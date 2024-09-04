Return-Path: <linux-fsdevel+bounces-28486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814A96B1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D681F27077
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0E13E3F6;
	Wed,  4 Sep 2024 06:31:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F180C0C;
	Wed,  4 Sep 2024 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431478; cv=none; b=SmvAz5DSOauObBfeujpDtlbHIRZk9uG3Mvdm+3dCixW0CKGnBPvNZRDo3PN6K7vJUDQAq3EViBhLx74pZPbH6Istt6tbQW34aOEODt0jA2UMM72nr7SFQFjJUrd59D75NTZfSkoNz9RyYdckDN+e7QGwvvEA/PrH8KuFXB1Bqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431478; c=relaxed/simple;
	bh=WfyNaOHMJkqYaHZkrkEufuBjtBjiCHa2OP4gaZq+wGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToCShUcAnD6udhlR5PNaWAqXPr8/DxZLIypNSiqa4N4ScJzmwm5Gf1S7uyy3ZkVnd+soOhx7FbToXdA9CdxeY7n9OtsQyU45/a7LcY63XdaLbB0UI1RYYpryjlT96ZO7t85zvOtZqFMySx8Q16XjCQUTFyDmFMgDuB9KOOVdCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzCL73Ps4z4f3jJB;
	Wed,  4 Sep 2024 14:30:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5153E1A07B6;
	Wed,  4 Sep 2024 14:31:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMif_tdmjKtlAQ--.29879S7;
	Wed, 04 Sep 2024 14:31:11 +0800 (CST)
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
Subject: [PATCH v2 03/10] ext4: drop ext4_update_disksize_before_punch()
Date: Wed,  4 Sep 2024 14:29:18 +0800
Message-Id: <20240904062925.716856-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMif_tdmjKtlAQ--.29879S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1ktr13Gry7XFyUXr1rCrg_yoW5tF1Dp3
	sxGFyxKr4rWa4DuF4IgrnrZr4Fy3ZrC3yUXrWrCr1Iqa47Zw4IgF1jyF1F9FW5trZ5Ar4j
	vF45tr4UXr1UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	vjDU0xZFpf9x0JUCg4hUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we always write back dirty data before zeroing range and punching
hole, the delalloc extended file's disksize of should be updated
properly when writing back pages, hence we don't need to update file's
disksize before discarding page cache in ext4_zero_range() and
ext4_punch_hole(), just drop ext4_update_disksize_before_punch().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  3 ---
 fs/ext4/extents.c |  4 ----
 fs/ext4/inode.c   | 37 +------------------------------------
 3 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261e..e8d7965f62c4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3414,9 +3414,6 @@ static inline int ext4_update_inode_size(struct inode *inode, loff_t newsize)
 	return changed;
 }
 
-int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
-				      loff_t len);
-
 struct ext4_group_info {
 	unsigned long   bb_state;
 #ifdef AGGRESSIVE_CHECK
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 19a9b14935b7..d9fccf2970e9 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4637,10 +4637,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
 			  EXT4_EX_NOCACHE);
 
-		ret = ext4_update_disksize_before_punch(inode, offset, len);
-		if (ret)
-			goto out_invalidate_lock;
-
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8af25442d44d..9343ce9f2b01 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3872,37 +3872,6 @@ int ext4_can_truncate(struct inode *inode)
 	return 0;
 }
 
-/*
- * We have to make sure i_disksize gets properly updated before we truncate
- * page cache due to hole punching or zero range. Otherwise i_disksize update
- * can get lost as it may have been postponed to submission of writeback but
- * that will never happen after we truncate page cache.
- */
-int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
-				      loff_t len)
-{
-	handle_t *handle;
-	int ret;
-
-	loff_t size = i_size_read(inode);
-
-	WARN_ON(!inode_is_locked(inode));
-	if (offset > size || offset + len < size)
-		return 0;
-
-	if (EXT4_I(inode)->i_disksize >= size)
-		return 0;
-
-	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
-	ext4_update_i_disksize(inode, size);
-	ret = ext4_mark_inode_dirty(handle, inode);
-	ext4_journal_stop(handle);
-
-	return ret;
-}
-
 static void ext4_wait_dax_page(struct inode *inode)
 {
 	filemap_invalidate_unlock(inode->i_mapping);
@@ -4022,13 +3991,9 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
 
 	/* Now release the pages and zero block aligned part of pages*/
-	if (last_block_offset > first_block_offset) {
-		ret = ext4_update_disksize_before_punch(inode, offset, length);
-		if (ret)
-			goto out_dio;
+	if (last_block_offset > first_block_offset)
 		truncate_pagecache_range(inode, first_block_offset,
 					 last_block_offset);
-	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
-- 
2.39.2


