Return-Path: <linux-fsdevel+bounces-37893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CE9F8943
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 02:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C7916755C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA048635A;
	Fri, 20 Dec 2024 01:20:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895F175A5;
	Fri, 20 Dec 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657617; cv=none; b=LMS+tGVHmq0W/aQ9kiY2xA3+lphAkt1cu4sjPiq9uaiKCf9Co2AkoSLp7qtJISir9skwqgDU0JU1JWO8RMv9maaIOPqUkGp4N5vxBnTq7GU+FGAc/UiuI24DYOrUj/qANGg/ZrWjUVQ2N05287IWe2XJAGd/YCvNOwb8uZOaZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657617; c=relaxed/simple;
	bh=pcIlf0IgS3ZMFCn8mWka2OLto4H+UiDPQ87GYmCmiYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoXHF++YtIX41/3nYBhRY4xjffbjO0VwXQXrctA5NUJjLQmORbNtJkzQ1I2xjuv1hC45L5EPdtcMDcuhQtIUqNerJrbxAgFfg8dMN6HyTfJYrIWiWaEFOSiPM9UyRYFUYJForLFFKgEZM9BuTrG3Yl7yUR81FcoFpo/b/eQFzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDqMq24Ncz4f3l24;
	Fri, 20 Dec 2024 09:19:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D3C0F1A0194;
	Fri, 20 Dec 2024 09:20:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoI6xmRnETtfFA--.47090S11;
	Fri, 20 Dec 2024 09:20:11 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 07/10] ext4: refactor ext4_insert_range()
Date: Fri, 20 Dec 2024 09:16:34 +0800
Message-ID: <20241220011637.1157197-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
References: <20241220011637.1157197-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoI6xmRnETtfFA--.47090S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry8Ww1fCF4xXFW8Gr43trb_yoWxAw48pr
	ZxWry5GrW0qa4v9rW8KF4DZF18K3WkW3y7WryxGrn3Xa4jvr9rK3WYyFyYgFy8KrWkArWY
	vF4Fy345Way2ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Simplify ext4_insert_range() and align its code style with that of
ext4_collapse_range(). Refactor it by: a) renaming variables, b)
removing redundant input parameter checks and moving the remaining
checks under i_rwsem in preparation for future refactoring, and c)
renaming the three stale error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 101 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8a0a720803a8..be44dd7aacdb 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5425,45 +5425,37 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
-	ext4_lblk_t offset_lblk, len_lblk, ee_start_lblk = 0;
+	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
-	int ret = 0, depth, split_flag = 0;
-	loff_t ioffset;
-
-	/*
-	 * We need to test this early because xfstests assumes that an
-	 * insert range of (0, 1) will return EOPNOTSUPP if the file
-	 * system does not support insert range.
-	 */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		return -EOPNOTSUPP;
-
-	/* Insert range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
-		return -EINVAL;
+	int ret, depth, split_flag = 0;
+	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
 
-	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
-
 	inode_lock(inode);
+
 	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		ret = -EOPNOTSUPP;
-		goto out_mutex;
+		goto out;
 	}
 
-	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out_mutex;
+	/* Insert range works only on fs cluster size aligned regions. */
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Offset must be less than i_size */
 	if (offset >= inode->i_size) {
 		ret = -EINVAL;
-		goto out_mutex;
+		goto out;
+	}
+
+	/* Check whether the maximum file size would be exceeded */
+	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
+		ret = -EFBIG;
+		goto out;
 	}
 
 	/* Wait for existing dio to complete */
@@ -5471,7 +5463,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5481,25 +5473,24 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_mmap;
+		goto out_invalidate_lock;
 
 	/*
-	 * Need to round down to align start offset to page size boundary
-	 * for page size > block size.
+	 * Write out all dirty pages. Need to round down to align start offset
+	 * to page size boundary for page size > block size.
 	 */
-	ioffset = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset,
-			LLONG_MAX);
+	start = round_down(offset, PAGE_SIZE);
+	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_mmap;
-	truncate_pagecache(inode, ioffset);
+		goto out_invalidate_lock;
+
+	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		goto out_mmap;
+		goto out_invalidate_lock;
 	}
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
@@ -5508,16 +5499,19 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	EXT4_I(inode)->i_disksize += len;
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
-		goto out_stop;
+		goto out_handle;
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = len >> inode->i_blkbits;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
 
-	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
+	path = ext4_find_extent(inode, start_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		up_write(&EXT4_I(inode)->i_data_sem);
 		ret = PTR_ERR(path);
-		goto out_stop;
+		goto out_handle;
 	}
 
 	depth = ext_depth(inode);
@@ -5527,16 +5521,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		ee_len = ext4_ext_get_actual_len(extent);
 
 		/*
-		 * If offset_lblk is not the starting block of extent, split
-		 * the extent @offset_lblk
+		 * If start_lblk is not the starting block of extent, split
+		 * the extent @start_lblk
 		 */
-		if ((offset_lblk > ee_start_lblk) &&
-				(offset_lblk < (ee_start_lblk + ee_len))) {
+		if ((start_lblk > ee_start_lblk) &&
+				(start_lblk < (ee_start_lblk + ee_len))) {
 			if (ext4_ext_is_unwritten(extent))
 				split_flag = EXT4_EXT_MARK_UNWRIT1 |
 					EXT4_EXT_MARK_UNWRIT2;
 			path = ext4_split_extent_at(handle, inode, path,
-					offset_lblk, split_flag,
+					start_lblk, split_flag,
 					EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_PRE_IO |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
@@ -5545,31 +5539,32 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		if (IS_ERR(path)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ret = PTR_ERR(path);
-			goto out_stop;
+			goto out_handle;
 		}
 	}
 
 	ext4_free_ext_path(path);
-	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
+	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
 
 	/*
-	 * if offset_lblk lies in a hole which is at start of file, use
+	 * if start_lblk lies in a hole which is at start of file, use
 	 * ee_start_lblk to shift extents
 	 */
 	ret = ext4_ext_shift_extents(inode, handle,
-		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
-
+		max(ee_start_lblk, start_lblk), len_lblk, SHIFT_RIGHT);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	if (ret)
+		goto out_handle;
+
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	if (ret >= 0)
-		ext4_update_inode_fsync_trans(handle, inode, 1);
 
-out_stop:
+out_handle:
 	ext4_journal_stop(handle);
-out_mmap:
+out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out_mutex:
+out:
 	inode_unlock(inode);
 	return ret;
 }
-- 
2.46.1


