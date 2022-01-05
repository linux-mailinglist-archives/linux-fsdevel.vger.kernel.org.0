Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A04858B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiAESxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiAESxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:53:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107CC061245;
        Wed,  5 Jan 2022 10:53:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A2D618D6;
        Wed,  5 Jan 2022 18:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F118C36AE9;
        Wed,  5 Jan 2022 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641408815;
        bh=UStcD7k87L/W/ztPnGciJzAOvy1mDGIphuNwjX6oCHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaO5rzUT8N7iJIzKYNwvy7gN46P+dYenyL4dEzsCdtnTMMJb3g73vrb4/mQHzQLwT
         Cnrh/iSIxuRIo9+6eaDDMh6eBsT4Achf3MOm4xxyFNxTAcaNlDjVI4xx/qU/Xq7xEx
         DPq1N3Q58KO96UII+QauAYAc95lWLy0MqCxne9GzVL7QsTgqGh9EVz+8TkZBbNDQM7
         fgap0niYQqKnBDsDkhRqkpJMiau0fSEO8EidByT9kUhV1XAOtm6BRIV3lDc3T7eZTu
         BoI2y/GXdYYqLbVGl1X8FKA3iaoMnap3gHf8G2XLkcD1+9lz0ES3x8wX9SKRZtdfIo
         I1tnik7yjXQTA==
Date:   Wed, 5 Jan 2022 10:53:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v9 09/10] xfs: Implement ->notify_failure() for XFS
Message-ID: <20220105185334.GD398655@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-10-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226143439.3985960-10-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:34:38PM +0800, Shiyang Ruan wrote:
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
>  fs/xfs/xfs_buf.c            |  15 +++
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 189 ++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_notify_failure.h |  10 ++
>  6 files changed, 219 insertions(+)
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
> index bbb0fbd34e64..d0df7604fa9e 100644
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
> @@ -1946,6 +1949,18 @@ xfs_alloc_buftarg(
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
>  	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
> +	if (btp->bt_daxdev) {
> +		dax_write_lock(btp->bt_daxdev);
> +		if (dax_get_holder(btp->bt_daxdev)) {
> +			dax_write_unlock(btp->bt_daxdev);
> +			xfs_err(mp, "DAX device already in use?!");
> +			goto error_free;
> +		}
> +
> +		dax_register_holder(btp->bt_daxdev, mp,
> +				&xfs_dax_holder_operations);
> +		dax_write_unlock(btp->bt_daxdev);
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
> index 000000000000..a87bd08365f4
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -0,0 +1,189 @@
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

Why is blockcount a 64-bit quantity, when the failure information is
dealt with on a per-AG basis?  I think "xfs_extlen_t blockcount" should
be large enough here.  (I'll get back to this further down.)

> +};
> +
> +static pgoff_t
> +xfs_failure_pgoff(
> +	struct xfs_mount		*mp,
> +	const struct xfs_rmap_irec	*rec,
> +	const struct failure_info	*notify)
> +{
> +	uint64_t pos = rec->rm_offset;

Nit: indenting ^^^^^ here.

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

Indenting and rather more local variables than we need?

static unsigned long
xfs_failure_pgcnt(
	struct xfs_mount		*mp,
	const struct xfs_rmap_irec	*rec,
	const struct failure_info	*notify)
{
	xfs_agblock_t			end_rec;
	xfs_agblock_t			end_notify;
	xfs_agblock_t			start_cross;
	xfs_agblock_t			end_cross;

	start_cross = max(rec->rm_startblock, notify->startblock);

	end_rec = rec->rm_startblock + rec->rm_blockcount;
	end_notify = notify->startblock + notify->blockcount;
	end_cross = min(end_rec, end_notify);

	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
}

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
> +		/* TODO check and try to fix metadata */
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
> +	mapping = VFS_I(ip)->i_mapping;
> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {

Is there a situation where we can receive media failure notices from DAX
but CONFIG_MEMORY_FAILURE is not enabled?  (I think the answer is yes?)

> +		pgoff_t off = xfs_failure_pgoff(mp, rec, notify);
> +		unsigned long cnt = xfs_failure_pgcnt(mp, rec, notify);
> +
> +		error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
> +	}

If so, then we ought to do /something/ besides silently dropping the
error, right?  Even if that something is rudely shutting down the fs,
like we do for attr/bmbt mappings above?

What I'm getting at is that I think this function should be:

#if IS_ENABLED(CONFIG_MEMORY_FAILURE)
static int
xfs_dax_failure_fn(
	struct xfs_btree_cur		*cur,
	const struct xfs_rmap_irec	*rec,
	void				*data)
{
	/* shut down if attr/bmbt record like above */

	error = xfs_iget(...);
	if (error == -ENODATA)
		return 0;
	if (error)
		return error;

	off = xfs_failure_pgoff(mp, rec, notify);
	cnt = xfs_failure_pgcnt(mp, rec, notify);

	error = mf_dax_kill_procs(mapping, off, cnt, notify->mf_flags);
	xfs_irele(ip);
	return error;
}
#else
static int
xfs_dax_failure_fn(
	struct xfs_btree_cur		*cur,
	const struct xfs_rmap_irec	*rec,
	void				*data)
{
	/* No other option besides shutting down the fs. */
	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
	return -EFSCORRUPTED;
}
#endif /* CONFIG_MEMORY_FAILURE */

> +	/* TODO try to fix data */
> +	xfs_irele(ip);
> +
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

This isn't correct.  This sets notify.blockcount to the fsbcount of the
entire failed area, but it sets notify.startblock either to the start
of the failed area OR the start of some AG within the failed area.

If the failed area was blocks 80-119 and each AG is 100 blocks, then
this means we'll probe AG 0 (blocks 0-99) with notify spanning 80-119.
Those last 20 blocks are outside AG 0, but the rmap query range won't
return anything outside that range, so it doesn't really matter.

Next time through the loop, though, we're dealing with AG 1 (blocks
100-199).  Now notify spans blocks 100-139, because bblen hasn't been
updated!  If there's a file with an extent that maps blocks 115-125 and
a process that has only block 124 mmap'd, we'll kill that process
incorrectly because of the accounting error.

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

I think what you really want is to set notify.blockcount to
min(agf_length, ri_high.rm_startblock).  That also means that
notify.blockcount can be xfs_extlen_t, which is the norm for per-AG
extent operations.

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

Technically speaking, if offset/len are beyond mp->m_sb.sb_logblocks
then we can return 0 since the log isn't using the failed part of the
external log.

Buuuut there are a lot of subtleties to the log, so maybe we (that is,
one of the more experienced xfs people) should implement a generic
handler for the log that will DTRT.

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
> +	offset -= mp->m_ddev_targp->bt_dax_part_off;

Don't we need to check offset/len to make sure they're still within the
boundaries of the data device?

--D

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
