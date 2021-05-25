Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752E73902E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhEYNwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 09:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233370AbhEYNwe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 09:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621950662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAtyr1HbqsY8i6dz4CNYfKVV2QI/4xne4YQpWKeuH+4=;
        b=YmpuUMfgprYdJOgnGYaPCHbzN0/crZ/97/iLAcOkXGjR2TBbla/OncdG2VhXfd+Xdt8x+4
        Qmxey1X2LwhRr3dn169B/sxxjoSQcqznxYEZlxLuY5j/tWUSSYHiD8AouSNr5RmofA703m
        0aZYbwdigoGFP6KamxvWUDsYpEKxBCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621950662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAtyr1HbqsY8i6dz4CNYfKVV2QI/4xne4YQpWKeuH+4=;
        b=c2tDIS4wnXqMxhg3dY/+OaGYEOdRfspROVqM4PbzGhsqBILPk0r5c2XCdEymPr0Y2WBKgk
        FzCMQeV5zIICLFDQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7892AEC8;
        Tue, 25 May 2021 13:51:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1C26E1F2CAE; Tue, 25 May 2021 15:51:00 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/13] mm: Protect operations adding pages to page cache with invalidate_lock
Date:   Tue, 25 May 2021 15:50:40 +0200
Message-Id: <20210525135100.11221-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525125652.20457-1-jack@suse.cz>
References: <20210525125652.20457-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, serializing operations such as page fault, read, or readahead
against hole punching is rather difficult. The basic race scheme is
like:

fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
  truncate_inode_pages_range()
						  <create pages in page
						   cache here>
  <update fs block mapping and free blocks>

Now the problem is in this way read / page fault / readahead can
instantiate pages in page cache with potentially stale data (if blocks
get quickly reused). Avoiding this race is not simple - page locks do
not work because we want to make sure there are *no* pages in given
range. inode->i_rwsem does not work because page fault happens under
mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
the performance for mixed read-write workloads suffer.

So create a new rw_semaphore in the address_space - invalidate_lock -
that protects adding of pages to page cache for page faults / reads /
readahead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/locking.rst | 64 ++++++++++++++++++--------
 fs/inode.c                            |  2 +
 include/linux/fs.h                    |  6 +++
 mm/filemap.c                          | 65 ++++++++++++++++++++++-----
 mm/readahead.c                        |  2 +
 mm/rmap.c                             | 37 +++++++--------
 mm/truncate.c                         |  3 +-
 7 files changed, 129 insertions(+), 50 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 4ed2b22bd0a8..af425bef55d3 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -271,19 +271,19 @@ prototypes::
 locking rules:
 	All except set_page_dirty and freepage may block
 
-======================	======================== =========
-ops			PageLocked(page)	 i_rwsem
-======================	======================== =========
+======================	======================== =========	===============
+ops			PageLocked(page)	 i_rwsem	invalidate_lock
+======================	======================== =========	===============
 writepage:		yes, unlocks (see below)
-readpage:		yes, unlocks
+readpage:		yes, unlocks				shared
 writepages:
 set_page_dirty		no
-readahead:		yes, unlocks
-readpages:		no
+readahead:		yes, unlocks				shared
+readpages:		no					shared
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
-invalidatepage:		yes
+invalidatepage:		yes					exclusive
 releasepage:		yes
 freepage:		yes
 direct_IO:
@@ -378,7 +378,10 @@ keep it that way and don't breed new callers.
 ->invalidatepage() is called when the filesystem must attempt to drop
 some or all of the buffers from the page when it is being truncated. It
 returns zero on success. If ->invalidatepage is zero, the kernel uses
-block_invalidatepage() instead.
+block_invalidatepage() instead. The filesystem should exclusively acquire
+invalidate_lock before invalidating page cache in truncate / hole punch path
+(and thus calling into ->invalidatepage) to block races between page cache
+invalidation and page cache filling functions (fault, read, ...).
 
 ->releasepage() is called when the kernel is about to try to drop the
 buffers from the page in preparation for freeing it.  It returns zero to
@@ -573,6 +576,27 @@ in sys_read() and friends.
 the lease within the individual filesystem to record the result of the
 operation
 
+->fallocate implementation must be really careful to maintain page cache
+consistency when punching holes or performing other operations that invalidate
+page cache contents. Usually the filesystem needs to call
+truncate_inode_pages_range() to invalidate relevant range of the page cache.
+However the filesystem usually also needs to update its internal (and on disk)
+view of file offset -> disk block mapping. Until this update is finished, the
+filesystem needs to block page faults and reads from reloading now-stale page
+cache contents from the disk. VFS provides mapping->invalidate_lock for this
+and acquires it in shared mode in paths loading pages from disk
+(filemap_fault(), filemap_read(), readahead paths). The filesystem is
+responsible for taking this lock in its fallocate implementation and generally
+whenever the page cache contents needs to be invalidated because a block is
+moving from under a page.
+
+->copy_file_range and ->remap_file_range implementations need to serialize
+against modifications of file data while the operation is running. For
+blocking changes through write(2) and similar operations inode->i_rwsem can be
+used. For blocking changes through memory mapping, the filesystem can use
+mapping->invalidate_lock provided it also acquires it in its ->page_mkwrite
+implementation.
+
 dquot_operations
 ================
 
@@ -630,11 +654,11 @@ pfn_mkwrite:	yes
 access:		yes
 =============	=========	===========================
 
-->fault() is called when a previously not present pte is about
-to be faulted in. The filesystem must find and return the page associated
-with the passed in "pgoff" in the vm_fault structure. If it is possible that
-the page may be truncated and/or invalidated, then the filesystem must lock
-the page, then ensure it is not already truncated (the page lock will block
+->fault() is called when a previously not present pte is about to be faulted
+in. The filesystem must find and return the page associated with the passed in
+"pgoff" in the vm_fault structure. If it is possible that the page may be
+truncated and/or invalidated, then the filesystem must lock invalidate_lock,
+then ensure the page is not already truncated (invalidate_lock will block
 subsequent truncate), and then return with VM_FAULT_LOCKED, and the page
 locked. The VM will unlock the page.
 
@@ -647,12 +671,14 @@ page table entry. Pointer to entry associated with the page is passed in
 "pte" field in vm_fault structure. Pointers to entries for other offsets
 should be calculated relative to "pte".
 
-->page_mkwrite() is called when a previously read-only pte is
-about to become writeable. The filesystem again must ensure that there are
-no truncate/invalidate races, and then return with the page locked. If
-the page has been truncated, the filesystem should not look up a new page
-like the ->fault() handler, but simply return with VM_FAULT_NOPAGE, which
-will cause the VM to retry the fault.
+->page_mkwrite() is called when a previously read-only pte is about to become
+writeable. The filesystem again must ensure that there are no
+truncate/invalidate races or races with operations such as ->remap_file_range
+or ->copy_file_range, and then return with the page locked. Usually
+mapping->invalidate_lock is suitable for proper serialization. If the page has
+been truncated, the filesystem should not look up a new page like the ->fault()
+handler, but simply return with VM_FAULT_NOPAGE, which will cause the VM to
+retry the fault.
 
 ->pfn_mkwrite() is the same as page_mkwrite but when the pte is
 VM_PFNMAP or VM_MIXEDMAP with a page-less entry. Expected return is
diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..84c528cd1955 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -190,6 +190,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
 	mapping->private_data = NULL;
 	mapping->writeback_index = 0;
+	__init_rwsem(&mapping->invalidate_lock, "mapping.invalidate_lock",
+		     &sb->s_type->invalidate_lock_key);
 	inode->i_private = NULL;
 	inode->i_mapping = mapping;
 	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..897238d9f1e0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -436,6 +436,10 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * struct address_space - Contents of a cacheable, mappable object.
  * @host: Owner, either the inode or the block_device.
  * @i_pages: Cached pages.
+ * @invalidate_lock: Guards coherency between page cache contents and
+ *   file offset->disk block mappings in the filesystem during invalidates.
+ *   It is also used to block modification of page cache contents through
+ *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
  * @i_mmap_writable: Number of VM_SHARED mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
@@ -453,6 +457,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
 struct address_space {
 	struct inode		*host;
 	struct xarray		i_pages;
+	struct rw_semaphore	invalidate_lock;
 	gfp_t			gfp_mask;
 	atomic_t		i_mmap_writable;
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
@@ -2488,6 +2493,7 @@ struct file_system_type {
 
 	struct lock_class_key i_lock_key;
 	struct lock_class_key i_mutex_key;
+	struct lock_class_key invalidate_lock_key;
 	struct lock_class_key i_mutex_dir_key;
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index ba1068a1837f..4d9ec4c6cc34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -77,7 +77,8 @@
  *        ->i_pages lock
  *
  *  ->i_rwsem
- *    ->i_mmap_rwsem		(truncate->unmap_mapping_range)
+ *    ->invalidate_lock		(acquired by fs in truncate path)
+ *      ->i_mmap_rwsem		(truncate->unmap_mapping_range)
  *
  *  ->mmap_lock
  *    ->i_mmap_rwsem
@@ -85,7 +86,8 @@
  *        ->i_pages lock	(arch-dependent flush_dcache_mmap_lock)
  *
  *  ->mmap_lock
- *    ->lock_page		(access_process_vm)
+ *    ->invalidate_lock		(filemap_fault)
+ *      ->lock_page		(filemap_fault, access_process_vm)
  *
  *  ->i_rwsem			(generic_perform_write)
  *    ->mmap_lock		(fault_in_pages_readable->do_page_fault)
@@ -2368,20 +2370,30 @@ static int filemap_update_page(struct kiocb *iocb,
 {
 	int error;
 
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!down_read_trylock(&mapping->invalidate_lock))
+			return -EAGAIN;
+	} else {
+		down_read(&mapping->invalidate_lock);
+	}
+
 	if (!trylock_page(page)) {
+		error = -EAGAIN;
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
-			return -EAGAIN;
+			goto unlock_mapping;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
+			up_read(&mapping->invalidate_lock);
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
 		error = __lock_page_async(page, iocb->ki_waitq);
 		if (error)
-			return error;
+			goto unlock_mapping;
 	}
 
+	error = AOP_TRUNCATED_PAGE;
 	if (!page->mapping)
-		goto truncated;
+		goto unlock;
 
 	error = 0;
 	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, page))
@@ -2392,15 +2404,13 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
-	if (error == AOP_TRUNCATED_PAGE)
-		put_page(page);
-	return error;
-truncated:
-	unlock_page(page);
-	put_page(page);
-	return AOP_TRUNCATED_PAGE;
+	goto unlock_mapping;
 unlock:
 	unlock_page(page);
+unlock_mapping:
+	up_read(&mapping->invalidate_lock);
+	if (error == AOP_TRUNCATED_PAGE)
+		put_page(page);
 	return error;
 }
 
@@ -2415,6 +2425,19 @@ static int filemap_create_page(struct file *file,
 	if (!page)
 		return -ENOMEM;
 
+	/*
+	 * Protect against truncate / hole punch. Grabbing invalidate_lock here
+	 * assures we cannot instantiate and bring uptodate new pagecache pages
+	 * after evicting page cache during truncate and before actually
+	 * freeing blocks.  Note that we could release invalidate_lock after
+	 * inserting the page into page cache as the locked page would then be
+	 * enough to synchronize with hole punching. But there are code paths
+	 * such as filemap_update_page() filling in partially uptodate pages or
+	 * ->readpages() that need to hold invalidate_lock while mapping blocks
+	 * for IO so let's hold the lock here as well to keep locking rules
+	 * simple.
+	 */
+	down_read(&mapping->invalidate_lock);
 	error = add_to_page_cache_lru(page, mapping, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2426,9 +2449,11 @@ static int filemap_create_page(struct file *file,
 	if (error)
 		goto error;
 
+	up_read(&mapping->invalidate_lock);
 	pagevec_add(pvec, page);
 	return 0;
 error:
+	up_read(&mapping->invalidate_lock);
 	put_page(page);
 	return error;
 }
@@ -2988,6 +3013,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 		fpin = do_sync_mmap_readahead(vmf);
+	}
+
+	/*
+	 * See comment in filemap_create_page() why we need invalidate_lock
+	 */
+	down_read(&mapping->invalidate_lock);
+	if (!page) {
 retry_find:
 		page = pagecache_get_page(mapping, offset,
 					  FGP_CREAT|FGP_FOR_MMAP,
@@ -2995,6 +3027,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!page) {
 			if (fpin)
 				goto out_retry;
+			up_read(&mapping->invalidate_lock);
 			return VM_FAULT_OOM;
 		}
 	}
@@ -3035,9 +3068,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(offset >= max_off)) {
 		unlock_page(page);
 		put_page(page);
+		up_read(&mapping->invalidate_lock);
 		return VM_FAULT_SIGBUS;
 	}
 
+	up_read(&mapping->invalidate_lock);
 	vmf->page = page;
 	return ret | VM_FAULT_LOCKED;
 
@@ -3056,6 +3091,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
+	up_read(&mapping->invalidate_lock);
 
 	return VM_FAULT_SIGBUS;
 
@@ -3067,6 +3103,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (page)
 		put_page(page);
+	up_read(&mapping->invalidate_lock);
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
@@ -3437,6 +3474,8 @@ static struct page *do_read_cache_page(struct address_space *mapping,
  *
  * If the page does not get brought uptodate, return -EIO.
  *
+ * The function expects mapping->invalidate_lock to be already held.
+ *
  * Return: up to date page on success, ERR_PTR() on failure.
  */
 struct page *read_cache_page(struct address_space *mapping,
@@ -3460,6 +3499,8 @@ EXPORT_SYMBOL(read_cache_page);
  *
  * If the page does not get brought uptodate, return -EIO.
  *
+ * The function expects mapping->invalidate_lock to be already held.
+ *
  * Return: up to date page on success, ERR_PTR() on failure.
  */
 struct page *read_cache_page_gfp(struct address_space *mapping,
diff --git a/mm/readahead.c b/mm/readahead.c
index d589f147f4c2..9785c54107bb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	unsigned int nofs = memalloc_nofs_save();
 
+	down_read(&mapping->invalidate_lock);
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -236,6 +237,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * will then handle the error.
 	 */
 	read_pages(ractl, &page_pool, false);
+	up_read(&mapping->invalidate_lock);
 	memalloc_nofs_restore(nofs);
 }
 EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
diff --git a/mm/rmap.c b/mm/rmap.c
index a35cbbbded0d..76d33c3b8ae6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -22,24 +22,25 @@
  *
  * inode->i_rwsem	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
- *     page->flags PG_locked (lock_page)   * (see hugetlbfs below)
- *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
- *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *           anon_vma->rwsem
- *             mm->page_table_lock or pte_lock
- *               swap_lock (in swap_duplicate, swap_info_get)
- *                 mmlist_lock (in mmput, drain_mmlist and others)
- *                 mapping->private_lock (in __set_page_dirty_buffers)
- *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
- *                     i_pages lock (widely used)
- *                       lruvec->lru_lock (in lock_page_lruvec_irq)
- *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
- *                 bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
- *                   sb_lock (within inode_lock in fs/fs-writeback.c)
- *                   i_pages lock (widely used, in set_page_dirty,
- *                             in arch-dependent flush_dcache_mmap_lock,
- *                             within bdi.wb->list_lock in __sync_single_inode)
+ *     mapping->invalidate_lock (in filemap_fault)
+ *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
+ *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
+ *           mapping->i_mmap_rwsem
+ *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
+ *             anon_vma->rwsem
+ *               mm->page_table_lock or pte_lock
+ *                 swap_lock (in swap_duplicate, swap_info_get)
+ *                   mmlist_lock (in mmput, drain_mmlist and others)
+ *                   mapping->private_lock (in __set_page_dirty_buffers)
+ *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                       i_pages lock (widely used)
+ *                         lruvec->lru_lock (in lock_page_lruvec_irq)
+ *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
+ *                   bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
+ *                     sb_lock (within inode_lock in fs/fs-writeback.c)
+ *                     i_pages lock (widely used, in set_page_dirty,
+ *                               in arch-dependent flush_dcache_mmap_lock,
+ *                               within bdi.wb->list_lock in __sync_single_inode)
  *
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
diff --git a/mm/truncate.c b/mm/truncate.c
index 57a618c4a0d6..d0cc6588aba2 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -415,7 +415,8 @@ EXPORT_SYMBOL(truncate_inode_pages_range);
  * @mapping: mapping to truncate
  * @lstart: offset from which to truncate
  *
- * Called under (and serialised by) inode->i_rwsem.
+ * Called under (and serialised by) inode->i_rwsem and
+ * mapping->invalidate_lock.
  *
  * Note: When this function returns, there can be a page in the process of
  * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
-- 
2.26.2

