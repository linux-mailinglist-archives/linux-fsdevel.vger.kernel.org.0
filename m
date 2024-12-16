Return-Path: <linux-fsdevel+bounces-37459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72B9F2819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6567A166310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDD1D278A;
	Mon, 16 Dec 2024 01:42:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACC1885AD;
	Mon, 16 Dec 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313368; cv=none; b=l/9wRNpNlxvDMmAqn05MDO3lgOYTU1OLIUsWtLs6LEQ5LLt75PbVtOzu3r8rvOY58zMVwhGHL/gs2N6ImZ2r7eDBbrnvE/aYVQ7IkzJuK32Ye2IS4hsKPfsTZremGpbnStZ/w8XOaTGjewoGuiLjJWILggeuh93NZ1zq3SFqll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313368; c=relaxed/simple;
	bh=cBRyU9QJFh6T9FSuRiJEAFE1pFRvHEFqQJSeIQk9fpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPJM1Hxzqze3wPVmMOeuS11FV126cXQ4RAQwkSpgcgDDYtE819vRrEefGBdZLVRbAjZWXxpXhYWv9bZLkHrPj3ofqF7pUdSQ+OP9166pohYqvwgybECwfvmQbEv39U2dnmipXLuxwSadrRKFelr2bJi42vVbKKzYTG0WizJAmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBN3X3bSqz4f3kFm;
	Mon, 16 Dec 2024 09:42:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E33F51A058E;
	Mon, 16 Dec 2024 09:42:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4d5hV9nYi3kEg--.4387S10;
	Mon, 16 Dec 2024 09:42:35 +0800 (CST)
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
Subject: [PATCH v4 06/10] ext4: refactor ext4_collapse_range()
Date: Mon, 16 Dec 2024 09:39:11 +0800
Message-ID: <20241216013915.3392419-7-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHY4d5hV9nYi3kEg--.4387S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry8KryxGr4fWrW5Kw18uFg_yoWxJF4UpF
	ZxWry5Kr10ga4kWr48tF4DZF18t3Wvg3yUW3yxGr9Yq3WqyrnrKa4YyFWFgFW8trWkZFWj
	qF40v34UWrW7Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Simplify ext4_collapse_range() and align its code style with that of
ext4_zero_range() and ext4_punch_hole(). Refactor it by: a) renaming
variables, b) removing redundant input parameter checks and moving
the remaining checks under i_rwsem in preparation for future
refactoring, and c) renaming the three stale error tags.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 103 +++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 97ad6fea58d3..8a0a720803a8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5292,43 +5292,36 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct address_space *mapping = inode->i_mapping;
-	ext4_lblk_t punch_start, punch_stop;
+	loff_t end = offset + len;
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
-	if (offset + len >= inode->i_size) {
+	if (end >= inode->i_size) {
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
@@ -5336,7 +5329,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out_mutex;
+		goto out;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5346,55 +5339,52 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	ret = ext4_break_layouts(inode);
 	if (ret)
-		goto out_mmap;
+		goto out_invalidate_lock;
 
 	/*
+	 * Write tail of the last page before removed range and data that
+	 * will be shifted since they will get removed from the page cache
+	 * below. We are also protected from pages becoming dirty by
+	 * i_rwsem and invalidate_lock.
 	 * Need to round down offset to be aligned with page size boundary
 	 * for page size > block size.
 	 */
-	ioffset = round_down(offset, PAGE_SIZE);
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
+	start = round_down(offset, PAGE_SIZE);
+	ret = filemap_write_and_wait_range(mapping, start, offset);
+	if (!ret)
+		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
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
@@ -5402,16 +5392,19 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
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
2.46.1


