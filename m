Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAE1AABCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634811AbgDOPV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:21:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57626 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbgDOPV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:21:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFJc9k100210;
        Wed, 15 Apr 2020 15:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EdqX8TxniOimG4o/YwfRZ05YBfX2iVKTfStuhIZp9Ow=;
 b=TaFr7Q2SWTO2u+LvDbZvvmnN1sS2VD1hU1rZIHD98eKbxIfAHdkHz2Lk9rRISG5mOzv6
 7iwYt+9dIahu7lfA9bVCxlJddngnTVGlYYKgZN5DBvhRrtzOIrgjQMGeIun9xNO8qydw
 t4a2J4UmQeNyDfbpVnqetNeF2Lxq9ax62UE9N9fObusLJb2KcmLFPBOfQIeL+U8zRIEc
 kmflDr0tbPu4AZ07rg7ycjIX9QjhGOGb+dwMbY2ETwj0GcPQL4qhlivtQCmy/oCpI/ZJ
 rLtEj8hP0MZAkZ2I6TIK32DOI4vnV99KwdRxxYiOFqHuhgsy7CohqK3rzvBxuBh0pkVM 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30e0aa1k6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:21:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFHq8O039357;
        Wed, 15 Apr 2020 15:21:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30dynvswfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:21:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFLEZZ003216;
        Wed, 15 Apr 2020 15:21:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:21:13 -0700
Date:   Wed, 15 Apr 2020 08:21:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 10/11] fs/xfs: Change
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200415152112.GR6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-11-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=3 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:22PM -0700, ira.weiny@intel.com wrote:
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
>  fs/xfs/xfs_ioctl.c | 105 +++++++++------------------------------------
>  1 file changed, 20 insertions(+), 85 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index c6cd92ef4a05..75d4a830ef38 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1145,63 +1145,28 @@ xfs_ioctl_setattr_xflags(
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
> +		return;
>  
> -	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
> -	return 0;
> -
> -out_unlock:
> -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	return error;
> +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS ||
> +	    mp->m_flags & XFS_MOUNT_DAX_NEVER)

This ought to have parentheses around the two bit manipulation
operations to avoid complaints from picky/stupid compilers.

--D

> +		return;
>  
> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> +		flag_inode_dontcache(inode);
>  }
>  
>  /*
> @@ -1209,17 +1174,10 @@ xfs_ioctl_setattr_dax_invalidate(
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
> @@ -1236,8 +1194,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_unlock;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> -	join_flags = 0;
> +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  
>  	/*
>  	 * CAP_FOWNER overrides the following restrictions:
> @@ -1258,8 +1215,6 @@ xfs_ioctl_setattr_get_trans(
>  out_cancel:
>  	xfs_trans_cancel(tp);
>  out_unlock:
> -	if (join_flags)
> -		xfs_iunlock(ip, join_flags);
>  	return ERR_PTR(error);
>  }
>  
> @@ -1386,7 +1341,6 @@ xfs_ioctl_setattr(
>  	struct xfs_dquot	*pdqp = NULL;
>  	struct xfs_dquot	*olddquot = NULL;
>  	int			code;
> -	int			join_flags = 0;
>  
>  	trace_xfs_ioctl_setattr(ip);
>  
> @@ -1410,18 +1364,9 @@ xfs_ioctl_setattr(
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
> @@ -1552,7 +1497,6 @@ xfs_ioc_setxflags(
>  	struct fsxattr		fa;
>  	struct fsxattr		old_fa;
>  	unsigned int		flags;
> -	int			join_flags = 0;
>  	int			error;
>  
>  	if (copy_from_user(&flags, arg, sizeof(flags)))
> @@ -1569,18 +1513,9 @@ xfs_ioc_setxflags(
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
