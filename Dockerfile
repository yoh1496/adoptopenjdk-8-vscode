FROM ubuntu:20.04

RUN apt update && apt install -y wget apt-transport-https gnupg git

# https://adoptopenjdk.net/installation.html
RUN wget https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public && \
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --import public &&  \
    gpg --no-default-keyring --keyring ./adoptopenjdk-keyring.gpg --export --output adoptopenjdk-archive-keyring.gpg && \
    rm adoptopenjdk-keyring.gpg && \
    mv adoptopenjdk-archive-keyring.gpg /usr/share/keyrings && \
    echo "deb [signed-by=/usr/share/keyrings/adoptopenjdk-archive-keyring.gpg] https://adoptopenjdk.jfrog.io/adoptopenjdk/deb focal main" | tee /etc/apt/sources.list.d/adoptopenjdk.list && \
    apt update

# install jdk and maven
RUN apt install -y adoptopenjdk-11-hotspot adoptopenjdk-8-hotspot maven

ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64