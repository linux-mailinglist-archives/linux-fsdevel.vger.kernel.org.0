Return-Path: <linux-fsdevel+bounces-27989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB79658D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76382867BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522916DC3D;
	Fri, 30 Aug 2024 07:39:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CF15748B;
	Fri, 30 Aug 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003578; cv=none; b=uy/qOHBXuPAr7X0oUi2DBjPSDn+FiLZIHp080xC+f6xpJ+uNvpslnbMRbg0U0VewazVbIlw8bRjsD1a9qnWABvgKIbeDlkvUhiJTLUAP5f6W/rfgb74yFbZVDWWWZfQVF2F+NSSh4N1DG+3bzRcDCI4a8ImAuR5xx5JXPRruD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003578; c=relaxed/simple;
	bh=qEfM1X3QBNYsOY1ZGHIWKei6u1TpAxD95wKcxl40ANU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCqG3rsoJs0qZIiAtOGgF9F+aYOk0JNhFdaCPWRlbz5okGrll0bDMMFY+WRT2EvbGmcZHQcen09OwjkyFysPuVxlwvLX7yArp3fpHIeCRb8ux0HEbnKnxbFGJhqOzf0qDwhlMdPuhlAoj1hEgP4waGZQKwz0bdwMEaax7VQV724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww95Q6vPCz4f3jt8;
	Fri, 30 Aug 2024 15:39:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 071B01A07BA;
	Fri, 30 Aug 2024 15:39:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4Uhd9FmXb5_DA--.51707S10;
	Fri, 30 Aug 2024 15:39:32 +0800 (CST)
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
Subject: [PATCH 06/10] ext4: refactor ext4_collapse_range()
Date: Fri, 30 Aug 2024 15:37:56 +0800
Message-Id: <20240830073800.2131781-7-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4Uhd9FmXb5_DA--.51707S10
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy3Zw4rKF1rtw4fXFy5Jwb_yoW7Ww1DpF
	W3Wry5Gr10ga4kWr4xtF4DZF10y3WkWrW8WryxGrnYqa4qyrnrKF4YyFyF9FWjqrWkZFWj
	vF40y34UWrW7C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Simplify ext4_collapse_range() and make the code style the same as
ext4_zero_range() and ext4_punch_hole(), refactor it by a) rename
variables, b) drop redundant input parameters checking, move others to
under i_rwsem, preparing for later refactor, c) rename the three stale
error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2fb0c2e303c7..5c0b4d512531 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5265,43 +5265,35 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
-	ext4_lblk_t punch_start, punch_stop;
+	ext4_lblk_t start_lblk, end_lblk;
 	handle_t *handle;
 	unsigned int credits;
-	loff_t new_size, ioffset;
+	loff_t start, new_size;
 	int ret;
 
-	/*
-	 * We need to test this early because xfstests assumes that a
-	 * collapse range of (0, 1) will return EOPNOTSUPP if the file
-	 * system does not support collapse range.
-	 */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		return -EOPNOTSUPP;
+	trace_ext4_collapse_range(inode, offset, len);
 
-	/* Collapse range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
-		return -EINVAL;
+	inode_lock(inode);
 
-	trace_ext4_collapse_range(inode, offset, len);
+	/* Currently just for extent based files */
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
-	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
-	punch_stop = (offset + len) >> EXT4_BLOCK_SIZE_BITS(sb);
+	/* Collapse range works only on fs cluster size aligned regions. */
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	inode_lock(inode);
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
 	 */
 	if (offset + len >= inode->i_size) {
 		ret = -EINVAL;
-		goto out_mutex;
-	}
-
-	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out_mutex;
+		goto out;
 	}
 
 	/* Wait for existing dio to complete */
@@ -5309,7 +5301,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5319,43 +5311,46 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_mmap;
+		goto out_invalidate_lock;
 
 	/*
 	 * Need to round down offset to be aligned with page size boundary
 	 * for page size > block size.
 	 */
-	ioffset = round_down(offset, PAGE_SIZE);
+	start = round_down(offset, PAGE_SIZE);
 	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(mapping, ioffset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
 	if (ret)
-		goto out_mmap;
-	truncate_pagecache(inode, ioffset);
+		goto out_invalidate_lock;
+	truncate_pagecache(inode, start);
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		goto out_mmap;
+		goto out_invalidate_lock;
 	}
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
+	start_lblk = offset >> inode->i_blkbits;
+	end_lblk = (offset + len) >> inode->i_blkbits;
+
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ext4_discard_preallocations(inode);
-	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
+	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
 
-	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
+	ret = ext4_ext_remove_space(inode, start_lblk, end_lblk - 1);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
+		goto out_handle;
 	}
 	ext4_discard_preallocations(inode);
 
-	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
-				     punch_stop - punch_start, SHIFT_LEFT);
+	ret = ext4_ext_shift_extents(inode, handle, end_lblk,
+				     end_lblk - start_lblk, SHIFT_LEFT);
 	if (ret) {
 		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
+		goto out_handle;
 	}
 
 	new_size = inode->i_size - len;
@@ -5363,16 +5358,19 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	EXT4_I(inode)->i_disksize = new_size;
 
 	up_write(&EXT4_I(inode)->i_data_sem);
-	if (IS_SYNC(inode))
-		ext4_handle_sync(handle);
 	ret = ext4_mark_inode_dirty(handle, inode);
+	if (ret)
+		goto out_handle;
+
 	ext4_update_inode_fsync_trans(handle, inode, 1);
+	if (IS_SYNC(inode))
+		ext4_handle_sync(handle);
 
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
2.39.2


