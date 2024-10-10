Return-Path: <linux-fsdevel+bounces-31571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C449987ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD4CB2676A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677181CEAC0;
	Thu, 10 Oct 2024 13:35:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37E1CC8B3;
	Thu, 10 Oct 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567352; cv=none; b=jE7RKKB3N56ZqClmPSTbG0z7L1iUSQ0id0tcOLqPysqZRuwKdiAJPwr9edACAh123VXDWoUEGHhib753ijtawAF76uFHK8/2+WwaCJ7UvWwPHk+4Zv7q8PNmnlFyWmIZMbFdxJfAVarazvszThz8m9GCenNAtQa+PBRADcR2VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567352; c=relaxed/simple;
	bh=RKxUSbx478VgenYvihB5XbO2huMG84DHYLr6jtnYvTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6wzPNVuK4j1BqQxXkWnGxuT8x6aRCFc7UeyaVCEYMeelTuUBlBvjuic+hWNa5wOegTQvdpZHpZoAbATxHjDPXIR8X6wI9xbPeEWzJgO4ynsQWOelf5BftO8nOWzVMsOnQfr63dTCyOLmT+IZBWRZYQL24cxMWH6S1rJOw0wK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPW3M3Pghz4f3kw1;
	Thu, 10 Oct 2024 21:35:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1EF141A08FC;
	Thu, 10 Oct 2024 21:35:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYc2AdnDRnZDg--.21356S14;
	Thu, 10 Oct 2024 21:35:44 +0800 (CST)
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
Subject: [PATCH v3 10/10] ext4: move out common parts into ext4_fallocate()
Date: Thu, 10 Oct 2024 21:33:33 +0800
Message-Id: <20241010133333.146793-11-yi.zhang@huawei.com>
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
X-CM-TRANSID:gCh0CgCXysYc2AdnDRnZDg--.21356S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1DCF1rGrWfKF4kZry8Grg_yoWfuw47pF
	W5JrW5tFyxWFykWr4rAanrZF13twnFgrWUWrWxu34vvasIywnFka1YkFyFqFW3trW8Zr4j
	vF4jvr9rGFW7Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
	LUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Currently, all zeroing ranges, punch holes, collapse ranges, and insert
ranges first wait for all existing direct I/O workers to complete, and
then they acquire the mapping's invalidate lock before performing the
actual work. These common components are nearly identical, so we can
simplify the code by factoring them out into the ext4_fallocate().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 121 ++++++++++++++++------------------------------
 fs/ext4/inode.c   |  23 +--------
 2 files changed, 43 insertions(+), 101 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a2db4e85790f..d5067d5aa449 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4587,23 +4587,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
 	/*
 	 * For journalled data we need to write (and checkpoint) pages before
 	 * discarding page cache to avoid inconsitent data on disk in case of
@@ -4616,7 +4599,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ext4_truncate_folios_range(inode, offset, end);
 	}
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages */
 	truncate_pagecache_range(inode, offset, end - 1);
@@ -4630,7 +4613,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 
 	/* Zero range excluding the unaligned edges */
@@ -4643,11 +4626,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
 					     new_size, flags);
 		if (ret)
-			goto out_invalidate_lock;
+			return ret;
 	}
 	/* Finish zeroing out if it doesn't contain partial block */
 	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
-		goto out_invalidate_lock;
+		return ret;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4660,7 +4643,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	/* Zero out partial block at the edges of the range */
@@ -4680,8 +4663,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -4714,13 +4695,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
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
@@ -4745,6 +4719,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	int ret;
 
 	/*
@@ -4768,6 +4743,29 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+
+	ret = file_modified(file);
+	if (ret)
+		return ret;
+
+	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
+		ret = ext4_do_fallocate(file, offset, len, mode);
+		goto out;
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
@@ -4777,7 +4775,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	else if (mode & FALLOC_FL_ZERO_RANGE)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
-		ret = ext4_do_fallocate(file, offset, len, mode);
+		ret = -EOPNOTSUPP;
+
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
 out:
 	inode_unlock(inode);
 	return ret;
@@ -5304,23 +5305,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5334,16 +5318,15 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5382,8 +5365,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
@@ -5424,23 +5405,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5448,16 +5412,15 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5528,8 +5491,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bea19cd6e676..1ccf84a64b7b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3992,23 +3992,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
-
 	/*
 	 * For journalled data we need to write (and checkpoint) pages
 	 * before discarding page cache to avoid inconsitent data on
@@ -4021,7 +4004,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ext4_truncate_folios_range(inode, offset, end);
 	}
 	if (ret)
-		goto out_invalidate_lock;
+		return ret;
 
 	/* Now release the pages and zero block aligned part of pages*/
 	truncate_pagecache_range(inode, offset, end - 1);
@@ -4034,7 +4017,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(sb, ret);
-		goto out_invalidate_lock;
+		return ret;
 	}
 
 	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
@@ -4079,8 +4062,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ext4_handle_sync(handle);
 out_handle:
 	ext4_journal_stop(handle);
-out_invalidate_lock:
-	filemap_invalidate_unlock(mapping);
 	return ret;
 }
 
-- 
2.39.2


