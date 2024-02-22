Return-Path: <linux-fsdevel+bounces-12465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8085F8BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8881C2311B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E60134CEA;
	Thu, 22 Feb 2024 12:51:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BF1350E8;
	Thu, 22 Feb 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606303; cv=none; b=aNEq0rODxXbyL6Qs2zUCJR+tXnIHOg8Tzk4DU+JYOfju03Bos3vlL6mb6xmLnE38HuNFzlppV8AevzMkztOTVqWaF+tknz3fh79laSW/ivnm8zBv2ifu0Jfka7t4WRlwaSTTX7coaIbkqSaf56Wod5Lj/M++Mzn7lgyj19hhLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606303; c=relaxed/simple;
	bh=U3bqHDFFwwPkYnyC7/NpA5LIH+dNInFlzB/J3Kx4CnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbGyt/o4xPnSrFAXz3etK9+lisn7WLOSBzlfvH2BrTQG1cxBhjGLx0ojpyDvjuQvTUGSuaCxITlnf4YIYMWcKX+CDA7vFR8qJRapu6RQ0/jfurZ4wcrnSB8AyY6pFMy738SawhwkM0vcF6sZ55/gPXXllIOnGBXDvVZxlnhd+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgY1K4YXfz4f3kFF;
	Thu, 22 Feb 2024 20:51:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A914D1A0DD6;
	Thu, 22 Feb 2024 20:51:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S18;
	Thu, 22 Feb 2024 20:51:38 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RFC v4 linux-next 14/19] jbd2: prevent direct access of bd_inode
Date: Thu, 22 Feb 2024 20:45:50 +0800
Message-Id: <20240222124555.2049140-15-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S18
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1rJFWrWr4xAF13Zw4kCrg_yoWxXr1rpF
	98Ga45ArWUZryjgrWxXrWUJrWYqa40ka4UWr9ru3sYy3yqyr97KF1kKr1UJFWUtFWrGan5
	XF1DC3y7Gw1UKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to get mapping
from the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/ext4/super.c      |  2 +-
 fs/jbd2/journal.c    | 26 +++++++++++++++-----------
 include/linux/jbd2.h | 18 ++++++++++++++----
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 55b3df71bf5e..4df1a5cfe0a5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5918,7 +5918,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
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


