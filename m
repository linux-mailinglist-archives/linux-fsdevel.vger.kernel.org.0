Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3263341BAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCSLmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 07:42:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42420 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCSLmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:42:02 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNDVx-0006Mu-0N; Fri, 19 Mar 2021 11:42:01 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3] cachefiles: do not yet allow on idmapped mounts
Date:   Fri, 19 Mar 2021 12:41:47 +0100
Message-Id: <20210319114146.410329-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

[1]: https://lore.kernel.org/lkml/20210303161528.n3jzg66ou2wa43qb@wittgenstein
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Ensure that "root" is initialized when cleaning up.

/* v3 */
- David Howells <dhowells@redhat.com>:
  - Reformulate commit message to avoid paragraphs with duplicated
    content.
  - Add a pr_warn() when cachefiles are supposed to be created on
    idmapped mounts.
---
 fs/cachefiles/bind.c | 6 ++++++
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

base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.27.0

