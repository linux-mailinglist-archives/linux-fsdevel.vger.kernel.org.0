Return-Path: <linux-fsdevel+bounces-32558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995FE9A96B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FDD285969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F81C578B;
	Tue, 22 Oct 2024 03:13:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C31487E9;
	Tue, 22 Oct 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566784; cv=none; b=JHuU9eUpzyMq0OfXDwME50+AvNyimXEsVUc+bRLWG6WkN50cn7Lz/4iimgfKtI6hDjEqCpX3mLs12WdwwpsrqDU6+XQkEo96feYjlZO4cbiKrRCg4e76Srp3rVo4xgwIG6jP5kjzSoUrhv58HXqMMKhlc1VaxpSvZxL6QzuWDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566784; c=relaxed/simple;
	bh=3kLoIhWBgWrbTJmEHk0gx9jhaeHoiNhK86cFpt3kCaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXJ6i7o7mKGXUoz6SYxfuHtGyB7N3OFKC+97eyd5Rs8pR6bk1EuDFxVEzjGUCbu9Lu45y0aL8i3Es0T15dQ0E/MTb3iY/hNit9PmwxfOC7NlcXOxGDiHzD+N6sfuhX+XJ8DhXrB7cDXl7BLdIEFk8ZyLr+1lpR0QW/XZS7mj/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg9330xz4f3lW6;
	Tue, 22 Oct 2024 11:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 943CB1A0568;
	Tue, 22 Oct 2024 11:12:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S14;
	Tue, 22 Oct 2024 11:12:55 +0800 (CST)
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
Subject: [PATCH 10/27] ext4: move out common parts into ext4_fallocate()
Date: Tue, 22 Oct 2024 19:10:41 +0800
Message-ID: <20241022111059.2566137-11-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1DCF1rGrWfKF4kZry8Grg_yoWftryfpF
	W5JrW5tFyxWFykWr4rAanrZF13twnFgrWUWrWxu34vvasIywnFka1YkFyFqFW3trW8Zr4j
	vF4jvr9rGFW7Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

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
2.46.1


