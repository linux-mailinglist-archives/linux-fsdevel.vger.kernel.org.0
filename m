Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C57369865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbhDWRa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 13:30:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243328AbhDWRa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:30:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 418C0B1BF;
        Fri, 23 Apr 2021 17:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD5451F2B72; Fri, 23 Apr 2021 19:30:18 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 07/12] f2fs: Convert to using invalidate_lock
Date:   Fri, 23 Apr 2021 19:29:36 +0200
Message-Id: <20210423173018.23133-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210423171010.12-1-jack@suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use invalidate_lock instead of f2fs' private i_mmap_sem. The intended
purpose is exactly the same. By this conversion we fix a long standing
race between hole punching and read(2) / readahead(2) paths that can
lead to stale page cache contents.

CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <yuchao0@huawei.com>
CC: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/data.c  |  4 ++--
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/file.c  | 58 ++++++++++++++++++++++++-------------------------
 fs/f2fs/super.c |  1 -
 4 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e5257c763d0..932c773b7b97 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3154,12 +3154,12 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	/* In the fs-verity case, f2fs_end_enable_verity() does the truncate */
 	if (to > i_size && !f2fs_verity_in_progress(inode)) {
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		down_write(&F2FS_I(inode)->i_mmap_sem);
+		down_write(&mapping->invalidate_lock);
 
 		truncate_pagecache(inode, i_size);
 		f2fs_truncate_blocks(inode, i_size, true);
 
-		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&mapping->invalidate_lock);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..f9010c69a57e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -742,7 +742,6 @@ struct f2fs_inode_info {
 
 	/* avoid racing between foreground op and gc */
 	struct rw_semaphore i_gc_rwsem[2];
-	struct rw_semaphore i_mmap_sem;
 	struct rw_semaphore i_xattr_sem; /* avoid racing between reading and changing EAs */
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d26ff2ae3f5e..e58d67a264ac 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -37,10 +37,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	vm_fault_t ret;
 
-	down_read(&F2FS_I(inode)->i_mmap_sem);
 	ret = filemap_fault(vmf);
-	up_read(&F2FS_I(inode)->i_mmap_sem);
-
 	if (!ret)
 		f2fs_update_iostat(F2FS_I_SB(inode), APP_MAPPED_READ_IO,
 							F2FS_BLKSIZE);
@@ -101,7 +98,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
 	file_update_time(vmf->vma->vm_file);
-	down_read(&F2FS_I(inode)->i_mmap_sem);
+	down_read(&inode->i_mapping->invalidate_lock);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
 			page_offset(page) > i_size_read(inode) ||
@@ -160,7 +157,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
-	up_read(&F2FS_I(inode)->i_mmap_sem);
+	up_read(&inode->i_mapping->invalidate_lock);
 
 	sb_end_pagefault(inode->i_sb);
 err:
@@ -941,7 +938,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		down_write(&F2FS_I(inode)->i_mmap_sem);
+		down_write(&inode->i_mapping->invalidate_lock);
 
 		truncate_setsize(inode, attr->ia_size);
 
@@ -951,7 +948,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * do not trim all blocks after i_size if target size is
 		 * larger than i_size.
 		 */
-		up_write(&F2FS_I(inode)->i_mmap_sem);
+		up_write(&inode->i_mapping->invalidate_lock);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
@@ -1094,7 +1091,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			down_write(&mapping->invalidate_lock);
 
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
@@ -1103,7 +1100,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			up_write(&mapping->invalidate_lock);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 	}
@@ -1338,7 +1335,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1346,7 +1343,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi);
 
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
@@ -1377,13 +1374,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		return ret;
 
 	/* write out all moved pages, if possible */
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 	return ret;
@@ -1483,7 +1480,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			pgoff_t end;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			down_write(&mapping->invalidate_lock);
 
 			truncate_pagecache_range(inode,
 				(loff_t)index << PAGE_SHIFT,
@@ -1495,7 +1492,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
-				up_write(&F2FS_I(inode)->i_mmap_sem);
+				up_write(&mapping->invalidate_lock);
 				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
@@ -1507,7 +1504,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_put_dnode(&dn);
 
 			f2fs_unlock_op(sbi);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			up_write(&mapping->invalidate_lock);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
@@ -1542,6 +1539,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
 	pgoff_t nr, pg_start, pg_end, delta, idx;
 	loff_t new_size;
 	int ret = 0;
@@ -1564,14 +1562,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi, true);
 
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 	if (ret)
 		return ret;
 
 	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	if (ret)
 		return ret;
 
@@ -1582,7 +1580,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1598,14 +1596,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi);
 	}
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	/* write out all moved pages, if possible */
-	down_write(&F2FS_I(inode)->i_mmap_sem);
-	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	down_write(&mapping->invalidate_lock);
+	filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
@@ -3566,7 +3564,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3602,7 +3600,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 out:
 	inode_unlock(inode);
 
@@ -3719,7 +3717,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3755,7 +3753,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 
 	if (ret >= 0) {
 		F2FS_I(inode)->i_flags &= ~F2FS_IMMUTABLE_FL;
@@ -3875,7 +3873,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		goto err;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	down_write(&mapping->invalidate_lock);
 
 	ret = filemap_write_and_wait_range(mapping, range.start,
 			to_end ? LLONG_MAX : end_addr - 1);
@@ -3962,7 +3960,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
 				prev_block, len, range.flags);
 out:
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&mapping->invalidate_lock);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 err:
 	inode_unlock(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 82592b19b4e0..c6ade37338ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1176,7 +1176,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->i_gc_rwsem[READ]);
 	init_rwsem(&fi->i_gc_rwsem[WRITE]);
-	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
 	/* Will be used by directory only */
-- 
2.26.2

