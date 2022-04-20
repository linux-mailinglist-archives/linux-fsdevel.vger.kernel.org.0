Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C37508E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381109AbiDTRdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381107AbiDTRdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:33:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E515A06;
        Wed, 20 Apr 2022 10:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1345B82113;
        Wed, 20 Apr 2022 17:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A57C385A1;
        Wed, 20 Apr 2022 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650475851;
        bh=vJXpbXxLyDU+B+Mv1AJbHoStKpClpd670zxaMiuWIC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opcEkQoZCcLo8dMy2XoJ+haQ5mwlUh720mTdj8anuj7zLaKoplPy2uZmOAF6X13fc
         hGnEEIMD+8op+o7yBdRtWSRvQ0dea9+QGbSO3lhRQ0D3RS9awfwu6MDFsRqAYUbT8D
         rBtCeeb97IoKlDDneByzIXxNtD0GNz114TMjRf1F1Qhzj2AuRnSluoCO4yjisEtAJD
         ZQOpWm6Dwtv8aVDiTBLby0vqxzO9qifn4Jwr9KSZpwegGB5o6nNr9UTnXZVXQ6NgBt
         CMMzYVROGujuYvAqurN2G0diaz++V/Qo4A5PAkP7pA4hYdppT6L/zza9YpJoupKI0b
         eZ9rOOWDcP0Pw==
Date:   Wed, 20 Apr 2022 10:30:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13.1 6/7] xfs: Implement ->notify_failure() for XFS
Message-ID: <20220420173051.GT17025@magnolia>
References: <20220419153854.GH17025@magnolia>
 <20220420073342.1998779-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420073342.1998779-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:33:42PM +0800, Shiyang Ruan wrote:
> Introduce xfs_notify_failure.c to handle failure related works, such as
> implement ->notify_failure(), register/unregister dax holder in xfs, and
> so on.
> 
> If the rmap feature of XFS enabled, we can query it to find files and
> metadata which are associated with the corrupt data.  For now all we do
> is kill processes with that file mapped into their address spaces, but
> future patches could actually do something about corrupt metadata.
> 
> After that, the memory failure needs to notify the processes who are
> using those files.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good now, thank you for your persistence!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/Makefile             |   5 +
>  fs/xfs/xfs_buf.c            |  11 +-
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 220 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_super.h          |   1 +
>  6 files changed, 238 insertions(+), 3 deletions(-)
>  create mode 100644 fs/xfs/xfs_notify_failure.c
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 04611a1068b4..09f5560e29f2 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -128,6 +128,11 @@ xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
>  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
>  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
>  
> +# notify failure
> +ifeq ($(CONFIG_MEMORY_FAILURE),y)
> +xfs-$(CONFIG_FS_DAX)		+= xfs_notify_failure.o
> +endif
> +
>  # online scrub/repair
>  ifeq ($(CONFIG_XFS_ONLINE_SCRUB),y)
>  
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index f9ca08398d32..084455f7e2ff 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -5,6 +5,7 @@
>   */
>  #include "xfs.h"
>  #include <linux/backing-dev.h>
> +#include <linux/dax.h>
>  
>  #include "xfs_shared.h"
>  #include "xfs_format.h"
> @@ -1911,7 +1912,7 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> -	fs_put_dax(btp->bt_daxdev, NULL);
> +	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>  
>  	kmem_free(btp);
>  }
> @@ -1958,14 +1959,18 @@ xfs_alloc_buftarg(
>  	struct block_device	*bdev)
>  {
>  	xfs_buftarg_t		*btp;
> +	const struct dax_holder_operations *ops = NULL;
>  
> +#if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
> +	ops = &xfs_dax_holder_operations;
> +#endif
>  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>  
>  	btp->bt_mount = mp;
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
> -	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, NULL,
> -					    NULL);
> +	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
> +					    mp, ops);
>  
>  	/*
>  	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 68f74549fa22..56530900bb86 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -536,6 +536,9 @@ xfs_do_force_shutdown(
>  	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
>  		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>  		why = "Corruption of in-memory data";
> +	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
> +		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> +		why = "Corruption of on-disk metadata";
>  	} else {
>  		tag = XFS_PTAG_SHUTDOWN_IOERROR;
>  		why = "Metadata I/O Error";
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index f6dc19de8322..9237cc159542 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_ONDISK	0x0010  /* corrupt metadata on device */
>  
>  #define XFS_SHUTDOWN_STRINGS \
>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> new file mode 100644
> index 000000000000..aa8dc27c599c
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
> + */
> +
> +#include "xfs.h"
> +#include "xfs_shared.h"
> +#include "xfs_format.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_alloc.h"
> +#include "xfs_bit.h"
> +#include "xfs_btree.h"
> +#include "xfs_inode.h"
> +#include "xfs_icache.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_rtalloc.h"
> +#include "xfs_trans.h"
> +
> +#include <linux/mm.h>
> +#include <linux/dax.h>
> +
> +struct failure_info {
> +	xfs_agblock_t		startblock;
> +	xfs_extlen_t		blockcount;
> +	int			mf_flags;
> +};
> +
> +static pgoff_t
> +xfs_failure_pgoff(
> +	struct xfs_mount		*mp,
> +	const struct xfs_rmap_irec	*rec,
> +	const struct failure_info	*notify)
> +{
> +	loff_t				pos = XFS_FSB_TO_B(mp, rec->rm_offset);
> +
> +	if (notify->startblock > rec->rm_startblock)
> +		pos += XFS_FSB_TO_B(mp,
> +				notify->startblock - rec->rm_startblock);
> +	return pos >> PAGE_SHIFT;
> +}
> +
> +static unsigned long
> +xfs_failure_pgcnt(
> +	struct xfs_mount		*mp,
> +	const struct xfs_rmap_irec	*rec,
> +	const struct failure_info	*notify)
> +{
> +	xfs_agblock_t			end_rec;
> +	xfs_agblock_t			end_notify;
> +	xfs_agblock_t			start_cross;
> +	xfs_agblock_t			end_cross;
> +
> +	start_cross = max(rec->rm_startblock, notify->startblock);
> +
> +	end_rec = rec->rm_startblock + rec->rm_blockcount;
> +	end_notify = notify->startblock + notify->blockcount;
> +	end_cross = min(end_rec, end_notify);
> +
> +	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
> +}
> +
> +static int
> +xfs_dax_failure_fn(
> +	struct xfs_btree_cur		*cur,
> +	const struct xfs_rmap_irec	*rec,
> +	void				*data)
> +{
> +	struct xfs_mount		*mp = cur->bc_mp;
> +	struct xfs_inode		*ip;
> +	struct failure_info		*notify = data;
> +	int				error = 0;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	/* Get files that incore, filter out others that are not in use. */
> +	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
> +			 0, &ip);
> +	/* Continue the rmap query if the inode isn't incore */
> +	if (error == -ENODATA)
> +		return 0;
> +	if (error)
> +		return error;
> +
> +	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
> +				  xfs_failure_pgoff(mp, rec, notify),
> +				  xfs_failure_pgcnt(mp, rec, notify),
> +				  notify->mf_flags);
> +	xfs_irele(ip);
> +	return error;
> +}
> +
> +static int
> +xfs_dax_notify_ddev_failure(
> +	struct xfs_mount	*mp,
> +	xfs_daddr_t		daddr,
> +	xfs_daddr_t		bblen,
> +	int			mf_flags)
> +{
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_buf		*agf_bp = NULL;
> +	int			error = 0;
> +	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
> +	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
> +
> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;
> +
> +	for (; agno <= end_agno; agno++) {
> +		struct xfs_rmap_irec	ri_low = { };
> +		struct xfs_rmap_irec	ri_high;
> +		struct failure_info	notify;
> +		struct xfs_agf		*agf;
> +		xfs_agblock_t		agend;
> +
> +		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +		if (error)
> +			break;
> +
> +		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
> +
> +		/*
> +		 * Set the rmap range from ri_low to ri_high, which represents
> +		 * a [start, end] where we looking for the files or metadata.
> +		 */
> +		memset(&ri_high, 0xFF, sizeof(ri_high));
> +		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +		if (agno == end_agno)
> +			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
> +
> +		agf = agf_bp->b_addr;
> +		agend = min(be32_to_cpu(agf->agf_length),
> +				ri_high.rm_startblock);
> +		notify.startblock = ri_low.rm_startblock;
> +		notify.blockcount = agend - ri_low.rm_startblock;
> +
> +		error = xfs_rmap_query_range(cur, &ri_low, &ri_high,
> +				xfs_dax_failure_fn, &notify);
> +		xfs_btree_del_cursor(cur, error);
> +		xfs_trans_brelse(tp, agf_bp);
> +		if (error)
> +			break;
> +
> +		fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
> +	}
> +
> +	xfs_trans_cancel(tp);
> +	return error;
> +}
> +
> +static int
> +xfs_dax_notify_failure(
> +	struct dax_device	*dax_dev,
> +	u64			offset,
> +	u64			len,
> +	int			mf_flags)
> +{
> +	struct xfs_mount	*mp = dax_holder(dax_dev);
> +	u64			ddev_start;
> +	u64			ddev_end;
> +
> +	if (!(mp->m_sb.sb_flags & SB_BORN)) {
> +		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
> +		return -EIO;
> +	}
> +
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
> +		xfs_warn(mp,
> +			 "notify_failure() not supported on realtime device!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
> +	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	if (!xfs_has_rmapbt(mp)) {
> +		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
> +	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
> +
> +	/* Ignore the range out of filesystem area */
> +	if (offset + len < ddev_start)
> +		return -ENXIO;
> +	if (offset > ddev_end)
> +		return -ENXIO;
> +
> +	/* Calculate the real range when it touches the boundary */
> +	if (offset > ddev_start)
> +		offset -= ddev_start;
> +	else {
> +		len -= ddev_start - offset;
> +		offset = 0;
> +	}
> +	if (offset + len > ddev_end)
> +		len -= ddev_end - offset;
> +
> +	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
> +			mf_flags);
> +}
> +
> +const struct dax_holder_operations xfs_dax_holder_operations = {
> +	.notify_failure		= xfs_dax_notify_failure,
> +};
> diff --git a/fs/xfs/xfs_super.h b/fs/xfs/xfs_super.h
> index 167d23f92ffe..27ab5087d0b3 100644
> --- a/fs/xfs/xfs_super.h
> +++ b/fs/xfs/xfs_super.h
> @@ -93,6 +93,7 @@ extern xfs_agnumber_t xfs_set_inode_alloc(struct xfs_mount *,
>  extern const struct export_operations xfs_export_operations;
>  extern const struct xattr_handler *xfs_xattr_handlers[];
>  extern const struct quotactl_ops xfs_quotactl_operations;
> +extern const struct dax_holder_operations xfs_dax_holder_operations;
>  
>  extern void xfs_reinit_percpu_counters(struct xfs_mount *mp);
>  
> -- 
> 2.35.1
> 
> 
> 
