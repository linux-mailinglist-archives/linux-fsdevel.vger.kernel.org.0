Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E031A6CCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbgDMTqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 15:46:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:2914 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387774AbgDMTqb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:46:31 -0400
IronPort-SDR: grEFM0nhMEbvPTaie49Xn6oP9QUTNd6QpZ4rtP0JOJkG7NUIu2hp+UniACxAuIp2Vhg+lQBn00
 skocZ4GfAY9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 12:46:30 -0700
IronPort-SDR: e4mMITxY+fkq+PARmd2XJYn1qgoh2dn84nSTYeUzXAhlMWRZa9fI+jXQDxAMfekIN3a1LzDQ1n
 9hWem+LTO3lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="277010474"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2020 12:46:30 -0700
Date:   Mon, 13 Apr 2020 12:46:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 8/9] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200413194609.GE1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-9-ira.weiny@intel.com>
 <20200413161240.GX6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413161240.GX6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:12:40AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 12, 2020 at 10:40:45PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > We only support changing FS_XFLAG_DAX on directories.  Files get their
> > flag from the parent directory on creation only.  So no data
> > invalidation needs to happen.
> > 
> > Alter the xfs_ioctl_setattr_dax_invalidate() to be
> > xfs_ioctl_setattr_dax_validate().  xfs_ioctl_setattr_dax_validate() now
> > validates that any FS_XFLAG_DAX change is ok.
> > 
> > This also allows use to remove the join_flags logic.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v6:
> > 	Fix completely broken implementation and update commit message.
> > 	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
> > 	and S_DAX changing on drop_caches
> > 
> > Changes from v5:
> > 	New patch
> > ---
> >  fs/xfs/xfs_ioctl.c | 102 +++++++--------------------------------------
> >  1 file changed, 16 insertions(+), 86 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index c6cd92ef4a05..ba42a5fb5b05 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1145,63 +1145,23 @@ xfs_ioctl_setattr_xflags(
> >  }
> >  
> >  /*
> > - * If we are changing DAX flags, we have to ensure the file is clean and any
> > - * cached objects in the address space are invalidated and removed. This
> > - * requires us to lock out other IO and page faults similar to a truncate
> > - * operation. The locks need to be held until the transaction has been committed
> > - * so that the cache invalidation is atomic with respect to the DAX flag
> > - * manipulation.
> > + * Mark inodes with a changing FS_XFLAG_DAX, I_DONTCACHE
> >   */
> > -static int
> > +static void
> >  xfs_ioctl_setattr_dax_invalidate(
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
> > -
> > -out_unlock:
> > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > -	return error;
> > +		return;
> 
> We also need a check up here to skip the I_DONTCACHE setting if the
> admin has set a mount option to override the inode flag.

Yes that would be more optimal!

Thanks,
Ira

> 
> The rest looks good to me.
> 
> --D
> 
> > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > +		inode->i_state |= I_DONTCACHE;
> >  }
> >  
> >  /*
> > @@ -1209,17 +1169,10 @@ xfs_ioctl_setattr_dax_invalidate(
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
> > @@ -1236,8 +1189,7 @@ xfs_ioctl_setattr_get_trans(
> >  		goto out_unlock;
> >  
> >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > -	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL | join_flags);
> > -	join_flags = 0;
> > +	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> >  
> >  	/*
> >  	 * CAP_FOWNER overrides the following restrictions:
> > @@ -1258,8 +1210,6 @@ xfs_ioctl_setattr_get_trans(
> >  out_cancel:
> >  	xfs_trans_cancel(tp);
> >  out_unlock:
> > -	if (join_flags)
> > -		xfs_iunlock(ip, join_flags);
> >  	return ERR_PTR(error);
> >  }
> >  
> > @@ -1386,7 +1336,6 @@ xfs_ioctl_setattr(
> >  	struct xfs_dquot	*pdqp = NULL;
> >  	struct xfs_dquot	*olddquot = NULL;
> >  	int			code;
> > -	int			join_flags = 0;
> >  
> >  	trace_xfs_ioctl_setattr(ip);
> >  
> > @@ -1410,18 +1359,9 @@ xfs_ioctl_setattr(
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
> > +	xfs_ioctl_setattr_dax_invalidate(ip, fa);
> >  
> > -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> > +	tp = xfs_ioctl_setattr_get_trans(ip);
> >  	if (IS_ERR(tp)) {
> >  		code = PTR_ERR(tp);
> >  		goto error_free_dquots;
> > @@ -1552,7 +1492,6 @@ xfs_ioc_setxflags(
> >  	struct fsxattr		fa;
> >  	struct fsxattr		old_fa;
> >  	unsigned int		flags;
> > -	int			join_flags = 0;
> >  	int			error;
> >  
> >  	if (copy_from_user(&flags, arg, sizeof(flags)))
> > @@ -1569,18 +1508,9 @@ xfs_ioc_setxflags(
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
> > +	xfs_ioctl_setattr_dax_invalidate(ip, &fa);
> >  
> > -	tp = xfs_ioctl_setattr_get_trans(ip, join_flags);
> > +	tp = xfs_ioctl_setattr_get_trans(ip);
> >  	if (IS_ERR(tp)) {
> >  		error = PTR_ERR(tp);
> >  		goto out_drop_write;
> > -- 
> > 2.25.1
> > 
