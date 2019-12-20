#!/usr/bin/env bash

PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

IMAGE_TAG=${TRAVIS_COMMIT:0:7}
SERVICE_NAME="tpp-bank-search-api"
OPENSHIFT_IMAGE_NAME="$OPENSHIFT_REGISTRY/$OPENSHIFT_NAMESPACE/$SERVICE_NAME"

JAR_NAME=banking-protocol-$PROJECT_VERSION.jar

docker build -t $OPENSHIFT_IMAGE_NAME:"$IMAGE_TAG" --build-arg JAR_FILE="$JAR_NAME" ./core/banking-protocol
docker login -u github-image-pusher -p $OPENSHIFT_TOKEN $OPENSHIFT_REGISTRY
docker push $OPENSHIFT_IMAGE_NAME:"$IMAGE_TAG"

