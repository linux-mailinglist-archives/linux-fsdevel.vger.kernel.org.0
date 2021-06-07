Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2706B39DF99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFGOyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhFGOyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F9621FDD7;
        Mon,  7 Jun 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYSgS5m2T2u6Q6Ponyx+Zv42cR4FBe8YnAlTCyybDyU=;
        b=joREQLoRJIX4r39pUhk19XimH+tuu2F5vaaVaQDlBNuVXvKj2tHu4ev8j+cbRrErJQSik9
        1yPwKwEBVUzluhO2f0FiTjYAKvWdjh3GZRkJLBBUiJuvDNb9glT5YEFmLIU6HLbfampi+I
        B2NiB4PP/evrejwYxGA4AQDux+zgeD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYSgS5m2T2u6Q6Ponyx+Zv42cR4FBe8YnAlTCyybDyU=;
        b=gq+L6wX/9UqiGmzLKik0LrRbrsxw3yavon/SNjh1r91+DTobUhBj045SJq5IDqteJhm/eI
        HLEZ577PX0qTIpAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CEC8FA3B8B;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B777C1F2CBA; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
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
Subject: [PATCH 11/14] f2fs: Convert to using invalidate_lock
Date:   Mon,  7 Jun 2021 16:52:21 +0200
Message-Id: <20210607145236.31852-11-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11698; h=from:subject; bh=ezAzL9Mh91MTCMm+oIB7Tr9ZHGQQoU+2zfoCcWTPNuI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgvjKlRxZLy+Up9fbVrWZihVGnUQaDfKkh8oR7zo3U L1Kw4eiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYL4ypQAKCRCcnaoHP2RA2S7DCA CNAmWsJA8HAgaSyRFLyyx8/cjpq2qUTZz+QXtWInurmb+t7GSrQiL6XPLT9089OuR/rCYQsasRpIzx OnobpcKVc/Z92L6HaArcxsaiROmXJB6CkaVnxFYXq2/j+EUuOwVWu33OCytCKHBO691Nlz3taJ2qJ4 BiGfPnLJA8TSKyEIztKaI0dg+bs/axNsi4WuhXObCCC34jMGTyqB77AukcsscFJRH9WfRMZ8U0XcHA bab3CmgNvHLOQS1sx7SmqetsyQ9lhLHW/2C+qYjJbbxMxUTJQceRNNS4YLaqFiLAyYN+fSWSMq8uvN It+T/kK6rX1p2DeS4phX4kn3DkD7Lb
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
 fs/f2fs/data.c  |  4 ++--
 fs/f2fs/f2fs.h  |  1 -
 fs/f2fs/file.c  | 62 ++++++++++++++++++++++++-------------------------
 fs/f2fs/super.c |  1 -
 4 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 96f1a354f89f..66ce7e7b1c37 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3165,12 +3165,12 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
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
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 044878866ca3..1f887c906aaf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -748,7 +748,6 @@ struct f2fs_inode_info {
 
 	/* avoid racing between foreground op and gc */
 	struct rw_semaphore i_gc_rwsem[2];
-	struct rw_semaphore i_mmap_sem;
 	struct rw_semaphore i_xattr_sem; /* avoid racing between reading and changing EAs */
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 44a4650aea7b..cce1ac3dd51b 100644
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
@@ -102,7 +99,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
 	file_update_time(vmf->vma->vm_file);
-	down_read(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock_shared(inode->i_mapping);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
 			page_offset(page) > i_size_read(inode) ||
@@ -161,7 +158,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
 out_sem:
-	up_read(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	sb_end_pagefault(inode->i_sb);
 err:
@@ -942,7 +939,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-		down_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_lock(inode->i_mapping);
 
 		truncate_setsize(inode, attr->ia_size);
 
@@ -952,7 +949,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 * do not trim all blocks after i_size if target size is
 		 * larger than i_size.
 		 */
-		up_write(&F2FS_I(inode)->i_mmap_sem);
+		filemap_invalidate_unlock(inode->i_mapping);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
@@ -1097,7 +1094,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			blk_end = (loff_t)pg_end << PAGE_SHIFT;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_lock(mapping);
 
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
@@ -1106,7 +1103,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		}
 	}
@@ -1341,7 +1338,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1349,7 +1346,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi);
 
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
@@ -1380,13 +1377,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
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
@@ -1486,7 +1483,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			pgoff_t end;
 
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-			down_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_lock(mapping);
 
 			truncate_pagecache_range(inode,
 				(loff_t)index << PAGE_SHIFT,
@@ -1498,7 +1495,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
-				up_write(&F2FS_I(inode)->i_mmap_sem);
+				filemap_invalidate_unlock(mapping);
 				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 				goto out;
 			}
@@ -1510,7 +1507,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_put_dnode(&dn);
 
 			f2fs_unlock_op(sbi);
-			up_write(&F2FS_I(inode)->i_mmap_sem);
+			filemap_invalidate_unlock(mapping);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 			f2fs_balance_fs(sbi, dn.node_changed);
@@ -1545,6 +1542,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
 	pgoff_t nr, pg_start, pg_end, delta, idx;
 	loff_t new_size;
 	int ret = 0;
@@ -1567,14 +1565,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
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
 
@@ -1585,7 +1583,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1601,14 +1599,14 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
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
@@ -3442,7 +3440,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3478,7 +3476,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 out:
 	inode_unlock(inode);
 
@@ -3595,7 +3593,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
@@ -3631,7 +3629,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	}
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	up_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	if (ret >= 0) {
 		F2FS_I(inode)->i_flags &= ~F2FS_IMMUTABLE_FL;
@@ -3751,7 +3749,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		goto err;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	down_write(&F2FS_I(inode)->i_mmap_sem);
+	filemap_invalidate_lock(mapping);
 
 	ret = filemap_write_and_wait_range(mapping, range.start,
 			to_end ? LLONG_MAX : end_addr - 1);
@@ -3838,7 +3836,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
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
index 7d325bfaf65a..22e942aac7ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1187,7 +1187,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->i_gc_rwsem[READ]);
 	init_rwsem(&fi->i_gc_rwsem[WRITE]);
-	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
 	/* Will be used by directory only */
-- 
2.26.2

