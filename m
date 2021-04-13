Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6200035DDAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhDML3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 07:29:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhDML3V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:29:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1688EB158;
        Tue, 13 Apr 2021 11:29:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D24E61F2B67; Tue, 13 Apr 2021 13:28:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] ext4: Convert to use inode->i_mapping_sem
Date:   Tue, 13 Apr 2021 13:28:47 +0200
Message-Id: <20210413112859.32249-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413105205.3093-1-jack@suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use inode->i_mapping_sem instead of its private
EXT4_I(inode)->i_mmap_sem. This is mostly search-and-replace. By this
conversion we fix a long standing race between hole punching and read(2)
/ readahead(2) paths that can lead to stale page cache contents.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h     | 10 ----------
 fs/ext4/extents.c  | 18 +++++++++---------
 fs/ext4/file.c     | 12 ++++++------
 fs/ext4/inode.c    | 47 +++++++++++++++++-----------------------------
 fs/ext4/ioctl.c    |  4 ++--
 fs/ext4/super.c    | 11 ++++-------
 fs/ext4/truncate.h |  4 ++--
 7 files changed, 40 insertions(+), 66 deletions(-)

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
index 77c84d6f1af6..a315fe6a0929 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4553,17 +4553,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 * Prevent page faults from reinstantiating pages we have
 		 * released from page cache.
 		 */
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping_sem);
 
 		ret = ext4_break_layouts(inode);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping_sem);
 			goto out_mutex;
 		}
 
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping_sem);
 			goto out_mutex;
 		}
 		/* Now release the pages and zero block aligned part of pages */
@@ -4572,7 +4572,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping_sem);
 		if (ret)
 			goto out_mutex;
 	}
@@ -5267,7 +5267,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5288,7 +5288,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	/*
 	 * Write data that will be shifted to preserve them when discarding
 	 * page cache below. We are also protected from pages becoming dirty
-	 * by i_mmap_sem.
+	 * by i_mapping_sem.
 	 */
 	ret = filemap_write_and_wait_range(inode->i_mapping, offset + len,
 					   LLONG_MAX);
@@ -5343,7 +5343,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5418,7 +5418,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5519,7 +5519,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..93fab87f0fff 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -692,17 +692,17 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	if (write) {
 		sb_start_pagefault(sb);
 		file_update_time(vmf->vma->vm_file);
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		down_read(&inode->i_mapping_sem);
 retry:
 		handle = ext4_journal_start_sb(sb, EXT4_HT_WRITE_PAGE,
 					       EXT4_DATA_TRANS_BLOCKS(sb));
 		if (IS_ERR(handle)) {
-			up_read(&EXT4_I(inode)->i_mmap_sem);
+			up_read(&inode->i_mapping_sem);
 			sb_end_pagefault(sb);
 			return VM_FAULT_SIGBUS;
 		}
 	} else {
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		down_read(&inode->i_mapping_sem);
 	}
 	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
 	if (write) {
@@ -714,10 +714,10 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 		/* Handling synchronous page fault? */
 		if (result & VM_FAULT_NEEDDSYNC)
 			result = dax_finish_sync_fault(vmf, pe_size, pfn);
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		up_read(&inode->i_mapping_sem);
 		sb_end_pagefault(sb);
 	} else {
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		up_read(&inode->i_mapping_sem);
 	}
 
 	return result;
@@ -739,7 +739,7 @@ static const struct vm_operations_struct ext4_dax_vm_ops = {
 #endif
 
 static const struct vm_operations_struct ext4_file_vm_ops = {
-	.fault		= ext4_filemap_fault,
+	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite   = ext4_page_mkwrite,
 };
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..d76803eba884 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3952,20 +3952,19 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct ext4_inode_info *ei)
+static void ext4_wait_dax_page(struct inode *inode)
 {
-	up_write(&ei->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 	schedule();
-	down_write(&ei->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 }
 
 int ext4_break_layouts(struct inode *inode)
 {
-	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct page *page;
 	int error;
 
-	if (WARN_ON_ONCE(!rwsem_is_locked(&ei->i_mmap_sem)))
+	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping_sem)))
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
+		down_write(&inode->i_mapping_sem);
 		ret = ext4_convert_inline_data(inode);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping_sem);
 		if (ret)
 			return ret;
 	}
@@ -4060,7 +4059,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -4133,7 +4132,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 out_stop:
 	ext4_journal_stop(handle);
 out_dio:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5428,11 +5427,11 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			inode_dio_wait(inode);
 		}
 
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping_sem);
 
 		rc = ext4_break_layouts(inode);
 		if (rc) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping_sem);
 			goto err_out;
 		}
 
@@ -5508,7 +5507,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				error = rc;
 		}
 out_mmap_sem:
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping_sem);
 	}
 
 	if (!error) {
@@ -5985,10 +5984,10 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	 * data (and journalled aops don't know how to handle these cases).
 	 */
 	if (val) {
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping_sem);
 		err = filemap_write_and_wait(inode->i_mapping);
 		if (err < 0) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			up_write(&inode->i_mapping_sem);
 			return err;
 		}
 	}
@@ -6021,7 +6020,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping_sem);
 
 	/* Finally we can mark the inode as dirty. */
 
@@ -6065,7 +6064,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
-	down_read(&EXT4_I(inode)->i_mmap_sem);
+	down_read(&inode->i_mapping_sem);
 
 	err = ext4_convert_inline_data(inode);
 	if (err)
@@ -6178,7 +6177,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 out_ret:
 	ret = block_page_mkwrite_return(err);
 out:
-	up_read(&EXT4_I(inode)->i_mmap_sem);
+	up_read(&inode->i_mapping_sem);
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
index a2cf35066f46..7a9f24596401 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -147,7 +147,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		goto journal_err_out;
 	}
 
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 	err = filemap_write_and_wait(inode->i_mapping);
 	if (err)
 		goto err_out;
@@ -255,7 +255,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	ext4_double_up_write_data_sem(inode, inode_bl);
 
 err_out:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 journal_err_out:
 	unlock_two_nondirectories(inode, inode_bl);
 	iput(inode_bl);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..ec38f3673ad2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -90,11 +90,8 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 /*
  * Lock ordering
  *
- * Note the difference between i_mmap_sem (EXT4_I(inode)->i_mmap_sem) and
- * i_mmap_rwsem (inode->i_mmap_rwsem)!
- *
  * page fault path:
- * mmap_lock -> sb_start_pagefault -> i_mmap_sem (r) -> transaction start ->
+ * mmap_lock -> sb_start_pagefault -> i_mapping_sem (r) -> transaction start ->
  *   page lock -> i_data_sem (rw)
  *
  * buffered write path:
@@ -103,8 +100,9 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
  *   i_data_sem (rw)
  *
  * truncate:
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> i_mmap_rwsem (w) -> page lock
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> transaction start ->
+ * sb_start_write -> i_mutex -> i_mapping_sem (w) -> i_mmap_rwsem (w) ->
+ *   page lock
+ * sb_start_write -> i_mutex -> i_mapping_sem (w) -> transaction start ->
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
index bcbe3668c1d4..4fe34ccc74e0 100644
--- a/fs/ext4/truncate.h
+++ b/fs/ext4/truncate.h
@@ -15,10 +15,10 @@ static inline void ext4_truncate_failed_write(struct inode *inode)
 	 * We don't need to call ext4_break_layouts() because the blocks we
 	 * are truncating were never visible to userspace.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping_sem);
 	truncate_inode_pages(inode->i_mapping, inode->i_size);
 	ext4_truncate(inode);
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping_sem);
 }
 
 /*
-- 
2.31.0.99.g0d91da736d9f.dirty

