Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB417517E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 02:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCBB0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 20:26:50 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44209 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgCBB0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:26:50 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EFDC43A18F5;
        Mon,  2 Mar 2020 12:26:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j8Zr2-0005Rv-Nx; Mon, 02 Mar 2020 12:26:44 +1100
Date:   Mon, 2 Mar 2020 12:26:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V5 06/12] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200302012644.GF10776@dread.disaster.area>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200227052442.22524-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227052442.22524-7-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=9IOwo1hVm1SR5oLVEfkA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:24:36PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DAX requires special address space operations (aops).  Changing DAX
> state therefore requires changing those aops.
> 
> However, many functions require aops to remain consistent through a deep
> call stack.
> 
> Define a vfs level inode rwsem to protect aops throughout call stacks
> which require them.
> 
> Finally, define calls to be used in subsequent patches when aops usage
> needs to be quiesced by the file system.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
....
> diff --git a/fs/stat.c b/fs/stat.c
> index 894699c74dde..274b3ccc82b1 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -79,8 +79,10 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> +	inode_aops_down_read(inode);
>  	if (IS_DAX(inode))
>  		stat->attributes |= STATX_ATTR_DAX;
> +	inode_aops_up_read(inode);

No locking needed here. statx() is racy to begin with (i.e.
information will be wrong by the time the syscall gets back to
userspace. Hence it really doesn't matter if we race checking the
flag here or not, and because this is a lockless fast path for
many worklaods (e.g. git), keeping locking out of the stat() fast
path is desirable.

>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 836a1f09be03..3e83a97dc047 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -420,6 +420,7 @@ xfs_iget_cache_hit(
>  		rcu_read_unlock();
>  
>  		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> +		ASSERT(!rwsem_is_locked(&inode->i_aops_sem));
>  		error = xfs_reinit_inode(mp, inode);
>  		if (error) {
>  			bool wake;

No need for this - aops can never be called on an XFS inode in
the reclaimable state - it's not visible to the VFS at this point.
If you need to assert that the lock has not been leaked, then this
needs to be done at the point where the VFS reclaims the inode (i.e.
the evict() path), not deep in XFS.

>  static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
>  				     struct iov_iter *iter)
>  {
> -	return file->f_op->read_iter(kio, iter);
> +	struct inode		*inode = file_inode(kio->ki_filp);
> +	ssize_t ret;
> +
> +	inode_aops_down_read(inode);
> +	ret = file->f_op->read_iter(kio, iter);
> +	inode_aops_up_read(inode);
> +	return ret;
>  }
>  
>  static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
>  				      struct iov_iter *iter)
>  {
> -	return file->f_op->write_iter(kio, iter);
> +	struct inode		*inode = file_inode(kio->ki_filp);
> +	ssize_t ret;
> +
> +	inode_aops_down_read(inode);
> +	ret = file->f_op->write_iter(kio, iter);
> +	inode_aops_up_read(inode);
> +	return ret;
>  }

I'm really on the fence about this. I don't really like it, but I
can't really put my finger on why :/

>  
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 4f17c83db575..6a30febb11e0 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -48,6 +48,8 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  	bdi = inode_to_bdi(mapping->host);
>  
>  	if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
> +		int ret = 0;
> +
>  		switch (advice) {
>  		case POSIX_FADV_NORMAL:
>  		case POSIX_FADV_RANDOM:
> @@ -58,9 +60,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>  			/* no bad return value, but ignore advice */
>  			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
>  		}
> -		return 0;
> +
> +		return ret;
>  	}

Completely spurious changes?

>  
>  	/*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1784478270e1..3a7863ba51b9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2293,6 +2293,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		 * and return.  Otherwise fallthrough to buffered io for
>  		 * the rest of the read.  Buffered reads will not work for
>  		 * DAX files, so don't bother trying.
> +		 *
> +		 * IS_DAX is protected under ->read_iter lock
>  		 */
>  		if (retval < 0 || !count || iocb->ki_pos >= size ||
>  		    IS_DAX(inode))

This check is in the DIO path, be we can't do DIO on DAX enabled
files to begin with, so we can only get here if S_DAX is not set on
the file.

Further, if IOCB_DIRECT is set, neither ext4 nor XFS call
generic_file_read_iter(); they run the iomap_dio_rw() path directly
instead. Only ext2 calls generic_file_read_iter() to do direct IO,
so it's the only filesystem that needs this IS_DAX() check in it.

I think we should fix ext2 to be implemented like ext4 and XFS -
they implement the buffered IO fallback, should it be required,
themselves and never use generic_file_read_iter() for direct IO.

That would allow us to add this to generic_file_read_iter():

	if (WARN_ON_ONCE(IS_DAX(inode))
		return -EINVAL;

to indicate that this should never be called directly on a DAX
capable filesystem. This places all the responsibility for managing
DAX behaviour on the filesystem, which then allows us to reason more
solidly about how the filesystem IO paths use and check the S_DAX
flag.

i.e. changing the on-disk flag already locks out the filesystem IO
path via the i_rwsem(), and all the filesystem IO paths (buffered,
direct IO and dax) are serialised by this flag. Hence we can check
once in the filesystem path once we have the i_rwsem held and
know that S_DAX will not change until we release it.

..... and now I realise what I was sitting on the fence about....

I don't like the aops locking in call_read/write_iter() because it
is actually redundant: the filesystem should be doing the necessary
locking in the IO path via the i_rwsem to prevent S_DAX from
changing while it is doing the IO.

IOWs, we need to restructure the locking inside the filesystem
read_iter and write_iter methods so that the i_rwsem protects the
S_DAX flag from changing dynamically. They all do:

	if (dax)
		do_dax_io()
	if (direct)
		do_direct_io()
	do_buffered_io()

And then we take the i_rwsem inside each of those functions and do
the IO. What we actually need to do is something like this:

	inode_lock_shared()
	if (dax)
		do_dax_io()
	if (direct)
		do_direct_io()
	do_buffered_io()
	inode_unlock_shared()

And remove the inode locking from inside the individual IO methods
themselves. It's a bit more complex than this because buffered
writes require exclusive locking, but this completely removes the
need for holding an aops lock over these methods.

I've attached a couple of untested patches (I've compiled them, so
they must be good!) to demonstrate what I mean for the XFS IO path.
The read side removes a heap of duplicate code, but the write side
is .... unfortunately complex. Have to think about that more.

> @@ -3377,6 +3379,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 * holes, for example.  For DAX files, a buffered write will
>  		 * not succeed (even if it did, DAX does not handle dirty
>  		 * page-cache pages correctly).
> +		 *
> +		 * IS_DAX is protected under ->write_iter lock
>  		 */
>  		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
>  			goto out;

Same here - this should never be called for DAX+iomap capable
filesystems.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b08b199f9a11..3d05bd10d83e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -572,6 +572,7 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  	unsigned long ret;
>  	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>  
> +	/* Should not need locking here because mmap is not allowed */
>  	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
>  		goto out;
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b679908743cb..f048178e2b93 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1592,9 +1592,11 @@ static void collapse_file(struct mm_struct *mm,
>  		} else {	/* !is_shmem */
>  			if (!page || xa_is_value(page)) {
>  				xas_unlock_irq(&xas);
> +				inode_aops_down_read(file->f_inode);
>  				page_cache_sync_readahead(mapping, &file->f_ra,
>  							  file, index,
>  							  PAGE_SIZE);
> +				inode_aops_up_read(file->f_inode);

Why is this readahead call needing aops protection, but not anywhere
else? And if this is not being done while holding a filesystem lock
(like i_rwsem or MMAPLOCK) then how is this safe against concurent
hole punch? i.e. doesn't it have exactly the same problems as
readahead in vfs_fadvise(WILL_NEED)?

>  				/* drain pagevecs to help isolate_lru_page() */
>  				lru_add_drain();
>  				page = find_lock_page(mapping, index);
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..a4fb0670137d 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -501,11 +501,18 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  
>  	ret = security_mmap_file(file, prot, flag);
>  	if (!ret) {
> -		if (down_write_killable(&mm->mmap_sem))
> +		if (file)
> +			inode_aops_down_read(file_inode(file));
> +		if (down_write_killable(&mm->mmap_sem)) {
> +			if (file)
> +				inode_aops_up_read(file_inode(file));
>  			return -EINTR;
> +		}
>  		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
>  				    &populate, &uf);
>  		up_write(&mm->mmap_sem);
> +		if (file)
> +			inode_aops_up_read(file_inode(file));
>  		userfaultfd_unmap_complete(mm, &uf);
>  		if (populate)
>  			mm_populate(ret, populate);

So this path calls the fops->mmap() filesystem method that we check
IS_DAX() in. As Christoph has mentioned, this could likely go away
if we took the XFS_MMAPLOCK_SHARED() inside xfs_file_mmap(), as that
would then serialise new mmaps against the transaction where we are
changing the on disk flag. i.e. all new attempts to mmap() the file
would then get blocked by the filesystem while the change is taking
place...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
