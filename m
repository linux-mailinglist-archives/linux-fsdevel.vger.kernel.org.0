Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09543139C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhBHQkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 11:40:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:51188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234509AbhBHQkO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:40:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AEBBAD6A;
        Mon,  8 Feb 2021 16:39:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 625271E0826; Mon,  8 Feb 2021 17:39:32 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] mm: Protect operations adding pages to page cache with i_mapping_lock
Date:   Mon,  8 Feb 2021 17:39:17 +0100
Message-Id: <20210208163918.7871-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210208163918.7871-1-jack@suse.cz>
References: <20210208163918.7871-1-jack@suse.cz>
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
 fs/inode.c         |  3 +++
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 45 +++++++++++++++++++++++++++++++++++++++++++--
 mm/readahead.c     |  2 ++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6442d97d9a4a..8df49d98e1cd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -174,6 +174,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 
 	init_rwsem(&inode->i_rwsem);
 	lockdep_set_class(&inode->i_rwsem, &sb->s_type->i_mutex_key);
+	init_rwsem(&inode->i_mapping_sem);
+	lockdep_set_class(&inode->i_mapping_sem,
+			  &sb->s_type->i_mapping_sem_key);
 
 	atomic_set(&inode->i_dio_count, 0);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b20ddd8a6e62..248609bc61a2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -658,6 +658,7 @@ struct inode {
 	/* Misc */
 	unsigned long		i_state;
 	struct rw_semaphore	i_rwsem;
+	struct rw_semaphore	i_mapping_sem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 	unsigned long		dirtied_time_when;
@@ -2249,6 +2250,7 @@ struct file_system_type {
 
 	struct lock_class_key i_lock_key;
 	struct lock_class_key i_mutex_key;
+	struct lock_class_key i_mapping_sem_key;
 	struct lock_class_key i_mutex_dir_key;
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 16a3bf693d4a..02f778ff02e0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2257,16 +2257,28 @@ static int filemap_update_page(struct kiocb *iocb,
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
@@ -2283,12 +2295,14 @@ static int filemap_update_page(struct kiocb *iocb,
 	error = filemap_read_page(iocb->ki_filp, mapping, page);
 	if (error == AOP_TRUNCATED_PAGE)
 		put_page(page);
+	up_read(&mapping->host->i_mapping_sem);
 	return error;
 truncated:
 	error = AOP_TRUNCATED_PAGE;
 	put_page(page);
 unlock:
 	unlock_page(page);
+	up_read(&mapping->host->i_mapping_sem);
 	return error;
 }
 
@@ -2303,6 +2317,19 @@ static int filemap_create_page(struct file *file,
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
@@ -2314,9 +2341,11 @@ static int filemap_create_page(struct file *file,
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
@@ -2772,6 +2801,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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
@@ -2779,6 +2815,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!page) {
 			if (fpin)
 				goto out_retry;
+			up_read(&inode->i_mapping_sem);
 			return VM_FAULT_OOM;
 		}
 	}
@@ -2819,9 +2856,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(offset >= max_off)) {
 		unlock_page(page);
 		put_page(page);
+		up_read(&inode->i_mapping_sem);
 		return VM_FAULT_SIGBUS;
 	}
 
+	up_read(&inode->i_mapping_sem);
 	vmf->page = page;
 	return ret | VM_FAULT_LOCKED;
 
@@ -2847,6 +2886,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
 
+	up_read(&inode->i_mapping_sem);
 	shrink_readahead_size_eio(ra);
 	return VM_FAULT_SIGBUS;
 
@@ -2858,6 +2898,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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
-- 
2.26.2

