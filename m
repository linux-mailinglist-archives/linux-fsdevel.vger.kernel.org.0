Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FB35DDBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhDML30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 07:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhDML3V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:29:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18E27B159;
        Tue, 13 Apr 2021 11:29:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD1A21F2B62; Tue, 13 Apr 2021 13:28:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] mm: Protect operations adding pages to page cache with i_mapping_lock
Date:   Tue, 13 Apr 2021 13:28:46 +0200
Message-Id: <20210413112859.32249-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413105205.3093-1-jack@suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
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

So create a new rw_semaphore in the inode - i_mapping_sem - that
protects adding of pages to page cache for page faults / reads /
readahead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/locking.rst | 38 ++++++++++++++------
 fs/inode.c                            |  3 ++
 include/linux/fs.h                    |  2 ++
 mm/filemap.c                          | 51 ++++++++++++++++++++++++---
 mm/readahead.c                        |  2 ++
 mm/rmap.c                             | 37 +++++++++----------
 mm/truncate.c                         |  2 +-
 7 files changed, 101 insertions(+), 34 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index b7dcc86c92a4..67ba0a81301a 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -266,19 +266,19 @@ prototypes::
 locking rules:
 	All except set_page_dirty and freepage may block
 
-======================	======================== =========
-ops			PageLocked(page)	 i_rwsem
-======================	======================== =========
+======================	======================== =========	===============
+ops			PageLocked(page)	 i_rwsem	i_mapping_sem
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
@@ -373,7 +373,10 @@ keep it that way and don't breed new callers.
 ->invalidatepage() is called when the filesystem must attempt to drop
 some or all of the buffers from the page when it is being truncated. It
 returns zero on success. If ->invalidatepage is zero, the kernel uses
-block_invalidatepage() instead.
+block_invalidatepage() instead. The filesystem should exclusively acquire
+i_mapping_sem before invalidating page cache in truncate / hole punch path (and
+thus calling into ->invalidatepage) to block races between page cache
+invalidation and page cache filling functions (fault, read, ...).
 
 ->releasepage() is called when the kernel is about to try to drop the
 buffers from the page in preparation for freeing it.  It returns zero to
@@ -567,6 +570,19 @@ in sys_read() and friends.
 the lease within the individual filesystem to record the result of the
 operation
 
+->fallocate implementation must be really careful to maintain page cache
+consistency when punching holes or performing other operations that invalidate
+page cache contents. Usually the filesystem needs to call
+truncate_inode_pages_range() to invalidate relevant range of the page cache.
+However the filesystem usually also needs to update its internal (and on disk)
+view of file offset -> disk block mapping. Until this update is finished, the
+filesystem needs to block page faults and reads from reloading now-stale page
+cache contents from the disk. VFS provides inode->i_mapping_sem for this and
+acquires it in shared mode in paths loading pages from disk (filemap_fault(),
+filemap_read(), readahead paths). The filesystem is responsible for taking this
+lock in its fallocate implementation and generally whenever the page cache
+contents needs to be invalidated because a block is moving from under a page.
+
 dquot_operations
 ================
 
@@ -628,9 +644,9 @@ access:		yes
 to be faulted in. The filesystem must find and return the page associated
 with the passed in "pgoff" in the vm_fault structure. If it is possible that
 the page may be truncated and/or invalidated, then the filesystem must lock
-the page, then ensure it is not already truncated (the page lock will block
-subsequent truncate), and then return with VM_FAULT_LOCKED, and the page
-locked. The VM will unlock the page.
+i_mapping_sem, then ensure the page is not already truncated (i_mapping_sem
+will block subsequent truncate), and then return with VM_FAULT_LOCKED, and the
+page locked. The VM will unlock the page.
 
 ->map_pages() is called when VM asks to map easy accessible pages.
 Filesystem should find and map pages associated with offsets from "start_pgoff"
diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..e23e707a507d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -175,6 +175,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 
 	init_rwsem(&inode->i_rwsem);
 	lockdep_set_class(&inode->i_rwsem, &sb->s_type->i_mutex_key);
+	init_rwsem(&inode->i_mapping_sem);
+	lockdep_set_class(&inode->i_mapping_sem,
+			  &sb->s_type->i_mapping_sem_key);
 
 	atomic_set(&inode->i_dio_count, 0);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..c020c105d2d9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -660,6 +660,7 @@ struct inode {
 	/* Misc */
 	unsigned long		i_state;
 	struct rw_semaphore	i_rwsem;
+	struct rw_semaphore	i_mapping_sem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 	unsigned long		dirtied_time_when;
@@ -2351,6 +2352,7 @@ struct file_system_type {
 
 	struct lock_class_key i_lock_key;
 	struct lock_class_key i_mutex_key;
+	struct lock_class_key i_mapping_sem_key;
 	struct lock_class_key i_mutex_dir_key;
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index bd7c50e060a9..bc82a7856d3e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -77,7 +77,8 @@
  *        ->i_pages lock
  *
  *  ->i_rwsem
- *    ->i_mmap_rwsem		(truncate->unmap_mapping_range)
+ *    ->i_mapping_sem		(acquired by fs in truncate path)
+ *      ->i_mmap_rwsem		(truncate->unmap_mapping_range)
  *
  *  ->mmap_lock
  *    ->i_mmap_rwsem
@@ -85,7 +86,8 @@
  *        ->i_pages lock	(arch-dependent flush_dcache_mmap_lock)
  *
  *  ->mmap_lock
- *    ->lock_page		(access_process_vm)
+ *    ->i_mapping_sem		(filemap_fault)
+ *      ->lock_page		(filemap_fault, access_process_vm)
  *
  *  ->i_rwsem			(generic_perform_write)
  *    ->mmap_lock		(fault_in_pages_readable->do_page_fault)
@@ -2276,16 +2278,28 @@ static int filemap_update_page(struct kiocb *iocb,
 {
 	int error;
 
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!down_read_trylock(&mapping->host->i_mapping_sem))
+			return -EAGAIN;
+	} else {
+		down_read(&mapping->host->i_mapping_sem);
+	}
+
 	if (!trylock_page(page)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
+		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
+			up_read(&mapping->host->i_mapping_sem);
 			return -EAGAIN;
+		}
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
+			up_read(&mapping->host->i_mapping_sem);
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
 		error = __lock_page_async(page, iocb->ki_waitq);
-		if (error)
+		if (error) {
+			up_read(&mapping->host->i_mapping_sem);
 			return error;
+		}
 	}
 
 	if (!page->mapping)
@@ -2302,6 +2316,7 @@ static int filemap_update_page(struct kiocb *iocb,
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
 	if (error == AOP_TRUNCATED_PAGE)
 		put_page(page);
+	up_read(&mapping->host->i_mapping_sem);
 	return error;
 truncated:
 	unlock_page(page);
@@ -2309,6 +2324,7 @@ static int filemap_update_page(struct kiocb *iocb,
 	return AOP_TRUNCATED_PAGE;
 unlock:
 	unlock_page(page);
+	up_read(&mapping->host->i_mapping_sem);
 	return error;
 }
 
@@ -2323,6 +2339,19 @@ static int filemap_create_page(struct file *file,
 	if (!page)
 		return -ENOMEM;
 
+	/*
+	 * Protect against truncate / hole punch. Grabbing i_mapping_sem here
+	 * assures we cannot instantiate and bring uptodate new pagecache pages
+	 * after evicting page cache during truncate and before actually
+	 * freeing blocks.  Note that we could release i_mapping_sem after
+	 * inserting the page into page cache as the locked page would then be
+	 * enough to synchronize with hole punching. But there are code paths
+	 * such as filemap_update_page() filling in partially uptodate pages or
+	 * ->readpages() that need to hold i_mapping_sem while mapping blocks
+	 * for IO so let's hold the lock here as well to keep locking rules
+	 * simple.
+	 */
+	down_read(&mapping->host->i_mapping_sem);
 	error = add_to_page_cache_lru(page, mapping, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2334,9 +2363,11 @@ static int filemap_create_page(struct file *file,
 	if (error)
 		goto error;
 
+	up_read(&mapping->host->i_mapping_sem);
 	pagevec_add(pvec, page);
 	return 0;
 error:
+	up_read(&mapping->host->i_mapping_sem);
 	put_page(page);
 	return error;
 }
@@ -2896,6 +2927,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 		fpin = do_sync_mmap_readahead(vmf);
+	}
+
+	/*
+	 * See comment in filemap_create_page() why we need i_mapping_sem
+	 */
+	down_read(&inode->i_mapping_sem);
+	if (!page) {
 retry_find:
 		page = pagecache_get_page(mapping, offset,
 					  FGP_CREAT|FGP_FOR_MMAP,
@@ -2903,6 +2941,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!page) {
 			if (fpin)
 				goto out_retry;
+			up_read(&inode->i_mapping_sem);
 			return VM_FAULT_OOM;
 		}
 	}
@@ -2943,9 +2982,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(offset >= max_off)) {
 		unlock_page(page);
 		put_page(page);
+		up_read(&inode->i_mapping_sem);
 		return VM_FAULT_SIGBUS;
 	}
 
+	up_read(&inode->i_mapping_sem);
 	vmf->page = page;
 	return ret | VM_FAULT_LOCKED;
 
@@ -2971,6 +3012,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
 
+	up_read(&inode->i_mapping_sem);
 	shrink_readahead_size_eio(ra);
 	return VM_FAULT_SIGBUS;
 
@@ -2982,6 +3024,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (page)
 		put_page(page);
+	up_read(&inode->i_mapping_sem);
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
diff --git a/mm/readahead.c b/mm/readahead.c
index c5b0457415be..ac5bb50b3a4c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 */
 	unsigned int nofs = memalloc_nofs_save();
 
+	down_read(&mapping->host->i_mapping_sem);
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -236,6 +237,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * will then handle the error.
 	 */
 	read_pages(ractl, &page_pool, false);
+	up_read(&mapping->host->i_mapping_sem);
 	memalloc_nofs_restore(nofs);
 }
 EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
diff --git a/mm/rmap.c b/mm/rmap.c
index dba8cb8a5578..37e5dceb4351 100644
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
+ *     inode->i_mapping_sem (in filemap_fault)
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
index 2cf71d8c3c62..464ad70a081f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -416,7 +416,7 @@ EXPORT_SYMBOL(truncate_inode_pages_range);
  * @mapping: mapping to truncate
  * @lstart: offset from which to truncate
  *
- * Called under (and serialised by) inode->i_rwsem.
+ * Called under (and serialised by) inode->i_rwsem and inode->i_mapping_rwsem.
  *
  * Note: When this function returns, there can be a page in the process of
  * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
-- 
2.31.0.99.g0d91da736d9f.dirty

