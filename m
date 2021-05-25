Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D39390BB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhEYVnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 17:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233467AbhEYVnB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 17:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E649613D5;
        Tue, 25 May 2021 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621978891;
        bh=Ff90q5Kz0o+BMBRcQ7Rxn+PAVevoQMBbngm/RLK1s+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7WwcUxQKZjNrqh4HMAxGnxr7VCwquen6SJALt7e7iV5i4bX++9K8LxIOp1kIRs5O
         9fLtSBpQdakVBftuhgpL4oFWpbo2sKjHVDMeZOcc+U/LPb3YEm1cZdPkvOb0fKwTph
         M7CkrFhzVExeTD7ns32hjrV6zpJlDrxFTt9gbb60Izc+41it5zfmeLQz6mn6Gmtyky
         Z7dqmDRkehTVa27itdEh+TeMb8S9UMmgOs0+FuntutheBG+gJkAyxxmHiwhTkWY0Cc
         EBpA5J63DL/mPwj7geODr3bz9PnyoVwd/6rImPFri9U0i1awZLAnS97c2mKicyRopd
         oJevdxgpT8cog==
Date:   Tue, 25 May 2021 14:41:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 08/13] xfs: Convert double locking of MMAPLOCK to use VFS
 helpers
Message-ID: <20210525214130.GP202121@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525135100.11221-8-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:50:45PM +0200, Jan Kara wrote:
> Convert places in XFS that take MMAPLOCK for two inodes to use helper
> VFS provides for it (filemap_invalidate_down_write_two()). Note that
> this changes lock ordering for MMAPLOCK from inode number based ordering
> to pointer based ordering VFS generally uses.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bmap_util.c | 15 ++++++++-------
>  fs/xfs/xfs_inode.c     | 37 +++++++++++--------------------------
>  2 files changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index a5e9d7d34023..8a5cede59f3f 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1582,7 +1582,6 @@ xfs_swap_extents(
>  	struct xfs_bstat	*sbp = &sxp->sx_stat;
>  	int			src_log_flags, target_log_flags;
>  	int			error = 0;
> -	int			lock_flags;
>  	uint64_t		f;
>  	int			resblks = 0;
>  	unsigned int		flags = 0;
> @@ -1594,8 +1593,8 @@ xfs_swap_extents(
>  	 * do the rest of the checks.
>  	 */
>  	lock_two_nondirectories(VFS_I(ip), VFS_I(tip));
> -	lock_flags = XFS_MMAPLOCK_EXCL;
> -	xfs_lock_two_inodes(ip, XFS_MMAPLOCK_EXCL, tip, XFS_MMAPLOCK_EXCL);
> +	filemap_invalidate_down_write_two(VFS_I(ip)->i_mapping,
> +					  VFS_I(tip)->i_mapping);
>  
>  	/* Verify that both files have the same format */
>  	if ((VFS_I(ip)->i_mode & S_IFMT) != (VFS_I(tip)->i_mode & S_IFMT)) {
> @@ -1667,7 +1666,6 @@ xfs_swap_extents(
>  	 * or cancel will unlock the inodes from this point onwards.
>  	 */
>  	xfs_lock_two_inodes(ip, XFS_ILOCK_EXCL, tip, XFS_ILOCK_EXCL);
> -	lock_flags |= XFS_ILOCK_EXCL;
>  	xfs_trans_ijoin(tp, ip, 0);
>  	xfs_trans_ijoin(tp, tip, 0);
>  
> @@ -1786,13 +1784,16 @@ xfs_swap_extents(
>  	trace_xfs_swap_extent_after(ip, 0);
>  	trace_xfs_swap_extent_after(tip, 1);
>  
> +out_unlock_ilock:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	xfs_iunlock(tip, XFS_ILOCK_EXCL);
>  out_unlock:
> -	xfs_iunlock(ip, lock_flags);
> -	xfs_iunlock(tip, lock_flags);
> +	filemap_invalidate_up_write_two(VFS_I(ip)->i_mapping,
> +					VFS_I(tip)->i_mapping);
>  	unlock_two_nondirectories(VFS_I(ip), VFS_I(tip));
>  	return error;
>  
>  out_trans_cancel:
>  	xfs_trans_cancel(tp);
> -	goto out_unlock;
> +	goto out_unlock_ilock;
>  }
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 53bb5fc33621..11616c9b37f8 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -537,12 +537,10 @@ xfs_lock_inodes(
>  }
>  
>  /*
> - * xfs_lock_two_inodes() can only be used to lock one type of lock at a time -
> - * the mmaplock or the ilock, but not more than one type at a time. If we lock
> - * more than one at a time, lockdep will report false positives saying we have
> - * violated locking orders.  The iolock must be double-locked separately since
> - * we use i_rwsem for that.  We now support taking one lock EXCL and the other
> - * SHARED.
> + * xfs_lock_two_inodes() can only be used to lock ilock. The iolock and
> + * mmaplock must be double-locked separately since we use i_rwsem and
> + * invalidate_lock for that. We now support taking one lock EXCL and the
> + * other SHARED.
>   */
>  void
>  xfs_lock_two_inodes(
> @@ -560,15 +558,8 @@ xfs_lock_two_inodes(
>  	ASSERT(hweight32(ip1_mode) == 1);
>  	ASSERT(!(ip0_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
>  	ASSERT(!(ip1_mode & (XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL)));
> -	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
> -	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
> -	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
> -	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
> -	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
> -	       !(ip0_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
> -	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
> -	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
> -
> +	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
> +	ASSERT(!(ip1_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)));
>  	ASSERT(ip0->i_ino != ip1->i_ino);
>  
>  	if (ip0->i_ino > ip1->i_ino) {
> @@ -3731,11 +3722,8 @@ xfs_ilock2_io_mmap(
>  	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
>  	if (ret)
>  		return ret;
> -	if (ip1 == ip2)
> -		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> -	else
> -		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
> -				    ip2, XFS_MMAPLOCK_EXCL);
> +	filemap_invalidate_down_write_two(VFS_I(ip1)->i_mapping,
> +					  VFS_I(ip2)->i_mapping);
>  	return 0;
>  }
>  
> @@ -3745,12 +3733,9 @@ xfs_iunlock2_io_mmap(
>  	struct xfs_inode	*ip1,
>  	struct xfs_inode	*ip2)
>  {
> -	bool			same_inode = (ip1 == ip2);
> -
> -	xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
> -	if (!same_inode)
> -		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> +	filemap_invalidate_up_write_two(VFS_I(ip1)->i_mapping,
> +					VFS_I(ip2)->i_mapping);
>  	inode_unlock(VFS_I(ip2));
> -	if (!same_inode)
> +	if (ip1 != ip2)
>  		inode_unlock(VFS_I(ip1));
>  }
> -- 
> 2.26.2
> 
