Return-Path: <linux-fsdevel+bounces-15728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A942E892856
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204C21F2172D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97501C0DE3;
	Sat, 30 Mar 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSL16c+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0481FA2;
	Sat, 30 Mar 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759168; cv=none; b=EvxVz0qW1tYUANsq7OzZj5m+onNkZuOi0W3tOyv8Gyyfj7BU7WymboODswqir55M9B2hOjz0qkmUbEUMPo1BMXJLX8nP9F/0p1Bi+Wr487mFjr6ttMreDXzfYkyPrzsjoHdMlwc4RwJLkgxZzoimtv/VISwjrsWZ4ei6oD93n+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759168; c=relaxed/simple;
	bh=0z4ZYu86DpTZ8kWeMVAJJBxYxGVAJH+LVsYX5SugWUg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjEEM3TGBrnfJoKmD6im4XoxMXNtfNqNhQ6C7e9OYgcqnnR4/6iMQpvvjsfAOIwczs+wlgbp0Yw2I5BHFQNBuytiUpMQ5ZnlDooeBhTwfVNkklZOORRv51Og8eQpbGyhTkLj4p0kJRRfgmt7n+BjyrsXTXq+SzRpw8XzCiEaO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSL16c+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD625C433F1;
	Sat, 30 Mar 2024 00:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759167;
	bh=0z4ZYu86DpTZ8kWeMVAJJBxYxGVAJH+LVsYX5SugWUg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lSL16c+cL/eJZ7wpUKlZj8ZMvKNS3F6bya2qKs6k5vRJVlq0zny6HOVVaVi6EttPJ
	 T2hCN5AZSrHNADvCDamHZWNN6ZS4mAQHPDAZspbf5eZDcdUabFnC6qfjiD4xnYW36V
	 KG/ix+hoCnFebGPGAtdmOXfIkgz0g48ATUO6wI9dg62WPmUCv+WK6GpIICxajMIaBW
	 BEPkcWrTadLiKFgV9ASKXILf19qtw91pY5WpGbeTd/Q7WVjPklC+g4rH4ma22QBrEg
	 coDGg3wl1quxgd7DLEno/qsaarLYtm0AD+RxxHvFcMjJVk/BDgQ68hToyNF9O2IdiH
	 UhU0MC3uSLS3w==
Date: Fri, 29 Mar 2024 17:39:27 -0700
Subject: [PATCH 13/29] xfs: add fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868775.1988170.1235485201931301190.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
 fs/xfs/Makefile               |    2 
 fs/xfs/libxfs/xfs_attr.c      |   41 +++
 fs/xfs/libxfs/xfs_attr.h      |    1 
 fs/xfs/libxfs/xfs_da_format.h |   14 +
 fs/xfs/libxfs/xfs_ondisk.h    |    3 
 fs/xfs/libxfs/xfs_verity.c    |   58 ++++
 fs/xfs/libxfs/xfs_verity.h    |   13 +
 fs/xfs/xfs_fsverity.c         |  559 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h         |   20 +
 fs/xfs/xfs_icache.c           |    4 
 fs/xfs/xfs_inode.h            |    5 
 fs/xfs/xfs_super.c            |   17 +
 fs/xfs/xfs_trace.h            |   32 ++
 13 files changed, 769 insertions(+)
 create mode 100644 fs/xfs/libxfs/xfs_verity.c
 create mode 100644 fs/xfs/libxfs/xfs_verity.h
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 702f2ddc918a1..a4b2f54914a87 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -57,6 +57,7 @@ xfs-y				+= $(addprefix libxfs/, \
 				   xfs_trans_resv.o \
 				   xfs_trans_space.o \
 				   xfs_types.o \
+				   xfs_verity.o \
 				   )
 # xfs_rtbitmap is shared with libxfs
 xfs-$(CONFIG_XFS_RT)		+= $(addprefix libxfs/, \
@@ -142,6 +143,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_fsverity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 931ec563a7460..c3f686411e378 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -27,6 +27,7 @@
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1262,6 +1263,43 @@ xfs_attr_removename(
 	goto out_unlock;
 }
 
+/*
+ * Retrieve the value stored in the xattr structure under @args->name.
+ *
+ * The caller must have initialized @args and must not hold any ILOCKs.
+ *
+ * Returns -ENOATTR if the name did not already exist.
+ */
+int
+xfs_attr_getname(
+	struct xfs_da_args	*args)
+{
+	unsigned int		lock_mode;
+	int			error;
+
+	ASSERT(!args->trans);
+
+	error = xfs_trans_alloc_empty(args->dp->i_mount, &args->trans);
+	if (error)
+		return error;
+
+	lock_mode = xfs_ilock_attr_map_shared(args->dp);
+
+	/* Make sure the attr fork iext tree is loaded */
+	if (xfs_inode_hasattr(args->dp)) {
+		error = xfs_iread_extents(args->trans, args->dp, XFS_ATTR_FORK);
+		if (error)
+			goto out_unlock;
+	}
+
+	error = xfs_attr_get_ilocked(args);
+out_unlock:
+	xfs_iunlock(args->dp, lock_mode);
+	xfs_trans_cancel(args->trans);
+	args->trans = NULL;
+	return error;
+}
+
 /*========================================================================
  * External routines when attribute list is inside the inode
  *========================================================================*/
@@ -1743,6 +1781,9 @@ xfs_attr_namecheck(
 	if (!xfs_attr_check_namespace(attr_flags))
 		return false;
 
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xfs_verity_namecheck(attr_flags, name, length);
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
index 958bb9e41ddb3..3e43d715bcdd2 100644
--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -561,6 +561,7 @@ void xfs_init_attr_trans(struct xfs_da_args *args, struct xfs_trans_res *tres,
 
 int xfs_attr_setname(struct xfs_da_args *args, bool rsvd);
 int xfs_attr_removename(struct xfs_da_args *args, bool rsvd);
+int xfs_attr_getname(struct xfs_da_args *args);
 
 /*
  * Check to see if the attr should be upgraded from non-existent or shortform to
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 8cbda181c2f48..679cf5b4ad4be 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -922,4 +922,18 @@ struct xfs_parent_rec {
 	__be32	p_gen;
 } __packed;
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode. The
+ * name of the attributes are byte offsets into merkle tree.
+ */
+struct xfs_merkle_key {
+	__be64	mk_offset;
+};
+
+/* ondisk xattr name used for the fsverity descriptor */
+#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index d46352d60d645..e927bb778ffdc 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -208,6 +208,9 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
 
+	/* fs-verity xattrs */
+	XFS_CHECK_STRUCT_SIZE(struct xfs_merkle_key,		8);
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME),	6);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/libxfs/xfs_verity.c b/fs/xfs/libxfs/xfs_verity.c
new file mode 100644
index 0000000000000..bda38b3c19698
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_verity.c
@@ -0,0 +1,58 @@
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
+
+/* Set a merkle tree offset in preparation for setting merkle tree attrs. */
+void
+xfs_merkle_key_to_disk(
+	struct xfs_merkle_key	*key,
+	uint64_t		offset)
+{
+	key->mk_offset = cpu_to_be64(offset);
+}
+
+/* Retrieve the merkle tree offset from the attr data. */
+uint64_t
+xfs_merkle_key_from_disk(
+	const void		*attr_name,
+	int			namelen)
+{
+	const struct xfs_merkle_key *key = attr_name;
+
+	ASSERT(namelen == sizeof(struct xfs_merkle_key));
+
+	return be64_to_cpu(key->mk_offset);
+}
+
+/* Return true if verity attr name is valid. */
+bool
+xfs_verity_namecheck(
+	unsigned int		attr_flags,
+	const void		*name,
+	int			namelen)
+{
+	if (!(attr_flags & XFS_ATTR_VERITY))
+		return false;
+
+	/*
+	 * Merkle tree pages are stored under u64 indexes; verity descriptor
+	 * blocks are held in a named attribute.
+	 */
+	if (namelen != sizeof(struct xfs_merkle_key) &&
+	    namelen != XFS_VERITY_DESCRIPTOR_NAME_LEN)
+		return false;
+
+	return true;
+}
diff --git a/fs/xfs/libxfs/xfs_verity.h b/fs/xfs/libxfs/xfs_verity.h
new file mode 100644
index 0000000000000..c01cc0678bc04
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_verity.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+void xfs_merkle_key_to_disk(struct xfs_merkle_key *key, uint64_t offset);
+uint64_t xfs_merkle_key_from_disk(const void *attr_name, int namelen);
+bool xfs_verity_namecheck(unsigned int attr_flags, const void *name,
+		int namelen);
+
+#endif	/* __XFS_VERITY_H__ */
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
new file mode 100644
index 0000000000000..a4a52575fb3d5
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.c
@@ -0,0 +1,559 @@
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
+#include "xfs_quota.h"
+#include "xfs_fsverity.h"
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
+	unsigned long		flags;
+
+	/* Pointer to the merkle tree block, which is power-of-2 sized */
+	void			*data;
+};
+
+#define XFS_MERKLE_BLOB_VERIFIED_BIT	(0) /* fsverity validated this */
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
+	mk = kmalloc(sizeof(struct xfs_merkle_blob), GFP_KERNEL);
+	if (!mk)
+		return NULL;
+
+	mk->data = kvzalloc(blocksize, GFP_KERNEL);
+	if (!mk->data) {
+		kfree(mk);
+		return NULL;
+	}
+
+	/* Caller owns this refcount. */
+	refcount_set(&mk->refcount, 1);
+	mk->flags = 0;
+	return mk;
+}
+
+/* Free a merkle tree blob. */
+static inline void
+xfs_merkle_blob_rele(
+	struct xfs_merkle_blob	*mk)
+{
+	if (refcount_dec_and_test(&mk->refcount)) {
+		kvfree(mk->data);
+		kfree(mk);
+	}
+}
+
+/* Initialize the merkle tree block cache */
+void
+xfs_fsverity_cache_init(
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
+xfs_fsverity_cache_drop(
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
+		trace_xfs_fsverity_cache_drop(ip, xas.xa_index, _RET_IP_);
+
+		xas_store(&xas, NULL);
+		xfs_merkle_blob_rele(mk);
+	}
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+/* Destroy the merkle tree block cache */
+void
+xfs_fsverity_cache_destroy(
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
+xfs_fsverity_cache_load(
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
+	trace_xfs_fsverity_cache_load(ip, key, _RET_IP_);
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
+xfs_fsverity_cache_store(
+	struct xfs_inode	*ip,
+	unsigned long		key,
+	struct xfs_merkle_blob	*mk)
+{
+	struct xfs_merkle_blob	*old;
+	unsigned long		flags;
+
+	trace_xfs_fsverity_cache_store(ip, key, _RET_IP_);
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
+/*
+ * Initialize an args structure to load or store the fsverity descriptor.
+ * Caller must ensure @args is zeroed except for value and valuelen.
+ */
+static inline void
+xfs_fsverity_init_vdesc_args(
+	struct xfs_inode	*ip,
+	struct xfs_da_args	*args)
+{
+	args->geo = ip->i_mount->m_attr_geo;
+	args->whichfork = XFS_ATTR_FORK,
+	args->attr_filter = XFS_ATTR_VERITY;
+	args->op_flags = XFS_DA_OP_OKNOENT;
+	args->dp = ip;
+	args->owner = ip->i_ino;
+	args->name = XFS_VERITY_DESCRIPTOR_NAME;
+	args->namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
+	xfs_attr_sethash(args);
+}
+
+/*
+ * Initialize an args structure to load or store a merkle tree block.
+ * Caller must ensure @args is zeroed except for value and valuelen.
+ */
+static inline void
+xfs_fsverity_init_merkle_args(
+	struct xfs_inode	*ip,
+	struct xfs_merkle_key	*key,
+	uint64_t		merkleoff,
+	struct xfs_da_args	*args)
+{
+	xfs_merkle_key_to_disk(key, merkleoff);
+	args->geo = ip->i_mount->m_attr_geo;
+	args->whichfork = XFS_ATTR_FORK,
+	args->attr_filter = XFS_ATTR_VERITY;
+	args->op_flags = XFS_DA_OP_OKNOENT;
+	args->dp = ip;
+	args->owner = ip->i_ino;
+	args->name = (const uint8_t *)key;
+	args->namelen = sizeof(struct xfs_merkle_key);
+	xfs_attr_sethash(args);
+}
+
+/* Delete the verity descriptor. */
+static int
+xfs_fsverity_delete_descriptor(
+	struct xfs_inode	*ip)
+{
+	struct xfs_da_args	args = { };
+
+	xfs_fsverity_init_vdesc_args(ip, &args);
+	return xfs_attr_removename(&args, false);
+}
+
+/* Delete a merkle tree block. */
+static int
+xfs_fsverity_delete_merkle_block(
+	struct xfs_inode	*ip,
+	u64			offset)
+{
+	struct xfs_merkle_key	name;
+	struct xfs_da_args	args = { };
+
+	xfs_fsverity_init_merkle_args(ip, &name, offset, &args);
+	return xfs_attr_removename(&args, false);
+}
+
+/* Retrieve the verity descriptor. */
+static int
+xfs_fsverity_get_descriptor(
+	struct inode		*inode,
+	void			*buf,
+	size_t			buf_size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_da_args	args = {
+		.value		= buf,
+		.valuelen	= buf_size,
+	};
+	int			error = 0;
+
+	/*
+	 * The fact that (returned attribute size) == (provided buf_size) is
+	 * checked by xfs_attr_copy_value() (returns -ERANGE).  No descriptor
+	 * is treated as a short read so that common fsverity code will
+	 * complain.
+	 */
+	xfs_fsverity_init_vdesc_args(ip, &args);
+	error = xfs_attr_getname(&args);
+	if (error == -ENOATTR)
+		return 0;
+	if (error)
+		return error;
+
+	return args.valuelen;
+}
+
+/*
+ * Clear out old fsverity metadata before we start building a new one.  This
+ * could happen if, say, we crashed while building fsverity data.
+ */
+static int
+xfs_fsverity_delete_stale_metadata(
+	struct xfs_inode	*ip,
+	u64			new_tree_size,
+	unsigned int		tree_blocksize)
+{
+	u64			offset;
+	int			error = 0;
+
+	/*
+	 * Delete as many merkle tree blocks in increasing blkno order until we
+	 * don't find any more.  That ought to be good enough for avoiding
+	 * dead bloat without excessive runtime.
+	 */
+	for (offset = new_tree_size; !error; offset += tree_blocksize) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		error = xfs_fsverity_delete_merkle_block(ip, offset);
+		if (error)
+			break;
+	}
+
+	return error != -ENOATTR ? error : 0;
+}
+
+/* Prepare to enable fsverity by clearing old metadata. */
+static int
+xfs_fsverity_begin_enable(
+	struct file		*filp,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+
+	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
+		return -EBUSY;
+
+	error = xfs_qm_dqattach(ip);
+	if (error)
+		return error;
+
+	return xfs_fsverity_delete_stale_metadata(ip, merkle_tree_size,
+			tree_blocksize);
+}
+
+/* Try to remove all the fsverity metadata after a failed enablement. */
+static int
+xfs_fsverity_delete_metadata(
+	struct xfs_inode	*ip,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	u64			offset;
+	int			error;
+
+	if (!merkle_tree_size)
+		return 0;
+
+	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		error = xfs_fsverity_delete_merkle_block(ip, offset);
+		if (error == -ENOATTR)
+			error = 0;
+		if (error)
+			return error;
+	}
+
+	error = xfs_fsverity_delete_descriptor(ip);
+	return error != -ENOATTR ? error : 0;
+}
+
+/* Complete (or fail) the process of enabling fsverity. */
+static int
+xfs_fsverity_end_enable(
+	struct file		*filp,
+	const void		*desc,
+	size_t			desc_size,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	struct xfs_da_args	args = {
+		.value		= (void *)desc,
+		.valuelen	= desc_size,
+	};
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	int			error = 0;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	/* fs-verity failed, just cleanup */
+	if (desc == NULL)
+		goto out;
+
+	xfs_fsverity_init_vdesc_args(ip, &args);
+	error = xfs_attr_setname(&args, false);
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
+	if (error) {
+		int	error2;
+
+		error2 = xfs_fsverity_delete_metadata(ip,
+				merkle_tree_size, tree_blocksize);
+		if (error2)
+			xfs_alert(ip->i_mount,
+ "ino 0x%llx failed to clean up new fsverity metadata, err %d",
+					ip->i_ino, error2);
+	}
+
+	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
+	return error;
+}
+
+/* Retrieve a merkle tree block. */
+static int
+xfs_fsverity_read_merkle(
+	const struct fsverity_readmerkle *req,
+	struct fsverity_blockbuf	*block)
+{
+	struct xfs_inode		*ip = XFS_I(req->inode);
+	struct xfs_merkle_key		name;
+	struct xfs_da_args		args = {
+		.valuelen		= block->size,
+	};
+	struct xfs_merkle_blob		*mk, *new_mk;
+	unsigned long			key = block->offset >> req->log_blocksize;
+	int				error;
+
+	ASSERT(block->offset >> req->log_blocksize <= ULONG_MAX);
+
+	/* Is the block already cached? */
+	mk = xfs_fsverity_cache_load(ip, key);
+	if (mk)
+		goto out_hit;
+
+	new_mk = xfs_merkle_blob_alloc(block->size);
+	if (!new_mk)
+		return -ENOMEM;
+	args.value = new_mk->data;
+
+	/* Read the block in from disk and try to store it in the cache. */
+	xfs_fsverity_init_merkle_args(ip, &name, block->offset, &args);
+	error = xfs_attr_getname(&args);
+	if (error)
+		goto out_new_mk;
+
+	if (!args.valuelen) {
+		error = -ENODATA;
+		goto out_new_mk;
+	}
+
+	mk = xfs_fsverity_cache_store(ip, key, new_mk);
+	if (mk != new_mk) {
+		/*
+		 * We raced with another thread to populate the cache and lost.
+		 * Free the new cache blob and continue with the existing one.
+		 */
+		xfs_merkle_blob_rele(new_mk);
+	}
+
+out_hit:
+	block->kaddr   = (void *)mk->data;
+	block->context = mk;
+	block->verified = test_bit(XFS_MERKLE_BLOB_VERIFIED_BIT, &mk->flags);
+
+	return 0;
+
+out_new_mk:
+	xfs_merkle_blob_rele(new_mk);
+	return error;
+}
+
+/* Write a merkle tree block. */
+static int
+xfs_fsverity_write_merkle(
+	const struct fsverity_writemerkle *req,
+	const void			*buf,
+	u64				pos,
+	unsigned int			size)
+{
+	struct inode			*inode = req->inode;
+	struct xfs_inode		*ip = XFS_I(inode);
+	struct xfs_merkle_key		name;
+	struct xfs_da_args		args = {
+		.value			= (void *)buf,
+		.valuelen		= size,
+	};
+
+	xfs_fsverity_init_merkle_args(ip, &name, pos, &args);
+	return xfs_attr_setname(&args, false);
+}
+
+/* Drop a cached merkle tree block.. */
+static void
+xfs_fsverity_drop_merkle(
+	struct fsverity_blockbuf	*block)
+{
+	struct xfs_merkle_blob		*mk = block->context;
+
+	if (block->verified)
+		set_bit(XFS_MERKLE_BLOB_VERIFIED_BIT, &mk->flags);
+	xfs_merkle_blob_rele(mk);
+	block->kaddr = NULL;
+	block->context = NULL;
+}
+
+const struct fsverity_operations xfs_fsverity_ops = {
+	.begin_enable_verity		= xfs_fsverity_begin_enable,
+	.end_enable_verity		= xfs_fsverity_end_enable,
+	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
+	.read_merkle_tree_block		= xfs_fsverity_read_merkle,
+	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
+	.drop_merkle_tree_block		= xfs_fsverity_drop_merkle,
+};
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
new file mode 100644
index 0000000000000..277a9f856f518
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_FSVERITY_H__
+#define __XFS_FSVERITY_H__
+
+#ifdef CONFIG_FS_VERITY
+void xfs_fsverity_cache_init(struct xfs_inode *ip);
+void xfs_fsverity_cache_drop(struct xfs_inode *ip);
+void xfs_fsverity_cache_destroy(struct xfs_inode *ip);
+
+extern const struct fsverity_operations xfs_fsverity_ops;
+#else
+# define xfs_fsverity_cache_init(ip)		((void)0)
+# define xfs_fsverity_cache_drop(ip)		((void)0)
+# define xfs_fsverity_cache_destroy(ip)		((void)0)
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_FSVERITY_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 01bbdbec6663f..0757062c318d0 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -28,6 +28,7 @@
 #include "xfs_da_format.h"
 #include "xfs_dir2.h"
 #include "xfs_imeta.h"
+#include "xfs_fsverity.h"
 
 #include <linux/iversion.h>
 
@@ -118,6 +119,7 @@ xfs_inode_alloc(
 	spin_lock_init(&ip->i_ioend_lock);
 	ip->i_next_unlinked = NULLAGINO;
 	ip->i_prev_unlinked = 0;
+	xfs_fsverity_cache_init(ip);
 
 	return ip;
 }
@@ -129,6 +131,8 @@ xfs_inode_free_callback(
 	struct inode		*inode = container_of(head, struct inode, i_rcu);
 	struct xfs_inode	*ip = XFS_I(inode);
 
+	xfs_fsverity_cache_destroy(ip);
+
 	switch (VFS_I(ip)->i_mode & S_IFMT) {
 	case S_IFREG:
 	case S_IFDIR:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 5a202706fc4a4..70c5700132b3e 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -96,6 +96,9 @@ typedef struct xfs_inode {
 	spinlock_t		i_ioend_lock;
 	struct work_struct	i_ioend_work;
 	struct list_head	i_ioend_list;
+#ifdef CONFIG_FS_VERITY
+	struct xarray		i_merkle_blocks;
+#endif
 } xfs_inode_t;
 
 static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
@@ -391,6 +394,8 @@ static inline bool xfs_inode_needs_cow_around(struct xfs_inode *ip)
  */
 #define XFS_IREMAPPING		(1U << 15)
 
+#define XFS_VERITY_CONSTRUCTION	(1U << 16) /* merkle tree construction */
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 42a1e1f23d3b3..4e398884c46ae 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -30,6 +30,7 @@
 #include "xfs_filestream.h"
 #include "xfs_quota.h"
 #include "xfs_sysfs.h"
+#include "xfs_fsverity.h"
 #include "xfs_ondisk.h"
 #include "xfs_rmap_item.h"
 #include "xfs_refcount_item.h"
@@ -53,6 +54,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/fsverity.h>
+#include <linux/iomap.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -672,6 +674,8 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	if (fsverity_active(inode))
+		xfs_fsverity_cache_drop(ip);
 	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
@@ -1534,6 +1538,9 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	sb->s_vop = &xfs_fsverity_ops;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1775,10 +1782,20 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 	"EXPERIMENTAL parent pointer feature enabled. Use at your own risk!");
 
+	if (xfs_has_verity(mp))
+		xfs_alert(mp,
+	"EXPERIMENTAL fsverity feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
 
+#ifdef CONFIG_FS_VERITY
+	error = iomap_init_fsverity(mp->m_super);
+	if (error)
+		goto out_unmount;
+#endif
+
 	root = igrab(VFS_I(mp->m_rootip));
 	if (!root) {
 		error = -ENOENT;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e2992b0115ad2..86a8702c1e27c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5908,6 +5908,38 @@ TRACE_EVENT(xfs_growfs_check_rtgeom,
 );
 #endif /* CONFIG_XFS_RT */
 
+#ifdef CONFIG_FS_VERITY
+DECLARE_EVENT_CLASS(xfs_fsverity_cache_class,
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
+#define DEFINE_XFS_FSVERITY_CACHE_EVENT(name) \
+DEFINE_EVENT(xfs_fsverity_cache_class, name, \
+	TP_PROTO(struct xfs_inode *ip, unsigned long key, unsigned long caller_ip), \
+	TP_ARGS(ip, key, caller_ip))
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_load);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
+#endif /* CONFIG_XFS_VERITY */
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH


