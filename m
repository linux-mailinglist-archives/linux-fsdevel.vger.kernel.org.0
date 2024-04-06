Return-Path: <linux-fsdevel+bounces-16277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CFD89A9F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688EE1C21084
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A33381C6;
	Sat,  6 Apr 2024 09:17:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33A36AF6;
	Sat,  6 Apr 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395072; cv=none; b=btklzGXmtLdi38KpIJRpVAkt6IEWcncxUP9lwyC7gVU+OItXBH4OeTDa1irmrgCiYK5FjaH3zFV2M3xTsqs+k6SWYxz44FID8yl2lvRtWHL5t65kxUJFGIbYtjREfLHmxZInuBsg/46PFz/+KfR6n1pRMwKhaUhfHx4rslsG3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395072; c=relaxed/simple;
	bh=8vZlYcXDwbM//A79Dk/T06AReJmn5bA6v/csx8/5VJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2gGd1/3U/KveRy2jWDv+dBnQjwkjCovAocJL42rifCCvrU4LUYBb+Rn6y+ZVAQWMgTVGzkvrzKw8nEfLKBTHzgVPY1rENmj96+8OP94m6AqAMccrhtA398Kqj5Bsc8rz/2jq5VHrOZ0dnZ5d7c/VLI6Vm+MotJVW4coWmvXQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBC3bPbz4f3lg9;
	Sat,  6 Apr 2024 17:17:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 013F91A0175;
	Sat,  6 Apr 2024 17:17:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S18;
	Sat, 06 Apr 2024 17:17:47 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 14/26] jbd2: prevent direct access of bd_inode
Date: Sat,  6 Apr 2024 17:09:18 +0800
Message-Id: <20240406090930.2252838-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S18
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1rJw4fAF1fJw1rKF4fuFg_yoWxXFW3pF
	98Ga45ZrWUZryjgrWxXrWUJrWYqa40ka4UWr9ru3sYy3yqyr97KF1kKr1UJFWUtFWrGan5
	XF1DC3y7Gw1UK3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to get mapping
from the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c      |  2 +-
 fs/jbd2/journal.c    | 26 +++++++++++++++-----------
 include/linux/jbd2.h | 18 ++++++++++++++----
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2a1afe6c77f2..d47c1e7e8798 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5910,7 +5910,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(bdev_file, sb->s_bdev_file, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..abd42a6ccd0e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1516,11 +1516,12 @@ static int journal_load_superblock(journal_t *journal)
  * very few fields yet: that has to wait until we have created the
  * journal structures from from scratch, or loaded them from disk. */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
+static journal_t *journal_init_common(struct file *bdev_file,
+			struct file *fs_dev_file,
 			unsigned long long start, int len, int blocksize)
 {
 	static struct lock_class_key jbd2_trans_commit_key;
+	struct block_device *bdev = file_bdev(bdev_file);
 	journal_t *journal;
 	int err;
 	int n;
@@ -1531,7 +1532,9 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 	journal->j_blocksize = blocksize;
 	journal->j_dev = bdev;
-	journal->j_fs_dev = fs_dev;
+	journal->j_dev_file = bdev_file;
+	journal->j_fs_dev = file_bdev(fs_dev_file);
+	journal->j_fs_dev_file = fs_dev_file;
 	journal->j_blk_offset = start;
 	journal->j_total_len = len;
 	jbd2_init_fs_dev_write_error(journal);
@@ -1628,8 +1631,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 /**
  *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure
- *  @bdev: Block device on which to create the journal
- *  @fs_dev: Device which hold journalled filesystem for this journal.
+ *  @bdev_file: Opened block device on which to create the journal
+ *  @fs_dev_file: Opened device which hold journalled filesystem for this journal.
  *  @start: Block nr Start of journal.
  *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
@@ -1640,13 +1643,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
+journal_t *jbd2_journal_init_dev(struct file *bdev_file,
+			struct file *fs_dev_file,
 			unsigned long long start, int len, int blocksize)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev_file, fs_dev_file, start, len, blocksize);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1683,8 +1686,9 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
-	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
+	journal = journal_init_common(inode->i_sb->s_bdev_file,
+			inode->i_sb->s_bdev_file, blocknr,
+			inode->i_size >> inode->i_sb->s_blocksize_bits,
 			inode->i_sb->s_blocksize);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
@@ -2009,7 +2013,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		byte_count = (block_stop - block_start + 1) *
 				journal->j_blocksize;
 
-		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+		truncate_inode_pages_range(journal->j_dev_file->f_mapping,
 				byte_start, byte_stop);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..fc26730ae8ef 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -968,6 +968,11 @@ struct journal_s
 	 */
 	struct block_device	*j_dev;
 
+	/**
+	 * @j_dev_file: Opended device @j_dev.
+	 */
+	struct file		*j_dev_file;
+
 	/**
 	 * @j_blocksize: Block size for the location where we store the journal.
 	 */
@@ -993,6 +998,11 @@ struct journal_s
 	 */
 	struct block_device	*j_fs_dev;
 
+	/**
+	 * @j_fs_dev_file: Opened device @j_fs_dev.
+	 */
+	struct file		*j_fs_dev_file;
+
 	/**
 	 * @j_fs_dev_wb_err:
 	 *
@@ -1533,8 +1543,8 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
+extern journal_t *jbd2_journal_init_dev(struct file *bdev_file,
+				struct file *fs_dev_file,
 				unsigned long long start, int len, int bsize);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);
@@ -1696,7 +1706,7 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
 
 static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_dev_file->f_mapping;
 
 	/*
 	 * Save the original wb_err value of client fs's bdev mapping which
@@ -1707,7 +1717,7 @@ static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 
 static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_dev_file->f_mapping;
 
 	return errseq_check(&mapping->wb_err,
 			    READ_ONCE(journal->j_fs_dev_wb_err));
-- 
2.39.2


