Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CF369864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbhDWRa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 13:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243327AbhDWRa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:30:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2112EB1B3;
        Fri, 23 Apr 2021 17:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 990E01F2B6D; Fri, 23 Apr 2021 19:30:18 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: [PATCH 03/12] ext4: Convert to use mapping->invalidate_lock
Date:   Fri, 23 Apr 2021 19:29:32 +0200
Message-Id: <20210423173018.23133-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210423171010.12-1-jack@suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use mapping->invalidate_lock instead of its private
EXT4_I(inode)->i_mmap_sem. This is mostly search-and-replace. By this
conversion we fix a long standing race between hole punching and read(2)
/ readahead(2) paths that can lead to stale page cache contents.

CC: <linux-ext4@vger.kernel.org>
CC: Ted Tso <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h     | 10 ----------
 fs/ext4/extents.c  | 25 +++++++++++++-----------
 fs/ext4/file.c     | 13 +++++++------
 fs/ext4/inode.c    | 47 +++++++++++++++++-----------------------------
 fs/ext4/ioctl.c    |  4 ++--
 fs/ext4/super.c    | 13 +++++--------
 fs/ext4/truncate.h |  8 +++++---
 7 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 826a56e3bbd2..2ae365458dca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1081,15 +1081,6 @@ struct ext4_inode_info {
 	 * by other means, so we have i_data_sem.
 	 */
 	struct rw_semaphore i_data_sem;
-	/*
-	 * i_mmap_sem is for serializing page faults with truncate / punch hole
-	 * operations. We have to make sure that new page cannot be faulted in
-	 * a section of the inode that is being punched. We cannot easily use
-	 * i_data_sem for this since we need protection for the whole punch
-	 * operation and i_data_sem ranks below transaction start so we have
-	 * to occasionally drop it.
-	 */
-	struct rw_semaphore i_mmap_sem;
 	struct inode vfs_inode;
 	struct jbd2_inode *jinode;
 
@@ -2908,7 +2899,6 @@ extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
-extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
 extern void ext4_da_release_space(struct inode *inode, int to_free);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 77c84d6f1af6..8bb6b84c8a84 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4467,6 +4467,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
 {
 	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
 	unsigned int max_blocks;
 	loff_t new_size = 0;
@@ -4553,17 +4554,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 * Prevent page faults from reinstantiating pages we have
 		 * released from page cache.
 		 */
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&mapping->invalidate_lock);
 
 		ret = ext4_break_layouts(inode);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&mapping->invalidate_lock);
 			goto out_mutex;
 		}
 
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&mapping->invalidate_lock);
 			goto out_mutex;
 		}
 		/* Now release the pages and zero block aligned part of pages */
@@ -4572,7 +4573,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&mapping->invalidate_lock);
 		if (ret)
 			goto out_mutex;
 	}
@@ -5214,6 +5215,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
+	struct address_space *mapping = inode->i_mapping;
 	ext4_lblk_t punch_start, punch_stop;
 	handle_t *handle;
 	unsigned int credits;
@@ -5267,7 +5269,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5282,15 +5284,15 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Write tail of the last page before removed range since it will get
 	 * removed from the page cache below.
 	 */
-	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset, offset);
+	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
 	if (ret)
 		goto out_mmap;
 	/*
 	 * Write data that will be shifted to preserve them when discarding
 	 * page cache below. We are also protected from pages becoming dirty
-	 * by i_mmap_sem.
+	 * by i_rwsem and invalidate_lock.
 	 */
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset + len,
+	ret = filemap_write_and_wait_range(mapping, offset + len,
 					   LLONG_MAX);
 	if (ret)
 		goto out_mmap;
@@ -5343,7 +5345,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5360,6 +5362,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
+	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
@@ -5418,7 +5421,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5519,7 +5522,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..61fa787138d8 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -687,22 +687,23 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	 */
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	pfn_t pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
 		file_update_time(vmf->vma->vm_file);
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		down_read(&mapping->invalidate_lock);
 retry:
 		handle = ext4_journal_start_sb(sb, EXT4_HT_WRITE_PAGE,
 					       EXT4_DATA_TRANS_BLOCKS(sb));
 		if (IS_ERR(handle)) {
-			up_read(&EXT4_I(inode)->i_mmap_sem);
+			up_read(&mapping->invalidate_lock);
 			sb_end_pagefault(sb);
 			return VM_FAULT_SIGBUS;
 		}
 	} else {
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		down_read(&mapping->invalidate_lock);
 	}
 	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
 	if (write) {
@@ -714,10 +715,10 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 		/* Handling synchronous page fault? */
 		if (result & VM_FAULT_NEEDDSYNC)
 			result = dax_finish_sync_fault(vmf, pe_size, pfn);
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		up_read(&mapping->invalidate_lock);
 		sb_end_pagefault(sb);
 	} else {
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		up_read(&mapping->invalidate_lock);
 	}
 
 	return result;
@@ -739,7 +740,7 @@ static const struct vm_operations_struct ext4_dax_vm_ops = {
 #endif
 
 static const struct vm_operations_struct ext4_file_vm_ops = {
-	.fault		= ext4_filemap_fault,
+	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite   = ext4_page_mkwrite,
 };
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..62020bff7096 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3952,20 +3952,19 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct ext4_inode_info *ei)
+static void ext4_wait_dax_page(struct inode *inode)
 {
-	up_write(&ei->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	schedule();
-	down_write(&ei->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 }
 
 int ext4_break_layouts(struct inode *inode)
 {
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct page *page;
 	int error;
 
-	if (WARN_ON_ONCE(!rwsem_is_locked(&ei->i_mmap_sem)))
+	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
 	do {
@@ -3976,7 +3975,7 @@ int ext4_break_layouts(struct inode *inode)
 		error = ___wait_var_event(&page->_refcount,
 				atomic_read(&page->_refcount) == 1,
 				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(ei));
+				ext4_wait_dax_page(inode));
 	} while (error == 0);
 
 	return error;
@@ -4007,9 +4006,9 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	if (ext4_has_inline_data(inode)) {
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&mapping->invalidate_lock);
 		ret = ext4_convert_inline_data(inode);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&mapping->invalidate_lock);
 		if (ret)
 			return ret;
 	}
@@ -4060,7 +4059,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -4133,7 +4132,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 out_stop:
 	ext4_journal_stop(handle);
 out_dio:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5428,11 +5427,11 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			inode_dio_wait(inode);
 		}
 
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping->invalidate_lock);
 
 		rc = ext4_break_layouts(inode);
 		if (rc) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping->invalidate_lock);
 			goto err_out;
 		}
 
@@ -5508,7 +5507,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				error = rc;
 		}
 out_mmap_sem:
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping->invalidate_lock);
 	}
 
 	if (!error) {
@@ -5985,10 +5984,10 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	 * data (and journalled aops don't know how to handle these cases).
 	 */
 	if (val) {
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping->invalidate_lock);
 		err = filemap_write_and_wait(inode->i_mapping);
 		if (err < 0) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping->invalidate_lock);
 			return err;
 		}
 	}
@@ -6021,7 +6020,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping->invalidate_lock);
 
 	/* Finally we can mark the inode as dirty. */
 
@@ -6065,7 +6064,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
-	down_read(&EXT4_I(inode)->i_mmap_sem);
+	down_read(&mapping->invalidate_lock);
 
 	err = ext4_convert_inline_data(inode);
 	if (err)
@@ -6178,7 +6177,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 out_ret:
 	ret = block_page_mkwrite_return(err);
 out:
-	up_read(&EXT4_I(inode)->i_mmap_sem);
+	up_read(&mapping->invalidate_lock);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
@@ -6186,15 +6185,3 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	ext4_journal_stop(handle);
 	goto out;
 }
-
-vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
-{
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	vm_fault_t ret;
-
-	down_read(&EXT4_I(inode)->i_mmap_sem);
-	ret = filemap_fault(vmf);
-	up_read(&EXT4_I(inode)->i_mmap_sem);
-
-	return ret;
-}
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a2cf35066f46..ec4e4350e2b0 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -147,7 +147,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		goto journal_err_out;
 	}
 
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 	err = filemap_write_and_wait(inode->i_mapping);
 	if (err)
 		goto err_out;
@@ -255,7 +255,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	ext4_double_up_write_data_sem(inode, inode_bl);
 
 err_out:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 journal_err_out:
 	unlock_two_nondirectories(inode, inode_bl);
 	iput(inode_bl);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..0525a19fd39d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -90,12 +90,9 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 /*
  * Lock ordering
  *
- * Note the difference between i_mmap_sem (EXT4_I(inode)->i_mmap_sem) and
- * i_mmap_rwsem (inode->i_mmap_rwsem)!
- *
  * page fault path:
- * mmap_lock -> sb_start_pagefault -> i_mmap_sem (r) -> transaction start ->
- *   page lock -> i_data_sem (rw)
+ * mmap_lock -> sb_start_pagefault -> invalidate_lock (r) -> transaction start
+ *   -> page lock -> i_data_sem (rw)
  *
  * buffered write path:
  * sb_start_write -> i_mutex -> mmap_lock
@@ -103,8 +100,9 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
  *   i_data_sem (rw)
  *
  * truncate:
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> i_mmap_rwsem (w) -> page lock
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> transaction start ->
+ * sb_start_write -> i_mutex -> invalidate_lock (w) -> i_mmap_rwsem (w) ->
+ *   page lock
+ * sb_start_write -> i_mutex -> invalidate_lock (w) -> transaction start ->
  *   i_data_sem (rw)
  *
  * direct IO:
@@ -1349,7 +1347,6 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&ei->i_orphan);
 	init_rwsem(&ei->xattr_sem);
 	init_rwsem(&ei->i_data_sem);
-	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
 }
diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
index bcbe3668c1d4..b7242e08c9dd 100644
--- a/fs/ext4/truncate.h
+++ b/fs/ext4/truncate.h
@@ -11,14 +11,16 @@
  */
 static inline void ext4_truncate_failed_write(struct inode *inode)
 {
+	struct address_space *mapping = inode->i_mapping;
+
 	/*
 	 * We don't need to call ext4_break_layouts() because the blocks we
 	 * are truncating were never visible to userspace.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
-	truncate_inode_pages(inode->i_mapping, inode->i_size);
+	down_write(&mapping->invalidate_lock);
+	truncate_inode_pages(mapping, inode->i_size);
 	ext4_truncate(inode);
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 }
 
 /*
-- 
2.26.2

