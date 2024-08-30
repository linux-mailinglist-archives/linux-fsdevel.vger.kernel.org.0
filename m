Return-Path: <linux-fsdevel+bounces-27986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A769658C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D635AB2528B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E233167DA4;
	Fri, 30 Aug 2024 07:39:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B456440;
	Fri, 30 Aug 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003577; cv=none; b=C3w4gQBw2lRjQ9N3PA7g4yLY0NFUafL8cybOlBUlChHySLO4ewDu0CoEtmAcGb0WWPglitvNgq8zvEwl28qBsBIvAITtIj4wMT7C29VIv3oYkb7ona3VYLq8ygLzEH822iNqfGsm07/gNF+1qHxYUHdYpR7rMZVT6oFdnIbRYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003577; c=relaxed/simple;
	bh=z4QA3LckWGbWewOWtpYmgJwdqog5qFmuMHyODofGZqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAzr80bTrkkKmJIubYmWKMKvo8BEXeh1Uu8tBk1zq8oO3/5sAR0kJkr8B4LHz1Uyab9LBvGo7vr6uP8f7HGYmXre4BF+i8SpZxMnuP520jOrkBJHX3h9bYWQvXOcN7KblDBQ/BZgkYoiVYFrZ/C+BX3/fVyLSXS57fZAxulyq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww95H0lP0z4f3lVv;
	Fri, 30 Aug 2024 15:39:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A69751A1DA3;
	Fri, 30 Aug 2024 15:39:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4Uhd9FmXb5_DA--.51707S5;
	Fri, 30 Aug 2024 15:39:30 +0800 (CST)
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
Subject: [PATCH 01/10] ext4: write out dirty data before dropping pages
Date: Fri, 30 Aug 2024 15:37:51 +0800
Message-Id: <20240830073800.2131781-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4Uhd9FmXb5_DA--.51707S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKryxCFyruryDGr13Cry3urg_yoWxJrW8pr
	W3trW3tr4xXayDWr4FyanrZF18K3s2gFWUuFyfGa40va4qywnrKa1YkFy8WFWUJFZrArW5
	XF4jq34xGrWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUTT5JUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Current zero range, punch hole and collapse range have a common
potential data loss problem. In general, ext4_zero_range(),
ext4_collapse_range() and ext4_punch_hold() will discard all page cache
of the operation range before converting the extents status. However,
the first two functions don't write back dirty data before discarding
page cache, and ext4_punch_hold() write back at the very beginning
without holding i_rwsem and mapping invalidate lock. Hence, if some bad
things (e.g. EIO or ENOMEM) happens just after dropping dirty page
cache, the operation will failed but the user's valid data in the dirty
page cache will be lost. Fix this by write all dirty data under i_rwsem
and mapping invalidate lock before discarding pages.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 77 +++++++++++++++++------------------------------
 fs/ext4/inode.c   | 19 +++++-------
 2 files changed, 36 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..7d5edfa2e630 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4602,6 +4602,24 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (ret)
 		goto out_mutex;
 
+	/*
+	 * Prevent page faults from reinstantiating pages we have released
+	 * from page cache.
+	 */
+	filemap_invalidate_lock(mapping);
+
+	ret = ext4_break_layouts(inode);
+	if (ret)
+		goto out_invalidate_lock;
+
+	/*
+	 * Write data that will be zeroed to preserve them when successfully
+	 * discarding page cache below but fail to convert extents.
+	 */
+	ret = filemap_write_and_wait_range(mapping, start, end - 1);
+	if (ret)
+		goto out_invalidate_lock;
+
 	/* Preallocate the range including the unaligned edges */
 	if (partial_begin || partial_end) {
 		ret = ext4_alloc_file_blocks(file,
@@ -4610,7 +4628,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 				 round_down(offset, 1 << blkbits)) >> blkbits,
 				new_size, flags);
 		if (ret)
-			goto out_mutex;
+			goto out_invalidate_lock;
 
 	}
 
@@ -4619,37 +4637,9 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
 			  EXT4_EX_NOCACHE);
 
-		/*
-		 * Prevent page faults from reinstantiating pages we have
-		 * released from page cache.
-		 */
-		filemap_invalidate_lock(mapping);
-
-		ret = ext4_break_layouts(inode);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
-
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
-		if (ret) {
-			filemap_invalidate_unlock(mapping);
-			goto out_mutex;
-		}
-
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
+		if (ret)
+			goto out_invalidate_lock;
 
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
@@ -4657,12 +4647,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
-		filemap_invalidate_unlock(mapping);
 		if (ret)
-			goto out_mutex;
+			goto out_invalidate_lock;
 	}
 	if (!partial_begin && !partial_end)
-		goto out_mutex;
+		goto out_invalidate_lock;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4675,7 +4664,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_mutex;
+		goto out_invalidate_lock;
 	}
 
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
@@ -4694,6 +4683,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 out_handle:
 	ext4_journal_stop(handle);
+out_invalidate_lock:
+	filemap_invalidate_unlock(mapping);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5363,20 +5354,8 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	 * for page size > block size.
 	 */
 	ioffset = round_down(offset, PAGE_SIZE);
-	/*
-	 * Write tail of the last page before removed range since it will get
-	 * removed from the page cache below.
-	 */
-	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
-	if (ret)
-		goto out_mmap;
-	/*
-	 * Write data that will be shifted to preserve them when discarding
-	 * page cache below. We are also protected from pages becoming dirty
-	 * by i_rwsem and invalidate_lock.
-	 */
-	ret = filemap_write_and_wait_range(mapping, offset + len,
-					   LLONG_MAX);
+	/* Write out all dirty pages */
+	ret = filemap_write_and_wait_range(mapping, ioffset, LLONG_MAX);
 	if (ret)
 		goto out_mmap;
 	truncate_pagecache(inode, ioffset);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..c3d7606a5315 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3957,17 +3957,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
-	/*
-	 * Write out all dirty pages to avoid race conditions
-	 * Then release them.
-	 */
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
-		ret = filemap_write_and_wait_range(mapping, offset,
-						   offset + length - 1);
-		if (ret)
-			return ret;
-	}
-
 	inode_lock(inode);
 
 	/* No need to punch hole beyond i_size */
@@ -4021,6 +4010,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (ret)
 		goto out_dio;
 
+	/* Write out all dirty pages to avoid race conditions */
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
+		ret = filemap_write_and_wait_range(mapping, offset,
+						   offset + length - 1);
+		if (ret)
+			goto out_dio;
+	}
+
 	first_block_offset = round_up(offset, sb->s_blocksize);
 	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
 
-- 
2.39.2


