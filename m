Return-Path: <linux-fsdevel+bounces-16291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420B89AA0F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A661C20F0E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2340BF0;
	Sat,  6 Apr 2024 09:17:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D03C092;
	Sat,  6 Apr 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395078; cv=none; b=S19tmRAADlGl2CFkE1BLsLu5f3IZwPqrXooFfcPn7XdSMqA38hyJhVKznF/7UcWm6WQqctTZvLR4QKIg85LGtQB6ItxhR6xCNkJ1VLYbW1amY8sFHC+fAPTlw8FHDiVl6Kz2o1gEzQAefDuBrBVuJ8Vg7330bt0u/76DI0kE6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395078; c=relaxed/simple;
	bh=saNPSwf7+Kc5VskVq4X9Yf9v8StZ+QKsIgEh1fzfkGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCpwoNeSS9Rhjs+6XPX1tiXH/2rzIZPcMbKB0MclGOHAnrCTN/DXNSg0aXxmzA1tXi1dy/hGEBzsWSgvznTAAaH52ThcYPUrVRyBs5XKD9+i4pQSAt1evB3WNkDpzTfpM5aRZXWCJ3HZoi/rfmNMUtt3pqoCQJJ6yIemyCN5F1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBJ3kJCz4f3lg7;
	Sat,  6 Apr 2024 17:17:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 026F61A0568;
	Sat,  6 Apr 2024 17:17:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S30;
	Sat, 06 Apr 2024 17:17:52 +0800 (CST)
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
Subject: [PATCH vfs.all 26/26] buffer: convert to use bdev_file
Date: Sat,  6 Apr 2024 17:09:30 +0800
Message-Id: <20240406090930.2252838-27-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S30
X-Coremail-Antispam: 1UD129KBjvAXoWfAryxJFyUJFy8WF4kXr13Arb_yoW5Kw4Uto
	Waqw4fZF4rt3yUJ34IyryvqryUZayDKw13Jr4rGFZ0v3Z5tw1jk343KF45J34fG3WFkryY
	gryfJw4ruF4UCr48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

With previous commit both filesystems and raw block device provide
bdev_file, it's safe to convert to use bdev_file. Now that there are no
users of bd_inode anymore, remove bd_inode from block_device as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c                |  1 -
 fs/buffer.c                 | 96 +++++++++++++++++++------------------
 fs/direct-io.c              |  2 +-
 fs/ext2/inode.c             |  2 +-
 fs/ext4/super.c             |  4 +-
 fs/jbd2/journal.c           |  6 +--
 fs/jbd2/recovery.c          |  9 ++--
 fs/jbd2/revoke.c            | 14 +++---
 fs/mpage.c                  |  8 ++--
 fs/nilfs2/recovery.c        | 27 +++++++----
 fs/ntfs3/fsntfs.c           | 10 ++--
 fs/ntfs3/super.c            |  6 +--
 fs/ocfs2/journal.c          |  2 +-
 fs/reiserfs/journal.c       |  8 ++--
 fs/reiserfs/reiserfs.h      |  6 +--
 include/linux/blk_types.h   |  1 -
 include/linux/buffer_head.h | 67 +++++++++++++-------------
 17 files changed, 141 insertions(+), 128 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3d300823da6b..31972a7bd358 100644
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
diff --git a/fs/buffer.c b/fs/buffer.c
index e4d74eb63265..a84e9878b52f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
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
@@ -655,10 +655,12 @@ EXPORT_SYMBOL(generic_buffers_fsync);
  * `bblock + 1' is probably a dirty indirect block.  Hunt it down and, if it's
  * dirty, schedule it for IO.  So that indirects merge nicely with their data.
  */
-void write_boundary_block(struct block_device *bdev,
-			sector_t bblock, unsigned blocksize)
+void write_boundary_block(struct file *bdev_file, sector_t bblock,
+			  unsigned int blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh = __find_get_block(bdev_file, bblock + 1,
+						  blocksize);
+
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -992,21 +994,21 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 
 /*
  * Initialise the state of a blockdev folio's buffers.
- */ 
-static sector_t folio_init_buffers(struct folio *folio,
-		struct block_device *bdev, unsigned size)
+ */
+static sector_t folio_init_buffers(struct folio *folio, struct file *bdev_file,
+				   unsigned int size)
 {
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
 	bool uptodate = folio_test_uptodate(folio);
 	sector_t block = div_u64(folio_pos(folio), size);
-	sector_t end_block = blkdev_max_block(bdev, size);
+	sector_t end_block = blkdev_max_block(file_bdev(bdev_file), size);
 
 	do {
 		if (!buffer_mapped(bh)) {
 			bh->b_end_io = NULL;
 			bh->b_private = NULL;
-			bh->b_bdev = bdev;
+			bh->b_bdev_file = bdev_file;
 			bh->b_blocknr = block;
 			if (uptodate)
 				set_buffer_uptodate(bh);
@@ -1031,10 +1033,10 @@ static sector_t folio_init_buffers(struct folio *folio,
  * Returns false if we have a failure which cannot be cured by retrying
  * without sleeping.  Returns true if we succeeded, or the caller should retry.
  */
-static bool grow_dev_folio(struct block_device *bdev, sector_t block,
-		pgoff_t index, unsigned size, gfp_t gfp)
+static bool grow_dev_folio(struct file *bdev_file, sector_t block,
+			   pgoff_t index, unsigned int size, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = file_inode(bdev_file);
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block = 0;
@@ -1047,7 +1049,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = folio_init_buffers(folio, bdev, size);
+			end_block = folio_init_buffers(folio, bdev_file, size);
 			goto unlock;
 		}
 
@@ -1075,7 +1077,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->i_private_lock);
 	link_dev_buffers(folio, bh);
-	end_block = folio_init_buffers(folio, bdev, size);
+	end_block = folio_init_buffers(folio, bdev_file, size);
 	spin_unlock(&inode->i_mapping->i_private_lock);
 unlock:
 	folio_unlock(folio);
@@ -1088,8 +1090,8 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
  * that folio was dirty, the buffers are set dirty also.  Returns false
  * if we've hit a permanent error.
  */
-static bool grow_buffers(struct block_device *bdev, sector_t block,
-		unsigned size, gfp_t gfp)
+static bool grow_buffers(struct file *bdev_file, sector_t block,
+			 unsigned int size, gfp_t gfp)
 {
 	loff_t pos;
 
@@ -1100,18 +1102,20 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
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
+__getblk_slow(struct file *bdev_file, sector_t block, unsigned int size,
+	      gfp_t gfp)
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
@@ -1353,7 +1357,7 @@ static void bh_lru_install(struct buffer_head *bh)
  * Look up the bh in this cpu's LRU.  If it's there, move it to the head.
  */
 static struct buffer_head *
-lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
+lookup_bh_lru(struct file *bdev_file, sector_t block, unsigned int size)
 {
 	struct buffer_head *ret = NULL;
 	unsigned int i;
@@ -1367,8 +1371,8 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 
-		if (bh && bh->b_blocknr == block && bh_bdev(bh) == bdev &&
-		    bh->b_size == size) {
+		if (bh && bh->b_blocknr == block &&
+		    bh_bdev(bh) == file_bdev(bdev_file) && bh->b_size == size) {
 			if (i) {
 				while (i) {
 					__this_cpu_write(bh_lrus.bhs[i],
@@ -1392,13 +1396,13 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * NULL
  */
 struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+__find_get_block(struct file *bdev_file, sector_t block, unsigned int size)
 {
-	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
+	struct buffer_head *bh = lookup_bh_lru(bdev_file, block, size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev_file, block);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1410,32 +1414,32 @@ EXPORT_SYMBOL(__find_get_block);
 
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
- * @bdev: The block device.
+ * @bdev_file: The opened block device.
  * @block: The block number.
- * @size: The size of buffer_heads for this @bdev.
+ * @size: The size of buffer_heads for this @bdev_file.
  * @gfp: The memory allocation flags to use.
  *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
-		unsigned size, gfp_t gfp)
+struct buffer_head *bdev_getblk(struct file *bdev_file, sector_t block,
+				unsigned int size, gfp_t gfp)
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
@@ -1447,7 +1451,7 @@ EXPORT_SYMBOL(__breadahead);
 
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
+ *  @bdev_file: the opened block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  *  @gfp: page allocation flag
@@ -1458,12 +1462,12 @@ EXPORT_SYMBOL(__breadahead);
  *  It returns NULL if the block was unreadable.
  */
 struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
-		   unsigned size, gfp_t gfp)
+__bread_gfp(struct file *bdev_file, sector_t block, unsigned int size,
+	    gfp_t gfp)
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
@@ -1676,7 +1680,7 @@ EXPORT_SYMBOL(create_empty_buffers);
 
 /**
  * clean_bdev_aliases: clean a range of buffers in block device
- * @bdev: Block device to clean buffers in
+ * @bdev_file: Opened block device to clean buffers in
  * @block: Start of a range of blocks to clean
  * @len: Number of blocks to clean
  *
@@ -1694,9 +1698,9 @@ EXPORT_SYMBOL(create_empty_buffers);
  * I/O in bforget() - it's more efficient to wait on the I/O only if we really
  * need to.  That happens here.
  */
-void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
+void clean_bdev_aliases(struct file *bdev_file, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = file_inode(bdev_file);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
 	pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 49475f530e0f..dade4cea754b 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -948,7 +948,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					map_bh->b_blocknr << sdio->blkfactor;
 				if (buffer_new(map_bh)) {
 					clean_bdev_aliases(
-						bh_bdev(map_bh),
+						map_bh->b_bdev_file,
 						map_bh->b_blocknr,
 						map_bh->b_size >> i_blkbits);
 				}
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 6286d1578426..c8f59a61c95b 100644
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
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d47c1e7e8798..1516d58a16ec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
+	struct buffer_head *bh = bdev_getblk(sb->s_bdev_file, block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -5854,7 +5854,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
 	set_blocksize(bdev, blocksize);
-	bh = __bread(bdev, sb_block, blocksize);
+	bh = __bread(bdev_file, sb_block, blocksize);
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c1ce32d99267..6157496deec2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
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
index 1f7664984d6e..1685a139467a 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -92,7 +92,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
 			goto failed;
 		}
 
-		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+		bh = __getblk(journal->j_dev_file, blocknr,
+			      journal->j_blocksize);
 		if (!bh) {
 			err = -ENOMEM;
 			goto failed;
@@ -148,7 +149,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 		return err;
 	}
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->j_dev_file, blocknr, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -370,7 +371,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 		journal->j_head = journal->j_first;
 	} else {
 #ifdef CONFIG_JBD2_DEBUG
-		int dropped = info.end_transaction - 
+		int dropped = info.end_transaction -
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
@@ -672,7 +673,7 @@ static int do_one_pass(journal_t *journal,
 
 					/* Find a buffer for the new
 					 * data being restored */
-					nbh = __getblk(journal->j_fs_dev,
+					nbh = __getblk(journal->j_fs_dev_file,
 							blocknr,
 							journal->j_blocksize);
 					if (nbh == NULL) {
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..f464f84d08e6 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -328,7 +328,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 {
 	struct buffer_head *bh = NULL;
 	journal_t *journal;
-	struct block_device *bdev;
+	struct file *bdev_file;
 	int err;
 
 	might_sleep();
@@ -341,11 +341,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 		return -EINVAL;
 	}
 
-	bdev = journal->j_fs_dev;
+	bdev_file = journal->j_fs_dev_file;
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block(bdev_file, blocknr, journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +355,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(bdev_file, blocknr, journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -466,7 +466,9 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+
+		bh2 = __find_get_block(bh->b_bdev_file, bh->b_blocknr,
+				       bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -495,7 +497,7 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct jbd2_revoke_record_s *record;
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
-			bh = __find_get_block(journal->j_fs_dev,
+			bh = __find_get_block(journal->j_fs_dev_file,
 					      record->blocknr,
 					      journal->j_blocksize);
 			if (bh) {
diff --git a/fs/mpage.c b/fs/mpage.c
index 40594afa63cb..f01f06f20585 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -472,7 +472,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	struct block_device *bdev = NULL;
 	int boundary = 0;
 	sector_t boundary_block = 0;
-	struct block_device *boundary_bdev = NULL;
+	struct file *boundary_bdev_file = NULL;
 	size_t length;
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
@@ -513,7 +513,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			boundary = buffer_boundary(bh);
 			if (boundary) {
 				boundary_block = bh->b_blocknr;
-				boundary_bdev = bh->b_bdev;
+				boundary_bdev_file = bh->b_bdev_file;
 			}
 			bdev = bh_bdev(bh);
 		} while ((bh = bh->b_this_page) != head);
@@ -555,7 +555,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			clean_bdev_bh_alias(&map_bh);
 		if (buffer_boundary(&map_bh)) {
 			boundary_block = map_bh.b_blocknr;
-			boundary_bdev = map_bh.b_bdev;
+			boundary_bdev_file = map_bh.b_bdev_file;
 		}
 		if (page_block) {
 			if (map_bh.b_blocknr != first_block + page_block)
@@ -628,7 +628,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (boundary || (first_unmapped != blocks_per_page)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
-			write_boundary_block(boundary_bdev,
+			write_boundary_block(boundary_bdev_file,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 49a70c68bf3c..88e4f130c932 100644
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
index ae2ef5c11868..32085ede15ea 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1033,14 +1033,14 @@ struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
 
 int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 {
-	struct block_device *bdev = sb->s_bdev;
 	u32 blocksize = sb->s_blocksize;
 	u64 block = lbo >> sb->s_blocksize_bits;
 	u32 off = lbo & (blocksize - 1);
 	u32 op = blocksize - off;
 
 	for (; bytes; block += 1, off = 0, op = blocksize) {
-		struct buffer_head *bh = __bread(bdev, block, blocksize);
+		struct buffer_head *bh = __bread(sb->s_bdev_file, block,
+						 blocksize);
 
 		if (!bh)
 			return -EIO;
@@ -1063,7 +1063,7 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		  const void *buf, int wait)
 {
 	u32 blocksize = sb->s_blocksize;
-	struct block_device *bdev = sb->s_bdev;
+	struct file *bdev_file = sb->s_bdev_file;
 	sector_t block = lbo >> sb->s_blocksize_bits;
 	u32 off = lbo & (blocksize - 1);
 	u32 op = blocksize - off;
@@ -1077,14 +1077,14 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 			op = bytes;
 
 		if (op < blocksize) {
-			bh = __bread(bdev, block, blocksize);
+			bh = __bread(bdev_file, block, blocksize);
 			if (!bh) {
 				ntfs_err(sb, "failed to read block %llx",
 					 (u64)block);
 				return -EIO;
 			}
 		} else {
-			bh = __getblk(bdev, block, blocksize);
+			bh = __getblk(bdev_file, block, blocksize);
 			if (!bh)
 				return -ENOMEM;
 		}
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9df7c20d066f..d67becf7302e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1627,7 +1627,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
-	struct block_device *bdev = sb->s_bdev;
+	struct file *bdev_file = sb->s_bdev_file;
 	sector_t devblock = (u64)lcn * sbi->blocks_per_cluster;
 	unsigned long blocks = (u64)len * sbi->blocks_per_cluster;
 	unsigned long cnt = 0;
@@ -1642,9 +1642,9 @@ void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 		limit >>= 1;
 
 	while (blocks--) {
-		clean_bdev_aliases(bdev, devblock++, 1);
+		clean_bdev_aliases(bdev_file, devblock++, 1);
 		if (cnt++ >= limit) {
-			sync_blockdev(bdev);
+			filemap_write_and_wait(bdev_file->f_mapping);
 			cnt = 0;
 		}
 	}
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
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 724113cb79d3..3961f406ee7e 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
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
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 22f736908cbe..d0907c079779 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -50,7 +50,6 @@ struct block_device {
 	bool			bd_write_holder;
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
-	struct inode		*bd_inode;	/* will die */
 
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 4c6f0d0332c8..cebff2645d59 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -69,7 +69,7 @@ struct buffer_head {
 	size_t b_size;			/* size of mapping */
 	char *b_data;			/* pointer to data within the page */
 
-	struct block_device *b_bdev;
+	struct file *b_bdev_file;
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
@@ -140,18 +140,18 @@ BUFFER_FNS(Defer_Completion, defer_completion)
 static __always_inline void bh_set_bdev_file(struct buffer_head *bh,
 					     struct file *bdev_file)
 {
-	bh->b_bdev = bdev_file ? file_bdev(bdev_file) : NULL;
+	bh->b_bdev_file = bdev_file;
 }
 
 static __always_inline void bh_copy_bdev_file(struct buffer_head *dbh,
 					      struct buffer_head *sbh)
 {
-	dbh->b_bdev = sbh->b_bdev;
+	dbh->b_bdev_file = sbh->b_bdev_file;
 }
 
 static __always_inline struct block_device *bh_bdev(struct buffer_head *bh)
 {
-	return bh->b_bdev;
+	return bh->b_bdev_file ? file_bdev(bh->b_bdev_file) : NULL;
 }
 
 static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
@@ -230,25 +230,24 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 				  bool datasync);
 int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
 			  bool datasync);
-void clean_bdev_aliases(struct block_device *bdev, sector_t block,
-			sector_t len);
+void clean_bdev_aliases(struct file *bdev_file, sector_t block, sector_t len);
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 {
-	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
+	clean_bdev_aliases(bh->b_bdev_file, bh->b_blocknr, 1);
 }
 
 void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
-struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
-			unsigned size);
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
-		unsigned size, gfp_t gfp);
+struct buffer_head *__find_get_block(struct file *bdev_file, sector_t block,
+				     unsigned int size);
+struct buffer_head *bdev_getblk(struct file *bdev_file, sector_t block,
+				unsigned int size, gfp_t gfp);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
-void __breadahead(struct block_device *, sector_t block, unsigned int size);
-struct buffer_head *__bread_gfp(struct block_device *,
-				sector_t block, unsigned size, gfp_t gfp);
+void __breadahead(struct file *bdev_file, sector_t block, unsigned int size);
+struct buffer_head *__bread_gfp(struct file *bdev_file, sector_t block,
+				unsigned int size, gfp_t gfp);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -257,8 +256,8 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
-void write_boundary_block(struct block_device *bdev,
-			sector_t bblock, unsigned blocksize);
+void write_boundary_block(struct file *bdev_file, sector_t bblock,
+			  unsigned int blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
@@ -336,59 +335,61 @@ static inline void bforget(struct buffer_head *bh)
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
-		sector_t block, unsigned size)
+static inline struct buffer_head *getblk_unmovable(struct file *bdev_file,
+						   sector_t block,
+						   unsigned int size)
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_file->f_mapping, ~__GFP_FS);
 	gfp |= __GFP_NOFAIL;
 
-	return bdev_getblk(bdev, block, size, gfp);
+	return bdev_getblk(bdev_file, block, size, gfp);
 }
 
-static inline struct buffer_head *__getblk(struct block_device *bdev,
-		sector_t block, unsigned size)
+static inline struct buffer_head *__getblk(struct file *bdev_file,
+					   sector_t block, unsigned int size)
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
@@ -456,7 +457,7 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
 
 /**
  *  __bread() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
+ *  @bdev_file: the opened block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  *
@@ -465,9 +466,9 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
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
-- 
2.39.2


