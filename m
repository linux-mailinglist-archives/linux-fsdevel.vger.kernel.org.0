Return-Path: <linux-fsdevel+bounces-14325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588CA87B078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3951C22FA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865413E7D5;
	Wed, 13 Mar 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl63tgd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164913DB9B;
	Wed, 13 Mar 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352418; cv=none; b=g+Lt5WbMCJfs7uLAsHWcreV08diyC+XvZqF2cHe4nWR2niGhJsGJYlQQsoZDYqFMdgn00DVErE/TKCQvyc1eOspmv/l3lAeh9BEb/r3zW2j2nqWbbxWnqRz5XERFWPyM9naoeG5/30fpXNNK6eupG9ncKxpRNIyAZFn/ZV/zrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352418; c=relaxed/simple;
	bh=QlJAa+uqVG2dhy6hqzccOs4xjxALGADksKWeBhfsQ3U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRQXz++aH7a1vU6EdqR307AYHmPWQ1dh5hDcp1eXS6Mo9QWuQMnFnzaiuVgZsj2+c2Qr3/MZMPClzROKm3jDFqgXxa+IHguMA2gDP3mbEW0BTZ7tfcstBSHuSFx4XqleIVwWqqS1gzGhZvi2K7b14odrZjrcIfMb0J1+BqEgD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl63tgd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8025C433C7;
	Wed, 13 Mar 2024 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352417;
	bh=QlJAa+uqVG2dhy6hqzccOs4xjxALGADksKWeBhfsQ3U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Yl63tgd+CGSnWASffx+TqrUCAEgwkFrQ98E+lRVrEEOK6wrooQ1x1ogLiXj5MdeSh
	 UV54F3ozrk5WCOHlxtXUKVNmLZqpuUExRVCdcm3qlp8+ZQqVZKAd8l8KaAZltnzWia
	 0Kf8RxJw2hktd86Z1YfrlpplpuI38QK7UNsSPsKsLl/HaA5BuugJ1uC4z98e4Epqlz
	 XedHxyw9y3I1Zqfm2xFv4tCvB+vIcJ7JQuiyio8ZkjQdShDW7zTHrz+fx+im710sCv
	 SaaT4w6L0YFMcVzA1haw94LLwXcnN6ol+1OcImqxn3mX272pfnCFY7kLo0paNoxXYI
	 59m2wdqaN/g7w==
Date: Wed, 13 Mar 2024 10:53:37 -0700
Subject: [PATCH 04/29] xfs: add parent pointer validator functions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
 linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223424.2613863.10249525423420622979.stgit@frogsfrogsfrogs>
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

From: Allison Henderson <allison.henderson@oracle.com>

Attribute names of parent pointers are not strings.  So we need to
modify attr_namecheck to verify parent pointer records when the
XFS_ATTR_PARENT flag is set.  At the same time, we need to validate attr
values during log recovery if the xattr is really a parent pointer.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: move functions to xfs_parent.c, adjust for new disk format]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile               |    1 
 fs/xfs/libxfs/xfs_attr.c      |   10 +++-
 fs/xfs/libxfs/xfs_attr.h      |    3 +
 fs/xfs/libxfs/xfs_da_format.h |    8 +++
 fs/xfs/libxfs/xfs_parent.c    |  113 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_parent.h    |   19 +++++++
 fs/xfs/scrub/attr.c           |    2 -
 fs/xfs/xfs_attr_item.c        |    6 +-
 fs/xfs/xfs_attr_list.c        |   14 +++--
 9 files changed, 165 insertions(+), 11 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_parent.c
 create mode 100644 fs/xfs/libxfs/xfs_parent.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 76674ad5833e..f8845e65cac7 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -41,6 +41,7 @@ xfs-y				+= $(addprefix libxfs/, \
 				   xfs_inode_buf.o \
 				   xfs_log_rlimit.o \
 				   xfs_ag_resv.o \
+				   xfs_parent.o \
 				   xfs_rmap.o \
 				   xfs_rmap_btree.o \
 				   xfs_refcount.o \
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index ff67a684a452..f0b625d45aa4 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -26,6 +26,7 @@
 #include "xfs_trace.h"
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
+#include "xfs_parent.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1515,9 +1516,14 @@ xfs_attr_node_get(
 /* Returns true if the attribute entry name is valid. */
 bool
 xfs_attr_namecheck(
-	const void	*name,
-	size_t		length)
+	struct xfs_mount	*mp,
+	const void		*name,
+	size_t			length,
+	unsigned int		flags)
 {
+	if (flags & XFS_ATTR_PARENT)
+		return xfs_parent_namecheck(mp, name, length, flags);
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
index 81be9b3e4004..92711c8d2a9f 100644
--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -547,7 +547,8 @@ int xfs_attr_get(struct xfs_da_args *args);
 int xfs_attr_set(struct xfs_da_args *args);
 int xfs_attr_set_iter(struct xfs_attr_intent *attr);
 int xfs_attr_remove_iter(struct xfs_attr_intent *attr);
-bool xfs_attr_namecheck(const void *name, size_t length);
+bool xfs_attr_namecheck(struct xfs_mount *mp, const void *name, size_t length,
+		unsigned int flags);
 int xfs_attr_calc_size(struct xfs_da_args *args, int *local);
 void xfs_init_attr_trans(struct xfs_da_args *args, struct xfs_trans_res *tres,
 			 unsigned int *total);
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 67e8c33c4e82..839df0e5401b 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -757,6 +757,14 @@ xfs_attr3_leaf_name(xfs_attr_leafblock_t *leafp, int idx)
 	return &((char *)leafp)[be16_to_cpu(entries[idx].nameidx)];
 }
 
+static inline int
+xfs_attr3_leaf_flags(xfs_attr_leafblock_t *leafp, int idx)
+{
+	struct xfs_attr_leaf_entry *entries = xfs_attr3_leaf_entryp(leafp);
+
+	return entries[idx].flags;
+}
+
 static inline xfs_attr_leaf_name_remote_t *
 xfs_attr3_leaf_name_remote(xfs_attr_leafblock_t *leafp, int idx)
 {
diff --git a/fs/xfs/libxfs/xfs_parent.c b/fs/xfs/libxfs/xfs_parent.c
new file mode 100644
index 000000000000..1d45f926c13a
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_parent.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Oracle.
+ * All rights reserved.
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_log_format.h"
+#include "xfs_shared.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_bmap_btree.h"
+#include "xfs_inode.h"
+#include "xfs_error.h"
+#include "xfs_trace.h"
+#include "xfs_trans.h"
+#include "xfs_da_btree.h"
+#include "xfs_attr.h"
+#include "xfs_dir2.h"
+#include "xfs_dir2_priv.h"
+#include "xfs_attr_sf.h"
+#include "xfs_bmap.h"
+#include "xfs_defer.h"
+#include "xfs_log.h"
+#include "xfs_xattr.h"
+#include "xfs_parent.h"
+#include "xfs_trans_space.h"
+
+/*
+ * Parent pointer attribute handling.
+ *
+ * Because the attribute value is a filename component, it will never be longer
+ * than 255 bytes. This means the attribute will always be a local format
+ * attribute as it is xfs_attr_leaf_entsize_local_max() for v5 filesystems will
+ * always be larger than this (max is 75% of block size).
+ *
+ * Creating a new parent attribute will always create a new attribute - there
+ * should never, ever be an existing attribute in the tree for a new inode.
+ * ENOSPC behavior is problematic - creating the inode without the parent
+ * pointer is effectively a corruption, so we allow parent attribute creation
+ * to dip into the reserve block pool to avoid unexpected ENOSPC errors from
+ * occurring.
+ */
+
+/* Return true if parent pointer EA name is valid. */
+bool
+xfs_parent_namecheck(
+	struct xfs_mount			*mp,
+	const struct xfs_parent_name_rec	*rec,
+	size_t					reclen,
+	unsigned int				attr_flags)
+{
+	if (!(attr_flags & XFS_ATTR_PARENT))
+		return false;
+
+	/* pptr updates use logged xattrs, so we should never see this flag */
+	if (attr_flags & XFS_ATTR_INCOMPLETE)
+		return false;
+
+	if (reclen != sizeof(struct xfs_parent_name_rec))
+		return false;
+
+	/* Only one namespace bit allowed. */
+	if (hweight32(attr_flags & XFS_ATTR_NSP_ONDISK_MASK) > 1)
+		return false;
+
+	return true;
+}
+
+/* Return true if parent pointer EA value is valid. */
+bool
+xfs_parent_valuecheck(
+	struct xfs_mount		*mp,
+	const void			*value,
+	size_t				valuelen)
+{
+	if (valuelen == 0 || valuelen > XFS_PARENT_DIRENT_NAME_MAX_SIZE)
+		return false;
+
+	if (value == NULL)
+		return false;
+
+	return true;
+}
+
+/* Return true if the ondisk parent pointer is consistent. */
+bool
+xfs_parent_hashcheck(
+	struct xfs_mount		*mp,
+	const struct xfs_parent_name_rec *rec,
+	const void			*value,
+	size_t				valuelen)
+{
+	struct xfs_name			dname = {
+		.name			= value,
+		.len			= valuelen,
+	};
+	xfs_ino_t			p_ino;
+
+	/* Valid dirent name? */
+	if (!xfs_dir2_namecheck(value, valuelen))
+		return false;
+
+	/* Valid inode number? */
+	p_ino = be64_to_cpu(rec->p_ino);
+	if (!xfs_verify_dir_ino(mp, p_ino))
+		return false;
+
+	/* Namehash matches name? */
+	return be32_to_cpu(rec->p_namehash) == xfs_dir2_hashname(mp, &dname);
+}
diff --git a/fs/xfs/libxfs/xfs_parent.h b/fs/xfs/libxfs/xfs_parent.h
new file mode 100644
index 000000000000..fcfeddb645f6
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_parent.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Oracle.
+ * All Rights Reserved.
+ */
+#ifndef	__XFS_PARENT_H__
+#define	__XFS_PARENT_H__
+
+/* Metadata validators */
+bool xfs_parent_namecheck(struct xfs_mount *mp,
+		const struct xfs_parent_name_rec *rec, size_t reclen,
+		unsigned int attr_flags);
+bool xfs_parent_valuecheck(struct xfs_mount *mp, const void *value,
+		size_t valuelen);
+bool xfs_parent_hashcheck(struct xfs_mount *mp,
+		const struct xfs_parent_name_rec *rec, const void *value,
+		size_t valuelen);
+
+#endif /* __XFS_PARENT_H__ */
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 49f91cc85a65..9a1f59f7b5a4 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -195,7 +195,7 @@ xchk_xattr_listent(
 	}
 
 	/* Does this name make sense? */
-	if (!xfs_attr_namecheck(name, namelen)) {
+	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
 		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
 		goto fail_xref;
 	}
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 9b4c61e1c22e..703770cf1482 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -591,7 +591,8 @@ xfs_attr_recover_work(
 	 */
 	attrp = &attrip->attri_format;
 	if (!xfs_attri_validate(mp, attrp) ||
-	    !xfs_attr_namecheck(nv->name.i_addr, nv->name.i_len))
+	    !xfs_attr_namecheck(mp, nv->name.i_addr, nv->name.i_len,
+				attrp->alfi_attr_filter))
 		return -EFSCORRUPTED;
 
 	attr = xfs_attri_recover_work(mp, dfp, attrp, &ip, nv);
@@ -731,7 +732,8 @@ xlog_recover_attri_commit_pass2(
 		return -EFSCORRUPTED;
 	}
 
-	if (!xfs_attr_namecheck(attr_name, attri_formatp->alfi_name_len)) {
+	if (!xfs_attr_namecheck(mp, attr_name, attri_formatp->alfi_name_len,
+				attri_formatp->alfi_attr_filter)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[1].i_addr, item->ri_buf[1].i_len);
 		return -EFSCORRUPTED;
diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index a6819a642cc0..fa74378577c5 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -59,6 +59,7 @@ xfs_attr_shortform_list(
 	struct xfs_attr_sf_sort		*sbuf, *sbp;
 	struct xfs_attr_sf_hdr		*sf = dp->i_af.if_data;
 	struct xfs_attr_sf_entry	*sfe;
+	struct xfs_mount		*mp = dp->i_mount;
 	int				sbsize, nsbuf, count, i;
 	int				error = 0;
 
@@ -82,8 +83,9 @@ xfs_attr_shortform_list(
 	     (dp->i_af.if_bytes + sf->count * 16) < context->bufsize)) {
 		for (i = 0, sfe = xfs_attr_sf_firstentry(sf); i < sf->count; i++) {
 			if (XFS_IS_CORRUPT(context->dp->i_mount,
-					   !xfs_attr_namecheck(sfe->nameval,
-							       sfe->namelen))) {
+					   !xfs_attr_namecheck(mp, sfe->nameval,
+							       sfe->namelen,
+							       sfe->flags))) {
 				xfs_dirattr_mark_sick(context->dp, XFS_ATTR_FORK);
 				return -EFSCORRUPTED;
 			}
@@ -177,8 +179,9 @@ xfs_attr_shortform_list(
 			cursor->offset = 0;
 		}
 		if (XFS_IS_CORRUPT(context->dp->i_mount,
-				   !xfs_attr_namecheck(sbp->name,
-						       sbp->namelen))) {
+				   !xfs_attr_namecheck(mp, sbp->name,
+						       sbp->namelen,
+						       sbp->flags))) {
 			xfs_dirattr_mark_sick(context->dp, XFS_ATTR_FORK);
 			error = -EFSCORRUPTED;
 			goto out;
@@ -474,7 +477,8 @@ xfs_attr3_leaf_list_int(
 		}
 
 		if (XFS_IS_CORRUPT(context->dp->i_mount,
-				   !xfs_attr_namecheck(name, namelen))) {
+				   !xfs_attr_namecheck(mp, name, namelen,
+						       entry->flags))) {
 			xfs_dirattr_mark_sick(context->dp, XFS_ATTR_FORK);
 			return -EFSCORRUPTED;
 		}


