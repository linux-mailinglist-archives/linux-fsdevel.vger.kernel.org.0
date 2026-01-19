Return-Path: <linux-fsdevel+bounces-74463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD3D3AFD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A7E309CAEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9338E101;
	Mon, 19 Jan 2026 15:56:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D538BF97;
	Mon, 19 Jan 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838204; cv=none; b=CGVLuijAqwFgsu+TxphUZ/qYkmNNSbYrafY5j+pvfkAkE2b+9xSOAghz6y2GXCwrMcI7RxKRZMuKlnB2njoOg7eeK1j1ZYZSJgdSQI/7begF6LLeVrlUIU/lEObjVG9MadduETIxIYzvA0DN+A7t1eKtBE8vlPV+wtqyWRirUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838204; c=relaxed/simple;
	bh=D+/mNA7x3bPUPssXz3x5ZzNDARVbZcReUJg4A05wgZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIA+YEAQw9TGBiyz6P54slR+ZKx2z555STiSUzj0RnGINyNb6BPlspVW4ZSS72YWeWn6BD2ZXIyq3igL7JsPMJxhRNrfh17IhjLq84Ges4tggfelD+BGwUuKckqvnJ4oKghFi0ShU65sCjFpgvQOIYGpoyHeDxE5BgFI3Ry3KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9DE4227AA8; Mon, 19 Jan 2026 16:56:39 +0100 (CET)
Date: Mon, 19 Jan 2026 16:56:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260119155639.GA10822@lst.de>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs> <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 09:44:53PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> verify the media of the devices backing an xfs filesystem, and have any
> resulting media errors reported to fsnotify and xfs_healer.

I really wish this would explain the approach (reading data into a
kernel buffer, and the choices of the buffer size and I/O pattern)
and their rationale a bit better here.

> +
> +struct xfs_group_data_lost {
> +	xfs_agblock_t		startblock;
> +	xfs_extlen_t		blockcount;
> +};
> +
> +/* Report lost file data from rmap records */
> +STATIC int
> +xfs_verify_report_data_lost(
> +	struct xfs_btree_cur		*cur,
> +	const struct xfs_rmap_irec	*rec,
> +	void				*data)
> +{
> +	struct xfs_mount		*mp = cur->bc_mp;
> +	struct xfs_inode		*ip;
> +	struct xfs_group_data_lost	*lost = data;
> +	xfs_fileoff_t			fileoff = rec->rm_offset;
> +	xfs_extlen_t			blocks = rec->rm_blockcount;
> +	const bool			is_attr =
> +			(rec->rm_flags & XFS_RMAP_ATTR_FORK);
> +	const xfs_agblock_t		lost_end =
> +			lost->startblock + lost->blockcount;
> +	const xfs_agblock_t		rmap_end =
> +			rec->rm_startblock + rec->rm_blockcount;
> +	int				error = 0;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner))
> +	       return 0;
> +
> +	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, 0, 0, &ip);
> +	if (error)
> +		return 0;
> +
> +	if (rec->rm_flags & XFS_RMAP_BMBT_BLOCK) {
> +		xfs_bmap_mark_sick(ip, is_attr ? XFS_ATTR_FORK : XFS_DATA_FORK);
> +		goto out_rele;
> +	}
> +
> +	if (is_attr) {
> +		xfs_inode_mark_sick(ip, XFS_SICK_INO_XATTR);
> +		goto out_rele;
> +	}
> +
> +	if (lost->startblock > rec->rm_startblock) {
> +		fileoff += lost->startblock - rec->rm_startblock;
> +		blocks -= lost->startblock - rec->rm_startblock;
> +	}
> +	if (rmap_end > lost_end)
> +		blocks -= rmap_end - lost_end;
> +
> +	fserror_report_data_lost(VFS_I(ip), XFS_FSB_TO_B(mp, fileoff),
> +			XFS_FSB_TO_B(mp, blocks), GFP_NOFS);
> +
> +out_rele:
> +	xfs_irele(ip);
> +	return 0;
> +}
> +
> +/* Walk reverse mappings to look for all file data loss */
> +STATIC int
> +xfs_verify_report_losses(
> +	struct xfs_mount	*mp,
> +	enum xfs_group_type	type,
> +	xfs_daddr_t		daddr,
> +	u64			bblen)
> +{
> +	struct xfs_group	*xg = NULL;
> +	struct xfs_trans	*tp;
> +	xfs_fsblock_t		start_bno, end_bno;
> +	uint32_t		start_gno, end_gno;
> +	int			error;
> +
> +	if (type == XG_TYPE_RTG) {
> +		start_bno = xfs_daddr_to_rtb(mp, daddr);
> +		end_bno = xfs_daddr_to_rtb(mp, daddr + bblen - 1);
> +	} else {
> +		start_bno = XFS_DADDR_TO_FSB(mp, daddr);
> +		end_bno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
> +	}
> +
> +	tp = xfs_trans_alloc_empty(mp);
> +	start_gno = xfs_fsb_to_gno(mp, start_bno, type);
> +	end_gno = xfs_fsb_to_gno(mp, end_bno, type);
> +	while ((xg = xfs_group_next_range(mp, xg, start_gno, end_gno, type))) {
> +		struct xfs_buf		*agf_bp = NULL;
> +		struct xfs_rtgroup	*rtg = NULL;
> +		struct xfs_btree_cur	*cur;
> +		struct xfs_rmap_irec	ri_low = { };
> +		struct xfs_rmap_irec	ri_high;
> +		struct xfs_group_data_lost lost;
> +
> +		if (type == XG_TYPE_AG) {
> +			struct xfs_perag	*pag = to_perag(xg);
> +
> +			error = xfs_alloc_read_agf(pag, tp, 0, &agf_bp);
> +			if (error) {
> +				xfs_perag_put(pag);
> +				break;
> +			}
> +
> +			cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, pag);
> +		} else {
> +			rtg = to_rtg(xg);
> +			xfs_rtgroup_lock(rtg, XFS_RTGLOCK_RMAP);
> +			cur = xfs_rtrmapbt_init_cursor(tp, rtg);
> +		}
> +
> +		/*
> +		 * Set the rmap range from ri_low to ri_high, which represents
> +		 * a [start, end] where we looking for the files or metadata.
> +		 */
> +		memset(&ri_high, 0xFF, sizeof(ri_high));
> +		if (xg->xg_gno == start_gno)
> +			ri_low.rm_startblock =
> +				xfs_fsb_to_gbno(mp, start_bno, type);
> +		if (xg->xg_gno == end_gno)
> +			ri_high.rm_startblock =
> +				xfs_fsb_to_gbno(mp, end_bno, type);
> +
> +		lost.startblock = ri_low.rm_startblock;
> +		lost.blockcount = min(xg->xg_block_count,
> +				      ri_high.rm_startblock + 1) -
> +							ri_low.rm_startblock;
> +
> +		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
> +				xfs_verify_report_data_lost, &lost);
> +		xfs_btree_del_cursor(cur, error);
> +		if (agf_bp)
> +			xfs_trans_brelse(tp, agf_bp);
> +		if (rtg)
> +			xfs_rtgroup_unlock(rtg, XFS_RTGLOCK_RMAP);
> +		if (error) {
> +			xfs_group_put(xg);
> +			break;
> +		}
> +	}
> +
> +	xfs_trans_cancel(tp);
> +	return 0;
> +}
> +
> +/*
> + * Compute the desired verify IO size.
> + *
> + * To minimize command overhead, we'd like to create bios that are 1MB, though
> + * we allow the user to ask for a smaller size.
> + */
> +STATIC unsigned int
> +xfs_verify_iosize(
> +	const struct xfs_verify_media	*me,
> +	struct xfs_buftarg		*btp,
> +	uint64_t			bbcount)
> +{
> +	unsigned int			iosize =
> +			min_not_zero(SZ_1M, me->me_max_io_size);
> +
> +	BUILD_BUG_ON(BBSHIFT != SECTOR_SHIFT);
> +	ASSERT(BBTOB(bbcount) >= bdev_logical_block_size(btp->bt_bdev));
> +
> +	return clamp(iosize, bdev_logical_block_size(btp->bt_bdev),
> +			BBTOB(bbcount));
> +}

> +/* Allocate as much memory as we can get for verification buffer. */
> +STATIC struct folio *

Can we please retired STATIC already?

> +STATIC void
> +xfs_verify_media_error(
> +	struct xfs_mount	*mp,
> +	struct xfs_verify_media	*me,
> +	struct xfs_buftarg	*btp,
> +	xfs_daddr_t		daddr,
> +	unsigned int		bio_bbcount,
> +	blk_status_t		bio_status)
> +{
> +	trace_xfs_verify_media_error(mp, me, btp->bt_bdev->bd_dev, daddr,
> +			bio_bbcount, bio_status);
> +
> +	/*
> +	 * Pass any I/O error up to the caller if we didn't successfully verify
> +	 * any bytes at all.
> +	 */
> +	if (me->me_start_daddr == daddr)
> +		me->me_ioerror = -blk_status_to_errno(bio_status);
> +
> +	/*
> +	 * PI validation failures, medium errors, or general IO errors are
> +	 * treated as indicators of data loss.  Everything else are (hopefully)
> +	 * transient errors and are not reported.
> +	 */

But still left in me->me_ioerror.  Is that intentional?

> +	switch (me->me_dev) {
> +	case XFS_DEV_DATA:
> +		xfs_verify_report_losses(mp, XG_TYPE_AG, daddr, bio_bbcount);
> +		break;
> +	case XFS_DEV_RT:
> +		xfs_verify_report_losses(mp, XG_TYPE_RTG, daddr, bio_bbcount);
> +		break;
> +	}

At some point we really need dev_to_group_type and vice versa helpers.


