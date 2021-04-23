Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C1369CD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Apr 2021 00:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhDWWjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 18:39:47 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:54769 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231218AbhDWWjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:39:46 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 7BC2B80A75C;
        Sat, 24 Apr 2021 08:39:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1la4S2-004aVt-Ff; Sat, 24 Apr 2021 08:39:06 +1000
Date:   Sat, 24 Apr 2021 08:39:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 05/12] xfs: Convert to use invalidate_lock
Message-ID: <20210423223906.GB1990290@dread.disaster.area>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423173018.23133-5-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=nsORYdAwf03t2uNsi-0A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 07:29:34PM +0200, Jan Kara wrote:
> Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
> purpose of invalidate_lock is exactly the same. Note that the locking in
> __xfs_filemap_fault() slightly changes as filemap_fault() already takes
> invalidate_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> CC: <linux-xfs@vger.kernel.org>
> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/xfs/xfs_file.c  | 12 ++++++-----
>  fs/xfs/xfs_inode.c | 52 ++++++++++++++++++++++++++--------------------
>  fs/xfs/xfs_inode.h |  1 -
>  fs/xfs/xfs_super.c |  2 --
>  4 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a007ca0711d9..2fc04ce0e9f9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1282,7 +1282,7 @@ xfs_file_llseek(
>   *
>   * mmap_lock (MM)
>   *   sb_start_pagefault(vfs, freeze)
> - *     i_mmaplock (XFS - truncate serialisation)
> + *     invalidate_lock (vfs - truncate serialisation)
>   *       page_lock (MM)
>   *         i_lock (XFS - extent map serialisation)
>   */

I think this needs to say "vfs/XFS_MMAPLOCK", because it's not
obvious from reading the code that these are the same thing...

> @@ -1303,24 +1303,26 @@ __xfs_filemap_fault(
>  		file_update_time(vmf->vma->vm_file);
>  	}
>  
> -	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>  	if (IS_DAX(inode)) {
>  		pfn_t pfn;
>  
> +		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
>  				(write_fault && !vmf->cow_page) ?
>  				 &xfs_direct_write_iomap_ops :
>  				 &xfs_read_iomap_ops);
>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
> +		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>  	} else {
> -		if (write_fault)
> +		if (write_fault) {
> +			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>  			ret = iomap_page_mkwrite(vmf,
>  					&xfs_buffered_write_iomap_ops);
> -		else
> +			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> +		} else
>  			ret = filemap_fault(vmf);
>  	}
> -	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);

This is kinda messy. If you lift the filemap_fault() path out of
this, then there rest of the code remains largely unchanged:

	if (!IS_DAX(inode) && !write_fault)
		return filemap_fault(vmf);

        if (write_fault) {
		sb_start_pagefault(inode->i_sb);
		file_update_time(vmf->vma->vm_file);
	}

	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
	if (IS_DAX(inode)) {
		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
				(write_fault && !vmf->cow_page) ?
				 &xfs_direct_write_iomap_ops :
				 &xfs_read_iomap_ops);
		if (ret & VM_FAULT_NEEDDSYNC)
			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
	} else {
		ret = iomap_page_mkwrite(vmf, &xfs_buffered_write_iomap_ops);
	}
	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);

	if (write_fault)
		sb_end_pagefault(inode->i_sb);
	return ret;

>  
>  	if (write_fault)
>  		sb_end_pagefault(inode->i_sb);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index f93370bd7b1e..ac83409d0bf3 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -134,7 +134,7 @@ xfs_ilock_attr_map_shared(
>  
>  /*
>   * In addition to i_rwsem in the VFS inode, the xfs inode contains 2
> - * multi-reader locks: i_mmap_lock and the i_lock.  This routine allows
> + * multi-reader locks: invalidate_lock and the i_lock.  This routine allows
>   * various combinations of the locks to be obtained.
>   *
>   * The 3 locks should always be ordered so that the IO lock is obtained first,
> @@ -142,23 +142,23 @@ xfs_ilock_attr_map_shared(
>   *
>   * Basic locking order:
>   *
> - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> + * i_rwsem -> invalidate_lock -> page_lock -> i_ilock
>   *
>   * mmap_lock locking order:
>   *
>   * i_rwsem -> page lock -> mmap_lock
> - * mmap_lock -> i_mmap_lock -> page_lock
> + * mmap_lock -> invalidate_lock -> page_lock

Same here - while XFS_MMAPLOCK still exists, the comments should
really associate the VFS invalidate lock with the XFS_MMAPLOCK...

>   *
>   * The difference in mmap_lock locking order mean that we cannot hold the
> - * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> - * fault in pages during copy in/out (for buffered IO) or require the mmap_lock
> - * in get_user_pages() to map the user pages into the kernel address space for
> - * direct IO. Similarly the i_rwsem cannot be taken inside a page fault because
> - * page faults already hold the mmap_lock.
> + * invalidate_lock over syscall based read(2)/write(2) based IO. These IO paths
> + * can fault in pages during copy in/out (for buffered IO) or require the
> + * mmap_lock in get_user_pages() to map the user pages into the kernel address
> + * space for direct IO. Similarly the i_rwsem cannot be taken inside a page
> + * fault because page faults already hold the mmap_lock.
>   *
>   * Hence to serialise fully against both syscall and mmap based IO, we need to
> - * take both the i_rwsem and the i_mmap_lock. These locks should *only* be both
> - * taken in places where we need to invalidate the page cache in a race
> + * take both the i_rwsem and the invalidate_lock. These locks should *only* be
> + * both taken in places where we need to invalidate the page cache in a race
>   * free manner (e.g. truncate, hole punch and other extent manipulation
>   * functions).
>   */
> @@ -190,10 +190,13 @@ xfs_ilock(
>  				 XFS_IOLOCK_DEP(lock_flags));
>  	}
>  
> -	if (lock_flags & XFS_MMAPLOCK_EXCL)
> -		mrupdate_nested(&ip->i_mmaplock, XFS_MMAPLOCK_DEP(lock_flags));
> -	else if (lock_flags & XFS_MMAPLOCK_SHARED)
> -		mraccess_nested(&ip->i_mmaplock, XFS_MMAPLOCK_DEP(lock_flags));
> +	if (lock_flags & XFS_MMAPLOCK_EXCL) {
> +		down_write_nested(&VFS_I(ip)->i_mapping->invalidate_lock,
> +				  XFS_MMAPLOCK_DEP(lock_flags));
> +	} else if (lock_flags & XFS_MMAPLOCK_SHARED) {
> +		down_read_nested(&VFS_I(ip)->i_mapping->invalidate_lock,
> +				 XFS_MMAPLOCK_DEP(lock_flags));
> +	}

Well, that neuters all the "xfs_isilocked(ip, XFS_MMAPLOCK_EXCL)"
checks when lockdep is not enabled. IOWs, CONFIG_XFS_DEBUG=y will no
longer report incorrect use of read vs write locking.  That was the
main issue that stopped the last attempt to convert the mrlocks to
plain rwsems.

> @@ -358,8 +361,11 @@ xfs_isilocked(
>  
>  	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
>  		if (!(lock_flags & XFS_MMAPLOCK_SHARED))
> -			return !!ip->i_mmaplock.mr_writer;
> -		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
> +			return !debug_locks ||
> +				lockdep_is_held_type(
> +					&VFS_I(ip)->i_mapping->invalidate_lock,
> +					0);
> +		return rwsem_is_locked(&VFS_I(ip)->i_mapping->invalidate_lock);
>  	}

Yeah, this is the problem - the use of lockdep_is_held_type() here.
We need rwsem_is_write_locked() here, not a dependency on lockdep.

I know, you're only copying the IOLOCK stuff, but I really don't
like the fact that we end up more dependent on lockdep for catching
basic lock usage mistakes. Lockdep is simply not usable in typical
developer QA environment because of the performance overhead and
false positives it introduces. It already takes 3-4 hours to do a
single fstests run on XFS without lockdep and it at least doubles
when lockdep is enabled.  Hence requiring lockdep just to check a
rwsem is held in write mode is not an improvement on the development
and verification side of things....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
