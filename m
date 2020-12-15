Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971652DB553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgLOUlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 15:41:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgLOUlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:41:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFKYJEX164464;
        Tue, 15 Dec 2020 20:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kAVfU2YSzTPNWt+XUeseFMhEQpB+HP/JJ1JjvbiIEDU=;
 b=vSeBCpGPnsOo61iuCOT7747IHkN1CQ+2khif/Tf5IX8feum8N5ZtMLuOZNq2H0Yie4hR
 sIcI4ebnP3dTZIVVaD1MJUzA2/uWNXC5tnELGuKk6WaYND4IOOZo0bLncBzS5yZu7u1i
 Yp5WeA87DUm4nAsPqIcBbKHlFKnSHenpM3APyvuli0HBAINFY5t2X0iJxZCv8M3oHY/4
 1cI0YMgqcosnagEL+Dedz8PHRV/L9ExKOg3vYjqFuveMKCMFqO4Pulf91BCUURkDFRZ/
 Q1J4jGM4AT1L3yal9tY2+2d3YigJcXY7S4obxILSdkU7admqMRCvj7vwj3rZrd54jUDm Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9rcqnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 20:40:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFKZ9rN178866;
        Tue, 15 Dec 2020 20:40:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35e6jrpctk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 20:40:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BFKeZwk028059;
        Tue, 15 Dec 2020 20:40:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 12:40:34 -0800
Date:   Tue, 15 Dec 2020 12:40:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [RFC PATCH v3 9/9] xfs: Implement ->corrupted_range() for XFS
Message-ID: <20201215204032.GA6918@magnolia>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-10-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215121414.253660-10-ruansy.fnst@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150138
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 08:14:14PM +0800, Shiyang Ruan wrote:
> This function is used to handle errors which may cause data lost in
> filesystem.  Such as memory failure in fsdax mode.
> 
> In XFS, it requires "rmapbt" feature in order to query for files or
> metadata which associated to the corrupted data.  Then we could call fs
> recover functions to try to repair the corrupted data.(did not
> implemented in this patchset)
> 
> After that, the memory failure also needs to notify the processes who
> are using those files.
> 
> Only support data device.  Realtime device is not supported for now.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_fsops.c | 10 +++++
>  fs/xfs/xfs_mount.h |  2 +
>  fs/xfs/xfs_super.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index ef1d5bb88b93..0ec1b44bfe88 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -501,6 +501,16 @@ xfs_do_force_shutdown(
>  "Corruption of in-memory data detected.  Shutting down filesystem");
>  		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>  			xfs_stack_trace();
> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
> +"Corruption of on-disk metadata detected.  Shutting down filesystem");
> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
> +			xfs_stack_trace();
> +	} else if (flags & SHUTDOWN_CORRUPT_DATA) {
> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
> +"Corruption of on-disk file data detected.  Shutting down filesystem");
> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
> +			xfs_stack_trace();
>  	} else if (logerror) {
>  		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
>  			"Log I/O Error Detected. Shutting down filesystem");
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index dfa429b77ee2..e36c07553486 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -274,6 +274,8 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
> +#define SHUTDOWN_CORRUPT_DATA	0x0020  /* corrupt file data on device */

This symbol isn't used anywhere.  I don't know why we'd shut down the fs
for data loss, as we don't do that anywhere else in xfs.

>  
>  /*
>   * Flags for xfs_mountfs
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e3e229e52512..30202de7e89d 100644
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
> @@ -1103,6 +1108,93 @@ xfs_fs_free_cached_objects(
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
> +	int				rc = 0;

Note: we usually use the name "error", not "rc".

> +	int				*flags = data;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner)) {

There are a few more things to check here to detect if metadata has been
lost.  The first is that any loss in the extended attribute information
is considered filesystem metadata; and the second is that loss of an
extent btree block is also metadata.

IOWs, this check should be:

	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
		// TODO check and try to fix metadata
		return -EFSCORRUPTED;
	}

> +		// TODO check and try to fix metadata
> +		rc = -EFSCORRUPTED;
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
> +		if (IS_DAX(VFS_I(ip)))
> +			rc = mf_dax_mapping_kill_procs(VFS_I(ip)->i_mapping,
> +						       rec->rm_offset, *flags);

If the file isn't S_DAX, should we call mapping_set_error here so
that the next fsync() will also return EIO?

> +
> +		// TODO try to fix data
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
> +	xfs_filblks_t		bc = XFS_B_TO_FSB(mp, len);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
> +	int			rc = 0;
> +
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
> +		xfs_warn(mp, "storage lost support not available for realtime device!");
> +		return 0;
> +	}

This ought to kill the fs when an external log device is configured:

	if (mp->m_logdev_targp &&
	    mp->m_logdev_targp != mp->m_ddev_targp &&
	    mp->m_logdev_targp->bt_bdev == bdev) {
		xfs_error(mp, "ondisk log corrupt, shutting down fs!");
		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
		return 0;
	}

Then, we need to check explicitly for rmap support:

	if (!xfs_sb_version_hasrmapbt(&mp->m_sb))
		return 0;

so that we screen out filesystems that don't have rmap enabled.

> +	rc = xfs_trans_alloc_empty(mp, &tp);
> +	if (rc)
> +		return rc;
> +
> +	rc = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +	if (rc)
> +		return rc;
> +
> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
> +
> +	/* Construct a range for rmap query */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bc;
> +
> +	rc = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);
> +	if (rc == -ECANCELED)
> +		rc = 0;

I don't think anything returns ECANCELED here...

--D

> +	if (rc == -EFSCORRUPTED)
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> +
> +	xfs_btree_del_cursor(cur, rc);
> +	xfs_trans_brelse(tp, agf_bp);
> +	return rc;
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1116,6 +1208,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.corrupted_range	= xfs_fs_corrupted_range,
>  };
>  
>  static int
> -- 
> 2.29.2
> 
> 
> 
