Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD9233D2E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCPLXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 07:23:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43404 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhCPLXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:23:09 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lM7n0-0006XY-2K; Tue, 16 Mar 2021 11:23:06 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] cachefiles: do not yet allow on idmapped mounts
Date:   Tue, 16 Mar 2021 12:22:57 +0100
Message-Id: <20210316112257.2974212-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Based on discussion with David Howells my understanding of cachefiles
and the cachefiles userspace daemon is that it creates a cache on a
local filesystem (e.g. ext4, xfs etc.) for a network filesystem. The way
this is done is by writing "bind" to /dev/cachefiles and pointing it to
the directory to use as the cache.
So from our offline discussion I gather that cachefilesd creates a cache
on a local filesystem (ext4, xfs etc.) for a network filesystem. The way
this is done is by writing "bind" to /dev/cachefiles and pointing it to
a directory to use as the cache.
Currently this directory can technically also be an idmapped mount but
cachefiles aren't yet fully aware of such mounts and thus don't take the
idmapping into account. This could leave users confused as the ownership
of the files wouldn't match to what they expressed in the idmapping. So
let's not allow this for now and only make cachefiles aware of idmapped
mounts after it's current rewrite/rework is done.

Link: https://lore.kernel.org/lkml/20210303161528.n3jzg66ou2wa43qb@wittgenstein
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cachefiles/bind.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index dfb14dbddf51..bd7eab9a0539 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -115,6 +115,10 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	if (ret < 0)
 		goto error_open_root;
 
+	ret = -EINVAL;
+	if (mnt_user_ns(path.mnt) != &init_user_ns)
+		goto error_unsupported;
+
 	cache->mnt = path.mnt;
 	root = path.dentry;
 

base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.27.0

