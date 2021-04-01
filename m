Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0283350BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDABKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhDABKM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A263361059;
        Thu,  1 Apr 2021 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239411;
        bh=T5PUl359kzo+vFmrOpMOYvPBRBzKhRrOfmi+b8Rnx7Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jtpp2PRN8XRQtEnnTrpKOkU0LwgSShEl84ybdUXe0k5uDNm1k4hhAPfDsCVU4swvb
         egtCEm5+TklUEPMxgV3BAsXdwHCxCS/flfG0HCZhq9Q+yyQeVs+gLK4lRPS0AqTCND
         QyDCCNXf9lCPFBiIrlsvkCnElDk2cZhZwbkwV3JZg/92vZXEBnYR3RdttKZ6bAkZWB
         zwoM0EFSAOzgcy4V75E0nRifEgO3ZX14a8IhS4JQwCvqUgGMKyyMAOhlPE8QPoJVB7
         xCfGwoFCCgl/qn8+lP5ioj4USLww8CZ9m9Gik6gh/Idyi7DLXUfC9MD76vzXCWUJZM
         4P72DIToRDfWw==
Subject: [PATCH 15/18] xfs: condense extended attributes after an atomic swap
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:10:10 -0700
Message-ID: <161723941063.3149451.11685074660218933956.stgit@magnolia>
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

Add a new swapext flag that enables us to perform post-swap processing
on file2 once we're done swapping the extent maps.  If we were swapping
the extended attributes, we want to be able to convert file2's attr fork
from block to inline format.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online xattr repair feature can create
salvaged attrs in a temporary file and swap the attr forks when ready.
If one file is in extents format and the other is inline, we will have to
promote both to extents format to perform the swap.  After the swap, we
can try to condense the fixed file's attr fork back down to inline
format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_log_format.h |    6 ++++
 fs/xfs/libxfs/xfs_swapext.c    |   56 ++++++++++++++++++++++++++++++++++++++--
 fs/xfs/libxfs/xfs_swapext.h    |    5 ++++
 fs/xfs/xfs_trace.h             |    6 +++-
 4 files changed, 67 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 52ca6d72de6a..9cca7db4c663 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -814,9 +814,13 @@ struct xfs_swap_extent {
 /* Do not swap any part of the range where file1's mapping is a hole. */
 #define XFS_SWAP_EXTENT_SKIP_FILE1_HOLES (1ULL << 2)
 
+/* Try to convert inode2 from block to short format at the end, if possible. */
+#define XFS_SWAP_EXTENT_INO2_SHORTFORM	(1ULL << 3)
+
 #define XFS_SWAP_EXTENT_FLAGS		(XFS_SWAP_EXTENT_ATTR_FORK | \
 					 XFS_SWAP_EXTENT_SET_SIZES | \
-					 XFS_SWAP_EXTENT_SKIP_FILE1_HOLES)
+					 XFS_SWAP_EXTENT_SKIP_FILE1_HOLES | \
+					 XFS_SWAP_EXTENT_INO2_SHORTFORM)
 
 /* This is the structure used to lay out an sxi log item in the log. */
 struct xfs_sxi_log_format {
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 082680635146..964af61c9e5d 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -22,6 +22,9 @@
 #include "xfs_trans_space.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_attr_leaf.h"
 
 /* Information to help us reset reflink flag / CoW fork state after a swap. */
 
@@ -196,12 +199,46 @@ xfs_swapext_update_size(
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 }
 
+/* Convert inode2's leaf attr fork back to shortform, if possible.. */
+STATIC int
+xfs_swapext_attr_to_shortform2(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_da_args	args = {
+		.dp		= sxi->sxi_ip2,
+		.geo		= tp->t_mountp->m_attr_geo,
+		.whichfork	= XFS_ATTR_FORK,
+		.trans		= tp,
+	};
+	struct xfs_buf		*bp;
+	int			forkoff;
+	int			error;
+
+	if (!xfs_bmap_one_block(sxi->sxi_ip2, XFS_ATTR_FORK))
+		return 0;
+
+	error = xfs_attr3_leaf_read(tp, sxi->sxi_ip2, 0, &bp);
+	if (error)
+		return error;
+
+	forkoff = xfs_attr_shortform_allfit(bp, sxi->sxi_ip2);
+	if (forkoff == 0)
+		return 0;
+
+	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
+}
+
+/* Mask of all flags that require post-processing of file2. */
+#define XFS_SWAP_EXTENT_POST_PROCESSING (XFS_SWAP_EXTENT_INO2_SHORTFORM)
+
 /* Do we have more work to do to finish this operation? */
 bool
 xfs_swapext_has_more_work(
 	struct xfs_swapext_intent	*sxi)
 {
-	return sxi->sxi_blockcount > 0;
+	return sxi->sxi_blockcount > 0 ||
+		(sxi->sxi_flags & XFS_SWAP_EXTENT_POST_PROCESSING);
 }
 
 /* Check all extents to make sure we can actually swap them. */
@@ -273,12 +310,23 @@ xfs_swapext_finish_one(
 	int				whichfork;
 	int				nimaps;
 	int				bmap_flags;
-	int				error;
+	int				error = 0;
 
 	whichfork = (sxi->sxi_flags & XFS_SWAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
 	bmap_flags = xfs_bmapi_aflag(whichfork);
 
+	/* Do any post-processing work that we requires a transaction roll. */
+	if (sxi->sxi_blockcount == 0) {
+		if (sxi->sxi_flags & XFS_SWAP_EXTENT_INO2_SHORTFORM) {
+			if (sxi->sxi_flags & XFS_SWAP_EXTENT_ATTR_FORK)
+				error = xfs_swapext_attr_to_shortform2(tp, sxi);
+			sxi->sxi_flags &= ~XFS_SWAP_EXTENT_INO2_SHORTFORM;
+			return error;
+		}
+		return 0;
+	}
+
 	while (sxi->sxi_blockcount > 0) {
 		/* Read extent from the first file */
 		nimaps = 1;
@@ -419,7 +467,7 @@ xfs_swapext_finish_one(
 }
 
 /* Estimate the bmbt and rmapbt overhead required to exchange extents. */
-static int
+int
 xfs_swapext_estimate_overhead(
 	const struct xfs_swapext_req	*req,
 	struct xfs_swapext_res		*res)
@@ -838,6 +886,8 @@ xfs_swapext_init_intent(
 	}
 	if (req->flags & XFS_SWAPEXT_SKIP_FILE1_HOLES)
 		sxi->sxi_flags |= XFS_SWAP_EXTENT_SKIP_FILE1_HOLES;
+	if (req->flags & XFS_SWAPEXT_INO2_SHORTFORM)
+		sxi->sxi_flags |= XFS_SWAP_EXTENT_INO2_SHORTFORM;
 	sxi->sxi_ip1 = req->ip1;
 	sxi->sxi_ip2 = req->ip2;
 	sxi->sxi_startoff1 = req->startoff1;
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index e63f4a5556c1..68842d62ec82 100644
--- a/fs/xfs/libxfs/xfs_swapext.h
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -41,6 +41,9 @@ struct xfs_swapext_intent {
 /* Do not swap any part of the range where file1's mapping is a hole. */
 #define XFS_SWAPEXT_SKIP_FILE1_HOLES	(1U << 1)
 
+/* Try to convert inode2's fork to local format, if possible. */
+#define XFS_SWAPEXT_INO2_SHORTFORM	(1U << 2)
+
 /* Parameters for a swapext request. */
 struct xfs_swapext_req {
 	struct xfs_inode	*ip1;
@@ -68,6 +71,8 @@ unsigned int xfs_swapext_reflink_prep(const struct xfs_swapext_req *req);
 void xfs_swapext_reflink_finish(struct xfs_trans *tp,
 		const struct xfs_swapext_req *req, unsigned int reflink_state);
 
+int xfs_swapext_estimate_overhead(const struct xfs_swapext_req *req,
+		struct xfs_swapext_res *res);
 int xfs_swapext_estimate(const struct xfs_swapext_req *req,
 		struct xfs_swapext_res *res);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index f2db023986a4..915f3856a04a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3954,7 +3954,8 @@ DEFINE_EOFBLOCKS_EVENT(xfs_inodegc_free_space);
 
 #define XFS_SWAPEXT_STRINGS \
 	{ XFS_SWAPEXT_SET_SIZES,		"SETSIZES" }, \
-	{ XFS_SWAPEXT_SKIP_FILE1_HOLES,		"SKIP_FILE1_HOLES" }
+	{ XFS_SWAPEXT_SKIP_FILE1_HOLES,		"SKIP_FILE1_HOLES" }, \
+	{ XFS_SWAPEXT_INO2_SHORTFORM,		"INO2_SHORTFORM" }
 
 TRACE_EVENT(xfs_swapext_estimate,
 	TP_PROTO(const struct xfs_swapext_req *req,
@@ -4010,7 +4011,8 @@ TRACE_EVENT(xfs_swapext_estimate,
 #define XFS_SWAP_EXTENT_STRINGS \
 	{ XFS_SWAP_EXTENT_ATTR_FORK,		"ATTRFORK" }, \
 	{ XFS_SWAP_EXTENT_SET_SIZES,		"SETSIZES" }, \
-	{ XFS_SWAP_EXTENT_SKIP_FILE1_HOLES,	"SKIP_FILE1_HOLES" }
+	{ XFS_SWAP_EXTENT_SKIP_FILE1_HOLES,	"SKIP_FILE1_HOLES" }, \
+	{ XFS_SWAP_EXTENT_INO2_SHORTFORM,	"INO2_SHORTFORM" }
 
 TRACE_EVENT(xfs_swapext_defer,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_swapext_intent *sxi),

