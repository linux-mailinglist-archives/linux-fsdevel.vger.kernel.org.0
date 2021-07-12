Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577173C611F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhGLQ7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54452 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbhGLQ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3ADFC1FFD6;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8E7vrR6zXynjBoTnu3ufP18Y1ZTA91z7pnOPjTirPU=;
        b=Ste7XaPASzUzTrgARnSBmsnMY2nQYqNOreGM6fyAN4WiyShpa/RYCvrqsETfzpN52AoMwX
        sfbBtuMKG40DWvwPpXgKQWSwRXV398XiwBpJi5OTz+FCXyRTcm94Pywc30uXvUboUtmRw7
        lficaLIWvGIlozFCGKh1ytHN+LnEszI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8E7vrR6zXynjBoTnu3ufP18Y1ZTA91z7pnOPjTirPU=;
        b=8+77fgbk0OpWV8JHJ/mKNl/0ec0c4MIUZInM5EKCKuUP4RvS0SxEj28Yww3cMiUd7pEK9p
        oZpxzgJGfKP5k5Cg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 1A31CA3B8E;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C6D1E1F2CD3; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/14] ext4: Convert to use mapping->invalidate_lock
Date:   Mon, 12 Jul 2021 18:55:56 +0200
Message-Id: <20210712165609.13215-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15717; h=from:subject; bh=sYOfCWiGrKcoQmmtM8j64sZ34yEp/HtbWWrFQ3NzNj0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQdUGuXB8X458eQdPv38vOhbRxZGeYnqIiO1Rz7 /G1w6naJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0HQAKCRCcnaoHP2RA2TxtB/ 0e8Ow2YaO7FQLU57iwDKQB8h6XrYcnzHkk4LCzxfZ3ugFTSIwncycqokumH8Pxx6XDNVJCox/4awcp hSKrWsOVXsO0fQGD/k4d2bGsnIf86twwmLw+7roHzKy55DNpaU4S1RI7OTUCh8plJ8UEXdvpoToMKQ 4ecagbRPNy3syw5LHoIK3qBXqLYEU84ufrbkw8tbsNiwTvGl/zdpjJUmt5iYRp5VlasxzkhYnM+IvY mj6sWq3sgMoZFoOHHnjM/ZSd4GJvgN8907BZmSa93AQmRGhjabJothTTKP3USNJn6mmhye/PMP7DTr f9OZKPC7iZORDq0QbXESLf2Ob0jUA/
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index 3c51e243450d..7ebaf66b6e31 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1086,15 +1086,6 @@ struct ext4_inode_info {
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
 
@@ -2972,7 +2963,6 @@ extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
-extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
 extern void ext4_da_release_space(struct inode *inode, int to_free);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92ad64b89d9b..c33e0a2cb6c3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4474,6 +4474,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
 {
 	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
 	unsigned int max_blocks;
 	loff_t new_size = 0;
@@ -4560,17 +4561,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 * Prevent page faults from reinstantiating pages we have
 		 * released from page cache.
 		 */
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(mapping);
 
 		ret = ext4_break_layouts(inode);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			goto out_mutex;
 		}
 
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
 		if (ret) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			goto out_mutex;
 		}
 		/* Now release the pages and zero block aligned part of pages */
@@ -4579,7 +4580,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(mapping);
 		if (ret)
 			goto out_mutex;
 	}
@@ -5221,6 +5222,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
+	struct address_space *mapping = inode->i_mapping;
 	ext4_lblk_t punch_start, punch_stop;
 	handle_t *handle;
 	unsigned int credits;
@@ -5274,7 +5276,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5289,15 +5291,15 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
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
@@ -5350,7 +5352,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5367,6 +5369,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
+	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
@@ -5425,7 +5428,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -5526,7 +5529,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 	ext4_fc_stop_ineligible(sb);
 out_mmap:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 816dedcbd541..d3b4ed91aa68 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -704,22 +704,23 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	 */
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	pfn_t pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
 		file_update_time(vmf->vma->vm_file);
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock_shared(mapping);
 retry:
 		handle = ext4_journal_start_sb(sb, EXT4_HT_WRITE_PAGE,
 					       EXT4_DATA_TRANS_BLOCKS(sb));
 		if (IS_ERR(handle)) {
-			up_read(&EXT4_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock_shared(mapping);
 			sb_end_pagefault(sb);
 			return VM_FAULT_SIGBUS;
 		}
 	} else {
-		down_read(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock_shared(mapping);
 	}
 	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
 	if (write) {
@@ -731,10 +732,10 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 		/* Handling synchronous page fault? */
 		if (result & VM_FAULT_NEEDDSYNC)
 			result = dax_finish_sync_fault(vmf, pe_size, pfn);
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock_shared(mapping);
 		sb_end_pagefault(sb);
 	} else {
-		up_read(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock_shared(mapping);
 	}
 
 	return result;
@@ -756,7 +757,7 @@ static const struct vm_operations_struct ext4_dax_vm_ops = {
 #endif
 
 static const struct vm_operations_struct ext4_file_vm_ops = {
-	.fault		= ext4_filemap_fault,
+	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite   = ext4_page_mkwrite,
 };
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..325c038e7b23 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3950,20 +3950,19 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct ext4_inode_info *ei)
+static void ext4_wait_dax_page(struct inode *inode)
 {
-	up_write(&ei->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 	schedule();
-	down_write(&ei->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
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
@@ -3974,7 +3973,7 @@ int ext4_break_layouts(struct inode *inode)
 		error = ___wait_var_event(&page->_refcount,
 				atomic_read(&page->_refcount) == 1,
 				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(ei));
+				ext4_wait_dax_page(inode));
 	} while (error == 0);
 
 	return error;
@@ -4005,9 +4004,9 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	if (ext4_has_inline_data(inode)) {
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(mapping);
 		ret = ext4_convert_inline_data(inode);
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(mapping);
 		if (ret)
 			return ret;
 	}
@@ -4058,7 +4057,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	 * Prevent page faults from reinstantiating pages we have released from
 	 * page cache.
 	 */
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
@@ -4131,7 +4130,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 out_stop:
 	ext4_journal_stop(handle);
 out_dio:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5426,11 +5425,11 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			inode_dio_wait(inode);
 		}
 
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(inode->i_mapping);
 
 		rc = ext4_break_layouts(inode);
 		if (rc) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(inode->i_mapping);
 			goto err_out;
 		}
 
@@ -5506,7 +5505,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				error = rc;
 		}
 out_mmap_sem:
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(inode->i_mapping);
 	}
 
 	if (!error) {
@@ -5983,10 +5982,10 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	 * data (and journalled aops don't know how to handle these cases).
 	 */
 	if (val) {
-		down_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(inode->i_mapping);
 		err = filemap_write_and_wait(inode->i_mapping);
 		if (err < 0) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(inode->i_mapping);
 			return err;
 		}
 	}
@@ -6019,7 +6018,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
-		up_write(&EXT4_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(inode->i_mapping);
 
 	/* Finally we can mark the inode as dirty. */
 
@@ -6063,7 +6062,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
-	down_read(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock_shared(mapping);
 
 	err = ext4_convert_inline_data(inode);
 	if (err)
@@ -6176,7 +6175,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 out_ret:
 	ret = block_page_mkwrite_return(err);
 out:
-	up_read(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
@@ -6184,15 +6183,3 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
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
index 6eed6170aded..4fb5fe083c2b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -148,7 +148,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		goto journal_err_out;
 	}
 
-	down_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 	err = filemap_write_and_wait(inode->i_mapping);
 	if (err)
 		goto err_out;
@@ -256,7 +256,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	ext4_double_up_write_data_sem(inode, inode_bl);
 
 err_out:
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 journal_err_out:
 	unlock_two_nondirectories(inode, inode_bl);
 	iput(inode_bl);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..d6df62fc810c 100644
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
@@ -1360,7 +1358,6 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&ei->i_orphan);
 	init_rwsem(&ei->xattr_sem);
 	init_rwsem(&ei->i_data_sem);
-	init_rwsem(&ei->i_mmap_sem);
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
 }
diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
index bcbe3668c1d4..ce84aa2786c7 100644
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
+	filemap_invalidate_lock(mapping);
+	truncate_inode_pages(mapping, inode->i_size);
 	ext4_truncate(inode);
-	up_write(&EXT4_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 }
 
 /*
-- 
2.26.2

