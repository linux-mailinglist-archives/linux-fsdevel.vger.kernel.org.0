Return-Path: <linux-fsdevel+bounces-27987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56069658CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0081F2564A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BAE16BE28;
	Fri, 30 Aug 2024 07:39:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA0153BF9;
	Fri, 30 Aug 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003577; cv=none; b=gyXELYIvw6e8c/51+8CBCEuN0MQcuJKw8xQ8c+5BRLDgYrG5YukgOvIepTDT34l2g47TrqLMJ94uUcv6cJCqy0BwX+8u02ca8bIINuSed9dfeeSsAiCIqXPiVgHHFNR3jtPe62WpwNFxVs3Z1MDieHOkHLshzC0oYb2AhBEq5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003577; c=relaxed/simple;
	bh=CYeEELKvLhD3vIoUUOz2pHSh+1rJgkNW+PW3g0QUWRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CY5ohVMmT+BuvTgxjf+gVOHeNv+8UYcxW05yCPZJrXKOP9fO+iABPgIJhKUj1tZWSdD3xt3wTTGGbkFf8+5i4/K0qBVZfMvsh8zMufvAl32WO9YfTF/9Vq7iRHLxX0Wm6MxiB6VR6JrqboGn7cNZ2xfdtWoCWOvIcIM9H4D173k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww95J3nNXz4f3l24;
	Fri, 30 Aug 2024 15:39:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1988E1A0359;
	Fri, 30 Aug 2024 15:39:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4Uhd9FmXb5_DA--.51707S8;
	Fri, 30 Aug 2024 15:39:31 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
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
Subject: [PATCH 04/10] ext4: refactor ext4_zero_range()
Date: Fri, 30 Aug 2024 15:37:54 +0800
Message-Id: <20240830073800.2131781-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830073800.2131781-1-yi.zhang@huaweicloud.com>
References: <20240830073800.2131781-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4Uhd9FmXb5_DA--.51707S8
X-Coremail-Antispam: 1UD129KBjvJXoW3WryUAw47Jr1rZFWfWr4fGrg_yoW7Kr15pF
	ZxXr15Gr4fWFyj9r48KFsrZF40kw1DKrW8Wry7Wr1fX3sFqrn7K3Z0kr9YgFWIqrZ7Zr4Y
	vFs0y347GrWUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Current ext4_zero_range() is full of complex position calculation and
stale error out tags. In order to clean up the code and make things
clear, refactor it by a) simplify and rename variables, b) remove some
unnecessary position calculations, always write back dirty data and
drop cache from offset to end, instead of only write back aligned
blocks, c) rename the stale out_mutex tag.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 96 ++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d9fccf2970e9..2fb0c2e303c7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4540,40 +4540,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
@@ -4581,26 +4556,23 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released
@@ -4616,36 +4588,40 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	 * Write data that will be zeroed to preserve them when successfully
 	 * discarding page cache below but fail to convert extents.
 	 */
-	ret = filemap_write_and_wait_range(mapping, start, end - 1);
+	ret = filemap_write_and_wait_range(mapping, offset, end - 1);
 	if (ret)
 		goto out_invalidate_lock;
 
+	/* Now release the pages and zero block aligned part of pages */
+	truncate_pagecache_range(inode, offset, end - 1);
+
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 	/* Preallocate the range including the unaligned edges */
-	if (partial_begin || partial_end) {
-		ret = ext4_alloc_file_blocks(file,
-				round_down(offset, 1 << blkbits) >> blkbits,
-				(round_up((offset + len), 1 << blkbits) -
-				 round_down(offset, 1 << blkbits)) >> blkbits,
-				new_size, flags);
+	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
+		ext4_lblk_t alloc_lblk = offset >> blkbits;
+		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
+
+		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
+					     new_size, flags);
 		if (ret)
 			goto out_invalidate_lock;
 
 	}
 
 	/* Zero range excluding the unaligned edges */
-	if (max_blocks > 0) {
-		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
-			  EXT4_EX_NOCACHE);
-
-		/* Now release the pages and zero block aligned part of pages */
-		truncate_pagecache_range(inode, start, end - 1);
-
-		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
-					     flags);
+	start_lblk = round_up(offset, blocksize) >> blkbits;
+	end_lblk = end >> blkbits;
+	if (end_lblk > start_lblk) {
+		ext4_lblk_t zero_blks = end_lblk - start_lblk;
+
+		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
+		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
+					     new_size, flags);
 		if (ret)
 			goto out_invalidate_lock;
 	}
-	if (!partial_begin && !partial_end)
+	/* Finish zeroing out if it doesn't contain partial block */
+	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
 		goto out_invalidate_lock;
 
 	/*
@@ -4662,16 +4638,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_invalidate_lock;
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
 
@@ -4679,7 +4657,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out_mutex:
+out:
 	inode_unlock(inode);
 	return ret;
 }
-- 
2.39.2


