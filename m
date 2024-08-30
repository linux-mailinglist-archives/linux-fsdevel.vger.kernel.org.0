Return-Path: <linux-fsdevel+bounces-27991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AC9658D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED247B261EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7816F297;
	Fri, 30 Aug 2024 07:39:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B7165EED;
	Fri, 30 Aug 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003579; cv=none; b=oEhU+L/LsE43cK78WE4hFziKeP74DQ/AGp6j8Pk0H5AGtunkyxajoVq+kqJxUFbGQFlizXKU9FNEFXSu/Z5nGRrIww+reprVM0aq6JZdOvl6eb2/Bj63rK1qQC2dm6yNTw5Ph+c1ahCJJfITO2YDRdzo/r2KtsRZEZyecddiNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003579; c=relaxed/simple;
	bh=7Sza7CcxStYhbQ6TfF27ZTwDMUlCpfgTSYZALrKgfxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbRs5iqXvzcWyolCUp2Fg9pohFKunIYE3PYefS2fGDykpiL3a4rGle79qdIeKq2APc6KJCBErVQHynBmwgnuNLN2bro13G0HmmUlwZzulpoyRdGyzNZvJGJHVqPv6RLlbufiNRs7sIRdMR8cq2zFh0g+eC3W70ca4SZSB87/jC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww95R72HVz4f3jtx;
	Fri, 30 Aug 2024 15:39:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B9861A018D;
	Fri, 30 Aug 2024 15:39:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4Uhd9FmXb5_DA--.51707S12;
	Fri, 30 Aug 2024 15:39:33 +0800 (CST)
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
Subject: [PATCH 08/10] ext4: factor out ext4_do_fallocate()
Date: Fri, 30 Aug 2024 15:37:58 +0800
Message-Id: <20240830073800.2131781-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4Uhd9FmXb5_DA--.51707S12
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UtrWxJr1kurW3Cr13twb_yoWrtw1rpF
	Z8Jry5GrWxXa4DWrW0qw4UXF15ta1kKrWUWrWI9r1Sv3s0y3s3KF1YkFyFgFWftrW8Ar4j
	vF4Yyry7CF17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now the real job of normal fallocate are open code in ext4_fallocate(),
factor out a new helper ext4_do_fallocate() to do the real job, like
others functions (e.g. ext4_zero_range()) in ext4_fallocate() do, this
can make the code more clear, no functional changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 125 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 65 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a6c24c229cb4..4e23f9e8a7be 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4662,6 +4662,58 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
+	start_lblk = offset >> inode->i_blkbits;
+	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
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
@@ -4672,12 +4724,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
@@ -4699,71 +4746,19 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
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
2.39.2


