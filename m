Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701613C680E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 03:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhGMB2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 21:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhGMB2D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:28:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE691611B0;
        Tue, 13 Jul 2021 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626139514;
        bh=k2TgdwC12ySjmnchjCAtMC8VdD3v7/CJEwuU78hPqJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eg9UEk176ZR8BjHi6PJfnE0wnJ36KKS4lSMN6vO2B4d3eSNCSdsIFzr9I9f3TtxvP
         ZELcxCGV7RmdNfE/Gof+N8gMmNVRXSQGjwmW6UWRt/htNIxPe0P8ityBCA5fyF07KN
         vIiSSekLIyvbfFxHh0LOJi7KmAcvm1scE46t0IGYsQAZ3pJTDwFwTnpYRktsbDZQei
         z1wUPR8sMdh6OkYOsKnlXWvJHpGkpN56IRnIVLRMNtBbm6XX7c5Ce5JFuSPKgZP2Cb
         bVEz0oC7DNpbezZudfl8bbdIIFdzN0f/90ZaoZ4BBKDbMVM1q+y2SmRmQHt4FuEhTA
         GeG+LxNeT0JWg==
Date:   Mon, 12 Jul 2021 18:25:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/14] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210713012514.GB22402@magnolia>
References: <20210712163901.29514-1-jack@suse.cz>
 <20210712165609.13215-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712165609.13215-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 06:55:54PM +0200, Jan Kara wrote:
> Currently, serializing operations such as page fault, read, or readahead
> against hole punching is rather difficult. The basic race scheme is
> like:
> 
> fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
>   truncate_inode_pages_range()
> 						  <create pages in page
> 						   cache here>
>   <update fs block mapping and free blocks>
> 
> Now the problem is in this way read / page fault / readahead can
> instantiate pages in page cache with potentially stale data (if blocks
> get quickly reused). Avoiding this race is not simple - page locks do
> not work because we want to make sure there are *no* pages in given
> range. inode->i_rwsem does not work because page fault happens under
> mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
> the performance for mixed read-write workloads suffer.
> 
> So create a new rw_semaphore in the address_space - invalidate_lock -
> that protects adding of pages to page cache for page faults / reads /
> readahead.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst | 62 +++++++++++++------
>  fs/inode.c                            |  2 +
>  include/linux/fs.h                    | 33 ++++++++++
>  mm/filemap.c                          | 88 +++++++++++++++++++++++----
>  mm/readahead.c                        |  2 +
>  mm/rmap.c                             | 37 +++++------
>  mm/truncate.c                         |  3 +-
>  7 files changed, 176 insertions(+), 51 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index cdf15492c699..38a3097b6f1c 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -271,19 +271,19 @@ prototypes::
>  locking rules:
>  	All except set_page_dirty and freepage may block
>  
> -======================	======================== =========
> -ops			PageLocked(page)	 i_rwsem
> -======================	======================== =========
> +======================	======================== =========	===============
> +ops			PageLocked(page)	 i_rwsem	invalidate_lock
> +======================	======================== =========	===============
>  writepage:		yes, unlocks (see below)
> -readpage:		yes, unlocks
> +readpage:		yes, unlocks				shared
>  writepages:
>  set_page_dirty		no
> -readahead:		yes, unlocks
> -readpages:		no
> +readahead:		yes, unlocks				shared
> +readpages:		no					shared
>  write_begin:		locks the page		 exclusive
>  write_end:		yes, unlocks		 exclusive
>  bmap:
> -invalidatepage:		yes
> +invalidatepage:		yes					exclusive
>  releasepage:		yes
>  freepage:		yes
>  direct_IO:
> @@ -378,7 +378,10 @@ keep it that way and don't breed new callers.
>  ->invalidatepage() is called when the filesystem must attempt to drop
>  some or all of the buffers from the page when it is being truncated. It
>  returns zero on success. If ->invalidatepage is zero, the kernel uses
> -block_invalidatepage() instead.
> +block_invalidatepage() instead. The filesystem must exclusively acquire
> +invalidate_lock before invalidating page cache in truncate / hole punch path
> +(and thus calling into ->invalidatepage) to block races between page cache
> +invalidation and page cache filling functions (fault, read, ...).
>  
>  ->releasepage() is called when the kernel is about to try to drop the
>  buffers from the page in preparation for freeing it.  It returns zero to
> @@ -573,6 +576,25 @@ in sys_read() and friends.
>  the lease within the individual filesystem to record the result of the
>  operation
>  
> +->fallocate implementation must be really careful to maintain page cache
> +consistency when punching holes or performing other operations that invalidate
> +page cache contents. Usually the filesystem needs to call
> +truncate_inode_pages_range() to invalidate relevant range of the page cache.
> +However the filesystem usually also needs to update its internal (and on disk)
> +view of file offset -> disk block mapping. Until this update is finished, the
> +filesystem needs to block page faults and reads from reloading now-stale page
> +cache contents from the disk. Since VFS acquires mapping->invalidate_lock in
> +shared mode when loading pages from disk (filemap_fault(), filemap_read(),
> +readahead paths), the fallocate implementation must take the invalidate_lock to
> +prevent reloading.
> +
> +->copy_file_range and ->remap_file_range implementations need to serialize
> +against modifications of file data while the operation is running. For
> +blocking changes through write(2) and similar operations inode->i_rwsem can be
> +used. To block changes to file contents via a memory mapping during the
> +operation, the filesystem must take mapping->invalidate_lock to coordinate
> +with ->page_mkwrite.
> +
>  dquot_operations
>  ================
>  
> @@ -630,11 +652,11 @@ pfn_mkwrite:	yes
>  access:		yes
>  =============	=========	===========================
>  
> -->fault() is called when a previously not present pte is about
> -to be faulted in. The filesystem must find and return the page associated
> -with the passed in "pgoff" in the vm_fault structure. If it is possible that
> -the page may be truncated and/or invalidated, then the filesystem must lock
> -the page, then ensure it is not already truncated (the page lock will block
> +->fault() is called when a previously not present pte is about to be faulted
> +in. The filesystem must find and return the page associated with the passed in
> +"pgoff" in the vm_fault structure. If it is possible that the page may be
> +truncated and/or invalidated, then the filesystem must lock invalidate_lock,
> +then ensure the page is not already truncated (invalidate_lock will block
>  subsequent truncate), and then return with VM_FAULT_LOCKED, and the page
>  locked. The VM will unlock the page.
>  
> @@ -647,12 +669,14 @@ page table entry. Pointer to entry associated with the page is passed in
>  "pte" field in vm_fault structure. Pointers to entries for other offsets
>  should be calculated relative to "pte".
>  
> -->page_mkwrite() is called when a previously read-only pte is
> -about to become writeable. The filesystem again must ensure that there are
> -no truncate/invalidate races, and then return with the page locked. If
> -the page has been truncated, the filesystem should not look up a new page
> -like the ->fault() handler, but simply return with VM_FAULT_NOPAGE, which
> -will cause the VM to retry the fault.
> +->page_mkwrite() is called when a previously read-only pte is about to become
> +writeable. The filesystem again must ensure that there are no
> +truncate/invalidate races or races with operations such as ->remap_file_range
> +or ->copy_file_range, and then return with the page locked. Usually
> +mapping->invalidate_lock is suitable for proper serialization. If the page has
> +been truncated, the filesystem should not look up a new page like the ->fault()
> +handler, but simply return with VM_FAULT_NOPAGE, which will cause the VM to
> +retry the fault.
>  
>  ->pfn_mkwrite() is the same as page_mkwrite but when the pte is
>  VM_PFNMAP or VM_MIXEDMAP with a page-less entry. Expected return is
> diff --git a/fs/inode.c b/fs/inode.c
> index c93500d84264..84c528cd1955 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -190,6 +190,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> +	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
> +		     &sb->s_type->invalidate_lock_key);
>  	inode->i_private = NULL;
>  	inode->i_mapping = mapping;
>  	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..90a80de37ad4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -436,6 +436,10 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
>   * struct address_space - Contents of a cacheable, mappable object.
>   * @host: Owner, either the inode or the block_device.
>   * @i_pages: Cached pages.
> + * @invalidate_lock: Guards coherency between page cache contents and
> + *   file offset->disk block mappings in the filesystem during invalidates.
> + *   It is also used to block modification of page cache contents through
> + *   memory mappings.
>   * @gfp_mask: Memory allocation flags to use for allocating pages.
>   * @i_mmap_writable: Number of VM_SHARED mappings.
>   * @nr_thps: Number of THPs in the pagecache (non-shmem only).
> @@ -453,6 +457,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
>  struct address_space {
>  	struct inode		*host;
>  	struct xarray		i_pages;
> +	struct rw_semaphore	invalidate_lock;
>  	gfp_t			gfp_mask;
>  	atomic_t		i_mmap_writable;
>  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
> @@ -814,6 +819,33 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
>  	down_read_nested(&inode->i_rwsem, subclass);
>  }
>  
> +static inline void filemap_invalidate_lock(struct address_space *mapping)
> +{
> +	down_write(&mapping->invalidate_lock);
> +}
> +
> +static inline void filemap_invalidate_unlock(struct address_space *mapping)
> +{
> +	up_write(&mapping->invalidate_lock);
> +}
> +
> +static inline void filemap_invalidate_lock_shared(struct address_space *mapping)
> +{
> +	down_read(&mapping->invalidate_lock);
> +}
> +
> +static inline int filemap_invalidate_trylock_shared(
> +					struct address_space *mapping)
> +{
> +	return down_read_trylock(&mapping->invalidate_lock);
> +}
> +
> +static inline void filemap_invalidate_unlock_shared(
> +					struct address_space *mapping)
> +{
> +	up_read(&mapping->invalidate_lock);
> +}
> +
>  void lock_two_nondirectories(struct inode *, struct inode*);
>  void unlock_two_nondirectories(struct inode *, struct inode*);
>  
> @@ -2487,6 +2519,7 @@ struct file_system_type {
>  
>  	struct lock_class_key i_lock_key;
>  	struct lock_class_key i_mutex_key;
> +	struct lock_class_key invalidate_lock_key;
>  	struct lock_class_key i_mutex_dir_key;
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index acf20eca2fa4..56988c4e655d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -77,7 +77,8 @@
>   *        ->i_pages lock
>   *
>   *  ->i_rwsem
> - *    ->i_mmap_rwsem		(truncate->unmap_mapping_range)
> + *    ->invalidate_lock		(acquired by fs in truncate path)
> + *      ->i_mmap_rwsem		(truncate->unmap_mapping_range)
>   *
>   *  ->mmap_lock
>   *    ->i_mmap_rwsem
> @@ -85,7 +86,8 @@
>   *        ->i_pages lock	(arch-dependent flush_dcache_mmap_lock)
>   *
>   *  ->mmap_lock
> - *    ->lock_page		(access_process_vm)
> + *    ->invalidate_lock		(filemap_fault)
> + *      ->lock_page		(filemap_fault, access_process_vm)
>   *
>   *  ->i_rwsem			(generic_perform_write)
>   *    ->mmap_lock		(fault_in_pages_readable->do_page_fault)
> @@ -2368,20 +2370,30 @@ static int filemap_update_page(struct kiocb *iocb,
>  {
>  	int error;
>  
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!filemap_invalidate_trylock_shared(mapping))
> +			return -EAGAIN;
> +	} else {
> +		filemap_invalidate_lock_shared(mapping);
> +	}
> +
>  	if (!trylock_page(page)) {
> +		error = -EAGAIN;
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
> -			return -EAGAIN;
> +			goto unlock_mapping;
>  		if (!(iocb->ki_flags & IOCB_WAITQ)) {
> +			filemap_invalidate_unlock_shared(mapping);
>  			put_and_wait_on_page_locked(page, TASK_KILLABLE);
>  			return AOP_TRUNCATED_PAGE;
>  		}
>  		error = __lock_page_async(page, iocb->ki_waitq);
>  		if (error)
> -			return error;
> +			goto unlock_mapping;
>  	}
>  
> +	error = AOP_TRUNCATED_PAGE;
>  	if (!page->mapping)
> -		goto truncated;
> +		goto unlock;
>  
>  	error = 0;
>  	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, page))
> @@ -2392,15 +2404,13 @@ static int filemap_update_page(struct kiocb *iocb,
>  		goto unlock;
>  
>  	error = filemap_read_page(iocb->ki_filp, mapping, page);
> -	if (error == AOP_TRUNCATED_PAGE)
> -		put_page(page);
> -	return error;
> -truncated:
> -	unlock_page(page);
> -	put_page(page);
> -	return AOP_TRUNCATED_PAGE;
> +	goto unlock_mapping;
>  unlock:
>  	unlock_page(page);
> +unlock_mapping:
> +	filemap_invalidate_unlock_shared(mapping);
> +	if (error == AOP_TRUNCATED_PAGE)
> +		put_page(page);
>  	return error;
>  }
>  
> @@ -2415,6 +2425,19 @@ static int filemap_create_page(struct file *file,
>  	if (!page)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Protect against truncate / hole punch. Grabbing invalidate_lock here
> +	 * assures we cannot instantiate and bring uptodate new pagecache pages
> +	 * after evicting page cache during truncate and before actually
> +	 * freeing blocks.  Note that we could release invalidate_lock after
> +	 * inserting the page into page cache as the locked page would then be
> +	 * enough to synchronize with hole punching. But there are code paths
> +	 * such as filemap_update_page() filling in partially uptodate pages or
> +	 * ->readpages() that need to hold invalidate_lock while mapping blocks
> +	 * for IO so let's hold the lock here as well to keep locking rules
> +	 * simple.
> +	 */
> +	filemap_invalidate_lock_shared(mapping);
>  	error = add_to_page_cache_lru(page, mapping, index,
>  			mapping_gfp_constraint(mapping, GFP_KERNEL));
>  	if (error == -EEXIST)
> @@ -2426,9 +2449,11 @@ static int filemap_create_page(struct file *file,
>  	if (error)
>  		goto error;
>  
> +	filemap_invalidate_unlock_shared(mapping);
>  	pagevec_add(pvec, page);
>  	return 0;
>  error:
> +	filemap_invalidate_unlock_shared(mapping);
>  	put_page(page);
>  	return error;
>  }
> @@ -2967,6 +2992,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	pgoff_t max_off;
>  	struct page *page;
>  	vm_fault_t ret = 0;
> +	bool mapping_locked = false;
>  
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>  	if (unlikely(offset >= max_off))
> @@ -2988,15 +3014,30 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>  		ret = VM_FAULT_MAJOR;
>  		fpin = do_sync_mmap_readahead(vmf);
> +	}
> +
> +	if (!page) {

Is it still necessary to re-evaluate !page here?

>  retry_find:
> +		/*
> +		 * See comment in filemap_create_page() why we need
> +		 * invalidate_lock
> +		 */
> +		if (!mapping_locked) {
> +			filemap_invalidate_lock_shared(mapping);
> +			mapping_locked = true;
> +		}
>  		page = pagecache_get_page(mapping, offset,
>  					  FGP_CREAT|FGP_FOR_MMAP,
>  					  vmf->gfp_mask);
>  		if (!page) {
>  			if (fpin)
>  				goto out_retry;
> +			filemap_invalidate_unlock_shared(mapping);
>  			return VM_FAULT_OOM;
>  		}
> +	} else if (unlikely(!PageUptodate(page))) {
> +		filemap_invalidate_lock_shared(mapping);
> +		mapping_locked = true;
>  	}
>  
>  	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
> @@ -3014,8 +3055,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * We have a locked page in the page cache, now we need to check
>  	 * that it's up-to-date. If not, it is going to be due to an error.
>  	 */
> -	if (unlikely(!PageUptodate(page)))
> +	if (unlikely(!PageUptodate(page))) {
> +		/*
> +		 * The page was in cache and uptodate and now it is not.
> +		 * Strange but possible since we didn't hold the page lock all
> +		 * the time. Let's drop everything get the invalidate lock and
> +		 * try again.
> +		 */
> +		if (!mapping_locked) {
> +			unlock_page(page);
> +			put_page(page);
> +			goto retry_find;
> +		}
>  		goto page_not_uptodate;
> +	}
>  
>  	/*
>  	 * We've made it this far and we had to drop our mmap_lock, now is the
> @@ -3026,6 +3079,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		unlock_page(page);
>  		goto out_retry;
>  	}
> +	if (mapping_locked)
> +		filemap_invalidate_unlock_shared(mapping);
>  
>  	/*
>  	 * Found the page and have a reference on it.
> @@ -3056,6 +3111,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  
>  	if (!error || error == AOP_TRUNCATED_PAGE)
>  		goto retry_find;
> +	filemap_invalidate_unlock_shared(mapping);

Hm.  I /think/ it's the case that mapping_locked==true always holds here
because the new "The page was in cache and uptodate and now it is not."
block above will take the invalidate_lock and retry pagecache_get_page,
right?

>  
>  	return VM_FAULT_SIGBUS;
>  
> @@ -3067,6 +3123,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 */
>  	if (page)
>  		put_page(page);
> +	if (mapping_locked)
> +		filemap_invalidate_unlock_shared(mapping);

Hm.  I think this looks ok, even though this patch now contains the
subtlety that we've both hoisted the xfs mmaplock to page cache /and/
reduced the scope of the invalidate_lock.

As for fancy things like remap_range, I think they're still safe with
this latest iteration because those functions grab the invalidate_lock
in exclusive mode and invalidate the mappings before proceeding, which
means that other programs will never find the lockless path (i.e. page
locked, uptodate, and attached to the mapping) and will instead block on
the invalidate lock until the remap operation completes.   Is that
right?

--D
>  	if (fpin)
>  		fput(fpin);
>  	return ret | VM_FAULT_RETRY;
> @@ -3437,6 +3495,8 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>   *
>   * If the page does not get brought uptodate, return -EIO.
>   *
> + * The function expects mapping->invalidate_lock to be already held.
> + *
>   * Return: up to date page on success, ERR_PTR() on failure.
>   */
>  struct page *read_cache_page(struct address_space *mapping,
> @@ -3460,6 +3520,8 @@ EXPORT_SYMBOL(read_cache_page);
>   *
>   * If the page does not get brought uptodate, return -EIO.
>   *
> + * The function expects mapping->invalidate_lock to be already held.
> + *
>   * Return: up to date page on success, ERR_PTR() on failure.
>   */
>  struct page *read_cache_page_gfp(struct address_space *mapping,
> diff --git a/mm/readahead.c b/mm/readahead.c
> index d589f147f4c2..41b75d76d36e 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
> @@ -236,6 +237,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 * will then handle the error.
>  	 */
>  	read_pages(ractl, &page_pool, false);
> +	filemap_invalidate_unlock_shared(mapping);
>  	memalloc_nofs_restore(nofs);
>  }
>  EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a8b01929ab2e..86471aacc54a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -22,24 +22,25 @@
>   *
>   * inode->i_rwsem	(while writing or truncating, not reading or faulting)
>   *   mm->mmap_lock
> - *     page->flags PG_locked (lock_page)   * (see hugetlbfs below)
> - *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
> - *         mapping->i_mmap_rwsem
> - *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> - *           anon_vma->rwsem
> - *             mm->page_table_lock or pte_lock
> - *               swap_lock (in swap_duplicate, swap_info_get)
> - *                 mmlist_lock (in mmput, drain_mmlist and others)
> - *                 mapping->private_lock (in __set_page_dirty_buffers)
> - *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
> - *                     i_pages lock (widely used)
> - *                       lruvec->lru_lock (in lock_page_lruvec_irq)
> - *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> - *                 bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> - *                   sb_lock (within inode_lock in fs/fs-writeback.c)
> - *                   i_pages lock (widely used, in set_page_dirty,
> - *                             in arch-dependent flush_dcache_mmap_lock,
> - *                             within bdi.wb->list_lock in __sync_single_inode)
> + *     mapping->invalidate_lock (in filemap_fault)
> + *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
> + *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
> + *           mapping->i_mmap_rwsem
> + *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> + *             anon_vma->rwsem
> + *               mm->page_table_lock or pte_lock
> + *                 swap_lock (in swap_duplicate, swap_info_get)
> + *                   mmlist_lock (in mmput, drain_mmlist and others)
> + *                   mapping->private_lock (in __set_page_dirty_buffers)
> + *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
> + *                       i_pages lock (widely used)
> + *                         lruvec->lru_lock (in lock_page_lruvec_irq)
> + *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> + *                   bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> + *                     sb_lock (within inode_lock in fs/fs-writeback.c)
> + *                     i_pages lock (widely used, in set_page_dirty,
> + *                               in arch-dependent flush_dcache_mmap_lock,
> + *                               within bdi.wb->list_lock in __sync_single_inode)
>   *
>   * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
>   *   ->tasklist_lock
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 0f9becee9789..44ad5e515140 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -412,7 +412,8 @@ EXPORT_SYMBOL(truncate_inode_pages_range);
>   * @mapping: mapping to truncate
>   * @lstart: offset from which to truncate
>   *
> - * Called under (and serialised by) inode->i_rwsem.
> + * Called under (and serialised by) inode->i_rwsem and
> + * mapping->invalidate_lock.
>   *
>   * Note: When this function returns, there can be a page in the process of
>   * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
> -- 
> 2.26.2
> 
