Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB431A6985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbgDMQND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:13:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53116 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:12:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGAbB0021662;
        Mon, 13 Apr 2020 16:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pDenx9MnkyaPn+VTHPEtoLB3ox/bBPr6tmpD/F6AJME=;
 b=ME8D1w29Vo+Sz2e4JfRvME2qTJ7E3cAaqIQiqdHfkZRIJxAWzglUVDhVPK/7AV6wOIo8
 DHaW58HDKRAFjNt5kxBCICH8p79SeqLXXMiPGwJty3GABJSP+FTXTu0BkYU9nVcz/p21
 MyShFRIs2a7LXWI+TAXiRE5WByfgtzXwfgLFsC3orY2/qlOk0TBLGmp+QWzR3Wf9GdGH
 G+4PO5meEWagQEyv9SKlHtHuM+FvrzhJrbHUpq5ZioVWfuMY1qPNxpXVBI3zgdX6ak1L
 i8tKSv2R1XzoQugEOcTKfq/Ex5D0y/8EE+z/KaXc8sC1pxw6LeuPHZLgj+RMIhIzo3u9 sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30b5aqyew8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:12:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DG82TC135790;
        Mon, 13 Apr 2020 16:12:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30bqpcdsfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:12:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DGCgJa006179;
        Mon, 13 Apr 2020 16:12:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:12:42 -0700
Date:   Mon, 13 Apr 2020 09:12:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 8/9] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200413161240.GX6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-9-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=3 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=3 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:45PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> We only support changing FS_XFLAG_DAX on directories.  Files get their
> flag from the parent directory on creation only.  So no data
> invalidation needs to happen.
> 
> Alter the xfs_ioctl_setattr_dax_invalidate() to be
> xfs_ioctl_setattr_dax_validate().  xfs_ioctl_setattr_dax_validate() now
> validates that any FS_XFLAG_DAX change is ok.
> 
> This also allows use to remove the join_flags logic.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v6:
> 	Fix completely broken implementation and update commit message.
> 	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
> 	and S_DAX changing on drop_caches
> 
> Changes from v5:
> 	New patch
> ---
>  fs/xfs/xfs_ioctl.c | 102 +++++++--------------------------------------
>  1 file changed, 16 insertions(+), 86 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index c6cd92ef4a05..ba42a5fb5b05 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1145,63 +1145,23 @@ xfs_ioctl_setattr_xflags(
>  }
>  
>  /*
> - * If we are changing DAX flags, we have to ensure the file is clean and any
> - * cached objects in the address space are invalidated and removed. This
> - * requires us to lock out other IO and page faults similar to a truncate
> - * operation. The locks need to be held until the transaction has been committed
> - * so that the cache invalidation is atomic with respect to the DAX flag
> - * manipulation.
> + * Mark inodes with a changing FS_XFLAG_DAX, I_DONTCACHE
>   */
> -static int
> +static void
>  xfs_ioctl_setattr_dax_invalidate(
>  	struct xfs_inode	*ip,
> -	struct fsxattr		*fa,
> -	int			*join_flags)
> +	struct fsxattr		*fa)
>  {
> -	struct inode		*inode = VFS_I(ip);
> -	struct super_block	*sb = inode->i_sb;
> -	int			error;
> -
> -	*join_flags = 0;
> -
> -	/*
> -	 * It is only valid to set the DAX flag on regular files and
> -	 * directories on filesystems where the block size is equal to the page
> -	 * size. On directories it serves as an inherited hint so we don't
> -	 * have to check the device for dax support or flush pagecache.
> -	 */
> -	if (fa->fsx_xflags & FS_XFLAG_DAX) {
> -		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> -
> -		if (!bdev_dax_supported(target->bt_bdev, sb->s_blocksize))
> -			return -EINVAL;
> -	}
> -
> -	/* If the DAX state is not changing, we have nothing to do here. */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
> -		return 0;
> -	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
> -		return 0;
> +	struct inode            *inode = VFS_I(ip);
>  
>  	if (S_ISDIR(inode->i_mode))
> -		return 0;
> -
> -	/* lock, flush and invalidate mapping in preparation for flag change */
> -	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	error = filemap_write_and_wait(inode->i_mapping);
> -	if (error)
> -		goto out_unlock;
> -	error = invalidate_inode_pages2(inode->i_mapping);
> -	if (error)
> -		goto out_unlock;
> -
> -	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
> -	return 0;
> -
> -out_unlock:
> -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	return error;
> +		return;

We also need a check up here to skip the I_DONTCACHE setting if the
admin has set a mount option to override the inode flag.

The rest looks good to me.

--D

> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> +		inode->i_state |= I_DONTCACHE;
>  }
>  
>  /*
> @@ -1209,17 +1169,10 @@ xfs_ioctl_setattr_dax_invalidate(
>   * have permission to do so. On success, return a clean transaction and the
>   * inode locked exclusively ready for further operation specific checks. On
>   * failure, return an error without modifying or locking the inode.
> - *
> - * The inode might already be IO locked on call. If this is the case, it is
> - * indicated in @join_flags and we take full responsibility for ensuring they
> - * are unlocked from now on. Hence if we have an error here, we still have to
> - * unlock them. Otherwise, once they are joined to the transaction, they will
> - * be unlocked on commit/cancel.
>   */
>  static struct xfs_trans *
>  xfs_ioctl_setattr_get_trans(
> -	struct xfs_inode	*ip,
> -	int			join_flags)
> +	struct xfs_inode	*ip)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_trans	*tp;
> @@ -1236,8 +1189,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_unlock;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> -	join_flags = 0;
> +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  
>  	/*
>  	 * CAP_FOWNER overrides the following restrictions:
> @@ -1258,8 +1210,6 @@ xfs_ioctl_setattr_get_trans(
>  out_cancel:
>  	xfs_trans_cancel(tp);
>  out_unlock:
> -	if (join_flags)
> -		xfs_iunlock(ip, join_flags);
>  	return ERR_PTR(error);
>  }
>  
> @@ -1386,7 +1336,6 @@ xfs_ioctl_setattr(
>  	struct xfs_dquot	*pdqp = NULL;
>  	struct xfs_dquot	*olddquot = NULL;
>  	int			code;
> -	int			join_flags = 0;
>  
>  	trace_xfs_ioctl_setattr(ip);
>  
> @@ -1410,18 +1359,9 @@ xfs_ioctl_setattr(
>  			return code;
>  	}
>  
> -	/*
> -	 * Changing DAX config may require inode locking for mapping
> -	 * invalidation. These need to be held all the way to transaction commit
> -	 * or cancel time, so need to be passed through to
> -	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
> -	 * appropriately.
> -	 */
> -	code = xfs_ioctl_setattr_dax_invalidate(ip, fa, &join_flags);
> -	if (code)
> -		goto error_free_dquots;
> +	xfs_ioctl_setattr_dax_invalidate(ip, fa);
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		code = PTR_ERR(tp);
>  		goto error_free_dquots;
> @@ -1552,7 +1492,6 @@ xfs_ioc_setxflags(
>  	struct fsxattr		fa;
>  	struct fsxattr		old_fa;
>  	unsigned int		flags;
> -	int			join_flags = 0;
>  	int			error;
>  
>  	if (copy_from_user(&flags, arg, sizeof(flags)))
> @@ -1569,18 +1508,9 @@ xfs_ioc_setxflags(
>  	if (error)
>  		return error;
>  
> -	/*
> -	 * Changing DAX config may require inode locking for mapping
> -	 * invalidation. These need to be held all the way to transaction commit
> -	 * or cancel time, so need to be passed through to
> -	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
> -	 * appropriately.
> -	 */
> -	error = xfs_ioctl_setattr_dax_invalidate(ip, &fa, &join_flags);
> -	if (error)
> -		goto out_drop_write;
> +	xfs_ioctl_setattr_dax_invalidate(ip, &fa);
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		error = PTR_ERR(tp);
>  		goto out_drop_write;
> -- 
> 2.25.1
> 
