Return-Path: <linux-fsdevel+bounces-48019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D3AA8B9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D0188F180
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489B1AA7A6;
	Mon,  5 May 2025 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGOa/yII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578478F26;
	Mon,  5 May 2025 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746422556; cv=none; b=auQlqZm2QATVgYAXmWannwJyYfhGy4gogh6jR53jnCJMB6KxclgiB2L092HFmxs9L8k1RsX6aBzh9uotKGsdNCHYsF6obuZ4aFCFgRHfzbfaFlRZvAYc7g+W6cN4Udq+jKQWntNvhX4U7ivp8fH9uUJEASC9MMWR33qIk4Um7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746422556; c=relaxed/simple;
	bh=dk/UqMR+ikv/VOGtmFIjLNimfOtmdKbf3rJ31G7HsMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb7m3Wc/s8edAXX2ZVIr901lbyj7WQ9gxRAoGBpPTS7soulv1mFmBoOzzocLbK49ut28TbrnQPKKc57fDX04RvMaGJSeaXuvlmuG5Ef2WxAJMcqXkKgmG8ZApx1GDaxomKDhD7WmxB7kL+PSV2LaMl9YpMDIZXny02yI/VTcbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGOa/yII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCD8C4CEE4;
	Mon,  5 May 2025 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746422555;
	bh=dk/UqMR+ikv/VOGtmFIjLNimfOtmdKbf3rJ31G7HsMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGOa/yIIOZs3mBBR3O6FcmzBvDRRqZ3Va0qf/oTlkmra6BYzbkF4sjqVikP7x95B5
	 3//H3mT4un8pZySB4D+HQDprRgdYxKIetXpLv/ivcR5pC5ey3ltk/k4kv8gyb6skXJ
	 z32nY6AsJgGlQ5GiH1vESx+AcNOhJ7R14eGxRf18DPGoNNqFFtiINY0Bliypg0KXkI
	 3tWMtjRUAX+Ni49ogXiP1xXqF/zGwvk0M77cCGBbJX0jw2+TMCRRRA55ogXRy4sic1
	 KBeiuJGXaVBjqRxGC8t1aUq50Fl5J43dRu5Z6EjskKpabyFMb1QNdblvDh4Q0RZg3W
	 gWXeTmwkRivXw==
Date: Sun, 4 May 2025 22:22:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v10 13/15] xfs: add xfs_calc_atomic_write_unit_max()
Message-ID: <20250505052235.GW25675@frogsfrogsfrogs>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
 <20250501165733.1025207-14-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501165733.1025207-14-john.g.garry@oracle.com>

On Thu, May 01, 2025 at 04:57:31PM +0000, John Garry wrote:
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
> Function xfs_atomic_write_logitems() is added to find the limit the number
> of log items which can fit in a single transaction.
> 
> Amend the max atomic write computation to create a new transaction
> reservation type, and compute the maximum size of an atomic write
> completion (in fsblocks) based on this new transaction reservation.
> Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
> reasonable level of parallelism.  In the next patch, we'll add a mount
> option so that sysadmins can configure their own limits.
> 
> [djwong: use a new reservation type for atomic write ioends, refactor
> group limit calculations]
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> [jpg: rounddown power-of-2 always]
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_trans_resv.c | 94 ++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_trans_resv.h |  2 +
>  fs/xfs/xfs_mount.c             | 81 +++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h             |  6 +++
>  fs/xfs/xfs_reflink.c           | 16 ++++++
>  fs/xfs/xfs_reflink.h           |  2 +
>  fs/xfs/xfs_trace.h             | 60 ++++++++++++++++++++++
>  7 files changed, 261 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index a841432abf83..e73c09fbd24c 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.c
> +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> @@ -22,6 +22,12 @@
>  #include "xfs_rtbitmap.h"
>  #include "xfs_attr_item.h"
>  #include "xfs_log.h"
> +#include "xfs_defer.h"
> +#include "xfs_bmap_item.h"
> +#include "xfs_extfree_item.h"
> +#include "xfs_rmap_item.h"
> +#include "xfs_refcount_item.h"
> +#include "xfs_trace.h"
>  
>  #define _ALLOC	true
>  #define _FREE	false
> @@ -1394,3 +1400,91 @@ xfs_trans_resv_calc(
>  	 */
>  	xfs_calc_default_atomic_ioend_reservation(mp, resp);
>  }
> +
> +/*
> + * Return the per-extent and fixed transaction reservation sizes needed to
> + * complete an atomic write.
> + */
> +STATIC unsigned int
> +xfs_calc_atomic_write_ioend_geometry(
> +	struct xfs_mount	*mp,
> +	unsigned int		*step_size)
> +{
> +	const unsigned int	efi = xfs_efi_log_space(1);
> +	const unsigned int	efd = xfs_efd_log_space(1);
> +	const unsigned int	rui = xfs_rui_log_space(1);
> +	const unsigned int	rud = xfs_rud_log_space();
> +	const unsigned int	cui = xfs_cui_log_space(1);
> +	const unsigned int	cud = xfs_cud_log_space();
> +	const unsigned int	bui = xfs_bui_log_space(1);
> +	const unsigned int	bud = xfs_bud_log_space();
> +
> +	/*
> +	 * Maximum overhead to complete an atomic write ioend in software:
> +	 * remove data fork extent + remove cow fork extent + map extent into
> +	 * data fork.
> +	 *
> +	 * tx0: Creates a BUI and a CUI and that's all it needs.
> +	 *
> +	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
> +	 * enough space to relog the CUI (== CUI + CUD).
> +	 *
> +	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
> +	 * to relog the CUI.
> +	 *
> +	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
> +	 *
> +	 * tx4: Roll again, need space for an EFD.
> +	 *
> +	 * If the extent referenced by the pair of BUI/CUI items is not the one
> +	 * being currently processed, then we need to reserve space to relog
> +	 * both items.
> +	 */
> +	const unsigned int	tx0 = bui + cui;
> +	const unsigned int	tx1 = bud + rui + cui + cud;
> +	const unsigned int	tx2 = rud + cui + cud;
> +	const unsigned int	tx3 = cud + efi;
> +	const unsigned int	tx4 = efd;
> +	const unsigned int	relog = bui + bud + cui + cud;
> +
> +	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
> +						 max3(tx3, tx4, relog));
> +
> +	/* Overhead to finish one step of each intent item type */
> +	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
> +	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
> +	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
> +	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
> +
> +	/* We only finish one item per transaction in a chain */
> +	*step_size = max(f4, max3(f1, f2, f3));
> +
> +	return per_intent;
> +}
> +
> +/*
> + * Compute the maximum size (in fsblocks) of atomic writes that we can complete
> + * given the existing log reservations.
> + */
> +xfs_extlen_t
> +xfs_calc_max_atomic_write_fsblocks(
> +	struct xfs_mount		*mp)
> +{
> +	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
> +	unsigned int			per_intent = 0;
> +	unsigned int			step_size = 0;
> +	unsigned int			ret = 0;
> +
> +	if (resv->tr_logres > 0) {
> +		per_intent = xfs_calc_atomic_write_ioend_geometry(mp,
> +				&step_size);
> +
> +		if (resv->tr_logres >= step_size)
> +			ret = (resv->tr_logres - step_size) / per_intent;
> +	}
> +
> +	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
> +			resv->tr_logres, ret);
> +
> +	return ret;
> +}
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> index 670045d417a6..a6d303b83688 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.h
> +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> @@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
>  unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
>  unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
>  
> +xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
> +
>  #endif	/* __XFS_TRANS_RESV_H__ */
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 00b53f479ece..9c40914afabd 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -666,6 +666,80 @@ xfs_agbtree_compute_maxlevels(
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
>  
> +/* Maximum atomic write IO size that the kernel allows. */
> +static inline xfs_extlen_t xfs_calc_atomic_write_max(struct xfs_mount *mp)
> +{
> +	return rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
> +}
> +
> +static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
> +{
> +	return 1 << (ffs(nr) - 1);
> +}
> +
> +/*
> + * If the data device advertises atomic write support, limit the size of data
> + * device atomic writes to the greatest power-of-two factor of the AG size so
> + * that every atomic write unit aligns with the start of every AG.  This is
> + * required so that the per-AG allocations for an atomic write will always be
> + * aligned compatibly with the alignment requirements of the storage.
> + *
> + * If the data device doesn't advertise atomic writes, then there are no
> + * alignment restrictions and the largest out-of-place write we can do
> + * ourselves is the number of blocks that user files can allocate from any AG.
> + */
> +static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
> +{
> +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
> +		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
> +	return rounddown_pow_of_two(mp->m_ag_max_usable);
> +}
> +
> +/*
> + * Reflink on the realtime device requires rtgroups, and atomic writes require
> + * reflink.
> + *
> + * If the realtime device advertises atomic write support, limit the size of
> + * data device atomic writes to the greatest power-of-two factor of the rtgroup
> + * size so that every atomic write unit aligns with the start of every rtgroup.
> + * This is required so that the per-rtgroup allocations for an atomic write
> + * will always be aligned compatibly with the alignment requirements of the
> + * storage.
> + *
> + * If the rt device doesn't advertise atomic writes, then there are no
> + * alignment restrictions and the largest out-of-place write we can do
> + * ourselves is the number of blocks that user files can allocate from any
> + * rtgroup.
> + */
> +static inline xfs_extlen_t xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
> +{
> +	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
> +
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
> +		return max_pow_of_two_factor(rgs->blocks);
> +	return rounddown_pow_of_two(rgs->blocks);

Note: rounddown_pow_of_two returns an undefined result (and an UBSAN
warning) if rgs->blocks is zero.  I'm not sure why fstests didn't barf
up errors about this until now.

Oh, that's right, I forgot to run QA on Friday night because I was too
exhausted to remember.  And here it is *Sunday* night and I'm doing QA
work for ... some reason.  Oh, so it won't get in the way of other work
... tomorrow?  WTF is wrong with me.

--D

> +}
> +
> +/* Compute the maximum atomic write unit size for each section. */
> +static inline void
> +xfs_calc_atomic_write_unit_max(
> +	struct xfs_mount	*mp)
> +{
> +	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
> +	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
> +
> +	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
> +	const xfs_extlen_t	max_ioend = xfs_reflink_max_atomic_cow(mp);
> +	const xfs_extlen_t	max_agsize = xfs_calc_perag_awu_max(mp);
> +	const xfs_extlen_t	max_rgsize = xfs_calc_rtgroup_awu_max(mp);
> +
> +	ags->awu_max = min3(max_write, max_ioend, max_agsize);
> +	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
> +
> +	trace_xfs_calc_atomic_write_unit_max(mp, max_write, max_ioend,
> +			max_agsize, max_rgsize);
> +}
> +
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
>  xfs_rtbtree_compute_maxlevels(
> @@ -1082,6 +1156,13 @@ xfs_mountfs(
>  		xfs_zone_gc_start(mp);
>  	}
>  
> +	/*
> +	 * Pre-calculate atomic write unit max.  This involves computations
> +	 * derived from transaction reservations, so we must do this after the
> +	 * log is fully initialized.
> +	 */
> +	xfs_calc_atomic_write_unit_max(mp);
> +
>  	return 0;
>  
>   out_agresv:
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index e67bc3e91f98..e2abf31438e0 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -119,6 +119,12 @@ struct xfs_groups {
>  	 * SMR hard drives.
>  	 */
>  	xfs_fsblock_t		start_fsb;
> +
> +	/*
> +	 * Maximum length of an atomic write for files stored in this
> +	 * collection of allocation groups, in fsblocks.
> +	 */
> +	xfs_extlen_t		awu_max;
>  };
>  
>  struct xfs_freecounter {
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 218dee76768b..ad3bcb76d805 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1040,6 +1040,22 @@ xfs_reflink_end_atomic_cow(
>  	return error;
>  }
>  
> +/* Compute the largest atomic write that we can complete through software. */
> +xfs_extlen_t
> +xfs_reflink_max_atomic_cow(
> +	struct xfs_mount	*mp)
> +{
> +	/* We cannot do any atomic writes without out of place writes. */
> +	if (!xfs_can_sw_atomic_write(mp))
> +		return 0;
> +
> +	/*
> +	 * Atomic write limits must always be a power-of-2, according to
> +	 * generic_atomic_write_valid.
> +	 */
> +	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
> +}
> +
>  /*
>   * Free all CoW staging blocks that are still referenced by the ondisk refcount
>   * metadata.  The ondisk metadata does not track which inode created the
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index 412e9b6f2082..36cda724da89 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
>  
>  bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
>  
> +xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
> +
>  #endif /* __XFS_REFLINK_H */
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 9554578c6da4..d5ae00f8e04c 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
>  DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
>  DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
>  
> +TRACE_EVENT(xfs_calc_atomic_write_unit_max,
> +	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
> +		 unsigned int max_ioend, unsigned int max_agsize,
> +		 unsigned int max_rgsize),
> +	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned int, max_write)
> +		__field(unsigned int, max_ioend)
> +		__field(unsigned int, max_agsize)
> +		__field(unsigned int, max_rgsize)
> +		__field(unsigned int, data_awu_max)
> +		__field(unsigned int, rt_awu_max)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = mp->m_super->s_dev;
> +		__entry->max_write = max_write;
> +		__entry->max_ioend = max_ioend;
> +		__entry->max_agsize = max_agsize;
> +		__entry->max_rgsize = max_rgsize;
> +		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
> +		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
> +	),
> +	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->max_write,
> +		  __entry->max_ioend,
> +		  __entry->max_agsize,
> +		  __entry->max_rgsize,
> +		  __entry->data_awu_max,
> +		  __entry->rt_awu_max)
> +);
> +
> +TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
> +	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
> +		 unsigned int step_size, unsigned int logres,
> +		 unsigned int blockcount),
> +	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned int, per_intent)
> +		__field(unsigned int, step_size)
> +		__field(unsigned int, logres)
> +		__field(unsigned int, blockcount)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = mp->m_super->s_dev;
> +		__entry->per_intent = per_intent;
> +		__entry->step_size = step_size;
> +		__entry->logres = logres;
> +		__entry->blockcount = blockcount;
> +	),
> +	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->per_intent,
> +		  __entry->step_size,
> +		  __entry->logres,
> +		  __entry->blockcount)
> +);
> +
>  TRACE_EVENT(xlog_intent_recovery_failed,
>  	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
>  		 int error),
> -- 
> 2.31.1
> 
> 

