Return-Path: <linux-fsdevel+bounces-63876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA2BD125D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53393C1687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8C2F49FE;
	Mon, 13 Oct 2025 01:52:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAED2F1FD6;
	Mon, 13 Oct 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320370; cv=none; b=L7gDchPHE8JXmuMbNZtEaYRUME9x/Z7CIAuU1r6uNadevnRGStWXHPrgvdir9VfYKLXFdsUuFrTNMbZrIcBVnMIqkK2Q4tFx8L8pDOOtqd+qmSiKn4BpG5NZ12BoZmEN9WSunLQYCPlkoOn7jsRq4j/YmQdWUIXSz7t0D47DJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320370; c=relaxed/simple;
	bh=0TCdYGIC4kbIMGTSuIFa4/EzZ7AtsSeMSqB2nFU6Lyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgj4DajN2o4+QY/VpmWvtJvZPU8T604cS0WqSXZMu72gd3TzY1z7RCbTU1PnQt/SINo/TVv1zr4GdhbhwxAdvRxeKWADD8y+O8I4jtSNvRvCRrzroIM+8ZAqGOWNuqR4s/1PPe2zHbkzI1egBeALXSDctT5TQ9TXpQVIKA+kmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clL1s2cD2zYQtn6;
	Mon, 13 Oct 2025 09:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EBB8A1A0F69;
	Mon, 13 Oct 2025 09:52:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UVfW+xoNhu7AA--.53067S11;
	Mon, 13 Oct 2025 09:52:39 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 07/12] ext4: refactor mext_check_arguments()
Date: Mon, 13 Oct 2025 09:51:23 +0800
Message-ID: <20251013015128.499308-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UVfW+xoNhu7AA--.53067S11
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4xGF1fCF17GF4xKr43trb_yoWxKFyUpF
	yxCry5Xw4vqayFg3yvyrsrX34Fk3W7Gr47XrZ7Xw18uFy8Ary2ga4UJa1vqF9xJrWUJ34a
	vF40yrnruw1rJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When moving extents, mext_check_validity() performs some basic file
system and file checks. However, some essential checks need to be
performed after acquiring the i_rwsem are still scattered in
mext_check_arguments(). Move those checks into mext_check_validity() and
make it executes entirely under the i_rwsem to make the checks clearer.
Furthermore, rename mext_check_arguments() to mext_check_adjust_range(),
as it only performs checks and length adjustments on the move extent
range. Finally, also change the print message for the non-existent file
check to be consistent with other unsupported checks.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c | 97 +++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index cdd175d5c1f3..0191a3c746db 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -501,60 +501,36 @@ static int mext_check_validity(struct inode *orig_inode,
 		return -EOPNOTSUPP;
 	}
 
-	return 0;
-}
-
-/**
- * mext_check_arguments - Check whether move extent can be done
- *
- * @orig_inode:		original inode
- * @donor_inode:	donor inode
- * @orig_start:		logical start offset in block for orig
- * @donor_start:	logical start offset in block for donor
- * @len:		the number of blocks to be moved
- *
- * Check the arguments of ext4_move_extents() whether the files can be
- * exchanged with each other.
- * Return 0 on success, or a negative error value on failure.
- */
-static int
-mext_check_arguments(struct inode *orig_inode,
-		     struct inode *donor_inode, __u64 orig_start,
-		     __u64 donor_start, __u64 *len)
-{
-	__u64 orig_eof, donor_eof;
+	/* Ext4 move extent supports only extent based file */
+	if (!(ext4_test_inode_flag(orig_inode, EXT4_INODE_EXTENTS)) ||
+	    !(ext4_test_inode_flag(donor_inode, EXT4_INODE_EXTENTS))) {
+		ext4_msg(sb, KERN_ERR,
+			 "Online defrag not supported for non-extent files");
+		return -EOPNOTSUPP;
+	}
 
 	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
-		ext4_debug("ext4 move extent: suid or sgid is set"
-			   " to donor file [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: suid or sgid is set to donor file [ino:orig %lu, donor %lu]\n",
 			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
-	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
+	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode)) {
+		ext4_debug("ext4 move extent: donor should not be immutable or append file [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EPERM;
+	}
 
 	/* Ext4 move extent does not support swap files */
 	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
 		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -ETXTBSY;
 	}
 
 	if (ext4_is_quota_file(orig_inode) || ext4_is_quota_file(donor_inode)) {
 		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
-		return -EOPNOTSUPP;
-	}
-
-	/* Ext4 move extent supports only extent based file */
-	if (!(ext4_test_inode_flag(orig_inode, EXT4_INODE_EXTENTS))) {
-		ext4_debug("ext4 move extent: orig file is not extents "
-			"based file [ino:orig %lu]\n", orig_inode->i_ino);
-		return -EOPNOTSUPP;
-	} else if (!(ext4_test_inode_flag(donor_inode, EXT4_INODE_EXTENTS))) {
-		ext4_debug("ext4 move extent: donor file is not extents "
-			"based file [ino:donor %lu]\n", donor_inode->i_ino);
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EOPNOTSUPP;
 	}
 
@@ -563,12 +539,25 @@ mext_check_arguments(struct inode *orig_inode,
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+/*
+ * Check the moving range of ext4_move_extents() whether the files can be
+ * exchanged with each other, and adjust the length to fit within the file
+ * size. Return 0 on success, or a negative error value on failure.
+ */
+static int mext_check_adjust_range(struct inode *orig_inode,
+				   struct inode *donor_inode, __u64 orig_start,
+				   __u64 donor_start, __u64 *len)
+{
+	__u64 orig_eof, donor_eof;
+
 	/* Start offset should be same */
 	if ((orig_start & ~(PAGE_MASK >> orig_inode->i_blkbits)) !=
 	    (donor_start & ~(PAGE_MASK >> orig_inode->i_blkbits))) {
-		ext4_debug("ext4 move extent: orig and donor's start "
-			"offsets are not aligned [ino:orig %lu, donor %lu]\n",
-			orig_inode->i_ino, donor_inode->i_ino);
+		ext4_debug("ext4 move extent: orig and donor's start offsets are not aligned [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
@@ -577,9 +566,9 @@ mext_check_arguments(struct inode *orig_inode,
 	    (*len > EXT_MAX_BLOCKS) ||
 	    (donor_start + *len >= EXT_MAX_BLOCKS) ||
 	    (orig_start + *len >= EXT_MAX_BLOCKS))  {
-		ext4_debug("ext4 move extent: Can't handle over [%u] blocks "
-			"[ino:orig %lu, donor %lu]\n", EXT_MAX_BLOCKS,
-			orig_inode->i_ino, donor_inode->i_ino);
+		ext4_debug("ext4 move extent: Can't handle over [%u] blocks [ino:orig %lu, donor %lu]\n",
+			   EXT_MAX_BLOCKS,
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
@@ -594,9 +583,8 @@ mext_check_arguments(struct inode *orig_inode,
 	else if (donor_eof < donor_start + *len - 1)
 		*len = donor_eof - donor_start;
 	if (!*len) {
-		ext4_debug("ext4 move extent: len should not be 0 "
-			"[ino:orig %lu, donor %lu]\n", orig_inode->i_ino,
-			donor_inode->i_ino);
+		ext4_debug("ext4 move extent: len should not be 0 [ino:orig %lu, donor %lu]\n",
+			   orig_inode->i_ino, donor_inode->i_ino);
 		return -EINVAL;
 	}
 
@@ -629,22 +617,22 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	ext4_lblk_t d_start = donor_blk;
 	int ret;
 
-	ret = mext_check_validity(orig_inode, donor_inode);
-	if (ret)
-		return ret;
-
 	/* Protect orig and donor inodes against a truncate */
 	lock_two_nondirectories(orig_inode, donor_inode);
 
+	ret = mext_check_validity(orig_inode, donor_inode);
+	if (ret)
+		goto unlock;
+
 	/* Wait for all existing dio workers */
 	inode_dio_wait(orig_inode);
 	inode_dio_wait(donor_inode);
 
 	/* Protect extent tree against block allocations via delalloc */
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
-	/* Check the filesystem environment whether move_extent can be done */
-	ret = mext_check_arguments(orig_inode, donor_inode, orig_blk,
-				    donor_blk, &len);
+	/* Check and adjust the specified move_extent range. */
+	ret = mext_check_adjust_range(orig_inode, donor_inode, orig_blk,
+				      donor_blk, &len);
 	if (ret)
 		goto out;
 	o_end = o_start + len;
@@ -725,6 +713,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 
 	ext4_free_ext_path(path);
 	ext4_double_up_write_data_sem(orig_inode, donor_inode);
+unlock:
 	unlock_two_nondirectories(orig_inode, donor_inode);
 
 	return ret;
-- 
2.46.1


