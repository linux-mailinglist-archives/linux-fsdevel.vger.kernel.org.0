Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA91B313D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDUUb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 16:31:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUUb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:31:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKIasU160601;
        Tue, 21 Apr 2020 20:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WEoBxXbx2NztmxlxhFZr7b7x9VQPbvJsFvnC9qZBjXo=;
 b=VxjovD5NgI5KsFfpWUrCqOkgaHfjfWkaJXuCDkQYYiM3Pytofc6ay76dPxdz/L1QIXrE
 W/ugsIeoDjUKNni1BRzvahtl4+OVOYc5pyRfEFeRYrTansFYV/VU+SWUkbRPKq7valuO
 9qPRhdDpTqwtNh+cN7ArCx7DIcQ85yH/JxiOg3S/ZXGdRYdlnqtIzUzWR+QLdqvlf4yX
 QfdCkWVpSooOQFkUT+NThbCxu+eGAqnABiQQaTlngrXpTTB09BP0Wnv0qyJIVoL8CNkp
 68FcRfJJZWAoM60Uw3XA+Cmeti7BTCe7qGUqQVQCY1xCjQxMUdUWerH++8u4WL4rwqVh Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30fsgky7dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:31:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKDSZf193352;
        Tue, 21 Apr 2020 20:31:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30gb90wuqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:31:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LKVhq7014249;
        Tue, 21 Apr 2020 20:31:43 GMT
Received: from localhost (/10.159.227.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 13:31:43 -0700
Date:   Tue, 21 Apr 2020 13:31:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 10/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200421203140.GD6742@magnolia>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-11-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=3 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=3 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:17:52PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Because of the separation of FS_XFLAG_DAX from S_DAX and the delayed
> setting of S_DAX, data invalidation no longer needs to happen when
> FS_XFLAG_DAX is changed.
> 
> Change xfs_ioctl_setattr_dax_invalidate() to be
> xfs_ioctl_dax_check_set_cache() and alter the code to reflect the new
> functionality.
> 
> Furthermore, we no longer need the locking so we remove the join_flags
> logic.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V8:
> 	Change name of function to xfs_ioctl_dax_check_set_cache()
> 	Update commit message
> 	Fix bit manipulations
> 
> Changes from V7:
> 	Use new flag_inode_dontcache()
> 	Skip don't cache if mount over ride is active.
> 
> Changes from v6:
> 	Fix completely broken implementation and update commit message.
> 	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
> 	and S_DAX changing on drop_caches
> 
> Changes from v5:
> 	New patch
> ---
>  fs/xfs/xfs_ioctl.c | 108 +++++++++------------------------------------
>  1 file changed, 20 insertions(+), 88 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 104495ac187c..b87b571a6748 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1245,64 +1245,26 @@ xfs_ioctl_setattr_xflags(
>  	return 0;
>  }
>  
> -/*
> - * If we are changing DAX flags, we have to ensure the file is clean and any
> - * cached objects in the address space are invalidated and removed. This
> - * requires us to lock out other IO and page faults similar to a truncate
> - * operation. The locks need to be held until the transaction has been committed
> - * so that the cache invalidation is atomic with respect to the DAX flag
> - * manipulation.
> - */
> -static int
> -xfs_ioctl_setattr_dax_invalidate(
> +static void
> +xfs_ioctl_dax_check_set_cache(

That's a ... strange name.  Set cache on what?

Oh, this is the function that sets I_DONTCACHE if an FS_XFLAG_DAX change
could have an immediate effect on S_DAX (assuming no other users).  What
do you think of the following?

	/*
	 * If a change to FS_XFLAG_DAX will result in an change to S_DAX
	 * the next time the incore inode is initialized, set the VFS
	 * I_DONTCACHE flag to try to hurry that along.
	 */
	static void
	xfs_ioctl_try_change_vfs_dax(...)

--D

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
> +	struct xfs_mount	*mp = ip->i_mount;
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
> +		return;
>  
> -out_unlock:
> -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	return error;
> +	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
> +	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
> +		return;
>  
> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> +		mark_inode_dontcache(inode);
>  }
>  
>  /*
> @@ -1310,17 +1272,10 @@ xfs_ioctl_setattr_dax_invalidate(
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
> @@ -1337,8 +1292,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_unlock;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> -	join_flags = 0;
> +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  
>  	/*
>  	 * CAP_FOWNER overrides the following restrictions:
> @@ -1359,8 +1313,6 @@ xfs_ioctl_setattr_get_trans(
>  out_cancel:
>  	xfs_trans_cancel(tp);
>  out_unlock:
> -	if (join_flags)
> -		xfs_iunlock(ip, join_flags);
>  	return ERR_PTR(error);
>  }
>  
> @@ -1486,7 +1438,6 @@ xfs_ioctl_setattr(
>  	struct xfs_dquot	*pdqp = NULL;
>  	struct xfs_dquot	*olddquot = NULL;
>  	int			code;
> -	int			join_flags = 0;
>  
>  	trace_xfs_ioctl_setattr(ip);
>  
> @@ -1510,18 +1461,9 @@ xfs_ioctl_setattr(
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
> +	xfs_ioctl_dax_check_set_cache(ip, fa);
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		code = PTR_ERR(tp);
>  		goto error_free_dquots;
> @@ -1651,7 +1593,6 @@ xfs_ioc_setxflags(
>  	struct fsxattr		fa;
>  	struct fsxattr		old_fa;
>  	unsigned int		flags;
> -	int			join_flags = 0;
>  	int			error;
>  
>  	if (copy_from_user(&flags, arg, sizeof(flags)))
> @@ -1668,18 +1609,9 @@ xfs_ioc_setxflags(
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
> +	xfs_ioctl_dax_check_set_cache(ip, &fa);
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		error = PTR_ERR(tp);
>  		goto out_drop_write;
> -- 
> 2.25.1
> 
