Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB2F16AC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBXRBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 12:01:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:39212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgBXRBq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:01:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6186AD77;
        Mon, 24 Feb 2020 17:01:44 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] vfs: Rename __is_local_mountpoint to is_local_mountpoint
Date:   Mon, 24 Feb 2020 19:01:42 +0200
Message-Id: <20200224170142.5604-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current is_local_mountpoint is a simple wrapper with added d_mountpoint
check. However, the same check is the first thing which
__is_local_mountpoint performs. So remove the wrapper and promote the
private helper to is_local_mountpoint. No semantics changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/mount.h     | 9 +--------
 fs/namespace.c | 4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..bdbd2ad79209 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -140,14 +140,7 @@ struct proc_mounts {
 
 extern const struct seq_operations mounts_op;
 
-extern bool __is_local_mountpoint(struct dentry *dentry);
-static inline bool is_local_mountpoint(struct dentry *dentry)
-{
-	if (!d_mountpoint(dentry))
-		return false;
-
-	return __is_local_mountpoint(dentry);
-}
+extern bool is_local_mountpoint(struct dentry *dentry);
 
 static inline bool is_anon_ns(struct mnt_namespace *ns)
 {
diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..6d1f00849ac6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -649,7 +649,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
 }
 
 /*
- * __is_local_mountpoint - Test to see if dentry is a mountpoint in the
+ * is_local_mountpoint - Test to see if dentry is a mountpoint in the
  *                         current mount namespace.
  *
  * The common case is dentries are not mountpoints at all and that
@@ -663,7 +663,7 @@ struct vfsmount *lookup_mnt(const struct path *path)
  * namespace not just a mount that happens to have some specified
  * parent mount.
  */
-bool __is_local_mountpoint(struct dentry *dentry)
+bool is_local_mountpoint(struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt;
-- 
2.17.1

