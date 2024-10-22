Return-Path: <linux-fsdevel+bounces-32555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0A9A96AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3278E1F24334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68A17B436;
	Tue, 22 Oct 2024 03:13:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA44146A9F;
	Tue, 22 Oct 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566783; cv=none; b=V4GopPnZVgwfThWtsJ41ZcEpfmJElKH+EGgrHf76YJw24Y1gbu2v9u5XvRDyyHQSu5jN1KAelfhrwRmZw5VdhuOzXItNDN92aEPKNQPrlv1FJPv2SKDN6eth3fOiOOY1gAFWTVAqv0g8VgauDmbL+dI4IekdN3F3Vox8u7sqRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566783; c=relaxed/simple;
	bh=SL3556zehzIj4Ho5hXlwQ/qb69LOIePNOS7/RN3+B9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8vlb/NYadNu1VKUsbO0P2nKD1dEBUTd4Z6g9HSPd5c96Sj5l53VCLaGJWC/wxQFFUMK7aiXsYpUXAAjQtYoLes+ZKkhy23PJmG7SU7MY0rIxQSfACoeJRnlnqLFyZR5q6U4kgGk1BOEvLzLHFzMYNcYCLdW0o38Ye4LbFCx0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg61f68z4f3lW1;
	Tue, 22 Oct 2024 11:12:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 64D5A1A058E;
	Tue, 22 Oct 2024 11:12:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S9;
	Tue, 22 Oct 2024 11:12:52 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 05/27] ext4: refactor ext4_zero_range()
Date: Tue, 22 Oct 2024 19:10:36 +0800
Message-ID: <20241022111059.2566137-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrGr4DWF1UGr13Jr1fJFb_yoW3GF18pF
	ZIqrW5Kr48WFyq9r48KFsrZF40k3WkKrWUCFyxWrn5X3srtwn7Kan8KF95WFWIqrZ7Zw4Y
	vF4Yyry7GFWUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRtl1hUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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
2.46.1


