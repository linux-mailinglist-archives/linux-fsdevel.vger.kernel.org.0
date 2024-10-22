Return-Path: <linux-fsdevel+bounces-32549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D79A969C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1151AB2271C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E114659C;
	Tue, 22 Oct 2024 03:13:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BD13DBBE;
	Tue, 22 Oct 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566780; cv=none; b=D1ZGPNmajqzd9SmC1CpUTq9/Ct9uQImKA7n3JJOCTrClWv2Q7eMHWDj+JtQkXE4RuhTL8fNqc9Gy4xT1YejuupqRFoPWFy7RXPenN9T3xxjrbNAFy02g7CGSKbJfuEqsUP72wOTw2XPHqIa9uLpCh9Sn9s71lu7cWQCbNM28YgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566780; c=relaxed/simple;
	bh=Hs642+YcBh6zGzG/cPCBStH/9nkc21Aq/HGV670zhPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkNPKuH8nnFCMz7FalIc65DFMG1LhlH1D7sCvNyb6KkqTqL5Trm2kF+A7w23QTgwtk+IsZ3vAQAgV29n38AvBnu0OX44L2plwFHayTRczA6OsAuIyEv/6vUd7iiEauxhC6hgp/YWg48v7n+fh9mru2h+gdxjp7fjvTZqE59ssws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXcgG4jwxz4f3jkm;
	Tue, 22 Oct 2024 11:12:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E790C1A0359;
	Tue, 22 Oct 2024 11:12:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S13;
	Tue, 22 Oct 2024 11:12:54 +0800 (CST)
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
Subject: [PATCH 09/27] ext4: move out inode_lock into ext4_fallocate()
Date: Tue, 22 Oct 2024 19:10:40 +0800
Message-ID: <20241022111059.2566137-10-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S13
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWxtF47uw47tr13XF1rtFb_yoW3Xr4rpr
	Z8G3y5Jr4rXFykWrWvqa1DZF1jy3Z7KrWUWrW8urnFyasFy34fKF4YyFyF9FWrtrW8ZrWY
	vF4Utry7CFy7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
2.46.1


