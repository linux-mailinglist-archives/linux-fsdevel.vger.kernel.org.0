Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0344242E1FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhJNTX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhJNTX4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 799F5611ED;
        Thu, 14 Oct 2021 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634239311;
        bh=uE1IxhBHAWivyuatVdRSOmLf/84hO7wUUmmZzXZYNYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmuRUcdFrrD/QQ46fr5X60IuZODKndBkeD1QEHVHs+Bq7kNYMuEmy2DHhx0gmFFf9
         F8XHhoHezBj29glpI6yKQdtoNoqeFdSr62kwNuhQmSndxVAbf8nosd4zqSn59nRrS3
         wIjgi1zXXjnibAwT/BrVwqNrFykMH02xdZXAMltL+EzV+YE+OU2U70HglD3WQm2GH7
         t6YdpASxFwqT65+kvOL6lMJD2kTEYJVe5s8SGBTHecnAWXzEorJJwfp7PGAklZsEBl
         FnM5LSj/ifk10KR4iZXIqUSi7Vnu5S74w90j5Skn7hsnxTxCduHgg3dsj9hCGM5gIW
         qi2DQl2FIjcaA==
Date:   Thu, 14 Oct 2021 12:21:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 7/8] xfs: Implement ->notify_failure() for XFS
Message-ID: <20211014192151.GI24307@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:58PM +0800, Shiyang Ruan wrote:
> This function is used to handle errors which may cause data lost in
> filesystem.  Such as memory failure in fsdax mode.
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
> ---
>  drivers/dax/super.c |  19 +++++
>  fs/xfs/xfs_fsops.c  |   3 +
>  fs/xfs/xfs_mount.h  |   1 +
>  fs/xfs/xfs_super.c  | 188 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h |  18 +++++
>  5 files changed, 229 insertions(+)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 7d4a11dcba90..22091e7fb0ef 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -135,6 +135,25 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
>  
> +void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +	dax_set_holder(dax_dev, holder, ops);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_register_holder);
> +
> +void fs_dax_unregister_holder(struct dax_device *dax_dev)
> +{
> +	dax_set_holder(dax_dev, NULL, NULL);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_unregister_holder);
> +
> +void *fs_dax_get_holder(struct dax_device *dax_dev)
> +{
> +	return dax_get_holder(dax_dev);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_get_holder);
> +
>  bool generic_fsdax_supported(struct dax_device *dax_dev,
>  		struct block_device *bdev, int blocksize, sector_t start,
>  		sector_t sectors)
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 33e26690a8c4..4c2d3d4ca5a5 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -542,6 +542,9 @@ xfs_do_force_shutdown(
>  	} else if (flags & SHUTDOWN_CORRUPT_INCORE) {
>  		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
>  		why = "Corruption of in-memory data";
> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
> +		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
> +		why = "Corruption of on-disk metadata";
>  	} else {
>  		tag = XFS_PTAG_SHUTDOWN_IOERROR;
>  		why = "Metadata I/O Error";
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index e091f3b3fa15..d0f6da23e3df 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -434,6 +434,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int lags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
>  
>  #define XFS_SHUTDOWN_STRINGS \
>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index c4e0cd1c1c8c..46fdf44b5ec2 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -37,11 +37,19 @@
>  #include "xfs_reflink.h"
>  #include "xfs_pwork.h"
>  #include "xfs_ag.h"
> +#include "xfs_alloc.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_rtalloc.h"
> +#include "xfs_bit.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/mm.h>
> +#include <linux/dax.h>
>  
> +static const struct dax_holder_operations xfs_dax_holder_operations;
>  static const struct super_operations xfs_super_operations;
>  
>  static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
> @@ -377,6 +385,8 @@ xfs_close_devices(
>  
>  		xfs_free_buftarg(mp->m_logdev_targp);
>  		xfs_blkdev_put(logdev);
> +		if (dax_logdev)
> +			fs_dax_unregister_holder(dax_logdev);
>  		fs_put_dax(dax_logdev);
>  	}
>  	if (mp->m_rtdev_targp) {
> @@ -385,9 +395,13 @@ xfs_close_devices(
>  
>  		xfs_free_buftarg(mp->m_rtdev_targp);
>  		xfs_blkdev_put(rtdev);
> +		if (dax_rtdev)
> +			fs_dax_unregister_holder(dax_rtdev);
>  		fs_put_dax(dax_rtdev);
>  	}
>  	xfs_free_buftarg(mp->m_ddev_targp);
> +	if (dax_ddev)
> +		fs_dax_unregister_holder(dax_ddev);
>  	fs_put_dax(dax_ddev);
>  }
>  
> @@ -411,6 +425,9 @@ xfs_open_devices(
>  	struct block_device	*logdev = NULL, *rtdev = NULL;
>  	int			error;
>  
> +	if (dax_ddev)
> +		fs_dax_register_holder(dax_ddev, mp,
> +				&xfs_dax_holder_operations);
>  	/*
>  	 * Open real time and log devices - order is important.
>  	 */
> @@ -419,6 +436,9 @@ xfs_open_devices(
>  		if (error)
>  			goto out;
>  		dax_logdev = fs_dax_get_by_bdev(logdev);
> +		if (dax_logdev != dax_ddev && dax_logdev)
> +			fs_dax_register_holder(dax_logdev, mp,
> +					&xfs_dax_holder_operations);
>  	}
>  
>  	if (mp->m_rtname) {
> @@ -433,6 +453,9 @@ xfs_open_devices(
>  			goto out_close_rtdev;
>  		}
>  		dax_rtdev = fs_dax_get_by_bdev(rtdev);
> +		if (dax_rtdev)
> +			fs_dax_register_holder(dax_rtdev, mp,
> +					&xfs_dax_holder_operations);
>  	}
>  
>  	/*
> @@ -1110,6 +1133,171 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +struct notify_failure_info {
> +	xfs_agblock_t startblock;

Style nit: tabs between type name and variable name.

> +	xfs_filblks_t blockcount;
> +	int flags;

Are these MF_ flags to be passed from memory_failure to
mf_dax_kill_procs?

> +};
> +
> +static loff_t
> +xfs_notify_failure_start(
> +	struct xfs_mount			*mp,
> +	const struct xfs_rmap_irec		*rec,
> +	const struct notify_failure_info	*notify)
> +{
> +	loff_t start = rec->rm_offset;
> +
> +	if (notify->startblock > rec->rm_startblock)
> +		start += XFS_FSB_TO_B(mp,
> +				notify->startblock - rec->rm_startblock);

I'm confused, is this supposed to return the file pos(ition) of the
failed range in units of bytes or in fs blocks?

If it's units of bytes (like the loff_t return value implies) then this
should be called xfs_notify_failure_pos.

> +	return start;
> +}
> +
> +static size_t
> +xfs_notify_failure_size(
> +	struct xfs_mount			*mp,
> +	const struct xfs_rmap_irec		*rec,
> +	const struct notify_failure_info	*notify)
> +{
> +	xfs_agblock_t rec_start = rec->rm_startblock;
> +	xfs_agblock_t rec_end = rec->rm_startblock + rec->rm_blockcount;

These are "next" variables, not "end".  The end of the record is
startblock + blockcount - 1.

> +	xfs_agblock_t notify_start = notify->startblock;
> +	xfs_agblock_t notify_end = notify->startblock + notify->blockcount;
> +	xfs_agblock_t cross_start = max(rec_start, notify_start);
> +	xfs_agblock_t cross_end = min(rec_end, notify_end);
> +
> +	return XFS_FSB_TO_B(mp, cross_end - cross_start);
> +}
> +
> +static int
> +xfs_dax_notify_failure_fn(
> +	struct xfs_btree_cur		*cur,
> +	const struct xfs_rmap_irec	*rec,
> +	void				*data)
> +{
> +	struct xfs_mount		*mp = cur->bc_mp;
> +	struct xfs_inode		*ip;
> +	struct address_space		*mapping;
> +	struct notify_failure_info	*notify = data;
> +	int				error = 0;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		// TODO check and try to fix metadata
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	/* Get files that incore, filter out others that are not in use. */
> +	error = xfs_iget(mp, cur->bc_tp, rec->rm_owner, XFS_IGET_INCORE,
> +			 0, &ip);

If you're going to use _INCORE then you probably want to filter out the
-ENODATA or whatever error code means "inode wasn't loaded", because
returning any nonzero value to rmap_query_range causes it to stop
iterating.

> +	if (error)
> +		return error;
> +
> +	mapping = VFS_I(ip)->i_mapping;
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +		loff_t offset = xfs_notify_failure_start(mp, rec, notify);
> +		size_t size = xfs_notify_failure_size(mp, rec, notify);
> +
> +		error = mf_dax_kill_procs(mapping, offset >> PAGE_SHIFT, size,
> +					  notify->flags);
> +	}
> +	// TODO try to fix data
> +	xfs_irele(ip);
> +
> +	return error;
> +}
> +
> +static loff_t
> +xfs_dax_bdev_offset(
> +	struct xfs_mount *mp,
> +	struct dax_device *dax_dev,
> +	loff_t disk_offset)
> +{
> +	struct block_device *bdev;
> +
> +	if (mp->m_ddev_targp->bt_daxdev == dax_dev)
> +		bdev = mp->m_ddev_targp->bt_bdev;
> +	else if (mp->m_logdev_targp->bt_daxdev == dax_dev)
> +		bdev = mp->m_logdev_targp->bt_bdev;
> +	else
> +		bdev = mp->m_rtdev_targp->bt_bdev;
> +
> +	return disk_offset - (get_start_sect(bdev) << SECTOR_SHIFT);
> +}
> +
> +static int
> +xfs_dax_notify_failure(
> +	struct dax_device	*dax_dev,
> +	loff_t			offset,
> +	size_t			len,
> +	int			flags)

Are @flags supposed to contain the MF_ flags that were passed to
memory_failure()?  The variable name should probably be @mf_flags
throughout the patchset if that's the case.

> +{
> +	struct xfs_mount	*mp = fs_dax_get_holder(dax_dev);
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_buf		*agf_bp = NULL;
> +	struct xfs_rmap_irec	rmap_low, rmap_high;
> +	loff_t			bdev_offset = xfs_dax_bdev_offset(mp, dax_dev,
> +								  offset);

I don't like using loff_t to represent byte offsets into the physical
device.  loff_t should be used only for file byte offsets, and that's
not what we're storing here.

> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, bdev_offset);

I think this is still wrong, since fsblocks are segmented (nonlinear)
addresses.  Pass daddr into xfs_dax_notify_ddev_failure like I lay out
below, and then you can do:

	start_fsbno = XFS_DADDR_TO_FSB(mp, daddr);
	agno = XFS_FSB_TO_AGNO(mp, fsbno);
	notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
	notify.blockcount = XFS_BB_TO_FSB(mp, bblen);

(More on this below)

> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	int			error = 0;
> +	struct notify_failure_info notify = {
> +		.startblock	= XFS_FSB_TO_AGBNO(mp, fsbno),
> +		.blockcount	= XFS_B_TO_FSB(mp, len),
> +		.flags		= flags,
> +	};
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
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> +		return -EFSCORRUPTED;
> +	}

Urk.  xfs_dax_notify_failure should be a short function to dispatch the
notification to the proper handler.  Everything from here down should be
in a separate function xfs_dax_notify_ddev_failure, so that the next
line of xfs_dax_notify_failure is just:

	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset),
			BTOBB(len), flags);

And then we have

static int
xfs_dax_notify_ddev_failure(
	struct xfs_mount	*mp,
	xfs_daddr_t		daddr,
	xfs_daddr_t		bblen,
	int			mf_flags)
{
	if (!xfs_has_rmapbt(mp)) {
		xfs_warn(...);

Because otherwise xfs_dax_notify_failure gets cluttered.

> +
> +	if (!xfs_has_rmapbt(mp)) {
> +		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;
> +
> +	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +	if (error)
> +		goto out_cancel_tp;
> +
> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);

What happens if the failure range spans multiple AGs?  I suppose it's
not technically possible today since we only report a single page at a
time.  But for the general case, I think we actually want (building off
the sample code above) this function to do something like this:

	start_fsbno = XFS_DADDR_TO_FSB(mp, daddr);
	agno = XFS_FSB_TO_AGNO(mp, fsbno);
	end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
	end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);

	for (; agno <= end_agbno; agno++) {
		struct xfs_rmap_irec	rmap_low = { };
		struct xfs_rmap_irec	rmap_high;

		notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
		notify.blockcount = XFS_BB_TO_FSB(mp, bblen);

		/*
		 * init transaction, read agf, init cursor...
		 */

		memset(&rmap_high, 0xFF, sizeof(rmap_high));
		rmap_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
		if (agno == end_agbno)
			rmap_high.rm_startblock = XFS_FSB_TO_AGBNO(mp,
							end_fsbno);

		error = xfs_rmap_query_range(...);
		if (error)
			fail;

		fsbno = XFS_AGB_TO_FSB(mp, agno + 1, 0);
	}

--D

> +
> +	/* Construct a range for rmap query */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = notify.startblock;
> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = notify.blockcount;
> +
> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high,
> +				     xfs_dax_notify_failure_fn, &notify);
> +
> +	xfs_btree_del_cursor(cur, error);
> +	xfs_trans_brelse(tp, agf_bp);
> +
> +out_cancel_tp:
> +	xfs_trans_cancel(tp);
> +	return error;
> +}
> +
> +static const struct dax_holder_operations xfs_dax_holder_operations = {
> +	.notify_failure		= xfs_dax_notify_failure,
> +};
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 3d90becbd160..0f1fa7a4a616 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -149,6 +149,10 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
>  }
>  
>  struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
> +void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops);
> +void fs_dax_unregister_holder(struct dax_device *dax_dev);
> +void *fs_dax_get_holder(struct dax_device *dax_dev);
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
> @@ -179,6 +183,20 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>  	return NULL;
>  }
>  
> +static inline void fs_dax_register_holder(struct dax_device *dax_dev,
> +		void *holder, const struct dax_holder_operations *ops)
> +{
> +}
> +
> +static inline void fs_dax_unregister_holder(struct dax_device *dax_dev)
> +{
> +}
> +
> +static inline void *fs_dax_get_holder(struct dax_device *dax_dev)
> +{
> +	return NULL;
> +}
> +
>  static inline struct page *dax_layout_busy_page(struct address_space *mapping)
>  {
>  	return NULL;
> -- 
> 2.33.0
> 
> 
> 
