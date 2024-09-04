Return-Path: <linux-fsdevel+bounces-28489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC696B1B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63417288234
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118814659C;
	Wed,  4 Sep 2024 06:31:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5ED13B290;
	Wed,  4 Sep 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431480; cv=none; b=PhmuEEwOru7MNBDy0Vp3iuDnNlGYT5LJ8YIsajh78fUIOFmOYZuFG5cUa+qHR+rPS6L6pwtmPDaZAB9TZvZST221EHY3Xd0m9J6uJECLgK76oGgYMUsYD6MnCu6ybg6ayXhdr0NS0e8TXDc+jLYbmykwjfFi/VoviP0TRcOzdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431480; c=relaxed/simple;
	bh=WD4Z9iPQhwGeuPXzwbtlPQ3GhG9x88vvs/cOB/FZ0ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxSpHNRoVGahBHGfXIbx3rzWJqq1yhnanYp1NYnvIfSZqM2R6inKhnKDHfEvXR4uQ36kQhwNTzI0dK5walMT06WBI+VzqSGNJTK+Z1j6mZWfVbWxbNJi9KiZeiP/x2cjOY7Y5FMLejiysRBVa47eBnBzm1veoT7AsPMWz/KKGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzCLH62dxz4f3jkP;
	Wed,  4 Sep 2024 14:31:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1ED8C1A07B6;
	Wed,  4 Sep 2024 14:31:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMif_tdmjKtlAQ--.29879S13;
	Wed, 04 Sep 2024 14:31:13 +0800 (CST)
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
Subject: [PATCH v2 09/10] ext4: factor out the common checking part of all fallocate operations
Date: Wed,  4 Sep 2024 14:29:24 +0800
Message-Id: <20240904062925.716856-10-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAnXMif_tdmjKtlAQ--.29879S13
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW3Zw48uFWfAryfur47CFg_yoW3Kw4rpr
	Z8GrW5Jr1rWFykWrWvqw4DZF1Fyan2grWUWrWxurnFyasFy34xKF4YkFyF9FWrtrW8Ar4Y
	vF4Utry7CFW7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now the beginning of all the five functions in ext4_fallocate() (punch
hole, zero range, insert range, collapse range and normal fallocate) are
almost the same, they need to hold i_rwsem and check the validity of
input parameters, so move the holding of i_rwsem to ext4_fallocate()
and factor out a common helper to check the input parameters can make
the code more clear.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 132 ++++++++++++++++++----------------------------
 fs/ext4/inode.c   |  13 ++---
 2 files changed, 56 insertions(+), 89 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 06b2c1190181..91e509201915 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4548,23 +4548,14 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	int ret, flags, credits;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
-
-	inode_lock(inode);
-
-	/*
-	 * Indirect files do not support unwritten extents
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
 		new_size = end;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4572,7 +4563,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released
@@ -4657,8 +4648,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -4672,18 +4661,11 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	int ret;
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	start_lblk = offset >> inode->i_blkbits;
 	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
 
-	inode_lock(inode);
-
-	/* We only support preallocation for extent-based files only. */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
 		new_size = end;
@@ -4709,11 +4691,46 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 					EXT4_I(inode)->i_sync_tid);
 	}
 out:
-	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
 	return ret;
 }
 
+static int ext4_fallocate_check(struct inode *inode, int mode,
+				loff_t offset, loff_t len)
+{
+	/* Currently except punch_hole, just for extent based files. */
+	if (!(mode & FALLOC_FL_PUNCH_HOLE) &&
+	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Insert range and collapse range works only on fs cluster size
+	 * aligned regions.
+	 */
+	if (mode & (FALLOC_FL_INSERT_RANGE | FALLOC_FL_COLLAPSE_RANGE) &&
+	    !IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(inode->i_sb)))
+		return -EINVAL;
+
+	if (mode & FALLOC_FL_INSERT_RANGE) {
+		/* Collapse range, offset must be less than i_size */
+		if (offset >= inode->i_size)
+			return -EINVAL;
+		/* Check whether the maximum file size would be exceeded */
+		if (len > inode->i_sb->s_maxbytes - inode->i_size)
+			return -EFBIG;
+	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+		/*
+		 * Insert range, there is no need to overlap collapse
+		 * range with EOF, in which case it is effectively a
+		 * truncate operation.
+		 */
+		if (offset + len >= inode->i_size)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * preallocate space for a file. This implements ext4's fallocate file
  * operation, which gets called from sys_fallocate system call.
@@ -4744,9 +4761,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
-	inode_unlock(inode);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = ext4_fallocate_check(inode, mode, offset, len);
+	if (ret)
+		goto out;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
@@ -4758,7 +4778,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
 		ret = ext4_do_fallocate(file, offset, len, mode);
-
+out:
+	inode_unlock(inode);
 	return ret;
 }
 
@@ -5267,36 +5288,14 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	int ret;
 
 	trace_ext4_collapse_range(inode, offset, len);
-
-	inode_lock(inode);
-
-	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	/* Collapse range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * There is no need to overlap collapse range with EOF, in which case
-	 * it is effectively a truncate operation
-	 */
-	if (offset + len >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5365,8 +5364,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -5392,39 +5389,14 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
-
-	inode_lock(inode);
-
-	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	/* Insert range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Offset must be less than i_size */
-	if (offset >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out;
-	}
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5525,8 +5497,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dfaf9e9d6ad8..57636c656fa5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3923,15 +3923,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	unsigned long blocksize = i_blocksize(inode);
 	handle_t *handle;
 	unsigned int credits;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size)
-		goto out;
+		return 0;
 
 	/*
 	 * If the hole extends beyond i_size, set the hole to end after
@@ -3951,7 +3950,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -3959,7 +3958,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -4036,8 +4035,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
-- 
2.39.2


