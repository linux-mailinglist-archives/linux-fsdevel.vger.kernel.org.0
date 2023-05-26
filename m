Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5D711C61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjEZBR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEZBR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4371E195;
        Thu, 25 May 2023 18:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF3964C28;
        Fri, 26 May 2023 01:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8FBC433D2;
        Fri, 26 May 2023 01:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063841;
        bh=aXubmXtTbE1qvb7w3IT0258xn4wJUQ97sMVZ2LZaBIQ=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=kbEkbZb6PbMYGM0z7CZa3WI4CwhhdyLD9S5FuhVl490j60w3BEYYOL14cgr7SdYDd
         xRi4RZ7S9ecMHFu/HT5ktNaMv5LbE2HICu85IYPyfxHzuHPII6OiL0+P4Nu/KlQx5c
         cpXCY2vLh6ndGPz3PChogE5UGcbvHCb9lh+LP2luFkIHVBuaSALtb3U2SegEP+HlJX
         WstRscvrHOepQ1CecYQ6i4O60lO48WLXOh2mlcihrtShEyPMpSdr0ADsxmz4xC6vWL
         1lbXp14oRrV/mD9vQ7YK1cz1n3VedLS4GmmWF2R3HwlK9eDSC34l2xBn0xFsu4x8ou
         yvIMxglThMUWQ==
Date:   Thu, 25 May 2023 18:17:20 -0700
Subject: [PATCH 11/25] xfs: create deferred log items for extent swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065138.3734442.14077414868998354441.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Now that we've created the skeleton of a log intent item to track and
restart extent swap operations, add the upper level logic to commit
intent items and turn them into concrete work recorded in the log.  We
use the deferred item "multihop" feature that was introduced a few
patches ago to constrain the number of active swap operations to one per
thread.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile                 |    1 
 fs/xfs/libxfs/xfs_bmap.h        |    2 
 fs/xfs/libxfs/xfs_defer.c       |    7 
 fs/xfs/libxfs/xfs_defer.h       |    3 
 fs/xfs/libxfs/xfs_format.h      |    6 
 fs/xfs/libxfs/xfs_log_format.h  |   31 +
 fs/xfs/libxfs/xfs_swapext.c     | 1040 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h     |  145 +++++
 fs/xfs/libxfs/xfs_trans_space.h |    4 
 fs/xfs/xfs_swapext_item.c       |  419 +++++++++++++++-
 fs/xfs/xfs_trace.c              |    1 
 fs/xfs/xfs_trace.h              |  216 ++++++++
 fs/xfs/xfs_xchgrange.c          |   50 ++
 fs/xfs/xfs_xchgrange.h          |   10 
 14 files changed, 1919 insertions(+), 16 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.c


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 6366c945ca7d..36baf9913b08 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -46,6 +46,7 @@ xfs-y				+= $(addprefix libxfs/, \
 				   xfs_refcount.o \
 				   xfs_refcount_btree.o \
 				   xfs_sb.o \
+				   xfs_swapext.o \
 				   xfs_symlink_remote.o \
 				   xfs_trans_inode.o \
 				   xfs_trans_resv.o \
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index e35ddc9c0412..81be2b108ade 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -156,7 +156,7 @@ static inline bool xfs_bmap_is_real_extent(const struct xfs_bmbt_irec *irec)
  * Return true if the extent is a real, allocated extent, or false if it is  a
  * delayed allocation, and unwritten extent or a hole.
  */
-static inline bool xfs_bmap_is_written_extent(struct xfs_bmbt_irec *irec)
+static inline bool xfs_bmap_is_written_extent(const struct xfs_bmbt_irec *irec)
 {
 	return xfs_bmap_is_real_extent(irec) &&
 	       irec->br_state != XFS_EXT_UNWRITTEN;
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index bcfb6a4203cd..1619b9b928db 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -26,6 +26,7 @@
 #include "xfs_da_format.h"
 #include "xfs_da_btree.h"
 #include "xfs_attr.h"
+#include "xfs_swapext.h"
 
 static struct kmem_cache	*xfs_defer_pending_cache;
 
@@ -189,6 +190,7 @@ static const struct xfs_defer_op_type *defer_op_types[] = {
 	[XFS_DEFER_OPS_TYPE_FREE]	= &xfs_extent_free_defer_type,
 	[XFS_DEFER_OPS_TYPE_AGFL_FREE]	= &xfs_agfl_free_defer_type,
 	[XFS_DEFER_OPS_TYPE_ATTR]	= &xfs_attr_defer_type,
+	[XFS_DEFER_OPS_TYPE_SWAPEXT]	= &xfs_swapext_defer_type,
 };
 
 /*
@@ -913,6 +915,10 @@ xfs_defer_init_item_caches(void)
 	error = xfs_attr_intent_init_cache();
 	if (error)
 		goto err;
+	error = xfs_swapext_intent_init_cache();
+	if (error)
+		goto err;
+
 	return 0;
 err:
 	xfs_defer_destroy_item_caches();
@@ -923,6 +929,7 @@ xfs_defer_init_item_caches(void)
 void
 xfs_defer_destroy_item_caches(void)
 {
+	xfs_swapext_intent_destroy_cache();
 	xfs_attr_intent_destroy_cache();
 	xfs_extfree_intent_destroy_cache();
 	xfs_bmap_intent_destroy_cache();
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index 114a3a4930a3..bcc48b0c75c9 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -20,6 +20,7 @@ enum xfs_defer_ops_type {
 	XFS_DEFER_OPS_TYPE_FREE,
 	XFS_DEFER_OPS_TYPE_AGFL_FREE,
 	XFS_DEFER_OPS_TYPE_ATTR,
+	XFS_DEFER_OPS_TYPE_SWAPEXT,
 	XFS_DEFER_OPS_TYPE_MAX,
 };
 
@@ -65,7 +66,7 @@ extern const struct xfs_defer_op_type xfs_rmap_update_defer_type;
 extern const struct xfs_defer_op_type xfs_extent_free_defer_type;
 extern const struct xfs_defer_op_type xfs_agfl_free_defer_type;
 extern const struct xfs_defer_op_type xfs_attr_defer_type;
-
+extern const struct xfs_defer_op_type xfs_swapext_defer_type;
 
 /*
  * Deferred operation item relogging limits.
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 1424976ec955..bb8bff488017 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -425,6 +425,12 @@ static inline bool xfs_sb_version_haslogxattrs(struct xfs_sb *sbp)
 		 XFS_SB_FEAT_INCOMPAT_LOG_XATTRS);
 }
 
+static inline bool xfs_sb_version_haslogswapext(struct xfs_sb *sbp)
+{
+	return xfs_sb_is_v5(sbp) && (sbp->sb_features_log_incompat &
+		 XFS_SB_FEAT_INCOMPAT_LOG_SWAPEXT);
+}
+
 static inline bool
 xfs_is_quota_inode(struct xfs_sb *sbp, xfs_ino_t ino)
 {
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index b105a5ef6644..171f72e41225 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -891,9 +891,36 @@ struct xfs_swap_extent {
 	int64_t			sx_isize2;
 };
 
-#define XFS_SWAP_EXT_FLAGS		(0)
+/* Swap extents between extended attribute forks. */
+#define XFS_SWAP_EXT_ATTR_FORK		(1ULL << 0)
 
-#define XFS_SWAP_EXT_STRINGS
+/* Set the file sizes when finished. */
+#define XFS_SWAP_EXT_SET_SIZES		(1ULL << 1)
+
+/*
+ * Swap only the extents of the two files where the file allocation units
+ * mapped to file1's range have been written to.
+ */
+#define XFS_SWAP_EXT_INO1_WRITTEN	(1ULL << 2)
+
+/* Clear the reflink flag from inode1 after the operation. */
+#define XFS_SWAP_EXT_CLEAR_INO1_REFLINK	(1ULL << 3)
+
+/* Clear the reflink flag from inode2 after the operation. */
+#define XFS_SWAP_EXT_CLEAR_INO2_REFLINK	(1ULL << 4)
+
+#define XFS_SWAP_EXT_FLAGS		(XFS_SWAP_EXT_ATTR_FORK | \
+					 XFS_SWAP_EXT_SET_SIZES | \
+					 XFS_SWAP_EXT_INO1_WRITTEN | \
+					 XFS_SWAP_EXT_CLEAR_INO1_REFLINK | \
+					 XFS_SWAP_EXT_CLEAR_INO2_REFLINK)
+
+#define XFS_SWAP_EXT_STRINGS \
+	{ XFS_SWAP_EXT_ATTR_FORK,		"ATTRFORK" }, \
+	{ XFS_SWAP_EXT_SET_SIZES,		"SETSIZES" }, \
+	{ XFS_SWAP_EXT_INO1_WRITTEN,		"INO1_WRITTEN" }, \
+	{ XFS_SWAP_EXT_CLEAR_INO1_REFLINK,	"CLEAR_INO1_REFLINK" }, \
+	{ XFS_SWAP_EXT_CLEAR_INO2_REFLINK,	"CLEAR_INO2_REFLINK" }
 
 /* This is the structure used to lay out an sxi log item in the log. */
 struct xfs_sxi_log_format {
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
new file mode 100644
index 000000000000..671dd8365a02
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -0,0 +1,1040 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_defer.h"
+#include "xfs_inode.h"
+#include "xfs_trans.h"
+#include "xfs_bmap.h"
+#include "xfs_icache.h"
+#include "xfs_quota.h"
+#include "xfs_swapext.h"
+#include "xfs_trace.h"
+#include "xfs_bmap_btree.h"
+#include "xfs_trans_space.h"
+#include "xfs_error.h"
+#include "xfs_errortag.h"
+#include "xfs_health.h"
+
+struct kmem_cache	*xfs_swapext_intent_cache;
+
+/* bmbt mappings adjacent to a pair of records. */
+struct xfs_swapext_adjacent {
+	struct xfs_bmbt_irec		left1;
+	struct xfs_bmbt_irec		right1;
+	struct xfs_bmbt_irec		left2;
+	struct xfs_bmbt_irec		right2;
+};
+
+#define ADJACENT_INIT { \
+	.left1  = { .br_startblock = HOLESTARTBLOCK }, \
+	.right1 = { .br_startblock = HOLESTARTBLOCK }, \
+	.left2  = { .br_startblock = HOLESTARTBLOCK }, \
+	.right2 = { .br_startblock = HOLESTARTBLOCK }, \
+}
+
+/* Information to help us reset reflink flag / CoW fork state after a swap. */
+
+/* Previous state of the two inodes' reflink flags. */
+#define XFS_REFLINK_STATE_IP1		(1U << 0)
+#define XFS_REFLINK_STATE_IP2		(1U << 1)
+
+/*
+ * If the reflink flag is set on either inode, make sure it has an incore CoW
+ * fork, since all reflink inodes must have them.  If there's a CoW fork and it
+ * has extents in it, make sure the inodes are tagged appropriately so that
+ * speculative preallocations can be GC'd if we run low of space.
+ */
+static inline void
+xfs_swapext_ensure_cowfork(
+	struct xfs_inode	*ip)
+{
+	struct xfs_ifork	*cfork;
+
+	if (xfs_is_reflink_inode(ip))
+		xfs_ifork_init_cow(ip);
+
+	cfork = xfs_ifork_ptr(ip, XFS_COW_FORK);
+	if (!cfork)
+		return;
+	if (cfork->if_bytes > 0)
+		xfs_inode_set_cowblocks_tag(ip);
+	else
+		xfs_inode_clear_cowblocks_tag(ip);
+}
+
+/* Schedule an atomic extent swap. */
+void
+xfs_swapext_schedule(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	trace_xfs_swapext_defer(tp->t_mountp, sxi);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_SWAPEXT, &sxi->sxi_list);
+}
+
+/*
+ * Adjust the on-disk inode size upwards if needed so that we never map extents
+ * into the file past EOF.  This is crucial so that log recovery won't get
+ * confused by the sudden appearance of post-eof extents.
+ */
+STATIC void
+xfs_swapext_update_size(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fsize_t		new_isize)
+{
+	struct xfs_mount	*mp = tp->t_mountp;
+	xfs_fsize_t		len;
+
+	if (new_isize < 0)
+		return;
+
+	len = min(XFS_FSB_TO_B(mp, imap->br_startoff + imap->br_blockcount),
+		  new_isize);
+
+	if (len <= ip->i_disk_size)
+		return;
+
+	trace_xfs_swapext_update_inode_size(ip, len);
+
+	ip->i_disk_size = len;
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+}
+
+static inline bool
+sxi_has_more_swap_work(const struct xfs_swapext_intent *sxi)
+{
+	return sxi->sxi_blockcount > 0;
+}
+
+static inline bool
+sxi_has_postop_work(const struct xfs_swapext_intent *sxi)
+{
+	return sxi->sxi_flags & (XFS_SWAP_EXT_CLEAR_INO1_REFLINK |
+				 XFS_SWAP_EXT_CLEAR_INO2_REFLINK);
+}
+
+static inline void
+sxi_advance(
+	struct xfs_swapext_intent	*sxi,
+	const struct xfs_bmbt_irec	*irec)
+{
+	sxi->sxi_startoff1 += irec->br_blockcount;
+	sxi->sxi_startoff2 += irec->br_blockcount;
+	sxi->sxi_blockcount -= irec->br_blockcount;
+}
+
+/* Check all extents to make sure we can actually swap them. */
+int
+xfs_swapext_check_extents(
+	struct xfs_mount		*mp,
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_ifork		*ifp1, *ifp2;
+
+	/* No fork? */
+	ifp1 = xfs_ifork_ptr(req->ip1, req->whichfork);
+	ifp2 = xfs_ifork_ptr(req->ip2, req->whichfork);
+	if (!ifp1 || !ifp2)
+		return -EINVAL;
+
+	/* We don't know how to swap local format forks. */
+	if (ifp1->if_format == XFS_DINODE_FMT_LOCAL ||
+	    ifp2->if_format == XFS_DINODE_FMT_LOCAL)
+		return -EINVAL;
+
+	/* We don't support realtime data forks yet. */
+	if (!XFS_IS_REALTIME_INODE(req->ip1))
+		return 0;
+	if (req->whichfork == XFS_ATTR_FORK)
+		return 0;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_XFS_QUOTA
+/* Log the actual updates to the quota accounting. */
+static inline void
+xfs_swapext_update_quota(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_bmbt_irec		*irec1,
+	struct xfs_bmbt_irec		*irec2)
+{
+	int64_t				ip1_delta = 0, ip2_delta = 0;
+	unsigned int			qflag;
+
+	qflag = XFS_IS_REALTIME_INODE(sxi->sxi_ip1) ? XFS_TRANS_DQ_RTBCOUNT :
+						      XFS_TRANS_DQ_BCOUNT;
+
+	if (xfs_bmap_is_real_extent(irec1)) {
+		ip1_delta -= irec1->br_blockcount;
+		ip2_delta += irec1->br_blockcount;
+	}
+
+	if (xfs_bmap_is_real_extent(irec2)) {
+		ip1_delta += irec2->br_blockcount;
+		ip2_delta -= irec2->br_blockcount;
+	}
+
+	xfs_trans_mod_dquot_byino(tp, sxi->sxi_ip1, qflag, ip1_delta);
+	xfs_trans_mod_dquot_byino(tp, sxi->sxi_ip2, qflag, ip2_delta);
+}
+#else
+# define xfs_swapext_update_quota(tp, sxi, irec1, irec2)	((void)0)
+#endif
+
+/* Decide if we want to skip this mapping from file1. */
+static inline bool
+xfs_swapext_can_skip_mapping(
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_bmbt_irec		*irec)
+{
+	/* Do not skip this mapping if the caller did not tell us to. */
+	if (!(sxi->sxi_flags & XFS_SWAP_EXT_INO1_WRITTEN))
+		return false;
+
+	/* Do not skip mapped, written extents. */
+	if (xfs_bmap_is_written_extent(irec))
+		return false;
+
+	/*
+	 * The mapping is unwritten or a hole.  It cannot be a delalloc
+	 * reservation because we already excluded those.  It cannot be an
+	 * unwritten extent with dirty page cache because we flushed the page
+	 * cache.  We don't support realtime files yet, so we needn't (yet)
+	 * deal with them.
+	 */
+	return true;
+}
+
+/*
+ * Walk forward through the file ranges in @sxi until we find two different
+ * mappings to exchange.  If there is work to do, return the mappings;
+ * otherwise we've reached the end of the range and sxi_blockcount will be
+ * zero.
+ *
+ * If the walk skips over a pair of mappings to the same storage, save them as
+ * the left records in @adj (if provided) so that the simulation phase can
+ * avoid an extra lookup.
+  */
+static int
+xfs_swapext_find_mappings(
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_bmbt_irec		*irec1,
+	struct xfs_bmbt_irec		*irec2,
+	struct xfs_swapext_adjacent	*adj)
+{
+	int				nimaps;
+	int				bmap_flags;
+	int				error;
+
+	bmap_flags = xfs_bmapi_aflag(xfs_swapext_whichfork(sxi));
+
+	for (; sxi_has_more_swap_work(sxi); sxi_advance(sxi, irec1)) {
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->sxi_ip1, sxi->sxi_startoff1,
+				sxi->sxi_blockcount, irec1, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec1->br_startblock == DELAYSTARTBLOCK ||
+		    irec1->br_startoff != sxi->sxi_startoff1) {
+			/*
+			 * We should never get no mapping or a delalloc extent
+			 * or something that doesn't match what we asked for,
+			 * since the caller flushed both inodes and we hold the
+			 * ILOCKs for both inodes.
+			 */
+			ASSERT(0);
+			return -EINVAL;
+		}
+
+		if (xfs_swapext_can_skip_mapping(sxi, irec1)) {
+			trace_xfs_swapext_extent1_skip(sxi->sxi_ip1, irec1);
+			continue;
+		}
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->sxi_ip2, sxi->sxi_startoff2,
+				irec1->br_blockcount, irec2, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec2->br_startblock == DELAYSTARTBLOCK ||
+		    irec2->br_startoff != sxi->sxi_startoff2) {
+			/*
+			 * We should never get no mapping or a delalloc extent
+			 * or something that doesn't match what we asked for,
+			 * since the caller flushed both inodes and we hold the
+			 * ILOCKs for both inodes.
+			 */
+			ASSERT(0);
+			return -EINVAL;
+		}
+
+		/*
+		 * We can only swap as many blocks as the smaller of the two
+		 * extent maps.
+		 */
+		irec1->br_blockcount = min(irec1->br_blockcount,
+					   irec2->br_blockcount);
+
+		trace_xfs_swapext_extent1(sxi->sxi_ip1, irec1);
+		trace_xfs_swapext_extent2(sxi->sxi_ip2, irec2);
+
+		/* We found something to swap, so return it. */
+		if (irec1->br_startblock != irec2->br_startblock)
+			return 0;
+
+		/*
+		 * Two extents mapped to the same physical block must not have
+		 * different states; that's filesystem corruption.  Move on to
+		 * the next extent if they're both holes or both the same
+		 * physical extent.
+		 */
+		if (irec1->br_state != irec2->br_state) {
+			xfs_bmap_mark_sick(sxi->sxi_ip1,
+					xfs_swapext_whichfork(sxi));
+			xfs_bmap_mark_sick(sxi->sxi_ip2,
+					xfs_swapext_whichfork(sxi));
+			return -EFSCORRUPTED;
+		}
+
+		/*
+		 * Save the mappings if we're estimating work and skipping
+		 * these identical mappings.
+		 */
+		if (adj) {
+			memcpy(&adj->left1, irec1, sizeof(*irec1));
+			memcpy(&adj->left2, irec2, sizeof(*irec2));
+		}
+	}
+
+	return 0;
+}
+
+/* Exchange these two mappings. */
+static void
+xfs_swapext_exchange_mappings(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_bmbt_irec		*irec1,
+	struct xfs_bmbt_irec		*irec2)
+{
+	int				whichfork = xfs_swapext_whichfork(sxi);
+
+	xfs_swapext_update_quota(tp, sxi, irec1, irec2);
+
+	/* Remove both mappings. */
+	xfs_bmap_unmap_extent(tp, sxi->sxi_ip1, whichfork, irec1);
+	xfs_bmap_unmap_extent(tp, sxi->sxi_ip2, whichfork, irec2);
+
+	/*
+	 * Re-add both mappings.  We swap the file offsets between the two maps
+	 * and add the opposite map, which has the effect of filling the
+	 * logical offsets we just unmapped, but with with the physical mapping
+	 * information swapped.
+	 */
+	swap(irec1->br_startoff, irec2->br_startoff);
+	xfs_bmap_map_extent(tp, sxi->sxi_ip1, whichfork, irec2);
+	xfs_bmap_map_extent(tp, sxi->sxi_ip2, whichfork, irec1);
+
+	/* Make sure we're not mapping extents past EOF. */
+	if (whichfork == XFS_DATA_FORK) {
+		xfs_swapext_update_size(tp, sxi->sxi_ip1, irec2,
+				sxi->sxi_isize1);
+		xfs_swapext_update_size(tp, sxi->sxi_ip2, irec1,
+				sxi->sxi_isize2);
+	}
+
+	/*
+	 * Advance our cursor and exit.   The caller (either defer ops or log
+	 * recovery) will log the SXD item, and if *blockcount is nonzero, it
+	 * will log a new SXI item for the remainder and call us back.
+	 */
+	sxi_advance(sxi, irec1);
+}
+
+static inline void
+xfs_swapext_clear_reflink(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip)
+{
+	trace_xfs_reflink_unset_inode_flag(ip);
+
+	ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+}
+
+/* Finish whatever work might come after a swap operation. */
+static int
+xfs_swapext_do_postop_work(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	if (sxi->sxi_flags & XFS_SWAP_EXT_CLEAR_INO1_REFLINK) {
+		xfs_swapext_clear_reflink(tp, sxi->sxi_ip1);
+		sxi->sxi_flags &= ~XFS_SWAP_EXT_CLEAR_INO1_REFLINK;
+	}
+
+	if (sxi->sxi_flags & XFS_SWAP_EXT_CLEAR_INO2_REFLINK) {
+		xfs_swapext_clear_reflink(tp, sxi->sxi_ip2);
+		sxi->sxi_flags &= ~XFS_SWAP_EXT_CLEAR_INO2_REFLINK;
+	}
+
+	return 0;
+}
+
+/* Finish one extent swap, possibly log more. */
+int
+xfs_swapext_finish_one(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_bmbt_irec		irec1, irec2;
+	int				error;
+
+	if (sxi_has_more_swap_work(sxi)) {
+		/*
+		 * If the operation state says that some range of the files
+		 * have not yet been swapped, look for extents in that range to
+		 * swap.  If we find some extents, swap them.
+		 */
+		error = xfs_swapext_find_mappings(sxi, &irec1, &irec2, NULL);
+		if (error)
+			return error;
+
+		if (sxi_has_more_swap_work(sxi))
+			xfs_swapext_exchange_mappings(tp, sxi, &irec1, &irec2);
+
+		/*
+		 * If the caller asked us to exchange the file sizes after the
+		 * swap and either we just swapped the last extents in the
+		 * range or we didn't find anything to swap, update the ondisk
+		 * file sizes.
+		 */
+		if ((sxi->sxi_flags & XFS_SWAP_EXT_SET_SIZES) &&
+		    !sxi_has_more_swap_work(sxi)) {
+			sxi->sxi_ip1->i_disk_size = sxi->sxi_isize1;
+			sxi->sxi_ip2->i_disk_size = sxi->sxi_isize2;
+
+			xfs_trans_log_inode(tp, sxi->sxi_ip1, XFS_ILOG_CORE);
+			xfs_trans_log_inode(tp, sxi->sxi_ip2, XFS_ILOG_CORE);
+		}
+	} else if (sxi_has_postop_work(sxi)) {
+		/*
+		 * Now that we're finished with the swap operation, complete
+		 * the post-op cleanup work.
+		 */
+		error = xfs_swapext_do_postop_work(tp, sxi);
+		if (error)
+			return error;
+	}
+
+	/* If we still have work to do, ask for a new transaction. */
+	if (sxi_has_more_swap_work(sxi) || sxi_has_postop_work(sxi)) {
+		trace_xfs_swapext_defer(tp->t_mountp, sxi);
+		return -EAGAIN;
+	}
+
+	/*
+	 * If we reach here, we've finished all the swapping work and the post
+	 * operation work.  The last thing we need to do before returning to
+	 * the caller is to make sure that COW forks are set up correctly.
+	 */
+	if (!(sxi->sxi_flags & XFS_SWAP_EXT_ATTR_FORK)) {
+		xfs_swapext_ensure_cowfork(sxi->sxi_ip1);
+		xfs_swapext_ensure_cowfork(sxi->sxi_ip2);
+	}
+
+	return 0;
+}
+
+/*
+ * Compute the amount of bmbt blocks we should reserve for each file.  In the
+ * worst case, each exchange will fill a hole with a new mapping, which could
+ * result in a btree split every time we add a new leaf block.
+ */
+static inline uint64_t
+xfs_swapext_bmbt_blocks(
+	struct xfs_mount		*mp,
+	const struct xfs_swapext_req	*req)
+{
+	return howmany_64(req->nr_exchanges,
+					XFS_MAX_CONTIG_BMAPS_PER_BLOCK(mp)) *
+			XFS_EXTENTADD_SPACE_RES(mp, req->whichfork);
+}
+
+static inline uint64_t
+xfs_swapext_rmapbt_blocks(
+	struct xfs_mount		*mp,
+	const struct xfs_swapext_req	*req)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	if (XFS_IS_REALTIME_INODE(req->ip1))
+		return 0;
+
+	return howmany_64(req->nr_exchanges,
+					XFS_MAX_CONTIG_RMAPS_PER_BLOCK(mp)) *
+			XFS_RMAPADD_SPACE_RES(mp);
+}
+
+/* Estimate the bmbt and rmapbt overhead required to exchange extents. */
+static int
+xfs_swapext_estimate_overhead(
+	struct xfs_swapext_req	*req)
+{
+	struct xfs_mount	*mp = req->ip1->i_mount;
+	xfs_filblks_t		bmbt_blocks;
+	xfs_filblks_t		rmapbt_blocks;
+	xfs_filblks_t		resblks = req->resblks;
+
+	/*
+	 * Compute the number of bmbt and rmapbt blocks we might need to handle
+	 * the estimated number of exchanges.
+	 */
+	bmbt_blocks = xfs_swapext_bmbt_blocks(mp, req);
+	rmapbt_blocks = xfs_swapext_rmapbt_blocks(mp, req);
+
+	trace_xfs_swapext_overhead(mp, bmbt_blocks, rmapbt_blocks);
+
+	/* Make sure the change in file block count doesn't overflow. */
+	if (check_add_overflow(req->ip1_bcount, bmbt_blocks, &req->ip1_bcount))
+		return -EFBIG;
+	if (check_add_overflow(req->ip2_bcount, bmbt_blocks, &req->ip2_bcount))
+		return -EFBIG;
+
+	/*
+	 * Add together the number of blocks we need to handle btree growth,
+	 * then add it to the number of blocks we need to reserve to this
+	 * transaction.
+	 */
+	if (check_add_overflow(resblks, bmbt_blocks, &resblks))
+		return -ENOSPC;
+	if (check_add_overflow(resblks, bmbt_blocks, &resblks))
+		return -ENOSPC;
+	if (check_add_overflow(resblks, rmapbt_blocks, &resblks))
+		return -ENOSPC;
+	if (check_add_overflow(resblks, rmapbt_blocks, &resblks))
+		return -ENOSPC;
+
+	/* Can't actually reserve more than UINT_MAX blocks. */
+	if (req->resblks > UINT_MAX)
+		return -ENOSPC;
+
+	req->resblks = resblks;
+	trace_xfs_swapext_final_estimate(req);
+	return 0;
+}
+
+/* Decide if we can merge two real extents. */
+static inline bool
+can_merge(
+	const struct xfs_bmbt_irec	*b1,
+	const struct xfs_bmbt_irec	*b2)
+{
+	/* Don't merge holes. */
+	if (b1->br_startblock == HOLESTARTBLOCK ||
+	    b2->br_startblock == HOLESTARTBLOCK)
+		return false;
+
+	/* We don't merge holes. */
+	if (!xfs_bmap_is_real_extent(b1) || !xfs_bmap_is_real_extent(b2))
+		return false;
+
+	if (b1->br_startoff   + b1->br_blockcount == b2->br_startoff &&
+	    b1->br_startblock + b1->br_blockcount == b2->br_startblock &&
+	    b1->br_state			  == b2->br_state &&
+	    b1->br_blockcount + b2->br_blockcount <= XFS_MAX_BMBT_EXTLEN)
+		return true;
+
+	return false;
+}
+
+#define CLEFT_CONTIG	0x01
+#define CRIGHT_CONTIG	0x02
+#define CHOLE		0x04
+#define CBOTH_CONTIG	(CLEFT_CONTIG | CRIGHT_CONTIG)
+
+#define NLEFT_CONTIG	0x10
+#define NRIGHT_CONTIG	0x20
+#define NHOLE		0x40
+#define NBOTH_CONTIG	(NLEFT_CONTIG | NRIGHT_CONTIG)
+
+/* Estimate the effect of a single swap on extent count. */
+static inline int
+delta_nextents_step(
+	struct xfs_mount		*mp,
+	const struct xfs_bmbt_irec	*left,
+	const struct xfs_bmbt_irec	*curr,
+	const struct xfs_bmbt_irec	*new,
+	const struct xfs_bmbt_irec	*right)
+{
+	bool				lhole, rhole, chole, nhole;
+	unsigned int			state = 0;
+	int				ret = 0;
+
+	lhole = left->br_startblock == HOLESTARTBLOCK;
+	rhole = right->br_startblock == HOLESTARTBLOCK;
+	chole = curr->br_startblock == HOLESTARTBLOCK;
+	nhole = new->br_startblock == HOLESTARTBLOCK;
+
+	if (chole)
+		state |= CHOLE;
+	if (!lhole && !chole && can_merge(left, curr))
+		state |= CLEFT_CONTIG;
+	if (!rhole && !chole && can_merge(curr, right))
+		state |= CRIGHT_CONTIG;
+	if ((state & CBOTH_CONTIG) == CBOTH_CONTIG &&
+	    left->br_startblock + curr->br_startblock +
+					right->br_startblock > XFS_MAX_BMBT_EXTLEN)
+		state &= ~CRIGHT_CONTIG;
+
+	if (nhole)
+		state |= NHOLE;
+	if (!lhole && !nhole && can_merge(left, new))
+		state |= NLEFT_CONTIG;
+	if (!rhole && !nhole && can_merge(new, right))
+		state |= NRIGHT_CONTIG;
+	if ((state & NBOTH_CONTIG) == NBOTH_CONTIG &&
+	    left->br_startblock + new->br_startblock +
+					right->br_startblock > XFS_MAX_BMBT_EXTLEN)
+		state &= ~NRIGHT_CONTIG;
+
+	switch (state & (CLEFT_CONTIG | CRIGHT_CONTIG | CHOLE)) {
+	case CLEFT_CONTIG | CRIGHT_CONTIG:
+		/*
+		 * left/curr/right are the same extent, so deleting curr causes
+		 * 2 new extents to be created.
+		 */
+		ret += 2;
+		break;
+	case 0:
+		/*
+		 * curr is not contiguous with any extent, so we remove curr
+		 * completely
+		 */
+		ret--;
+		break;
+	case CHOLE:
+		/* hole, do nothing */
+		break;
+	case CLEFT_CONTIG:
+	case CRIGHT_CONTIG:
+		/* trim either left or right, no change */
+		break;
+	}
+
+	switch (state & (NLEFT_CONTIG | NRIGHT_CONTIG | NHOLE)) {
+	case NLEFT_CONTIG | NRIGHT_CONTIG:
+		/*
+		 * left/curr/right will become the same extent, so adding
+		 * curr causes the deletion of right.
+		 */
+		ret--;
+		break;
+	case 0:
+		/* new is not contiguous with any extent */
+		ret++;
+		break;
+	case NHOLE:
+		/* hole, do nothing. */
+		break;
+	case NLEFT_CONTIG:
+	case NRIGHT_CONTIG:
+		/* new is absorbed into left or right, no change */
+		break;
+	}
+
+	trace_xfs_swapext_delta_nextents_step(mp, left, curr, new, right, ret,
+			state);
+	return ret;
+}
+
+/* Make sure we don't overflow the extent counters. */
+static inline int
+ensure_delta_nextents(
+	struct xfs_swapext_req	*req,
+	struct xfs_inode	*ip,
+	int64_t			delta)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, req->whichfork);
+	xfs_extnum_t		max_extents;
+	bool			large_extcount;
+
+	if (delta < 0)
+		return 0;
+
+	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_REDUCE_MAX_IEXTENTS)) {
+		if (ifp->if_nextents + delta > 10)
+			return -EFBIG;
+	}
+
+	if (req->req_flags & XFS_SWAP_REQ_NREXT64)
+		large_extcount = true;
+	else
+		large_extcount = xfs_inode_has_large_extent_counts(ip);
+
+	max_extents = xfs_iext_max_nextents(large_extcount, req->whichfork);
+	if (ifp->if_nextents + delta <= max_extents)
+		return 0;
+	if (large_extcount)
+		return -EFBIG;
+	if (!xfs_has_large_extent_counts(mp))
+		return -EFBIG;
+
+	max_extents = xfs_iext_max_nextents(true, req->whichfork);
+	if (ifp->if_nextents + delta > max_extents)
+		return -EFBIG;
+
+	req->req_flags |= XFS_SWAP_REQ_NREXT64;
+	return 0;
+}
+
+/* Find the next extent after irec. */
+static inline int
+get_next_ext(
+	struct xfs_inode		*ip,
+	int				bmap_flags,
+	const struct xfs_bmbt_irec	*irec,
+	struct xfs_bmbt_irec		*nrec)
+{
+	xfs_fileoff_t			off;
+	xfs_filblks_t			blockcount;
+	int				nimaps = 1;
+	int				error;
+
+	off = irec->br_startoff + irec->br_blockcount;
+	blockcount = XFS_MAX_FILEOFF - off;
+	error = xfs_bmapi_read(ip, off, blockcount, nrec, &nimaps, bmap_flags);
+	if (error)
+		return error;
+	if (nrec->br_startblock == DELAYSTARTBLOCK ||
+	    nrec->br_startoff != off) {
+		/*
+		 * If we don't get the extent we want, return a zero-length
+		 * mapping, which our estimator function will pretend is a hole.
+		 * We shouldn't get delalloc reservations.
+		 */
+		nrec->br_startblock = HOLESTARTBLOCK;
+	}
+
+	return 0;
+}
+
+int __init
+xfs_swapext_intent_init_cache(void)
+{
+	xfs_swapext_intent_cache = kmem_cache_create("xfs_swapext_intent",
+			sizeof(struct xfs_swapext_intent),
+			0, 0, NULL);
+
+	return xfs_swapext_intent_cache != NULL ? 0 : -ENOMEM;
+}
+
+void
+xfs_swapext_intent_destroy_cache(void)
+{
+	kmem_cache_destroy(xfs_swapext_intent_cache);
+	xfs_swapext_intent_cache = NULL;
+}
+
+/*
+ * Decide if we will swap the reflink flags between the two files after the
+ * swap.  The only time we want to do this is if we're exchanging all extents
+ * under EOF and the inode reflink flags have different states.
+ */
+static inline bool
+sxi_can_exchange_reflink_flags(
+	const struct xfs_swapext_req	*req,
+	unsigned int			reflink_state)
+{
+	struct xfs_mount		*mp = req->ip1->i_mount;
+
+	if (hweight32(reflink_state) != 1)
+		return false;
+	if (req->startoff1 != 0 || req->startoff2 != 0)
+		return false;
+	if (req->blockcount != XFS_B_TO_FSB(mp, req->ip1->i_disk_size))
+		return false;
+	if (req->blockcount != XFS_B_TO_FSB(mp, req->ip2->i_disk_size))
+		return false;
+	return true;
+}
+
+
+/* Allocate and initialize a new incore intent item from a request. */
+struct xfs_swapext_intent *
+xfs_swapext_init_intent(
+	const struct xfs_swapext_req	*req,
+	unsigned int			*reflink_state)
+{
+	struct xfs_swapext_intent	*sxi;
+	unsigned int			rs = 0;
+
+	sxi = kmem_cache_zalloc(xfs_swapext_intent_cache,
+			GFP_NOFS | __GFP_NOFAIL);
+	INIT_LIST_HEAD(&sxi->sxi_list);
+	sxi->sxi_ip1 = req->ip1;
+	sxi->sxi_ip2 = req->ip2;
+	sxi->sxi_startoff1 = req->startoff1;
+	sxi->sxi_startoff2 = req->startoff2;
+	sxi->sxi_blockcount = req->blockcount;
+	sxi->sxi_isize1 = sxi->sxi_isize2 = -1;
+
+	if (req->whichfork == XFS_ATTR_FORK)
+		sxi->sxi_flags |= XFS_SWAP_EXT_ATTR_FORK;
+
+	if (req->whichfork == XFS_DATA_FORK &&
+	    (req->req_flags & XFS_SWAP_REQ_SET_SIZES)) {
+		sxi->sxi_flags |= XFS_SWAP_EXT_SET_SIZES;
+		sxi->sxi_isize1 = req->ip2->i_disk_size;
+		sxi->sxi_isize2 = req->ip1->i_disk_size;
+	}
+
+	if (req->req_flags & XFS_SWAP_REQ_INO1_WRITTEN)
+		sxi->sxi_flags |= XFS_SWAP_EXT_INO1_WRITTEN;
+
+	if (req->req_flags & XFS_SWAP_REQ_LOGGED)
+		sxi->sxi_op_flags |= XFS_SWAP_EXT_OP_LOGGED;
+	if (req->req_flags & XFS_SWAP_REQ_NREXT64)
+		sxi->sxi_op_flags |= XFS_SWAP_EXT_OP_NREXT64;
+
+	if (req->whichfork == XFS_DATA_FORK) {
+		/*
+		 * Record the state of each inode's reflink flag before the
+		 * operation.
+		 */
+		if (xfs_is_reflink_inode(req->ip1))
+			rs |= XFS_REFLINK_STATE_IP1;
+		if (xfs_is_reflink_inode(req->ip2))
+			rs |= XFS_REFLINK_STATE_IP2;
+
+		/*
+		 * Figure out if we're clearing the reflink flags (which
+		 * effectively swaps them) after the operation.
+		 */
+		if (sxi_can_exchange_reflink_flags(req, rs)) {
+			if (rs & XFS_REFLINK_STATE_IP1)
+				sxi->sxi_flags |=
+						XFS_SWAP_EXT_CLEAR_INO1_REFLINK;
+			if (rs & XFS_REFLINK_STATE_IP2)
+				sxi->sxi_flags |=
+						XFS_SWAP_EXT_CLEAR_INO2_REFLINK;
+		}
+	}
+
+	if (reflink_state)
+		*reflink_state = rs;
+	return sxi;
+}
+
+/*
+ * Estimate the number of exchange operations and the number of file blocks
+ * in each file that will be affected by the exchange operation.
+ */
+int
+xfs_swapext_estimate(
+	struct xfs_swapext_req		*req)
+{
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_bmbt_irec		irec1, irec2;
+	struct xfs_swapext_adjacent	adj = ADJACENT_INIT;
+	xfs_filblks_t			ip1_blocks = 0, ip2_blocks = 0;
+	int64_t				d_nexts1, d_nexts2;
+	int				bmap_flags;
+	int				error;
+
+	ASSERT(!(req->req_flags & ~XFS_SWAP_REQ_FLAGS));
+
+	bmap_flags = xfs_bmapi_aflag(req->whichfork);
+	sxi = xfs_swapext_init_intent(req, NULL);
+
+	/*
+	 * To guard against the possibility of overflowing the extent counters,
+	 * we have to estimate an upper bound on the potential increase in that
+	 * counter.  We can split the extent at each end of the range, and for
+	 * each step of the swap we can split the extent that we're working on
+	 * if the extents do not align.
+	 */
+	d_nexts1 = d_nexts2 = 3;
+
+	while (sxi_has_more_swap_work(sxi)) {
+		/*
+		 * Walk through the file ranges until we find something to
+		 * swap.  Because we're simulating the swap, pass in adj to
+		 * capture skipped mappings for correct estimation of bmbt
+		 * record merges.
+		 */
+		error = xfs_swapext_find_mappings(sxi, &irec1, &irec2, &adj);
+		if (error)
+			goto out_free;
+		if (!sxi_has_more_swap_work(sxi))
+			break;
+
+		/* Update accounting. */
+		if (xfs_bmap_is_real_extent(&irec1))
+			ip1_blocks += irec1.br_blockcount;
+		if (xfs_bmap_is_real_extent(&irec2))
+			ip2_blocks += irec2.br_blockcount;
+		req->nr_exchanges++;
+
+		/* Read the next extents from both files. */
+		error = get_next_ext(req->ip1, bmap_flags, &irec1, &adj.right1);
+		if (error)
+			goto out_free;
+
+		error = get_next_ext(req->ip2, bmap_flags, &irec2, &adj.right2);
+		if (error)
+			goto out_free;
+
+		/* Update extent count deltas. */
+		d_nexts1 += delta_nextents_step(req->ip1->i_mount,
+				&adj.left1, &irec1, &irec2, &adj.right1);
+
+		d_nexts2 += delta_nextents_step(req->ip1->i_mount,
+				&adj.left2, &irec2, &irec1, &adj.right2);
+
+		/* Now pretend we swapped the extents. */
+		if (can_merge(&adj.left2, &irec1))
+			adj.left2.br_blockcount += irec1.br_blockcount;
+		else
+			memcpy(&adj.left2, &irec1, sizeof(irec1));
+
+		if (can_merge(&adj.left1, &irec2))
+			adj.left1.br_blockcount += irec2.br_blockcount;
+		else
+			memcpy(&adj.left1, &irec2, sizeof(irec2));
+
+		sxi_advance(sxi, &irec1);
+	}
+
+	/* Account for the blocks that are being exchanged. */
+	if (XFS_IS_REALTIME_INODE(req->ip1) &&
+	    req->whichfork == XFS_DATA_FORK) {
+		req->ip1_rtbcount = ip1_blocks;
+		req->ip2_rtbcount = ip2_blocks;
+	} else {
+		req->ip1_bcount = ip1_blocks;
+		req->ip2_bcount = ip2_blocks;
+	}
+
+	/*
+	 * Make sure that both forks have enough slack left in their extent
+	 * counters that the swap operation will not overflow.
+	 */
+	trace_xfs_swapext_delta_nextents(req, d_nexts1, d_nexts2);
+	if (req->ip1 == req->ip2) {
+		error = ensure_delta_nextents(req, req->ip1,
+				d_nexts1 + d_nexts2);
+	} else {
+		error = ensure_delta_nextents(req, req->ip1, d_nexts1);
+		if (error)
+			goto out_free;
+		error = ensure_delta_nextents(req, req->ip2, d_nexts2);
+	}
+	if (error)
+		goto out_free;
+
+	trace_xfs_swapext_initial_estimate(req);
+	error = xfs_swapext_estimate_overhead(req);
+out_free:
+	kmem_cache_free(xfs_swapext_intent_cache, sxi);
+	return error;
+}
+
+static inline void
+xfs_swapext_set_reflink(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip)
+{
+	trace_xfs_reflink_set_inode_flag(ip);
+
+	ip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+}
+
+/*
+ * If either file has shared blocks and we're swapping data forks, we must flag
+ * the other file as having shared blocks so that we get the shared-block rmap
+ * functions if we need to fix up the rmaps.
+ */
+void
+xfs_swapext_ensure_reflink(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_intent	*sxi,
+	unsigned int			reflink_state)
+{
+	if ((reflink_state & XFS_REFLINK_STATE_IP1) &&
+	    !xfs_is_reflink_inode(sxi->sxi_ip2))
+		xfs_swapext_set_reflink(tp, sxi->sxi_ip2);
+
+	if ((reflink_state & XFS_REFLINK_STATE_IP2) &&
+	    !xfs_is_reflink_inode(sxi->sxi_ip1))
+		xfs_swapext_set_reflink(tp, sxi->sxi_ip1);
+}
+
+/* Widen the extent counts of both inodes if necessary. */
+static inline void
+xfs_swapext_upgrade_extent_counts(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_intent	*sxi)
+{
+	if (!(sxi->sxi_op_flags & XFS_SWAP_EXT_OP_NREXT64))
+		return;
+
+	sxi->sxi_ip1->i_diflags2 |= XFS_DIFLAG2_NREXT64;
+	xfs_trans_log_inode(tp, sxi->sxi_ip1, XFS_ILOG_CORE);
+
+	sxi->sxi_ip2->i_diflags2 |= XFS_DIFLAG2_NREXT64;
+	xfs_trans_log_inode(tp, sxi->sxi_ip2, XFS_ILOG_CORE);
+}
+
+/*
+ * Schedule a swap a range of extents from one inode to another.  If the atomic
+ * swap feature is enabled, then the operation progress can be resumed even if
+ * the system goes down.  The caller must commit the transaction to start the
+ * work.
+ *
+ * The caller must ensure the inodes must be joined to the transaction and
+ * ILOCKd; they will still be joined to the transaction at exit.
+ */
+void
+xfs_swapext(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_swapext_intent	*sxi;
+	unsigned int			reflink_state;
+
+	ASSERT(xfs_isilocked(req->ip1, XFS_ILOCK_EXCL));
+	ASSERT(xfs_isilocked(req->ip2, XFS_ILOCK_EXCL));
+	ASSERT(req->whichfork != XFS_COW_FORK);
+	ASSERT(!(req->req_flags & ~XFS_SWAP_REQ_FLAGS));
+	if (req->req_flags & XFS_SWAP_REQ_SET_SIZES)
+		ASSERT(req->whichfork == XFS_DATA_FORK);
+
+	if (req->blockcount == 0)
+		return;
+
+	sxi = xfs_swapext_init_intent(req, &reflink_state);
+	xfs_swapext_schedule(tp, sxi);
+	xfs_swapext_ensure_reflink(tp, sxi, reflink_state);
+	xfs_swapext_upgrade_extent_counts(tp, sxi);
+}
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index 6d17657cf1f6..7aa499537fd8 100644
--- a/fs/xfs/libxfs/xfs_swapext.h
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -21,4 +21,149 @@ static inline bool xfs_swapext_supported(struct xfs_mount *mp)
 	       !xfs_has_realtime(mp);
 }
 
+/*
+ * In-core information about an extent swap request between ranges of two
+ * inodes.
+ */
+struct xfs_swapext_intent {
+	/* List of other incore deferred work. */
+	struct list_head	sxi_list;
+
+	/* Inodes participating in the operation. */
+	struct xfs_inode	*sxi_ip1;
+	struct xfs_inode	*sxi_ip2;
+
+	/* File offset range information. */
+	xfs_fileoff_t		sxi_startoff1;
+	xfs_fileoff_t		sxi_startoff2;
+	xfs_filblks_t		sxi_blockcount;
+
+	/* Set these file sizes after the operation, unless negative. */
+	xfs_fsize_t		sxi_isize1;
+	xfs_fsize_t		sxi_isize2;
+
+	/* XFS_SWAP_EXT_* log operation flags */
+	unsigned int		sxi_flags;
+
+	/* XFS_SWAP_EXT_OP_* flags */
+	unsigned int		sxi_op_flags;
+};
+
+/* Use log intent items to track and restart the entire operation. */
+#define XFS_SWAP_EXT_OP_LOGGED	(1U << 0)
+
+/* Upgrade files to have large extent counts before proceeding. */
+#define XFS_SWAP_EXT_OP_NREXT64	(1U << 1)
+
+#define XFS_SWAP_EXT_OP_STRINGS \
+	{ XFS_SWAP_EXT_OP_LOGGED,		"LOGGED" }, \
+	{ XFS_SWAP_EXT_OP_NREXT64,		"NREXT64" }
+
+static inline int
+xfs_swapext_whichfork(const struct xfs_swapext_intent *sxi)
+{
+	if (sxi->sxi_flags & XFS_SWAP_EXT_ATTR_FORK)
+		return XFS_ATTR_FORK;
+	return XFS_DATA_FORK;
+}
+
+/* Parameters for a swapext request. */
+struct xfs_swapext_req {
+	/* Inodes participating in the operation. */
+	struct xfs_inode	*ip1;
+	struct xfs_inode	*ip2;
+
+	/* File offset range information. */
+	xfs_fileoff_t		startoff1;
+	xfs_fileoff_t		startoff2;
+	xfs_filblks_t		blockcount;
+
+	/* Data or attr fork? */
+	int			whichfork;
+
+	/* XFS_SWAP_REQ_* operation flags */
+	unsigned int		req_flags;
+
+	/*
+	 * Fields below this line are filled out by xfs_swapext_estimate;
+	 * callers should initialize this part of the struct to zero.
+	 */
+
+	/*
+	 * Data device blocks to be moved out of ip1, and free space needed to
+	 * handle the bmbt changes.
+	 */
+	xfs_filblks_t		ip1_bcount;
+
+	/*
+	 * Data device blocks to be moved out of ip2, and free space needed to
+	 * handle the bmbt changes.
+	 */
+	xfs_filblks_t		ip2_bcount;
+
+	/* rt blocks to be moved out of ip1. */
+	xfs_filblks_t		ip1_rtbcount;
+
+	/* rt blocks to be moved out of ip2. */
+	xfs_filblks_t		ip2_rtbcount;
+
+	/* Free space needed to handle the bmbt changes */
+	unsigned long long	resblks;
+
+	/* Number of extent swaps needed to complete the operation */
+	unsigned long long	nr_exchanges;
+};
+
+/* Caller has permission to use log intent items for the swapext operation. */
+#define XFS_SWAP_REQ_LOGGED		(1U << 0)
+
+/* Set the file sizes when finished. */
+#define XFS_SWAP_REQ_SET_SIZES		(1U << 1)
+
+/*
+ * Swap only the parts of the two files where the file allocation units
+ * mapped to file1's range have been written to.
+ */
+#define XFS_SWAP_REQ_INO1_WRITTEN	(1U << 2)
+
+/* Files need to be upgraded to have large extent counts. */
+#define XFS_SWAP_REQ_NREXT64		(1U << 3)
+
+#define XFS_SWAP_REQ_FLAGS		(XFS_SWAP_REQ_LOGGED | \
+					 XFS_SWAP_REQ_SET_SIZES | \
+					 XFS_SWAP_REQ_INO1_WRITTEN | \
+					 XFS_SWAP_REQ_NREXT64)
+
+#define XFS_SWAP_REQ_STRINGS \
+	{ XFS_SWAP_REQ_LOGGED,		"LOGGED" }, \
+	{ XFS_SWAP_REQ_SET_SIZES,	"SETSIZES" }, \
+	{ XFS_SWAP_REQ_INO1_WRITTEN,	"INO1_WRITTEN" }, \
+	{ XFS_SWAP_REQ_NREXT64,		"NREXT64" }
+
+unsigned int xfs_swapext_reflink_prep(const struct xfs_swapext_req *req);
+void xfs_swapext_reflink_finish(struct xfs_trans *tp,
+		const struct xfs_swapext_req *req, unsigned int reflink_state);
+
+int xfs_swapext_estimate(struct xfs_swapext_req *req);
+
+extern struct kmem_cache	*xfs_swapext_intent_cache;
+
+int __init xfs_swapext_intent_init_cache(void);
+void xfs_swapext_intent_destroy_cache(void);
+
+struct xfs_swapext_intent *xfs_swapext_init_intent(
+		const struct xfs_swapext_req *req, unsigned int *reflink_state);
+void xfs_swapext_ensure_reflink(struct xfs_trans *tp,
+		const struct xfs_swapext_intent *sxi, unsigned int reflink_state);
+
+void xfs_swapext_schedule(struct xfs_trans *tp,
+		struct xfs_swapext_intent *sxi);
+int xfs_swapext_finish_one(struct xfs_trans *tp,
+		struct xfs_swapext_intent *sxi);
+
+int xfs_swapext_check_extents(struct xfs_mount *mp,
+		const struct xfs_swapext_req *req);
+
+void xfs_swapext(struct xfs_trans *tp, const struct xfs_swapext_req *req);
+
 #endif /* __XFS_SWAPEXT_H_ */
diff --git a/fs/xfs/libxfs/xfs_trans_space.h b/fs/xfs/libxfs/xfs_trans_space.h
index 87b31c69a773..9640fc232c14 100644
--- a/fs/xfs/libxfs/xfs_trans_space.h
+++ b/fs/xfs/libxfs/xfs_trans_space.h
@@ -10,6 +10,10 @@
  * Components of space reservations.
  */
 
+/* Worst case number of bmaps that can be held in a block. */
+#define XFS_MAX_CONTIG_BMAPS_PER_BLOCK(mp)    \
+		(((mp)->m_bmap_dmxr[0]) - ((mp)->m_bmap_dmnr[0]))
+
 /* Worst case number of rmaps that can be held in a block. */
 #define XFS_MAX_CONTIG_RMAPS_PER_BLOCK(mp)    \
 		(((mp)->m_rmap_mxr[0]) - ((mp)->m_rmap_mnr[0]))
diff --git a/fs/xfs/xfs_swapext_item.c b/fs/xfs/xfs_swapext_item.c
index 87d1be73bbf9..e6faca45fc12 100644
--- a/fs/xfs/xfs_swapext_item.c
+++ b/fs/xfs/xfs_swapext_item.c
@@ -16,13 +16,17 @@
 #include "xfs_trans.h"
 #include "xfs_trans_priv.h"
 #include "xfs_swapext_item.h"
+#include "xfs_swapext.h"
 #include "xfs_log.h"
 #include "xfs_bmap.h"
 #include "xfs_icache.h"
+#include "xfs_bmap_btree.h"
 #include "xfs_trans_space.h"
 #include "xfs_error.h"
 #include "xfs_log_priv.h"
 #include "xfs_log_recover.h"
+#include "xfs_xchgrange.h"
+#include "xfs_trace.h"
 
 struct kmem_cache	*xfs_sxi_cache;
 struct kmem_cache	*xfs_sxd_cache;
@@ -144,13 +148,395 @@ static inline struct xfs_sxd_log_item *SXD_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_sxd_log_item, sxd_item);
 }
 
+STATIC void
+xfs_sxd_item_size(
+	struct xfs_log_item	*lip,
+	int			*nvecs,
+	int			*nbytes)
+{
+	*nvecs += 1;
+	*nbytes += sizeof(struct xfs_sxd_log_format);
+}
+
+/*
+ * This is called to fill in the vector of log iovecs for the given sxd log
+ * item. We use only 1 iovec, and we point that at the sxd_log_format structure
+ * embedded in the sxd item.
+ */
+STATIC void
+xfs_sxd_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_sxd_log_item	*sxd_lip = SXD_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	sxd_lip->sxd_format.sxd_type = XFS_LI_SXD;
+	sxd_lip->sxd_format.sxd_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_SXD_FORMAT, &sxd_lip->sxd_format,
+			sizeof(struct xfs_sxd_log_format));
+}
+
+/*
+ * The SXD is either committed or aborted if the transaction is cancelled. If
+ * the transaction is cancelled, drop our reference to the SXI and free the
+ * SXD.
+ */
+STATIC void
+xfs_sxd_item_release(
+	struct xfs_log_item	*lip)
+{
+	struct xfs_sxd_log_item	*sxd_lip = SXD_ITEM(lip);
+
+	kmem_free(sxd_lip->sxd_item.li_lv_shadow);
+	xfs_sxi_release(sxd_lip->sxd_intent_log_item);
+	kmem_cache_free(xfs_sxd_cache, sxd_lip);
+}
+
+static struct xfs_log_item *
+xfs_sxd_item_intent(
+	struct xfs_log_item	*lip)
+{
+	return &SXD_ITEM(lip)->sxd_intent_log_item->sxi_item;
+}
+
+static const struct xfs_item_ops xfs_sxd_item_ops = {
+	.flags		= XFS_ITEM_RELEASE_WHEN_COMMITTED |
+			  XFS_ITEM_INTENT_DONE,
+	.iop_size	= xfs_sxd_item_size,
+	.iop_format	= xfs_sxd_item_format,
+	.iop_release	= xfs_sxd_item_release,
+	.iop_intent	= xfs_sxd_item_intent,
+};
+
+static struct xfs_sxd_log_item *
+xfs_trans_get_sxd(
+	struct xfs_trans		*tp,
+	struct xfs_sxi_log_item		*sxi_lip)
+{
+	struct xfs_sxd_log_item		*sxd_lip;
+
+	sxd_lip = kmem_cache_zalloc(xfs_sxd_cache, GFP_KERNEL | __GFP_NOFAIL);
+	xfs_log_item_init(tp->t_mountp, &sxd_lip->sxd_item, XFS_LI_SXD,
+			  &xfs_sxd_item_ops);
+	sxd_lip->sxd_intent_log_item = sxi_lip;
+	sxd_lip->sxd_format.sxd_sxi_id = sxi_lip->sxi_format.sxi_id;
+
+	xfs_trans_add_item(tp, &sxd_lip->sxd_item);
+	return sxd_lip;
+}
+
+/*
+ * Finish an swapext update and log it to the SXD. Note that the transaction is
+ * marked dirty regardless of whether the swapext update succeeds or fails to
+ * support the SXI/SXD lifecycle rules.
+ */
+static int
+xfs_swapext_finish_update(
+	struct xfs_trans		*tp,
+	struct xfs_log_item		*done,
+	struct xfs_swapext_intent	*sxi)
+{
+	int				error;
+
+	error = xfs_swapext_finish_one(tp, sxi);
+
+	/*
+	 * Mark the transaction dirty, even on error. This ensures the
+	 * transaction is aborted, which:
+	 *
+	 * 1.) releases the SXI and frees the SXD
+	 * 2.) shuts down the filesystem
+	 */
+	tp->t_flags |= XFS_TRANS_DIRTY;
+	if (done)
+		set_bit(XFS_LI_DIRTY, &done->li_flags);
+
+	return error;
+}
+
+/* Log swapext updates in the intent item. */
+STATIC struct xfs_log_item *
+xfs_swapext_create_intent(
+	struct xfs_trans		*tp,
+	struct list_head		*items,
+	unsigned int			count,
+	bool				sort)
+{
+	struct xfs_sxi_log_item		*sxi_lip;
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_swap_extent		*sx;
+
+	ASSERT(count == 1);
+
+	sxi = list_first_entry_or_null(items, struct xfs_swapext_intent,
+			sxi_list);
+
+	/*
+	 * We use the same defer ops control machinery to perform extent swaps
+	 * even if we aren't using the machinery to track the operation status
+	 * through log items.
+	 */
+	if (!(sxi->sxi_op_flags & XFS_SWAP_EXT_OP_LOGGED))
+		return NULL;
+
+	sxi_lip = xfs_sxi_init(tp->t_mountp);
+	xfs_trans_add_item(tp, &sxi_lip->sxi_item);
+	tp->t_flags |= XFS_TRANS_DIRTY;
+	set_bit(XFS_LI_DIRTY, &sxi_lip->sxi_item.li_flags);
+
+	sx = &sxi_lip->sxi_format.sxi_extent;
+	sx->sx_inode1 = sxi->sxi_ip1->i_ino;
+	sx->sx_inode2 = sxi->sxi_ip2->i_ino;
+	sx->sx_startoff1 = sxi->sxi_startoff1;
+	sx->sx_startoff2 = sxi->sxi_startoff2;
+	sx->sx_blockcount = sxi->sxi_blockcount;
+	sx->sx_isize1 = sxi->sxi_isize1;
+	sx->sx_isize2 = sxi->sxi_isize2;
+	sx->sx_flags = sxi->sxi_flags;
+
+	return &sxi_lip->sxi_item;
+}
+
+STATIC struct xfs_log_item *
+xfs_swapext_create_done(
+	struct xfs_trans		*tp,
+	struct xfs_log_item		*intent,
+	unsigned int			count)
+{
+	if (intent == NULL)
+		return NULL;
+	return &xfs_trans_get_sxd(tp, SXI_ITEM(intent))->sxd_item;
+}
+
+/* Process a deferred swapext update. */
+STATIC int
+xfs_swapext_finish_item(
+	struct xfs_trans		*tp,
+	struct xfs_log_item		*done,
+	struct list_head		*item,
+	struct xfs_btree_cur		**state)
+{
+	struct xfs_swapext_intent	*sxi;
+	int				error;
+
+	sxi = container_of(item, struct xfs_swapext_intent, sxi_list);
+
+	/*
+	 * Swap one more extent between the two files.  If there's still more
+	 * work to do, we want to requeue ourselves after all other pending
+	 * deferred operations have finished.  This includes all of the dfops
+	 * that we queued directly as well as any new ones created in the
+	 * process of finishing the others.  Doing so prevents us from queuing
+	 * a large number of SXI log items in kernel memory, which in turn
+	 * prevents us from pinning the tail of the log (while logging those
+	 * new SXI items) until the first SXI items can be processed.
+	 */
+	error = xfs_swapext_finish_update(tp, done, sxi);
+	if (error == -EAGAIN)
+		return error;
+
+	kmem_cache_free(xfs_swapext_intent_cache, sxi);
+	return error;
+}
+
+/* Abort all pending SXIs. */
+STATIC void
+xfs_swapext_abort_intent(
+	struct xfs_log_item		*intent)
+{
+	xfs_sxi_release(SXI_ITEM(intent));
+}
+
+/* Cancel a deferred swapext update. */
+STATIC void
+xfs_swapext_cancel_item(
+	struct list_head		*item)
+{
+	struct xfs_swapext_intent	*sxi;
+
+	sxi = container_of(item, struct xfs_swapext_intent, sxi_list);
+	kmem_cache_free(xfs_swapext_intent_cache, sxi);
+}
+
+const struct xfs_defer_op_type xfs_swapext_defer_type = {
+	.max_items	= 1,
+	.create_intent	= xfs_swapext_create_intent,
+	.abort_intent	= xfs_swapext_abort_intent,
+	.create_done	= xfs_swapext_create_done,
+	.finish_item	= xfs_swapext_finish_item,
+	.cancel_item	= xfs_swapext_cancel_item,
+};
+
+/* Is this recovered SXI ok? */
+static inline bool
+xfs_sxi_validate(
+	struct xfs_mount		*mp,
+	struct xfs_sxi_log_item		*sxi_lip)
+{
+	struct xfs_swap_extent		*sx = &sxi_lip->sxi_format.sxi_extent;
+
+	if (!xfs_sb_version_haslogswapext(&mp->m_sb))
+		return false;
+
+	if (sxi_lip->sxi_format.__pad != 0)
+		return false;
+
+	if (sx->sx_flags & ~XFS_SWAP_EXT_FLAGS)
+		return false;
+
+	if (!xfs_verify_ino(mp, sx->sx_inode1) ||
+	    !xfs_verify_ino(mp, sx->sx_inode2))
+		return false;
+
+	if ((sx->sx_flags & XFS_SWAP_EXT_SET_SIZES) &&
+	     (sx->sx_isize1 < 0 || sx->sx_isize2 < 0))
+		return false;
+
+	if (!xfs_verify_fileext(mp, sx->sx_startoff1, sx->sx_blockcount))
+		return false;
+
+	return xfs_verify_fileext(mp, sx->sx_startoff2, sx->sx_blockcount);
+}
+
+/*
+ * Use the recovered log state to create a new request, estimate resource
+ * requirements, and create a new incore intent state.
+ */
+STATIC struct xfs_swapext_intent *
+xfs_sxi_item_recover_intent(
+	struct xfs_mount		*mp,
+	const struct xfs_swap_extent	*sx,
+	struct xfs_swapext_req		*req,
+	unsigned int			*reflink_state)
+{
+	struct xfs_inode		*ip1, *ip2;
+	int				error;
+
+	/*
+	 * Grab both inodes and set IRECOVERY to prevent trimming of post-eof
+	 * extents and freeing of unlinked inodes until we're totally done
+	 * processing files.
+	 */
+	error = xlog_recover_iget(mp, sx->sx_inode1, &ip1);
+	if (error)
+		return ERR_PTR(error);
+	error = xlog_recover_iget(mp, sx->sx_inode2, &ip2);
+	if (error)
+		goto err_rele1;
+
+	req->ip1 = ip1;
+	req->ip2 = ip2;
+	req->startoff1 = sx->sx_startoff1;
+	req->startoff2 = sx->sx_startoff2;
+	req->blockcount = sx->sx_blockcount;
+
+	if (sx->sx_flags & XFS_SWAP_EXT_ATTR_FORK)
+		req->whichfork = XFS_ATTR_FORK;
+	else
+		req->whichfork = XFS_DATA_FORK;
+
+	if (sx->sx_flags & XFS_SWAP_EXT_SET_SIZES)
+		req->req_flags |= XFS_SWAP_REQ_SET_SIZES;
+	if (sx->sx_flags & XFS_SWAP_EXT_INO1_WRITTEN)
+		req->req_flags |= XFS_SWAP_REQ_INO1_WRITTEN;
+	req->req_flags |= XFS_SWAP_REQ_LOGGED;
+
+	xfs_xchg_range_ilock(NULL, ip1, ip2);
+	error = xfs_swapext_estimate(req);
+	xfs_xchg_range_iunlock(ip1, ip2);
+	if (error)
+		goto err_rele2;
+
+	return xfs_swapext_init_intent(req, reflink_state);
+
+err_rele2:
+	xfs_irele(ip2);
+err_rele1:
+	xfs_irele(ip1);
+	return ERR_PTR(error);
+}
+
 /* Process a swapext update intent item that was recovered from the log. */
 STATIC int
 xfs_sxi_item_recover(
-	struct xfs_log_item	*lip,
-	struct list_head	*capture_list)
+	struct xfs_log_item		*lip,
+	struct list_head		*capture_list)
 {
-	return -EFSCORRUPTED;
+	struct xfs_swapext_req		req = { .req_flags = 0 };
+	struct xfs_swapext_intent	*sxi;
+	struct xfs_sxi_log_item		*sxi_lip = SXI_ITEM(lip);
+	struct xfs_mount		*mp = lip->li_log->l_mp;
+	struct xfs_swap_extent		*sx = &sxi_lip->sxi_format.sxi_extent;
+	struct xfs_sxd_log_item		*sxd_lip = NULL;
+	struct xfs_trans		*tp;
+	struct xfs_inode		*ip1, *ip2;
+	unsigned int			reflink_state;
+	int				error = 0;
+
+	if (!xfs_sxi_validate(mp, sxi_lip)) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&sxi_lip->sxi_format,
+				sizeof(sxi_lip->sxi_format));
+		return -EFSCORRUPTED;
+	}
+
+	sxi = xfs_sxi_item_recover_intent(mp, sx, &req, &reflink_state);
+	if (IS_ERR(sxi))
+		return PTR_ERR(sxi);
+
+	trace_xfs_swapext_recover(mp, sxi);
+
+	ip1 = sxi->sxi_ip1;
+	ip2 = sxi->sxi_ip2;
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, req.resblks, 0, 0,
+			&tp);
+	if (error)
+		goto err_rele;
+
+	sxd_lip = xfs_trans_get_sxd(tp, sxi_lip);
+
+	xfs_xchg_range_ilock(tp, ip1, ip2);
+
+	xfs_swapext_ensure_reflink(tp, sxi, reflink_state);
+	error = xfs_swapext_finish_update(tp, &sxd_lip->sxd_item, sxi);
+	if (error == -EAGAIN) {
+		/*
+		 * If there's more extent swapping to be done, we have to
+		 * schedule that as a separate deferred operation to be run
+		 * after we've finished replaying all of the intents we
+		 * recovered from the log.  Transfer ownership of the sxi to
+		 * the transaction.
+		 */
+		xfs_swapext_schedule(tp, sxi);
+		error = 0;
+		sxi = NULL;
+	}
+	if (error == -EFSCORRUPTED)
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, sx,
+				sizeof(*sx));
+	if (error)
+		goto err_cancel;
+
+	/*
+	 * Commit transaction, which frees the transaction and saves the inodes
+	 * for later replay activities.
+	 */
+	error = xfs_defer_ops_capture_and_commit(tp, capture_list);
+	goto err_unlock;
+
+err_cancel:
+	xfs_trans_cancel(tp);
+err_unlock:
+	xfs_xchg_range_iunlock(ip1, ip2);
+err_rele:
+	if (sxi)
+		kmem_cache_free(xfs_swapext_intent_cache, sxi);
+	xfs_irele(ip2);
+	xfs_irele(ip1);
+	return error;
 }
 
 STATIC bool
@@ -167,8 +553,21 @@ xfs_sxi_item_relog(
 	struct xfs_log_item	*intent,
 	struct xfs_trans	*tp)
 {
-	ASSERT(0);
-	return NULL;
+	struct xfs_sxd_log_item		*sxd_lip;
+	struct xfs_sxi_log_item		*sxi_lip;
+	struct xfs_swap_extent		*sx;
+
+	sx = &SXI_ITEM(intent)->sxi_format.sxi_extent;
+
+	tp->t_flags |= XFS_TRANS_DIRTY;
+	sxd_lip = xfs_trans_get_sxd(tp, SXI_ITEM(intent));
+	set_bit(XFS_LI_DIRTY, &sxd_lip->sxd_item.li_flags);
+
+	sxi_lip = xfs_sxi_init(tp->t_mountp);
+	memcpy(&sxi_lip->sxi_format.sxi_extent, sx, sizeof(*sx));
+	xfs_trans_add_item(tp, &sxi_lip->sxi_item);
+	set_bit(XFS_LI_DIRTY, &sxi_lip->sxi_item.li_flags);
+	return &sxi_lip->sxi_item;
 }
 
 static const struct xfs_item_ops xfs_sxi_item_ops = {
@@ -202,17 +601,17 @@ xlog_recover_sxi_commit_pass2(
 
 	sxi_formatp = item->ri_buf[0].i_addr;
 
-	if (sxi_formatp->__pad != 0) {
-		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
-		return -EFSCORRUPTED;
-	}
-
 	len = sizeof(struct xfs_sxi_log_format);
 	if (item->ri_buf[0].i_len != len) {
 		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
 		return -EFSCORRUPTED;
 	}
 
+	if (sxi_formatp->__pad != 0) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
 	sxi_lip = xfs_sxi_init(mp);
 	memcpy(&sxi_lip->sxi_format, sxi_formatp, len);
 
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index c9a5d8087b63..b43b973f0e10 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -40,6 +40,7 @@
 #include "scrub/xfbtree.h"
 #include "xfs_btree_mem.h"
 #include "xfs_bmap.h"
+#include "xfs_swapext.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index faecf54080a8..8e9cb02ca5be 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -79,6 +79,8 @@ struct xfs_dqtrx;
 struct xfs_icwalk;
 struct xfs_perag;
 struct xfs_bmap_intent;
+struct xfs_swapext_intent;
+struct xfs_swapext_req;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -2181,7 +2183,7 @@ TRACE_EVENT(xfs_dir2_leafn_moveents,
 		  __entry->count)
 );
 
-#define XFS_SWAPEXT_INODES \
+#define XFS_SWAP_EXT_INODES \
 	{ 0,	"target" }, \
 	{ 1,	"temp" }
 
@@ -2216,7 +2218,7 @@ DECLARE_EVENT_CLASS(xfs_swap_extent_class,
 		  "broot size %d, forkoff 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __print_symbolic(__entry->which, XFS_SWAPEXT_INODES),
+		  __print_symbolic(__entry->which, XFS_SWAP_EXT_INODES),
 		  __print_symbolic(__entry->format, XFS_INODE_FORMAT_STR),
 		  __entry->nex,
 		  __entry->broot_size,
@@ -3769,6 +3771,10 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1_skip);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
+DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
 
 /* fsmap traces */
 DECLARE_EVENT_CLASS(xfs_fsmap_class,
@@ -4614,6 +4620,212 @@ DEFINE_PERAG_INTENTS_EVENT(xfs_perag_wait_intents);
 
 #endif /* CONFIG_XFS_DRAIN_INTENTS */
 
+TRACE_EVENT(xfs_swapext_overhead,
+	TP_PROTO(struct xfs_mount *mp, unsigned long long bmbt_blocks,
+		 unsigned long long rmapbt_blocks),
+	TP_ARGS(mp, bmbt_blocks, rmapbt_blocks),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long long, bmbt_blocks)
+		__field(unsigned long long, rmapbt_blocks)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->bmbt_blocks = bmbt_blocks;
+		__entry->rmapbt_blocks = rmapbt_blocks;
+	),
+	TP_printk("dev %d:%d bmbt_blocks 0x%llx rmapbt_blocks 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->bmbt_blocks,
+		  __entry->rmapbt_blocks)
+);
+
+DECLARE_EVENT_CLASS(xfs_swapext_estimate_class,
+	TP_PROTO(const struct xfs_swapext_req *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(xfs_fileoff_t, startoff1)
+		__field(xfs_fileoff_t, startoff2)
+		__field(xfs_filblks_t, blockcount)
+		__field(int, whichfork)
+		__field(unsigned int, req_flags)
+		__field(xfs_filblks_t, ip1_bcount)
+		__field(xfs_filblks_t, ip2_bcount)
+		__field(xfs_filblks_t, ip1_rtbcount)
+		__field(xfs_filblks_t, ip2_rtbcount)
+		__field(unsigned long long, resblks)
+		__field(unsigned long long, nr_exchanges)
+	),
+	TP_fast_assign(
+		__entry->dev = req->ip1->i_mount->m_super->s_dev;
+		__entry->ino1 = req->ip1->i_ino;
+		__entry->ino2 = req->ip2->i_ino;
+		__entry->startoff1 = req->startoff1;
+		__entry->startoff2 = req->startoff2;
+		__entry->blockcount = req->blockcount;
+		__entry->whichfork = req->whichfork;
+		__entry->req_flags = req->req_flags;
+		__entry->ip1_bcount = req->ip1_bcount;
+		__entry->ip2_bcount = req->ip2_bcount;
+		__entry->ip1_rtbcount = req->ip1_rtbcount;
+		__entry->ip2_rtbcount = req->ip2_rtbcount;
+		__entry->resblks = req->resblks;
+		__entry->nr_exchanges = req->nr_exchanges;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx fileoff1 0x%llx ino2 0x%llx fileoff2 0x%llx fsbcount 0x%llx flags (%s) fork %s bcount1 0x%llx rtbcount1 0x%llx bcount2 0x%llx rtbcount2 0x%llx resblks 0x%llx nr_exchanges %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->startoff1,
+		  __entry->ino2, __entry->startoff2,
+		  __entry->blockcount,
+		  __print_flags(__entry->req_flags, "|", XFS_SWAP_REQ_STRINGS),
+		  __print_symbolic(__entry->whichfork, XFS_WHICHFORK_STRINGS),
+		  __entry->ip1_bcount,
+		  __entry->ip1_rtbcount,
+		  __entry->ip2_bcount,
+		  __entry->ip2_rtbcount,
+		  __entry->resblks,
+		  __entry->nr_exchanges)
+);
+
+#define DEFINE_SWAPEXT_ESTIMATE_EVENT(name)	\
+DEFINE_EVENT(xfs_swapext_estimate_class, name,	\
+	TP_PROTO(const struct xfs_swapext_req *req), \
+	TP_ARGS(req))
+DEFINE_SWAPEXT_ESTIMATE_EVENT(xfs_swapext_initial_estimate);
+DEFINE_SWAPEXT_ESTIMATE_EVENT(xfs_swapext_final_estimate);
+
+DECLARE_EVENT_CLASS(xfs_swapext_intent_class,
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_swapext_intent *sxi),
+	TP_ARGS(mp, sxi),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(unsigned int, flags)
+		__field(unsigned int, opflags)
+		__field(xfs_fileoff_t, startoff1)
+		__field(xfs_fileoff_t, startoff2)
+		__field(xfs_filblks_t, blockcount)
+		__field(xfs_fsize_t, isize1)
+		__field(xfs_fsize_t, isize2)
+		__field(xfs_fsize_t, new_isize1)
+		__field(xfs_fsize_t, new_isize2)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->ino1 = sxi->sxi_ip1->i_ino;
+		__entry->ino2 = sxi->sxi_ip2->i_ino;
+		__entry->flags = sxi->sxi_flags;
+		__entry->opflags = sxi->sxi_op_flags;
+		__entry->startoff1 = sxi->sxi_startoff1;
+		__entry->startoff2 = sxi->sxi_startoff2;
+		__entry->blockcount = sxi->sxi_blockcount;
+		__entry->isize1 = sxi->sxi_ip1->i_disk_size;
+		__entry->isize2 = sxi->sxi_ip2->i_disk_size;
+		__entry->new_isize1 = sxi->sxi_isize1;
+		__entry->new_isize2 = sxi->sxi_isize2;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx fileoff1 0x%llx ino2 0x%llx fileoff2 0x%llx fsbcount 0x%llx flags (%s) opflags (%s) isize1 0x%llx newisize1 0x%llx isize2 0x%llx newisize2 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->startoff1,
+		  __entry->ino2, __entry->startoff2,
+		  __entry->blockcount,
+		  __print_flags(__entry->flags, "|", XFS_SWAP_EXT_STRINGS),
+		  __print_flags(__entry->opflags, "|", XFS_SWAP_EXT_OP_STRINGS),
+		  __entry->isize1, __entry->new_isize1,
+		  __entry->isize2, __entry->new_isize2)
+);
+
+#define DEFINE_SWAPEXT_INTENT_EVENT(name)	\
+DEFINE_EVENT(xfs_swapext_intent_class, name,	\
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_swapext_intent *sxi), \
+	TP_ARGS(mp, sxi))
+DEFINE_SWAPEXT_INTENT_EVENT(xfs_swapext_defer);
+DEFINE_SWAPEXT_INTENT_EVENT(xfs_swapext_recover);
+
+TRACE_EVENT(xfs_swapext_delta_nextents_step,
+	TP_PROTO(struct xfs_mount *mp,
+		 const struct xfs_bmbt_irec *left,
+		 const struct xfs_bmbt_irec *curr,
+		 const struct xfs_bmbt_irec *new,
+		 const struct xfs_bmbt_irec *right,
+		 int delta, unsigned int state),
+	TP_ARGS(mp, left, curr, new, right, delta, state),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_fileoff_t, loff)
+		__field(xfs_fsblock_t, lstart)
+		__field(xfs_filblks_t, lcount)
+		__field(xfs_fileoff_t, coff)
+		__field(xfs_fsblock_t, cstart)
+		__field(xfs_filblks_t, ccount)
+		__field(xfs_fileoff_t, noff)
+		__field(xfs_fsblock_t, nstart)
+		__field(xfs_filblks_t, ncount)
+		__field(xfs_fileoff_t, roff)
+		__field(xfs_fsblock_t, rstart)
+		__field(xfs_filblks_t, rcount)
+		__field(int, delta)
+		__field(unsigned int, state)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->loff = left->br_startoff;
+		__entry->lstart = left->br_startblock;
+		__entry->lcount = left->br_blockcount;
+		__entry->coff = curr->br_startoff;
+		__entry->cstart = curr->br_startblock;
+		__entry->ccount = curr->br_blockcount;
+		__entry->noff = new->br_startoff;
+		__entry->nstart = new->br_startblock;
+		__entry->ncount = new->br_blockcount;
+		__entry->roff = right->br_startoff;
+		__entry->rstart = right->br_startblock;
+		__entry->rcount = right->br_blockcount;
+		__entry->delta = delta;
+		__entry->state = state;
+	),
+	TP_printk("dev %d:%d left 0x%llx:0x%llx:0x%llx; curr 0x%llx:0x%llx:0x%llx <- new 0x%llx:0x%llx:0x%llx; right 0x%llx:0x%llx:0x%llx delta %d state 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		__entry->loff, __entry->lstart, __entry->lcount,
+		__entry->coff, __entry->cstart, __entry->ccount,
+		__entry->noff, __entry->nstart, __entry->ncount,
+		__entry->roff, __entry->rstart, __entry->rcount,
+		__entry->delta, __entry->state)
+);
+
+TRACE_EVENT(xfs_swapext_delta_nextents,
+	TP_PROTO(const struct xfs_swapext_req *req, int64_t d_nexts1,
+		 int64_t d_nexts2),
+	TP_ARGS(req, d_nexts1, d_nexts2),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(xfs_extnum_t, nexts1)
+		__field(xfs_extnum_t, nexts2)
+		__field(int64_t, d_nexts1)
+		__field(int64_t, d_nexts2)
+	),
+	TP_fast_assign(
+		__entry->dev = req->ip1->i_mount->m_super->s_dev;
+		__entry->ino1 = req->ip1->i_ino;
+		__entry->ino2 = req->ip2->i_ino;
+		__entry->nexts1 = xfs_ifork_ptr(req->ip1, req->whichfork)->if_nextents;
+		__entry->nexts2 = xfs_ifork_ptr(req->ip2, req->whichfork)->if_nextents;
+		__entry->d_nexts1 = d_nexts1;
+		__entry->d_nexts2 = d_nexts2;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx nexts %llu ino2 0x%llx nexts %llu delta1 %lld delta2 %lld",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->nexts1,
+		  __entry->ino2, __entry->nexts2,
+		  __entry->d_nexts1, __entry->d_nexts2)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index b91df426d426..965f8bfc3f59 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -12,6 +12,7 @@
 #include "xfs_defer.h"
 #include "xfs_inode.h"
 #include "xfs_trans.h"
+#include "xfs_swapext.h"
 #include "xfs_xchgrange.h"
 #include <linux/fsnotify.h>
 
@@ -338,6 +339,55 @@ xfs_exch_range(
 	file_start_write(file2);
 	error = __xfs_exch_range(file1, file2, fxr);
 	file_end_write(file2);
+	return error;
+}
+
+/* XFS-specific parts of XFS_IOC_EXCHANGE_RANGE */
+
+/* Lock (and optionally join) two inodes for a file range exchange. */
+void
+xfs_xchg_range_ilock(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	if (ip1 != ip2)
+		xfs_lock_two_inodes(ip1, XFS_ILOCK_EXCL,
+				    ip2, XFS_ILOCK_EXCL);
+	else
+		xfs_ilock(ip1, XFS_ILOCK_EXCL);
+	if (tp) {
+		xfs_trans_ijoin(tp, ip1, 0);
+		if (ip2 != ip1)
+			xfs_trans_ijoin(tp, ip2, 0);
+	}
+
+}
+
+/* Unlock two inodes after a file range exchange operation. */
+void
+xfs_xchg_range_iunlock(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	if (ip2 != ip1)
+		xfs_iunlock(ip2, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip1, XFS_ILOCK_EXCL);
+}
+
+/*
+ * Estimate the resource requirements to exchange file contents between the two
+ * files.  The caller is required to hold the IOLOCK and the MMAPLOCK and to
+ * have flushed both inodes' pagecache and active direct-ios.
+ */
+int
+xfs_xchg_range_estimate(
+	struct xfs_swapext_req	*req)
+{
+	int			error;
 
+	xfs_xchg_range_ilock(NULL, req->ip1, req->ip2);
+	error = xfs_swapext_estimate(req);
+	xfs_xchg_range_iunlock(req->ip1, req->ip2);
 	return error;
 }
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
index 414fce7a159f..3870e78f4807 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -15,4 +15,14 @@ int xfs_exch_range_finish(struct file *file1, struct file *file2);
 int xfs_exch_range(struct file *file1, struct file *file2,
 		struct xfs_exch_range *fxr);
 
+/* XFS-specific parts of file exchanges */
+
+struct xfs_swapext_req;
+
+void xfs_xchg_range_ilock(struct xfs_trans *tp, struct xfs_inode *ip1,
+		struct xfs_inode *ip2);
+void xfs_xchg_range_iunlock(struct xfs_inode *ip1, struct xfs_inode *ip2);
+
+int xfs_xchg_range_estimate(struct xfs_swapext_req *req);
+
 #endif /* __XFS_XCHGRANGE_H__ */

