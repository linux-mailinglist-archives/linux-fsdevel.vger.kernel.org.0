Return-Path: <linux-fsdevel+bounces-46025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286AA81797
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102553BE5A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4C2550B5;
	Tue,  8 Apr 2025 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKTQVZnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820B15855E;
	Tue,  8 Apr 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147716; cv=none; b=u7qViVa62b6B4Qwatw4z9IoZKQBCaiq+XZPBdIXOgeTmOd1cgIuPlWoVKZMnB6FW+P0uVjQk77slQ25xbeisYhaw0zGL6vo1jPZqKMU61i9K8SG/D31ix/+Iedg9Ex9qH/XeYtmOaxjqZxh9YvQr+6ftHPcTujAC9RK1OOWtJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147716; c=relaxed/simple;
	bh=fUiuAdzgAvJkJyMAViYiCN4SfiPs4C8OlBeFxDAE6xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqxoNAStPukIvzomU1HXV/Ze8djRGb947ZjsDDy717cbOEdC1QSrnlpeNLy2P8gv275gUJ2zSHwVvsOXyo3i80mZPcz9zE7nrnK9sjKlIrZi2O9qcwhi1ZdH8Tl717gdF8odNJ/LYxYh9WL2WSa3RjiuTqFwe32HxxXRYYWmoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKTQVZnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0AC4CEE5;
	Tue,  8 Apr 2025 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744147715;
	bh=fUiuAdzgAvJkJyMAViYiCN4SfiPs4C8OlBeFxDAE6xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKTQVZnHmujoe68jhZqAMHRZL4V3fo6Xmm+t0Fr62vc5bYCLeeScd1Oxo0oN3Qej1
	 GewP55rwrU3Rb1ZlMCzPl1RDr+sy4wJrJn551kWC7EdufuV4OpWd1Kw3MDarzo9Ugj
	 rbBl7NHwdbhWuiT50z68cjggenkX+KlbzTRt/c0j4w8ihcI7L3rNJGLxq6acM/tFim
	 9zccAeMw8ydrg3XdRcbRaRVY8dOEsB3f4tr+asrwadX5KI642jE9yZ90DhIyRCZ7wg
	 qyxxNjXo/Rm7lU3HHTLdhGk44fQPRoFgdy9LyJdGSixIDp1TRUJ04zGIZtFLje6/Y1
	 In0YrRJ2c0MJA==
Date: Tue, 8 Apr 2025 14:28:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250408212835.GH6283@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-12-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:42:08AM +0000, John Garry wrote:
> Now that CoW-based atomic writes are supported, update the max size of an
> atomic write for the data device.
> 
> The limit of a CoW-based atomic write will be the limit of the number of
> logitems which can fit into a single transaction.
> 
> In addition, the max atomic write size needs to be aligned to the agsize.
> Limit the size of atomic writes to the greatest power-of-two factor of the
> agsize so that allocations for an atomic write will always be aligned
> compatibly with the alignment requirements of the storage.
> 
> rtvol is not commonly used, so it is not very important to support large
> atomic writes there initially.
> 
> Furthermore, adding large atomic writes for rtvol would be complicated due
> to alignment already offered by rtextsize and also the limitation of
> reflink support only be possible for rtextsize is a power-of-2.
> 
> Function xfs_atomic_write_logitems() is added to find the limit the number
> of log items which can fit in a single transaction.
> 
> Darrick Wong contributed the changes in xfs_atomic_write_logitems()
> originally, but may now be outdated by [0].
> 
> [0] https://lore.kernel.org/linux-xfs/20250406172227.GC6307@frogsfrogsfrogs/
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_mount.c | 36 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h |  5 +++++
>  fs/xfs/xfs_super.c | 22 ++++++++++++++++++++++
>  fs/xfs/xfs_super.h |  1 +
>  4 files changed, 64 insertions(+)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 00b53f479ece..27a737202637 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -666,6 +666,37 @@ xfs_agbtree_compute_maxlevels(
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
>  
> +static inline void
> +xfs_compute_atomic_write_unit_max(
> +	struct xfs_mount	*mp)
> +{
> +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
> +	unsigned int		max_extents_logitems;
> +	unsigned int		max_agsize;
> +
> +	if (!xfs_has_reflink(mp)) {
> +		mp->m_atomic_write_unit_max = 1;
> +		return;
> +	}
> +
> +	/*
> +	 * Find limit according to logitems.
> +	 */
> +	max_extents_logitems = xfs_atomic_write_logitems(mp);
> +
> +	/*
> +	 * Also limit the size of atomic writes to the greatest power-of-two
> +	 * factor of the agsize so that allocations for an atomic write will
> +	 * always be aligned compatibly with the alignment requirements of the
> +	 * storage.
> +	 * The greatest power-of-two is the value according to the lowest bit
> +	 * set.
> +	 */
> +	max_agsize = 1 << (ffs(agsize) - 1);
> +
> +	mp->m_atomic_write_unit_max = min(max_extents_logitems, max_agsize);
> +}
> +
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
>  xfs_rtbtree_compute_maxlevels(
> @@ -842,6 +873,11 @@ xfs_mountfs(
>  	 */
>  	xfs_trans_init(mp);
>  
> +	/*
> +	 * Pre-calculate atomic write unit max.
> +	 */
> +	xfs_compute_atomic_write_unit_max(mp);
> +
>  	/*
>  	 * Allocate and initialize the per-ag data.
>  	 */
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 799b84220ebb..4462bffbf0ff 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -230,6 +230,11 @@ typedef struct xfs_mount {
>  	bool			m_update_sb;	/* sb needs update in mount */
>  	unsigned int		m_max_open_zones;
>  
> +	/*
> +	 * data device max atomic write.
> +	 */
> +	xfs_extlen_t		m_atomic_write_unit_max;
> +
>  	/*
>  	 * Bitsets of per-fs metadata that have been checked and/or are sick.
>  	 * Callers must hold m_sb_lock to access these two fields.
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b2dd0c0bf509..42b2b7540507 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -615,6 +615,28 @@ xfs_init_mount_workqueues(
>  	return -ENOMEM;
>  }
>  
> +unsigned int
> +xfs_atomic_write_logitems(
> +	struct xfs_mount	*mp)
> +{
> +	unsigned int		efi = xfs_efi_item_overhead(1);
> +	unsigned int		rui = xfs_rui_item_overhead(1);
> +	unsigned int		cui = xfs_cui_item_overhead(1);
> +	unsigned int		bui = xfs_bui_item_overhead(1);

Intent items can be relogged during a transaction roll, so you need to
add the done item overhead too, e.g.

	const unsigned int	efi = xfs_efi_item_overhead(1) +
				      xfs_efd_item_overhead(1);
	const unsigned int	rui = xfs_rui_item_overhead(1) +
				      xfs_rud_item_overhead();
	const unsigned int	cui = xfs_cui_item_overhead(1) +
				      xfs_cud_item_overhead();
	const unsigned int	bui = xfs_bui_item_overhead(1) +
				      xfs_bud_item_overhead();

> +	unsigned int		logres = M_RES(mp)->tr_write.tr_logres;
> +
> +	/*
> +	 * Maximum overhead to complete an atomic write ioend in software:
> +	 * remove data fork extent + remove cow fork extent +
> +	 * map extent into data fork
> +	 */
> +	unsigned int		atomic_logitems =
> +		(bui + cui + rui + efi) + (cui + rui) + (bui + rui);

You still have to leave enough space to finish at least one step of the
intent types that can be attached to the untorn cow ioend.  Assuming
that you have functions to compute the reservation needed to finish one
step of each of the four intent item types, the worst case reservation
to finish one item is:

	/* Overhead to finish one step of each intent item type */
	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);

	/* We only finish one item per transaction in a chain */
	const unsigned int	step_size = max(f4, max3(f1, f2, f3));

So the worst case limit on the number of loops through
xfs_reflink_remap_extent is:

	return rounddown_pow_of_two((logres - step_size) /
			atomic_logitems);

and that's the maximum software untorn write unit.  On my system that
gets you 128 blocks, but YMMY.  Those xfs_calc_finish_*_reservation
helpers look something like this:

/*
 * Finishing an EFI can free the blocks and bmap blocks (t2):
 *    the agf for each of the ags: nr * sector size
 *    the agfl for each of the ags: nr * sector size
 *    the super block to reflect the freed blocks: sector size
 *    worst case split in allocation btrees per extent assuming nr extents:
 *		nr exts * 2 trees * (2 * max depth - 1) * block size
 */
inline unsigned int
xfs_calc_finish_efi_reservation(
	struct xfs_mount	*mp,
	unsigned int		nr)
{
	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
			       mp->m_sb.sb_blocksize);
}

/*
 * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
 * on each end of the record, and that can cause the AGFL to be refilled or
 * emptied out.
 */
inline unsigned int
xfs_calc_finish_rui_reservation(
	struct xfs_mount	*mp,
	unsigned int		nr)
{
	if (!xfs_has_rmapbt(mp))
		return 0;
	return xfs_calc_finish_efi_reservation(mp, nr);
}

/*
 * In finishing a BUI, we can modify:
 *    the inode being truncated: inode size
 *    dquots
 *    the inode's bmap btree: (max depth + 1) * block size
 */
inline unsigned int
xfs_calc_finish_bui_reservation(
	struct xfs_mount	*mp,
	unsigned int		nr)
{
	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
			       mp->m_sb.sb_blocksize);
}


/*
 * Finishing a data device refcount updates (t1):
 *    the agfs of the ags containing the blocks: nr_ops * sector size
 *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
 */
inline unsigned int
xfs_calc_finish_cui_reservation(
	struct xfs_mount	*mp,
	unsigned int		nr_ops)
{
	if (!xfs_has_reflink(mp))
		return 0;

	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
			       mp->m_sb.sb_blocksize);
}

--D

> +
> +	/* atomic write limits are always a power-of-2 */
> +	return rounddown_pow_of_two(logres / (2 * atomic_logitems));
> +}
> +
>  STATIC void
>  xfs_destroy_mount_workqueues(
>  	struct xfs_mount	*mp)
> diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
> index c0e85c1e42f2..e0f82be9093a 100644
> --- a/fs/xfs/xfs_super.h
> +++ b/fs/xfs/xfs_super.h
> @@ -100,5 +100,6 @@ extern struct workqueue_struct *xfs_discard_wq;
>  #define XFS_M(sb)		((struct xfs_mount *)((sb)->s_fs_info))
>  
>  struct dentry *xfs_debugfs_mkdir(const char *name, struct dentry *parent);
> +unsigned int xfs_atomic_write_logitems(struct xfs_mount *mp);
>  
>  #endif	/* __XFS_SUPER_H__ */
> -- 
> 2.31.1
> 
> 

