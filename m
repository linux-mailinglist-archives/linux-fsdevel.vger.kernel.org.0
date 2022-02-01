Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD154A663A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 21:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiBAUl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 15:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiBAUlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:41:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DEC061741;
        Tue,  1 Feb 2022 12:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D12B616FB;
        Tue,  1 Feb 2022 20:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD3BC340EB;
        Tue,  1 Feb 2022 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748101;
        bh=+Aams9bKVTkm04jO+/5wKAEgKwPe4NmYBIC6lLhUMWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrvtbhH2dez7QfYf4YU1FmvDmFXkjtl4Y08DiWZw4DFrQxQGiGdMmuwvJPLqhsshS
         eOGMjt5Y3WFBORzlCGX9mCwxKX5+UZInet3K/i8tM6BZFIuXUly9QKQ1anM+p/9a7u
         /P3YyhfrrWCpayyLG+jickDdS+xOS0OfpO485bADtSPcbs2A9Puewq/lxnxXJQBK4D
         3HNI0pVrUexFFvnG3Gnl/ZPvq8pWpNmG55NUegVYAIKYUN8Z4FkVXdh/7V8ymU/4Xg
         btjKd6pCIdGLbipVgcWyVfLi5DZKWqwrHElVl9UyQFOqWSqzdhgko5aiJxl98Rd+GZ
         Ejr7Oci1ugIvQ==
Date:   Tue, 1 Feb 2022 12:41:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v10 8/9] xfs: Implement ->notify_failure() for XFS
Message-ID: <20220201204140.GC8338@magnolia>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127124058.1172422-9-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:57PM +0800, Shiyang Ruan wrote:
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
> ---
>  fs/xfs/Makefile             |   1 +
>  fs/xfs/xfs_buf.c            |  12 ++
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 222 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_notify_failure.h |  10 ++
>  6 files changed, 249 insertions(+)
>  create mode 100644 fs/xfs/xfs_notify_failure.c
>  create mode 100644 fs/xfs/xfs_notify_failure.h
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 04611a1068b4..389970b3e13b 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -84,6 +84,7 @@ xfs-y				+= xfs_aops.o \
>  				   xfs_message.o \
>  				   xfs_mount.o \
>  				   xfs_mru_cache.o \
> +				   xfs_notify_failure.o \
>  				   xfs_pwork.o \
>  				   xfs_reflink.o \
>  				   xfs_stats.o \
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index b45e0d50a405..017010b3d601 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -19,6 +19,7 @@
>  #include "xfs_errortag.h"
>  #include "xfs_error.h"
>  #include "xfs_ag.h"
> +#include "xfs_notify_failure.h"
>  
>  static struct kmem_cache *xfs_buf_cache;
>  
> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> +	if (btp->bt_daxdev)
> +		dax_unregister_holder(btp->bt_daxdev);
>  	fs_put_dax(btp->bt_daxdev);
>  
>  	kmem_free(btp);
> @@ -1946,6 +1949,15 @@ xfs_alloc_buftarg(
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
>  	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
> +	if (btp->bt_daxdev) {
> +		if (dax_get_holder(btp->bt_daxdev)) {
> +			xfs_err(mp, "DAX device already in use?!");
> +			goto error_free;
> +		}
> +
> +		dax_register_holder(btp->bt_daxdev, mp,
> +				&xfs_dax_holder_operations);

Um... is XFS required to take a lock here?  How do we prevent parallel
mounts of filesystems on two partitions from breaking each other?

> +	}
>  
>  	/*
>  	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 33e26690a8c4..d4d36c5bef11 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -542,6 +542,9 @@ xfs_do_force_shutdown(
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
> index 00720a02e761..47ff4ac53c4c 100644
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
> index 000000000000..6abaa043f4bc
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.

2022?

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
> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)
> +static pgoff_t
> +xfs_failure_pgoff(
> +	struct xfs_mount		*mp,
> +	const struct xfs_rmap_irec	*rec,
> +	const struct failure_info	*notify)
> +{
> +	uint64_t			pos = rec->rm_offset;
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
> +#else
> +static int
> +xfs_dax_failure_fn(
> +	struct xfs_btree_cur		*cur,
> +	const struct xfs_rmap_irec	*rec,
> +	void				*data)
> +{
> +	struct xfs_mount		*mp = cur->bc_mp;
> +
> +	/* No other option besides shutting down the fs. */
> +	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
> +	return -EFSCORRUPTED;
> +}
> +#endif /* CONFIG_MEMORY_FAILURE && CONFIG_FS_DAX */
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
> +	struct failure_info	notify;
> +	int			error = 0;
> +	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
> +	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
> +
> +	/*
> +	 * Once a file is found by rmap, we take the intersection of two ranges:
> +	 * notification range and file extent range, to make sure we won't go
> +	 * out of scope.
> +	 */
> +	notify.mf_flags = mf_flags;
> +	notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +	notify.blockcount = XFS_BB_TO_FSB(mp, bblen);

This looks even more incorrect than what V9 did, because the notify
structure helps the per-AG rmap record iterator pick the records (within
that AG) that overlap the failed area, but we haven't selected any AGs
yet.

> +
> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;
> +
> +	for (; agno <= end_agno; agno++) {
> +		struct xfs_rmap_irec	ri_low = { };
> +		struct xfs_rmap_irec	ri_high;

So declare @notify here:

		struct failure_info	notify;

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
> +		 * The part of range out of a AG will be ignored.  So, it's fine
> +		 * to set ri_low to "startblock" in all loops.  When it reaches
> +		 * the last AG, set the ri_high to "endblock" to make sure we
> +		 * actually end at the end.
> +		 */
> +		memset(&ri_high, 0xFF, sizeof(ri_high));
> +		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +		if (agno == end_agno)
> +			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);

And initialize it here:

		struct xfs_agf		*agf = agf_bp->b_addr;
		xfs_agblock_t		agend;

		agend = min(be32_to_cpu(agf->agf_length),
				ri_high.rm_startblock);
		notify.startblock = ri_low.rm_startblock;
		notify.blockcount = agend - ri_low.rm_startblock;

Before passing @notify to the rmap iteration.

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
> +	struct xfs_mount	*mp = dax_get_holder(dax_dev);
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
> +	if (offset < mp->m_ddev_targp->bt_dax_part_off ||
> +	    ((offset + len) > mp->m_ddev_targp->bt_bdev->bd_nr_sectors <<
> +				SECTOR_SHIFT)) {

I think this logic is wrong?

If the failed region overlaps the entire fs, offset will be less than
bt_dax_part_off.

We're looking for reasons to ignore the failure event, right?

So if the failed area is before the start of the fs then we can ignore
it:

	if (offset + len < mp->m_ddev_targp->bt_dax_part_off)
		return -ENXIO;

and if the failed area starts after the fs then we can ignore that too:

	bdev_end = mp->m_ddev_targp->bt_dax_part_off +
		   mp->m_ddev_targp->bt_bdev->bd_nr_sectors;
	if (offset > bdev_end)
		return -ENXIO;

Right?

--D

> +		xfs_warn(mp, "notify_failure() goes out of the scope.");
> +		return -ENXIO;
> +	}
> +
> +	offset -= mp->m_ddev_targp->bt_dax_part_off;
> +	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
> +			mf_flags);
> +}
> +
> +const struct dax_holder_operations xfs_dax_holder_operations = {
> +	.notify_failure		= xfs_dax_notify_failure,
> +};
> diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
> new file mode 100644
> index 000000000000..f40cb315e7ce
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.h
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
> + */
> +#ifndef __XFS_NOTIFY_FAILURE_H__
> +#define __XFS_NOTIFY_FAILURE_H__
> +
> +extern const struct dax_holder_operations xfs_dax_holder_operations;
> +
> +#endif  /* __XFS_NOTIFY_FAILURE_H__ */
> -- 
> 2.34.1
> 
> 
> 
