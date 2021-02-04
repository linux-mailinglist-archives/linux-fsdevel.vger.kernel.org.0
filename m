Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC52330FA2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbhBDRtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238756AbhBDRtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612460859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WoCQGzrOsnk55IaG+1UEwkLjcE8h9OKWofQDyL0qDdM=;
        b=WNcds/5J8A2CRnfAbZp51mb8VPvU3obyD1e+aAqeo/+WtUI4wFYirG3PAXank6pPoyOyr2
        HLnpqn0HhRXDjaw5JtdZHWUY3x4bupPuUAl5JtnUoYBY/yI2ysbrKyvpdC8c/Fl8Ru4LTb
        pisRBeROEcV5IxCnqt1bSq+WZ4yE5po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-lEo22RTJPJKzB2hJMUlSNw-1; Thu, 04 Feb 2021 12:47:36 -0500
X-MC-Unique: lEo22RTJPJKzB2hJMUlSNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5A8107ACE3;
        Thu,  4 Feb 2021 17:47:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81C4062679;
        Thu,  4 Feb 2021 17:47:32 +0000 (UTC)
Subject: [RFC][PATCH 0/2] keys: request_key() interception in containers
From:   David Howells <dhowells@redhat.com>
To:     sprabhu@redhat.com
Cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        christian@brauner.io, selinux@vger.kernel.org,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 04 Feb 2021 17:47:31 +0000
Message-ID: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a rough draft of a facility by which keys can be intercepted.

There are two patches:

 (1) Add tags to namespaces that can be used to find out, when we're
     looking for an intercept, if a namespace that an intercept is
     filtering on is the same as namespace of the caller of request_key()
     without the need for the intercept record to pin the namespaces that
     it's using as filters (which would also cause a dependency cycle).

     Tags contain only a refcount and are compared by address.

 (2) Add a new keyctl:

            keyctl(KEYCTL_SERVICE_INTERCEPT,
                   int queue_keyring, int userns_fd,
                   const char *type_name, unsigned int ns_mask);

     that allows a request_key() intercept to be added to the specified
     user namespace.  The authorisation key for an intercepted request is
     placed in the queue_keyring, which can be watched to gain a
     notification of this happening.  The watcher can then examine the auth
     key to determine what key is to be instantiated.

     A simple sample is provided that can be used to try this.

Some things that need to be worked out:

 (*) Intercepts are linked to the lifetime of the user_namespace on which
     they're placed, but not the daemon or the queue keyring.  Probably
     they should be removed when the queue keyring is removed, but they
     currently pin it.

 (*) Setting userns_fd to other than -1 is not yet supported (-1 indicates
     the current user namespace).

 (*) Multiple threads can monitor a queue keyring, but they will all get
     woken.  They can use keyctl_move() to decide who gets to process it.


The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-intercept

David
---
David Howells (2):
      Add namespace tags that can be used for matching without pinning a ns
      keys: Allow request_key upcalls from a container to be intercepted


 include/linux/key-type.h                |   4 +-
 include/linux/user_namespace.h          |   2 +
 include/uapi/linux/keyctl.h             |  13 +
 kernel/user.c                           |   3 +
 kernel/user_namespace.c                 |   2 +
 samples/watch_queue/Makefile            |   2 +
 samples/watch_queue/key_req_intercept.c | 271 +++++++++++++++++++
 security/keys/Makefile                  |   2 +
 security/keys/compat.c                  |   3 +
 security/keys/internal.h                |   5 +
 security/keys/keyctl.c                  |   6 +
 security/keys/keyring.c                 |   1 +
 security/keys/process_keys.c            |   2 +-
 security/keys/request_key.c             |  16 +-
 security/keys/request_key_auth.c        |   3 +
 security/keys/service.c                 | 337 ++++++++++++++++++++++++
 16 files changed, 663 insertions(+), 9 deletions(-)
 create mode 100644 samples/watch_queue/key_req_intercept.c
 create mode 100644 security/keys/service.c


