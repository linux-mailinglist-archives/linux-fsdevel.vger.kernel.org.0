Return-Path: <linux-fsdevel+bounces-32561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D529A96BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9806285487
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C171C9EBA;
	Tue, 22 Oct 2024 03:13:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFB1487D1;
	Tue, 22 Oct 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566785; cv=none; b=i9sHGMGsF37YTirdUIx1bCVRkW/swwWH1eyWR4eRgP0szwgiX8CdabHWbjFYXz2v3WrqAqWpW4VWvZ+xUl915z5gFiwGRNE0Q+aaDJ+jQnyV0skXF3ULjZRnztrsp8tFrOHflgAXMpvr5MJMwKQAwFcOK+klVTBnKSx9sGqCJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566785; c=relaxed/simple;
	bh=QSoSH/PS71Cm1qttsP1bNXGF+E8W1iWagKD5oA18EkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUR3S9OxcAZVzp125lQEv9JGEyUVNt97irLCk9AeGBWlaM6hvUAPAdX59vuWBT5Y0URhGpWIXrnKyQG4Wn/BMlSslHSHH11lWjj878EE8uxPtQ6v7ddGORAx3Ejl9451gt98MW6J6U0kPI1CArbeZWFATYrlsn15hLIXMLIrLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcg73Vqkz4f3lVx;
	Tue, 22 Oct 2024 11:12:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A5F681A0359;
	Tue, 22 Oct 2024 11:12:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S11;
	Tue, 22 Oct 2024 11:12:53 +0800 (CST)
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
Subject: [PATCH 07/27] ext4: refactor ext4_insert_range()
Date: Tue, 22 Oct 2024 19:10:38 +0800
Message-ID: <20241022111059.2566137-8-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S11
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUCF13Wr1UJw45uryDWrg_yoWxAr48pr
	ZxWry5GrWFqa4v9rW8KF4DZF18K3WkG3y7GryxGrn3Xa4jvr9rK3WYkFyYgFy8KrWkZrWY
	vF4Fk345Way2ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Simplify ext4_insert_range() and align its code style with that of
ext4_collapse_range(). Refactor it by: a) renaming variables, b)
removing redundant input parameter checks and moving the remaining
checks under i_rwsem in preparation for future refactoring, and c)
renaming the three stale error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 101 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a4e95f3b5f09..4e35c2415e9b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5428,45 +5428,37 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5474,7 +5466,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5484,25 +5476,24 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
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
 
@@ -5511,16 +5502,19 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5530,16 +5524,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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
@@ -5548,31 +5542,32 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
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


