Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5199C1AFFE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 04:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDTCbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 22:31:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40414 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgDTCbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:31:38 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3B49A7EBC89;
        Mon, 20 Apr 2020 12:31:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jQMDb-0007nY-RJ; Mon, 20 Apr 2020 12:31:31 +1000
Date:   Mon, 20 Apr 2020 12:31:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 10/11] fs/xfs: Change
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200420023131.GC9800@dread.disaster.area>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-11-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-11-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8
        a=o5zHEhoZkx2EJpuSsmwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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

That describes what the code is doing, not why.

>   */
> -static int
> +static void
>  xfs_ioctl_setattr_dax_invalidate(
>  	struct xfs_inode	*ip,
> -	struct fsxattr		*fa,
> -	int			*join_flags)
> +	struct fsxattr		*fa)

It's not an invalidation function anymore, so needs a name change.

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
> +		return;

	if (mp->m_flags & (XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER))
		return;
> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> +		flag_inode_dontcache(inode);

This doesn't set the XFS inode's "don't cache" flag, despite it
having one that serves exactly the same purpose. IOWs, if the
XFS_IDONTCACHE flag is now redundant, please replace it's current
usage with this new flag and get rid of the XFS inode flag. i.e.
the only place we set XFS_IDONTCACHE can be replaced with a call to
this mark_inode_dontcache() call...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
