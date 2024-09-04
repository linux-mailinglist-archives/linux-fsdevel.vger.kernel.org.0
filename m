Return-Path: <linux-fsdevel+bounces-28490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0296B1B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B591C25273
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C11465BF;
	Wed,  4 Sep 2024 06:31:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC613C3E4;
	Wed,  4 Sep 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431480; cv=none; b=fFAsE+UkZLxVCoSesLCWFA+P9T/dRYxKxdl65FeUsIsPW74JOYnXp8Rpyp3+04mm0gzMNx3xQJs/dgxfDB+hEZtfXDDuynAE5clGTXGSsj8vmFpxG3fwMIwbyGTUtVJ9SktykL7OlKcPkYuloi3QRsDmn5l2bvqJSPRCRs8Gaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431480; c=relaxed/simple;
	bh=/5jcPMouCUYVUMVhTO23SY4BZr/Fyg2XzW2J9e/qYz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNpQwpi8QDusE1CrlqiuQrU/cBjsn7l1T2XX2/u7pQov6d+NpbvRQS/J/oLhZmRm0g0MA/0d+cDLFEK+FAhqQuXEFq/oeMCBPzI9Tkmg5nw55cHEy7he3EiV91cMFaiLxwSv+0DxOxVkZjiWIXMMyIk6G08ZpjE5vY6gmCHNOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzCLB5BKGz4f3jHx;
	Wed,  4 Sep 2024 14:30:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F3D21A12FF;
	Wed,  4 Sep 2024 14:31:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMif_tdmjKtlAQ--.29879S14;
	Wed, 04 Sep 2024 14:31:14 +0800 (CST)
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
Subject: [PATCH v2 10/10] ext4: factor out a common helper to lock and flush data before fallocate
Date: Wed,  4 Sep 2024 14:29:25 +0800
Message-Id: <20240904062925.716856-11-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAnXMif_tdmjKtlAQ--.29879S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww47ZF1fGF1Dtr17KFW3ZFb_yoW3Wr1DpF
	ZxGryrKrW8Xa48ur4rAanrZr1rKa97KrWxZryxGw10v343J3sFka1YyF18XFy5trW8Zr45
	ZF4jvry7CF47uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now the beginning of the first four functions in ext4_fallocate() (punch
hole, zero range, insert range and collapse range) are almost the same,
they need to wait for the dio to finish, get filemap invalidate lock,
write back dirty data and finally drop page cache. Factor out a common
helper to do these work can reduce a lot of the redundant code.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |   2 +
 fs/ext4/extents.c | 125 ++++++++++++++++++++--------------------------
 fs/ext4/inode.c   |  25 +---------
 3 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e8d7965f62c4..281fab9abc42 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3696,6 +3696,8 @@ extern int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				 ext4_lblk_t end);
 extern void ext4_ext_init(struct super_block *);
 extern void ext4_ext_release(struct super_block *);
+extern int ext4_prepare_falloc(struct file *file, loff_t start, loff_t end,
+			       int mode);
 extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 91e509201915..eee63e92dcc6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4558,34 +4558,10 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
+	ret = ext4_prepare_falloc(file, offset, end - 1, FALLOC_FL_ZERO_RANGE);
 	if (ret)
 		return ret;
 
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
-	/*
-	 * Write data that will be zeroed to preserve them when successfully
-	 * discarding page cache below but fail to convert extents.
-	 */
-	ret = filemap_write_and_wait_range(mapping, offset, end - 1);
-	if (ret)
-		goto out_invalidate_lock;
-
-	/* Now release the pages and zero block aligned part of pages */
-	truncate_pagecache_range(inode, offset, end - 1);
-
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 	/* Preallocate the range including the unaligned edges */
 	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
@@ -4731,6 +4707,52 @@ static int ext4_fallocate_check(struct inode *inode, int mode,
 	return 0;
 }
 
+int ext4_prepare_falloc(struct file *file, loff_t start, loff_t end, int mode)
+{
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = inode->i_mapping;
+	int ret;
+
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+	ret = file_modified(file);
+	if (ret)
+		return ret;
+
+	/*
+	 * Prevent page faults from reinstantiating pages we have released
+	 * from page cache.
+	 */
+	filemap_invalidate_lock(mapping);
+
+	ret = ext4_break_layouts(inode);
+	if (ret)
+		goto failed;
+
+	/*
+	 * Write data that will be zeroed to preserve them when successfully
+	 * discarding page cache below but fail to convert extents.
+	 */
+	ret = filemap_write_and_wait_range(mapping, start, end);
+	if (ret)
+		goto failed;
+
+	/*
+	 * For insert range and collapse range, COWed private pages should
+	 * be removed since the file's logical offset will be changed, but
+	 * punch hole and zero range doesn't.
+	 */
+	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE))
+		truncate_pagecache(inode, start);
+	else
+		truncate_pagecache_range(inode, start, end);
+
+	return 0;
+failed:
+	filemap_invalidate_unlock(mapping);
+	return ret;
+}
+
 /*
  * preallocate space for a file. This implements ext4's fallocate file
  * operation, which gets called from sys_fallocate system call.
@@ -5284,39 +5306,20 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_lblk_t start_lblk, end_lblk;
 	handle_t *handle;
 	unsigned int credits;
-	loff_t start, new_size;
+	loff_t new_size;
 	int ret;
 
 	trace_ext4_collapse_range(inode, offset, len);
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
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
 	 * Need to round down offset to be aligned with page size boundary
 	 * for page size > block size.
 	 */
-	start = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
+	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
+				  LLONG_MAX, FALLOC_FL_COLLAPSE_RANGE);
 	if (ret)
-		goto out_invalidate_lock;
-	truncate_pagecache(inode, start);
+		return ret;
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
@@ -5386,38 +5389,18 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
 	unsigned int credits, ee_len;
 	int ret, depth, split_flag = 0;
-	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
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
 	 * Need to round down to align start offset to page size boundary
 	 * for page size > block size.
 	 */
-	start = round_down(offset, PAGE_SIZE);
-	/* Write out all dirty pages */
-	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
+	ret = ext4_prepare_falloc(file, round_down(offset, PAGE_SIZE),
+				  LLONG_MAX, FALLOC_FL_INSERT_RANGE);
 	if (ret)
-		goto out_invalidate_lock;
-	truncate_pagecache(inode, start);
+		return ret;
 
 	credits = ext4_writepage_trans_blocks(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 57636c656fa5..4b7f8fcaa5c2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3953,33 +3953,10 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 			return ret;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
+	ret = ext4_prepare_falloc(file, offset, end - 1, FALLOC_FL_PUNCH_HOLE);
 	if (ret)
 		return ret;
 
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
-	/* Write out all dirty pages to avoid race conditions */
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
-		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
-		if (ret)
-			goto out_invalidate_lock;
-	}
-
-	/* Now release the pages and zero block aligned part of pages*/
-	truncate_pagecache_range(inode, offset, end - 1);
-
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
 	else
-- 
2.39.2


