Return-Path: <linux-fsdevel+bounces-31570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52609987E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E682C1C24564
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90C1CCEF6;
	Thu, 10 Oct 2024 13:35:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46311CB506;
	Thu, 10 Oct 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567350; cv=none; b=YEcX/Cv3C69xptCGaEnO/ilOcZOYocxzwF8M7eil7Z/C9AG8Olnprph1YPk28xPu1zFH899mk/pdh1GjQf9w7ZE2rUCDxB4UNY5906F/HDEu7ItnV8UElW5s4TOWryfN/MzMM6/uWPLRfiTf7gCU5GZqGG9tb3RZz/dlUIYYmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567350; c=relaxed/simple;
	bh=4d/eifYjYq40EpqmeGsaUkJLh+iOaNzJz0DlPkZ0OD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SX3/ah5EgMMXkMr/WUPuZukOy9axnpO7iQPpZXMGT46x+kkCXT1JFTR3I3/w1cdAly7J4iEOeLCANfRp7H/bv/jlH5LDSkbIP+WcNhud+Top4S/amJKPzg29z3qFRRc5BeSLxrzJPuFvRTtc46dG1TbIWbZZ8MqrP5KkIpjcYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPW3M09Bvz4f3lV7;
	Thu, 10 Oct 2024 21:35:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A49D61A08FC;
	Thu, 10 Oct 2024 21:35:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYc2AdnDRnZDg--.21356S13;
	Thu, 10 Oct 2024 21:35:44 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
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
Subject: [PATCH v3 09/10] ext4: move out inode_lock into ext4_fallocate()
Date: Thu, 10 Oct 2024 21:33:32 +0800
Message-Id: <20241010133333.146793-10-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241010133333.146793-1-yi.zhang@huawei.com>
References: <20241010133333.146793-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYc2AdnDRnZDg--.21356S13
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1DAFyUKr13Kw1rXrykAFb_yoW3Gw1Upr
	Z8G3y5Jr4rXFykWrWvqa1DZF1jy3Z7KrWUWrW8urnFyasFy34fKF4YyFyF9FWrtrW8ZrWY
	vF4Utry7CFy7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZyC
	LUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Currently, all five sub-functions of ext4_fallocate() acquire the
inode's i_rwsem at the beginning and release it before exiting. This
process can be simplified by factoring out the management of i_rwsem
into the ext4_fallocate() function.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 90 +++++++++++++++--------------------------------
 fs/ext4/inode.c   | 13 +++----
 2 files changed, 33 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2f727104f53d..a2db4e85790f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4573,23 +4573,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	int ret, flags, credits;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	inode_lock(inode);
-
-	/*
-	 * Indirect files do not support unwritten extents
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	/* Indirect files do not support unwritten extents */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return -EOPNOTSUPP;
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
 		new_size = end;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4597,7 +4592,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released
@@ -4687,8 +4682,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -4702,12 +4695,11 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	int ret;
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	start_lblk = offset >> inode->i_blkbits;
 	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
 
-	inode_lock(inode);
-
 	/* We only support preallocation for extent-based files only. */
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 		ret = -EOPNOTSUPP;
@@ -4739,7 +4731,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 					EXT4_I(inode)->i_sync_tid);
 	}
 out:
-	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
 	return ret;
 }
@@ -4774,9 +4765,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
-	inode_unlock(inode);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
@@ -4788,7 +4778,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
 		ret = ext4_do_fallocate(file, offset, len, mode);
-
+out:
+	inode_unlock(inode);
 	return ret;
 }
 
@@ -5298,36 +5289,27 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	int ret;
 
 	trace_ext4_collapse_range(inode, offset, len);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
 	/* Collapse range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
+		return -EINVAL;
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
 	 */
-	if (end >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (end >= inode->i_size)
+		return -EINVAL;
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5402,8 +5384,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -5429,39 +5409,27 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
 	/* Insert range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
+		return -EINVAL;
 	/* Offset must be less than i_size */
-	if (offset >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (offset >= inode->i_size)
+		return -EINVAL;
 	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out;
-	}
+	if (len > inode->i_sb->s_maxbytes - inode->i_size)
+		return -EFBIG;
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5562,8 +5530,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1d128333bd06..bea19cd6e676 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3962,15 +3962,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
@@ -3990,7 +3989,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -3998,7 +3997,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -4082,8 +4081,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
-- 
2.39.2


