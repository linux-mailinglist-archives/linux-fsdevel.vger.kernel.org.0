Return-Path: <linux-fsdevel+bounces-37897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A819F8950
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 02:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DFF1888D0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43E1A83F0;
	Fri, 20 Dec 2024 01:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495F194A67;
	Fri, 20 Dec 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734657623; cv=none; b=OOUqgRKBSXlcfL6DN+JDBRQe2uFXLJORJYqHu+CCwJ6tFGSnTpYS1x+cqdApOOG0LbA7kGGyYF+TATgygR5fkO0ziInBszFytxfSm1G8aSvG0S3nHps1NW6uoVFxatVZjL26LN+iXcQHuxGXojg4sSNJu++DZGbskwGcDhzprpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734657623; c=relaxed/simple;
	bh=RVO7FDIcTZWJ/lSgJSLwezUCC1w4ywmZQ4JcwpfcFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnqZ9skoPUtE3DAJ9hyTQtEbBPAFzrUflAn2Imy08zB+aJGwIV3SM5MvW8d+Z68iLHrEgyngJA8LXpoHLR1jyG/Eu3bnb3OgqU6YeaNtjyVTuSAstnWHAcwPt6YvFTzKrBCewWiO25FKcb3rzsYQcKc5Ufg88Xwkxhl42xTxsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDqMr5Yxqz4f3jJ5;
	Fri, 20 Dec 2024 09:19:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 536691A0568;
	Fri, 20 Dec 2024 09:20:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoI6xmRnETtfFA--.47090S12;
	Fri, 20 Dec 2024 09:20:12 +0800 (CST)
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
Subject: [PATCH v5 08/10] ext4: factor out ext4_do_fallocate()
Date: Fri, 20 Dec 2024 09:16:35 +0800
Message-ID: <20241220011637.1157197-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnzoI6xmRnETtfFA--.47090S12
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13tFWDZr4Uuw48Xw43Jrb_yoWrKFy7pF
	Z8JryUGFWxXa4DWrW0qw4UXFn8ta1kKrWUWrWI9rnav3s0y3sxKF1YkFyFgFWftrW8Ar4j
	vF4Yyry7CF17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now the real job of normal fallocate are open coded in ext4_fallocate(),
factor out a new helper ext4_do_fallocate() to do the real job, like
others functions (e.g. ext4_zero_range()) in ext4_fallocate() do, this
can make the code more clear, no functional changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 125 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 65 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index be44dd7aacdb..a8bbbf8a9950 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4689,6 +4689,58 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	return ret;
 }
 
+static long ext4_do_fallocate(struct file *file, loff_t offset,
+			      loff_t len, int mode)
+{
+	struct inode *inode = file_inode(file);
+	loff_t end = offset + len;
+	loff_t new_size = 0;
+	ext4_lblk_t start_lblk, len_lblk;
+	int ret;
+
+	trace_ext4_fallocate_enter(inode, offset, len, mode);
+
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
+
+	inode_lock(inode);
+
+	/* We only support preallocation for extent-based files only. */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
+	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
+		new_size = end;
+		ret = inode_newsize_ok(inode, new_size);
+		if (ret)
+			goto out;
+	}
+
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
+	inode_dio_wait(inode);
+
+	ret = file_modified(file);
+	if (ret)
+		goto out;
+
+	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
+				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
+	if (ret)
+		goto out;
+
+	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
+		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
+					EXT4_I(inode)->i_sync_tid);
+	}
+out:
+	inode_unlock(inode);
+	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
+	return ret;
+}
+
 /*
  * preallocate space for a file. This implements ext4's fallocate file
  * operation, which gets called from sys_fallocate system call.
@@ -4699,12 +4751,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	loff_t new_size = 0;
-	unsigned int max_blocks;
-	int ret = 0;
-	int flags;
-	ext4_lblk_t lblk;
-	unsigned int blkbits = inode->i_blkbits;
+	int ret;
 
 	/*
 	 * Encrypted inodes can't handle collapse range or insert
@@ -4726,71 +4773,19 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
 	if (ret)
-		goto exit;
+		return ret;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
+	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
 		ret = ext4_collapse_range(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_INSERT_RANGE) {
+	else if (mode & FALLOC_FL_INSERT_RANGE)
 		ret = ext4_insert_range(file, offset, len);
-		goto exit;
-	}
-
-	if (mode & FALLOC_FL_ZERO_RANGE) {
+	else if (mode & FALLOC_FL_ZERO_RANGE)
 		ret = ext4_zero_range(file, offset, len, mode);
-		goto exit;
-	}
-	trace_ext4_fallocate_enter(inode, offset, len, mode);
-	lblk = offset >> blkbits;
-
-	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
-
-	inode_lock(inode);
-
-	/*
-	 * We only support preallocation for extent-based files only
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > inode->i_size ||
-	     offset + len > EXT4_I(inode)->i_disksize)) {
-		new_size = offset + len;
-		ret = inode_newsize_ok(inode, new_size);
-		if (ret)
-			goto out;
-	}
-
-	/* Wait all existing dio workers, newcomers will block on i_rwsem */
-	inode_dio_wait(inode);
-
-	ret = file_modified(file);
-	if (ret)
-		goto out;
-
-	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
-	if (ret)
-		goto out;
+	else
+		ret = ext4_do_fallocate(file, offset, len, mode);
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
-					EXT4_I(inode)->i_sync_tid);
-	}
-out:
-	inode_unlock(inode);
-	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
-exit:
 	return ret;
 }
 
-- 
2.46.1


