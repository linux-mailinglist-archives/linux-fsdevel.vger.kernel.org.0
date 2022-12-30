Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C0659EDC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiL3XxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiL3XxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:53:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4D1E3E2;
        Fri, 30 Dec 2022 15:53:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2649B80883;
        Fri, 30 Dec 2022 23:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9E1C433EF;
        Fri, 30 Dec 2022 23:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444380;
        bh=6jDbZQzQFUtiKixlRWE6RAZepECmkaHvKDIqDs7AvPc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YgGHsEf9Q5wDgVCzgcAYAdDIj4oRrnmG41tG+p1YQV1MnxMvuBKl+UDzrbpeZ6tWv
         SS9nWTqKuSU8+jKuOshF/95S54PVT7nkTe3JfMD7ONB2gbzXBfR0zLvfE6xFjBKm2o
         OmBvgyL/wuJnRSRB2gNWSerbF/G6US3PxGQR1CEVt9DE5bJgR0kXHrE6+FurLp2lOL
         GgwDTtgBwwWfMJ4Ys3xENvl6+eruEAd6ZvtiCSvi2mh1A22jwcauKxq8kDQDT0hIOm
         +qWcell0ca8QmYHeIsn5ymyxDiFTycEs2gQ3iK44VVxpGIRxbrhuNaiMzdfIrDO20N
         CxE1JbFfUiL+g==
Subject: [PATCH 11/21] xfs: port xfs_swap_extents_rmap to our new code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:56 -0800
Message-ID: <167243843684.699466.18215544953813368074.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/xfs/xfs_bmap_util.c |  151 +++++-------------------------------------------
 fs/xfs/xfs_trace.h     |    5 --
 2 files changed, 16 insertions(+), 140 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index d587015aec0e..4d4696bf9b08 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1360,138 +1360,6 @@ xfs_swap_extent_flush(
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
-	tip_flags2 = tip->i_diflags2;
-	if (ip->i_diflags2 & XFS_DIFLAG2_REFLINK)
-		tip->i_diflags2 |= XFS_DIFLAG2_REFLINK;
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
-				if (error == -EFBIG)
-					error = xfs_iext_count_upgrade(tp, ip,
-							XFS_IEXT_SWAP_RMAP_CNT);
-				if (error)
-					goto out;
-			}
-
-			if (xfs_bmap_is_real_extent(&irec)) {
-				error = xfs_iext_count_may_overflow(tip,
-						XFS_DATA_FORK,
-						XFS_IEXT_SWAP_RMAP_CNT);
-				if (error == -EFBIG)
-					error = xfs_iext_count_upgrade(tp, ip,
-							XFS_IEXT_SWAP_RMAP_CNT);
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
-	tip->i_diflags2 = tip_flags2;
-	return 0;
-
-out:
-	trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
-	tip->i_diflags2 = tip_flags2;
-	return error;
-}
-
 /* Swap the extents of two files by swapping data forks. */
 STATIC int
 xfs_swap_extent_forks(
@@ -1775,13 +1643,24 @@ xfs_swap_extents(
 	src_log_flags = XFS_ILOG_CORE;
 	target_log_flags = XFS_ILOG_CORE;
 
-	if (xfs_has_rmapbt(mp))
-		error = xfs_swap_extent_rmap(&tp, ip, tip);
-	else
+	if (xfs_has_rmapbt(mp)) {
+		struct xfs_swapext_req	req = {
+			.ip1		= tip,
+			.ip2		= ip,
+			.whichfork	= XFS_DATA_FORK,
+			.blockcount	= XFS_B_TO_FSB(ip->i_mount,
+						       i_size_read(VFS_I(ip))),
+		};
+
+		xfs_swapext(tp, &req);
+		error = xfs_defer_finish(&tp);
+	} else
 		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
 				&target_log_flags);
-	if (error)
+	if (error) {
+		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
+	}
 
 	/* Do we have to swap reflink flags? */
 	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 6841f04ee38d..b0ced76af3b9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3759,13 +3759,10 @@ DEFINE_INODE_ERROR_EVENT(xfs_reflink_end_cow_error);
 
 DEFINE_INODE_IREC_EVENT(xfs_reflink_cancel_cow);
 
-/* rmap swapext tracepoints */
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap);
-DEFINE_INODE_IREC_EVENT(xfs_swap_extent_rmap_remap_piece);
-DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_rmap_error);
 
 /* swapext tracepoints */
 DEFINE_INODE_ERROR_EVENT(xfs_file_xchg_range_error);
+DEFINE_INODE_ERROR_EVENT(xfs_swap_extent_error);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent1);
 DEFINE_INODE_IREC_EVENT(xfs_swapext_extent2);
 DEFINE_ITRUNC_EVENT(xfs_swapext_update_inode_size);

