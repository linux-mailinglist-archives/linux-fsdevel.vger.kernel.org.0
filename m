Return-Path: <linux-fsdevel+bounces-37463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3379F2822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DFA16727C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1D1D5166;
	Mon, 16 Dec 2024 01:42:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED11C3F36;
	Mon, 16 Dec 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313370; cv=none; b=ZpB93bGauYlbFZD+IBBYtD+3gtW7nhnj8FmwQ1rw/37fH26Ld8mimGKpXQDth7EVJjXcnQUM9QwGKm/xQPqYjUswHORNRs7i0bfoWZ6fpAbbmGm6ztQO0YUvvJippJsRZpMedas4wFxkEkZa9oAsylC2WIUslJlpZ7cHk9+RIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313370; c=relaxed/simple;
	bh=wjzCN8egFjuKl/ME4ywSBay39UK3FaT+q7TnG88DHH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkPgXEfC60FRy7e+hzu0l+juC+w6eMMG2kLbMO5SflBW9Cj8fUY+DVNGyod7f0fzZZ4XZ3dhnhGj2ZBg5PhVFDiigCZIDIlH5KfHiPkRiZQd69gX1Gw5KwOvBjzZjbgrZGOfFC8hX4T+1R8dmLHKA5zHfmz8KO1/aPRzi3Mfi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBN3Z1lqnz4f3kFG;
	Mon, 16 Dec 2024 09:42:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A38B21A0E9B;
	Mon, 16 Dec 2024 09:42:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4d5hV9nYi3kEg--.4387S14;
	Mon, 16 Dec 2024 09:42:37 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 10/10] ext4: move out common parts into ext4_fallocate()
Date: Mon, 16 Dec 2024 09:39:15 +0800
Message-ID: <20241216013915.3392419-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4d5hV9nYi3kEg--.4387S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw4rKF4xKr1UXr4rJF4rAFb_yoWDAFy3pF
	W5JrW5trWxWFykWF4FyanrZF1aywsFgrW8WrWxu3sYvas0ywnrKa1YkFyFvFW5trW8Ar4j
	vF4jvry7GFW7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, all zeroing ranges, punch holes, collapse ranges, and insert
ranges first wait for all existing direct I/O workers to complete, and
then they acquire the mapping's invalidate lock before performing the
actual work. These common components are nearly identical, so we can
simplify the code by factoring them out into the ext4_fallocate().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 124 ++++++++++++++++------------------------------
 fs/ext4/inode.c   |  25 ++--------
 2 files changed, 45 insertions(+), 104 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 85f0de1abe78..1b028be19193 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4568,7 +4568,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
 {
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
 	loff_t new_size = 0;
 	loff_t end = offset + len;
@@ -4592,23 +4591,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released
-	 * from page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 	/* Preallocate the range including the unaligned edges */
 	if (!IS_ALIGNED(offset | end, blocksize)) {
@@ -4618,17 +4600,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 
 	ret = ext4_update_disksize_before_punch(inode, offset, len);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages */
 	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Zero range excluding the unaligned edges */
 	start_lblk = EXT4_B_TO_LBLK(inode, offset);
@@ -4640,11 +4622,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 	/* Finish zeroing out if it doesn't contain partial block */
 	if (IS_ALIGNED(offset | end, blocksize))
-		goto out_invalidate_lock;
+		return ret;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4657,7 +4639,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	/* Zero out partial block at the edges of the range */
@@ -4677,8 +4659,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -4711,13 +4691,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 			goto out;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out;
-
 	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
 				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
 	if (ret)
@@ -4742,6 +4715,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	int ret;
 
 	/*
@@ -4765,6 +4739,29 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out_inode_lock;
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+
+	ret = file_modified(file);
+	if (ret)
+		return ret;
+
+	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
+		ret = ext4_do_fallocate(file, offset, len, mode);
+		goto out_inode_lock;
+	}
+
+	/*
+	 * Follow-up operations will drop page cache, hold invalidate lock
+	 * to prevent page faults from reinstantiating pages we have
+	 * released from page cache.
+	 */
+	filemap_invalidate_lock(mapping);
+
+	ret = ext4_break_layouts(inode);
+	if (ret)
+		goto out_invalidate_lock;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
 	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
@@ -4774,7 +4771,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	else if (mode & FALLOC_FL_ZERO_RANGE)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
-		ret = ext4_do_fallocate(file, offset, len, mode);
+		ret = -EOPNOTSUPP;
+
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
 out_inode_lock:
 	inode_unlock(inode);
 	return ret;
@@ -5301,23 +5301,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	if (end >= inode->i_size)
 		return -EINVAL;
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	/*
 	 * Write tail of the last page before removed range and data that
 	 * will be shifted since they will get removed from the page cache
@@ -5331,16 +5314,15 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	if (!ret)
 		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_invalidate_lock;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	start_lblk = offset >> inode->i_blkbits;
@@ -5379,8 +5361,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -5421,23 +5401,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	if (len > inode->i_sb->s_maxbytes - inode->i_size)
 		return -EFBIG;
 
-	/* Wait for existing dio to complete */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
-
 	/*
 	 * Write out all dirty pages. Need to round down to align start offset
 	 * to page size boundary for page size > block size.
@@ -5445,16 +5408,15 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	start = round_down(offset, PAGE_SIZE);
 	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto out_invalidate_lock;
-	}
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	/* Expand file to avoid data loss if there is error while shifting */
@@ -5525,8 +5487,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2e1f070ab449..2677a2cace58 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4009,7 +4009,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t start_lblk, end_lblk;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
 	loff_t end = offset + length;
 	handle_t *handle;
@@ -4044,31 +4043,15 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		return ret;
-
-	/*
-	 * Prevent page faults from reinstantiating pages we have released from
-	 * page cache.
-	 */
-	filemap_invalidate_lock(mapping);
-
-	ret = ext4_break_layouts(inode);
-	if (ret)
-		goto out_invalidate_lock;
 
 	ret = ext4_update_disksize_before_punch(inode, offset, length);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages*/
 	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
@@ -4078,7 +4061,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
@@ -4123,8 +4106,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ext4_handle_sync(handle);
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
-- 
2.46.1


