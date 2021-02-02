Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF230B561
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 03:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBBCmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 21:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhBBCm3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:42:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F2FA64E9C;
        Tue,  2 Feb 2021 02:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612233708;
        bh=naWXAFU+6TKdKkVuNGQRwpVvCUYGZXnZdcMsBtOH4uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgstTYgkenP2WnTOGFSdOSUmp7Bqp7OocOMpJX+lO9rew99J9DVyEpZ9WUJooO74B
         Gv/w/hXObsFeCONTnY19zTJmgdlD0IVdGuP1ZUtpZp2A8kIZk3RgzIaYHaHX/LFDn9
         4x3Sk7AQgkZMzX7WbKW737wbpXEuK5LrYzBZum1eKz4mkWayd2Dot5GybmlgnbRHfT
         T1QgwnVtJXepOkmuCfdvyO072Y2+pw1cf7FSokRFvCW8JoMEUs8vhgjAm7fxHgsLq1
         fgiRYdptfwW+DRAhATquyPQAon2Nz5Ulc1rBe6VDNe0a9Ay3H9Sb5TrkHRt3CmFfDx
         GhihJCHCZUe4A==
Date:   Mon, 1 Feb 2021 18:41:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH RESEND v2 09/10] xfs: Implement ->corrupted_range() for
 XFS
Message-ID: <20210202024147.GI7193@magnolia>
References: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
 <20210129062757.1594130-10-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129062757.1594130-10-ruansy.fnst@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:27:56PM +0800, Shiyang Ruan wrote:
> This function is used to handle errors which may cause data lost in
> filesystem.  Such as memory failure in fsdax mode.
> 
> In XFS, it requires "rmapbt" feature in order to query for files or
> metadata which associated to the corrupted data.  Then we could call fs
> recover functions to try to repair the corrupted data.(did not
> implemented in this patchset)

I would suggest:
"If the rmap feature of XFS enabled, we can query it to find files and
metadata which are associated with the corrupt data.  For now all we do
is kill processes with that file mapped into their address spaces, but
future patches could actually do something about corrupt metadata."

> After that, the memory failure also needs to notify the processes who
> are using those files.
> 
> Only support data device.  Realtime device is not supported for now.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_fsops.c |   5 +++
>  fs/xfs/xfs_mount.h |   1 +
>  fs/xfs/xfs_super.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 959ce91a3755..f03901a5c673 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -498,6 +498,11 @@ xfs_do_force_shutdown(
>  "Corruption of in-memory data detected.  Shutting down filesystem");
>  		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>  			xfs_stack_trace();
> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
> +"Corruption of on-disk metadata detected.  Shutting down filesystem");
> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
> +			xfs_stack_trace();
>  	} else if (logerror) {
>  		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
>  			"Log I/O Error Detected. Shutting down filesystem");
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index dfa429b77ee2..8f0df67ffcc1 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -274,6 +274,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
>  
>  /*
>   * Flags for xfs_mountfs
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 813be879a5e5..93093fe0ee8a 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -35,6 +35,11 @@
>  #include "xfs_refcount_item.h"
>  #include "xfs_bmap_item.h"
>  #include "xfs_reflink.h"
> +#include "xfs_alloc.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_rtalloc.h"
> +#include "xfs_bit.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
> @@ -1105,6 +1110,109 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +static int
> +xfs_corrupt_helper(
> +	struct xfs_btree_cur		*cur,
> +	struct xfs_rmap_irec		*rec,
> +	void				*data)
> +{
> +	struct xfs_inode		*ip;
> +	struct address_space		*mapping;
> +	int				rc = 0;
> +	int				*flags = data;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		// TODO check and try to fix metadata
> +		rc = -EFSCORRUPTED;

The xfs_force_shutdown() call should go here, since SHUTDOWN_CORRUPT_META
is specific to this case.

I guess one could also dig through the buffer cache and delwri_submit
those buffers or something.

> +	} else {
> +		/*
> +		 * Get files that incore, filter out others that are not in use.
> +		 */
> +		rc = xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner,
> +			      XFS_IGET_INCORE, 0, &ip);
> +		if (rc || !ip)
> +			return rc;
> +		if (!VFS_I(ip)->i_mapping)
> +			goto out;
> +
> +		mapping = VFS_I(ip)->i_mapping;
> +		if (IS_DAX(VFS_I(ip)))
> +			rc = mf_dax_mapping_kill_procs(mapping, rec->rm_offset,
> +						       *flags);
> +		else
> +			mapping_set_error(mapping, -EIO);
> +
> +		// TODO try to fix data

What could we do to fix the data?  If we're not in S_DAX mode and
there's actually pagecache mapped in, does that imply that we could
mark it dirty and kick off dirty pagecache writeback?

> +out:
> +		xfs_irele(ip);
> +	}
> +
> +	return rc;
> +}
> +
> +static int
> +xfs_fs_corrupted_range(
> +	struct super_block	*sb,
> +	struct block_device	*bdev,
> +	loff_t			offset,
> +	size_t			len,
> +	void			*data)
> +{
> +	struct xfs_mount	*mp = XFS_M(sb);
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_rmap_irec	rmap_low, rmap_high;
> +	struct xfs_buf		*agf_bp = NULL;
> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
> +	xfs_filblks_t		bcnt = XFS_B_TO_FSB(mp, len);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
> +	int			error = 0;
> +
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
> +		xfs_warn(mp, "corrupted_range support not available for realtime device!");
> +		return 0;
> +	}
> +	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_bdev == bdev &&
> +	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);

Longer term question for the rest of the xfs community: Can we do better
than this?  If the ail has checkpointed past this part of the log then
we could just write zeroes into dead area, right?

Also, if one of the log buffers points to a dead log area and isn't the
one that's currently being written into, can we just submit_bio it to
rewrite the lost part of the log??

> +		return 0;
> +	}
> +
> +	if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
> +		xfs_warn(mp, "corrupted_range needs rmapbt enabled!");
> +		return 0;
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
> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
> +
> +	/* Construct a range for rmap query */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bcnt;
> +
> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);

Long line here...

> +	if (error == -EFSCORRUPTED)
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);

This should go in xfs_corrupt_helper as I mentioned above.

--D

> +
> +	xfs_btree_del_cursor(cur, error);
> +	xfs_trans_brelse(tp, agf_bp);
> +out_cancel_tp:
> +	xfs_trans_cancel(tp);
> +	return error;
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1118,6 +1226,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.corrupted_range	= xfs_fs_corrupted_range,
>  };
>  
>  static int
> -- 
> 2.30.0
> 
> 
> 
