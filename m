Return-Path: <linux-fsdevel+bounces-31569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C99987E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3630E1C24489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D651CCB3A;
	Thu, 10 Oct 2024 13:35:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA741C7B8D;
	Thu, 10 Oct 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567349; cv=none; b=cCNDEWDIjmuV7mua52g2Yx9opqP8v6RB3CLvDmCfwvFd6QRzBrLwqFqdTajA5M0s+c/Yo6sMS1c2vdTDYtdXfe+1h8tPvCcSwRJRwHQnXdhIdD945DSnuiwnJXYhSh31PNF2fx74zisq5llySwkx7Y6lPYQimaXGjpzzprc+WMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567349; c=relaxed/simple;
	bh=MMTmuru0uSXetyI199H8UvzbW3ycYcsIf8+FqX5Rajk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sC+eyzgRzyOoJ36dkZZUBPJt5Vxtrb8Ryp8xK21I49c1FYUj8kUx10aU1gzDNtucfSELDJjHXWvLYBfuO38xkDLUHtkNRK5SAMfB1aEXJUBJNu3AKU6lkpJMiVmQmMuhL37NygJVxnXeFLeRa9Zfoc2V5NENQA3bLihbLGjqzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XPW3K6yC1z4f3jsL;
	Thu, 10 Oct 2024 21:35:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D3FA91A058E;
	Thu, 10 Oct 2024 21:35:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYc2AdnDRnZDg--.21356S9;
	Thu, 10 Oct 2024 21:35:42 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 05/10] ext4: refactor ext4_zero_range()
Date: Thu, 10 Oct 2024 21:33:28 +0800
Message-Id: <20241010133333.146793-6-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241010133333.146793-1-yi.zhang@huawei.com>
References: <20241010133333.146793-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYc2AdnDRnZDg--.21356S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrGr4DWF1UGr13Jr1fJFb_yoW3Gr1DpF
	ZIqrW5Kr4xWFyq9r48KFs7ZF40k3WkKrWUCFyxWrn5X3srtwn7Kan0kF95WFWIqrZ7Zw4Y
	vF4Yyry7GFWUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDU
	UUU
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

The current implementation of ext4_zero_range() contains complex
position calculations and stale error tags. To improve the code's
clarity and maintainability, it is essential to clean up the code and
improve its readability, this can be achieved by: a) simplifying and
renaming variables, making the style the same as ext4_punch_hole(); b)
eliminating unnecessary position calculations, writing back all data in
data=journal mode, and drop page cache from the original offset to the
end, rather than using aligned blocks; c) renaming the stale out_mutex
tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 161 +++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 96 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index aa07b5ddaff8..f843342e5164 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4565,40 +4565,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = file->f_mapping;
 	handle_t *handle = NULL;
-	unsigned int max_blocks;
 	loff_t new_size = 0;
-	int ret = 0;
-	int flags;
-	int credits;
-	int partial_begin, partial_end;
-	loff_t start, end;
-	ext4_lblk_t lblk;
+	loff_t end = offset + len;
+	ext4_lblk_t start_lblk, end_lblk;
+	unsigned int blocksize = i_blocksize(inode);
 	unsigned int blkbits = inode->i_blkbits;
+	int ret, flags, credits;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
 
-	/*
-	 * Round up offset. This is not fallocate, we need to zero out
-	 * blocks, so convert interior block aligned part of the range to
-	 * unwritten and possibly manually zero out unaligned parts of the
-	 * range. Here, start and partial_begin are inclusive, end and
-	 * partial_end are exclusive.
-	 */
-	start = round_up(offset, 1 << blkbits);
-	end = round_down((offset + len), 1 << blkbits);
-
-	if (start < offset || end > offset + len)
-		return -EINVAL;
-	partial_begin = offset & ((1 << blkbits) - 1);
-	partial_end = (offset + len) & ((1 << blkbits) - 1);
-
-	lblk = start >> blkbits;
-	max_blocks = (end >> blkbits);
-	if (max_blocks < lblk)
-		max_blocks = 0;
-	else
-		max_blocks -= lblk;
-
 	inode_lock(inode);
 
 	/*
@@ -4606,88 +4581,78 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	 */
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 		ret = -EOPNOTSUPP;
-		goto out_mutex;
+		goto out;
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > inode->i_size ||
-	     offset + len > EXT4_I(inode)->i_disksize)) {
-		new_size = offset + len;
+	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
+		new_size = end;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
-			goto out_mutex;
+			goto out;
 	}
 
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
-
-	/* Preallocate the range including the unaligned edges */
-	if (partial_begin || partial_end) {
-		ret = ext4_alloc_file_blocks(file,
-				round_down(offset, 1 << blkbits) >> blkbits,
-				(round_up((offset + len), 1 << blkbits) -
-				 round_down(offset, 1 << blkbits)) >> blkbits,
-				new_size, flags);
-		if (ret)
-			goto out_mutex;
-
-	}
-
-	/* Zero range excluding the unaligned edges */
-	if (max_blocks > 0) {
-		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
-			  EXT4_EX_NOCACHE);
+		goto out;
 
-		/*
-		 * Prevent page faults from reinstantiating pages we have
-		 * released from page cache.
-		 */
-		filemap_invalidate_lock(mapping);
+	/*
+	 * Prevent page faults from reinstantiating pages we have released
+	 * from page cache.
+	 */
+	filemap_invalidate_lock(mapping);
 
-		ret = ext4_break_layouts(inode);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
+	ret = ext4_break_layouts(inode);
+	if (ret)
+		goto out_invalidate_lock;
 
+	/*
+	 * For journalled data we need to write (and checkpoint) pages before
+	 * discarding page cache to avoid inconsitent data on disk in case of
+	 * crash before zeroing trans is committed.
+	 */
+	if (ext4_should_journal_data(inode)) {
+		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
+	} else {
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
+		ext4_truncate_folios_range(inode, offset, end);
+	}
+	if (ret)
+		goto out_invalidate_lock;
 
-		/*
-		 * For journalled data we need to write (and checkpoint) pages
-		 * before discarding page cache to avoid inconsitent data on
-		 * disk in case of crash before zeroing trans is committed.
-		 */
-		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping, start,
-							   end - 1);
-			if (ret) {
-				filemap_invalidate_unlock(mapping);
-				goto out_mutex;
-			}
-		}
+	/* Now release the pages and zero block aligned part of pages */
+	truncate_pagecache_range(inode, offset, end - 1);
 
-		/* Now release the pages and zero block aligned part of pages */
-		ext4_truncate_folios_range(inode, start, end);
-		truncate_pagecache_range(inode, start, end - 1);
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	/* Preallocate the range including the unaligned edges */
+	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
+		ext4_lblk_t alloc_lblk = offset >> blkbits;
+		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
 
-		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
-					     flags);
-		filemap_invalidate_unlock(mapping);
+		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
+					     new_size, flags);
 		if (ret)
-			goto out_mutex;
+			goto out_invalidate_lock;
 	}
-	if (!partial_begin && !partial_end)
-		goto out_mutex;
+
+	/* Zero range excluding the unaligned edges */
+	start_lblk = round_up(offset, blocksize) >> blkbits;
+	end_lblk = end >> blkbits;
+	if (end_lblk > start_lblk) {
+		ext4_lblk_t zero_blks = end_lblk - start_lblk;
+
+		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
+		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
+					     new_size, flags);
+		if (ret)
+			goto out_invalidate_lock;
+	}
+	/* Finish zeroing out if it doesn't contain partial block */
+	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
+		goto out_invalidate_lock;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4700,25 +4665,29 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_mutex;
+		goto out_invalidate_lock;
 	}
 
+	/* Zero out partial block at the edges of the range */
+	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
+	if (ret)
+		goto out_handle;
+
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret))
 		goto out_handle;
-	/* Zero out partial block at the edges of the range */
-	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
 
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (file->f_flags & O_SYNC)
 		ext4_handle_sync(handle);
 
 out_handle:
 	ext4_journal_stop(handle);
-out_mutex:
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
+out:
 	inode_unlock(inode);
 	return ret;
 }
-- 
2.39.2


