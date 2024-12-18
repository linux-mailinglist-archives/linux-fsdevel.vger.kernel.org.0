Return-Path: <linux-fsdevel+bounces-37762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED399F6F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C26166E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847E1FCD0C;
	Wed, 18 Dec 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg1tbOH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B01922EE;
	Wed, 18 Dec 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556598; cv=none; b=ktuY+P+Gf4RoISJRXbZZL49DoDb9TPWlSPiIzLjP8bakFDQO6jUTboghtvmQ6a8WIw8Xedr+1jP7eFxG5kD8qard4tuUk/0rIFQXoxQ/TciIoIf29+qzxtHRg4/5SWfjENQw0TDm+KgsZJImSANs6pk7W9pKfvoRVb6kckhfISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556598; c=relaxed/simple;
	bh=BzP8UTSDo5oitwO7ghy7d6m6Rl07PvzBU5guVa6Dy50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvryJ8Fbrsy8kAOoCA53chuaw5bg1P5T21a4UjwavvKO7Gk+Np5rvqy+r4EtVoFDj6dfn2zIGyU7bmqLAhnwbRCByPSzIwTcSmiov3yuIgvReUe27+Qiu5hbDVzFgUISq306oE3Iw4pPlz1goKI1zDo6Mh8jONF5P7v+QxQjS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg1tbOH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD1C4CECD;
	Wed, 18 Dec 2024 21:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734556598;
	bh=BzP8UTSDo5oitwO7ghy7d6m6Rl07PvzBU5guVa6Dy50=;
	h=From:To:Cc:Subject:Date:From;
	b=Bg1tbOH40ROGrk3Uq0Flni+/gJucA12nM0oTfZpiwTkmsbAMx0aJCrtjAv9apbXeg
	 4UkejTo19kGWVQitUrDAf/yoeNbPfyfcBjSkEGsPwY/ZPR9D7Fr6R8hFChxd8a2g79
	 8AzPEUATSPYM5V8ZdJU32vr1171JPfSLJuDiMNQzb03zdNy2M3TLyAUbBU5V3PWPgU
	 R9IzYDmu1bTbMObM/ry4KF3l3o9UPS96laRC2dNELzIW4tRSlhVjNRECqEvFDZfTcx
	 yLB92nCZOVS+JoIwkMidnJjhVkBg5UMBzJqwYU8TagNkyLmvqc2UAlYNpABUvR+hGh
	 js5MBRA4yyodg==
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
	johannes.thumshirn@wdc.com,
	kernel-team@meta.com
Subject: [RFC v2] lsm: fs: Use inode_free_callback to free i_security in RCU callback
Date: Wed, 18 Dec 2024 13:16:15 -0800
Message-ID: <20241218211615.506095-1-song@kernel.org>
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

Rename i_callback to inode_free_callback and call security_inode_free_rcu
from it to free i_security so that a rcu_head is saved for each inode.
Special care are needed for file systems that provide a destroy_inode()
callback, but not a free_inode() callback. Specifically, the following
logic are added to handle such cases:

 - XFS recycles inode after destroy_inode. The inodes are freed from
   recycle logic. Let xfs_inode_free_callback() call inode_free_callback.
 - Let pipe free inode from a RCU callback.
 - Let btrfs-test free inode from a RCU callback.

Signed-off-by: Song Liu <song@kernel.org>

---

Changes v1 => v2:
1. Wrap security_inode_free_rcu inside inode_free_callback so that
   the interface is cleaner.

RFC v1: https://lore.kernel.org/linux-fsdevel/20241216234308.1326841-1-song@kernel.org/
---
 Documentation/filesystems/vfs.rst |  5 +++-
 fs/btrfs/fs.h                     |  1 +
 fs/btrfs/inode.c                  |  4 +++
 fs/btrfs/tests/btrfs-tests.c      |  1 +
 fs/inode.c                        | 20 +++++++++----
 fs/pipe.c                         |  1 -
 fs/xfs/xfs_icache.c               |  1 +
 include/linux/fs.h                |  2 ++
 include/linux/security.h          |  4 +++
 security/security.c               | 48 +++++++++++++++++++------------
 10 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0b18af3f954e..93d6f59fd2c0 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -306,7 +306,10 @@ or bottom half).
 ``free_inode``
 	this method is called from RCU callback. If you use call_rcu()
 	in ->destroy_inode to free 'struct inode' memory, then it's
-	better to release memory in this method.
+	better to release memory in this method. Some filesystems may
+	decide not to provide a free_inode() method, but to free the
+	inode through a different code path. In this case, the filesystem
+	should call inode_free_callback() before freeing the inode.
 
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
index 6b4c77268fc0..e5dbf59e7297 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -318,13 +318,13 @@ void free_inode_nonrcu(struct inode *inode)
 }
 EXPORT_SYMBOL(free_inode_nonrcu);
 
-static void i_callback(struct rcu_head *head)
+void inode_free_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	security_inode_free_rcu(inode);
 	if (inode->free_inode)
 		inode->free_inode(inode);
-	else
-		free_inode_nonrcu(inode);
 }
 
 static struct inode *alloc_inode(struct super_block *sb)
@@ -346,8 +346,11 @@ static struct inode *alloc_inode(struct super_block *sb)
 			if (!ops->free_inode)
 				return NULL;
 		}
-		inode->free_inode = ops->free_inode;
-		i_callback(&inode->i_rcu);
+		if (ops->free_inode)
+			inode->free_inode = ops->free_inode;
+		else
+			inode->free_inode = free_inode_nonrcu;
+		inode_free_callback(&inode->i_rcu);
 		return NULL;
 	}
 
@@ -387,8 +390,13 @@ static void destroy_inode(struct inode *inode)
 		if (!ops->free_inode)
 			return;
 	}
+	if (ops->free_inode)
+		inode->free_inode = ops->free_inode;
+	else
+		inode->free_inode = free_inode_nonrcu;
+
 	inode->free_inode = ops->free_inode;
-	call_rcu(&inode->i_rcu, i_callback);
+	call_rcu(&inode->i_rcu, inode_free_callback);
 }
 
 /**
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
index 7b6c026d01a1..7c72a6199f15 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -162,6 +162,7 @@ xfs_inode_free_callback(
 		ip->i_itemp = NULL;
 	}
 
+	inode_free_callback(&inode->i_rcu);
 	kmem_cache_free(xfs_inode_cache, ip);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..dab8f1cd1b72 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3810,4 +3810,6 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
+void inode_free_callback(struct rcu_head *head);
+
 #endif /* _LINUX_FS_H */
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
index 7523d14f31fb..b9a515d881f6 100644
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
@@ -747,10 +741,15 @@ static int lsm_file_alloc(struct file *file)
  */
 static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
 {
-	if (!lsm_inode_cache) {
-		inode->i_security = NULL;
+	/*
+	 * If the filesystem recycles inode, i_security may be already
+	 * allocated. Just return in this case.
+	 */
+	if (inode->i_security)
+		return 0;
+
+	if (!lsm_inode_cache)
 		return 0;
-	}
 
 	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
 	if (inode->i_security == NULL)
@@ -1693,18 +1692,13 @@ int security_inode_alloc(struct inode *inode, gfp_t gfp)
 	if (unlikely(rc))
 		return rc;
 	rc = call_int_hook(inode_alloc_security, inode);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_inode_free(inode);
+		security_inode_free_rcu(inode);
+	}
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
@@ -1724,9 +1718,25 @@ static void inode_free_by_rcu(struct rcu_head *head)
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


