Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30C3473F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhCXIv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 04:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233672AbhCXIvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616575881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W/86U4WY3HJ5VvQ3jx54R3hafA8M0dgjXIl/x1KumV4=;
        b=E6eyTdtIowk+xTy/H1CMrF5Qd4copt36H68g6boCpH/HJyDd2fFy+WYHiMCRhHlMeNjVjR
        ZAP2dwoizkYAXsg7HUqBmJ4kQSR89Q5uWp4UDgpExaNbaVbzjP3LjJ2N2ZfiyP04G4mJmJ
        R0WiOHU/lwaIoQJ6jtGOEn8220SkRqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-kGoMiK29PsCHzWkzHMHlzQ-1; Wed, 24 Mar 2021 04:51:17 -0400
X-MC-Unique: kGoMiK29PsCHzWkzHMHlzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 451F2801FCE;
        Wed, 24 Mar 2021 08:51:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00A25D9DE;
        Wed, 24 Mar 2021 08:51:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: do not yet allow on idmapped mounts
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 08:51:10 +0000
Message-ID: <161657587086.2876766.8721792351947204187.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Based on discussions (e.g. in [1]) my understanding of cachefiles and
the cachefiles userspace daemon is that it creates a cache on a local
filesystem (e.g. ext4, xfs etc.) for a network filesystem. The way this
is done is by writing "bind" to /dev/cachefiles and pointing it to the
directory to use as the cache.
Currently this directory can technically also be an idmapped mount but
cachefiles aren't yet fully aware of such mounts and thus don't take the
idmapping into account when creating cache entries. This could leave
users confused as the ownership of the files wouldn't match to what they
expressed in the idmapping. Block cache files on idmapped mounts until
the fscache rework is done and we have ported it to support idmapped
mounts.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/lkml/20210303161528.n3jzg66ou2wa43qb@wittgenstein [1]
Link: https://lore.kernel.org/r/20210316112257.2974212-1-christian.brauner@ubuntu.com/ # v1
Link: https://listman.redhat.com/archives/linux-cachefs/2021-March/msg00044.html # v2
Link: https://lore.kernel.org/r/20210319114146.410329-1-christian.brauner@ubuntu.com/ # v3
---

 fs/cachefiles/bind.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index dfb14dbddf51..38bb7764b454 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -118,6 +118,12 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	cache->mnt = path.mnt;
 	root = path.dentry;
 
+	ret = -EINVAL;
+	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+		pr_warn("File cache on idmapped mounts not supported");
+		goto error_unsupported;
+	}
+
 	/* check parameters */
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||


