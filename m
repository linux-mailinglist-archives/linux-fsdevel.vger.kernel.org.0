Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A021A2565
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgDHPhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:37:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46396 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgDHPhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:37:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038FDlpx070604;
        Wed, 8 Apr 2020 15:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KeiGyQzCitBI7OpwnOdSAa98UlvLhw7jZV9PLWvum7k=;
 b=s/Hue1ySZvDibbj2dPDDcv/XuME+YnwWLnOnFn8IVdXNYO4borKG7OD7TjPun5Hj05Pa
 J32JBAdYj2FaTAco/nrdzBdofYGvz2fD9jEclKU64vYnnAa6na9dbqIY5hilnIBboExt
 1jPu4ZsN+Jn68e4ZQhELsl0fCpLHxN6CFwPRcX+SBScR37NgAveXVRtoa/67BXI8HbfC
 OOmtfj1yVcYSb+jf0HNDdehtquDVW8sN0/820o65T1iqeM2fQMT5PoiggovxD1f0xWhz
 N0xmR38CBQKvrqPOxmdJJvCuFCDa39pQAH8RCuEudYA7QWAL/BWJ9wELX8jQXXRVR0vH 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3091m0vapc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 15:37:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038FCYKa173999;
        Wed, 8 Apr 2020 15:37:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 309gd8wbqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 15:37:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 038FbKr3027899;
        Wed, 8 Apr 2020 15:37:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 08:37:20 -0700
Date:   Wed, 8 Apr 2020 08:37:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
 to xfs_ioctl_dax_check()
Message-ID: <20200408153717.GH6742@magnolia>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407182958.568475-8-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=3 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:29:57AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> We only support changing FS_XFLAG_DAX on directories.  Files get their
> flag from the parent directory on creation only.  So no data
> invalidation needs to happen.
> 
> Alter the xfs_ioctl_setattr_dax_invalidate() to be
> xfs_ioctl_dax_check().
> 
> This also allows use to remove the join_flags logic.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v5:
> 	New patch
> ---
>  fs/xfs/xfs_ioctl.c | 91 +++++-----------------------------------------
>  1 file changed, 10 insertions(+), 81 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index c6cd92ef4a05..5472faab7c4f 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1145,63 +1145,18 @@ xfs_ioctl_setattr_xflags(
>  }
>  
>  /*
> - * If we are changing DAX flags, we have to ensure the file is clean and any
> - * cached objects in the address space are invalidated and removed. This
> - * requires us to lock out other IO and page faults similar to a truncate
> - * operation. The locks need to be held until the transaction has been committed
> - * so that the cache invalidation is atomic with respect to the DAX flag
> - * manipulation.
> + * Only directories are allowed to change dax flags
>   */
>  static int
>  xfs_ioctl_setattr_dax_invalidate(
> -	struct xfs_inode	*ip,
> -	struct fsxattr		*fa,
> -	int			*join_flags)
> +	struct xfs_inode	*ip)
>  {
>  	struct inode		*inode = VFS_I(ip);
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

Does the !S_ISDIR check below apply unconditionally even if we weren't
trying to change the DAX flag?

> -	if (S_ISDIR(inode->i_mode))
> -		return 0;
>  
> -	/* lock, flush and invalidate mapping in preparation for flag change */
> -	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	error = filemap_write_and_wait(inode->i_mapping);
> -	if (error)
> -		goto out_unlock;
> -	error = invalidate_inode_pages2(inode->i_mapping);
> -	if (error)
> -		goto out_unlock;
> +	if (!S_ISDIR(inode->i_mode))
> +		return -EINVAL;

If this entire function collapses to an S_ISDIR check then you might
as well just hoist this one piece to the caller.  Also, where is
xfs_ioctl_dax_check?

<confused>

--D

>  
> -	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
>  	return 0;
> -
> -out_unlock:
> -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> -	return error;
> -
>  }
>  
>  /*
> @@ -1209,17 +1164,10 @@ xfs_ioctl_setattr_dax_invalidate(
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
> @@ -1236,8 +1184,7 @@ xfs_ioctl_setattr_get_trans(
>  		goto out_unlock;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> -	join_flags = 0;
> +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  
>  	/*
>  	 * CAP_FOWNER overrides the following restrictions:
> @@ -1258,8 +1205,6 @@ xfs_ioctl_setattr_get_trans(
>  out_cancel:
>  	xfs_trans_cancel(tp);
>  out_unlock:
> -	if (join_flags)
> -		xfs_iunlock(ip, join_flags);
>  	return ERR_PTR(error);
>  }
>  
> @@ -1386,7 +1331,6 @@ xfs_ioctl_setattr(
>  	struct xfs_dquot	*pdqp = NULL;
>  	struct xfs_dquot	*olddquot = NULL;
>  	int			code;
> -	int			join_flags = 0;
>  
>  	trace_xfs_ioctl_setattr(ip);
>  
> @@ -1410,18 +1354,11 @@ xfs_ioctl_setattr(
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
> +	code = xfs_ioctl_setattr_dax_invalidate(ip);
>  	if (code)
>  		goto error_free_dquots;
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		code = PTR_ERR(tp);
>  		goto error_free_dquots;
> @@ -1552,7 +1489,6 @@ xfs_ioc_setxflags(
>  	struct fsxattr		fa;
>  	struct fsxattr		old_fa;
>  	unsigned int		flags;
> -	int			join_flags = 0;
>  	int			error;
>  
>  	if (copy_from_user(&flags, arg, sizeof(flags)))
> @@ -1569,18 +1505,11 @@ xfs_ioc_setxflags(
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
> +	error = xfs_ioctl_setattr_dax_invalidate(ip);
>  	if (error)
>  		goto out_drop_write;
>  
> -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> +	tp = xfs_ioctl_setattr_get_trans(ip);
>  	if (IS_ERR(tp)) {
>  		error = PTR_ERR(tp);
>  		goto out_drop_write;
> -- 
> 2.25.1
> 
