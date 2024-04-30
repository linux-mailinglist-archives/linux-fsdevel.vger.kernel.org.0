Return-Path: <linux-fsdevel+bounces-18243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1A8B689A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B584285E9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67C11190;
	Tue, 30 Apr 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxo2X4yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EE10A01;
	Tue, 30 Apr 2024 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447666; cv=none; b=j39y3EvTulwMt06TJQkLMbtpWcqckSCIZYJNL2Z3e5R+/TXHerwmmoov0Wbr4ISLxXWt1cDOJMBdbSwrvmJmVU6acI7CO41m6VqCK4cq1E9G/WXdsf1NJMpnzl+jjsa91eBv/1rsI7ExUknkEh7H13BnDsedKZQar1rc+1+ehmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447666; c=relaxed/simple;
	bh=KV+Gghlcgbn215xVETo1EajjXO+D8JdzGOCTktlZKCs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auK+252rRH23/omvwp+2kwxIuicXdWnwHK2HMg/4pA87H8FokmEgj5BLF9lkTG8RXm1DYm8aSEuoIJOcHVjwte/aoTe57y4ZZSH0nJCEF/GWc+FBBOHogWAC9s8Ef+v00T//SI3c+kYz01LUXwK72UkFtr9iEp0MDDZLNZ51I4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxo2X4yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE355C116B1;
	Tue, 30 Apr 2024 03:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447666;
	bh=KV+Gghlcgbn215xVETo1EajjXO+D8JdzGOCTktlZKCs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lxo2X4yb9j13a1LD/F6W+QeMlHp2/7dE7m12IE1wsf+XO1EtDHkf4MvpO8JhO799T
	 RqnWlsWOYX6krlck79F9CoYH1GeGjRdQQ/wmQdDTOojU8S/3BeFNeUhyKXv/3GcSVR
	 TLqlPAKCsez0xeIyUTf9QLiYQvHwol5xd21rKcaBsP+yZrexwxJw7pfEriWqWB+zyA
	 PW1ze7hZlxcP4AUXRagokNdveHqC1XV2Sdk60aieqSacRhDV7f/sPcraU/gzHD/v5E
	 8M2dz8v17X4VD+QJDAQ+MW+F10TILXQ+G8y7mrhqB0tYVa1DBtM5GbwouiBu27rcWZ
	 RL62FUOAraj3Q==
Date: Mon, 29 Apr 2024 20:27:45 -0700
Subject: [PATCH 14/26] xfs: add fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680601.957659.7420481919840574646.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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

Merkle tree blocks are indexed by a per-AG rhashtable to reduce the time
it takes to load a block from disk in a manner that doesn't bloat struct
xfs_inode.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace caching implementation with an xarray, other cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile               |    2 
 fs/xfs/libxfs/xfs_ag.h        |    8 
 fs/xfs/libxfs/xfs_attr.c      |    4 
 fs/xfs/libxfs/xfs_da_format.h |   14 +
 fs/xfs/libxfs/xfs_ondisk.h    |    3 
 fs/xfs/libxfs/xfs_verity.c    |   58 +++
 fs/xfs/libxfs/xfs_verity.h    |   13 +
 fs/xfs/xfs_fsops.c            |    6 
 fs/xfs/xfs_fsverity.c         |  758 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h         |   32 ++
 fs/xfs/xfs_inode.h            |    2 
 fs/xfs/xfs_mount.c            |   10 -
 fs/xfs/xfs_super.c            |   22 +
 fs/xfs/xfs_trace.c            |    1 
 fs/xfs/xfs_trace.h            |   39 ++
 15 files changed, 971 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/libxfs/xfs_verity.c
 create mode 100644 fs/xfs/libxfs/xfs_verity.h
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index f8e72e53d9ec5..34176ba4c77ef 100644
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
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 80bf8771ea2ac..792ce162312e7 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -123,6 +123,12 @@ struct xfs_perag {
 
 	/* Hook to feed rmapbt updates to an active online repair. */
 	struct xfs_hooks	pag_rmap_update_hooks;
+
+# ifdef CONFIG_FS_VERITY
+	/* per-inode merkle tree caches */
+	spinlock_t		pagi_merkle_lock;
+	struct rhashtable	pagi_merkle_blobs;
+# endif /* CONFIG_FS_VERITY */
 #endif /* __KERNEL__ */
 };
 
@@ -135,6 +141,7 @@ struct xfs_perag {
 #define XFS_AGSTATE_ALLOWS_INODES	3
 #define XFS_AGSTATE_AGFL_NEEDS_RESET	4
 #define XFS_AGSTATE_NOALLOC		5
+#define XFS_AGSTATE_MERKLE		6
 
 #define __XFS_AG_OPSTATE(name, NAME) \
 static inline bool xfs_perag_ ## name (struct xfs_perag *pag) \
@@ -148,6 +155,7 @@ __XFS_AG_OPSTATE(prefers_metadata, PREFERS_METADATA)
 __XFS_AG_OPSTATE(allows_inodes, ALLOWS_INODES)
 __XFS_AG_OPSTATE(agfl_needs_reset, AGFL_NEEDS_RESET)
 __XFS_AG_OPSTATE(prohibits_alloc, NOALLOC)
+__XFS_AG_OPSTATE(caches_merkle, MERKLE)
 
 void xfs_free_unused_perag_range(struct xfs_mount *mp, xfs_agnumber_t agstart,
 			xfs_agnumber_t agend);
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 1b9d9ffb16833..953a82d70223e 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -27,6 +27,7 @@
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1619,6 +1620,9 @@ xfs_attr_namecheck(
 	if (!xfs_attr_check_namespace(attr_flags))
 		return false;
 
+	if (attr_flags & XFS_ATTR_VERITY)
+		return xfs_verity_namecheck(attr_flags, name, length);
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index c84b94da3f321..43e9d1f00a4ab 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -929,4 +929,18 @@ struct xfs_parent_rec {
 	__be32	p_gen;
 } __packed;
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode.  The
+ * name of the attributes are byte positions into the merkle data.
+ */
+struct xfs_merkle_key {
+	__be64	mk_pos;
+};
+
+/* ondisk xattr name used for the fsverity descriptor */
+#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index 7a312aed23373..03aaf508e4a49 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -209,6 +209,9 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
 
+	/* fs-verity xattrs */
+	XFS_CHECK_STRUCT_SIZE(struct xfs_merkle_key,		8);
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME),	6);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/libxfs/xfs_verity.c b/fs/xfs/libxfs/xfs_verity.c
new file mode 100644
index 0000000000000..ff02c5c840b58
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
+/* Set a merkle tree pos in preparation for setting merkle tree attrs. */
+void
+xfs_merkle_key_to_disk(
+	struct xfs_merkle_key	*key,
+	uint64_t		pos)
+{
+	key->mk_pos = cpu_to_be64(pos);
+}
+
+/* Retrieve the merkle tree pos from the attr data. */
+uint64_t
+xfs_merkle_key_from_disk(
+	const void		*attr_name,
+	int			namelen)
+{
+	const struct xfs_merkle_key *key = attr_name;
+
+	ASSERT(namelen == sizeof(struct xfs_merkle_key));
+
+	return be64_to_cpu(key->mk_pos);
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
index 0000000000000..5813665c5a01e
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
+void xfs_merkle_key_to_disk(struct xfs_merkle_key *key, uint64_t pos);
+uint64_t xfs_merkle_key_from_disk(const void *attr_name, int namelen);
+bool xfs_verity_namecheck(unsigned int attr_flags, const void *name,
+		int namelen);
+
+#endif	/* __XFS_VERITY_H__ */
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index a2929a0e0367e..1187b1a33b76c 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -25,6 +25,7 @@
 #include "xfs_rtalloc.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
+#include "xfs_fsverity.h"
 
 /*
  * Write new AG headers to disk. Non-transactional, but need to be
@@ -155,6 +156,11 @@ xfs_growfs_data_private(
 		error = xfs_initialize_perag(mp, nagcount, nb, &nagimax);
 		if (error)
 			return error;
+		error = xfs_fsverity_growfs(mp, oagcount, nagcount);
+		if (error) {
+			xfs_free_unused_perag_range(mp, oagcount, nagcount);
+			return error;
+		}
 	} else if (nagcount < oagcount) {
 		/* TODO: shrinking the entire AGs hasn't yet completed */
 		return -EINVAL;
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
new file mode 100644
index 0000000000000..e0f54acd4f786
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.c
@@ -0,0 +1,758 @@
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
+#include "xfs_ag.h"
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
+ * passing the data portion of the blob to xfs_attr_get, and later caching the
+ * data blob via a per-ag hashtable.
+ *
+ * The cache structure indexes merkle tree blocks by the pos given to us by
+ * fsverity, which drastically reduces lookups.  First, it eliminating the need
+ * to walk the xattr structure to find the remote block containing the merkle
+ * tree block.  Second, access to each block in the xattr structure requires a
+ * lookup in the incore extent btree.
+ */
+struct xfs_merkle_blob {
+	struct rhash_head	rhash;
+	struct rcu_head		rcu;
+
+	struct xfs_merkle_bkey	key;
+
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
+static const struct rhashtable_params xfs_fsverity_merkle_hash_params = {
+	.key_len		= sizeof(struct xfs_merkle_bkey),
+	.key_offset		= offsetof(struct xfs_merkle_blob, key),
+	.head_offset		= offsetof(struct xfs_merkle_blob, rhash),
+	.automatic_shrinking	= true,
+};
+
+/*
+ * Allocate a merkle tree blob object to prepare for reading a merkle tree
+ * object from disk.
+ */
+static inline struct xfs_merkle_blob *
+xfs_merkle_blob_alloc(
+	struct xfs_inode	*ip,
+	u64			pos,
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
+	mk->key.ino = ip->i_ino;
+	mk->key.pos = pos;
+	return mk;
+}
+
+/* Actually free this blob. */
+static void
+xfs_merkle_blob_free(
+	struct callback_head	*cb)
+{
+	struct xfs_merkle_blob	*mk =
+		container_of(cb, struct xfs_merkle_blob, rcu);
+
+	kvfree(mk->data);
+	kfree(mk);
+}
+
+/* Free a merkle tree blob. */
+static inline void
+xfs_merkle_blob_rele(
+	struct xfs_merkle_blob	*mk)
+{
+	if (refcount_dec_and_test(&mk->refcount))
+		call_rcu(&mk->rcu, xfs_merkle_blob_free);
+}
+
+/*
+ * Drop this merkle tree blob from the cache.  Caller must have a reference to
+ * the blob, which will be dropped at the end.
+ */
+static inline void
+xfs_merkle_blob_drop(
+	struct xfs_perag	*pag,
+	struct xfs_merkle_blob	*mk)
+{
+	/*
+	 * Remove the blob from the hash table and drop the cache's
+	 * ref to the blob handle.
+	 */
+	spin_lock(&pag->pagi_merkle_lock);
+	rhashtable_remove_fast(&pag->pagi_merkle_blobs, &mk->rhash,
+			xfs_fsverity_merkle_hash_params);
+	xfs_merkle_blob_rele(mk);
+	spin_unlock(&pag->pagi_merkle_lock);
+
+	/* Drop the reference we obtained above. */
+	xfs_merkle_blob_rele(mk);
+}
+
+/* Drop all the merkle tree blocks from this part of the cache. */
+STATIC void
+xfs_fsverity_drop_cache(
+	struct xfs_inode	*ip,
+	u64			tree_size,
+	unsigned int		block_size)
+{
+	struct xfs_merkle_bkey	key = {
+		.ino		= ip->i_ino,
+		.pos		= 0,
+	};
+	struct xfs_perag	*pag;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_merkle_blob	*mk;
+	s64			freed = 0;
+
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	if (!pag)
+		return;
+
+	for (key.pos = 0; key.pos < tree_size; key.pos += block_size) {
+		/*
+		 * Try to grab the blob from the hash table and get our own
+		 * reference to the object.  If there's a blob handle but it
+		 * has zero refcount then we're racing with reclaim and can
+		 * move on.
+		 */
+		rcu_read_lock();
+		mk = rhashtable_lookup(&pag->pagi_merkle_blobs, &key,
+				xfs_fsverity_merkle_hash_params);
+		if (mk && !refcount_inc_not_zero(&mk->refcount))
+			mk = NULL;
+		rcu_read_unlock();
+
+		if (!mk)
+			continue;
+
+		trace_xfs_fsverity_cache_drop(mp, &mk->key, _RET_IP_);
+
+		xfs_merkle_blob_drop(pag, mk);
+		freed++;
+	}
+
+	xfs_perag_put(pag);
+}
+
+/*
+ * Drop all the merkle tree blocks out of the cache.  Caller must ensure that
+ * there are no active references to cache items.
+ */
+void
+xfs_fsverity_destroy_inode(
+	struct xfs_inode	*ip)
+{
+	u64			tree_size;
+	unsigned int		block_size;
+	int			error;
+
+	error = fsverity_merkle_tree_geometry(VFS_I(ip), &block_size,
+			&tree_size);
+	if (error)
+		return;
+
+	xfs_fsverity_drop_cache(ip, tree_size, block_size);
+}
+
+/* Return a cached merkle tree block, or NULL. */
+static struct xfs_merkle_blob *
+xfs_fsverity_cache_load(
+	struct xfs_inode	*ip,
+	u64			pos)
+{
+	struct xfs_merkle_bkey	key = {
+		.ino		= ip->i_ino,
+		.pos		= pos,
+	};
+	struct xfs_perag	*pag;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_merkle_blob	*mk;
+
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	if (!pag)
+		return NULL;
+
+	rcu_read_lock();
+	mk = rhashtable_lookup(&pag->pagi_merkle_blobs, &key,
+			xfs_fsverity_merkle_hash_params);
+	if (mk && !refcount_inc_not_zero(&mk->refcount))
+		mk = NULL;
+	rcu_read_unlock();
+	xfs_perag_put(pag);
+
+	if (!mk) {
+		trace_xfs_fsverity_cache_miss(mp, &key, _RET_IP_);
+		return NULL;
+	}
+
+	trace_xfs_fsverity_cache_hit(mp, &mk->key, _RET_IP_);
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
+	struct xfs_merkle_blob	*mk)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_merkle_blob	*old;
+	struct xfs_perag	*pag;
+
+	ASSERT(ip->i_ino == mk->key.ino);
+
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
+	if (!pag) {
+		ASSERT(pag);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
+	spin_lock(&pag->pagi_merkle_lock);
+	old = rhashtable_lookup_get_insert_fast(&pag->pagi_merkle_blobs,
+			&mk->rhash, xfs_fsverity_merkle_hash_params);
+	if (IS_ERR(old)) {
+		spin_unlock(&pag->pagi_merkle_lock);
+		xfs_perag_put(pag);
+		return old;
+	}
+	if (!old) {
+		/*
+		 * There was no previous value.  @mk is now live in the cache.
+		 * Bump the active refcount to transfer ownership to the cache
+		 * and return @mk to the caller.
+		 */
+		refcount_inc(&mk->refcount);
+		spin_unlock(&pag->pagi_merkle_lock);
+		xfs_perag_put(pag);
+
+		trace_xfs_fsverity_cache_store(mp, &mk->key, _RET_IP_);
+		return mk;
+	}
+
+	/*
+	 * We obtained an active reference to a previous value in the cache.
+	 * Return it to the caller.
+	 */
+	refcount_inc(&old->refcount);
+	spin_unlock(&pag->pagi_merkle_lock);
+	xfs_perag_put(pag);
+
+	trace_xfs_fsverity_cache_reuse(mp, &old->key, _RET_IP_);
+	return old;
+}
+
+/* Set up fsverity for this mount. */
+int
+xfs_fsverity_mount(
+	struct xfs_mount	*mp)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
+	int			error;
+
+	if (!xfs_has_verity(mp))
+		return 0;
+
+	for_each_perag(mp, agno, pag) {
+		spin_lock_init(&pag->pagi_merkle_lock);
+		error = rhashtable_init(&pag->pagi_merkle_blobs,
+				&xfs_fsverity_merkle_hash_params);
+		if (error) {
+			xfs_perag_put(pag);
+			goto out_perag;
+		}
+		set_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate);
+	}
+
+	return 0;
+out_perag:
+	for_each_perag(mp, agno, pag) {
+		if (test_and_clear_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate))
+			rhashtable_destroy(&pag->pagi_merkle_blobs);
+	}
+
+	return error;
+}
+
+/* Set up new merkle tree caches for new AGs. */
+int
+xfs_fsverity_growfs(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		old_agcount,
+	xfs_agnumber_t		new_agcount)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
+	int			error;
+
+	if (!xfs_has_verity(mp))
+		return 0;
+
+	agno = old_agcount;
+	for_each_perag_range(mp, agno, new_agcount - 1, pag) {
+		spin_lock_init(&pag->pagi_merkle_lock);
+		error = rhashtable_init(&pag->pagi_merkle_blobs,
+				&xfs_fsverity_merkle_hash_params);
+		if (error) {
+			xfs_perag_put(pag);
+			goto out_perag;
+		}
+		set_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate);
+	}
+
+	return 0;
+out_perag:
+	agno = old_agcount;
+	for_each_perag_range(mp, agno, new_agcount - 1, pag) {
+		if (test_and_clear_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate))
+			rhashtable_destroy(&pag->pagi_merkle_blobs);
+	}
+
+	return error;
+}
+
+struct xfs_fsverity_umount {
+	struct xfs_mount	*mp;
+	s64			freed;
+};
+
+/* Destroy this blob that's still left over in the cache. */
+static void
+xfs_merkle_blob_destroy(
+	void			*ptr,
+	void			*arg)
+{
+	struct xfs_fsverity_umount *fu = arg;
+	struct xfs_merkle_blob	*mk = ptr;
+
+	trace_xfs_fsverity_cache_unmount(fu->mp, &mk->key, _RET_IP_);
+
+	xfs_merkle_blob_rele(ptr);
+	fu->freed++;
+}
+
+/* Tear down fsverity from this mount. */
+void
+xfs_fsverity_unmount(
+	struct xfs_mount	*mp)
+{
+	struct xfs_fsverity_umount fu = {
+		.mp		= mp,
+		.freed		= 0,
+	};
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
+
+	if (!xfs_has_verity(mp))
+		return;
+
+	for_each_perag(mp, agno, pag) {
+		if (test_and_clear_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate))
+			rhashtable_free_and_destroy(&pag->pagi_merkle_blobs,
+					xfs_merkle_blob_destroy, &fu);
+	}
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
+	return xfs_attr_set(&args, XFS_ATTRUPDATE_REMOVE, false);
+}
+
+/* Delete a merkle tree block. */
+static int
+xfs_fsverity_delete_merkle_block(
+	struct xfs_inode	*ip,
+	u64			pos)
+{
+	struct xfs_merkle_key	name;
+	struct xfs_da_args	args = { };
+
+	xfs_fsverity_init_merkle_args(ip, &name, pos, &args);
+	return xfs_attr_set(&args, XFS_ATTRUPDATE_REMOVE, false);
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
+	error = xfs_attr_get(&args);
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
+	u64			pos;
+	int			error = 0;
+
+	/*
+	 * Delete as many merkle tree blocks in increasing blkno order until we
+	 * don't find any more.  That ought to be good enough for avoiding
+	 * dead bloat without excessive runtime.
+	 */
+	for (pos = new_tree_size; !error; pos += tree_blocksize) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		error = xfs_fsverity_delete_merkle_block(ip, pos);
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
+	u64			pos;
+	int			error;
+
+	if (!merkle_tree_size)
+		return 0;
+
+	for (pos = 0; pos < merkle_tree_size; pos += tree_blocksize) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		error = xfs_fsverity_delete_merkle_block(ip, pos);
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
+	error = xfs_attr_set(&args, XFS_ATTRUPDATE_UPSERT, false);
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
+	int				error;
+
+	/* Is the block already cached? */
+	mk = xfs_fsverity_cache_load(ip, block->pos);
+	if (mk)
+		goto out_hit;
+
+	new_mk = xfs_merkle_blob_alloc(ip, block->pos, block->size);
+	if (!new_mk)
+		return -ENOMEM;
+	args.value = new_mk->data;
+
+	/* Read the block in from disk and try to store it in the cache. */
+	xfs_fsverity_init_merkle_args(ip, &name, block->pos, &args);
+	error = xfs_attr_get(&args);
+	if (error)
+		goto out_new_mk;
+
+	mk = xfs_fsverity_cache_store(ip, new_mk);
+	if (IS_ERR(mk)) {
+		xfs_merkle_blob_rele(new_mk);
+		return PTR_ERR(mk);
+	}
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
+	return xfs_attr_set(&args, XFS_ATTRUPDATE_UPSERT, false);
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
index 0000000000000..9156244dce4fe
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_FSVERITY_H__
+#define __XFS_FSVERITY_H__
+
+#ifdef CONFIG_FS_VERITY
+struct xfs_merkle_bkey {
+	/* inumber of the file */
+	xfs_ino_t		ino;
+
+	/* the position of the block in the Merkle tree (in bytes) */
+	u64			pos;
+};
+
+void xfs_fsverity_destroy_inode(struct xfs_inode *ip);
+
+int xfs_fsverity_mount(struct xfs_mount *mp);
+void xfs_fsverity_unmount(struct xfs_mount *mp);
+int xfs_fsverity_growfs(struct xfs_mount *mp, xfs_agnumber_t old_agcount,
+		xfs_agnumber_t new_agcount);
+
+extern const struct fsverity_operations xfs_fsverity_ops;
+#else
+# define xfs_fsverity_destroy_inode(ip)		((void)0)
+# define xfs_fsverity_mount(mp)			(0)
+# define xfs_fsverity_unmount(mp)		((void)0)
+# define xfs_fsverity_growfs(mp, o, n)		(0)
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_FSVERITY_H__ */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 503ea082dfac4..a90ed25b14769 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -391,6 +391,8 @@ static inline bool xfs_inode_needs_cow_around(struct xfs_inode *ip)
  */
 #define XFS_IREMAPPING		(1U << 15)
 
+#define XFS_VERITY_CONSTRUCTION	(1U << 16) /* merkle tree construction */
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index b40c850d97f59..71942e46c7db4 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -38,6 +38,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
+#include "xfs_fsverity.h"
 #include "scrub/stats.h"
 
 static DEFINE_MUTEX(xfs_uuid_table_mutex);
@@ -881,6 +882,10 @@ xfs_mountfs(
 	if (error)
 		goto out_fail_wait;
 
+	error = xfs_fsverity_mount(mp);
+	if (error)
+		goto out_inodegc_shrinker;
+
 	/*
 	 * Log's mount-time initialization. The first part of recovery can place
 	 * some items on the AIL, to be handled when recovery is finished or
@@ -891,7 +896,7 @@ xfs_mountfs(
 			      XFS_FSB_TO_BB(mp, sbp->sb_logblocks));
 	if (error) {
 		xfs_warn(mp, "log mount failed");
-		goto out_inodegc_shrinker;
+		goto out_fsverity;
 	}
 
 	/*
@@ -1103,6 +1108,8 @@ xfs_mountfs(
 	 */
 	xfs_unmount_flush_inodes(mp);
 	xfs_log_mount_cancel(mp);
+ out_fsverity:
+	xfs_fsverity_unmount(mp);
  out_inodegc_shrinker:
 	shrinker_free(mp->m_inodegc_shrinker);
  out_fail_wait:
@@ -1194,6 +1201,7 @@ xfs_unmountfs(
 #if defined(DEBUG)
 	xfs_errortag_clearall(mp);
 #endif
+	xfs_fsverity_unmount(mp);
 	shrinker_free(mp->m_inodegc_shrinker);
 	xfs_free_rtgroups(mp);
 	xfs_free_perag(mp);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 72842d4f16c92..24d67b710a1e9 100644
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
 
@@ -668,6 +670,8 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	if (fsverity_active(inode))
+		xfs_fsverity_destroy_inode(ip);
 	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
@@ -1524,6 +1528,9 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	sb->s_vop = &xfs_fsverity_ops;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1769,10 +1776,25 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 	"EXPERIMENTAL parent pointer feature enabled. Use at your own risk!");
 
+	if (xfs_has_verity(mp))
+		xfs_warn(mp,
+	"EXPERIMENTAL fsverity feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
 
+#ifdef CONFIG_FS_VERITY
+	/*
+	 * Don't use a high priority workqueue like the other fsverity
+	 * implementations because that will lead to conflicts with the xfs log
+	 * workqueue.
+	 */
+	error = iomap_init_fsverity(mp->m_super, 0, 0);
+	if (error)
+		goto out_unmount;
+#endif
+
 	root = igrab(VFS_I(mp->m_rootip));
 	if (!root) {
 		error = -ENOENT;
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index b40f01cb0fe8d..9777360088897 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -47,6 +47,7 @@
 #include "xfs_rmap.h"
 #include "xfs_refcount.h"
 #include "xfs_fsrefs.h"
+#include "xfs_fsverity.h"
 
 static inline void
 xfs_rmapbt_crack_agno_opdev(
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 7116e7d9627d0..3e44d38fd871a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -102,6 +102,7 @@ struct xfs_extent_free_item;
 struct xfs_rmap_intent;
 struct xfs_refcount_intent;
 struct xfs_fsrefs;
+struct xfs_merkle_bkey;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -5922,6 +5923,44 @@ TRACE_EVENT(xfs_growfs_check_rtgeom,
 );
 #endif /* CONFIG_XFS_RT */
 
+#ifdef CONFIG_FS_VERITY
+DECLARE_EVENT_CLASS(xfs_fsverity_cache_class,
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_merkle_bkey *key,
+		 unsigned long caller_ip),
+	TP_ARGS(mp, key, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, pos)
+		__field(void *, caller_ip)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->ino = key->ino;
+		__entry->pos = key->pos;
+		__entry->caller_ip = (void *)caller_ip;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx caller %pS",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->caller_ip)
+)
+
+#define DEFINE_XFS_FSVERITY_CACHE_EVENT(name) \
+DEFINE_EVENT(xfs_fsverity_cache_class, name, \
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_merkle_bkey *key, \
+		 unsigned long caller_ip), \
+	TP_ARGS(mp, key, caller_ip))
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_miss);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_hit);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_reuse);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_unmount);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_reclaim);
+#endif /* CONFIG_XFS_VERITY */
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH


