Return-Path: <linux-fsdevel+bounces-14343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD387B0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EB71F29F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A65786B;
	Wed, 13 Mar 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKaWMnJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF14CE13;
	Wed, 13 Mar 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352683; cv=none; b=k7e3xuzEh40ixrEh32/TPKvdb7nn3WpjV73CLmiDf3ay+9xa7NDLkyTHiMSojS/CWZbLQmm5K43S7G7yL6Bz8HJ7SvaGdeEsh036qsBDjA8Im9bDeigZBJwBtK9VMOScAtg5H+2wQO/nZaXR0mreG1APOSWZe+14Vuwe7Gb4AIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352683; c=relaxed/simple;
	bh=otBM5hpwR46eG0j/1XUqSqZWfYVJN3udcv1PxRmECuA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/0tlhiG9Jc5W7iFGJJfkyRQimKrn914A0Hsomb4eyPQVqtuC3GXa3dj8LTtIykS4xwkfEOjLtmkZJLY9Y5Z2bOiAc6RCH8LCheduxmaHDWVoDume0eIGy2Rpy0J8mvwmj1SXgsa6ASb3Efg7Ft60B1ZbLo732Cx/BinKdYEKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKaWMnJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE46C433F1;
	Wed, 13 Mar 2024 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352683;
	bh=otBM5hpwR46eG0j/1XUqSqZWfYVJN3udcv1PxRmECuA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NKaWMnJJKSTjmm/tROxEN7BRW9QAZH7gUgEpIJLMPduM84YgMi/hYT++PEUTYPE8e
	 hBkJL9eWZ0z5O/xMSXx9pW96XbabRWAtOSz2hRdGzGHix3HjHyPxYKcpF6KC5gE+ax
	 k+23C4S4hziuLB9WIx8Kyo3Dbcpbd84aKHvkTy7XF95oqGtY0BnRF551WaSOp9t6Ul
	 6NYLH1+mTEbUNMohqvwSd9DroZZeYaRmGFCcF3aBPq2x0C7JS0XUtotlc9sA6DjNsl
	 kpZ9xiZ5Tf1T9xSlzxN5Jf8PcHsEujpXwAe1V9uZZYC/Nhq3zTyUlF1ry8Q57lJDIU
	 mt/ZwxvfvRc/A==
Date: Wed, 13 Mar 2024 10:58:03 -0700
Subject: [PATCH 21/29] xfs: add fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223693.2613863.3986547716372413007.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended file attributes. The metadata consist of verity
descriptor and Merkle tree blocks.

The descriptor is stored under "vdesc" extended attribute. The
Merkle tree blocks are stored under binary indexes which are offsets
into the Merkle tree.

When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
flag is set meaning that the Merkle tree is being build. The
initialization ends with storing of verity descriptor and setting
inode on-disk flag (XFS_DIFLAG2_VERITY).

The verification on read is done in read path of iomap.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace caching implementation with an xarray, other cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile               |    1 
 fs/xfs/libxfs/xfs_attr.c      |   13 +
 fs/xfs/libxfs/xfs_da_format.h |   14 +
 fs/xfs/libxfs/xfs_ondisk.h    |    3 
 fs/xfs/xfs_icache.c           |    4 
 fs/xfs/xfs_inode.h            |    5 
 fs/xfs/xfs_super.c            |   12 +
 fs/xfs/xfs_trace.h            |   32 +++
 fs/xfs/xfs_verity.c           |  477 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h           |   20 ++
 10 files changed, 581 insertions(+)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index f8845e65cac7..8396a633b541 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -130,6 +130,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index f0b625d45aa4..a3aea521b0d2 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -27,6 +27,7 @@
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1524,6 +1525,18 @@ xfs_attr_namecheck(
 	if (flags & XFS_ATTR_PARENT)
 		return xfs_parent_namecheck(mp, name, length, flags);
 
+	if (flags & XFS_ATTR_VERITY) {
+		/* Merkle tree pages are stored under u64 indexes */
+		if (length == sizeof(struct xfs_fsverity_merkle_key))
+			return true;
+
+		/* Verity descriptor blocks are held in a named attribute. */
+		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
+			return true;
+
+		return false;
+	}
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 28d4ac6fa156..bb04fde4a800 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -914,4 +914,18 @@ struct xfs_parent_name_rec {
  */
 #define XFS_PARENT_DIRENT_NAME_MAX_SIZE		(MAXNAMELEN - 1)
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode. The
+ * name of the attributes are offsets into merkle tree.
+ */
+struct xfs_fsverity_merkle_key {
+	__be64 merkleoff;
+};
+
+/* ondisk xattr name used for the fsverity descriptor */
+#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index 81885a6a028e..64adc0a45644 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -194,6 +194,9 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
+
+	/* fs-verity descriptor xattr name */
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME), 6);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e64265bc0b33..fef77938c718 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -25,6 +25,7 @@
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
+#include "xfs_verity.h"
 
 #include <linux/iversion.h>
 
@@ -115,6 +116,7 @@ xfs_inode_alloc(
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
 	ip->i_prev_unlinked = 0;
+	xfs_verity_cache_init(ip);
 
 	return ip;
 }
@@ -126,6 +128,8 @@ xfs_inode_free_callback(
 	struct inode		*inode = container_of(head, struct inode, i_rcu);
 	struct xfs_inode	*ip = XFS_I(inode);
 
+	xfs_verity_cache_destroy(ip);
+
 	switch (VFS_I(ip)->i_mode & S_IFMT) {
 	case S_IFREG:
 	case S_IFDIR:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3ea3a6f26ceb..cb2e43e5cd43 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -92,6 +92,9 @@ typedef struct xfs_inode {
 	spinlock_t		i_ioend_lock;
 	struct work_struct	i_ioend_work;
 	struct list_head	i_ioend_list;
+#ifdef CONFIG_FS_VERITY
+	struct xarray		i_merkle_blocks;
+#endif
 } xfs_inode_t;
 
 static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
@@ -361,6 +364,8 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
  */
 #define XFS_IREMAPPING		(1U << 15)
 
+#define XFS_VERITY_CONSTRUCTION	(1U << 16) /* merkle tree construction */
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a09739beb8f3..1f96dff5731e 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -30,6 +30,7 @@
 #include "xfs_filestream.h"
 #include "xfs_quota.h"
 #include "xfs_sysfs.h"
+#include "xfs_verity.h"
 #include "xfs_ondisk.h"
 #include "xfs_rmap_item.h"
 #include "xfs_refcount_item.h"
@@ -666,6 +667,8 @@ xfs_fs_destroy_inode(
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
 	fsverity_cleanup_inode(inode);
+	if (IS_VERITY(inode))
+		xfs_verity_cache_drop(ip);
 	xfs_inode_mark_reclaimable(ip);
 }
 
@@ -1521,6 +1524,11 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	error = fsverity_set_ops(sb, &xfs_verity_ops);
+	if (error)
+		return error;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1730,6 +1738,10 @@ xfs_fs_fill_super(
 		goto out_filestream_unmount;
 	}
 
+	if (xfs_has_verity(mp))
+		xfs_alert(mp,
+	"EXPERIMENTAL fs-verity feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9d4ae05abfc8..23abec742c3b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4767,6 +4767,38 @@ DEFINE_XFBTREE_FREESP_EVENT(xfbtree_alloc_block);
 DEFINE_XFBTREE_FREESP_EVENT(xfbtree_free_block);
 #endif /* CONFIG_XFS_BTREE_IN_MEM */
 
+#ifdef CONFIG_FS_VERITY
+DECLARE_EVENT_CLASS(xfs_verity_cache_class,
+	TP_PROTO(struct xfs_inode *ip, unsigned long key, unsigned long caller_ip),
+	TP_ARGS(ip, key, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(unsigned long, key)
+		__field(void *, caller_ip)
+	),
+	TP_fast_assign(
+		__entry->dev = ip->i_mount->m_super->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->key = key;
+		__entry->caller_ip = (void *)caller_ip;
+	),
+	TP_printk("dev %d:%d ino 0x%llx key 0x%lx caller %pS",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->key,
+		  __entry->caller_ip)
+)
+
+#define DEFINE_XFS_VERITY_CACHE_EVENT(name) \
+DEFINE_EVENT(xfs_verity_cache_class, name, \
+	TP_PROTO(struct xfs_inode *ip, unsigned long key, unsigned long caller_ip), \
+	TP_ARGS(ip, key, caller_ip))
+DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_load);
+DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_store);
+DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_drop);
+#endif /* CONFIG_XFS_VERITY */
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
new file mode 100644
index 000000000000..9f3bcc9150d2
--- /dev/null
+++ b/fs/xfs/xfs_verity.c
@@ -0,0 +1,477 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Red Hat, Inc.
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_log_format.h"
+#include "xfs_attr.h"
+#include "xfs_verity.h"
+#include "xfs_bmap_util.h"
+#include "xfs_log_format.h"
+#include "xfs_trans.h"
+#include "xfs_attr_leaf.h"
+#include "xfs_trace.h"
+#include <linux/fsverity.h>
+
+/*
+ * Merkle Tree Block Cache
+ * =======================
+ *
+ * fsverity requires that the filesystem implement caching of ondisk merkle
+ * tree blocks.  XFS stores merkle tree blocks in the extended attribute data,
+ * which makes it important to keep copies in memory for as long as possible.
+ * This is performed by allocating the data blob structure defined below,
+ * passing the data portion of the blob to xfs_attr_get, and later adding the
+ * data blob to an xarray embedded in the xfs_inode structure.
+ *
+ * The xarray structure indexes merkle tree blocks by the offset given to us by
+ * fsverity, which drastically reduces lookups.  First, it eliminating the need
+ * to walk the xattr structure to find the remote block containing the merkle
+ * tree block.  Second, access to each block in the xattr structure requires a
+ * lookup in the incore extent btree.
+ */
+struct xfs_merkle_blob {
+	/* refcount of this item; the cache holds its own ref */
+	refcount_t		refcount;
+
+	/* blob data, must be last! */
+	unsigned char		data[];
+};
+
+/* Size of a merkle tree cache block */
+static inline size_t sizeof_xfs_merkle_blob(unsigned int blocksize)
+{
+	return struct_size_t(struct xfs_merkle_blob, data, blocksize);
+}
+
+/*
+ * Allocate a merkle tree blob object to prepare for reading a merkle tree
+ * object from disk.
+ */
+static inline struct xfs_merkle_blob *
+xfs_merkle_blob_alloc(
+	unsigned int		blocksize)
+{
+	struct xfs_merkle_blob	*mk;
+
+	mk = kvzalloc(sizeof_xfs_merkle_blob(blocksize), GFP_KERNEL);
+	if (!mk)
+		return NULL;
+
+	/* Caller owns this refcount. */
+	refcount_set(&mk->refcount, 1);
+	return mk;
+}
+
+/* Free a merkle tree blob. */
+static inline void
+xfs_merkle_blob_rele(
+	struct xfs_merkle_blob	*mk)
+{
+	if (refcount_dec_and_test(&mk->refcount))
+		kvfree(mk);
+}
+
+/* Initialize the merkle tree block cache */
+void
+xfs_verity_cache_init(
+	struct xfs_inode	*ip)
+{
+	xa_init(&ip->i_merkle_blocks);
+}
+
+/*
+ * Drop all the merkle tree blocks out of the cache.  Caller must ensure that
+ * there are no active references to cache items.
+ */
+void
+xfs_verity_cache_drop(
+	struct xfs_inode	*ip)
+{
+	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_merkle_blob	*mk;
+	unsigned long		flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_for_each(&xas, mk, ULONG_MAX) {
+		ASSERT(refcount_read(&mk->refcount) == 1);
+
+		trace_xfs_verity_cache_drop(ip, xas.xa_index, _RET_IP_);
+
+		xas_store(&xas, NULL);
+		xfs_merkle_blob_rele(mk);
+	}
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+/* Destroy the merkle tree block cache */
+void
+xfs_verity_cache_destroy(
+	struct xfs_inode	*ip)
+{
+	ASSERT(xa_empty(&ip->i_merkle_blocks));
+
+	/*
+	 * xa_destroy calls xas_lock from rcu freeing softirq context, so
+	 * we must use xa*_lock_irqsave.
+	 */
+	xa_destroy(&ip->i_merkle_blocks);
+}
+
+/* Return a cached merkle tree block, or NULL. */
+static struct xfs_merkle_blob *
+xfs_verity_cache_load(
+	struct xfs_inode	*ip,
+	unsigned long		key)
+{
+	XA_STATE(xas, &ip->i_merkle_blocks, key);
+	struct xfs_merkle_blob	*mk;
+
+	/* Look up the cached item and try to get an active ref. */
+	rcu_read_lock();
+	do {
+		mk = xas_load(&xas);
+		if (xa_is_zero(mk))
+			mk = NULL;
+	} while (xas_retry(&xas, mk) ||
+		 (mk && !refcount_inc_not_zero(&mk->refcount)));
+	rcu_read_unlock();
+
+	if (!mk)
+		return NULL;
+
+	trace_xfs_verity_cache_load(ip, key, _RET_IP_);
+	return mk;
+}
+
+/*
+ * Try to store a merkle tree block in the cache with the given key.
+ *
+ * If the merkle tree block is not already in the cache, the given block @mk
+ * will be added to the cache and returned.  The caller retains its active
+ * reference to @mk.
+ *
+ * If there was already a merkle block in the cache, it will be returned to
+ * the caller with an active reference.  @mk will be untouched.
+ */
+static struct xfs_merkle_blob *
+xfs_verity_cache_store(
+	struct xfs_inode	*ip,
+	unsigned long		key,
+	struct xfs_merkle_blob	*mk)
+{
+	struct xfs_merkle_blob	*old;
+	unsigned long		flags;
+
+	trace_xfs_verity_cache_store(ip, key, _RET_IP_);
+
+	/*
+	 * Either replace a NULL entry with mk, or take an active ref to
+	 * whatever's currently there.
+	 */
+	xa_lock_irqsave(&ip->i_merkle_blocks, flags);
+	do {
+		old = __xa_cmpxchg(&ip->i_merkle_blocks, key, NULL, mk,
+				GFP_KERNEL);
+	} while (old && !refcount_inc_not_zero(&old->refcount));
+	xa_unlock_irqrestore(&ip->i_merkle_blocks, flags);
+
+	if (old == NULL) {
+		/*
+		 * There was no previous value.  @mk is now live in the cache.
+		 * Bump the active refcount to transfer ownership to the cache
+		 * and return @mk to the caller.
+		 */
+		refcount_inc(&mk->refcount);
+		return mk;
+	}
+
+	/*
+	 * We obtained an active reference to a previous value in the cache.
+	 * Return it to the caller.
+	 */
+	return old;
+}
+
+static inline void
+xfs_fsverity_merkle_key_to_disk(
+	struct xfs_fsverity_merkle_key	*key,
+	u64				offset)
+{
+	key->merkleoff = cpu_to_be64(offset);
+}
+
+static inline u64
+xfs_fsverity_merkle_key_from_disk(
+	void				*attr_name)
+{
+	struct xfs_fsverity_merkle_key	*key = attr_name;
+
+	return be64_to_cpu(key->merkleoff);
+}
+
+static int
+xfs_verity_get_descriptor(
+	struct inode		*inode,
+	void			*buf,
+	size_t			buf_size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error = 0;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= buf,
+		.valuelen	= buf_size,
+	};
+
+	/*
+	 * The fact that (returned attribute size) == (provided buf_size) is
+	 * checked by xfs_attr_copy_value() (returns -ERANGE)
+	 */
+	error = xfs_attr_get(&args);
+	if (error)
+		return error;
+
+	return args.valuelen;
+}
+
+static int
+xfs_verity_begin_enable(
+	struct file		*filp,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error = 0;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+
+	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
+		return -EBUSY;
+
+	return error;
+}
+
+static int
+xfs_drop_merkle_tree(
+	struct xfs_inode		*ip,
+	u64				merkle_tree_size,
+	unsigned int			tree_blocksize)
+{
+	struct xfs_fsverity_merkle_key	name;
+	int				error = 0;
+	u64				offset = 0;
+	struct xfs_da_args		args = {
+		.dp			= ip,
+		.whichfork		= XFS_ATTR_FORK,
+		.attr_filter		= XFS_ATTR_VERITY,
+		.op_flags		= XFS_DA_OP_REMOVE,
+		.name			= (const uint8_t *)&name,
+		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		/* NULL value make xfs_attr_set remove the attr */
+		.value			= NULL,
+	};
+
+	if (!merkle_tree_size)
+		return 0;
+
+	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
+		xfs_fsverity_merkle_key_to_disk(&name, offset);
+		error = xfs_attr_set(&args);
+		if (error)
+			return error;
+	}
+
+	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
+	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
+	error = xfs_attr_set(&args);
+
+	return error;
+}
+
+static int
+xfs_verity_end_enable(
+	struct file		*filp,
+	const void		*desc,
+	size_t			desc_size,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= (void *)desc,
+		.valuelen	= desc_size,
+	};
+	int			error = 0;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	/* fs-verity failed, just cleanup */
+	if (desc == NULL)
+		goto out;
+
+	error = xfs_attr_set(&args);
+	if (error)
+		goto out;
+
+	/* Set fsverity inode flag */
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
+			0, 0, false, &tp);
+	if (error)
+		goto out;
+
+	/*
+	 * Ensure that we've persisted the verity information before we enable
+	 * it on the inode and tell the caller we have sealed the inode.
+	 */
+	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (!error)
+		inode->i_flags |= S_VERITY;
+
+out:
+	if (error)
+		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
+						  tree_blocksize));
+
+	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
+	return error;
+}
+
+static int
+xfs_verity_read_merkle(
+	const struct fsverity_readmerkle *req,
+	struct fsverity_blockbuf	*block)
+{
+	struct xfs_inode		*ip = XFS_I(req->inode);
+	struct xfs_fsverity_merkle_key	name;
+	struct xfs_da_args		args = {
+		.dp			= ip,
+		.attr_filter		= XFS_ATTR_VERITY,
+		.name			= (const uint8_t *)&name,
+		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		.valuelen		= block->size,
+	};
+	struct xfs_merkle_blob		*mk, *new_mk;
+	unsigned long			key = block->offset >> req->log_blocksize;
+	int				error;
+
+	ASSERT(block->offset >> req->log_blocksize <= ULONG_MAX);
+
+	xfs_fsverity_merkle_key_to_disk(&name, block->offset);
+
+	/* Is the block already cached? */
+	mk = xfs_verity_cache_load(ip, key);
+	if (mk)
+		goto out_hit;
+
+	new_mk = xfs_merkle_blob_alloc(block->size);
+	if (!new_mk)
+		return -ENOMEM;
+	args.value = new_mk->data;
+
+	/* Read the block in from disk and try to store it in the cache. */
+	xfs_fsverity_merkle_key_to_disk(&name, block->offset);
+
+	error = xfs_attr_get(&args);
+	if (error)
+		goto out_new_mk;
+
+	if (!args.valuelen) {
+		error = -ENODATA;
+		goto out_new_mk;
+	}
+
+	mk = xfs_verity_cache_store(ip, key, new_mk);
+	if (mk != new_mk) {
+		/*
+		 * We raced with another thread to populate the cache and lost.
+		 * Free the new cache blob and continue with the existing one.
+		 */
+		xfs_merkle_blob_rele(new_mk);
+	}
+
+	/* We might have loaded this in from disk, fsverity must recheck */
+	fsverity_invalidate_block(req->inode, block);
+
+out_hit:
+	block->kaddr   = (void *)mk->data;
+	block->context = mk;
+	return 0;
+
+out_new_mk:
+	xfs_merkle_blob_rele(new_mk);
+	return error;
+}
+
+static int
+xfs_verity_write_merkle(
+	struct inode		*inode,
+	const void		*buf,
+	u64			pos,
+	unsigned int		size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_fsverity_merkle_key	name;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
+		.value		= (void *)buf,
+		.valuelen	= size,
+	};
+
+	xfs_fsverity_merkle_key_to_disk(&name, pos);
+	args.name = (const uint8_t *)&name.merkleoff;
+
+	return xfs_attr_set(&args);
+}
+
+static void
+xfs_verity_drop_merkle(
+	struct fsverity_blockbuf	*block)
+{
+	struct xfs_merkle_blob		*mk = block->context;
+
+	xfs_merkle_blob_rele(mk);
+	block->kaddr = NULL;
+	block->context = NULL;
+}
+
+const struct fsverity_operations xfs_verity_ops = {
+	.begin_enable_verity		= xfs_verity_begin_enable,
+	.end_enable_verity		= xfs_verity_end_enable,
+	.get_verity_descriptor		= xfs_verity_get_descriptor,
+	.read_merkle_tree_block		= xfs_verity_read_merkle,
+	.write_merkle_tree_block	= xfs_verity_write_merkle,
+	.drop_merkle_tree_block		= xfs_verity_drop_merkle,
+};
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
new file mode 100644
index 000000000000..31d51482f7f7
--- /dev/null
+++ b/fs/xfs/xfs_verity.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+#ifdef CONFIG_FS_VERITY
+void xfs_verity_cache_init(struct xfs_inode *ip);
+void xfs_verity_cache_drop(struct xfs_inode *ip);
+void xfs_verity_cache_destroy(struct xfs_inode *ip);
+
+extern const struct fsverity_operations xfs_verity_ops;
+#else
+# define xfs_verity_cache_init(ip)		((void)0)
+# define xfs_verity_cache_drop(ip)		((void)0)
+# define xfs_verity_cache_destroy(ip)		((void)0)
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_VERITY_H__ */


