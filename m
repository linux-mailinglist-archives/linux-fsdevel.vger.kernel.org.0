Return-Path: <linux-fsdevel+bounces-12475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75385F8D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E491F2174A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865E1332B3;
	Thu, 22 Feb 2024 12:51:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27361420B8;
	Thu, 22 Feb 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606308; cv=none; b=q3Hdkp/S8L7eM0692x01DPjpgOKAci16XMuoJ78Z85qrubcSHK45RlLoBNDnslqN5/jYCiQeK1K9D9wbWISq/OwxVMq9MqOFWOUHuw68C+1YY5H40rZr/xaJWQOAuhL/A4NHeq3zrzt2mWlN8fEGwkWQzJ42lkhhHCk3CiwQudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606308; c=relaxed/simple;
	bh=Tcq+PIlYGWcI67qbfsNhUIbVZ3a0YSfb2efcNOsCgao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t51NaNJ5uEKjkdUQzdAW5rJl9xFOKBrJOhTU6OTEPMSa/hg2dChLvCmrsW17zNNT/hTitHhJjp8DjCFz03TOs/cQh/a94fNZk1pNzzj4bV+JHWI57H4MJkudpH9b6gOjRnT38jPiM2snoKsQe4/7EC5efIoBSQjsnDEYgtwQoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgY1M6ZhBz4f3jcv;
	Thu, 22 Feb 2024 20:51:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E81481A0DDE;
	Thu, 22 Feb 2024 20:51:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S23;
	Thu, 22 Feb 2024 20:51:40 +0800 (CST)
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
Subject: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Date: Thu, 22 Feb 2024 20:45:55 +0800
Message-Id: <20240222124555.2049140-20-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S23
X-Coremail-Antispam: 1UD129KBjvAXoWDGr4DWF43Cw17ZryDZFW7CFg_yoWxtr1fXo
	Waqw4fXr4rK3yUJ3yIkryFqryUZayDtw13JF4rWFZ8Zas3tw1j93y3Kw47Xa4fG3WFkryY
	gryfJw45WF4Uur48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	OBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

In prior patches we introduced the ability to open block devices as
files and made all filesystems stash the opened block device files. With
this patch we remove bdev->bd_inode from struct block_device.

Using files allows us to stop passing struct block_device directly to
almost all buffer_head helpers. Whenever access to the inode of the
block device is needed bdev_file_inode(bdev_file) can be used instead of
bdev->bd_inode.

The only user that doesn't rely on files is the block layer itself in
block/fops.c where we only have access to the block device. As the bdev
filesystem doesn't open block devices as files obviously.

This introduces a union into struct buffer_head and struct iomap. The
union encompasses both struct block_device and struct file. In both
cases a flag is used to differentiate whether a block device or a proper
file was stashed. Simple accessors bh_bdev() and iomap_bdev() are used
to return the block device in the really low-level functions where it's
needed. These are overall just a few callsites.

Originally-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c                  |   8 ++-
 block/fops.c                  |   2 +
 drivers/md/md-bitmap.c        |   2 +-
 fs/affs/file.c                |   2 +-
 fs/btrfs/inode.c              |   2 +-
 fs/buffer.c                   | 103 +++++++++++++++++++---------------
 fs/direct-io.c                |   4 +-
 fs/erofs/data.c               |   3 +-
 fs/erofs/internal.h           |   1 +
 fs/erofs/zmap.c               |   2 +-
 fs/ext2/inode.c               |   4 +-
 fs/ext2/xattr.c               |   2 +-
 fs/ext4/inode.c               |   8 +--
 fs/ext4/mmp.c                 |   2 +-
 fs/ext4/page-io.c             |   5 +-
 fs/ext4/super.c               |   4 +-
 fs/ext4/xattr.c               |   2 +-
 fs/f2fs/data.c                |   7 ++-
 fs/f2fs/f2fs.h                |   1 +
 fs/fuse/dax.c                 |   2 +-
 fs/gfs2/aops.c                |   2 +-
 fs/gfs2/bmap.c                |   2 +-
 fs/gfs2/meta_io.c             |   2 +-
 fs/hpfs/file.c                |   2 +-
 fs/iomap/buffered-io.c        |   8 +--
 fs/iomap/direct-io.c          |  11 ++--
 fs/iomap/swapfile.c           |   2 +-
 fs/iomap/trace.h              |   2 +-
 fs/jbd2/commit.c              |   2 +-
 fs/jbd2/journal.c             |   8 +--
 fs/jbd2/recovery.c            |   8 +--
 fs/jbd2/revoke.c              |  13 +++--
 fs/jbd2/transaction.c         |   8 +--
 fs/mpage.c                    |  26 ++++++---
 fs/nilfs2/btnode.c            |   4 +-
 fs/nilfs2/gcinode.c           |   2 +-
 fs/nilfs2/mdt.c               |   2 +-
 fs/nilfs2/page.c              |   4 +-
 fs/nilfs2/recovery.c          |  27 +++++----
 fs/ntfs3/fsntfs.c             |   8 +--
 fs/ntfs3/inode.c              |   2 +-
 fs/ntfs3/super.c              |   2 +-
 fs/ocfs2/journal.c            |   2 +-
 fs/reiserfs/fix_node.c        |   2 +-
 fs/reiserfs/journal.c         |  10 ++--
 fs/reiserfs/prints.c          |   4 +-
 fs/reiserfs/reiserfs.h        |   6 +-
 fs/reiserfs/stree.c           |   2 +-
 fs/reiserfs/tail_conversion.c |   2 +-
 fs/xfs/xfs_iomap.c            |   4 +-
 fs/zonefs/file.c              |   4 +-
 include/linux/blk_types.h     |   1 -
 include/linux/blkdev.h        |   2 +
 include/linux/buffer_head.h   |  73 +++++++++++++++---------
 include/linux/iomap.h         |  14 ++++-
 include/trace/events/block.h  |   2 +-
 56 files changed, 259 insertions(+), 182 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b7af04d34af2..98c192ff81ec 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -412,7 +412,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
-	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
 		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
@@ -1230,6 +1229,13 @@ struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
 }
 EXPORT_SYMBOL_GPL(bdev_read_folio);
 
+void clean_bdev_aliases2(struct block_device *bdev, sector_t block,
+			 sector_t len)
+{
+	return __clean_bdev_aliases(bdev_inode(bdev), block, len);
+}
+EXPORT_SYMBOL_GPL(clean_bdev_aliases2);
+
 static int __init setup_bdev_allow_write_mounted(char *str)
 {
 	if (kstrtobool(str, &bdev_allow_write_mounted))
diff --git a/block/fops.c b/block/fops.c
index 1fcbdb131a8f..5550f8b53c21 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -386,6 +386,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	loff_t isize = i_size_read(inode);
 
 	iomap->bdev = bdev;
+	iomap->flags |= IOMAP_F_BDEV;
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	if (iomap->offset >= isize)
 		return -EIO;
@@ -407,6 +408,7 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 	bh->b_bdev = I_BDEV(inode);
 	bh->b_blocknr = iblock;
 	set_buffer_mapped(bh);
+	set_buffer_bdev(bh);
 	return 0;
 }
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9672f75c3050..689f5f543520 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -380,7 +380,7 @@ static int read_file_page(struct file *file, unsigned long index,
 			}
 
 			bh->b_blocknr = block;
-			bh->b_bdev = inode->i_sb->s_bdev;
+			bh->b_bdev_file = inode->i_sb->s_bdev_file;
 			if (count < blocksize)
 				count = 0;
 			else
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 04c018e19602..c0583831c58f 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -365,7 +365,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 err_alloc:
 	brelse(ext_bh);
 	clear_buffer_mapped(bh_result);
-	bh_result->b_bdev = NULL;
+	bh_result->b_bdev_file = NULL;
 	// unlock cache
 	affs_unlock_ext(inode);
 	return -ENOSPC;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df55dd891137..b3b2e01093dd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7716,7 +7716,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap->bdev_file = fs_info->fs_devices->latest_dev->bdev_file;
 	iomap->length = len;
 	free_extent_map(em);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index b55dea034a5d..5753c068ec78 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -129,7 +129,7 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
 	if (!test_bit(BH_Quiet, &bh->b_state))
 		printk_ratelimited(KERN_ERR
 			"Buffer I/O error on dev %pg, logical block %llu%s\n",
-			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
+			bh_bdev(bh), (unsigned long long)bh->b_blocknr, msg);
 }
 
 /*
@@ -187,9 +187,9 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * succeeds, there is no need to take i_private_lock.
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct file *bdev_file, sector_t block)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = file_inode(bdev_file);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct buffer_head *ret = NULL;
 	pgoff_t index;
@@ -232,7 +232,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       "device %pg blocksize: %d\n",
 		       (unsigned long long)block,
 		       (unsigned long long)bh->b_blocknr,
-		       bh->b_state, bh->b_size, bdev,
+		       bh->b_state, bh->b_size, file_bdev(bdev_file),
 		       1 << bd_inode->i_blkbits);
 	}
 out_unlock:
@@ -473,7 +473,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * try_to_free_buffers() will be operating against the *blockdev* mapping
  * at the time, not against the S_ISREG file which depends on those buffers.
  * So the locking for i_private_list is via the i_private_lock in the address_space
- * which backs the buffers.  Which is different from the address_space 
+ * which backs the buffers.  Which is different from the address_space
  * against which the buffers are listed.  So for a particular address_space,
  * mapping->i_private_lock does *not* protect mapping->i_private_list!  In fact,
  * mapping->i_private_list will always be protected by the backing blockdev's
@@ -655,10 +655,12 @@ EXPORT_SYMBOL(generic_buffers_fsync);
  * `bblock + 1' is probably a dirty indirect block.  Hunt it down and, if it's
  * dirty, schedule it for IO.  So that indirects merge nicely with their data.
  */
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *bdev_file,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh =
+		__find_get_block(bdev_file, bblock + 1, blocksize);
+
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -994,8 +996,9 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
  * Initialise the state of a blockdev folio's buffers.
  */ 
 static sector_t folio_init_buffers(struct folio *folio,
-		struct block_device *bdev, unsigned size)
+		struct file *bdev_file, unsigned int size)
 {
+	struct block_device *bdev = file_bdev(bdev_file);
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
 	bool uptodate = folio_test_uptodate(folio);
@@ -1006,7 +1009,7 @@ static sector_t folio_init_buffers(struct folio *folio,
 		if (!buffer_mapped(bh)) {
 			bh->b_end_io = NULL;
 			bh->b_private = NULL;
-			bh->b_bdev = bdev;
+			bh->b_bdev_file = bdev_file;
 			bh->b_blocknr = block;
 			if (uptodate)
 				set_buffer_uptodate(bh);
@@ -1031,10 +1034,10 @@ static sector_t folio_init_buffers(struct folio *folio,
  * Returns false if we have a failure which cannot be cured by retrying
  * without sleeping.  Returns true if we succeeded, or the caller should retry.
  */
-static bool grow_dev_folio(struct block_device *bdev, sector_t block,
+static bool grow_dev_folio(struct file *bdev_file, sector_t block,
 		pgoff_t index, unsigned size, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = file_inode(bdev_file);
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block = 0;
@@ -1047,7 +1050,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = folio_init_buffers(folio, bdev, size);
+			end_block = folio_init_buffers(folio, bdev_file, size);
 			goto unlock;
 		}
 
@@ -1075,7 +1078,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->i_private_lock);
 	link_dev_buffers(folio, bh);
-	end_block = folio_init_buffers(folio, bdev, size);
+	end_block = folio_init_buffers(folio, bdev_file, size);
 	spin_unlock(&inode->i_mapping->i_private_lock);
 unlock:
 	folio_unlock(folio);
@@ -1088,7 +1091,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
  * that folio was dirty, the buffers are set dirty also.  Returns false
  * if we've hit a permanent error.
  */
-static bool grow_buffers(struct block_device *bdev, sector_t block,
+static bool grow_buffers(struct file *bdev_file, sector_t block,
 		unsigned size, gfp_t gfp)
 {
 	loff_t pos;
@@ -1100,18 +1103,19 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
 	if (check_mul_overflow(block, (sector_t)size, &pos) || pos > MAX_LFS_FILESIZE) {
 		printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
 			__func__, (unsigned long long)block,
-			bdev);
+			file_bdev(bdev_file));
 		return false;
 	}
 
 	/* Create a folio with the proper size buffers */
-	return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
+	return grow_dev_folio(bdev_file, block, pos / PAGE_SIZE, size, gfp);
 }
 
 static struct buffer_head *
-__getblk_slow(struct block_device *bdev, sector_t block,
-	     unsigned size, gfp_t gfp)
+__getblk_slow(struct file *bdev_file, sector_t block, unsigned size, gfp_t gfp)
 {
+	struct block_device *bdev = file_bdev(bdev_file);
+
 	/* Size must be multiple of hard sectorsize */
 	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
 			(size < 512 || size > PAGE_SIZE))) {
@@ -1127,11 +1131,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	for (;;) {
 		struct buffer_head *bh;
 
-		bh = __find_get_block(bdev, block, size);
+		bh = __find_get_block(bdev_file, block, size);
 		if (bh)
 			return bh;
 
-		if (!grow_buffers(bdev, block, size, gfp))
+		if (!grow_buffers(bdev_file, block, size, gfp))
 			return NULL;
 	}
 }
@@ -1367,7 +1371,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 
-		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
+		if (bh && bh->b_blocknr == block && bh_bdev(bh) == bdev &&
 		    bh->b_size == size) {
 			if (i) {
 				while (i) {
@@ -1392,13 +1396,14 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * NULL
  */
 struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+__find_get_block(struct file *bdev_file, sector_t block, unsigned int size)
 {
-	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
+	struct buffer_head *bh = lookup_bh_lru(file_bdev(bdev_file), block,
+					       size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev_file, block);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1410,32 +1415,32 @@ EXPORT_SYMBOL(__find_get_block);
 
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
- * @bdev: The block device.
+ * @bdev_file: The opened block device.
  * @block: The block number.
- * @size: The size of buffer_heads for this @bdev.
+ * @size: The size of buffer_heads for this block device.
  * @gfp: The memory allocation flags to use.
  *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+struct buffer_head *bdev_getblk(struct file *bdev_file, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh = __find_get_block(bdev_file, block, size);
 
 	might_alloc(gfp);
 	if (bh)
 		return bh;
 
-	return __getblk_slow(bdev, block, size, gfp);
+	return __getblk_slow(bdev_file, block, size, gfp);
 }
 EXPORT_SYMBOL(bdev_getblk);
 
 /*
  * Do async read-ahead on a buffer..
  */
-void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
+void __breadahead(struct file *bdev_file, sector_t block, unsigned int size)
 {
-	struct buffer_head *bh = bdev_getblk(bdev, block, size,
+	struct buffer_head *bh = bdev_getblk(bdev_file, block, size,
 			GFP_NOWAIT | __GFP_MOVABLE);
 
 	if (likely(bh)) {
@@ -1447,7 +1452,7 @@ EXPORT_SYMBOL(__breadahead);
 
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
+ *  @bdev_file: the opened block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  *  @gfp: page allocation flag
@@ -1458,12 +1463,11 @@ EXPORT_SYMBOL(__breadahead);
  *  It returns NULL if the block was unreadable.
  */
 struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
-		   unsigned size, gfp_t gfp)
+__bread_gfp(struct file *bdev_file, sector_t block, unsigned int size, gfp_t gfp)
 {
 	struct buffer_head *bh;
 
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= mapping_gfp_constraint(bdev_file->f_mapping, ~__GFP_FS);
 
 	/*
 	 * Prefer looping in the allocator rather than here, at least that
@@ -1471,7 +1475,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 	 */
 	gfp |= __GFP_NOFAIL;
 
-	bh = bdev_getblk(bdev, block, size, gfp);
+	bh = bdev_getblk(bdev_file, block, size, gfp);
 
 	if (likely(bh) && !buffer_uptodate(bh))
 		bh = __bread_slow(bh);
@@ -1556,7 +1560,7 @@ EXPORT_SYMBOL(folio_set_bh);
 /* Bits that are cleared during an invalidate */
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
-	 1 << BH_Delay | 1 << BH_Unwritten)
+	 1 << BH_Delay | 1 << BH_Unwritten | 1 << BH_Bdev)
 
 static void discard_buffer(struct buffer_head * bh)
 {
@@ -1564,7 +1568,7 @@ static void discard_buffer(struct buffer_head * bh)
 
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
-	bh->b_bdev = NULL;
+	bh->b_bdev_file = NULL;
 	b_state = READ_ONCE(bh->b_state);
 	do {
 	} while (!try_cmpxchg(&bh->b_state, &b_state,
@@ -1675,8 +1679,8 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
 EXPORT_SYMBOL(create_empty_buffers);
 
 /**
- * clean_bdev_aliases: clean a range of buffers in block device
- * @bdev: Block device to clean buffers in
+ * __clean_bdev_aliases: clean a range of buffers in block device
+ * @inode: Block device inode to clean buffers in
  * @block: Start of a range of blocks to clean
  * @len: Number of blocks to clean
  *
@@ -1694,9 +1698,8 @@ EXPORT_SYMBOL(create_empty_buffers);
  * I/O in bforget() - it's more efficient to wait on the I/O only if we really
  * need to.  That happens here.
  */
-void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
+void __clean_bdev_aliases(struct inode *bd_inode, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
 	pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
@@ -1746,7 +1749,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			break;
 	}
 }
-EXPORT_SYMBOL(clean_bdev_aliases);
+EXPORT_SYMBOL(__clean_bdev_aliases);
 
 static struct buffer_head *folio_create_buffers(struct folio *folio,
 						struct inode *inode,
@@ -2003,7 +2006,17 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 {
 	loff_t offset = (loff_t)block << inode->i_blkbits;
 
-	bh->b_bdev = iomap->bdev;
+	if (iomap->flags & IOMAP_F_BDEV) {
+		 /*
+		  * If this request originated directly from the block layer we
+		  * only have access to the plain block device. Mark the
+		  * buffer_head similarly.
+		  */
+		bh->b_bdev = iomap->bdev;
+		set_buffer_bdev(bh);
+	} else {
+		bh->b_bdev_file = iomap->bdev_file;
+	}
 
 	/*
 	 * Block points to offset in file we need to map, iomap contains
@@ -2778,7 +2791,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	if (buffer_prio(bh))
 		opf |= REQ_PRIO;
 
-	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), 1, opf, GFP_NOIO);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 60456263a338..77691f2b2565 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -671,7 +671,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
 	sector = start_sector << (sdio->blkbits - 9);
 	nr_pages = bio_max_segs(sdio->pages_in_io);
 	BUG_ON(nr_pages <= 0);
-	dio_bio_alloc(dio, sdio, map_bh->b_bdev, sector, nr_pages);
+	dio_bio_alloc(dio, sdio, bh_bdev(map_bh), sector, nr_pages);
 	sdio->boundary = 0;
 out:
 	return ret;
@@ -946,7 +946,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					map_bh->b_blocknr << sdio->blkfactor;
 				if (buffer_new(map_bh)) {
 					clean_bdev_aliases(
-						map_bh->b_bdev,
+						map_bh->b_bdev_file,
 						map_bh->b_blocknr,
 						map_bh->b_size >> i_blkbits);
 				}
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index dc2d43abe8c5..6127ff1ba453 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -204,6 +204,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	int id;
 
 	map->m_bdev = sb->s_bdev;
+	map->m_bdev_file = sb->s_bdev_file;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
@@ -278,7 +279,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_daxdev;
 	else
-		iomap->bdev = mdev.m_bdev;
+		iomap->bdev_file = mdev.m_bdev_file;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0f0706325b7b..50f8a7f161fd 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -377,6 +377,7 @@ enum {
 
 struct erofs_map_dev {
 	struct erofs_fscache *m_fscache;
+	struct file *m_bdev_file;
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
 	u64 m_dax_part_off;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..6da3083e8252 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -739,7 +739,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	if (ret < 0)
 		return ret;
 
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev_file = inode->i_sb->s_bdev_file;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f3d570a9302b..32555734e727 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -744,7 +744,7 @@ static int ext2_get_blocks(struct inode *inode,
 		 * We must unmap blocks before zeroing so that writeback cannot
 		 * overwrite zeros with stale data from block device page cache.
 		 */
-		clean_bdev_aliases(inode->i_sb->s_bdev,
+		clean_bdev_aliases(inode->i_sb->s_bdev_file,
 				   le32_to_cpu(chain[depth-1].key),
 				   count);
 		/*
@@ -842,7 +842,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = sbi->s_daxdev;
 	else
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->bdev_file = inode->i_sb->s_bdev_file;
 
 	if (ret == 0) {
 		/*
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index c885dcc3bd0d..42e595e87a74 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -80,7 +80,7 @@
 	} while (0)
 # define ea_bdebug(bh, f...) do { \
 		printk(KERN_DEBUG "block %pg:%lu: ", \
-			bh->b_bdev, (unsigned long) bh->b_blocknr); \
+			bh_bdev(bh), (unsigned long) bh->b_blocknr); \
 		printk(f); \
 		printk("\n"); \
 	} while (0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ccf3b5e3a7c..eb861ca94e63 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1791,11 +1791,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
  * reserve space for a single block.
  *
  * For delayed buffer_head we have BH_Mapped, BH_New, BH_Delay set.
- * We also have b_blocknr = -1 and b_bdev initialized properly
+ * We also have b_blocknr = -1 and b_bdev_file initialized properly
  *
  * For unwritten buffer_head we have BH_Mapped, BH_New, BH_Unwritten set.
- * We also have b_blocknr = physicalblock mapping unwritten extent and b_bdev
- * initialized properly.
+ * We also have b_blocknr = physicalblock mapping unwritten extent and
+ * b_bdev_file initialized properly.
  */
 int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create)
@@ -3235,7 +3235,7 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 	else
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->bdev_file = inode->i_sb->s_bdev_file;
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bd946d0c71b7..5641bd34d021 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -384,7 +384,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
 	snprintf(mmp->mmp_bdevname, sizeof(mmp->mmp_bdevname),
-		 "%pg", bh->b_bdev);
+		 "%pg", bh_bdev(bh));
 
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 312bc6813357..b0c3de39daa1 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -93,8 +93,7 @@ struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end)
 static void buffer_io_error(struct buffer_head *bh)
 {
 	printk_ratelimited(KERN_ERR "Buffer I/O error on device %pg, logical block %llu\n",
-		       bh->b_bdev,
-			(unsigned long long)bh->b_blocknr);
+		       bh_bdev(bh), (unsigned long long)bh->b_blocknr);
 }
 
 static void ext4_finish_bio(struct bio *bio)
@@ -397,7 +396,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4df1a5cfe0a5..d2ca92bf5f7e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+	struct buffer_head *bh = bdev_getblk(sb->s_bdev_file, block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -5862,7 +5862,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
 	set_blocksize(bdev, blocksize);
-	bh = __bread(bdev, sb_block, blocksize);
+	bh = __bread(bdev_file, sb_block, blocksize);
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 82dc5e673d5c..41128ccec2ec 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -68,7 +68,7 @@
 	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)					\
 	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
-	       bh->b_bdev, (unsigned long)bh->b_blocknr, ##__VA_ARGS__)
+	       bh_bdev(bh), (unsigned long)bh->b_blocknr, ##__VA_ARGS__)
 #else
 # define ea_idebug(inode, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 05158f89ef32..8ec12b3716bc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1606,6 +1606,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto out;
 
 	map->m_bdev = inode->i_sb->s_bdev;
+	map->m_bdev_file = inode->i_sb->s_bdev_file;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
 
@@ -1724,8 +1725,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
 
-		if (map->m_multidev_dio)
+		if (map->m_multidev_dio) {
 			map->m_bdev = FDEV(bidx).bdev;
+			map->m_bdev_file = FDEV(bidx).bdev_file;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
@@ -4250,7 +4253,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
-		iomap->bdev = map.m_bdev;
+		iomap->bdev_file = map.m_bdev_file;
 		iomap->addr = blks_to_bytes(inode, map.m_pblk);
 	} else {
 		if (flags & IOMAP_WRITE)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cc481d7b9287..ed36c11325cd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -697,6 +697,7 @@ struct extent_tree_info {
 				F2FS_MAP_DELALLOC)
 
 struct f2fs_map_blocks {
+	struct file *m_bdev_file;	/* for multi-device dio */
 	struct block_device *m_bdev;	/* for multi-device dio */
 	block_t m_pblk;
 	block_t m_lblk;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..24966e93a237 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -575,7 +575,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 
 	iomap->offset = pos;
 	iomap->flags = 0;
-	iomap->bdev = NULL;
+	iomap->bdev_file = NULL;
 	iomap->dax_dev = fc->dax->dev;
 
 	/*
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..0e4e295ebf49 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -622,7 +622,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			spin_unlock(&sdp->sd_ail_lock);
 		}
 	}
-	bh->b_bdev = NULL;
+	bh->b_bdev_file = NULL;
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 789af5c8fade..ef4e7ad83d4c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -926,7 +926,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		iomap->flags |= IOMAP_F_GFS2_BOUNDARY;
 
 out:
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev_file = inode->i_sb->s_bdev_file;
 unlock:
 	up_read(&ip->i_rw_mutex);
 	return ret;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f814054c8cd0..2052d3fc2c24 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -218,7 +218,7 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 		struct buffer_head *bh = *bhs;
 		struct bio *bio;
 
-		bio = bio_alloc(bh->b_bdev, num, opf, GFP_NOIO);
+		bio = bio_alloc(bh_bdev(bh), num, opf, GFP_NOIO);
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 		while (num > 0) {
 			bh = *bhs;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1bb8d97cd9ae..7353d0e2f35a 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -128,7 +128,7 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(flags & (IOMAP_WRITE | IOMAP_ZERO)))
 		return -EINVAL;
 
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev_file = inode->i_sb->s_bdev_file;
 	iomap->offset = offset;
 
 	hpfs_lock(sb);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2ad0e287c704..2fc8abd693da 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -415,7 +415,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+		ctx->bio = bio_alloc(iomap_bdev(iomap), bio_max_segs(nr_vecs),
 				     REQ_OP_READ, gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
@@ -423,7 +423,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+			ctx->bio = bio_alloc(iomap_bdev(iomap), 1, REQ_OP_READ,
 					     orig_gfp);
 		}
 		if (ctx->rac)
@@ -662,7 +662,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
+	bio_init(&bio, iomap_bdev(iomap), &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_add_folio_nofail(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
@@ -1684,7 +1684,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+	bio = bio_alloc_bioset(iomap_bdev(&wpc->iomap), BIO_MAX_VECS,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..42518754c65d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -56,9 +56,9 @@ static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
 	if (dio->dops && dio->dops->bio_set)
-		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
+		return bio_alloc_bioset(iomap_bdev(&iter->iomap), nr_vecs, opf,
 					GFP_KERNEL, dio->dops->bio_set);
-	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
+	return bio_alloc(iomap_bdev(&iter->iomap), nr_vecs, opf, GFP_KERNEL);
 }
 
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
@@ -288,8 +288,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length) & (bdev_logical_block_size(iomap_bdev(iomap)) - 1) ||
+	    !bdev_iter_is_aligned(iomap_bdev(iomap), dio->submit.iter))
 		return -EINVAL;
 
 	if (iomap->type == IOMAP_UNWRITTEN) {
@@ -316,7 +316,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
 		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
+		    (bdev_fua(iomap_bdev(iomap)) ||
+			      !bdev_write_cache(iomap_bdev(iomap))))
 			use_fua = true;
 		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 5fc0ac36dee3..20bd67e85d15 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -116,7 +116,7 @@ static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
 		return iomap_swapfile_fail(isi, "has shared extents");
 
 	/* Only one bdev per swap file. */
-	if (iomap->bdev != isi->sis->bdev)
+	if (iomap_bdev(iomap) != isi->sis->bdev)
 		return iomap_swapfile_fail(isi, "outside the main device");
 
 	if (isi->iomap.length == 0) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..43fb3ce21674 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(iomap_class,
 		__entry->length = iomap->length;
 		__entry->type = iomap->type;
 		__entry->flags = iomap->flags;
-		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+		__entry->bdev = iomap_bdev(iomap) ? iomap_bdev(iomap)->bd_dev : 0;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
 		  "length 0x%llx type %s flags %s",
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..fffb1b4e2068 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1014,7 +1014,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_mapped(bh);
 				clear_buffer_new(bh);
 				clear_buffer_req(bh);
-				bh->b_bdev = NULL;
+				bh->b_bdev_file = NULL;
 			}
 		}
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index abd42a6ccd0e..bbe5d02801b6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -434,7 +434,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
-	new_bh->b_bdev = journal->j_dev;
+	new_bh->b_bdev_file = journal->j_dev_file;
 	new_bh->b_blocknr = blocknr;
 	new_bh->b_private = bh_in;
 	set_buffer_mapped(new_bh);
@@ -880,7 +880,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (ret)
 		return ret;
 
-	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
+	bh = __getblk(journal->j_dev_file, pblock, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -1007,7 +1007,7 @@ jbd2_journal_get_descriptor_buffer(transaction_t *transaction, int type)
 	if (err)
 		return NULL;
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->j_dev_file, blocknr, journal->j_blocksize);
 	if (!bh)
 		return NULL;
 	atomic_dec(&transaction->t_outstanding_credits);
@@ -1461,7 +1461,7 @@ static int journal_load_superblock(journal_t *journal)
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
 
-	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
+	bh = getblk_unmovable(journal->j_dev_file, journal->j_blk_offset,
 			      journal->j_blocksize);
 	if (bh)
 		err = bh_read(bh, 0);
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..7b561e2c6a7c 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -92,7 +92,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 			goto failed;
 		}
 
-		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+		bh = __getblk(journal->j_dev_file, blocknr, journal->j_blocksize);
 		if (!bh) {
 			err = -ENOMEM;
 			goto failed;
@@ -148,7 +148,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 		return err;
 	}
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->j_dev_file, blocknr, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -370,7 +370,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 		journal->j_head = journal->j_first;
 	} else {
 #ifdef CONFIG_JBD2_DEBUG
-		int dropped = info.end_transaction - 
+		int dropped = info.end_transaction -
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
@@ -672,7 +672,7 @@ static int do_one_pass(journal_t *journal,
 
 					/* Find a buffer for the new
 					 * data being restored */
-					nbh = __getblk(journal->j_fs_dev,
+					nbh = __getblk(journal->j_fs_dev_file,
 							blocknr,
 							journal->j_blocksize);
 					if (nbh == NULL) {
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..99c2758539a8 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -328,7 +328,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 {
 	struct buffer_head *bh = NULL;
 	journal_t *journal;
-	struct block_device *bdev;
+	struct file *file;
 	int err;
 
 	might_sleep();
@@ -341,11 +341,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 		return -EINVAL;
 	}
 
-	bdev = journal->j_fs_dev;
+	file = journal->j_fs_dev_file;
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block(file, blocknr, journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +355,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(file, blocknr, journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -466,7 +466,8 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block(bh->b_bdev_file, bh->b_blocknr,
+				       bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -495,7 +496,7 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct jbd2_revoke_record_s *record;
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
-			bh = __find_get_block(journal->j_fs_dev,
+			bh = __find_get_block(journal->j_fs_dev_file,
 					      record->blocknr,
 					      journal->j_blocksize);
 			if (bh) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..30ebc93dc430 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -929,7 +929,7 @@ static void warn_dirty_buffer(struct buffer_head *bh)
 	       "JBD2: Spotted dirty metadata buffer (dev = %pg, blocknr = %llu). "
 	       "There's a risk of filesystem corruption in case of system "
 	       "crash.\n",
-	       bh->b_bdev, (unsigned long long)bh->b_blocknr);
+	       bh_bdev(bh), (unsigned long long)bh->b_blocknr);
 }
 
 /* Call t_frozen trigger and copy buffer data into jh->b_frozen_data. */
@@ -990,7 +990,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	/* If it takes too long to lock the buffer, trace it */
 	time_lock = jbd2_time_diff(start_lock, jiffies);
 	if (time_lock > HZ/10)
-		trace_jbd2_lock_buffer_stall(bh->b_bdev->bd_dev,
+		trace_jbd2_lock_buffer_stall(bh_bdev(bh)->bd_dev,
 			jiffies_to_msecs(time_lock));
 
 	/* We now hold the buffer lock so it is safe to query the buffer
@@ -2374,7 +2374,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
 			/* Already zapped buffer? Nothing to do... */
-			if (!bh->b_bdev)
+			if (!bh_bdev(bh))
 				return 0;
 			return -EBUSY;
 		}
@@ -2428,7 +2428,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	clear_buffer_new(bh);
 	clear_buffer_delay(bh);
 	clear_buffer_unwritten(bh);
-	bh->b_bdev = NULL;
+	bh->b_bdev_file = NULL;
 	return may_free;
 }
 
diff --git a/fs/mpage.c b/fs/mpage.c
index 738882e0766d..ef6e72eec312 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -126,7 +126,12 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 	do {
 		if (block == page_block) {
 			page_bh->b_state = bh->b_state;
-			page_bh->b_bdev = bh->b_bdev;
+			if (buffer_bdev(bh)) {
+				page_bh->b_bdev = bh->b_bdev;
+				set_buffer_bdev(page_bh);
+			} else {
+				page_bh->b_bdev_file = bh->b_bdev_file;
+			}
 			page_bh->b_blocknr = bh->b_blocknr;
 			break;
 		}
@@ -216,7 +221,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_bdev(map_bh);
 	}
 
 	/*
@@ -272,7 +277,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_bdev(map_bh);
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -472,7 +477,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	struct block_device *bdev = NULL;
 	int boundary = 0;
 	sector_t boundary_block = 0;
-	struct block_device *boundary_bdev = NULL;
+	struct file *boundary_bdev_file = NULL;
 	size_t length;
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
@@ -513,9 +518,9 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			boundary = buffer_boundary(bh);
 			if (boundary) {
 				boundary_block = bh->b_blocknr;
-				boundary_bdev = bh->b_bdev;
+				boundary_bdev_file = bh->b_bdev_file;
 			}
-			bdev = bh->b_bdev;
+			bdev = bh_bdev(bh);
 		} while ((bh = bh->b_this_page) != head);
 
 		if (first_unmapped)
@@ -549,13 +554,16 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		map_bh.b_size = 1 << blkbits;
 		if (mpd->get_block(inode, block_in_file, &map_bh, 1))
 			goto confused;
+		/* This helper cannot be used from the block layer directly. */
+		if (WARN_ON_ONCE(buffer_bdev(&map_bh)))
+			goto confused;
 		if (!buffer_mapped(&map_bh))
 			goto confused;
 		if (buffer_new(&map_bh))
 			clean_bdev_bh_alias(&map_bh);
 		if (buffer_boundary(&map_bh)) {
 			boundary_block = map_bh.b_blocknr;
-			boundary_bdev = map_bh.b_bdev;
+			boundary_bdev_file = map_bh.b_bdev_file;
 		}
 		if (page_block) {
 			if (map_bh.b_blocknr != first_block + page_block)
@@ -565,7 +573,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		}
 		page_block++;
 		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
+		bdev = bh_bdev(&map_bh);
 		if (block_in_file == last_block)
 			break;
 		block_in_file++;
@@ -627,7 +635,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (boundary || (first_unmapped != blocks_per_page)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
-			write_boundary_block(boundary_bdev,
+			write_boundary_block(boundary_bdev_file,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 0131d83b912d..0620bccbf6e0 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -59,7 +59,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 		BUG();
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->b_bdev_file = inode->i_sb->s_bdev_file;
 	bh->b_blocknr = blocknr;
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
@@ -118,7 +118,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		goto found;
 	}
 	set_buffer_mapped(bh);
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->b_bdev_file = inode->i_sb->s_bdev_file;
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index bf9a11d58817..77d4b9275b87 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -84,7 +84,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	}
 
 	if (!buffer_mapped(bh)) {
-		bh->b_bdev = inode->i_sb->s_bdev;
+		bh->b_bdev_file = inode->i_sb->s_bdev_file;
 		set_buffer_mapped(bh);
 	}
 	bh->b_blocknr = pbn;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 4f792a0ad0f0..99cf302ce116 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -89,7 +89,7 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 	if (buffer_uptodate(bh))
 		goto failed_bh;
 
-	bh->b_bdev = sb->s_bdev;
+	bh->b_bdev_file = sb->s_bdev_file;
 	err = nilfs_mdt_insert_new_block(inode, block, bh, init_block);
 	if (likely(!err)) {
 		get_bh(bh);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 14e470fb8870..f893d7e2e472 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -111,7 +111,7 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 
 	dbh->b_state = sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
 	dbh->b_blocknr = sbh->b_blocknr;
-	dbh->b_bdev = sbh->b_bdev;
+	dbh->b_bdev_file = sbh->b_bdev_file;
 
 	bh = dbh;
 	bits = sbh->b_state & (BIT(BH_Uptodate) | BIT(BH_Mapped));
@@ -216,7 +216,7 @@ static void nilfs_copy_folio(struct folio *dst, struct folio *src,
 		lock_buffer(dbh);
 		dbh->b_state = sbh->b_state & mask;
 		dbh->b_blocknr = sbh->b_blocknr;
-		dbh->b_bdev = sbh->b_bdev;
+		dbh->b_bdev_file = sbh->b_bdev_file;
 		sbh = sbh->b_this_page;
 		dbh = dbh->b_this_page;
 	} while (dbh != dbufs);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index a9b8d77c8c1d..e2f5dcc923c7 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -107,7 +107,8 @@ static int nilfs_compute_checksum(struct the_nilfs *nilfs,
 		do {
 			struct buffer_head *bh;
 
-			bh = __bread(nilfs->ns_bdev, ++start, blocksize);
+			bh = __bread(nilfs->ns_sb->s_bdev_file, ++start,
+				     blocksize);
 			if (!bh)
 				return -EIO;
 			check_bytes -= size;
@@ -136,7 +137,8 @@ int nilfs_read_super_root_block(struct the_nilfs *nilfs, sector_t sr_block,
 	int ret;
 
 	*pbh = NULL;
-	bh_sr = __bread(nilfs->ns_bdev, sr_block, nilfs->ns_blocksize);
+	bh_sr = __bread(nilfs->ns_sb->s_bdev_file, sr_block,
+			nilfs->ns_blocksize);
 	if (unlikely(!bh_sr)) {
 		ret = NILFS_SEG_FAIL_IO;
 		goto failed;
@@ -183,7 +185,8 @@ nilfs_read_log_header(struct the_nilfs *nilfs, sector_t start_blocknr,
 {
 	struct buffer_head *bh_sum;
 
-	bh_sum = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh_sum = __bread(nilfs->ns_sb->s_bdev_file, start_blocknr,
+			 nilfs->ns_blocksize);
 	if (bh_sum)
 		*sum = (struct nilfs_segment_summary *)bh_sum->b_data;
 	return bh_sum;
@@ -250,7 +253,7 @@ static void *nilfs_read_summary_info(struct the_nilfs *nilfs,
 	if (bytes > (*pbh)->b_size - *offset) {
 		blocknr = (*pbh)->b_blocknr;
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + 1,
+		*pbh = __bread(nilfs->ns_sb->s_bdev_file, blocknr + 1,
 			       nilfs->ns_blocksize);
 		if (unlikely(!*pbh))
 			return NULL;
@@ -289,7 +292,7 @@ static void nilfs_skip_summary_info(struct the_nilfs *nilfs,
 		*offset = bytes * (count - (bcnt - 1) * nitem_per_block);
 
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + bcnt,
+		*pbh = __bread(nilfs->ns_sb->s_bdev_file, blocknr + bcnt,
 			       nilfs->ns_blocksize);
 	}
 }
@@ -318,7 +321,8 @@ static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 
 	sumbytes = le32_to_cpu(sum->ss_sumbytes);
 	blocknr = start_blocknr + DIV_ROUND_UP(sumbytes, nilfs->ns_blocksize);
-	bh = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh = __bread(nilfs->ns_sb->s_bdev_file, start_blocknr,
+		     nilfs->ns_blocksize);
 	if (unlikely(!bh))
 		goto out;
 
@@ -478,7 +482,8 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
-	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
+	bh_org = __bread(nilfs->ns_sb->s_bdev_file, rb->blocknr,
+			 nilfs->ns_blocksize);
 	if (unlikely(!bh_org))
 		return -EIO;
 
@@ -697,7 +702,8 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	    nilfs_get_segnum_of_block(nilfs, ri->ri_super_root))
 		return;
 
-	bh = __getblk(nilfs->ns_bdev, ri->ri_lsegs_start, nilfs->ns_blocksize);
+	bh = __getblk(nilfs->ns_sb->s_bdev_file, ri->ri_lsegs_start,
+		      nilfs->ns_blocksize);
 	BUG_ON(!bh);
 	memset(bh->b_data, 0, bh->b_size);
 	set_buffer_dirty(bh);
@@ -823,7 +829,8 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 	/* Read ahead segment */
 	b = seg_start;
 	while (b <= seg_end)
-		__breadahead(nilfs->ns_bdev, b++, nilfs->ns_blocksize);
+		__breadahead(nilfs->ns_sb->s_bdev_file, b++,
+			     nilfs->ns_blocksize);
 
 	for (;;) {
 		brelse(bh_sum);
@@ -869,7 +876,7 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 		if (pseg_start == seg_start) {
 			nilfs_get_segment_range(nilfs, nextnum, &b, &end);
 			while (b <= end)
-				__breadahead(nilfs->ns_bdev, b++,
+				__breadahead(nilfs->ns_sb->s_bdev_file, b++,
 					     nilfs->ns_blocksize);
 		}
 		if (!(flags & NILFS_SS_SR)) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index ae2ef5c11868..def075a25b2c 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1033,14 +1033,13 @@ struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
 
 int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 {
-	struct block_device *bdev = sb->s_bdev;
 	u32 blocksize = sb->s_blocksize;
 	u64 block = lbo >> sb->s_blocksize_bits;
 	u32 off = lbo & (blocksize - 1);
 	u32 op = blocksize - off;
 
 	for (; bytes; block += 1, off = 0, op = blocksize) {
-		struct buffer_head *bh = __bread(bdev, block, blocksize);
+		struct buffer_head *bh = __bread(sb->s_bdev_file, block, blocksize);
 
 		if (!bh)
 			return -EIO;
@@ -1063,7 +1062,6 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		  const void *buf, int wait)
 {
 	u32 blocksize = sb->s_blocksize;
-	struct block_device *bdev = sb->s_bdev;
 	sector_t block = lbo >> sb->s_blocksize_bits;
 	u32 off = lbo & (blocksize - 1);
 	u32 op = blocksize - off;
@@ -1077,14 +1075,14 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 			op = bytes;
 
 		if (op < blocksize) {
-			bh = __bread(bdev, block, blocksize);
+			bh = __bread(sb->s_bdev_file, block, blocksize);
 			if (!bh) {
 				ntfs_err(sb, "failed to read block %llx",
 					 (u64)block);
 				return -EIO;
 			}
 		} else {
-			bh = __getblk(bdev, block, blocksize);
+			bh = __getblk(sb->s_bdev_file, block, blocksize);
 			if (!bh)
 				return -ENOMEM;
 		}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3c4c878f6d77..a97eedc5130f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -609,7 +609,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	lbo = ((u64)lcn << cluster_bits) + off;
 
 	set_buffer_mapped(bh);
-	bh->b_bdev = sb->s_bdev;
+	bh->b_bdev_file = sb->s_bdev_file;
 	bh->b_blocknr = lbo >> sb->s_blocksize_bits;
 
 	valid = ni->i_valid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cef5467fd928..aa7c6a8b04de 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1642,7 +1642,7 @@ void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 		limit >>= 1;
 
 	while (blocks--) {
-		clean_bdev_aliases(bdev, devblock++, 1);
+		clean_bdev_aliases(sb->s_bdev_file, devblock++, 1);
 		if (cnt++ >= limit) {
 			sync_blockdev(bdev);
 			cnt = 0;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 604fea3a26ff..4ad64997f3c7 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1209,7 +1209,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
 		}
 
 		for (i = 0; i < p_blocks; i++, p_blkno++) {
-			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
+			bh = __find_get_block(osb->sb->s_bdev_file, p_blkno,
 					osb->sb->s_blocksize);
 			/* block not cached. */
 			if (!bh)
diff --git a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
index 6c13a8d9a73c..2b288b1539d9 100644
--- a/fs/reiserfs/fix_node.c
+++ b/fs/reiserfs/fix_node.c
@@ -2332,7 +2332,7 @@ static void tb_buffer_sanity_check(struct super_block *sb,
 				       "in tree %s[%d] (%b)",
 				       descr, level, bh);
 
-		if (bh->b_bdev != sb->s_bdev)
+		if (bh_bdev(bh) != sb->s_bdev)
 			reiserfs_panic(sb, "jmacd-4", "buffer has wrong "
 				       "device %s[%d] (%b)",
 				       descr, level, bh);
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 6474529c4253..4d07d2f26317 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -618,7 +618,7 @@ static void reiserfs_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 	if (buffer_journaled(bh)) {
 		reiserfs_warning(NULL, "clm-2084",
 				 "pinned buffer %lu:%pg sent to disk",
-				 bh->b_blocknr, bh->b_bdev);
+				 bh->b_blocknr, bh_bdev(bh));
 	}
 	if (uptodate)
 		set_buffer_uptodate(bh);
@@ -2315,7 +2315,7 @@ static int journal_read_transaction(struct super_block *sb,
  * from other places.
  * Note: Do not use journal_getblk/sb_getblk functions here!
  */
-static struct buffer_head *reiserfs_breada(struct block_device *dev,
+static struct buffer_head *reiserfs_breada(struct file *bdev_file,
 					   b_blocknr_t block, int bufsize,
 					   b_blocknr_t max_block)
 {
@@ -2324,7 +2324,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	struct buffer_head *bh;
 	int i, j;
 
-	bh = __getblk(dev, block, bufsize);
+	bh = __getblk(bdev_file, block, bufsize);
 	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
@@ -2334,7 +2334,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	bhlist[0] = bh;
 	j = 1;
 	for (i = 1; i < blocks; i++) {
-		bh = __getblk(dev, block + i, bufsize);
+		bh = __getblk(bdev_file, block + i, bufsize);
 		if (!bh)
 			break;
 		if (buffer_uptodate(bh)) {
@@ -2447,7 +2447,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(file_bdev(journal->j_bdev_file), cur_dblock,
+		    reiserfs_breada(journal->j_bdev_file, cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 84a194b77f19..249a458b6e28 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -156,7 +156,7 @@ static int scnprintf_buffer_head(char *buf, size_t size, struct buffer_head *bh)
 {
 	return scnprintf(buf, size,
 			 "dev %pg, size %zd, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-			 bh->b_bdev, bh->b_size,
+			 bh_bdev(bh), bh->b_size,
 			 (unsigned long long)bh->b_blocknr,
 			 atomic_read(&(bh->b_count)),
 			 bh->b_state, bh->b_page,
@@ -561,7 +561,7 @@ static int print_super_block(struct buffer_head *bh)
 		return 1;
 	}
 
-	printk("%pg\'s super block is in block %llu\n", bh->b_bdev,
+	printk("%pg\'s super block is in block %llu\n", bh_bdev(bh),
 	       (unsigned long long)bh->b_blocknr);
 	printk("Reiserfs version %s\n", version);
 	printk("Block count %u\n", sb_block_count(rs));
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index f0e1f29f20ee..49caa7c42fb7 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2810,10 +2810,10 @@ struct reiserfs_journal_header {
 
 /* We need these to make journal.c code more readable */
 #define journal_find_get_block(s, block) __find_get_block(\
-		file_bdev(SB_JOURNAL(s)->j_bdev_file), block, s->s_blocksize)
-#define journal_getblk(s, block) __getblk(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
+		SB_JOURNAL(s)->j_bdev_file, block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_bdev_file,\
 		block, s->s_blocksize)
-#define journal_bread(s, block) __bread(file_bdev(SB_JOURNAL(s)->j_bdev_file),\
+#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_bdev_file,\
 		block, s->s_blocksize)
 
 enum reiserfs_bh_state_bits {
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 5faf702f8d15..23998f071d9c 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -331,7 +331,7 @@ static inline int key_in_buffer(
 	       || chk_path->path_length > MAX_HEIGHT,
 	       "PAP-5050: pointer to the key(%p) is NULL or invalid path length(%d)",
 	       key, chk_path->path_length);
-	RFALSE(!PATH_PLAST_BUFFER(chk_path)->b_bdev,
+	RFALSE(!bh_bdev(PATH_PLAST_BUFFER(chk_path)),
 	       "PAP-5060: device must not be NODEV");
 
 	if (comp_keys(get_lkey(chk_path, sb), key) == 1)
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index 2cec61af2a9e..f38dfae74e32 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -187,7 +187,7 @@ void reiserfs_unmap_buffer(struct buffer_head *bh)
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
-	bh->b_bdev = NULL;
+	bh->b_bdev_file = NULL;
 	unlock_buffer(bh);
 }
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 18c8f168b153..c06d41bbb919 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -125,7 +125,7 @@ xfs_bmbt_to_iomap(
 	if (mapping_flags & IOMAP_DAX)
 		iomap->dax_dev = target->bt_daxdev;
 	else
-		iomap->bdev = target->bt_bdev;
+		iomap->bdev_file = target->bt_bdev_file;
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
@@ -150,7 +150,7 @@ xfs_hole_to_iomap(
 	iomap->type = IOMAP_HOLE;
 	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
-	iomap->bdev = target->bt_bdev;
+	iomap->bdev_file = target->bt_bdev_file;
 	iomap->dax_dev = target->bt_daxdev;
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 8dab4c2ad300..e454d08ad7d0 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -38,7 +38,7 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	 * act as if there is a hole up to the file maximum size.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev_file = inode->i_sb->s_bdev_file;
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	isize = i_size_read(inode);
 	if (iomap->offset >= isize) {
@@ -88,7 +88,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	 * write pointer) and unwriten beyond.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev_file = inode->i_sb->s_bdev_file;
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
 	isize = i_size_read(inode);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1c07848dea7e..79c652f42e57 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,7 +49,6 @@ struct block_device {
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
-	struct inode		*bd_inode;	/* will die */
 
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3fb02e3a527a..f3bc2e77999a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1524,6 +1524,8 @@ struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
 bool disk_live(struct gendisk *disk);
 unsigned int block_size(struct block_device *bdev);
+void clean_bdev_aliases2(struct block_device *bdev, sector_t block,
+			 sector_t len);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..863af22f24c4 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/blk_types.h>
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
@@ -34,6 +35,7 @@ enum bh_state_bits {
 	BH_Meta,	/* Buffer contains metadata */
 	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
 	BH_Defer_Completion, /* Defer AIO completion to workqueue */
+	BH_Bdev,
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -68,7 +70,10 @@ struct buffer_head {
 	size_t b_size;			/* size of mapping */
 	char *b_data;			/* pointer to data within the page */
 
-	struct block_device *b_bdev;
+	union {
+		struct file *b_bdev_file;
+		struct block_device *b_bdev;
+	};
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
@@ -135,6 +140,14 @@ BUFFER_FNS(Unwritten, unwritten)
 BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
+BUFFER_FNS(Bdev, bdev)
+
+static __always_inline struct block_device *bh_bdev(struct buffer_head *bh)
+{
+	if (buffer_bdev(bh))
+		return bh->b_bdev;
+	return file_bdev(bh->b_bdev_file);
+}
 
 static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
 {
@@ -212,24 +225,33 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 				  bool datasync);
 int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
 			  bool datasync);
-void clean_bdev_aliases(struct block_device *bdev, sector_t block,
-			sector_t len);
+void __clean_bdev_aliases(struct inode *inode, sector_t block, sector_t len);
+
+static inline void clean_bdev_aliases(struct file *bdev_file, sector_t block,
+				      sector_t len)
+{
+	return __clean_bdev_aliases(file_inode(bdev_file), block, len);
+}
+
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 {
-	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
+	if (buffer_bdev(bh))
+		clean_bdev_aliases2(bh->b_bdev, bh->b_blocknr, 1);
+	else
+		clean_bdev_aliases(bh->b_bdev_file, bh->b_blocknr, 1);
 }
 
 void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
-struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
+struct buffer_head *__find_get_block(struct file *bdev_file, sector_t block,
 			unsigned size);
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+struct buffer_head *bdev_getblk(struct file *bdev_file, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
-void __breadahead(struct block_device *, sector_t block, unsigned int size);
-struct buffer_head *__bread_gfp(struct block_device *,
+void __breadahead(struct file *bdev_file, sector_t block, unsigned int size);
+struct buffer_head *__bread_gfp(struct file *bdev_file,
 				sector_t block, unsigned size, gfp_t gfp);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
@@ -239,7 +261,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *bdev_file,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
@@ -318,66 +340,67 @@ static inline void bforget(struct buffer_head *bh)
 static inline struct buffer_head *
 sb_bread(struct super_block *sb, sector_t block)
 {
-	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+	return __bread_gfp(sb->s_bdev_file, block, sb->s_blocksize,
+			   __GFP_MOVABLE);
 }
 
 static inline struct buffer_head *
 sb_bread_unmovable(struct super_block *sb, sector_t block)
 {
-	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
+	return __bread_gfp(sb->s_bdev_file, block, sb->s_blocksize, 0);
 }
 
 static inline void
 sb_breadahead(struct super_block *sb, sector_t block)
 {
-	__breadahead(sb->s_bdev, block, sb->s_blocksize);
+	__breadahead(sb->s_bdev_file, block, sb->s_blocksize);
 }
 
-static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
+static inline struct buffer_head *getblk_unmovable(struct file *bdev_file,
 		sector_t block, unsigned size)
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_file->f_mapping, ~__GFP_FS);
 	gfp |= __GFP_NOFAIL;
 
-	return bdev_getblk(bdev, block, size, gfp);
+	return bdev_getblk(bdev_file, block, size, gfp);
 }
 
-static inline struct buffer_head *__getblk(struct block_device *bdev,
+static inline struct buffer_head *__getblk(struct file *bdev_file,
 		sector_t block, unsigned size)
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_file->f_mapping, ~__GFP_FS);
 	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
 
-	return bdev_getblk(bdev, block, size, gfp);
+	return bdev_getblk(bdev_file, block, size, gfp);
 }
 
 static inline struct buffer_head *sb_getblk(struct super_block *sb,
 		sector_t block)
 {
-	return __getblk(sb->s_bdev, block, sb->s_blocksize);
+	return __getblk(sb->s_bdev_file, block, sb->s_blocksize);
 }
 
 static inline struct buffer_head *sb_getblk_gfp(struct super_block *sb,
 		sector_t block, gfp_t gfp)
 {
-	return bdev_getblk(sb->s_bdev, block, sb->s_blocksize, gfp);
+	return bdev_getblk(sb->s_bdev_file, block, sb->s_blocksize, gfp);
 }
 
 static inline struct buffer_head *
 sb_find_get_block(struct super_block *sb, sector_t block)
 {
-	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
+	return __find_get_block(sb->s_bdev_file, block, sb->s_blocksize);
 }
 
 static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
 	set_buffer_mapped(bh);
-	bh->b_bdev = sb->s_bdev;
+	bh->b_bdev_file = sb->s_bdev_file;
 	bh->b_blocknr = block;
 	bh->b_size = sb->s_blocksize;
 }
@@ -438,7 +461,7 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
 
 /**
  *  __bread() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
+ *  @bdev_file: the opened block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  *
@@ -447,9 +470,9 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
  *  It returns NULL if the block was unreadable.
  */
 static inline struct buffer_head *
-__bread(struct block_device *bdev, sector_t block, unsigned size)
+__bread(struct file *bdev_file, sector_t block, unsigned int size)
 {
-	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
+	return __bread_gfp(bdev_file, block, size, __GFP_MOVABLE);
 }
 
 /**
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..176b202a2c7d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -77,6 +77,7 @@ struct vm_fault;
  */
 #define IOMAP_F_SIZE_CHANGED	(1U << 8)
 #define IOMAP_F_STALE		(1U << 9)
+#define IOMAP_F_BDEV		(1U << 10)
 
 /*
  * Flags from 0x1000 up are for file system specific usage:
@@ -97,7 +98,11 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
-	struct block_device	*bdev;	/* block device for I/O */
+	union {
+		/* block device for I/O */
+		struct block_device	*bdev;
+		struct file		*bdev_file;
+	};
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
@@ -105,6 +110,13 @@ struct iomap {
 	u64			validity_cookie; /* used with .iomap_valid() */
 };
 
+static inline struct block_device *iomap_bdev(const struct iomap *iomap)
+{
+	if (iomap->flags & IOMAP_F_BDEV)
+		return iomap->bdev;
+	return file_bdev(iomap->bdev_file);
+}
+
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..95d3ed978864 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -26,7 +26,7 @@ DECLARE_EVENT_CLASS(block_buffer,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= bh->b_bdev->bd_dev;
+		__entry->dev		= bh_bdev(bh)->bd_dev;
 		__entry->sector		= bh->b_blocknr;
 		__entry->size		= bh->b_size;
 	),
-- 
2.39.2


