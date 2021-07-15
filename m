Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C853C9FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhGONnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59662 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhGONn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DC251FE27;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAwH8p8fifiQg27/Bml9bQG8rBDFikpquMFbXnFLpF0=;
        b=1q5ce0ejgt4apY8fgVTLEINTJHtLlUEjqdpJyoJMEQqAHtLuv0S1nYHKW9ZiwZYJGHhGmq
        U4OtCrGr/2NUurwNQjbZtjNex0WxR+v9w4St7cZS1mpjBvnP3rtA0RneqvpvRx0cBKiQn3
        cXv95Z8fjgYc4eER5TpvmPJ9Zdc0n2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MAwH8p8fifiQg27/Bml9bQG8rBDFikpquMFbXnFLpF0=;
        b=9xIHoPuIEFkhAbxquASAEkhpL4ZXo2rGQPyJOmW9bHfFVpT+XZdv++REm1WNowbekYouoK
        8ifSoSuFzPpieIDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 68590A3BA0;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A1851E0E81; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 11/14] f2fs: Convert to using invalidate_lock
Date:   Thu, 15 Jul 2021 15:40:21 +0200
Message-Id: <20210715134032.24868-11-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12344; h=from:subject; bh=ugTzdnQ5fwj65SlrJvAh5LPvP/ZLlo/IqJfGP2n6gZ0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrFIPcXwZZYwK4J88o6DMh61busWv3ks1R0FhPw fmLfaECJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6xQAKCRCcnaoHP2RA2fa3CA CH20fdImRPyfVXQW24cQzPmd2KgQP3evXTQGNaeQc3pUMwcuRZwC61cem6pShqocaSYuBQrKdZfW+M 6Dvn3opd8VKSn3rxWA+a+OWOaOVzvR2kKjubFOUZZpk2rC6A4o62lvfzBXBM8u3IQnabhG3zcCXfDj xI2bMirEw8a58aG3vz8FgXxVfkv7xA/L/FypBBju4sUFEfKShNwEBJWuEJSz6aneoqiVJ4pp8CR/ST iuUnQjnofwOZrQBnmotTE/JzHKP3DFc48oS4wbY0XXe67CUSkxhrZ8MI2ysrKzhDVr+uQkCEi3BM2J s1dfvB0bGvaio6YBJwIddvYjl3nPQ0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/data.c  |  8 +++----
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/file.c  | 62 ++++++++++++++++++++++++-------------------------
 fs/f2fs/super.c |  1 -
 4 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d2cf48c5a2e4..eb222b35edef 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3187,12 +3187,12 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	/* In the fs-verity case, f2fs_end_enable_verity() does the truncate */
 	if (to > i_size && !f2fs_verity_in_progress(inode)) {
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		down_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(mapping);
 
 		truncate_pagecache(inode, i_size);
 		f2fs_truncate_blocks(inode, i_size, true);
 
-		up_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(mapping);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	}
 }
@@ -3852,7 +3852,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	int ret = 0;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	set_inode_flag(inode, FI_ALIGNED_WRITE);
 
@@ -3894,7 +3894,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	clear_inode_flag(inode, FI_DO_DEFRAG);
 	clear_inode_flag(inode, FI_ALIGNED_WRITE);
 
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	return ret;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee8eb33e2c25..906b2c4b50e7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -754,7 +754,6 @@ struct f2fs_inode_info {
 
 	/* avoid racing between foreground op and gc */
 	struct rw_semaphore i_gc_rwsem[2];
-	struct rw_semaphore i_mmap_sem;
 	struct rw_semaphore i_xattr_sem; /* avoid racing between reading and changing EAs */
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..1ff333755721 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -38,10 +38,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
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
+	filemap_invalidate_lock_shared(inode->i_mapping);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
 			page_offset(page) > i_size_read(inode) ||
@@ -159,7 +156,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
-	up_read(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	sb_end_pagefault(inode->i_sb);
 err:
@@ -940,7 +937,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		down_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(inode->i_mapping);
 
 		truncate_setsize(inode, attr->ia_size);
 
@@ -950,7 +947,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * do not trim all blocks after i_size if target size is
 		 * larger than i_size.
 		 */
-		up_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(inode->i_mapping);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
@@ -1095,7 +1092,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_lock(mapping);
 
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
@@ -1104,7 +1101,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 	}
@@ -1339,7 +1336,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1347,7 +1344,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi);
 
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
@@ -1378,13 +1375,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		return ret;
 
 	/* write out all moved pages, if possible */
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 	return ret;
@@ -1484,7 +1481,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			pgoff_t end;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_lock(mapping);
 
 			truncate_pagecache_range(inode,
 				(loff_t)index << PAGE_SHIFT,
@@ -1496,7 +1493,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
-				up_write(&F2FS_I(inode)->i_mmap_sem);
+				filemap_invalidate_unlock(mapping);
 				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
@@ -1508,7 +1505,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_put_dnode(&dn);
 
 			f2fs_unlock_op(sbi);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
@@ -1543,6 +1540,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
 	pgoff_t nr, pg_start, pg_end, delta, idx;
 	loff_t new_size;
 	int ret = 0;
@@ -1565,14 +1563,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi, true);
 
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 	if (ret)
 		return ret;
 
 	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	if (ret)
 		return ret;
 
@@ -1583,7 +1581,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1599,14 +1597,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi);
 	}
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	/* write out all moved pages, if possible */
-	down_write(&F2FS_I(inode)->i_mmap_sem);
-	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	filemap_invalidate_lock(mapping);
+	filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
@@ -3440,7 +3438,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3476,7 +3474,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 out:
 	inode_unlock(inode);
 
@@ -3593,7 +3591,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3629,7 +3627,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	if (ret >= 0) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
@@ -3748,7 +3746,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		goto err;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 
 	ret = filemap_write_and_wait_range(mapping, range.start,
 			to_end ? LLONG_MAX : end_addr - 1);
@@ -3835,7 +3833,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
 				prev_block, len, range.flags);
 out:
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 err:
 	inode_unlock(inode);
@@ -4313,9 +4311,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		/* if we couldn't write data, we should deallocate blocks. */
 		if (preallocated && i_size_read(inode) < target_size) {
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_lock(inode->i_mapping);
 			f2fs_truncate(inode);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(inode->i_mapping);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fecd3050ccd..ce2ab1b85c11 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1289,7 +1289,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->i_gc_rwsem[READ]);
 	init_rwsem(&fi->i_gc_rwsem[WRITE]);
-	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
 	/* Will be used by directory only */
-- 
2.26.2

