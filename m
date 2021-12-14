Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30422474706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 17:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhLNQBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 11:01:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57912 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhLNQBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:01:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A82B81829;
        Tue, 14 Dec 2021 16:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21652C34606;
        Tue, 14 Dec 2021 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639497674;
        bh=pF5K+mUeyxcOVp4pq2zNLZT9tE1Ik6kaQf+SIytgkq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwbPheNYVtZYAWiamgLxeh4Y6I9HVrGXChek/2/qFAUqRnqMynF++Odhrt1wkhS8U
         zi91Mpa6HqEM1H9HtoGeJq3xNRLwSlpuTAJASz6X5Xno5W24dc7F5vO6z9qLH4H73k
         PHkCqEtgiZJiuo9w/Elsdvoc7OCZnoyaNIsVD0auTeFxIcMtQkMVUV5gE7FPx+WXIw
         pHJszlyEWcpH4Bg3tgV8TPYBg6iGrJCP4zn46j5rXOI8LUZje+KaQL83ce7gD4i1yv
         3BrSPjvmmvErmFArCHXoFQ53zKr2JB1OzU39xMcbrAGOxnYHbes5XYHkZSLweMlO9v
         Hynj27zH2sAVA==
Date:   Tue, 14 Dec 2021 08:01:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v8 8/9] xfs: Implement ->notify_failure() for XFS
Message-ID: <20211214160113.GI1218082@magnolia>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202084856.1285285-9-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:48:55PM +0800, Shiyang Ruan wrote:
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
>  fs/xfs/xfs_buf.c            |   4 +
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 224 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_notify_failure.h |  15 +++
>  6 files changed, 248 insertions(+)
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
> index bbb0fbd34e64..40a8916cbbcb 100644
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
> @@ -1892,6 +1893,7 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> +	xfs_notify_failure_unregister(btp->bt_daxdev);
>  	fs_put_dax(btp->bt_daxdev);
>  
>  	kmem_free(btp);
> @@ -1947,6 +1949,8 @@ xfs_alloc_buftarg(
>  	btp->bt_bdev = bdev;
>  	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
>  
> +	xfs_notify_failure_register(mp, btp->bt_daxdev);

There's no _unregister call if the buftarg allocation fails.

> +
>  	/*
>  	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
>  	 * per 30 seconds so as to not spam logs too much on repeated errors.
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
> index 00720a02e761..7812de2c00a7 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -435,6 +435,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */

SHUTDOWN_CORRUPT_ONDISK?

>  
>  #define XFS_SHUTDOWN_STRINGS \
>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> new file mode 100644
> index 000000000000..0c868f89ca3e
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
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
> +	xfs_filblks_t		blockcount;
> +	int			mf_flags;
> +};
> +
> +static pgoff_t
> +xfs_failure_pgoff(
> +	struct xfs_mount		*mp,
> +	const struct xfs_rmap_irec	*rec,
> +	const struct failure_info	*notify)
> +{
> +	uint64_t pos = rec->rm_offset;
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
> +	xfs_agblock_t start_rec = rec->rm_startblock;
> +	xfs_agblock_t end_rec = rec->rm_startblock + rec->rm_blockcount;
> +	xfs_agblock_t start_notify = notify->startblock;
> +	xfs_agblock_t end_notify = notify->startblock + notify->blockcount;
> +	xfs_agblock_t start_cross = max(start_rec, start_notify);
> +	xfs_agblock_t end_cross = min(end_rec, end_notify);
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
> +	struct address_space		*mapping;
> +	struct failure_info		*notify = data;
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
> +	/* Continue the rmap query if the inode isn't incore */
> +	if (error == -ENODATA)
> +		return 0;
> +	if (error)
> +		return error;
> +
> +	mapping = VFS_I(ip)->i_mapping;
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +		pgoff_t off = xfs_failure_pgoff(mp, rec, notify);
> +		unsigned long cnt = xfs_failure_pgcnt(mp, rec, notify);
> +
> +		error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
> +	}
> +	// TODO try to fix data
> +	xfs_irele(ip);
> +
> +	return error;
> +}
> +
> +static u64
> +xfs_dax_ddev_offset(
> +	struct xfs_mount	*mp,
> +	struct dax_device	*dax_dev,
> +	u64			disk_offset)
> +{
> +	xfs_buftarg_t *targp;

struct xfs_buftarg	*targp;

> +
> +	if (mp->m_ddev_targp->bt_daxdev == dax_dev)
> +		targp = mp->m_ddev_targp;
> +	else if (mp->m_logdev_targp->bt_daxdev == dax_dev)
> +		targp = mp->m_logdev_targp;
> +	else
> +		targp = mp->m_rtdev_targp;
> +
> +	return disk_offset - targp->bt_dax_part_off;
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
> +	struct failure_info	notify = { .mf_flags = mf_flags };
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
> +
> +		notify.startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +		notify.blockcount = XFS_BB_TO_FSB(mp, bblen);
> +
> +		error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +		if (error)
> +			break;
> +
> +		cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agf_bp->b_pag);
> +
> +		memset(&ri_high, 0xFF, sizeof(ri_high));
> +		ri_low.rm_startblock = XFS_FSB_TO_AGBNO(mp, fsbno);
> +		if (agno == end_agno)
> +			ri_high.rm_startblock = XFS_FSB_TO_AGBNO(mp, end_fsbno);
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
> +	struct xfs_mount	*mp = fs_dax_get_holder(dax_dev);
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
> +
> +	if (!xfs_has_rmapbt(mp)) {
> +		xfs_warn(mp, "notify_failure() needs rmapbt enabled!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	offset = xfs_dax_ddev_offset(mp, dax_dev, offset);
> +	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
> +			mf_flags);
> +}
> +
> +static const struct dax_holder_operations xfs_dax_holder_operations = {
> +	.notify_failure		= xfs_dax_notify_failure,
> +};
> +
> +void
> +xfs_notify_failure_register(
> +	struct xfs_mount	*mp,
> +	struct dax_device	*dax_dev)
> +{
> +	if (dax_dev && !fs_dax_get_holder(dax_dev))
> +		fs_dax_register_holder(dax_dev, mp, &xfs_dax_holder_operations);

Under what circumstances would there already be a holder?

I don't think it's a good idea to let the mount progress if there's
already a dax holder, since I can't imagine a valid use case for this
scenario.  How about the following for xfs_alloc_buftarg?

	if (btp->bt_daxdev) {
		if (dax_get_holder(dax_dev)) {
			xfs_err(mp, "DAX device already in use?!");
			goto error_free;
		}

		dax_register_holder(dax_dev, mp,
				&xfs_dax_holder_operations);
	}

and skip the two-line wrapper.

--D

> +}
> +
> +void
> +xfs_notify_failure_unregister(
> +	struct dax_device	*dax_dev)
> +{
> +	if (dax_dev)
> +		fs_dax_unregister_holder(dax_dev);
> +}
> diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
> new file mode 100644
> index 000000000000..992bccf155aa
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Fujitsu.  All Rights Reserved.
> + */
> +#ifndef __XFS_NOTIFY_FAILURE_H__
> +#define __XFS_NOTIFY_FAILURE_H__
> +
> +struct xfs_mount;
> +struct dax_device;
> +
> +void xfs_notify_failure_register(struct xfs_mount *mp,
> +		struct dax_device *dax_dev);
> +void xfs_notify_failure_unregister(struct dax_device *dax_dev);
> +
> +#endif  /* __XFS_NOTIFY_FAILURE_H__ */
> -- 
> 2.34.0
> 
> 
> 
