Return-Path: <linux-fsdevel+bounces-32553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7549A96A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408E81C23327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F315B0F1;
	Tue, 22 Oct 2024 03:13:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369D146A63;
	Tue, 22 Oct 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566782; cv=none; b=tEq+r8OQciRoPwxazhWPircBofwzgBD/idqG36o0AfBCiOP7HXerDMhTOKZBjivr7CFnwZQcmM8awplj8L4AIcP6IIDpdwhVK1A58ksARMNFfgqEfh4aqM11C0Jso2G0Ec10K1IPRHIjWrRGoN4VTUGoVS87eYjX0U3sbq3XPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566782; c=relaxed/simple;
	bh=9OoTY+6/DPLRRyXqggoqwvpTYNignh7uw7u+WydgWiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8jB1ZXpIdgMvErPAbKHQGF9DuagwgAdbM3FDCOE5rvNs0psENo0NG+TmZfpCgvzS5YbCXUXhNvjx7DFNVNk3RhPqJuePl0YjwbG5dyEWb4wm97miUWTu1I/zsw6pR8HKOG9ATFF7QBmPB5r25Oao7l9QW1o44uk88s4tAYwSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg54Jh4z4f3lVc;
	Tue, 22 Oct 2024 11:12:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C0CBC1A0359;
	Tue, 22 Oct 2024 11:12:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S8;
	Tue, 22 Oct 2024 11:12:51 +0800 (CST)
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
Subject: [PATCH 04/27] ext4: refactor ext4_punch_hole()
Date: Tue, 22 Oct 2024 19:10:35 +0800
Message-ID: <20241022111059.2566137-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GF48tFWrGF1fAF17GFWfKrg_yoW3GFy7p3
	y3Ary5Kr48WFyq9F4Iqr4DXF1Ik3WDKrWUWryxGr1fW34qyw1IgFs0kF1Fgay5trZrZw4j
	vF45t347W34UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRtl1hUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The current implementation of ext4_punch_hole() contains complex
position calculations and stale error tags. To improve the code's
clarity and maintainability, it is essential to clean up the code and
improve its readability, this can be achieved by: a) simplifying and
renaming variables; b) eliminating unnecessary position calculations;
c) writing back all data in data=journal mode, and drop page cache from
the original offset to the end, rather than using aligned blocks,
d) renaming the stale error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 140 +++++++++++++++++++++---------------------------
 1 file changed, 62 insertions(+), 78 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94b923afcd9c..1d128333bd06 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3955,13 +3955,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 {
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
-	ext4_lblk_t first_block, stop_block;
+	ext4_lblk_t start_lblk, end_lblk;
 	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset, max_length;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
+	loff_t end = offset + length;
+	unsigned long blocksize = i_blocksize(inode);
 	handle_t *handle;
 	unsigned int credits;
-	int ret = 0, ret2 = 0;
+	int ret = 0;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
@@ -3969,36 +3970,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size)
-		goto out_mutex;
+		goto out;
 
 	/*
-	 * If the hole extends beyond i_size, set the hole
-	 * to end after the page that contains i_size
+	 * If the hole extends beyond i_size, set the hole to end after
+	 * the page that contains i_size, and also make sure that the hole
+	 * within one block before last range.
 	 */
-	if (offset + length > inode->i_size) {
-		length = inode->i_size +
-		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
-		   offset;
-	}
+	if (end > inode->i_size)
+		end = round_up(inode->i_size, PAGE_SIZE);
+	if (end > max_end)
+		end = max_end;
+	length = end - offset;
 
 	/*
-	 * For punch hole the length + offset needs to be within one block
-	 * before last range. Adjust the length if it goes beyond that limit.
+	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
+	 * block.
 	 */
-	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
-	if (offset + length > max_length)
-		length = max_length - offset;
-
-	if (offset & (sb->s_blocksize - 1) ||
-	    (offset + length) & (sb->s_blocksize - 1)) {
-		/*
-		 * Attach jinode to inode for jbd2 if we do any zeroing of
-		 * partial block
-		 */
+	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out_mutex;
-
+			goto out;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4006,7 +3998,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -4016,34 +4008,24 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_dio;
-
-	first_block_offset = round_up(offset, sb->s_blocksize);
-	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
+		goto out_invalidate_lock;
 
-	/* Now release the pages and zero block aligned part of pages*/
-	if (last_block_offset > first_block_offset) {
+	/*
+	 * For journalled data we need to write (and checkpoint) pages
+	 * before discarding page cache to avoid inconsitent data on
+	 * disk in case of crash before punching trans is committed.
+	 */
+	if (ext4_should_journal_data(inode)) {
+		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
+	} else {
 		ret = ext4_update_disksize_before_punch(inode, offset, length);
-		if (ret)
-			goto out_dio;
-
-		/*
-		 * For journalled data we need to write (and checkpoint) pages
-		 * before discarding page cache to avoid inconsitent data on
-		 * disk in case of crash before punching trans is committed.
-		 */
-		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping,
-					first_block_offset, last_block_offset);
-			if (ret)
-				goto out_dio;
-		}
-
-		ext4_truncate_folios_range(inode, first_block_offset,
-					   last_block_offset + 1);
-		truncate_pagecache_range(inode, first_block_offset,
-					 last_block_offset);
+		ext4_truncate_folios_range(inode, offset, end);
 	}
+	if (ret)
+		goto out_invalidate_lock;
+
+	/* Now release the pages and zero block aligned part of pages*/
+	truncate_pagecache_range(inode, offset, end - 1);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
@@ -4053,52 +4035,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(sb, ret);
-		goto out_dio;
+		goto out_invalidate_lock;
 	}
 
-	ret = ext4_zero_partial_blocks(handle, inode, offset,
-				       length);
+	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
 	if (ret)
-		goto out_stop;
-
-	first_block = (offset + sb->s_blocksize - 1) >>
-		EXT4_BLOCK_SIZE_BITS(sb);
-	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
+		goto out_handle;
 
 	/* If there are blocks to remove, do it */
-	if (stop_block > first_block) {
-		ext4_lblk_t hole_len = stop_block - first_block;
+	start_lblk = round_up(offset, blocksize) >> inode->i_blkbits;
+	end_lblk = end >> inode->i_blkbits;
+
+	if (end_lblk > start_lblk) {
+		ext4_lblk_t hole_len = end_lblk - start_lblk;
 
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 
-		ext4_es_remove_extent(inode, first_block, hole_len);
+		ext4_es_remove_extent(inode, start_lblk, hole_len);
 
 		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-			ret = ext4_ext_remove_space(inode, first_block,
-						    stop_block - 1);
+			ret = ext4_ext_remove_space(inode, start_lblk,
+						    end_lblk - 1);
 		else
-			ret = ext4_ind_remove_space(handle, inode, first_block,
-						    stop_block);
+			ret = ext4_ind_remove_space(handle, inode, start_lblk,
+						    end_lblk);
+		if (ret) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto out_handle;
+		}
 
-		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
+		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
 				      EXTENT_STATUS_HOLE, 0);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
-	ext4_fc_track_range(handle, inode, first_block, stop_block);
+	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
+
+	ret = ext4_mark_inode_dirty(handle, inode);
+	if (unlikely(ret))
+		goto out_handle;
+
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-
-	ret2 = ext4_mark_inode_dirty(handle, inode);
-	if (unlikely(ret2))
-		ret = ret2;
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_dio:
+out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out_mutex:
+out:
 	inode_unlock(inode);
 	return ret;
 }
-- 
2.46.1


