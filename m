Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA02350BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhDABKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232953AbhDABJo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A1A161057;
        Thu,  1 Apr 2021 01:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239383;
        bh=raR0GSITZN2TjnODcnCMnimE/KtsLVOh73RZT0twwwg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UxsPjNexZlI2qUy/SxiDuWG640aSinAp7Cj2FCVxKIFIIT7ruGw9dLeqgh3SAU8s6
         POtM4RzzKp682SB7PWzLaz1Ed0sTJ5Odvw9RZKo6YGw+yOlxTlJEq+WoFrqalhrQsA
         7RlBH6+EVuns/VH/Vw19lrHS92f1lOUb0hH8aM1ROXJ8sPKa1/JNghaSNcFvqd5weL
         7Sy5yTPjbj3/ZYUl5R30Et796zqoyJkwTJlln6leU42ivG+WeDbx7riBncRvR7bydz
         rKAoj84vnl6J3cXmwlRCcliz086PB/s3JFBfna+7V/seuyaWNfeSunnUPcTDqRbaSW
         6R92cnYYQrkvg==
Subject: [PATCH 10/18] xfs: port xfs_swap_extents_rmap to our new code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:42 -0700
Message-ID: <161723938272.3149451.1207557688320964773.stgit@magnolia>
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

The inner loop of xfs_swap_extents_rmap does the same work as
xfs_swapext_finish_one, so adapt it to use that.  Doing so has the side
benefit that the older code path no longer wastes its time remapping
shared extents.

This forms the basis of the non-atomic swaprange implementation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  143 ++++--------------------------------------------
 fs/xfs/xfs_trace.h     |    5 --
 2 files changed, 14 insertions(+), 134 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 87fde8c875a2..2881583bb957 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1358,132 +1358,6 @@ xfs_swap_extent_flush(
 	return 0;
 }
 
-/*
- * Move extents from one file to another, when rmap is enabled.
- */
-STATIC int
-xfs_swap_extent_rmap(
-	struct xfs_trans		**tpp,
-	struct xfs_inode		*ip,
-	struct xfs_inode		*tip)
-{
-	struct xfs_trans		*tp = *tpp;
-	struct xfs_bmbt_irec		irec;
-	struct xfs_bmbt_irec		uirec;
-	struct xfs_bmbt_irec		tirec;
-	xfs_fileoff_t			offset_fsb;
-	xfs_fileoff_t			end_fsb;
-	xfs_filblks_t			count_fsb;
-	int				error;
-	xfs_filblks_t			ilen;
-	xfs_filblks_t			rlen;
-	int				nimaps;
-	uint64_t			tip_flags2;
-
-	/*
-	 * If the source file has shared blocks, we must flag the donor
-	 * file as having shared blocks so that we get the shared-block
-	 * rmap functions when we go to fix up the rmaps.  The flags
-	 * will be switch for reals later.
-	 */
-	tip_flags2 = tip->i_d.di_flags2;
-	if (ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)
-		tip->i_d.di_flags2 |= XFS_DIFLAG2_REFLINK;
-
-	offset_fsb = 0;
-	end_fsb = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
-	count_fsb = (xfs_filblks_t)(end_fsb - offset_fsb);
-
-	while (count_fsb) {
-		/* Read extent from the donor file */
-		nimaps = 1;
-		error = xfs_bmapi_read(tip, offset_fsb, count_fsb, &tirec,
-				&nimaps, 0);
-		if (error)
-			goto out;
-		ASSERT(nimaps == 1);
-		ASSERT(tirec.br_startblock != DELAYSTARTBLOCK);
-
-		trace_xfs_swap_extent_rmap_remap(tip, &tirec);
-		ilen = tirec.br_blockcount;
-
-		/* Unmap the old blocks in the source file. */
-		while (tirec.br_blockcount) {
-			ASSERT(tp->t_firstblock == NULLFSBLOCK);
-			trace_xfs_swap_extent_rmap_remap_piece(tip, &tirec);
-
-			/* Read extent from the source file */
-			nimaps = 1;
-			error = xfs_bmapi_read(ip, tirec.br_startoff,
-					tirec.br_blockcount, &irec,
-					&nimaps, 0);
-			if (error)
-				goto out;
-			ASSERT(nimaps == 1);
-			ASSERT(tirec.br_startoff == irec.br_startoff);
-			trace_xfs_swap_extent_rmap_remap_piece(ip, &irec);
-
-			/* Trim the extent. */
-			uirec = tirec;
-			uirec.br_blockcount = rlen = min_t(xfs_filblks_t,
-					tirec.br_blockcount,
-					irec.br_blockcount);
-			trace_xfs_swap_extent_rmap_remap_piece(tip, &uirec);
-
-			if (xfs_bmap_is_real_extent(&uirec)) {
-				error = xfs_iext_count_may_overflow(ip,
-						XFS_DATA_FORK,
-						XFS_IEXT_SWAP_RMAP_CNT);
-				if (error)
-					goto out;
-			}
-
-			if (xfs_bmap_is_real_extent(&irec)) {
-				error = xfs_iext_count_may_overflow(tip,
-						XFS_DATA_FORK,
-						XFS_IEXT_SWAP_RMAP_CNT);
-				if (error)
-					goto out;
-			}
-
-			/* Remove the mapping from the donor file. */
-			xfs_bmap_unmap_extent(tp, tip, XFS_DATA_FORK, &uirec);
-
-			/* Remove the mapping from the source file. */
-			xfs_bmap_unmap_extent(tp, ip, XFS_DATA_FORK, &irec);
-
-			/* Map the donor file's blocks into the source file. */
-			xfs_bmap_map_extent(tp, ip, XFS_DATA_FORK, &uirec);
-
-			/* Map the source file's blocks into the donor file. */
-			xfs_bmap_map_extent(tp, tip, XFS_DATA_FORK, &irec);
-
-			error = xfs_defer_finish(tpp);
-			tp = *tpp;
-			if (error)
-				goto out;
-
-			tirec.br_startoff += rlen;
-			if (tirec.br_startblock != HOLESTARTBLOCK &&
-			    tirec.br_startblock != DELAYSTARTBLOCK)
-				tirec.br_startblock += rlen;
-			tirec.br_blockcount -= rlen;
-		}
-
-		/* Roll on... */
-		count_fsb -= ilen;
-		offset_fsb += ilen;
-	}
-
-	tip->i_d.di_flags2 = tip_flags2;
-	return 0;
-
-out:
-	trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
-	tip->i_d.di_flags2 = tip_flags2;
-	return error;
-}
-
 /* Swap the extents of two files by swapping data forks. */
 STATIC int
 xfs_swap_extent_forks(
@@ -1769,13 +1643,22 @@ xfs_swap_extents(
 	src_log_flags = XFS_ILOG_CORE;
 	target_log_flags = XFS_ILOG_CORE;
 
-	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
-		error = xfs_swap_extent_rmap(&tp, ip, tip);
-	else
+	if (xfs_sb_version_hasrmapbt(&mp->m_sb)) {
+		struct xfs_swapext_req	req = {
+			.ip1		= ip,
+			.ip2		= tip,
+			.whichfork	= XFS_DATA_FORK,
+			.blockcount	= XFS_B_TO_FSB(ip->i_mount,
+						       i_size_read(VFS_I(ip))),
+		};
+		error = xfs_swapext(&tp, &req);
+	} else
 		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
 				&target_log_flags);
-	if (error)
+	if (error) {
+		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
+	}
 
 	/* Do we have to swap reflink flags? */
 	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index f4e739e81594..f2db023986a4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3315,14 +3315,11 @@ DEFINE_INODE_ERROR_EVENT(xfs_reflink_end_cow_error);
 
 DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 
-/* rmap swapext tracepoints */
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
-DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
 
 /* swapext tracepoints */
 DEFINE_DOUBLE_IO_EVENT(xfs_file_xchg_range);
 DEFINE_INODE_ERROR_EVENT(xfs_file_xchg_range_error);
+DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);

