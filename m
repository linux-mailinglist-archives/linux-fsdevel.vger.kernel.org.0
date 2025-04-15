Return-Path: <linux-fsdevel+bounces-46495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B30A8A406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C96F1764CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC928B4F0;
	Tue, 15 Apr 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZpZ71i8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07263946F;
	Tue, 15 Apr 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734303; cv=none; b=SQn2JeR1+xgqSMmOXhZkHOle1yP8si38fMOsqMibF1vBE7yMaUhtXbiCcmsKkzx62HQQmpQS5tAUbE3ckhzO67lgmuoWH2N6IpEKbPKWxBm/uimc/nwLddgQRks9mOurqmkIL2VK4LuyqRLSfBxvQNf7Wo3Imf5/jKA8/4+MsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734303; c=relaxed/simple;
	bh=J/l9yPCJjiPtRFq0ZyHCyPQfpKmLNcSlMHCIvAeiHzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqtUyjB3VHALopgJaT4z4nErBvQycdDk8cYAgEXPOhs8r6g8Oo6lbfHrGo/nJPBYuZVO3y2G6eChC63xsUEWj9RoW3vQ27KWS7APOhj67mCiDLaeyunppbezNOrkBkQ9/WgxcE6q4dHBIN949k1mJXE0N3AAn1EchDLwSIy5R7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZpZ71i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B0C4CEEB;
	Tue, 15 Apr 2025 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744734302;
	bh=J/l9yPCJjiPtRFq0ZyHCyPQfpKmLNcSlMHCIvAeiHzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZpZ71i8GdSvKB+0cvBHrtA6CWN0Bi9vSA6qQLDxssaHwabANu+qwZgpibH9eKKt6
	 NY2V4u9WM+IXZvnidZTGXwjo1nlPduAMtiyUvGwrxPuAwkNkkxnF0moWCg+zp74exG
	 x8+gTmPzgog6iLCqR4Mz8oWvcJDKy0f4dJMHi7PdpqSzkvXoiKlFVqdS/I9BamUf71
	 L4mQp970jca4HFFX1EOtZxgeR3L9QTVLPo5T517Bsi7Y7dAqRElu5bp2uGd8pqQyxX
	 r7irYbereWt3aYf++ZJhWCCJjAf1C5YRARor5+/W+MU2rdXCs2ONHAWknuwzu+q3/L
	 QFRGyax5hTqmw==
Date: Tue, 15 Apr 2025 09:25:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 12/14] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250415162501.GP25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415121425.4146847-13-john.g.garry@oracle.com>

On Tue, Apr 15, 2025 at 12:14:23PM +0000, John Garry wrote:
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
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> [djwong: use a new reservation type for atomic write ioends]

There should be a
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
underneath this line.

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_resv.c | 90 ++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_trans_resv.h |  2 +
>  fs/xfs/xfs_mount.c             | 80 ++++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h             |  6 +++
>  fs/xfs/xfs_reflink.c           | 13 +++++
>  fs/xfs/xfs_reflink.h           |  2 +
>  fs/xfs/xfs_trace.h             | 60 +++++++++++++++++++++++
>  7 files changed, 253 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index 797eb6a41e9b..f530aa5d72f5 100644
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
> @@ -1385,3 +1391,87 @@ xfs_trans_resv_calc(
>  	 */
>  	resp->tr_atomic_ioend = resp->tr_itruncate;
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
> +	unsigned int			per_intent, step_size;
> +	unsigned int			ret = 0;
> +
> +	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
> +
> +	if (resv->tr_logres >= step_size)
> +		ret = (resv->tr_logres - step_size) / per_intent;
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
> index 00b53f479ece..860fc3c91fd5 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -666,6 +666,79 @@ xfs_agbtree_compute_maxlevels(
>  	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>  }
>  
> +static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
> +{
> +	return 1 << (ffs(nr) - 1);
> +}
> +
> +static inline void
> +xfs_compute_atomic_write_unit_max(
> +	struct xfs_mount	*mp)
> +{
> +	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
> +	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
> +
> +	/* Maximum write IO size that the kernel allows. */
> +	const unsigned int	max_write =
> +		rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
> +
> +	/*
> +	 * Maximum atomic write ioend that we can handle.  The atomic write
> +	 * fallback requires reflink to handle an out of place write, so we
> +	 * don't support atomic writes at all unless reflink is enabled.
> +	 */
> +	const unsigned int	max_ioend = xfs_reflink_max_atomic_cow(mp);
> +
> +	unsigned int		max_agsize;
> +	unsigned int		max_rgsize;
> +
> +	/*
> +	 * If the data device advertises atomic write support, limit the size
> +	 * of data device atomic writes to the greatest power-of-two factor of
> +	 * the AG size so that every atomic write unit aligns with the start
> +	 * of every AG.  This is required so that the per-AG allocations for an
> +	 * atomic write will always be aligned compatibly with the alignment
> +	 * requirements of the storage.
> +	 *
> +	 * If the data device doesn't advertise atomic writes, then there are
> +	 * no alignment restrictions and the largest out-of-place write we can
> +	 * do ourselves is the number of blocks that user files can allocate
> +	 * from any AG.
> +	 */
> +
> +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)

Just to pick nits with my own code, there doesn't need to be a blank
line between the comment and the if test.

> +		max_agsize = max_pow_of_two_factor(mp->m_sb.sb_agblocks);
> +	else
> +		max_agsize = mp->m_ag_max_usable;
> +
> +	/*
> +	 * Reflink on the realtime device requires rtgroups and rt reflink
> +	 * requires rtgroups.

And this should be shortened to "Reflink on the realtime device requires
rtgroups."

--D

> +	 *
> +	 * If the realtime device advertises atomic write support, limit the
> +	 * size of data device atomic writes to the greatest power-of-two
> +	 * factor of the rtgroup size so that every atomic write unit aligns
> +	 * with the start of every rtgroup.  This is required so that the
> +	 * per-rtgroup allocations for an atomic write will always be aligned
> +	 * compatibly with the alignment requirements of the storage.
> +	 *
> +	 * If the rt device doesn't advertise atomic writes, then there are
> +	 * no alignment restrictions and the largest out-of-place write we can
> +	 * do ourselves is the number of blocks that user files can allocate
> +	 * from any rtgroup.
> +	 */
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
> +		max_rgsize = max_pow_of_two_factor(rgs->blocks);
> +	else
> +		max_rgsize = rgs->blocks;
> +
> +	ags->awu_max = min3(max_write, max_ioend, max_agsize);
> +	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
> +
> +	trace_xfs_compute_atomic_write_unit_max(mp, max_write, max_ioend,
> +			max_agsize, max_rgsize);
> +}
> +
>  /* Compute maximum possible height for realtime btree types for this fs. */
>  static inline void
>  xfs_rtbtree_compute_maxlevels(
> @@ -1082,6 +1155,13 @@ xfs_mountfs(
>  		xfs_zone_gc_start(mp);
>  	}
>  
> +	/*
> +	 * Pre-calculate atomic write unit max.  This involves computations
> +	 * derived from transaction reservations, so we must do this after the
> +	 * log is fully initialized.
> +	 */
> +	xfs_compute_atomic_write_unit_max(mp);
> +
>  	return 0;
>  
>   out_agresv:
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 799b84220ebb..c0eff3adfa31 100644
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
> index 218dee76768b..eff560f284ab 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1040,6 +1040,19 @@ xfs_reflink_end_atomic_cow(
>  	return error;
>  }
>  
> +/* Compute the largest atomic write that we can complete through software. */
> +xfs_extlen_t
> +xfs_reflink_max_atomic_cow(
> +	struct xfs_mount	*mp)
> +{
> +	/* We cannot do any atomic writes without out of place writes. */
> +	if (!xfs_has_reflink(mp))
> +		return 0;
> +
> +	/* atomic write limits are always a power-of-2 */
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
> index 9554578c6da4..24d73e9bbe83 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
>  DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
>  DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
>  
> +TRACE_EVENT(xfs_compute_atomic_write_unit_max,
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

