Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6461EC0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBRYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 13:24:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBRYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:24:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052HLtG1100291;
        Tue, 2 Jun 2020 17:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=69/JLxXKjizNOV1XvRT1+9SrWey+uOeGWCCeVirdDfs=;
 b=AblGUQfa4Wz0RtDPdDZBOxr5b5ZOLLeysPtmE7zrYGoqfzvhSrTo446h7Mhs4oOIHWNP
 LALzkfblEa3UJDirwWtEMRFzLB74tX7fm9eFGoH8mxaH9E6zsIjRNYd9eEtM+k8kSSWy
 hjWlbzxWJe5zMlyh2mCukN3IlAo46J4akgjFDbxOSi/hpLj7JW6iGyl7BhUIbR1Rlnks
 3cgNOiXGVRsni5H4p/Z5xNCfERQ8rCZjjEqVAKrO83rW91cV5Mw1CJpjw1kluqpEyXTi
 1KRK6qfmhBj5NWwPSXCswACc4c7NoWaE/A8+a2sv88ubG546E7hHJ4ypAM4F2tWc6tJc Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewqwa12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 17:23:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052HHvrk183806;
        Tue, 2 Jun 2020 17:23:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25phktu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 17:23:57 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 052HNtW4030839;
        Tue, 2 Jun 2020 17:23:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 10:23:54 -0700
Date:   Tue, 2 Jun 2020 10:23:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 11/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200602172353.GC8230@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-12-ira.weiny@intel.com>
 <20200428201138.GD6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428201138.GD6742@magnolia>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=10
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=10 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:11:38PM -0700, Darrick J. Wong wrote:
> On Mon, Apr 27, 2020 at 05:21:42PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Because of the separation of FS_XFLAG_DAX from S_DAX and the delayed
> > setting of S_DAX, data invalidation no longer needs to happen when
> > FS_XFLAG_DAX is changed.
> > 
> > Change xfs_ioctl_setattr_dax_invalidate() to be
> > xfs_ioctl_dax_check_set_cache() and alter the code to reflect the new
> > functionality.
> > 
> > Furthermore, we no longer need the locking so we remove the join_flags
> > logic.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Looks ok,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D
> 
> > 
> > ---
> > Changes from V10:
> > 	adjust for renamed d_mark_dontcache() function
> > 
> > Changes from V9:
> > 	Change name of function to xfs_ioctl_setattr_prepare_dax()
> > 
> > Changes from V8:
> > 	Change name of function to xfs_ioctl_dax_check_set_cache()
> > 	Update commit message
> > 	Fix bit manipulations
> > 
> > Changes from V7:
> > 	Use new flag_inode_dontcache()
> > 	Skip don't cache if mount over ride is active.
> > 
> > Changes from v6:
> > 	Fix completely broken implementation and update commit message.
> > 	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
> > 	and S_DAX changing on drop_caches
> > 
> > Changes from v5:
> > 	New patch
> > ---
> >  fs/xfs/xfs_ioctl.c | 108 +++++++++------------------------------------
> >  1 file changed, 20 insertions(+), 88 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index 104495ac187c..ff474f2c9acf 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1245,64 +1245,26 @@ xfs_ioctl_setattr_xflags(
> >  	return 0;
> >  }
> >  
> > -/*
> > - * If we are changing DAX flags, we have to ensure the file is clean and any
> > - * cached objects in the address space are invalidated and removed. This
> > - * requires us to lock out other IO and page faults similar to a truncate
> > - * operation. The locks need to be held until the transaction has been committed
> > - * so that the cache invalidation is atomic with respect to the DAX flag
> > - * manipulation.
> > - */
> > -static int
> > -xfs_ioctl_setattr_dax_invalidate(
> > +static void
> > +xfs_ioctl_setattr_prepare_dax(
> >  	struct xfs_inode	*ip,
> > -	struct fsxattr		*fa,
> > -	int			*join_flags)
> > +	struct fsxattr		*fa)
> >  {
> > -	struct inode		*inode = VFS_I(ip);
> > -	struct super_block	*sb = inode->i_sb;
> > -	int			error;
> > -
> > -	*join_flags = 0;
> > -
> > -	/*
> > -	 * It is only valid to set the DAX flag on regular files and
> > -	 * directories on filesystems where the block size is equal to the page
> > -	 * size. On directories it serves as an inherited hint so we don't
> > -	 * have to check the device for dax support or flush pagecache.
> > -	 */
> > -	if (fa->fsx_xflags & FS_XFLAG_DAX) {
> > -		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > -
> > -		if (!bdev_dax_supported(target->bt_bdev, sb->s_blocksize))
> > -			return -EINVAL;
> > -	}
> > -
> > -	/* If the DAX state is not changing, we have nothing to do here. */
> > -	if ((fa->fsx_xflags & FS_XFLAG_DAX) && IS_DAX(inode))
> > -		return 0;
> > -	if (!(fa->fsx_xflags & FS_XFLAG_DAX) && !IS_DAX(inode))
> > -		return 0;
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	struct inode            *inode = VFS_I(ip);
> >  
> >  	if (S_ISDIR(inode->i_mode))
> > -		return 0;
> > -
> > -	/* lock, flush and invalidate mapping in preparation for flag change */
> > -	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > -	error = filemap_write_and_wait(inode->i_mapping);
> > -	if (error)
> > -		goto out_unlock;
> > -	error = invalidate_inode_pages2(inode->i_mapping);
> > -	if (error)
> > -		goto out_unlock;
> > -
> > -	*join_flags = XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL;
> > -	return 0;
> > +		return;
> >  
> > -out_unlock:
> > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > -	return error;
> > +	if ((mp->m_flags & XFS_MOUNT_DAX_ALWAYS) ||
> > +	    (mp->m_flags & XFS_MOUNT_DAX_NEVER))
> > +		return;
> >  
> > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > +		d_mark_dontcache(inode);

Now that I think about this further, are we /really/ sure that we want
to let unprivileged userspace cause inode evictions?

--D

> >  }
> >  
> >  /*
> > @@ -1310,17 +1272,10 @@ xfs_ioctl_setattr_dax_invalidate(
> >   * have permission to do so. On success, return a clean transaction and the
> >   * inode locked exclusively ready for further operation specific checks. On
> >   * failure, return an error without modifying or locking the inode.
> > - *
> > - * The inode might already be IO locked on call. If this is the case, it is
> > - * indicated in @join_flags and we take full responsibility for ensuring they
> > - * are unlocked from now on. Hence if we have an error here, we still have to
> > - * unlock them. Otherwise, once they are joined to the transaction, they will
> > - * be unlocked on commit/cancel.
> >   */
> >  static struct xfs_trans *
> >  xfs_ioctl_setattr_get_trans(
> > -	struct xfs_inode	*ip,
> > -	int			join_flags)
> > +	struct xfs_inode	*ip)
> >  {
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	struct xfs_trans	*tp;
> > @@ -1337,8 +1292,7 @@ xfs_ioctl_setattr_get_trans(
> >  		goto out_unlock;
> >  
> >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> > -	join_flags = 0;
> > +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> >  
> >  	/*
> >  	 * CAP_FOWNER overrides the following restrictions:
> > @@ -1359,8 +1313,6 @@ xfs_ioctl_setattr_get_trans(
> >  out_cancel:
> >  	xfs_trans_cancel(tp);
> >  out_unlock:
> > -	if (join_flags)
> > -		xfs_iunlock(ip, join_flags);
> >  	return ERR_PTR(error);
> >  }
> >  
> > @@ -1486,7 +1438,6 @@ xfs_ioctl_setattr(
> >  	struct xfs_dquot	*pdqp = NULL;
> >  	struct xfs_dquot	*olddquot = NULL;
> >  	int			code;
> > -	int			join_flags = 0;
> >  
> >  	trace_xfs_ioctl_setattr(ip);
> >  
> > @@ -1510,18 +1461,9 @@ xfs_ioctl_setattr(
> >  			return code;
> >  	}
> >  
> > -	/*
> > -	 * Changing DAX config may require inode locking for mapping
> > -	 * invalidation. These need to be held all the way to transaction commit
> > -	 * or cancel time, so need to be passed through to
> > -	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
> > -	 * appropriately.
> > -	 */
> > -	code = xfs_ioctl_setattr_dax_invalidate(ip, fa, &join_flags);
> > -	if (code)
> > -		goto error_free_dquots;
> > +	xfs_ioctl_setattr_prepare_dax(ip, fa);
> >  
> > -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> > +	tp = xfs_ioctl_setattr_get_trans(ip);
> >  	if (IS_ERR(tp)) {
> >  		code = PTR_ERR(tp);
> >  		goto error_free_dquots;
> > @@ -1651,7 +1593,6 @@ xfs_ioc_setxflags(
> >  	struct fsxattr		fa;
> >  	struct fsxattr		old_fa;
> >  	unsigned int		flags;
> > -	int			join_flags = 0;
> >  	int			error;
> >  
> >  	if (copy_from_user(&flags, arg, sizeof(flags)))
> > @@ -1668,18 +1609,9 @@ xfs_ioc_setxflags(
> >  	if (error)
> >  		return error;
> >  
> > -	/*
> > -	 * Changing DAX config may require inode locking for mapping
> > -	 * invalidation. These need to be held all the way to transaction commit
> > -	 * or cancel time, so need to be passed through to
> > -	 * xfs_ioctl_setattr_get_trans() so it can apply them to the join call
> > -	 * appropriately.
> > -	 */
> > -	error = xfs_ioctl_setattr_dax_invalidate(ip, &fa, &join_flags);
> > -	if (error)
> > -		goto out_drop_write;
> > +	xfs_ioctl_setattr_prepare_dax(ip, &fa);
> >  
> > -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> > +	tp = xfs_ioctl_setattr_get_trans(ip);
> >  	if (IS_ERR(tp)) {
> >  		error = PTR_ERR(tp);
> >  		goto out_drop_write;
> > -- 
> > 2.25.1
> > 
