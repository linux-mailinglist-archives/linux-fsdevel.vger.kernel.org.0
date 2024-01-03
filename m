Return-Path: <linux-fsdevel+bounces-7215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D167822DE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FFA285C49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED331CAAA;
	Wed,  3 Jan 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5pgGJ2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBA1CA91;
	Wed,  3 Jan 2024 12:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14368C4339A;
	Wed,  3 Jan 2024 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704286600;
	bh=DkTQ2uWC2bPHGoGYF7ID+i42KGRRC/cXMHjU4dFopLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5pgGJ2c8l2INmEdUgOxoMeGhUE2UgS31/w/4r5F756oKIEZ7HooaDc6lhjKnDUM+
	 U7VJ7YZ8KVVQfMIM93754H80rbgULEHXG4+mijCJ8+U7TfI0IK3Md9nCIfUGczp5oR
	 bFFSnxPY/U05Hsryut6YNytVuxJKG77+PnG1RIMq33ApFH+VwcZrcdFFogCiBGll5h
	 2dQnEA2aqdoQxToijs2YwODpHevT4u5zoksMUqURwQjqVkUTHzHSjddxLQ334hXFSt
	 n3rWkOboM1ZXBBBKDHxPE1oD8isJ8UbwClwqpoHzLs2RstiZzEZYteEFWoDkqgJaai
	 bG1SSxt5T8vjA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 03 Jan 2024 13:55:32 +0100
Subject: [PATCH DRAFT RFC 34/34] buffer: port block device access to files
 and get rid of bd_inode access
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-vfs-bdev-file-v1-34-6c8ee55fb6ef@kernel.org>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=52787; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DkTQ2uWC2bPHGoGYF7ID+i42KGRRC/cXMHjU4dFopLw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaROjbSbI5bXVsaXbHd8QXCr5edpD3P51yzjPvQ/RvbGe
 47jfbt+dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkcDLD/6SDtdlL1f93xsyp
 edpU+EbZlndG0YfPsvw7T7JPsrx9I53hn9YOqcJQ94aoA9cPPnydfXx/sBMby6vz/42zEvVF76z
 gYAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/fops.c                  |  1 +
 drivers/md/md-bitmap.c        |  1 +
 fs/affs/file.c                |  1 +
 fs/btrfs/inode.c              |  1 +
 fs/buffer.c                   | 69 ++++++++++++++++++++++---------------------
 fs/direct-io.c                |  2 +-
 fs/erofs/data.c               |  7 +++--
 fs/erofs/internal.h           |  1 +
 fs/erofs/zmap.c               |  1 +
 fs/ext2/inode.c               |  8 +++--
 fs/ext4/inode.c               |  6 ++--
 fs/ext4/super.c               |  6 ++--
 fs/f2fs/data.c                |  6 +++-
 fs/f2fs/f2fs.h                |  1 +
 fs/fuse/dax.c                 |  1 +
 fs/gfs2/aops.c                |  1 +
 fs/gfs2/bmap.c                |  1 +
 fs/hpfs/file.c                |  1 +
 fs/jbd2/commit.c              |  1 +
 fs/jbd2/journal.c             | 26 +++++++++-------
 fs/jbd2/recovery.c            |  6 ++--
 fs/jbd2/revoke.c              | 10 +++----
 fs/jbd2/transaction.c         |  1 +
 fs/mpage.c                    |  5 +++-
 fs/nilfs2/btnode.c            |  2 ++
 fs/nilfs2/gcinode.c           |  1 +
 fs/nilfs2/mdt.c               |  1 +
 fs/nilfs2/page.c              |  2 ++
 fs/nilfs2/recovery.c          | 20 ++++++-------
 fs/nilfs2/the_nilfs.c         |  1 +
 fs/ntfs/aops.c                |  3 ++
 fs/ntfs/file.c                |  1 +
 fs/ntfs/mft.c                 |  2 ++
 fs/ntfs3/fsntfs.c             |  8 ++---
 fs/ntfs3/inode.c              |  1 +
 fs/ntfs3/super.c              |  2 +-
 fs/ocfs2/journal.c            |  2 +-
 fs/reiserfs/journal.c         |  8 ++---
 fs/reiserfs/reiserfs.h        |  6 ++--
 fs/reiserfs/tail_conversion.c |  1 +
 fs/xfs/xfs_iomap.c            |  7 +++--
 fs/zonefs/file.c              |  2 ++
 include/linux/buffer_head.h   | 45 +++++++++++++++-------------
 include/linux/iomap.h         |  1 +
 include/linux/jbd2.h          |  6 ++--
 45 files changed, 172 insertions(+), 114 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e831196dafac..6557b71c7657 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -381,6 +381,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	loff_t isize = i_size_read(inode);
 
 	iomap->bdev = bdev;
+	BUG_ON(true /* TODO(brauner): This is the only place where we don't go from inode->i_sb->s_f_bdev for obvious reasons. Thoughts? */);
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	if (iomap->offset >= isize)
 		return -EIO;
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9672f75c3050..489d9c74e1af 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -380,6 +380,7 @@ static int read_file_page(struct file *file, unsigned long index,
 			}
 
 			bh->b_blocknr = block;
+			bh->f_b_bdev = inode->i_sb->s_f_bdev;
 			bh->b_bdev = inode->i_sb->s_bdev;
 			if (count < blocksize)
 				count = 0;
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 04c018e19602..7b62430d7052 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -366,6 +366,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 	brelse(ext_bh);
 	clear_buffer_mapped(bh_result);
 	bh_result->b_bdev = NULL;
+	bh_result->f_b_bdev = NULL;
 	// unlock cache
 	affs_unlock_ext(inode);
 	return -ENOSPC;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fb3c3f43c3fa..ee895a8be28d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7647,6 +7647,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	}
 	iomap->offset = start;
 	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap->f_bdev = fs_info->fs_devices->latest_dev->f_bdev;
 	iomap->length = len;
 	free_extent_map(em);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 5ffc44ab4854..17191d33974f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -187,9 +187,9 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * succeeds, there is no need to take i_private_lock.
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct file *f_bdev, sector_t block)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(f_bdev);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct buffer_head *ret = NULL;
 	pgoff_t index;
@@ -232,7 +232,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 		       "device %pg blocksize: %d\n",
 		       (unsigned long long)block,
 		       (unsigned long long)bh->b_blocknr,
-		       bh->b_state, bh->b_size, bdev,
+		       bh->b_state, bh->b_size, F_BDEV(f_bdev),
 		       1 << bd_inode->i_blkbits);
 	}
 out_unlock:
@@ -656,10 +656,10 @@ EXPORT_SYMBOL(generic_buffers_fsync);
  * `bblock + 1' is probably a dirty indirect block.  Hunt it down and, if it's
  * dirty, schedule it for IO.  So that indirects merge nicely with their data.
  */
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *f_bdev,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh = __find_get_block(f_bdev, bblock + 1, blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -995,18 +995,19 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
  * Initialise the state of a blockdev folio's buffers.
  */ 
 static sector_t folio_init_buffers(struct folio *folio,
-		struct block_device *bdev, sector_t block, int size)
+		struct file *f_bdev, sector_t block, int size)
 {
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
 	bool uptodate = folio_test_uptodate(folio);
-	sector_t end_block = blkdev_max_block(bdev, size);
+	sector_t end_block = blkdev_max_block(F_BDEV(f_bdev), size);
 
 	do {
 		if (!buffer_mapped(bh)) {
 			bh->b_end_io = NULL;
 			bh->b_private = NULL;
-			bh->b_bdev = bdev;
+			bh->b_bdev = F_BDEV(f_bdev);
+			bh->f_b_bdev = f_bdev;
 			bh->b_blocknr = block;
 			if (uptodate)
 				set_buffer_uptodate(bh);
@@ -1029,10 +1030,10 @@ static sector_t folio_init_buffers(struct folio *folio,
  * This is used purely for blockdev mappings.
  */
 static int
-grow_dev_page(struct block_device *bdev, sector_t block,
+grow_dev_page(struct file *f_bdev, sector_t block,
 	      pgoff_t index, int size, int sizebits, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_file_inode(f_bdev);
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block;
@@ -1046,7 +1047,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = folio_init_buffers(folio, bdev,
+			end_block = folio_init_buffers(folio, f_bdev,
 					(sector_t)index << sizebits, size);
 			goto done;
 		}
@@ -1066,7 +1067,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->i_private_lock);
 	link_dev_buffers(folio, bh);
-	end_block = folio_init_buffers(folio, bdev,
+	end_block = folio_init_buffers(folio, f_bdev,
 			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->i_private_lock);
 done:
@@ -1082,7 +1083,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
  * that page was dirty, the buffers are set dirty also.
  */
 static int
-grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
+grow_buffers(struct file *f_bdev, sector_t block, int size, gfp_t gfp)
 {
 	pgoff_t index;
 	int sizebits;
@@ -1098,25 +1099,25 @@ grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 		printk(KERN_ERR "%s: requested out-of-range block %llu for "
 			"device %pg\n",
 			__func__, (unsigned long long)block,
-			bdev);
+			F_BDEV(f_bdev));
 		return -EIO;
 	}
 
 	/* Create a page with the proper size buffers.. */
-	return grow_dev_page(bdev, block, index, size, sizebits, gfp);
+	return grow_dev_page(f_bdev, block, index, size, sizebits, gfp);
 }
 
 static struct buffer_head *
-__getblk_slow(struct block_device *bdev, sector_t block,
+__getblk_slow(struct file *f_bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
 	/* Size must be multiple of hard sectorsize */
-	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
+	if (unlikely(size & (bdev_logical_block_size(F_BDEV(f_bdev))-1) ||
 			(size < 512 || size > PAGE_SIZE))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
 		printk(KERN_ERR "logical block size: %d\n",
-					bdev_logical_block_size(bdev));
+					bdev_logical_block_size(F_BDEV(f_bdev)));
 
 		dump_stack();
 		return NULL;
@@ -1126,11 +1127,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 		struct buffer_head *bh;
 		int ret;
 
-		bh = __find_get_block(bdev, block, size);
+		bh = __find_get_block(f_bdev, block, size);
 		if (bh)
 			return bh;
 
-		ret = grow_buffers(bdev, block, size, gfp);
+		ret = grow_buffers(f_bdev, block, size, gfp);
 		if (ret < 0)
 			return NULL;
 	}
@@ -1392,13 +1393,13 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * NULL
  */
 struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+__find_get_block(struct file *f_bdev, sector_t block, unsigned size)
 {
-	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
+	struct buffer_head *bh = lookup_bh_lru(F_BDEV(f_bdev), block, size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(f_bdev, block);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1417,25 +1418,25 @@ EXPORT_SYMBOL(__find_get_block);
  *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+struct buffer_head *bdev_getblk(struct file *f_bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	struct buffer_head *bh = __find_get_block(f_bdev, block, size);
 
 	might_alloc(gfp);
 	if (bh)
 		return bh;
 
-	return __getblk_slow(bdev, block, size, gfp);
+	return __getblk_slow(f_bdev, block, size, gfp);
 }
 EXPORT_SYMBOL(bdev_getblk);
 
 /*
  * Do async read-ahead on a buffer..
  */
-void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
+void __breadahead(struct file *f_bdev, sector_t block, unsigned size)
 {
-	struct buffer_head *bh = bdev_getblk(bdev, block, size,
+	struct buffer_head *bh = bdev_getblk(f_bdev, block, size,
 			GFP_NOWAIT | __GFP_MOVABLE);
 
 	if (likely(bh)) {
@@ -1458,12 +1459,12 @@ EXPORT_SYMBOL(__breadahead);
  *  It returns NULL if the block was unreadable.
  */
 struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
+__bread_gfp(struct file *f_bdev, sector_t block,
 		   unsigned size, gfp_t gfp)
 {
 	struct buffer_head *bh;
 
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= mapping_gfp_constraint(bdev_file_inode(f_bdev)->i_mapping, ~__GFP_FS);
 
 	/*
 	 * Prefer looping in the allocator rather than here, at least that
@@ -1471,7 +1472,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 	 */
 	gfp |= __GFP_NOFAIL;
 
-	bh = bdev_getblk(bdev, block, size, gfp);
+	bh = bdev_getblk(f_bdev, block, size, gfp);
 
 	if (likely(bh) && !buffer_uptodate(bh))
 		bh = __bread_slow(bh);
@@ -1565,6 +1566,7 @@ static void discard_buffer(struct buffer_head * bh)
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
 	bh->b_bdev = NULL;
+	bh->f_b_bdev = NULL;
 	b_state = READ_ONCE(bh->b_state);
 	do {
 	} while (!try_cmpxchg(&bh->b_state, &b_state,
@@ -1694,9 +1696,9 @@ EXPORT_SYMBOL(create_empty_buffers);
  * I/O in bforget() - it's more efficient to wait on the I/O only if we really
  * need to.  That happens here.
  */
-void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
+void clean_bdev_aliases(struct file *f_bdev, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(f_bdev);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
 	pgoff_t index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
@@ -2017,6 +2019,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 	loff_t offset = block << inode->i_blkbits;
 
 	bh->b_bdev = iomap->bdev;
+	bh->f_b_bdev = iomap->f_bdev;
 
 	/*
 	 * Block points to offset in file we need to map, iomap contains
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 60456263a338..7ee66552bddc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -946,7 +946,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					map_bh->b_blocknr << sdio->blkfactor;
 				if (buffer_new(map_bh)) {
 					clean_bdev_aliases(
-						map_bh->b_bdev,
+						map_bh->f_b_bdev,
 						map_bh->b_blocknr,
 						map_bh->b_size >> i_blkbits);
 				}
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fed9153f2b83..a7cdec57e226 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -204,6 +204,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	int id;
 
 	map->m_bdev = sb->s_bdev;
+	map->f_m_bdev = sb->s_f_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
@@ -275,10 +276,12 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->offset = map.m_la;
-	if (flags & IOMAP_DAX)
+	if (flags & IOMAP_DAX) {
 		iomap->dax_dev = mdev.m_daxdev;
-	else
+	} else {
 		iomap->bdev = mdev.m_bdev;
+		iomap->f_bdev = mdev.f_m_bdev;
+	}
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8ad8957de64c..2c55d7a7b79d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -377,6 +377,7 @@ enum {
 
 struct erofs_map_dev {
 	struct erofs_fscache *m_fscache;
+	struct file *f_m_bdev;
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
 	u64 m_dax_part_off;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7b55111fd533..90f6fb155400 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -741,6 +741,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 		return ret;
 
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->f_bdev = inode->i_sb->s_f_bdev;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 464faf6c217e..f92cd53a1b5c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -744,7 +744,7 @@ static int ext2_get_blocks(struct inode *inode,
 		 * We must unmap blocks before zeroing so that writeback cannot
 		 * overwrite zeros with stale data from block device page cache.
 		 */
-		clean_bdev_aliases(inode->i_sb->s_bdev,
+		clean_bdev_aliases(inode->i_sb->s_f_bdev,
 				   le32_to_cpu(chain[depth-1].key),
 				   count);
 		/*
@@ -839,10 +839,12 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->flags = 0;
 	iomap->offset = (u64)first_block << blkbits;
-	if (flags & IOMAP_DAX)
+	if (flags & IOMAP_DAX) {
 		iomap->dax_dev = sbi->s_daxdev;
-	else
+	} else {
 		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->f_bdev = inode->i_sb->s_f_bdev;
+	}
 
 	if (ret == 0) {
 		/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0558c8c986d4..6685801dde6f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3237,10 +3237,12 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (map->m_flags & EXT4_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
 
-	if (flags & IOMAP_DAX)
+	if (flags & IOMAP_DAX) {
 		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
-	else
+	} else {
 		iomap->bdev = inode->i_sb->s_bdev;
+		iomap->f_bdev = inode->i_sb->s_f_bdev;
+	}
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 40387ba598f4..97fa9f36c1dd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(F_BDEV(sb->s_f_bdev), block,
+	struct buffer_head *bh = bdev_getblk(sb->s_f_bdev, block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -5887,7 +5887,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
 	set_blocksize(bdev, blocksize);
-	bh = __bread(bdev, sb_block, blocksize);
+	bh = __bread(f_bdev, sb_block, blocksize);
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
@@ -5943,7 +5943,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	if (IS_ERR(f_bdev))
 		return ERR_CAST(f_bdev);
 
-	journal = jbd2_journal_init_dev(F_BDEV(f_bdev), F_BDEV(sb->s_f_bdev), j_start,
+	journal = jbd2_journal_init_dev(f_bdev, sb->s_f_bdev, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e42b5f24deb..dee05c392f88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1615,6 +1615,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto out;
 
 	map->m_bdev = inode->i_sb->s_bdev;
+	map->f_m_bdev = inode->i_sb->s_f_bdev;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
 
@@ -1733,8 +1734,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
 
-		if (map->m_multidev_dio)
+		if (map->m_multidev_dio) {
 			map->m_bdev = FDEV(bidx).bdev;
+			map->f_m_bdev = FDEV(bidx).f_bdev;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
@@ -4263,6 +4266,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
 		iomap->bdev = map.m_bdev;
+		iomap->f_bdev = map.f_m_bdev;
 		iomap->addr = blks_to_bytes(inode, map.m_pblk);
 	} else {
 		if (flags & IOMAP_WRITE)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9a73eed3b424..831d3f43a157 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -684,6 +684,7 @@ struct extent_tree_info {
 				F2FS_MAP_DELALLOC)
 
 struct f2fs_map_blocks {
+	struct file *f_m_bdev;	/* for multi-device dio */
 	struct block_device *m_bdev;	/* for multi-device dio */
 	block_t m_pblk;
 	block_t m_lblk;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..44ad0468e1da 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -576,6 +576,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 	iomap->offset = pos;
 	iomap->flags = 0;
 	iomap->bdev = NULL;
+	iomap->f_bdev = NULL;
 	iomap->dax_dev = fc->dax->dev;
 
 	/*
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 9611bfceda4b..6b327f6589b5 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -626,6 +626,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 		}
 	}
 	bh->b_bdev = NULL;
+	bh->f_b_bdev = NULL;
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index d9ccfd27e4f1..eaf6346ee602 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -927,6 +927,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 
 out:
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->f_bdev = inode->i_sb->s_f_bdev;
 unlock:
 	up_read(&ip->i_rw_mutex);
 	return ret;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1bb8d97cd9ae..a4d16f72c0de 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -129,6 +129,7 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return -EINVAL;
 
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->f_bdev = inode->i_sb->s_f_bdev;
 	iomap->offset = offset;
 
 	hpfs_lock(sb);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..2a0d8c8cc94d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1015,6 +1015,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_new(bh);
 				clear_buffer_req(bh);
 				bh->b_bdev = NULL;
+				bh->f_b_bdev = NULL;
 			}
 		}
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 206cb53ef2b0..4f5165ba7ff1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -435,6 +435,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
 	new_bh->b_bdev = journal->j_dev;
+	new_bh->f_b_bdev = journal->f_j_dev;
 	new_bh->b_blocknr = blocknr;
 	new_bh->b_private = bh_in;
 	set_buffer_mapped(new_bh);
@@ -880,7 +881,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (ret)
 		return ret;
 
-	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
+	bh = __getblk(journal->f_j_dev, pblock, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -1007,7 +1008,7 @@ jbd2_journal_get_descriptor_buffer(transaction_t *transaction, int type)
 	if (err)
 		return NULL;
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->f_j_dev, blocknr, journal->j_blocksize);
 	if (!bh)
 		return NULL;
 	atomic_dec(&transaction->t_outstanding_credits);
@@ -1461,7 +1462,7 @@ static int journal_load_superblock(journal_t *journal)
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
 
-	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
+	bh = getblk_unmovable(journal->f_j_dev, journal->j_blk_offset,
 			      journal->j_blocksize);
 	if (bh)
 		err = bh_read(bh, 0);
@@ -1516,11 +1517,12 @@ static int journal_load_superblock(journal_t *journal)
  * very few fields yet: that has to wait until we have created the
  * journal structures from from scratch, or loaded them from disk. */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
+static journal_t *journal_init_common(struct file *f_bdev,
+			struct file *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
 	static struct lock_class_key jbd2_trans_commit_key;
+	struct block_device *bdev = F_BDEV(f_bdev);
 	journal_t *journal;
 	int err;
 	int n;
@@ -1530,8 +1532,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 		return ERR_PTR(-ENOMEM);
 
 	journal->j_blocksize = blocksize;
-	journal->j_dev = bdev;
-	journal->j_fs_dev = fs_dev;
+	journal->f_j_dev = f_bdev;
+	journal->f_j_fs_dev = fs_dev;
+	journal->j_dev = F_BDEV(f_bdev);
+	journal->j_fs_dev = F_BDEV(fs_dev);
 	journal->j_blk_offset = start;
 	journal->j_total_len = len;
 
@@ -1639,13 +1643,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
+journal_t *jbd2_journal_init_dev(struct file *f_bdev,
+			struct file *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(f_bdev, fs_dev, start, len, blocksize);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1682,7 +1686,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
-	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
+	journal = journal_init_common(inode->i_sb->s_f_bdev, inode->i_sb->s_f_bdev,
 			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
 			inode->i_sb->s_blocksize);
 	if (IS_ERR(journal))
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 01f744cb97a4..6a2edc91b378 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -92,7 +92,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 			goto failed;
 		}
 
-		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+		bh = __getblk(journal->f_j_dev, blocknr, journal->j_blocksize);
 		if (!bh) {
 			err = -ENOMEM;
 			goto failed;
@@ -148,7 +148,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 		return err;
 	}
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->f_j_dev, blocknr, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -677,7 +677,7 @@ static int do_one_pass(journal_t *journal,
 
 					/* Find a buffer for the new
 					 * data being restored */
-					nbh = __getblk(journal->j_fs_dev,
+					nbh = __getblk(journal->f_j_fs_dev,
 							blocknr,
 							journal->j_blocksize);
 					if (nbh == NULL) {
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..8d21b2995ff8 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -328,7 +328,6 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 {
 	struct buffer_head *bh = NULL;
 	journal_t *journal;
-	struct block_device *bdev;
 	int err;
 
 	might_sleep();
@@ -341,11 +340,10 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 		return -EINVAL;
 	}
 
-	bdev = journal->j_fs_dev;
 	bh = bh_in;
 
 	if (!bh) {
-		bh = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh = __find_get_block(journal->f_j_fs_dev, blocknr, journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +353,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(journal->f_j_fs_dev, blocknr, journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -466,7 +464,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block(bh->f_b_bdev, bh->b_blocknr, bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -495,7 +493,7 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct jbd2_revoke_record_s *record;
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
-			bh = __find_get_block(journal->j_fs_dev,
+			bh = __find_get_block(journal->f_j_fs_dev,
 					      record->blocknr,
 					      journal->j_blocksize);
 			if (bh) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5f08b5fd105a..b7309b894c91 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2415,6 +2415,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	clear_buffer_delay(bh);
 	clear_buffer_unwritten(bh);
 	bh->b_bdev = NULL;
+	bh->f_b_bdev = NULL;
 	return may_free;
 }
 
diff --git a/fs/mpage.c b/fs/mpage.c
index ffb064ed9d04..f526ad5a8386 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -483,6 +483,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	int boundary = 0;
 	sector_t boundary_block = 0;
 	struct block_device *boundary_bdev = NULL;
+	struct file *f_boundary_bdev = NULL;
 	size_t length;
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
@@ -522,6 +523,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			if (boundary) {
 				boundary_block = bh->b_blocknr;
 				boundary_bdev = bh->b_bdev;
+				f_boundary_bdev = bh->f_b_bdev;
 			}
 			bdev = bh->b_bdev;
 		} while ((bh = bh->b_this_page) != head);
@@ -564,6 +566,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		if (buffer_boundary(&map_bh)) {
 			boundary_block = map_bh.b_blocknr;
 			boundary_bdev = map_bh.b_bdev;
+			f_boundary_bdev = map_bh.f_b_bdev;
 		}
 		if (page_block) {
 			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
@@ -633,7 +636,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (boundary || (first_unmapped != blocks_per_page)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
-			write_boundary_block(boundary_bdev,
+			write_boundary_block(f_boundary_bdev,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5710833ac1cc..9c6314e5cd7a 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -60,6 +60,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
 	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->f_b_bdev = inode->i_sb->f_s_bdev;
 	bh->b_blocknr = blocknr;
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
@@ -119,6 +120,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 	}
 	set_buffer_mapped(bh);
 	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->f_b_bdev = inode->i_sb->f_s_bdev;
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 8beb2730929d..f15f3b012d92 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -85,6 +85,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 
 	if (!buffer_mapped(bh)) {
 		bh->b_bdev = inode->i_sb->s_bdev;
+		bh->f_b_bdev = inode->i_sb->f_s_bdev;
 		set_buffer_mapped(bh);
 	}
 	bh->b_blocknr = pbn;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c97c77a39668..a7205ca74937 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -90,6 +90,7 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 		goto failed_bh;
 
 	bh->b_bdev = sb->s_bdev;
+	bh->f_b_bdev = sb->f_s_bdev;
 	err = nilfs_mdt_insert_new_block(inode, block, bh, init_block);
 	if (likely(!err)) {
 		get_bh(bh);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 06b04758f289..5809cfc99781 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -112,6 +112,7 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 	dbh->b_state = sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
 	dbh->b_blocknr = sbh->b_blocknr;
 	dbh->b_bdev = sbh->b_bdev;
+	dbh->f_b_bdev = sbh->f_b_bdev;
 
 	bh = dbh;
 	bits = sbh->b_state & (BIT(BH_Uptodate) | BIT(BH_Mapped));
@@ -216,6 +217,7 @@ static void nilfs_copy_folio(struct folio *dst, struct folio *src,
 		dbh->b_state = sbh->b_state & mask;
 		dbh->b_blocknr = sbh->b_blocknr;
 		dbh->b_bdev = sbh->b_bdev;
+		dbh->f_b_bdev = sbh->f_b_bdev;
 		sbh = sbh->b_this_page;
 		dbh = dbh->b_this_page;
 	} while (dbh != dbufs);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0955b657938f..cbd30496fca2 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -107,7 +107,7 @@ static int nilfs_compute_checksum(struct the_nilfs *nilfs,
 		do {
 			struct buffer_head *bh;
 
-			bh = __bread(nilfs->ns_bdev, ++start, blocksize);
+			bh = __bread(nilfs->ns_f_bdev, ++start, blocksize);
 			if (!bh)
 				return -EIO;
 			check_bytes -= size;
@@ -136,7 +136,7 @@ int nilfs_read_super_root_block(struct the_nilfs *nilfs, sector_t sr_block,
 	int ret;
 
 	*pbh = NULL;
-	bh_sr = __bread(nilfs->ns_bdev, sr_block, nilfs->ns_blocksize);
+	bh_sr = __bread(nilfs->ns_f_bdev, sr_block, nilfs->ns_blocksize);
 	if (unlikely(!bh_sr)) {
 		ret = NILFS_SEG_FAIL_IO;
 		goto failed;
@@ -183,7 +183,7 @@ nilfs_read_log_header(struct the_nilfs *nilfs, sector_t start_blocknr,
 {
 	struct buffer_head *bh_sum;
 
-	bh_sum = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh_sum = __bread(nilfs->ns_f_bdev, start_blocknr, nilfs->ns_blocksize);
 	if (bh_sum)
 		*sum = (struct nilfs_segment_summary *)bh_sum->b_data;
 	return bh_sum;
@@ -250,7 +250,7 @@ static void *nilfs_read_summary_info(struct the_nilfs *nilfs,
 	if (bytes > (*pbh)->b_size - *offset) {
 		blocknr = (*pbh)->b_blocknr;
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + 1,
+		*pbh = __bread(nilfs->ns_f_bdev, blocknr + 1,
 			       nilfs->ns_blocksize);
 		if (unlikely(!*pbh))
 			return NULL;
@@ -289,7 +289,7 @@ static void nilfs_skip_summary_info(struct the_nilfs *nilfs,
 		*offset = bytes * (count - (bcnt - 1) * nitem_per_block);
 
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + bcnt,
+		*pbh = __bread(nilfs->ns_f_bdev, blocknr + bcnt,
 			       nilfs->ns_blocksize);
 	}
 }
@@ -318,7 +318,7 @@ static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 
 	sumbytes = le32_to_cpu(sum->ss_sumbytes);
 	blocknr = start_blocknr + DIV_ROUND_UP(sumbytes, nilfs->ns_blocksize);
-	bh = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh = __bread(nilfs->ns_f_bdev, start_blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh))
 		goto out;
 
@@ -477,7 +477,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 	struct buffer_head *bh_org;
 	void *kaddr;
 
-	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
+	bh_org = __bread(nilfs->ns_f_bdev, rb->blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh_org))
 		return -EIO;
 
@@ -696,7 +696,7 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	    nilfs_get_segnum_of_block(nilfs, ri->ri_super_root))
 		return;
 
-	bh = __getblk(nilfs->ns_bdev, ri->ri_lsegs_start, nilfs->ns_blocksize);
+	bh = __getblk(nilfs->ns_f_bdev, ri->ri_lsegs_start, nilfs->ns_blocksize);
 	BUG_ON(!bh);
 	memset(bh->b_data, 0, bh->b_size);
 	set_buffer_dirty(bh);
@@ -822,7 +822,7 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 	/* Read ahead segment */
 	b = seg_start;
 	while (b <= seg_end)
-		__breadahead(nilfs->ns_bdev, b++, nilfs->ns_blocksize);
+		__breadahead(nilfs->ns_f_bdev, b++, nilfs->ns_blocksize);
 
 	for (;;) {
 		brelse(bh_sum);
@@ -868,7 +868,7 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 		if (pseg_start == seg_start) {
 			nilfs_get_segment_range(nilfs, nextnum, &b, &end);
 			while (b <= end)
-				__breadahead(nilfs->ns_bdev, b++,
+				__breadahead(nilfs->ns_f_bdev, b++,
 					     nilfs->ns_blocksize);
 		}
 		if (!(flags & NILFS_SS_SR)) {
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 71400496ed36..6908dd87f44c 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -63,6 +63,7 @@ struct the_nilfs *alloc_nilfs(struct super_block *sb)
 
 	nilfs->ns_sb = sb;
 	nilfs->ns_bdev = sb->s_bdev;
+	nilfs->ns_f_bdev = sb->s_f_bdev;
 	atomic_set(&nilfs->ns_ndirtyblks, 0);
 	init_rwsem(&nilfs->ns_sem);
 	mutex_init(&nilfs->ns_snapshot_mount_mutex);
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 548f3b51aa5f..cc31e38479ac 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -228,6 +228,7 @@ static int ntfs_read_block(struct folio *folio)
 			continue;
 		}
 		bh->b_bdev = vol->sb->s_bdev;
+		bh->f_b_bdev = vol->sb->s_f_bdev;
 		/* Is the block within the allowed limits? */
 		if (iblock < lblock) {
 			bool is_retry = false;
@@ -679,6 +680,7 @@ static int ntfs_write_block(struct folio *folio, struct writeback_control *wbc)
 
 		/* Unmapped, dirty buffer. Need to map it. */
 		bh->b_bdev = vol->sb->s_bdev;
+		bh->f_b_bdev = vol->sb->s_f_bdev;
 
 		/* Convert block into corresponding vcn and offset. */
 		vcn = (VCN)block << blocksize_bits;
@@ -989,6 +991,7 @@ static int ntfs_write_mst_block(struct page *page,
 			unsigned int vcn_ofs;
 
 			bh->b_bdev = vol->sb->s_bdev;
+			bh->f_b_bdev = vol->sb->s_f_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = (VCN)block << bh_size_bits;
 			vcn_ofs = vcn & vol->cluster_size_mask;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 297c0b9db621..e3f35d1550ed 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -681,6 +681,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 		}
 		/* Unmapped buffer.  Need to map it. */
 		bh->b_bdev = vol->sb->s_bdev;
+		bh->f_b_bdev = vol->sb->s_f_bdev;
 		/*
 		 * If the current buffer is in the same clusters as the map
 		 * cache, there is no need to check the runlist again.  The
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6fd1dc4b08c8..9193f2516d06 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -527,6 +527,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			unsigned int vcn_ofs;
 
 			bh->b_bdev = vol->sb->s_bdev;
+			bh->f_b_bdev = vol->sb->s_f_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
@@ -720,6 +721,7 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 			unsigned int vcn_ofs;
 
 			bh->b_bdev = vol->sb->s_bdev;
+			bh->f_b_bdev = vol->sb->s_f_bdev;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index fbfe21dbb425..c58efca1427b 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1015,7 +1015,7 @@ int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 	u32 op = blocksize - off;
 
 	for (; bytes; block += 1, off = 0, op = blocksize) {
-		struct buffer_head *bh = __bread(bdev, block, blocksize);
+		struct buffer_head *bh = __bread(sb->s_f_bdev, block, blocksize);
 
 		if (!bh)
 			return -EIO;
@@ -1052,14 +1052,14 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 			op = bytes;
 
 		if (op < blocksize) {
-			bh = __bread(bdev, block, blocksize);
+			bh = __bread(sb->s_f_bdev, block, blocksize);
 			if (!bh) {
 				ntfs_err(sb, "failed to read block %llx",
 					 (u64)block);
 				return -EIO;
 			}
 		} else {
-			bh = __getblk(bdev, block, blocksize);
+			bh = __getblk(sb->s_f_bdev, block, blocksize);
 			if (!bh)
 				return -ENOMEM;
 		}
@@ -2673,4 +2673,4 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 out:
 	__putname(uni);
 	return err;
-}
\ No newline at end of file
+}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5e3d71374918..daa8976c137c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -612,6 +612,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 
 	set_buffer_mapped(bh);
 	bh->b_bdev = sb->s_bdev;
+	bh->f_b_bdev = sb->s_f_bdev;
 	bh->b_blocknr = lbo >> sb->s_blocksize_bits;
 
 	valid = ni->i_valid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..f0f969d35b83 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1632,7 +1632,7 @@ void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 		limit >>= 1;
 
 	while (blocks--) {
-		clean_bdev_aliases(bdev, devblock++, 1);
+		clean_bdev_aliases(sb->s_f_bdev, devblock++, 1);
 		if (cnt++ >= limit) {
 			sync_blockdev(bdev);
 			cnt = 0;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 604fea3a26ff..20485bac26d2 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1209,7 +1209,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
 		}
 
 		for (i = 0; i < p_blocks; i++, p_blkno++) {
-			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
+			bh = __find_get_block(osb->sb->s_f_bdev, p_blkno,
 					osb->sb->s_blocksize);
 			/* block not cached. */
 			if (!bh)
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 177ccb4d9bc3..94b2663130c2 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2315,7 +2315,7 @@ static int journal_read_transaction(struct super_block *sb,
  * from other places.
  * Note: Do not use journal_getblk/sb_getblk functions here!
  */
-static struct buffer_head *reiserfs_breada(struct block_device *dev,
+static struct buffer_head *reiserfs_breada(struct file *f_dev,
 					   b_blocknr_t block, int bufsize,
 					   b_blocknr_t max_block)
 {
@@ -2324,7 +2324,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	struct buffer_head *bh;
 	int i, j;
 
-	bh = __getblk(dev, block, bufsize);
+	bh = __getblk(f_dev, block, bufsize);
 	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
@@ -2334,7 +2334,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	bhlist[0] = bh;
 	j = 1;
 	for (i = 1; i < blocks; i++) {
-		bh = __getblk(dev, block + i, bufsize);
+		bh = __getblk(f_dev, block + i, bufsize);
 		if (!bh)
 			break;
 		if (buffer_uptodate(bh)) {
@@ -2447,7 +2447,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(F_BDEV(journal->j_f_bdev), cur_dblock,
+		    reiserfs_breada(journal->j_f_bdev, cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index ea2f5950e5c6..61f5146e876f 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2810,10 +2810,10 @@ struct reiserfs_journal_header {
 
 /* We need these to make journal.c code more readable */
 #define journal_find_get_block(s, block) __find_get_block(\
-		F_BDEV(SB_JOURNAL(s)->j_f_bdev), block, s->s_blocksize)
-#define journal_getblk(s, block) __getblk(F_BDEV(SB_JOURNAL(s)->j_f_bdev),\
+		SB_JOURNAL(s)->j_f_bdev, block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_f_bdev,\
 		block, s->s_blocksize)
-#define journal_bread(s, block) __bread(F_BDEV(SB_JOURNAL(s)->j_f_bdev),\
+#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_f_bdev,\
 		block, s->s_blocksize)
 
 enum reiserfs_bh_state_bits {
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index 2cec61af2a9e..0978a0a73a64 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -188,6 +188,7 @@ void reiserfs_unmap_buffer(struct buffer_head *bh)
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
 	bh->b_bdev = NULL;
+	bh->f_b_bdev = NULL;
 	unlock_buffer(bh);
 }
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 18c8f168b153..e0f38fafc5df 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -122,10 +122,12 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	if (mapping_flags & IOMAP_DAX)
+	if (mapping_flags & IOMAP_DAX) {
 		iomap->dax_dev = target->bt_daxdev;
-	else
+	} else {
 		iomap->bdev = target->bt_bdev;
+		iomap->f_bdev = target->bt_f_bdev;
+	}
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
@@ -151,6 +153,7 @@ xfs_hole_to_iomap(
 	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
 	iomap->bdev = target->bt_bdev;
+	iomap->f_bdev = target->bt_f_bdev;
 	iomap->dax_dev = target->bt_daxdev;
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index b2c9b35df8f7..2c79506ca7b6 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -39,6 +39,7 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->f_bdev = inode->i_sb->s_f_bdev;
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	isize = i_size_read(inode);
 	if (iomap->offset >= isize) {
@@ -89,6 +90,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->f_bdev = inode->i_sb->s_f_bdev;
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
 	isize = i_size_read(inode);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5f23ee599889..61747b88c073 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -9,6 +9,7 @@
 #define _LINUX_BUFFER_HEAD_H
 
 #include <linux/types.h>
+#include <linux/blkdev.h>
 #include <linux/blk_types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
@@ -68,6 +69,7 @@ struct buffer_head {
 	size_t b_size;			/* size of mapping */
 	char *b_data;			/* pointer to data within the page */
 
+	struct file *f_b_bdev;
 	struct block_device *b_bdev;
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
@@ -213,24 +215,24 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 				  bool datasync);
 int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
 			  bool datasync);
-void clean_bdev_aliases(struct block_device *bdev, sector_t block,
+void clean_bdev_aliases(struct file *f_bdev, sector_t block,
 			sector_t len);
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 {
-	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
+	clean_bdev_aliases(bh->f_b_bdev, bh->b_blocknr, 1);
 }
 
 void mark_buffer_async_write(struct buffer_head *bh);
 void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
-struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
+struct buffer_head *__find_get_block(struct file *f_bdev, sector_t block,
 			unsigned size);
-struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+struct buffer_head *bdev_getblk(struct file *f_bdev, sector_t block,
 		unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
-void __breadahead(struct block_device *, sector_t block, unsigned int size);
-struct buffer_head *__bread_gfp(struct block_device *,
+void __breadahead(struct file *, sector_t block, unsigned int size);
+struct buffer_head *__bread_gfp(struct file *,
 				sector_t block, unsigned size, gfp_t gfp);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
@@ -240,7 +242,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *f_bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
@@ -321,59 +323,59 @@ static inline void bforget(struct buffer_head *bh)
 static inline struct buffer_head *
 sb_bread(struct super_block *sb, sector_t block)
 {
-	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+	return __bread_gfp(sb->s_f_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
 }
 
 static inline struct buffer_head *
 sb_bread_unmovable(struct super_block *sb, sector_t block)
 {
-	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
+	return __bread_gfp(sb->s_f_bdev, block, sb->s_blocksize, 0);
 }
 
 static inline void
 sb_breadahead(struct super_block *sb, sector_t block)
 {
-	__breadahead(sb->s_bdev, block, sb->s_blocksize);
+	__breadahead(sb->s_f_bdev, block, sb->s_blocksize);
 }
 
-static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
+static inline struct buffer_head *getblk_unmovable(struct file *f_bdev,
 		sector_t block, unsigned size)
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_file_inode(f_bdev)->i_mapping, ~__GFP_FS);
 	gfp |= __GFP_NOFAIL;
 
-	return bdev_getblk(bdev, block, size, gfp);
+	return bdev_getblk(f_bdev, block, size, gfp);
 }
 
-static inline struct buffer_head *__getblk(struct block_device *bdev,
+static inline struct buffer_head *__getblk(struct file *f_bdev,
 		sector_t block, unsigned size)
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_file_inode(f_bdev)->i_mapping, ~__GFP_FS);
 	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
 
-	return bdev_getblk(bdev, block, size, gfp);
+	return bdev_getblk(f_bdev, block, size, gfp);
 }
 
 static inline struct buffer_head *sb_getblk(struct super_block *sb,
 		sector_t block)
 {
-	return __getblk(sb->s_bdev, block, sb->s_blocksize);
+	return __getblk(sb->s_f_bdev, block, sb->s_blocksize);
 }
 
 static inline struct buffer_head *sb_getblk_gfp(struct super_block *sb,
 		sector_t block, gfp_t gfp)
 {
-	return bdev_getblk(sb->s_bdev, block, sb->s_blocksize, gfp);
+	return bdev_getblk(sb->s_f_bdev, block, sb->s_blocksize, gfp);
 }
 
 static inline struct buffer_head *
 sb_find_get_block(struct super_block *sb, sector_t block)
 {
-	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
+	return __find_get_block(sb->s_f_bdev, block, sb->s_blocksize);
 }
 
 static inline void
@@ -381,6 +383,7 @@ map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
 	set_buffer_mapped(bh);
 	bh->b_bdev = sb->s_bdev;
+	bh->f_b_bdev = sb->s_f_bdev;
 	bh->b_blocknr = block;
 	bh->b_size = sb->s_blocksize;
 }
@@ -450,9 +453,9 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
  *  It returns NULL if the block was unreadable.
  */
 static inline struct buffer_head *
-__bread(struct block_device *bdev, sector_t block, unsigned size)
+__bread(struct file *f_bdev, sector_t block, unsigned size)
 {
-	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
+	return __bread_gfp(f_bdev, block, size, __GFP_MOVABLE);
 }
 
 /**
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..91f1e434cab3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -97,6 +97,7 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
+	struct file		*f_bdev;
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index beb30719ee16..d357ba510df6 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -972,6 +972,7 @@ struct journal_s
 	 * @j_dev: Device where we store the journal.
 	 */
 	struct block_device	*j_dev;
+	struct file		*f_j_dev;
 
 	/**
 	 * @j_blocksize: Block size for the location where we store the journal.
@@ -997,6 +998,7 @@ struct journal_s
 	 * equal to j_dev.
 	 */
 	struct block_device	*j_fs_dev;
+	struct file		*f_j_fs_dev;
 
 	/**
 	 * @j_total_len: Total maximum capacity of the journal region on disk.
@@ -1537,8 +1539,8 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
+extern journal_t * jbd2_journal_init_dev(struct file *f_bdev,
+				struct file *fs_dev,
 				unsigned long long start, int len, int bsize);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);

-- 
2.42.0


