Return-Path: <linux-fsdevel+bounces-37457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E439F2810
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB31162695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB21CD215;
	Mon, 16 Dec 2024 01:42:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36415B0F2;
	Mon, 16 Dec 2024 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313367; cv=none; b=Q3JzV5ifAUXRiVaNoGk26L5l7M3G7tFCyoX/musMDTJK9kS7G1VZMsbazlhEMZP4/2dZV/HOlFMtkW4gyBJw3tQJAA2NL7sKB7p4WdUTRDJI97P4m7ksnIHGZDd1pRiEDJqg/+oG1G4sMo6Q5MSIBM7rbtXT+qVEN/JqmQJg7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313367; c=relaxed/simple;
	bh=W5PhK1KsrUUZp3w9xhXuL3uVuNnA5Aii+yETLMoo6s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4MbE+C5FtOhDuXshszKVs1zqLvW+8RKGiLV8c8i66B7X4utip3iWiBPljF3pGzfD3STx8kEdHjpyLGvwv0N3CsK4hkVASWttblHaKbuJqzAF1BnZBDxIXH0Z6cHM+qhFtNPD5d/LhRBMTKIj0GbxqH7jiMbO3RptEVeQdLXn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBN3V4RvCz4f3lVL;
	Mon, 16 Dec 2024 09:42:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1324A1A058E;
	Mon, 16 Dec 2024 09:42:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4d5hV9nYi3kEg--.4387S8;
	Mon, 16 Dec 2024 09:42:34 +0800 (CST)
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
Subject: [PATCH v4 04/10] ext4: refactor ext4_punch_hole()
Date: Mon, 16 Dec 2024 09:39:09 +0800
Message-ID: <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHY4d5hV9nYi3kEg--.4387S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GF48tFWrGF1fAw43Xr1fWFg_yoWxKw4rp3
	9Iyry5Kr48WFyv9F4xtr4DXF1Ik3WkKrWUWryxGr1fW34qyw1IgF1qkF1Fga45KrZ7Xr4j
	vF45try7W34UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
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
 fs/ext4/ext4.h  |   2 +
 fs/ext4/inode.c | 119 +++++++++++++++++++++---------------------------
 2 files changed, 55 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8843929b46ce..8be06d5f5b43 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -367,6 +367,8 @@ struct ext4_io_submit {
 #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
 	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
 								  blkbits))
+#define EXT4_B_TO_LBLK(inode, offset) \
+	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
 
 /* Translate a block number to a cluster number */
 #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a5ba2b71d508..7720d3700b27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4008,13 +4008,13 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
 	handle_t *handle;
 	unsigned int credits;
-	int ret = 0, ret2 = 0;
+	int ret = 0;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
@@ -4022,36 +4022,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
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
+	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out_mutex;
-
+			goto out;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4059,7 +4050,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -4069,22 +4060,16 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_dio;
+		goto out_invalidate_lock;
 
-	first_block_offset = round_up(offset, sb->s_blocksize);
-	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
+	ret = ext4_update_disksize_before_punch(inode, offset, length);
+	if (ret)
+		goto out_invalidate_lock;
 
 	/* Now release the pages and zero block aligned part of pages*/
-	if (last_block_offset > first_block_offset) {
-		ret = ext4_update_disksize_before_punch(inode, offset, length);
-		if (ret)
-			goto out_dio;
-
-		ret = ext4_truncate_page_cache_block_range(inode,
-				first_block_offset, last_block_offset + 1);
-		if (ret)
-			goto out_dio;
-	}
+	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
+	if (ret)
+		goto out_invalidate_lock;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
@@ -4094,52 +4079,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
+	start_lblk = EXT4_B_TO_LBLK(inode, offset);
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


