Return-Path: <linux-fsdevel+bounces-37568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BC9F3E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 00:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980BA1636FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7F1DACAF;
	Mon, 16 Dec 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjBUqQHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1B1D63C6;
	Mon, 16 Dec 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392618; cv=none; b=BwoYfwsU8H8ynW3AgVA1e1XkWygW/HFqLbbbX+2G88yYW9CaFDpo6M8WS0J7ZSw1Jyn8y37oU1m07txDo6YT89wTwEQDbp2csescDMzrHb32/tRaFM0AHknYPxFXOw1DMLA5Ssl+lO9HxAho8Luizy6BlRSjfI4Tj5AfhIpSPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392618; c=relaxed/simple;
	bh=fIVp+sEQjZ4XZZvtVIOOtRBaJxmavMvZF40g2aZx2jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UavmaDM/jLOom0qYhHc8vajrXyFmpowGdGnFuljy5eJyCuakhntFcP6VUJGZVsEmswEx0uqb4urG9p7Ctj8K8r7iaTofubf/VqS2J7YaXc6PZQYoVDvjExGroWZFGAEKsoq/0EJisNGpcp516qKmdh668ZnZWv0cmhPh9DPTwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjBUqQHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5ADC4CED0;
	Mon, 16 Dec 2024 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734392617;
	bh=fIVp+sEQjZ4XZZvtVIOOtRBaJxmavMvZF40g2aZx2jw=;
	h=From:To:Cc:Subject:Date:From;
	b=IjBUqQHmKfShTYr8EyoM6JIINBGKBmfAaLXRGifWuTmnoBadqBBcZUV26rz+k4End
	 jbX5m//+FJqoi0xUlGsHoZ3d5CZpFoEfNu2/flclwfAQuluZ3oUMmg1+y0kbSXwU7f
	 rReU9LoOsxX6YsiQxOJF/WdFENJKMcP5Iad6XVL9db9HlpehiIzfREc8nhyvnABHTZ
	 O0jouKBl//6/k5+yCCMWIXGMFH+tOIt4phaff9UHh9xAYXVZN8vJ7essFzbGCsIzn8
	 bDxMXXw61PGjp+xorctrUm8zPrYwxkFExEIKZBYwxr6h7as8sVUGIVX2CUxZOY7p7q
	 t/8wALQmBqndA==
From: Song Liu <song@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: willy@infradead.org,
	corbet@lwn.net,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	brauner@kernel.org,
	jack@suse.cz,
	cem@kernel.org,
	djwong@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	fdmanana@suse.com,
	song@kernel.org,
	johannes.thumshirn@wdc.com
Subject: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
Date: Mon, 16 Dec 2024 15:43:08 -0800
Message-ID: <20241216234308.1326841-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode->i_security needes to be freed from RCU callback. A rcu_head was
added to i_security to call the RCU callback. However, since struct inode
already has i_rcu, the extra rcu_head is wasteful. Specifically, when any
LSM uses i_security, a rcu_head (two pointers) is allocated for each
inode.

Add security_inode_free_rcu() to i_callback to free i_security so that
a rcu_head is saved for each inode. Special care are needed for file
systems that provide a destroy_inode() callback, but not a free_inode()
callback. Specifically, the following logic are added to handle such
cases:

 - XFS recycles inode after destroy_inode. The inodes are freed from
   recycle logic. Let xfs_inode_free_callback() and xfs_inode_alloc()
   call security_inode_free_rcu() before freeing the inode.
 - Let pipe free inode from a RCU callback.
 - Let btrfs-test free inode from a RCU callback.

Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/filesystems/vfs.rst |  8 ++++-
 fs/btrfs/fs.h                     |  1 +
 fs/btrfs/inode.c                  |  4 +++
 fs/btrfs/tests/btrfs-tests.c      |  1 +
 fs/inode.c                        |  2 ++
 fs/pipe.c                         |  1 -
 fs/xfs/xfs_icache.c               |  3 ++
 include/linux/security.h          |  4 +++
 security/security.c               | 49 +++++++++++++++++++------------
 9 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0b18af3f954e..af62cdd0bb7a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -306,7 +306,13 @@ or bottom half).
 ``free_inode``
 	this method is called from RCU callback. If you use call_rcu()
 	in ->destroy_inode to free 'struct inode' memory, then it's
-	better to release memory in this method.
+	better to release memory in this method. LSMs leverage the
+	vfs RCU callback (i_callback) to free inode->i_security after a
+	RCU grace period. If the filesystem provides a destroy_inode()
+	callback but not a free_inode() callback, it is responsible to
+	call security_inode_free_rcu() in the filesystem's RCU callback.
+	For example, xfs calls security_inode_free_rcu() from
+	xfs_inode_free_callback().
 
 ``dirty_inode``
 	this method is called by the VFS when an inode is marked dirty.
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..f606ea2a14ab 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1068,6 +1068,7 @@ static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
 }
 
 void btrfs_test_destroy_inode(struct inode *inode);
+void btrfs_test_free_inode(struct inode *inode);
 
 #else
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03fe0de2cd0d..62ee8394cf6c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7707,6 +7707,10 @@ void btrfs_test_destroy_inode(struct inode *inode)
 {
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 	kfree(BTRFS_I(inode)->file_extent_tree);
+}
+
+void btrfs_test_free_inode(struct inode *inode)
+{
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 #endif
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index e607b5d52fb1..581b518b99b7 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -35,6 +35,7 @@ const char *test_error[] = {
 static const struct super_operations btrfs_test_super_ops = {
 	.alloc_inode	= btrfs_alloc_inode,
 	.destroy_inode	= btrfs_test_destroy_inode,
+	.free_inode	= btrfs_test_free_inode,
 };
 
 
diff --git a/fs/inode.c b/fs/inode.c
index 6b4c77268fc0..4b1eac736730 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -321,6 +321,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
 static void i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	security_inode_free_rcu(inode);
 	if (inode->free_inode)
 		inode->free_inode(inode);
 	else
diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..eb9c75ef5d80 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1422,7 +1422,6 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 }
 
 static const struct super_operations pipefs_ops = {
-	.destroy_inode = free_inode_nonrcu,
 	.statfs = simple_statfs,
 };
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 7b6c026d01a1..a85a661ad78f 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -30,6 +30,7 @@
 #include "xfs_metafile.h"
 
 #include <linux/iversion.h>
+#include <linux/security.h>
 
 /* Radix tree tags for incore inode tree. */
 
@@ -97,6 +98,7 @@ xfs_inode_alloc(
 	ip = alloc_inode_sb(mp->m_super, xfs_inode_cache, GFP_KERNEL | __GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
+		security_inode_free_rcu(VFS_I(ip));
 		kmem_cache_free(xfs_inode_cache, ip);
 		return NULL;
 	}
@@ -162,6 +164,7 @@ xfs_inode_free_callback(
 		ip->i_itemp = NULL;
 	}
 
+	security_inode_free_rcu(inode);
 	kmem_cache_free(xfs_inode_cache, ip);
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cad..4983d6a3ccb3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -400,6 +400,7 @@ int security_path_notify(const struct path *path, u64 mask,
 					unsigned int obj_type);
 int security_inode_alloc(struct inode *inode, gfp_t gfp);
 void security_inode_free(struct inode *inode);
+void security_inode_free_rcu(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
@@ -860,6 +861,9 @@ static inline int security_inode_alloc(struct inode *inode, gfp_t gfp)
 static inline void security_inode_free(struct inode *inode)
 { }
 
+static inline void security_inode_free_rcu(struct inode *inode)
+{ }
+
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
diff --git a/security/security.c b/security/security.c
index 7523d14f31fb..0ca9a41b7aca 100644
--- a/security/security.c
+++ b/security/security.c
@@ -265,12 +265,6 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
@@ -1688,23 +1682,26 @@ int security_path_notify(const struct path *path, u64 mask,
  */
 int security_inode_alloc(struct inode *inode, gfp_t gfp)
 {
-	int rc = lsm_inode_alloc(inode, gfp);
+	int rc;
 
-	if (unlikely(rc))
-		return rc;
+	/*
+	 * If the file system recycles inode, i_security may be already
+	 * allocated. In this case, we need to call inode_alloc_security
+	 * hooks again, so that the LSMs can reinitialize the inode blob
+	 * properly.
+	 */
+	if (!inode->i_security) {
+		rc = lsm_inode_alloc(inode, gfp);
+
+		if (unlikely(rc))
+			return rc;
+	}
 	rc = call_int_hook(inode_alloc_security, inode);
 	if (unlikely(rc))
 		security_inode_free(inode);
 	return rc;
 }
 
-static void inode_free_by_rcu(struct rcu_head *head)
-{
-	/* The rcu head is at the start of the inode blob */
-	call_void_hook(inode_free_security_rcu, head);
-	kmem_cache_free(lsm_inode_cache, head);
-}
-
 /**
  * security_inode_free() - Free an inode's LSM blob
  * @inode: the inode
@@ -1724,9 +1721,25 @@ static void inode_free_by_rcu(struct rcu_head *head)
 void security_inode_free(struct inode *inode)
 {
 	call_void_hook(inode_free_security, inode);
-	if (!inode->i_security)
+}
+
+/**
+ * security_inode_free_rcu() - Free an inode's LSM blob from i_callback
+ * @inode: the inode
+ *
+ * Release any LSM resources associated with @inode. This is called from
+ * i_callback after a RCU grace period. Therefore, it is safe to free
+ * everything now.
+ */
+void security_inode_free_rcu(struct inode *inode)
+{
+	void *inode_security = inode->i_security;
+
+	if (!inode_security)
 		return;
-	call_rcu((struct rcu_head *)inode->i_security, inode_free_by_rcu);
+	inode->i_security = NULL;
+	call_void_hook(inode_free_security_rcu, inode_security);
+	kmem_cache_free(lsm_inode_cache, inode_security);
 }
 
 /**
-- 
2.43.5


