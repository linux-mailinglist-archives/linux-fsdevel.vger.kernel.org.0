Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385FF350B99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhDABJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhDABJ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE7D61059;
        Thu,  1 Apr 2021 01:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239367;
        bh=q7DASjIZRhT0G4pO+lCXiqA5oOV1MGbQ+a4JtQSpUI8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RA7GJDuYpRO3ou3YFQRQXBA5z+ZpzFbI2C1vkq1g43uSTHnkPOVSwNS+7vk5yEV8q
         of9EBdOIZ2eQYpm0xtKRyWtHKHeGVvjR0eY3TFkXDiZayX94Q2714wUeJXdoJW5lqN
         DAZ6a/rbyS0+m7QaVinBHleO7a0lchjgzVbtpw6890elxXQHGhcQECHvgHMXOXZZHz
         T+8Ye6R/DKAJOI0TXN5qacjjEWTkGUG1xw0ueCnmdjb0UIJFrmD/ZHF4Ftqr3SpLbj
         AuYZ5y7/77GL89EPTvhQ1s6u+39KzTst5hFRqTWcHsFxE/HZLUUxd1TerBYxYaK84l
         AUAihZkOgTD3g==
Subject: [PATCH 07/18] xfs: create deferred log items for extent swapping
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:26 -0700
Message-ID: <161723936601.3149451.16418246116610965317.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 fs/xfs/Makefile                 |    2 
 fs/xfs/libxfs/xfs_bmap.h        |    4 
 fs/xfs/libxfs/xfs_defer.c       |    1 
 fs/xfs/libxfs/xfs_defer.h       |    2 
 fs/xfs/libxfs/xfs_log_recover.h |    2 
 fs/xfs/libxfs/xfs_swapext.c     |  878 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_swapext.h     |   84 ++++
 fs/xfs/xfs_bmap_item.c          |   11 
 fs/xfs/xfs_bmap_util.c          |    1 
 fs/xfs/xfs_log_recover.c        |   25 +
 fs/xfs/xfs_swapext_item.c       |  327 ++++++++++++++-
 fs/xfs/xfs_trace.c              |    1 
 fs/xfs/xfs_trace.h              |  185 ++++++++
 fs/xfs/xfs_xchgrange.c          |   66 +++
 fs/xfs/xfs_xchgrange.h          |   19 +
 15 files changed, 1593 insertions(+), 15 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_swapext.c
 create mode 100644 fs/xfs/libxfs/xfs_swapext.h
 create mode 100644 fs/xfs/xfs_xchgrange.c
 create mode 100644 fs/xfs/xfs_xchgrange.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index a7cc6f496ad0..f356869d8fd9 100644
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
@@ -92,6 +93,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_sysfs.o \
 				   xfs_trans.o \
 				   xfs_xattr.o \
+				   xfs_xchgrange.o \
 				   kmem.o
 
 # low-level transaction/log code
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 30ce3ba24259..bdf725ded307 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -159,7 +159,7 @@ static inline int xfs_bmapi_whichfork(int bmapi_flags)
 	{ BMAP_COWFORK,		"COW" }
 
 /* Return true if the extent is an allocated extent, written or not. */
-static inline bool xfs_bmap_is_real_extent(struct xfs_bmbt_irec *irec)
+static inline bool xfs_bmap_is_real_extent(const struct xfs_bmbt_irec *irec)
 {
 	return irec->br_startblock != HOLESTARTBLOCK &&
 		irec->br_startblock != DELAYSTARTBLOCK &&
@@ -170,7 +170,7 @@ static inline bool xfs_bmap_is_real_extent(struct xfs_bmbt_irec *irec)
  * Return true if the extent is a real, allocated extent, or false if it is  a
  * delayed allocation, and unwritten extent or a hole.
  */
-static inline bool xfs_bmap_is_written_extent(struct xfs_bmbt_irec *irec)
+static inline bool xfs_bmap_is_written_extent(const struct xfs_bmbt_irec *irec)
 {
 	return xfs_bmap_is_real_extent(irec) &&
 	       irec->br_state != XFS_EXT_UNWRITTEN;
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index a7d1357687d0..927e7245d7ec 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -178,6 +178,7 @@ static const struct xfs_defer_op_type *defer_op_types[] = {
 	[XFS_DEFER_OPS_TYPE_RMAP]	= &xfs_rmap_update_defer_type,
 	[XFS_DEFER_OPS_TYPE_FREE]	= &xfs_extent_free_defer_type,
 	[XFS_DEFER_OPS_TYPE_AGFL_FREE]	= &xfs_agfl_free_defer_type,
+	[XFS_DEFER_OPS_TYPE_SWAPEXT]	= &xfs_swapext_defer_type,
 };
 
 static void
diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
index f5e3ca17aa26..99ff9feb0d9b 100644
--- a/fs/xfs/libxfs/xfs_defer.h
+++ b/fs/xfs/libxfs/xfs_defer.h
@@ -19,6 +19,7 @@ enum xfs_defer_ops_type {
 	XFS_DEFER_OPS_TYPE_RMAP,
 	XFS_DEFER_OPS_TYPE_FREE,
 	XFS_DEFER_OPS_TYPE_AGFL_FREE,
+	XFS_DEFER_OPS_TYPE_SWAPEXT,
 	XFS_DEFER_OPS_TYPE_MAX,
 };
 
@@ -63,6 +64,7 @@ extern const struct xfs_defer_op_type xfs_refcount_update_defer_type;
 extern const struct xfs_defer_op_type xfs_rmap_update_defer_type;
 extern const struct xfs_defer_op_type xfs_extent_free_defer_type;
 extern const struct xfs_defer_op_type xfs_agfl_free_defer_type;
+extern const struct xfs_defer_op_type xfs_swapext_defer_type;
 
 /*
  * This structure enables a dfops user to detach the chain of deferred
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index dcc11a8c438a..cb8f17074bef 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -124,6 +124,8 @@ void xlog_buf_readahead(struct xlog *log, xfs_daddr_t blkno, uint len,
 		const struct xfs_buf_ops *ops);
 bool xlog_is_buffer_cancelled(struct xlog *log, xfs_daddr_t blkno, uint len);
 
+int xlog_recover_iget(struct xfs_mount *mp, xfs_ino_t ino,
+		struct xfs_inode **ipp);
 void xlog_recover_release_intent(struct xlog *log, unsigned short intent_type,
 		uint64_t intent_id);
 
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
new file mode 100644
index 000000000000..9fb67cbd018f
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -0,0 +1,878 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
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
+
+/* Information to help us reset reflink flag / CoW fork state after a swap. */
+
+/* Are we swapping the data fork? */
+#define XFS_SX_REFLINK_DATAFORK		(1U << 0)
+
+/* Can we swap the flags? */
+#define XFS_SX_REFLINK_SWAPFLAGS	(1U << 1)
+
+/* Previous state of the two inodes' reflink flags. */
+#define XFS_SX_REFLINK_IP1_REFLINK	(1U << 2)
+#define XFS_SX_REFLINK_IP2_REFLINK	(1U << 3)
+
+
+/*
+ * Prepare both inodes' reflink state for an extent swap, and return our
+ * findings so that xfs_swapext_reflink_finish can deal with the aftermath.
+ */
+unsigned int
+xfs_swapext_reflink_prep(
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_mount		*mp = req->ip1->i_mount;
+	unsigned int			rs = 0;
+
+	if (req->whichfork != XFS_DATA_FORK)
+		return 0;
+
+	/*
+	 * If either file has shared blocks and we're swapping data forks, we
+	 * must flag the other file as having shared blocks so that we get the
+	 * shared-block rmap functions if we need to fix up the rmaps.  The
+	 * flags will be switched for real by xfs_swapext_reflink_finish.
+	 */
+	if (xfs_is_reflink_inode(req->ip1))
+		rs |= XFS_SX_REFLINK_IP1_REFLINK;
+	if (xfs_is_reflink_inode(req->ip2))
+		rs |= XFS_SX_REFLINK_IP2_REFLINK;
+
+	if (rs & XFS_SX_REFLINK_IP1_REFLINK)
+		req->ip2->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+	if (rs & XFS_SX_REFLINK_IP2_REFLINK)
+		req->ip1->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+	/*
+	 * If either file had the reflink flag set before; and the two files'
+	 * reflink state was different; and we're swapping the entirety of both
+	 * files, then we can exchange the reflink flags at the end.
+	 * Otherwise, we propagate the reflink flag from either file to the
+	 * other file.
+	 *
+	 * Note that we've only set the _REFLINK flags of the reflink state, so
+	 * we can cheat and use hweight32 for the reflink flag test.
+	 *
+	 */
+	if (hweight32(rs) == 1 && req->startoff1 == 0 && req->startoff2 == 0 &&
+	    req->blockcount == XFS_B_TO_FSB(mp, req->ip1->i_d.di_size) &&
+	    req->blockcount == XFS_B_TO_FSB(mp, req->ip2->i_d.di_size))
+		rs |= XFS_SX_REFLINK_SWAPFLAGS;
+
+	rs |= XFS_SX_REFLINK_DATAFORK;
+	return rs;
+}
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
+	cfork = XFS_IFORK_PTR(ip, XFS_COW_FORK);
+	if (!cfork)
+		return;
+	if (cfork->if_bytes > 0)
+		xfs_inode_set_cowblocks_tag(ip);
+	else
+		xfs_inode_clear_cowblocks_tag(ip);
+}
+
+/*
+ * Set both inodes' ondisk reflink flags to their final state and ensure that
+ * the incore state is ready to go.
+ */
+void
+xfs_swapext_reflink_finish(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_req	*req,
+	unsigned int			rs)
+{
+	if (!(rs & XFS_SX_REFLINK_DATAFORK))
+		return;
+
+	if (rs & XFS_SX_REFLINK_SWAPFLAGS) {
+		/* Exchange the reflink inode flags and log them. */
+		req->ip1->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		if (rs & XFS_SX_REFLINK_IP2_REFLINK)
+			req->ip1->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+		req->ip2->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		if (rs & XFS_SX_REFLINK_IP1_REFLINK)
+			req->ip2->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
+
+		xfs_trans_log_inode(tp, req->ip1, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, req->ip2, XFS_ILOG_CORE);
+	}
+
+	xfs_swapext_ensure_cowfork(req->ip1);
+	xfs_swapext_ensure_cowfork(req->ip2);
+}
+
+/* Schedule an atomic extent swap. */
+static inline void
+xfs_swapext_schedule(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	trace_xfs_swapext_defer(tp->t_mountp, sxi);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_SWAPEXT, &sxi->sxi_list);
+}
+
+/* Reschedule an atomic extent swap on behalf of log recovery. */
+void
+xfs_swapext_reschedule(
+	struct xfs_trans		*tp,
+	const struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_swapext_intent	*new_sxi;
+
+	new_sxi = kmem_alloc(sizeof(struct xfs_swapext_intent), KM_NOFS);
+	memcpy(new_sxi, sxi, sizeof(*new_sxi));
+	INIT_LIST_HEAD(&new_sxi->sxi_list);
+
+	xfs_swapext_schedule(tp, new_sxi);
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
+	if (len <= ip->i_d.di_size)
+		return;
+
+	trace_xfs_swapext_update_inode_size(ip, len);
+
+	ip->i_d.di_size = len;
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+}
+
+/* Do we have more work to do to finish this operation? */
+bool
+xfs_swapext_has_more_work(
+	struct xfs_swapext_intent	*sxi)
+{
+	return sxi->sxi_blockcount > 0;
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
+	ifp1 = XFS_IFORK_PTR(req->ip1, req->whichfork);
+	ifp2 = XFS_IFORK_PTR(req->ip2, req->whichfork);
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
+/* Finish one extent swap, possibly log more. */
+int
+xfs_swapext_finish_one(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_bmbt_irec		irec1, irec2;
+	int				whichfork;
+	int				nimaps;
+	int				bmap_flags;
+	int				error;
+
+	whichfork = (sxi->sxi_flags & XFS_SWAP_EXTENT_ATTR_FORK) ?
+			XFS_ATTR_FORK : XFS_DATA_FORK;
+	bmap_flags = xfs_bmapi_aflag(whichfork);
+
+	while (sxi->sxi_blockcount > 0) {
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->sxi_ip1, sxi->sxi_startoff1,
+				sxi->sxi_blockcount, &irec1, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec1.br_startblock == DELAYSTARTBLOCK ||
+		    irec1.br_startoff != sxi->sxi_startoff1) {
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
+		 * If the caller told us to ignore sparse areas of file1, jump
+		 * ahead to the next region.
+		 */
+		if ((sxi->sxi_flags & XFS_SWAP_EXTENT_SKIP_FILE1_HOLES) &&
+		    irec1.br_startblock == HOLESTARTBLOCK) {
+			trace_xfs_swapext_extent1(sxi->sxi_ip1, &irec1);
+
+			sxi->sxi_startoff1 += irec1.br_blockcount;
+			sxi->sxi_startoff2 += irec1.br_blockcount;
+			sxi->sxi_blockcount -= irec1.br_blockcount;
+			continue;
+		}
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(sxi->sxi_ip2, sxi->sxi_startoff2,
+				irec1.br_blockcount, &irec2, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (nimaps != 1 ||
+		    irec2.br_startblock == DELAYSTARTBLOCK ||
+		    irec2.br_startoff != sxi->sxi_startoff2) {
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
+		irec1.br_blockcount = min(irec1.br_blockcount,
+					  irec2.br_blockcount);
+
+		trace_xfs_swapext_extent1(sxi->sxi_ip1, &irec1);
+		trace_xfs_swapext_extent2(sxi->sxi_ip2, &irec2);
+
+		/*
+		 * Two extents mapped to the same physical block must not have
+		 * different states; that's filesystem corruption.  Move on to
+		 * the next extent if they're both holes or both the same
+		 * physical extent.
+		 */
+		if (irec1.br_startblock == irec2.br_startblock) {
+			if (irec1.br_state != irec2.br_state)
+				return -EFSCORRUPTED;
+
+			sxi->sxi_startoff1 += irec1.br_blockcount;
+			sxi->sxi_startoff2 += irec1.br_blockcount;
+			sxi->sxi_blockcount -= irec1.br_blockcount;
+			continue;
+		}
+
+		xfs_swapext_update_quota(tp, sxi, &irec1, &irec2);
+
+		/* Remove both mappings. */
+		xfs_bmap_unmap_extent(tp, sxi->sxi_ip1, whichfork, &irec1);
+		xfs_bmap_unmap_extent(tp, sxi->sxi_ip2, whichfork, &irec2);
+
+		/*
+		 * Re-add both mappings.  We swap the file offsets between the
+		 * two maps and add the opposite map, which has the effect of
+		 * filling the logical offsets we just unmapped, but with with
+		 * the physical mapping information swapped.
+		 */
+		swap(irec1.br_startoff, irec2.br_startoff);
+		xfs_bmap_map_extent(tp, sxi->sxi_ip1, whichfork, &irec2);
+		xfs_bmap_map_extent(tp, sxi->sxi_ip2, whichfork, &irec1);
+
+		/* Make sure we're not mapping extents past EOF. */
+		if (whichfork == XFS_DATA_FORK) {
+			xfs_swapext_update_size(tp, sxi->sxi_ip1, &irec2,
+					sxi->sxi_isize1);
+			xfs_swapext_update_size(tp, sxi->sxi_ip2, &irec1,
+					sxi->sxi_isize2);
+		}
+
+		/*
+		 * Advance our cursor and exit.   The caller (either defer ops
+		 * or log recovery) will log the SXD item, and if *blockcount
+		 * is nonzero, it will log a new SXI item for the remainder
+		 * and call us back.
+		 */
+		sxi->sxi_startoff1 += irec1.br_blockcount;
+		sxi->sxi_startoff2 += irec1.br_blockcount;
+		sxi->sxi_blockcount -= irec1.br_blockcount;
+		break;
+	}
+
+	/*
+	 * If the caller asked us to exchange the file sizes and we're done
+	 * moving extents, update the ondisk file sizes now.
+	 */
+	if (sxi->sxi_blockcount == 0 &&
+	    (sxi->sxi_flags & XFS_SWAP_EXTENT_SET_SIZES)) {
+		sxi->sxi_ip1->i_d.di_size = sxi->sxi_isize1;
+		sxi->sxi_ip2->i_d.di_size = sxi->sxi_isize2;
+
+		xfs_trans_log_inode(tp, sxi->sxi_ip1, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, sxi->sxi_ip2, XFS_ILOG_CORE);
+	}
+
+	if (xfs_swapext_has_more_work(sxi))
+		trace_xfs_swapext_defer(tp->t_mountp, sxi);
+
+	return 0;
+}
+
+/* Estimate the bmbt and rmapbt overhead required to exchange extents. */
+static int
+xfs_swapext_estimate_overhead(
+	const struct xfs_swapext_req	*req,
+	struct xfs_swapext_res		*res)
+{
+	struct xfs_mount		*mp = req->ip1->i_mount;
+	unsigned int			bmbt_overhead;
+
+	/*
+	 * Compute the amount of bmbt blocks we should reserve for each file.
+	 *
+	 * Conceptually this shouldn't affect the shape of either bmbt, but
+	 * since we atomically move extents one by one, we reserve enough space
+	 * to handle a bmbt split for each remap operation (t1).
+	 *
+	 * However, we must be careful to handle a corner case where the
+	 * repeated unmap and map activities could result in ping-ponging of
+	 * the btree shape.  This behavior can come from one of two sources:
+	 *
+	 * An inode's extent list could have just enough records to straddle
+	 * the btree format boundary. If so, the inode could bounce between
+	 * btree <-> extent format on unmap -> remap cycles, freeing and
+	 * allocating a bmapbt block each time.
+	 *
+	 * The same thing can happen if we have just enough records in a block
+	 * to bounce between one and two leaf blocks. If there aren't enough
+	 * sibling blocks to absorb or donate some records, we end up reshaping
+	 * the tree with every remap operation.  This doesn't seem to happen if
+	 * we have more than four bmbt leaf blocks, so we'll make that the
+	 * lower bound on the pingponging (t2).
+	 *
+	 * Therefore, we use XFS_TRANS_RES_FDBLKS so that freed bmbt blocks
+	 * are accounted back to the transaction block reservation.
+	 */
+	bmbt_overhead = XFS_NEXTENTADD_SPACE_RES(mp, res->nr_exchanges,
+						 req->whichfork);
+	res->ip1_bcount += bmbt_overhead;
+	res->ip2_bcount += bmbt_overhead;
+	res->resblks += 2 * bmbt_overhead;
+
+	/* Apply similar logic to rmapbt reservations. */
+	if (xfs_sb_version_hasrmapbt(&mp->m_sb)) {
+		unsigned int	rmapbt_overhead;
+
+		if (!XFS_IS_REALTIME_INODE(req->ip1))
+			rmapbt_overhead = XFS_NRMAPADD_SPACE_RES(mp,
+							res->nr_exchanges);
+		else
+			rmapbt_overhead = 0;
+		res->resblks += 2 * rmapbt_overhead;
+	}
+
+	trace_xfs_swapext_estimate(req, res);
+
+	if (res->resblks > UINT_MAX)
+		return -ENOSPC;
+	return 0;
+}
+
+/* Decide if we can merge two real extents. */
+static inline bool
+can_merge(
+	const struct xfs_bmbt_irec	*b1,
+	const struct xfs_bmbt_irec	*b2)
+{
+	/* Zero length means uninitialized. */
+	if (b1->br_blockcount == 0 || b2->br_blockcount == 0)
+		return false;
+
+	/* We don't merge holes. */
+	if (!xfs_bmap_is_real_extent(b1) || !xfs_bmap_is_real_extent(b2))
+		return false;
+
+	if (b1->br_startoff   + b1->br_blockcount == b2->br_startoff &&
+	    b1->br_startblock + b1->br_blockcount == b2->br_startblock &&
+	    b1->br_state			  == b2->br_state &&
+	    b1->br_blockcount + b2->br_blockcount <= MAXEXTLEN)
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
+	lhole = left->br_blockcount == 0 ||
+		left->br_startblock == HOLESTARTBLOCK;
+	rhole = right->br_blockcount == 0 ||
+		right->br_startblock == HOLESTARTBLOCK;
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
+					right->br_startblock > MAXEXTLEN)
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
+					right->br_startblock > MAXEXTLEN)
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
+check_delta_nextents(
+	const struct xfs_swapext_req	*req,
+	struct xfs_inode		*ip,
+	int64_t				delta)
+{
+	ASSERT(delta < INT_MAX);
+	ASSERT(delta > INT_MIN);
+
+	if (delta < 0)
+		return 0;
+
+	return xfs_iext_count_may_overflow(ip, req->whichfork, delta);
+}
+
+/* Find the next extent after irec. */
+static inline int
+get_next_ext(
+	struct xfs_inode		*ip,
+	unsigned int			bmap_flags,
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
+		 */
+		nrec->br_blockcount = 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Estimate the number of exchange operations and the number of file blocks
+ * in each file that will be affected by the exchange operation.
+ */
+int
+xfs_swapext_estimate(
+	const struct xfs_swapext_req	*req,
+	struct xfs_swapext_res		*res)
+{
+	struct xfs_bmbt_irec		irec1, irec2;
+	struct xfs_bmbt_irec		lrec1 = { }, lrec2 = { };
+	struct xfs_bmbt_irec		rrec1, rrec2;
+	xfs_fileoff_t			startoff1 = req->startoff1;
+	xfs_fileoff_t			startoff2 = req->startoff2;
+	xfs_filblks_t			blockcount = req->blockcount;
+	xfs_filblks_t			ip1_blocks = 0, ip2_blocks = 0;
+	int64_t				d_nexts1, d_nexts2;
+	int				bmap_flags;
+	int				nimaps;
+	int				error;
+
+	bmap_flags = xfs_bmapi_aflag(req->whichfork);
+	memset(res, 0, sizeof(struct xfs_swapext_res));
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
+	while (blockcount > 0) {
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip1, startoff1, blockcount,
+				&irec1, &nimaps, bmap_flags);
+		if (error)
+			return error;
+		if (irec1.br_startblock == DELAYSTARTBLOCK ||
+		    irec1.br_startoff != startoff1) {
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
+		 * If the caller told us to ignore sparse areas of file1, jump
+		 * ahead to the next region.
+		 */
+		if ((req->flags & XFS_SWAPEXT_SKIP_FILE1_HOLES) &&
+		    irec1.br_startblock == HOLESTARTBLOCK) {
+			memcpy(&lrec1, &irec1, sizeof(struct xfs_bmbt_irec));
+			lrec1.br_blockcount = 0;
+			goto advance;
+		}
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip2, startoff2,
+				irec1.br_blockcount, &irec2, &nimaps,
+				bmap_flags);
+		if (error)
+			return error;
+		if (irec2.br_startblock == DELAYSTARTBLOCK ||
+		    irec2.br_startoff != startoff2) {
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
+		irec1.br_blockcount = min(irec1.br_blockcount,
+					  irec2.br_blockcount);
+
+		/*
+		 * Two extents mapped to the same physical block must not have
+		 * different states; that's filesystem corruption.  Move on to
+		 * the next extent if they're both holes or both the same
+		 * physical extent.
+		 */
+		if (irec1.br_startblock == irec2.br_startblock) {
+			if (irec1.br_state != irec2.br_state)
+				return -EFSCORRUPTED;
+			memcpy(&lrec1, &irec1, sizeof(struct xfs_bmbt_irec));
+			memcpy(&lrec2, &irec2, sizeof(struct xfs_bmbt_irec));
+			goto advance;
+		}
+
+		/* Update accounting. */
+		if (xfs_bmap_is_real_extent(&irec1))
+			ip1_blocks += irec1.br_blockcount;
+		if (xfs_bmap_is_real_extent(&irec2))
+			ip2_blocks += irec2.br_blockcount;
+		res->nr_exchanges++;
+
+		/* Read next extent from the first file */
+		error = get_next_ext(req->ip1, bmap_flags, &irec1, &rrec1);
+		if (error)
+			return error;
+		error = get_next_ext(req->ip2, bmap_flags, &irec2, &rrec2);
+		if (error)
+			return error;
+
+		d_nexts1 += delta_nextents_step(req->ip1->i_mount,
+				&lrec1, &irec1, &irec2, &rrec1);
+		d_nexts2 += delta_nextents_step(req->ip1->i_mount,
+				&lrec2, &irec2, &irec1, &rrec2);
+
+		/* Now pretend we swapped the extents. */
+		if (can_merge(&lrec2, &irec1))
+			lrec2.br_blockcount += irec1.br_blockcount;
+		else
+			memcpy(&lrec2, &irec1, sizeof(struct xfs_bmbt_irec));
+		if (can_merge(&lrec1, &irec2))
+			lrec1.br_blockcount += irec2.br_blockcount;
+		else
+			memcpy(&lrec1, &irec2, sizeof(struct xfs_bmbt_irec));
+
+advance:
+		/* Advance our cursor and move on. */
+		startoff1 += irec1.br_blockcount;
+		startoff2 += irec1.br_blockcount;
+		blockcount -= irec1.br_blockcount;
+	}
+
+	/* Account for the blocks that are being exchanged. */
+	if (XFS_IS_REALTIME_INODE(req->ip1) &&
+	    req->whichfork == XFS_DATA_FORK) {
+		res->ip1_rtbcount = ip1_blocks;
+		res->ip2_rtbcount = ip2_blocks;
+	} else {
+		res->ip1_bcount = ip1_blocks;
+		res->ip2_bcount = ip2_blocks;
+	}
+
+	/*
+	 * Make sure that both forks have enough slack left in their extent
+	 * counters that the swap operation will not overflow.
+	 */
+	trace_xfs_swapext_delta_nextents(req, d_nexts1, d_nexts2);
+	if (req->ip1 == req->ip2) {
+		error = check_delta_nextents(req, req->ip1,
+				d_nexts1 + d_nexts2);
+	} else {
+		error = check_delta_nextents(req, req->ip1, d_nexts1);
+		if (error)
+			return error;
+		error = check_delta_nextents(req, req->ip2, d_nexts2);
+	}
+	if (error)
+		return error;
+
+	return xfs_swapext_estimate_overhead(req, res);
+}
+
+static void
+xfs_swapext_init_intent(
+	struct xfs_swapext_intent	*sxi,
+	const struct xfs_swapext_req	*req)
+{
+	INIT_LIST_HEAD(&sxi->sxi_list);
+	sxi->sxi_flags = 0;
+	if (req->whichfork == XFS_ATTR_FORK)
+		sxi->sxi_flags |= XFS_SWAP_EXTENT_ATTR_FORK;
+	sxi->sxi_isize1 = sxi->sxi_isize2 = -1;
+	if (req->whichfork == XFS_DATA_FORK &&
+	    (req->flags & XFS_SWAPEXT_SET_SIZES)) {
+		sxi->sxi_flags |= XFS_SWAP_EXTENT_SET_SIZES;
+		sxi->sxi_isize1 = req->ip2->i_d.di_size;
+		sxi->sxi_isize2 = req->ip1->i_d.di_size;
+	}
+	if (req->flags & XFS_SWAPEXT_SKIP_FILE1_HOLES)
+		sxi->sxi_flags |= XFS_SWAP_EXTENT_SKIP_FILE1_HOLES;
+	sxi->sxi_ip1 = req->ip1;
+	sxi->sxi_ip2 = req->ip2;
+	sxi->sxi_startoff1 = req->startoff1;
+	sxi->sxi_startoff2 = req->startoff2;
+	sxi->sxi_blockcount = req->blockcount;
+}
+
+/*
+ * Swap a range of extents from one inode to another.  If the atomic swap
+ * feature is enabled, then the operation progress can be resumed even if the
+ * system goes down.
+ *
+ * The caller must ensure the inodes must be joined to the transaction and
+ * ILOCKd; they will still be joined to the transaction at exit.
+ */
+int
+xfs_swapext(
+	struct xfs_trans		**tpp,
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_swapext_intent	*sxi;
+	unsigned int			reflink_state;
+	int				error;
+
+	ASSERT(xfs_isilocked(req->ip1, XFS_ILOCK_EXCL));
+	ASSERT(xfs_isilocked(req->ip2, XFS_ILOCK_EXCL));
+	ASSERT(req->whichfork != XFS_COW_FORK);
+	if (req->flags & XFS_SWAPEXT_SET_SIZES)
+		ASSERT(req->whichfork == XFS_DATA_FORK);
+
+	reflink_state = xfs_swapext_reflink_prep(req);
+
+	sxi = kmem_alloc(sizeof(struct xfs_swapext_intent), KM_NOFS);
+	xfs_swapext_init_intent(sxi, req);
+	xfs_swapext_schedule(*tpp, sxi);
+
+	error = xfs_defer_finish(tpp);
+	if (error)
+		return error;
+
+	xfs_swapext_reflink_finish(*tpp, req, reflink_state);
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
new file mode 100644
index 000000000000..e63f4a5556c1
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_SWAPEXT_H_
+#define __XFS_SWAPEXT_H_ 1
+
+/*
+ * In-core information about an extent swap request between ranges of two
+ * inodes.
+ */
+struct xfs_swapext_intent {
+	/* List of other incore deferred work. */
+	struct list_head	sxi_list;
+
+	/* The two inodes we're swapping. */
+	union {
+		struct xfs_inode *sxi_ip1;
+		xfs_ino_t	sxi_ino1;
+	};
+	union {
+		struct xfs_inode *sxi_ip2;
+		xfs_ino_t	sxi_ino2;
+	};
+
+	/* File offset range information. */
+	xfs_fileoff_t		sxi_startoff1;
+	xfs_fileoff_t		sxi_startoff2;
+	xfs_filblks_t		sxi_blockcount;
+	uint64_t		sxi_flags;
+
+	/* Set these file sizes after the operation, unless negative. */
+	xfs_fsize_t		sxi_isize1;
+	xfs_fsize_t		sxi_isize2;
+};
+
+/* Set the sizes of both files after the operation. */
+#define XFS_SWAPEXT_SET_SIZES		(1U << 0)
+
+/* Do not swap any part of the range where file1's mapping is a hole. */
+#define XFS_SWAPEXT_SKIP_FILE1_HOLES	(1U << 1)
+
+/* Parameters for a swapext request. */
+struct xfs_swapext_req {
+	struct xfs_inode	*ip1;
+	struct xfs_inode	*ip2;
+	xfs_fileoff_t		startoff1;
+	xfs_fileoff_t		startoff2;
+	xfs_filblks_t		blockcount;
+	int			whichfork;
+	unsigned int		flags;
+};
+
+/* Estimated resource requirements for a swapext operation. */
+struct xfs_swapext_res {
+	xfs_filblks_t		ip1_bcount;
+	xfs_filblks_t		ip2_bcount;
+	xfs_filblks_t		ip1_rtbcount;
+	xfs_filblks_t		ip2_rtbcount;
+	unsigned long long	resblks;
+	unsigned int		nr_exchanges;
+};
+
+bool xfs_swapext_has_more_work(struct xfs_swapext_intent *sxi);
+
+unsigned int xfs_swapext_reflink_prep(const struct xfs_swapext_req *req);
+void xfs_swapext_reflink_finish(struct xfs_trans *tp,
+		const struct xfs_swapext_req *req, unsigned int reflink_state);
+
+int xfs_swapext_estimate(const struct xfs_swapext_req *req,
+		struct xfs_swapext_res *res);
+
+void xfs_swapext_reschedule(struct xfs_trans *tpp,
+		const struct xfs_swapext_intent *sxi_state);
+int xfs_swapext_finish_one(struct xfs_trans *tp,
+		struct xfs_swapext_intent *sxi_state);
+
+int xfs_swapext_check_extents(struct xfs_mount *mp,
+		const struct xfs_swapext_req *req);
+
+int xfs_swapext(struct xfs_trans **tpp, const struct xfs_swapext_req *req);
+
+#endif /* __XFS_SWAPEXT_H_ */
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index bba73ddd0585..33725b761a22 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -24,7 +24,6 @@
 #include "xfs_error.h"
 #include "xfs_log_priv.h"
 #include "xfs_log_recover.h"
-#include "xfs_quota.h"
 
 kmem_zone_t	*xfs_bui_zone;
 kmem_zone_t	*xfs_bud_zone;
@@ -494,18 +493,10 @@ xfs_bui_item_recover(
 			XFS_ATTR_FORK : XFS_DATA_FORK;
 	bui_type = bmap->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
 
-	/* Grab the inode. */
-	error = xfs_iget(mp, NULL, bmap->me_owner, 0, 0, &ip);
+	error = xlog_recover_iget(mp, bmap->me_owner, &ip);
 	if (error)
 		return error;
 
-	error = xfs_qm_dqattach(ip);
-	if (error)
-		goto err_rele;
-
-	if (VFS_I(ip)->i_nlink == 0)
-		xfs_iflags_set(ip, XFS_IRECOVERY);
-
 	/* Allocate transaction and do the work. */
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
 			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 269a4cb34bba..87fde8c875a2 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -29,6 +29,7 @@
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
 #include "xfs_sb.h"
+#include "xfs_swapext.h"
 
 /* Kernel only BMAP related definitions and functions */
 
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 107bb222d79f..54705f6864db 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -25,6 +25,7 @@
 #include "xfs_icache.h"
 #include "xfs_error.h"
 #include "xfs_buf_item.h"
+#include "xfs_quota.h"
 
 #define BLK_AVG(blk1, blk2)	((blk1+blk2) >> 1)
 
@@ -1755,6 +1756,30 @@ xlog_recover_release_intent(
 	spin_unlock(&ailp->ail_lock);
 }
 
+int
+xlog_recover_iget(
+	struct xfs_mount	*mp,
+	xfs_ino_t		ino,
+	struct xfs_inode	**ipp)
+{
+	int			error;
+
+	error = xfs_iget(mp, NULL, ino, 0, 0, ipp);
+	if (error)
+		return error;
+
+	error = xfs_qm_dqattach(*ipp);
+	if (error) {
+		xfs_irele(*ipp);
+		return error;
+	}
+
+	if (VFS_I(*ipp)->i_nlink == 0)
+		xfs_iflags_set(*ipp, XFS_IRECOVERY);
+
+	return 0;
+}
+
 /******************************************************************************
  *
  *		Log recover routines
diff --git a/fs/xfs/xfs_swapext_item.c b/fs/xfs/xfs_swapext_item.c
index 83913e9fd4d4..4dba3879bec8 100644
--- a/fs/xfs/xfs_swapext_item.c
+++ b/fs/xfs/xfs_swapext_item.c
@@ -16,13 +16,16 @@
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
 
 kmem_zone_t	*xfs_sxi_zone;
 kmem_zone_t	*xfs_sxd_zone;
@@ -195,13 +198,318 @@ static const struct xfs_item_ops xfs_sxd_item_ops = {
 	.iop_release	= xfs_sxd_item_release,
 };
 
+static struct xfs_sxd_log_item *
+xfs_trans_get_sxd(
+	struct xfs_trans		*tp,
+	struct xfs_sxi_log_item		*sxi_lip)
+{
+	struct xfs_sxd_log_item		*sxd_lip;
+
+	sxd_lip = kmem_cache_zalloc(xfs_sxd_zone, GFP_KERNEL | __GFP_NOFAIL);
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
+STATIC void
+xfs_swapext_log_item(
+	struct xfs_trans		*tp,
+	struct xfs_sxi_log_item		*sxi_lip,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_swap_extent		*sx;
+
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
+}
+
+STATIC struct xfs_log_item *
+xfs_swapext_create_intent(
+	struct xfs_trans		*tp,
+	struct list_head		*items,
+	unsigned int			count,
+	bool				sort)
+{
+	struct xfs_sxi_log_item		*sxi_lip = xfs_sxi_init(tp->t_mountp);
+	struct xfs_swapext_intent	*sxi;
+
+	ASSERT(count == XFS_SXI_MAX_FAST_EXTENTS);
+
+	/*
+	 * We use the same defer ops control machinery to perform extent swaps
+	 * even if we lack the machinery to track the operation status through
+	 * log items.
+	 */
+	if (!xfs_sb_version_hasatomicswap(&tp->t_mountp->m_sb))
+		return NULL;
+
+	xfs_trans_add_item(tp, &sxi_lip->sxi_item);
+	list_for_each_entry(sxi, items, sxi_list)
+		xfs_swapext_log_item(tp, sxi_lip, sxi);
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
+	if (!error && xfs_swapext_has_more_work(sxi))
+		return -EAGAIN;
+
+	kmem_free(sxi);
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
+	kmem_free(sxi);
+}
+
+const struct xfs_defer_op_type xfs_swapext_defer_type = {
+	.max_items	= XFS_SXI_MAX_FAST_EXTENTS,
+	.create_intent	= xfs_swapext_create_intent,
+	.abort_intent	= xfs_swapext_abort_intent,
+	.create_done	= xfs_swapext_create_done,
+	.finish_item	= xfs_swapext_finish_item,
+	.cancel_item	= xfs_swapext_cancel_item,
+};
+
+static int
+xfs_sxi_item_recover_estimate(
+	struct xfs_swapext_intent	*sxi,
+	struct xfs_swapext_res		*res)
+{
+	struct xfs_swapext_req		req = {
+		.ip1			= sxi->sxi_ip1,
+		.ip2			= sxi->sxi_ip2,
+		.startoff1		= sxi->sxi_startoff1,
+		.startoff2		= sxi->sxi_startoff2,
+		.blockcount		= sxi->sxi_blockcount,
+		.whichfork		= XFS_DATA_FORK,
+	};
+
+	if (sxi->sxi_flags & XFS_SWAP_EXTENT_ATTR_FORK)
+		req.whichfork = XFS_ATTR_FORK;
+	if (sxi->sxi_flags & XFS_SWAP_EXTENT_SET_SIZES)
+		req.flags |= XFS_SWAPEXT_SET_SIZES;
+	if (sxi->sxi_flags & XFS_SWAP_EXTENT_SKIP_FILE1_HOLES)
+		req.flags |= XFS_SWAPEXT_SKIP_FILE1_HOLES;
+
+	return xfs_xchg_range_estimate(&req, res);
+}
+
+/* Is this recovered SXI ok? */
+static inline bool
+xfs_sxi_validate(
+	struct xfs_mount		*mp,
+	struct xfs_sxi_log_item		*sxi_lip)
+{
+	struct xfs_swap_extent		*sx = &sxi_lip->sxi_format.sxi_extent;
+
+	if (!xfs_sb_version_hasatomicswap(&mp->m_sb))
+		return false;
+
+	if (sxi_lip->sxi_format.__pad != 0)
+		return false;
+
+	if (sx->sx_flags & ~XFS_SWAP_EXTENT_FLAGS)
+		return false;
+
+	if (!xfs_verify_ino(mp, sx->sx_inode1) ||
+	    !xfs_verify_ino(mp, sx->sx_inode2))
+		return false;
+
+	if ((sx->sx_flags & XFS_SWAP_EXTENT_SET_SIZES) &&
+	     (sx->sx_isize1 < 0 || sx->sx_isize2 < 0))
+		return false;
+
+	if (!xfs_verify_fileext(mp, sx->sx_startoff1, sx->sx_blockcount))
+		return false;
+
+	return xfs_verify_fileext(mp, sx->sx_startoff2, sx->sx_blockcount);
+}
+
 /* Process a swapext update intent item that was recovered from the log. */
 STATIC int
 xfs_sxi_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
-	return -EFSCORRUPTED;
+	struct xfs_swapext_intent	sxi;
+	struct xfs_swapext_res		res;
+	struct xfs_sxi_log_item		*sxi_lip = SXI_ITEM(lip);
+	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_swap_extent		*sx = &sxi_lip->sxi_format.sxi_extent;
+	struct xfs_sxd_log_item		*sxd_lip = NULL;
+	struct xfs_trans		*tp;
+	bool				more_work;
+	int				error = 0;
+
+	if (!xfs_sxi_validate(mp, sxi_lip)) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&sxi_lip->sxi_format,
+				sizeof(sxi_lip->sxi_format));
+		return -EFSCORRUPTED;
+	}
+
+	memset(&sxi, 0, sizeof(sxi));
+	INIT_LIST_HEAD(&sxi.sxi_list);
+
+	/*
+	 * Grab both inodes and set IRECOVERY to prevent trimming of post-eof
+	 * extents and freeing of unlinked inodes until we're totally done
+	 * processing files.
+	 */
+	error = xlog_recover_iget(mp, sx->sx_inode1, &sxi.sxi_ip1);
+	if (error)
+		return error;
+	error = xlog_recover_iget(mp, sx->sx_inode2, &sxi.sxi_ip2);
+	if (error)
+		goto err_rele1;
+
+	/*
+	 * Construct the rest of our in-core swapext intent state so that we
+	 * can allocate all the resources we need to continue the swap work.
+	 */
+	sxi.sxi_flags = sx->sx_flags;
+	sxi.sxi_startoff1 = sx->sx_startoff1;
+	sxi.sxi_startoff2 = sx->sx_startoff2;
+	sxi.sxi_blockcount = sx->sx_blockcount;
+	sxi.sxi_isize1 = sx->sx_isize1;
+	sxi.sxi_isize2 = sx->sx_isize2;
+	error = xfs_sxi_item_recover_estimate(&sxi, &res);
+	if (error)
+		goto err_rele2;
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, res.resblks, 0,
+			0, &tp);
+	if (error)
+		goto err_rele2;
+
+	sxd_lip = xfs_trans_get_sxd(tp, sxi_lip);
+
+	xfs_xchg_range_ilock(tp, sxi.sxi_ip1, sxi.sxi_ip2);
+
+	error = xfs_swapext_finish_update(tp, &sxd_lip->sxd_item, &sxi);
+	if (error)
+		goto err_cancel;
+
+	/*
+	 * If there's more extent swapping to be done, we have to schedule that
+	 * as a separate deferred operation to be run after we've finished
+	 * replaying all of the intents we recovered from the log.
+	 */
+	more_work = xfs_swapext_has_more_work(&sxi);
+	if (more_work)
+		xfs_swapext_reschedule(tp, &sxi);
+
+	/*
+	 * Commit transaction, which frees the transaction and saves the inodes
+	 * for later replay activities.
+	 */
+	error = xfs_defer_ops_capture_and_commit(tp, sxi.sxi_ip1, sxi.sxi_ip2,
+			capture_list);
+	goto err_unlock;
+
+err_cancel:
+	xfs_trans_cancel(tp);
+err_unlock:
+	xfs_xchg_range_iunlock(sxi.sxi_ip1, sxi.sxi_ip2);
+err_rele2:
+	if (sxi.sxi_ip2 != sxi.sxi_ip1)
+		xfs_irele(sxi.sxi_ip2);
+err_rele1:
+	xfs_irele(sxi.sxi_ip1);
+	return error;
 }
 
 STATIC bool
@@ -218,8 +526,21 @@ xfs_sxi_item_relog(
 	struct xfs_log_item		*intent,
 	struct xfs_trans		*tp)
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
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 9b8d703dc9fd..f8cceacfb51d 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -30,6 +30,7 @@
 #include "xfs_fsmap.h"
 #include "xfs_btree_staging.h"
 #include "xfs_icache.h"
+#include "xfs_swapext.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e5cc6f2a4fa8..dc9cc3c67e58 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -38,6 +38,9 @@ struct xfs_inobt_rec_incore;
 union xfs_btree_ptr;
 struct xfs_dqtrx;
 struct xfs_eofblocks;
+struct xfs_swapext_intent;
+struct xfs_swapext_req;
+struct xfs_swapext_res;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -3316,6 +3319,9 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
 DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
 DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
+DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
+DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);
 
 /* fsmap traces */
 DECLARE_EVENT_CLASS(xfs_fsmap_class,
@@ -3945,6 +3951,185 @@ DEFINE_EOFBLOCKS_EVENT(xfs_ioc_free_eofblocks);
 DEFINE_EOFBLOCKS_EVENT(xfs_blockgc_free_space);
 DEFINE_EOFBLOCKS_EVENT(xfs_inodegc_free_space);
 
+#define XFS_SWAPEXT_STRINGS \
+	{ XFS_SWAPEXT_SET_SIZES,		"SETSIZES" }, \
+	{ XFS_SWAPEXT_SKIP_FILE1_HOLES,		"SKIP_FILE1_HOLES" }
+
+TRACE_EVENT(xfs_swapext_estimate,
+	TP_PROTO(const struct xfs_swapext_req *req,
+		 const struct xfs_swapext_res *res),
+	TP_ARGS(req, res),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(xfs_fileoff_t, startoff1)
+		__field(xfs_fileoff_t, startoff2)
+		__field(xfs_filblks_t, blockcount)
+		__field(int, whichfork)
+		__field(unsigned int, flags)
+		__field(xfs_filblks_t, ip1_bcount)
+		__field(xfs_filblks_t, ip2_bcount)
+		__field(xfs_filblks_t, ip1_rtbcount)
+		__field(xfs_filblks_t, ip2_rtbcount)
+		__field(unsigned long long, resblks)
+		__field(unsigned int, nr_exchanges)
+	),
+	TP_fast_assign(
+		__entry->dev = req->ip1->i_mount->m_super->s_dev;
+		__entry->ino1 = req->ip1->i_ino;
+		__entry->ino2 = req->ip2->i_ino;
+		__entry->startoff1 = req->startoff1;
+		__entry->startoff2 = req->startoff2;
+		__entry->blockcount = req->blockcount;
+		__entry->whichfork = req->whichfork;
+		__entry->flags = req->flags;
+		__entry->ip1_bcount = res->ip1_bcount;
+		__entry->ip2_bcount = res->ip2_bcount;
+		__entry->ip1_rtbcount = res->ip1_rtbcount;
+		__entry->ip2_rtbcount = res->ip2_rtbcount;
+		__entry->resblks = res->resblks;
+		__entry->nr_exchanges = res->nr_exchanges;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx startoff1 %llu ino2 0x%llx startoff2 %llu blockcount %llu flags (%s) %sfork bcount1 %llu rtbcount1 %llu bcount2 %llu rtbcount2 %llu resblks %llu nr_exchanges %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->startoff1,
+		  __entry->ino2, __entry->startoff2,
+		  __entry->blockcount,
+		  __print_flags(__entry->flags, "|", XFS_SWAPEXT_STRINGS),
+		  __entry->whichfork == XFS_ATTR_FORK ? "attr" : "data",
+		  __entry->ip1_bcount,
+		  __entry->ip1_rtbcount,
+		  __entry->ip2_bcount,
+		  __entry->ip2_rtbcount,
+		  __entry->resblks,
+		  __entry->nr_exchanges)
+);
+
+#define XFS_SWAP_EXTENT_STRINGS \
+	{ XFS_SWAP_EXTENT_ATTR_FORK,		"ATTRFORK" }, \
+	{ XFS_SWAP_EXTENT_SET_SIZES,		"SETSIZES" }, \
+	{ XFS_SWAP_EXTENT_SKIP_FILE1_HOLES,	"SKIP_FILE1_HOLES" }
+
+TRACE_EVENT(xfs_swapext_defer,
+	TP_PROTO(struct xfs_mount *mp, const struct xfs_swapext_intent *sxi),
+	TP_ARGS(mp, sxi),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino1)
+		__field(xfs_ino_t, ino2)
+		__field(uint64_t, flags)
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
+		__entry->startoff1 = sxi->sxi_startoff1;
+		__entry->startoff2 = sxi->sxi_startoff2;
+		__entry->blockcount = sxi->sxi_blockcount;
+		__entry->isize1 = sxi->sxi_ip1->i_d.di_size;
+		__entry->isize2 = sxi->sxi_ip2->i_d.di_size;
+		__entry->new_isize1 = sxi->sxi_isize1;
+		__entry->new_isize2 = sxi->sxi_isize2;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx startoff1 %llu ino2 0x%llx startoff2 %llu blockcount %llu flags (%s) isize1 %lld newisize1 %lld isize2 %lld newisize2 %lld",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->startoff1,
+		  __entry->ino2, __entry->startoff2,
+		  __entry->blockcount,
+		  __print_flags(__entry->flags, "|", XFS_SWAP_EXTENT_STRINGS),
+		  __entry->isize1, __entry->new_isize1,
+		  __entry->isize2, __entry->new_isize2)
+);
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
+	TP_printk("dev %d;%d left %llu:%lld:%llu; curr %llu:%lld:%llu <- new %llu:%lld:%llu; right %llu:%lld:%llu delta %d state x%x",
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
+		__entry->nexts1 = XFS_IFORK_PTR(req->ip1, req->whichfork)->if_nextents;
+		__entry->nexts2 = XFS_IFORK_PTR(req->ip2, req->whichfork)->if_nextents;
+		__entry->d_nexts1 = d_nexts1;
+		__entry->d_nexts2 = d_nexts2;
+	),
+	TP_printk("dev %d:%d ino1 0x%llx nexts %u ino2 0x%llx nexts %u delta1 %lld delta2 %lld",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino1, __entry->nexts1,
+		  __entry->ino2, __entry->nexts2,
+		  __entry->d_nexts1, __entry->d_nexts2)
+);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
new file mode 100644
index 000000000000..5e7098d5838e
--- /dev/null
+++ b/fs/xfs/xfs_xchgrange.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
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
+#include "xfs_swapext.h"
+#include "xfs_xchgrange.h"
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
+	const struct xfs_swapext_req	*req,
+	struct xfs_swapext_res		*res)
+{
+	int				error;
+
+	xfs_xchg_range_ilock(NULL, req->ip1, req->ip2);
+	error = xfs_swapext_estimate(req, res);
+	xfs_xchg_range_iunlock(req->ip1, req->ip2);
+	return error;
+}
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
new file mode 100644
index 000000000000..ddda2bfb6f4b
--- /dev/null
+++ b/fs/xfs/xfs_xchgrange.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_XCHGRANGE_H__
+#define __XFS_XCHGRANGE_H__
+
+struct xfs_swapext_req;
+struct xfs_swapext_res;
+
+void xfs_xchg_range_ilock(struct xfs_trans *tp, struct xfs_inode *ip1,
+		struct xfs_inode *ip2);
+void xfs_xchg_range_iunlock(struct xfs_inode *ip1, struct xfs_inode *ip2);
+
+int xfs_xchg_range_estimate(const struct xfs_swapext_req *req,
+		struct xfs_swapext_res *res);
+
+#endif /* __XFS_XCHGRANGE_H__ */

