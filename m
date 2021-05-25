Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB92390B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhEYVjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 17:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233461AbhEYVi7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 17:38:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D426613D8;
        Tue, 25 May 2021 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621978649;
        bh=nv08Dxq3HSmkoQ5pPmoU67FnZ+w+dkNHctp4s/QZUS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANhw69bWiEO4qKM9OmxmGcvl8tuonWhREShrEOy2nut+psi/R4u9okxCFKEWg8Puz
         JALodU7uPQRiQ0VF+EPvOBw0CLy5GTXBCeUu/4aMUkWuu85LWJWsVtfLaCPA2Yw3E9
         blJ66YPExqXLe3mJQorJCBkTk94NwsIFYZvnTBCL4ISKLX8GW5902EqfuTTIJZIpgz
         xig20XNu6k2NBZXcmZVbzOMIj5gkcRLDbjIwYfJgaS6bfFtw7wMpDQAQNFtvxBJ1Tf
         bqxtl7Kgub7H8zntfSjedjvUvUAshI8jPwTYR4CzPzPPCYcx0eYrRWn2aG/OE4GDbT
         mUkEOQkkJL3Kg==
Date:   Tue, 25 May 2021 14:37:29 -0700
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
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/13] xfs: Convert to use invalidate_lock
Message-ID: <20210525213729.GC202144@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525135100.11221-7-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:50:44PM +0200, Jan Kara wrote:
> Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
> purpose of invalidate_lock is exactly the same. Note that the locking in
> __xfs_filemap_fault() slightly changes as filemap_fault() already takes
> invalidate_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> CC: <linux-xfs@vger.kernel.org>
> CC: "Darrick J. Wong" <darrick.wong@oracle.com>

It's djwong@kernel.org now.

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/xfs/xfs_file.c  | 12 ++++++-----
>  fs/xfs/xfs_inode.c | 52 ++++++++++++++++++++++++++--------------------
>  fs/xfs/xfs_inode.h |  1 -
>  fs/xfs/xfs_super.c |  2 --
>  4 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 396ef36dcd0a..dc9cb5c20549 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1282,7 +1282,7 @@ xfs_file_llseek(
>   *
>   * mmap_lock (MM)
>   *   sb_start_pagefault(vfs, freeze)
> - *     i_mmaplock (XFS - truncate serialisation)
> + *     invalidate_lock (vfs/XFS_MMAPLOCK - truncate serialisation)
>   *       page_lock (MM)
>   *         i_lock (XFS - extent map serialisation)
>   */
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
>  
>  	if (write_fault)
>  		sb_end_pagefault(inode->i_sb);
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 0369eb22c1bb..53bb5fc33621 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -131,7 +131,7 @@ xfs_ilock_attr_map_shared(
>  
>  /*
>   * In addition to i_rwsem in the VFS inode, the xfs inode contains 2
> - * multi-reader locks: i_mmap_lock and the i_lock.  This routine allows
> + * multi-reader locks: invalidate_lock and the i_lock.  This routine allows
>   * various combinations of the locks to be obtained.
>   *
>   * The 3 locks should always be ordered so that the IO lock is obtained first,
> @@ -139,23 +139,23 @@ xfs_ilock_attr_map_shared(
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
> @@ -187,10 +187,13 @@ xfs_ilock(
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
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
>  		mrupdate_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
> @@ -239,10 +242,10 @@ xfs_ilock_nowait(
>  	}
>  
>  	if (lock_flags & XFS_MMAPLOCK_EXCL) {
> -		if (!mrtryupdate(&ip->i_mmaplock))
> +		if (!down_write_trylock(&VFS_I(ip)->i_mapping->invalidate_lock))
>  			goto out_undo_iolock;
>  	} else if (lock_flags & XFS_MMAPLOCK_SHARED) {
> -		if (!mrtryaccess(&ip->i_mmaplock))
> +		if (!down_read_trylock(&VFS_I(ip)->i_mapping->invalidate_lock))
>  			goto out_undo_iolock;
>  	}
>  
> @@ -257,9 +260,9 @@ xfs_ilock_nowait(
>  
>  out_undo_mmaplock:
>  	if (lock_flags & XFS_MMAPLOCK_EXCL)
> -		mrunlock_excl(&ip->i_mmaplock);
> +		up_write(&VFS_I(ip)->i_mapping->invalidate_lock);
>  	else if (lock_flags & XFS_MMAPLOCK_SHARED)
> -		mrunlock_shared(&ip->i_mmaplock);
> +		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
>  out_undo_iolock:
>  	if (lock_flags & XFS_IOLOCK_EXCL)
>  		up_write(&VFS_I(ip)->i_rwsem);
> @@ -306,9 +309,9 @@ xfs_iunlock(
>  		up_read(&VFS_I(ip)->i_rwsem);
>  
>  	if (lock_flags & XFS_MMAPLOCK_EXCL)
> -		mrunlock_excl(&ip->i_mmaplock);
> +		up_write(&VFS_I(ip)->i_mapping->invalidate_lock);
>  	else if (lock_flags & XFS_MMAPLOCK_SHARED)
> -		mrunlock_shared(&ip->i_mmaplock);
> +		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
>  		mrunlock_excl(&ip->i_lock);
> @@ -334,7 +337,7 @@ xfs_ilock_demote(
>  	if (lock_flags & XFS_ILOCK_EXCL)
>  		mrdemote(&ip->i_lock);
>  	if (lock_flags & XFS_MMAPLOCK_EXCL)
> -		mrdemote(&ip->i_mmaplock);
> +		downgrade_write(&VFS_I(ip)->i_mapping->invalidate_lock);
>  	if (lock_flags & XFS_IOLOCK_EXCL)
>  		downgrade_write(&VFS_I(ip)->i_rwsem);
>  
> @@ -355,8 +358,11 @@ xfs_isilocked(
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

This doesn't look right...

If lockdep is disabled, we always return true for
xfs_isilocked(ip, XFS_MMAPLOCK_EXCL) even if nobody holds the lock?

Granted, you probably just copy-pasted from the IOLOCK_SHARED clause
beneath it.  Er... oh right, preichl was messing with all that...

https://lore.kernel.org/linux-xfs/20201016021005.548850-2-preichl@redhat.com/

I guess I'll go have a look at that again.

--D

>  	}
>  
>  	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index ca826cfba91c..a0e4153efbbe 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -40,7 +40,6 @@ typedef struct xfs_inode {
>  	/* Transaction and locking information. */
>  	struct xfs_inode_log_item *i_itemp;	/* logging information */
>  	mrlock_t		i_lock;		/* inode lock */
> -	mrlock_t		i_mmaplock;	/* inode mmap IO lock */
>  	atomic_t		i_pincount;	/* inode pin count */
>  
>  	/*
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index a2dab05332ac..eeaf44910b5f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -715,8 +715,6 @@ xfs_fs_inode_init_once(
>  	atomic_set(&ip->i_pincount, 0);
>  	spin_lock_init(&ip->i_flags_lock);
>  
> -	mrlock_init(&ip->i_mmaplock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
> -		     "xfsino", ip->i_ino);
>  	mrlock_init(&ip->i_lock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
>  		     "xfsino", ip->i_ino);
>  }
> -- 
> 2.26.2
> 
