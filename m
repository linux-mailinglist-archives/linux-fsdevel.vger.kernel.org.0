Return-Path: <linux-fsdevel+bounces-48020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F84AA8BA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA4917189B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAC1AC458;
	Mon,  5 May 2025 05:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9VBoTLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC319F115;
	Mon,  5 May 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746422735; cv=none; b=DaFUdVSqmLPrjOz28a0Pw+M+o7C1/Bx5mn+yJIbb/JU+qzYCSFccu8huift2IS9x7tvwhyH+8DO20oV9SQRqCZImK3xP2ijgv9ZCwgk6RoKVt9PBh5tIue7czwl6p8FA0m8fGgKXaozJZmyifzqzsKSUYPai5+tYckyTsokd2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746422735; c=relaxed/simple;
	bh=Enjr0bRp1vPYBada2YDlTTXwgkgR+H7+yYzrJAV+PWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJzxEuqLMG/PgsQsFwiOe7wMfG9NCdsgqtoUf8y3+ABLBdhn/UiEUMNYgzhTf9RbrBDlT5yHXH8CmkYdcYJ1GjFVrkkE+5tJgVukqje98+b9nNKBdHdmXNj9lzsBiXgUDTFKwRzXkGaiqajLdmxvAc4F6TLia7wt84gEIG8WdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9VBoTLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08922C4CEE4;
	Mon,  5 May 2025 05:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746422735;
	bh=Enjr0bRp1vPYBada2YDlTTXwgkgR+H7+yYzrJAV+PWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9VBoTLx4lQVHyDGPJefBbUJ2MYWYUTMQEnRoDsG4zun/azjwr3RpMOA2fDVYnCQV
	 9b8JG74K905eZrJJHAB3KoYX/+/f2DY3v8nzpITtMiM+4J9DVUIfKx2+OgivfjoQWN
	 X0ZHhfoG3+sN0Ot+s24f+uC4jCrCRW8BU4oiacU6b/6SiyLwi7wmKH45w32PrkQBrK
	 xC8/Nm9kQJ8N38vuv5v8N8I7igxv2laLqJKG6TnKndhEQjTlRRyCSNGGzCmz4b0/Ht
	 RL57Do4nQ9K56NL4KHpLT28DTobgExboLIZkLKx5DZffm8SSDssCwMqAuBCOX5+gEh
	 CMEsxiW1pS1YQ==
Date: Sun, 4 May 2025 22:25:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 14/16] xfs: add xfs_calc_atomic_write_unit_max()
Message-ID: <20250505052534.GX25675@frogsfrogsfrogs>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504085923.1895402-15-john.g.garry@oracle.com>

On Sun, May 04, 2025 at 08:59:21AM +0000, John Garry wrote:
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

Ok so I even attached the reply to the WRONG VERSION.  Something in
these changes cause xfs/289 to barf up this UBSAN warning, even on a
realtime + rtgroups volume:

[ 1160.539004] ------------[ cut here ]------------
[ 1160.540701] UBSAN: shift-out-of-bounds in /storage/home/djwong/cdev/work/linux-djw/include/linux/log2.h:67:13
[ 1160.544597] shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
[ 1160.547038] CPU: 3 UID: 0 PID: 288421 Comm: mount Not tainted 6.15.0-rc5-djwx #rc5 PREEMPT(lazy)  6f606c17703b80ffff7378e7041918eca24b3e68
[ 1160.547045] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
[ 1160.547047] Call Trace:
[ 1160.547049]  <TASK>
[ 1160.547051]  dump_stack_lvl+0x4f/0x60
[ 1160.547060]  __ubsan_handle_shift_out_of_bounds+0x1bc/0x380
[ 1160.547066]  xfs_set_max_atomic_write_opt.cold+0x22d/0x252 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
[ 1160.547249]  xfs_mountfs+0xa5c/0xb50 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
[ 1160.547434]  xfs_fs_fill_super+0x7eb/0xb30 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
[ 1160.547616]  ? xfs_open_devices+0x240/0x240 [xfs 1f657532c3dee9b1d567597a31645929273d3283]
[ 1160.547797]  get_tree_bdev_flags+0x132/0x1d0
[ 1160.547801]  vfs_get_tree+0x17/0xa0
[ 1160.547803]  path_mount+0x720/0xa80
[ 1160.547807]  __x64_sys_mount+0x10c/0x140
[ 1160.547810]  do_syscall_64+0x47/0x100
[ 1160.547814]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1160.547817] RIP: 0033:0x7fde55d62e0a
[ 1160.547820] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64 89 01 48
[ 1160.547823] RSP: 002b:00007fff11920ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 1160.547826] RAX: ffffffffffffffda RBX: 0000556a10cd1de0 RCX: 00007fde55d62e0a
[ 1160.547828] RDX: 0000556a10cd2010 RSI: 0000556a10cd2090 RDI: 0000556a10ce2590
[ 1160.547829] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fff11920d50
[ 1160.547830] R10: 0000000000000000 R11: 0000000000000246 R12: 0000556a10ce2590
[ 1160.547832] R13: 0000556a10cd2010 R14: 00007fde55eca264 R15: 0000556a10cd1ef8
[ 1160.547834]  </TASK>
[ 1160.547835] ---[ end trace ]---

John, can you please figure this one out, seeing as it's 10:30pm on
Sunday night here?

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

