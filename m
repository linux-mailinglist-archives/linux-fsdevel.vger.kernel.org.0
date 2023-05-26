Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7776711C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjEZB1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZB1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50E125;
        Thu, 25 May 2023 18:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7ED560ADA;
        Fri, 26 May 2023 01:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306FBC433D2;
        Fri, 26 May 2023 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064419;
        bh=bPBOoA2XfnHLcv6z/7pE1KexBN4LwiiW6dddsiD/5qY=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=K208Ny9PxXl5eB61cZjAYkqQ1vymbCXn0OG+Cgif3vO2MoJ6N0HcJs9dfuWvbTg1X
         11eUmoRShXW78LVeyljX1VnwnM3Qx1FnRidfWRZ+KHZTW5kk3gz++dxyOsE5Z//R+A
         tJcy8Iz8HdJm9WWdXLZELgSVq8qwGiLgdQa7XzFAk8JkXe1HP6fe6QNWdgLRSDZYUE
         Sx/hI7fakYGXhRbxBHS4ZkBaNkvEGBSiY3hOSBRfdck82aw0fU9HkK8xPfROf5x7wC
         Khmh/kRWwop9muatZ68ops2cZd5YEaBs6SNAPZn95KOhqXC9+pYokH1fWFWEZhKYIG
         aFZ5vrQddb5bA==
Date:   Thu, 25 May 2023 18:26:59 -0700
Subject: [PATCH 19/25] xfs: remove old swap extents implementation
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065255.3734442.10564465892797061161.stgit@frogsfrogsfrogs>
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

Migrate the old XFS_IOC_SWAPEXT implementation to use our shiny new one.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  491 ------------------------------------------------
 fs/xfs/xfs_bmap_util.h |    7 -
 fs/xfs/xfs_ioctl.c     |  102 +++-------
 fs/xfs/xfs_ioctl.h     |    4 
 fs/xfs/xfs_ioctl32.c   |   11 -
 fs/xfs/xfs_xchgrange.c |  299 +++++++++++++++++++++++++++++
 6 files changed, 334 insertions(+), 580 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 0795c1a64af1..eef19e07f581 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1240,494 +1240,3 @@ xfs_insert_file_space(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-
-/*
- * We need to check that the format of the data fork in the temporary inode is
- * valid for the target inode before doing the swap. This is not a problem with
- * attr1 because of the fixed fork offset, but attr2 has a dynamically sized
- * data fork depending on the space the attribute fork is taking so we can get
- * invalid formats on the target inode.
- *
- * E.g. target has space for 7 extents in extent format, temp inode only has
- * space for 6.  If we defragment down to 7 extents, then the tmp format is a
- * btree, but when swapped it needs to be in extent format. Hence we can't just
- * blindly swap data forks on attr2 filesystems.
- *
- * Note that we check the swap in both directions so that we don't end up with
- * a corrupt temporary inode, either.
- *
- * Note that fixing the way xfs_fsr sets up the attribute fork in the source
- * inode will prevent this situation from occurring, so all we do here is
- * reject and log the attempt. basically we are putting the responsibility on
- * userspace to get this right.
- */
-int
-xfs_swap_extents_check_format(
-	struct xfs_inode	*ip,	/* target inode */
-	struct xfs_inode	*tip)	/* tmp inode */
-{
-	struct xfs_ifork	*ifp = &ip->i_df;
-	struct xfs_ifork	*tifp = &tip->i_df;
-
-	/* User/group/project quota ids must match if quotas are enforced. */
-	if (XFS_IS_QUOTA_ON(ip->i_mount) &&
-	    (!uid_eq(VFS_I(ip)->i_uid, VFS_I(tip)->i_uid) ||
-	     !gid_eq(VFS_I(ip)->i_gid, VFS_I(tip)->i_gid) ||
-	     ip->i_projid != tip->i_projid))
-		return -EINVAL;
-
-	/* Should never get a local format */
-	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
-	    tifp->if_format == XFS_DINODE_FMT_LOCAL)
-		return -EINVAL;
-
-	/*
-	 * if the target inode has less extents that then temporary inode then
-	 * why did userspace call us?
-	 */
-	if (ifp->if_nextents < tifp->if_nextents)
-		return -EINVAL;
-
-	/*
-	 * If we have to use the (expensive) rmap swap method, we can
-	 * handle any number of extents and any format.
-	 */
-	if (xfs_has_rmapbt(ip->i_mount))
-		return 0;
-
-	/*
-	 * if the target inode is in extent form and the temp inode is in btree
-	 * form then we will end up with the target inode in the wrong format
-	 * as we already know there are less extents in the temp inode.
-	 */
-	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    tifp->if_format == XFS_DINODE_FMT_BTREE)
-		return -EINVAL;
-
-	/* Check temp in extent form to max in target */
-	if (tifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    tifp->if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
-		return -EINVAL;
-
-	/* Check target in extent form to max in temp */
-	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
-	    ifp->if_nextents > XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
-		return -EINVAL;
-
-	/*
-	 * If we are in a btree format, check that the temp root block will fit
-	 * in the target and that it has enough extents to be in btree format
-	 * in the target.
-	 *
-	 * Note that we have to be careful to allow btree->extent conversions
-	 * (a common defrag case) which will occur when the temp inode is in
-	 * extent format...
-	 */
-	if (tifp->if_format == XFS_DINODE_FMT_BTREE) {
-		if (xfs_inode_has_attr_fork(ip) &&
-		    XFS_BMAP_BMDR_SPACE(tifp->if_broot) > xfs_inode_fork_boff(ip))
-			return -EINVAL;
-		if (tifp->if_nextents <= XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
-			return -EINVAL;
-	}
-
-	/* Reciprocal target->temp btree format checks */
-	if (ifp->if_format == XFS_DINODE_FMT_BTREE) {
-		if (xfs_inode_has_attr_fork(tip) &&
-		    XFS_BMAP_BMDR_SPACE(ip->i_df.if_broot) > xfs_inode_fork_boff(tip))
-			return -EINVAL;
-		if (ifp->if_nextents <= XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int
-xfs_swap_extent_flush(
-	struct xfs_inode	*ip)
-{
-	int	error;
-
-	error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
-	if (error)
-		return error;
-	truncate_pagecache_range(VFS_I(ip), 0, -1);
-
-	/* Verify O_DIRECT for ftmp */
-	if (VFS_I(ip)->i_mapping->nrpages)
-		return -EINVAL;
-	return 0;
-}
-
-/*
- * Fix up the owners of the bmbt blocks to refer to the current inode. The
- * change owner scan attempts to order all modified buffers in the current
- * transaction. In the event of ordered buffer failure, the offending buffer is
- * physically logged as a fallback and the scan returns -EAGAIN. We must roll
- * the transaction in this case to replenish the fallback log reservation and
- * restart the scan. This process repeats until the scan completes.
- */
-static int
-xfs_swap_change_owner(
-	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tmpip)
-{
-	int			error;
-	struct xfs_trans	*tp = *tpp;
-
-	do {
-		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
-					      NULL);
-		/* success or fatal error */
-		if (error != -EAGAIN)
-			break;
-
-		error = xfs_trans_roll(tpp);
-		if (error)
-			break;
-		tp = *tpp;
-
-		/*
-		 * Redirty both inodes so they can relog and keep the log tail
-		 * moving forward.
-		 */
-		xfs_trans_ijoin(tp, ip, 0);
-		xfs_trans_ijoin(tp, tmpip, 0);
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
-	} while (true);
-
-	return error;
-}
-
-/* Swap the extents of two files by swapping data forks. */
-int
-xfs_swap_extent_forks(
-	struct xfs_trans	**tpp,
-	struct xfs_swapext_req	*req)
-{
-	struct xfs_inode	*ip = req->ip2;
-	struct xfs_inode	*tip = req->ip1;
-	xfs_filblks_t		aforkblks = 0;
-	xfs_filblks_t		taforkblks = 0;
-	xfs_extnum_t		junk;
-	uint64_t		tmp;
-	int			src_log_flags = XFS_ILOG_CORE;
-	int			target_log_flags = XFS_ILOG_CORE;
-	int			error;
-
-	/*
-	 * Count the number of extended attribute blocks
-	 */
-	if (xfs_inode_has_attr_fork(ip) && ip->i_af.if_nextents > 0 &&
-	    ip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
-				&aforkblks);
-		if (error)
-			return error;
-	}
-	if (xfs_inode_has_attr_fork(tip) && tip->i_af.if_nextents > 0 &&
-	    tip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
-				&taforkblks);
-		if (error)
-			return error;
-	}
-
-	/*
-	 * Btree format (v3) inodes have the inode number stamped in the bmbt
-	 * block headers. We can't start changing the bmbt blocks until the
-	 * inode owner change is logged so recovery does the right thing in the
-	 * event of a crash. Set the owner change log flags now and leave the
-	 * bmbt scan as the last step.
-	 */
-	if (xfs_has_v3inodes(ip->i_mount)) {
-		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			target_log_flags |= XFS_ILOG_DOWNER;
-		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			src_log_flags |= XFS_ILOG_DOWNER;
-	}
-
-	/*
-	 * Swap the data forks of the inodes
-	 */
-	swap(ip->i_df, tip->i_df);
-
-	/*
-	 * Fix the on-disk inode values
-	 */
-	tmp = (uint64_t)ip->i_nblocks;
-	ip->i_nblocks = tip->i_nblocks - taforkblks + aforkblks;
-	tip->i_nblocks = tmp + taforkblks - aforkblks;
-
-	/*
-	 * The extents in the source inode could still contain speculative
-	 * preallocation beyond EOF (e.g. the file is open but not modified
-	 * while defrag is in progress). In that case, we need to copy over the
-	 * number of delalloc blocks the data fork in the source inode is
-	 * tracking beyond EOF so that when the fork is truncated away when the
-	 * temporary inode is unlinked we don't underrun the i_delayed_blks
-	 * counter on that inode.
-	 */
-	ASSERT(tip->i_delayed_blks == 0);
-	tip->i_delayed_blks = ip->i_delayed_blks;
-	ip->i_delayed_blks = 0;
-
-	switch (ip->i_df.if_format) {
-	case XFS_DINODE_FMT_EXTENTS:
-		src_log_flags |= XFS_ILOG_DEXT;
-		break;
-	case XFS_DINODE_FMT_BTREE:
-		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
-		       (src_log_flags & XFS_ILOG_DOWNER));
-		src_log_flags |= XFS_ILOG_DBROOT;
-		break;
-	}
-
-	switch (tip->i_df.if_format) {
-	case XFS_DINODE_FMT_EXTENTS:
-		target_log_flags |= XFS_ILOG_DEXT;
-		break;
-	case XFS_DINODE_FMT_BTREE:
-		target_log_flags |= XFS_ILOG_DBROOT;
-		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
-		       (target_log_flags & XFS_ILOG_DOWNER));
-		break;
-	}
-
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_diflags2 & XFS_DIFLAG2_REFLINK)) {
-		uint64_t	f;
-
-		f = ip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 |= tip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_has_reflink(ip->i_mount)) {
-		ASSERT(!ip->i_cowfp ||
-		       ip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
-		ASSERT(!tip->i_cowfp ||
-		       tip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
-
-		swap(ip->i_cowfp, tip->i_cowfp);
-
-		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(ip);
-		else
-			xfs_inode_clear_cowblocks_tag(ip);
-		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(tip);
-		else
-			xfs_inode_clear_cowblocks_tag(tip);
-	}
-
-	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
-	xfs_trans_log_inode(*tpp, tip, target_log_flags);
-
-	/*
-	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
-	 * have inode number owner values in the bmbt blocks that still refer to
-	 * the old inode. Scan each bmbt to fix up the owner values with the
-	 * inode number of the current inode.
-	 */
-	if (src_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(tpp, ip, tip);
-		if (error)
-			return error;
-	}
-	if (target_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(tpp, tip, ip);
-		if (error)
-			return error;
-	}
-
-	return 0;
-}
-
-int
-xfs_swap_extents(
-	struct xfs_inode	*ip,	/* target inode */
-	struct xfs_inode	*tip,	/* tmp inode */
-	struct xfs_swapext	*sxp)
-{
-	struct xfs_swapext_req	req = {
-		.ip1		= tip,
-		.ip2		= ip,
-		.whichfork	= XFS_DATA_FORK,
-	};
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
-	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			error = 0;
-	int			resblks = 0;
-	unsigned int		flags = 0;
-
-	/*
-	 * Lock the inodes against other IO, page faults and truncate to
-	 * begin with.  Then we can ensure the inodes are flushed and have no
-	 * page cache safely. Once we have done this we can take the ilocks and
-	 * do the rest of the checks.
-	 */
-	lock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	filemap_invalidate_lock_two(VFS_I(ip)->i_mapping,
-				    VFS_I(tip)->i_mapping);
-
-	/* Verify that both files have the same format */
-	if ((VFS_I(ip)->i_mode & S_IFMT) != (VFS_I(tip)->i_mode & S_IFMT)) {
-		error = -EINVAL;
-		goto out_unlock;
-	}
-
-	/* Verify both files are either real-time or non-realtime */
-	if (XFS_IS_REALTIME_INODE(ip) != XFS_IS_REALTIME_INODE(tip)) {
-		error = -EINVAL;
-		goto out_unlock;
-	}
-
-	error = xfs_qm_dqattach(ip);
-	if (error)
-		goto out_unlock;
-
-	error = xfs_qm_dqattach(tip);
-	if (error)
-		goto out_unlock;
-
-	error = xfs_swap_extent_flush(ip);
-	if (error)
-		goto out_unlock;
-	error = xfs_swap_extent_flush(tip);
-	if (error)
-		goto out_unlock;
-
-	if (xfs_inode_has_cow_data(tip)) {
-		error = xfs_reflink_cancel_cow_range(tip, 0, NULLFILEOFF, true);
-		if (error)
-			goto out_unlock;
-	}
-
-	/*
-	 * Extent "swapping" with rmap requires a permanent reservation and
-	 * a block reservation because it's really just a remap operation
-	 * performed with log redo items!
-	 */
-	if (xfs_has_rmapbt(mp)) {
-		int		w = XFS_DATA_FORK;
-		uint32_t	ipnext = ip->i_df.if_nextents;
-		uint32_t	tipnext	= tip->i_df.if_nextents;
-
-		/*
-		 * Conceptually this shouldn't affect the shape of either bmbt,
-		 * but since we atomically move extents one by one, we reserve
-		 * enough space to rebuild both trees.
-		 */
-		resblks = XFS_SWAP_RMAP_SPACE_RES(mp, ipnext, w);
-		resblks +=  XFS_SWAP_RMAP_SPACE_RES(mp, tipnext, w);
-
-		/*
-		 * If either inode straddles a bmapbt block allocation boundary,
-		 * the rmapbt algorithm triggers repeated allocs and frees as
-		 * extents are remapped. This can exhaust the block reservation
-		 * prematurely and cause shutdown. Return freed blocks to the
-		 * transaction reservation to counter this behavior.
-		 */
-		flags |= XFS_TRANS_RES_FDBLKS;
-	}
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, flags,
-				&tp);
-	if (error)
-		goto out_unlock;
-
-	/*
-	 * Lock and join the inodes to the tansaction so that transaction commit
-	 * or cancel will unlock the inodes from this point onwards.
-	 */
-	xfs_lock_two_inodes(ip, XFS_ILOCK_EXCL, tip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-	xfs_trans_ijoin(tp, tip, 0);
-
-
-	/* Verify all data are being swapped */
-	if (sxp->sx_offset != 0 ||
-	    sxp->sx_length != ip->i_disk_size ||
-	    sxp->sx_length != tip->i_disk_size) {
-		error = -EFAULT;
-		goto out_trans_cancel;
-	}
-
-	trace_xfs_swap_extent_before(ip, 0);
-	trace_xfs_swap_extent_before(tip, 1);
-
-	/* check inode formats now that data is flushed */
-	error = xfs_swap_extents_check_format(ip, tip);
-	if (error) {
-		xfs_notice(mp,
-		    "%s: inode 0x%llx format is incompatible for exchanging.",
-				__func__, ip->i_ino);
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * Compare the current change & modify times with that
-	 * passed in.  If they differ, we abort this swap.
-	 * This is the mechanism used to ensure the calling
-	 * process that the file was not changed out from
-	 * under it.
-	 */
-	if ((sbp->bs_ctime.tv_sec != VFS_I(ip)->i_ctime.tv_sec) ||
-	    (sbp->bs_ctime.tv_nsec != VFS_I(ip)->i_ctime.tv_nsec) ||
-	    (sbp->bs_mtime.tv_sec != VFS_I(ip)->i_mtime.tv_sec) ||
-	    (sbp->bs_mtime.tv_nsec != VFS_I(ip)->i_mtime.tv_nsec)) {
-		error = -EBUSY;
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * Note the trickiness in setting the log flags - we set the owner log
-	 * flag on the opposite inode (i.e. the inode we are setting the new
-	 * owner to be) because once we swap the forks and log that, log
-	 * recovery is going to see the fork as owned by the swapped inode,
-	 * not the pre-swapped inodes.
-	 */
-	req.blockcount = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
-	if (xfs_has_rmapbt(mp)) {
-		xfs_swapext(tp, &req);
-		error = xfs_defer_finish(&tp);
-	} else
-		error = xfs_swap_extent_forks(&tp, &req);
-	if (error) {
-		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
-		goto out_trans_cancel;
-	}
-
-	/*
-	 * If this is a synchronous mount, make sure that the
-	 * transaction goes to disk before returning to the user.
-	 */
-	if (xfs_has_wsync(mp))
-		xfs_trans_set_sync(tp);
-
-	error = xfs_trans_commit(tp);
-
-	trace_xfs_swap_extent_after(ip, 0);
-	trace_xfs_swap_extent_after(tip, 1);
-
-out_unlock_ilock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	xfs_iunlock(tip, XFS_ILOCK_EXCL);
-out_unlock:
-	filemap_invalidate_unlock_two(VFS_I(ip)->i_mapping,
-				      VFS_I(tip)->i_mapping);
-	unlock_two_nondirectories(VFS_I(ip), VFS_I(tip));
-	return error;
-
-out_trans_cancel:
-	xfs_trans_cancel(tp);
-	goto out_unlock_ilock;
-}
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 39c71da08403..8eb7166aa9d4 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -66,13 +66,6 @@ int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
 int	xfs_free_eofblocks(struct xfs_inode *ip);
 
-int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
-			 struct xfs_swapext *sx);
-
-struct xfs_swapext_req;
-int xfs_swap_extent_forks(struct xfs_trans **tpp, struct xfs_swapext_req *req);
-int xfs_swap_extents_check_format(struct xfs_inode *ip, struct xfs_inode *tip);
-
 xfs_daddr_t xfs_fsb_to_db(struct xfs_inode *ip, xfs_fsblock_t fsb);
 
 xfs_extnum_t xfs_bmap_count_leaves(struct xfs_ifork *ifp, xfs_filblks_t *count);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 6be87b3d56df..84e51745e2fd 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1657,81 +1657,43 @@ xfs_ioc_scrub_metadata(
 
 int
 xfs_ioc_swapext(
-	xfs_swapext_t	*sxp)
+	struct xfs_swapext	*sxp)
 {
-	xfs_inode_t     *ip, *tip;
-	struct fd	f, tmp;
-	int		error = 0;
+	struct xfs_exch_range	fxr = { 0 };
+	struct fd		fd2, fd1;
+	int			error = 0;
 
-	/* Pull information for the target fd */
-	f = fdget((int)sxp->sx_fdtarget);
-	if (!f.file) {
-		error = -EINVAL;
-		goto out;
-	}
-
-	if (!(f.file->f_mode & FMODE_WRITE) ||
-	    !(f.file->f_mode & FMODE_READ) ||
-	    (f.file->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_file;
-	}
+	fd2 = fdget((int)sxp->sx_fdtarget);
+	if (!fd2.file)
+		return -EINVAL;
 
-	tmp = fdget((int)sxp->sx_fdtmp);
-	if (!tmp.file) {
+	fd1 = fdget((int)sxp->sx_fdtmp);
+	if (!fd1.file) {
 		error = -EINVAL;
-		goto out_put_file;
+		goto dest_fdput;
 	}
 
-	if (!(tmp.file->f_mode & FMODE_WRITE) ||
-	    !(tmp.file->f_mode & FMODE_READ) ||
-	    (tmp.file->f_flags & O_APPEND)) {
-		error = -EBADF;
-		goto out_put_tmp_file;
-	}
+	fxr.file1_fd = sxp->sx_fdtmp;
+	fxr.length = sxp->sx_length;
+	fxr.flags = XFS_EXCH_RANGE_NONATOMIC | XFS_EXCH_RANGE_FILE2_FRESH |
+		    XFS_EXCH_RANGE_FULL_FILES;
+	fxr.file2_ino = sxp->sx_stat.bs_ino;
+	fxr.file2_mtime = sxp->sx_stat.bs_mtime.tv_sec;
+	fxr.file2_ctime = sxp->sx_stat.bs_ctime.tv_sec;
+	fxr.file2_mtime_nsec = sxp->sx_stat.bs_mtime.tv_nsec;
+	fxr.file2_ctime_nsec = sxp->sx_stat.bs_ctime.tv_nsec;
 
-	if (IS_SWAPFILE(file_inode(f.file)) ||
-	    IS_SWAPFILE(file_inode(tmp.file))) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
+	error = xfs_exch_range(fd1.file, fd2.file, &fxr);
 
 	/*
-	 * We need to ensure that the fds passed in point to XFS inodes
-	 * before we cast and access them as XFS structures as we have no
-	 * control over what the user passes us here.
+	 * The old implementation returned EFAULT if the swap range was not
+	 * the entirety of both files.
 	 */
-	if (f.file->f_op != &xfs_file_operations ||
-	    tmp.file->f_op != &xfs_file_operations) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	ip = XFS_I(file_inode(f.file));
-	tip = XFS_I(file_inode(tmp.file));
-
-	if (ip->i_mount != tip->i_mount) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	if (ip->i_ino == tip->i_ino) {
-		error = -EINVAL;
-		goto out_put_tmp_file;
-	}
-
-	if (xfs_is_shutdown(ip->i_mount)) {
-		error = -EIO;
-		goto out_put_tmp_file;
-	}
-
-	error = xfs_swap_extents(ip, tip, sxp);
-
- out_put_tmp_file:
-	fdput(tmp);
- out_put_file:
-	fdput(f);
- out:
+	if (error == -EDOM)
+		error = -EFAULT;
+	fdput(fd1);
+dest_fdput:
+	fdput(fd2);
 	return error;
 }
 
@@ -2016,14 +1978,10 @@ xfs_file_ioctl(
 	case XFS_IOC_SWAPEXT: {
 		struct xfs_swapext	sxp;
 
-		if (copy_from_user(&sxp, arg, sizeof(xfs_swapext_t)))
+		if (copy_from_user(&sxp, arg, sizeof(struct xfs_swapext)))
 			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
+
+		return xfs_ioc_swapext(&sxp);
 	}
 
 	case XFS_IOC_FSCOUNTS: {
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index 38be600b5e1e..4e00846990f2 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -10,9 +10,7 @@ struct xfs_bstat;
 struct xfs_ibulk;
 struct xfs_inogrp;
 
-int
-xfs_ioc_swapext(
-	xfs_swapext_t	*sxp);
+int xfs_ioc_swapext(struct xfs_swapext *sxp);
 
 extern int
 xfs_find_handle(
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index ee35eea1ecce..a118d2085490 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -425,7 +425,6 @@ xfs_file_compat_ioctl(
 	struct inode		*inode = file_inode(filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	void			__user *arg = compat_ptr(p);
-	int			error;
 
 	trace_xfs_file_compat_ioctl(ip);
 
@@ -435,6 +434,7 @@ xfs_file_compat_ioctl(
 		return xfs_compat_ioc_fsgeometry_v1(ip->i_mount, arg);
 	case XFS_IOC_FSGROWFSDATA_32: {
 		struct xfs_growfs_data	in;
+		int			error;
 
 		if (xfs_compat_growfs_data_copyin(&in, arg))
 			return -EFAULT;
@@ -447,6 +447,7 @@ xfs_file_compat_ioctl(
 	}
 	case XFS_IOC_FSGROWFSRT_32: {
 		struct xfs_growfs_rt	in;
+		int			error;
 
 		if (xfs_compat_growfs_rt_copyin(&in, arg))
 			return -EFAULT;
@@ -471,12 +472,8 @@ xfs_file_compat_ioctl(
 				   offsetof(struct xfs_swapext, sx_stat)) ||
 		    xfs_ioctl32_bstat_copyin(&sxp.sx_stat, &sxu->sx_stat))
 			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
+
+		return xfs_ioc_swapext(&sxp);
 	}
 	case XFS_IOC_FSBULKSTAT_32:
 	case XFS_IOC_FSBULKSTAT_SINGLE_32:
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 91d1ea949cf3..619cf9c0e67d 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -2,6 +2,11 @@
 /*
  * Copyright (C) 2020-2023 Oracle.  All Rights Reserved.
  * Author: Darrick J. Wong <djwong@kernel.org>
+ *
+ * The xfs_swap_extent_* functions are:
+ * Copyright (c) 2000-2006 Silicon Graphics, Inc.
+ * Copyright (c) 2012 Red Hat, Inc.
+ * All Rights Reserved.
  */
 #include "xfs.h"
 #include "xfs_shared.h"
@@ -14,6 +19,7 @@
 #include "xfs_trans.h"
 #include "xfs_quota.h"
 #include "xfs_bmap_util.h"
+#include "xfs_bmap_btree.h"
 #include "xfs_reflink.h"
 #include "xfs_trace.h"
 #include "xfs_swapext.h"
@@ -471,6 +477,299 @@ xfs_xchg_range_estimate(
 	return error;
 }
 
+/*
+ * We need to check that the format of the data fork in the temporary inode is
+ * valid for the target inode before doing the swap. This is not a problem with
+ * attr1 because of the fixed fork offset, but attr2 has a dynamically sized
+ * data fork depending on the space the attribute fork is taking so we can get
+ * invalid formats on the target inode.
+ *
+ * E.g. target has space for 7 extents in extent format, temp inode only has
+ * space for 6.  If we defragment down to 7 extents, then the tmp format is a
+ * btree, but when swapped it needs to be in extent format. Hence we can't just
+ * blindly swap data forks on attr2 filesystems.
+ *
+ * Note that we check the swap in both directions so that we don't end up with
+ * a corrupt temporary inode, either.
+ *
+ * Note that fixing the way xfs_fsr sets up the attribute fork in the source
+ * inode will prevent this situation from occurring, so all we do here is
+ * reject and log the attempt. basically we are putting the responsibility on
+ * userspace to get this right.
+ */
+STATIC int
+xfs_swap_extents_check_format(
+	struct xfs_inode	*ip,	/* target inode */
+	struct xfs_inode	*tip)	/* tmp inode */
+{
+	struct xfs_ifork	*ifp = &ip->i_df;
+	struct xfs_ifork	*tifp = &tip->i_df;
+
+	/* User/group/project quota ids must match if quotas are enforced. */
+	if (XFS_IS_QUOTA_ON(ip->i_mount) &&
+	    (!uid_eq(VFS_I(ip)->i_uid, VFS_I(tip)->i_uid) ||
+	     !gid_eq(VFS_I(ip)->i_gid, VFS_I(tip)->i_gid) ||
+	     ip->i_projid != tip->i_projid))
+		return -EINVAL;
+
+	/* Should never get a local format */
+	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
+	    tifp->if_format == XFS_DINODE_FMT_LOCAL)
+		return -EINVAL;
+
+	/*
+	 * if the target inode has less extents that then temporary inode then
+	 * why did userspace call us?
+	 */
+	if (ifp->if_nextents < tifp->if_nextents)
+		return -EINVAL;
+
+	/*
+	 * If we have to use the (expensive) rmap swap method, we can
+	 * handle any number of extents and any format.
+	 */
+	if (xfs_has_rmapbt(ip->i_mount))
+		return 0;
+
+	/*
+	 * if the target inode is in extent form and the temp inode is in btree
+	 * form then we will end up with the target inode in the wrong format
+	 * as we already know there are less extents in the temp inode.
+	 */
+	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    tifp->if_format == XFS_DINODE_FMT_BTREE)
+		return -EINVAL;
+
+	/* Check temp in extent form to max in target */
+	if (tifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    tifp->if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
+		return -EINVAL;
+
+	/* Check target in extent form to max in temp */
+	if (ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
+	    ifp->if_nextents > XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
+		return -EINVAL;
+
+	/*
+	 * If we are in a btree format, check that the temp root block will fit
+	 * in the target and that it has enough extents to be in btree format
+	 * in the target.
+	 *
+	 * Note that we have to be careful to allow btree->extent conversions
+	 * (a common defrag case) which will occur when the temp inode is in
+	 * extent format...
+	 */
+	if (tifp->if_format == XFS_DINODE_FMT_BTREE) {
+		if (xfs_inode_has_attr_fork(ip) &&
+		    XFS_BMAP_BMDR_SPACE(tifp->if_broot) > xfs_inode_fork_boff(ip))
+			return -EINVAL;
+		if (tifp->if_nextents <= XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK))
+			return -EINVAL;
+	}
+
+	/* Reciprocal target->temp btree format checks */
+	if (ifp->if_format == XFS_DINODE_FMT_BTREE) {
+		if (xfs_inode_has_attr_fork(tip) &&
+		    XFS_BMAP_BMDR_SPACE(ip->i_df.if_broot) > xfs_inode_fork_boff(tip))
+			return -EINVAL;
+		if (ifp->if_nextents <= XFS_IFORK_MAXEXT(tip, XFS_DATA_FORK))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Fix up the owners of the bmbt blocks to refer to the current inode. The
+ * change owner scan attempts to order all modified buffers in the current
+ * transaction. In the event of ordered buffer failure, the offending buffer is
+ * physically logged as a fallback and the scan returns -EAGAIN. We must roll
+ * the transaction in this case to replenish the fallback log reservation and
+ * restart the scan. This process repeats until the scan completes.
+ */
+static int
+xfs_swap_change_owner(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_inode	*tmpip)
+{
+	int			error;
+	struct xfs_trans	*tp = *tpp;
+
+	do {
+		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
+					      NULL);
+		/* success or fatal error */
+		if (error != -EAGAIN)
+			break;
+
+		error = xfs_trans_roll(tpp);
+		if (error)
+			break;
+		tp = *tpp;
+
+		/*
+		 * Redirty both inodes so they can relog and keep the log tail
+		 * moving forward.
+		 */
+		xfs_trans_ijoin(tp, ip, 0);
+		xfs_trans_ijoin(tp, tmpip, 0);
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
+	} while (true);
+
+	return error;
+}
+
+/* Swap the extents of two files by swapping data forks. */
+STATIC int
+xfs_swap_extent_forks(
+	struct xfs_trans	**tpp,
+	struct xfs_swapext_req	*req)
+{
+	struct xfs_inode	*ip = req->ip2;
+	struct xfs_inode	*tip = req->ip1;
+	xfs_filblks_t		aforkblks = 0;
+	xfs_filblks_t		taforkblks = 0;
+	xfs_extnum_t		junk;
+	uint64_t		tmp;
+	int			src_log_flags = XFS_ILOG_CORE;
+	int			target_log_flags = XFS_ILOG_CORE;
+	int			error;
+
+	/*
+	 * Count the number of extended attribute blocks
+	 */
+	if (xfs_inode_has_attr_fork(ip) && ip->i_af.if_nextents > 0 &&
+	    ip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
+		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
+				&aforkblks);
+		if (error)
+			return error;
+	}
+	if (xfs_inode_has_attr_fork(tip) && tip->i_af.if_nextents > 0 &&
+	    tip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
+		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
+				&taforkblks);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * Btree format (v3) inodes have the inode number stamped in the bmbt
+	 * block headers. We can't start changing the bmbt blocks until the
+	 * inode owner change is logged so recovery does the right thing in the
+	 * event of a crash. Set the owner change log flags now and leave the
+	 * bmbt scan as the last step.
+	 */
+	if (xfs_has_v3inodes(ip->i_mount)) {
+		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
+			target_log_flags |= XFS_ILOG_DOWNER;
+		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
+			src_log_flags |= XFS_ILOG_DOWNER;
+	}
+
+	/*
+	 * Swap the data forks of the inodes
+	 */
+	swap(ip->i_df, tip->i_df);
+
+	/*
+	 * Fix the on-disk inode values
+	 */
+	tmp = (uint64_t)ip->i_nblocks;
+	ip->i_nblocks = tip->i_nblocks - taforkblks + aforkblks;
+	tip->i_nblocks = tmp + taforkblks - aforkblks;
+
+	/*
+	 * The extents in the source inode could still contain speculative
+	 * preallocation beyond EOF (e.g. the file is open but not modified
+	 * while defrag is in progress). In that case, we need to copy over the
+	 * number of delalloc blocks the data fork in the source inode is
+	 * tracking beyond EOF so that when the fork is truncated away when the
+	 * temporary inode is unlinked we don't underrun the i_delayed_blks
+	 * counter on that inode.
+	 */
+	ASSERT(tip->i_delayed_blks == 0);
+	tip->i_delayed_blks = ip->i_delayed_blks;
+	ip->i_delayed_blks = 0;
+
+	switch (ip->i_df.if_format) {
+	case XFS_DINODE_FMT_EXTENTS:
+		src_log_flags |= XFS_ILOG_DEXT;
+		break;
+	case XFS_DINODE_FMT_BTREE:
+		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
+		       (src_log_flags & XFS_ILOG_DOWNER));
+		src_log_flags |= XFS_ILOG_DBROOT;
+		break;
+	}
+
+	switch (tip->i_df.if_format) {
+	case XFS_DINODE_FMT_EXTENTS:
+		target_log_flags |= XFS_ILOG_DEXT;
+		break;
+	case XFS_DINODE_FMT_BTREE:
+		target_log_flags |= XFS_ILOG_DBROOT;
+		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
+		       (target_log_flags & XFS_ILOG_DOWNER));
+		break;
+	}
+
+	/* Do we have to swap reflink flags? */
+	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
+	    (tip->i_diflags2 & XFS_DIFLAG2_REFLINK)) {
+		uint64_t	f;
+
+		f = ip->i_diflags2 & XFS_DIFLAG2_REFLINK;
+		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+		ip->i_diflags2 |= tip->i_diflags2 & XFS_DIFLAG2_REFLINK;
+		tip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+		tip->i_diflags2 |= f & XFS_DIFLAG2_REFLINK;
+	}
+
+	/* Swap the cow forks. */
+	if (xfs_has_reflink(ip->i_mount)) {
+		ASSERT(!ip->i_cowfp ||
+		       ip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
+		ASSERT(!tip->i_cowfp ||
+		       tip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
+
+		swap(ip->i_cowfp, tip->i_cowfp);
+
+		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(ip);
+		else
+			xfs_inode_clear_cowblocks_tag(ip);
+		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(tip);
+		else
+			xfs_inode_clear_cowblocks_tag(tip);
+	}
+
+	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
+	xfs_trans_log_inode(*tpp, tip, target_log_flags);
+
+	/*
+	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
+	 * have inode number owner values in the bmbt blocks that still refer to
+	 * the old inode. Scan each bmbt to fix up the owner values with the
+	 * inode number of the current inode.
+	 */
+	if (src_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, ip, tip);
+		if (error)
+			return error;
+	}
+	if (target_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, tip, ip);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
 /* Prepare two files to have their data exchanged. */
 int
 xfs_xchg_range_prep(

