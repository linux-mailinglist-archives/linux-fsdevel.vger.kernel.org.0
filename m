Return-Path: <linux-fsdevel+bounces-9351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7D840351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEFAB21E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2755B5A5;
	Mon, 29 Jan 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp/ZURe2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9345B1FE;
	Mon, 29 Jan 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525838; cv=none; b=TfmUUFlxQK0vSFSUvHWU1tA9sBW7+7YxQ0e560SOnFrrqaH+DWmlekglvQdkcyZnrYlGUJPnVa/wDle/oIcyB3IT/tix73V7Rn1o98FVIJwUuEfA/iTrXGC6pqEsa/XfThC/T5xP9wDqEI7Kt9ENghZZMgy+EkFtbnzep95hGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525838; c=relaxed/simple;
	bh=FRYUM4U1tHlSaKEw2330BQURx8jkWAFbTYSmltF31hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPOXBBxeqrxTzVhbHVrk8q2VbPBW1QO0CLce6lAhE9NYWXJFaQ34kdb0JgM4VF/FQD0f2N3ExwZcZYQM+sWVSKLUJxvHm9zH7uMHWcRagWVVJVtY6xzxFGvfTIXI9WEuAJKp1nRHNOIrsjeHmOy3eKXhncwRdu3s8qDeSMHDgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp/ZURe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5D8C433F1;
	Mon, 29 Jan 2024 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525838;
	bh=FRYUM4U1tHlSaKEw2330BQURx8jkWAFbTYSmltF31hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cp/ZURe2POd1EiHf3YL46O5N/MjDCfAUjgckimGJUVyKFgARmWn/Nk60AKMJZ+iqH
	 fRaNlf0DCjHtxCMTtgGvHiBfSThv/DrZ/Thh8jxCojVUP5gmV1Q12kdkA/uQbevjjy
	 9305J55CnHLtRa8CBFDwjFc4AkGWD6aq7SgOkKIie1xT/jxgSq9hPIzYB4lR9UXp4S
	 0QstjC1xmo3x6Sb+0PadDYOwHj/0LgtCYdLA86P8EoZ6g/Vj+uwvTSSqk8HichEMRz
	 6YY74eZN1nUoJ3UFiB+4QvzcbAJjivmNDIxRBdRnSB6zosFo/CutxXi5hsqgCeExI1
	 AoPQEmvZMRvYA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH RFC 1/2] fs & block: remove bdev->bd_inode
Date: Mon, 29 Jan 2024 11:56:41 +0100
Message-ID: <20240129-vfs-bdev-file-bd_inode-v1-1-42eb9eea96cf@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=100641; i=brauner@kernel.org; h=from:subject:message-id; bh=FRYUM4U1tHlSaKEw2330BQURx8jkWAFbTYSmltF31hI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRubym4kci/i/V13k+91Nud6efVQqMnJR8MERE8V5xom do/8Wh0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETyjjP8r/mXxKO0wX6P1dqy zemzwjiyj763u+PmW32ho996gsBqCUaGb6FZ3TwC/ttMVicx81zk7DnA8v9L3tIlV8NFDsr5sWg zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

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

The block layer itself continues to get direct access to the block
device inode from the block device. But afaict, it isn't necessary to
have bdev->bd_inode for this. Instead, the few places that need it can
use the bdev_inode() helper which returns the vfs_inode stashed in
struct bdev_inode.

That helper is currently exposed to a few non-block layer and block
drivers such as btrfs. The next patch fixes this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c                          | 48 ++++++++++--------
 block/blk-zoned.c                     |  4 +-
 block/fops.c                          |  4 +-
 block/genhd.c                         |  8 +--
 block/ioctl.c                         |  8 +--
 block/partitions/core.c               | 11 ++--
 drivers/gpu/drm/drm_gem_vram_helper.c |  2 +-
 drivers/md/bcache/super.c             |  2 +-
 drivers/md/md-bitmap.c                |  2 +-
 drivers/mtd/devices/block2mtd.c       |  4 +-
 drivers/s390/block/dasd_ioctl.c       |  2 +-
 drivers/scsi/scsicam.c                |  2 +-
 fs/affs/file.c                        |  2 +-
 fs/bcachefs/util.h                    |  2 +-
 fs/btrfs/disk-io.c                    |  6 +--
 fs/btrfs/inode.c                      |  2 +-
 fs/btrfs/volumes.c                    |  2 +-
 fs/btrfs/zoned.c                      |  2 +-
 fs/buffer.c                           | 95 +++++++++++++++++++----------------
 fs/cramfs/inode.c                     |  2 +-
 fs/direct-io.c                        |  7 +--
 fs/erofs/data.c                       |  5 +-
 fs/erofs/internal.h                   |  1 +
 fs/erofs/zmap.c                       |  2 +-
 fs/ext2/inode.c                       |  4 +-
 fs/ext2/xattr.c                       |  2 +-
 fs/ext4/inode.c                       |  8 +--
 fs/ext4/mmp.c                         |  2 +-
 fs/ext4/page-io.c                     |  4 +-
 fs/ext4/super.c                       |  7 ++-
 fs/ext4/xattr.c                       |  2 +-
 fs/f2fs/data.c                        |  7 ++-
 fs/f2fs/f2fs.h                        |  1 +
 fs/fuse/dax.c                         |  2 +-
 fs/gfs2/aops.c                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/gfs2/glock.c                       |  2 +-
 fs/gfs2/meta_io.c                     |  2 +-
 fs/gfs2/ops_fstype.c                  |  2 +-
 fs/hpfs/file.c                        |  2 +-
 fs/iomap/buffered-io.c                |  8 +--
 fs/iomap/direct-io.c                  | 10 ++--
 fs/iomap/swapfile.c                   |  2 +-
 fs/iomap/trace.h                      |  2 +-
 fs/jbd2/commit.c                      |  2 +-
 fs/jbd2/journal.c                     | 29 ++++++-----
 fs/jbd2/recovery.c                    |  6 +--
 fs/jbd2/revoke.c                      | 10 ++--
 fs/jbd2/transaction.c                 |  8 +--
 fs/mpage.c                            | 26 ++++++----
 fs/nilfs2/btnode.c                    |  4 +-
 fs/nilfs2/gcinode.c                   |  2 +-
 fs/nilfs2/mdt.c                       |  2 +-
 fs/nilfs2/page.c                      |  4 +-
 fs/nilfs2/recovery.c                  | 20 ++++----
 fs/nilfs2/segment.c                   |  2 +-
 fs/nilfs2/the_nilfs.c                 |  1 +
 fs/nilfs2/the_nilfs.h                 |  1 +
 fs/ntfs/aops.c                        |  6 +--
 fs/ntfs/file.c                        |  2 +-
 fs/ntfs/mft.c                         |  4 +-
 fs/ntfs3/fsntfs.c                     |  8 +--
 fs/ntfs3/inode.c                      |  2 +-
 fs/ntfs3/super.c                      |  2 +-
 fs/ocfs2/aops.c                       |  2 +-
 fs/ocfs2/journal.c                    |  2 +-
 fs/reiserfs/fix_node.c                |  2 +-
 fs/reiserfs/journal.c                 | 10 ++--
 fs/reiserfs/prints.c                  |  4 +-
 fs/reiserfs/reiserfs.h                |  6 +--
 fs/reiserfs/stree.c                   |  2 +-
 fs/reiserfs/tail_conversion.c         |  2 +-
 fs/xfs/xfs_iomap.c                    |  4 +-
 fs/zonefs/file.c                      |  4 +-
 include/linux/blk_types.h             |  1 -
 include/linux/blkdev.h                |  6 ++-
 include/linux/buffer_head.h           | 68 ++++++++++++++++---------
 include/linux/fs.h                    |  4 +-
 include/linux/iomap.h                 | 13 ++++-
 include/linux/jbd2.h                  | 10 ++--
 include/trace/events/block.h          |  2 +-
 81 files changed, 326 insertions(+), 255 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 185c43ebeea5..131cd1a7a877 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -43,6 +43,12 @@ static inline struct bdev_inode *BDEV_I(struct inode *inode)
 	return container_of(inode, struct bdev_inode, vfs_inode);
 }
 
+struct inode *bdev_inode(struct block_device *bdev)
+{
+	return &container_of(bdev, struct bdev_inode, bdev)->vfs_inode;
+}
+EXPORT_SYMBOL_GPL(bdev_inode);
+
 struct block_device *I_BDEV(struct inode *inode)
 {
 	return &BDEV_I(inode)->bdev;
@@ -57,7 +63,7 @@ EXPORT_SYMBOL(file_bdev);
 
 static void bdev_write_inode(struct block_device *bdev)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int ret;
 
 	spin_lock(&inode->i_lock);
@@ -76,7 +82,7 @@ static void bdev_write_inode(struct block_device *bdev)
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping_empty(mapping))
 		return;
@@ -88,7 +94,7 @@ static void kill_bdev(struct block_device *bdev)
 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
@@ -116,7 +122,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			goto invalidate;
 	}
 
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	truncate_inode_pages_range(bdev_inode(bdev)->i_mapping, lstart, lend);
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
@@ -126,7 +132,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * Someone else has handle exclusively open. Try invalidating instead.
 	 * The 'end' argument is inclusive so the rounding is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(bdev_inode(bdev)->i_mapping,
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
@@ -134,14 +140,14 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
+	loff_t size = i_size_read(bdev_inode(bdev));
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	bdev_inode(bdev)->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -155,9 +161,9 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	if (bdev_inode(bdev)->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		bdev_inode(bdev)->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -192,7 +198,7 @@ int sync_blockdev_nowait(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_flush(bdev->bd_inode->i_mapping);
+	return filemap_flush(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
@@ -204,13 +210,13 @@ int sync_blockdev(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	return filemap_write_and_wait(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL(sync_blockdev);
 
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
 {
-	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
+	return filemap_write_and_wait_range(bdev_inode(bdev)->i_mapping,
 			lstart, lend);
 }
 EXPORT_SYMBOL(sync_blockdev_range);
@@ -412,7 +418,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
-	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
 		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
@@ -430,19 +435,20 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	i_size_write(bdev_inode(bdev), (loff_t)sectors << SECTOR_SHIFT);
 	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	struct inode *inode = bdev_inode(bdev);
 	if (bdev_stable_writes(bdev))
-		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
+		mapping_set_stable_writes(inode->i_mapping);
 	bdev->bd_dev = dev;
-	bdev->bd_inode->i_rdev = dev;
-	bdev->bd_inode->i_ino = dev;
-	insert_inode_hash(bdev->bd_inode);
+	inode->i_rdev = dev;
+	inode->i_ino = dev;
+	insert_inode_hash(bdev_inode(bdev));
 }
 
 long nr_blockdev_pages(void)
@@ -901,7 +907,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
 	if (bdev_nowait(bdev))
 		bdev_file->f_mode |= FMODE_NOWAIT;
-	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
+	bdev_file->f_mapping = bdev_inode(bdev)->i_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
 	bdev_file->private_data = holder;
 
@@ -971,7 +977,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		blk_fops = &def_blk_fops_restricted;
 	else
 		blk_fops = &def_blk_fops;
-	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
+	bdev_file = alloc_file_pseudo_noaccount(bdev_inode(bdev),
 			blockdev_mnt, "", flags | O_LARGEFILE, blk_fops);
 	if (IS_ERR(bdev_file)) {
 		blkdev_put_no_open(bdev);
@@ -979,7 +985,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	}
 	bdev_file->f_mode &= ~FMODE_OPENED;
 
-	ihold(bdev->bd_inode);
+	ihold(bdev_inode(bdev));
 	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
 	if (ret) {
 		fput(bdev_file);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d343e5756a9c..232003d70318 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -401,7 +401,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
@@ -424,7 +424,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	if (cmd == BLKRESETZONE)
-		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index 4e65a7ce965e..1557c7bfcf1f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -381,6 +381,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	loff_t isize = i_size_read(inode);
 
 	iomap->bdev = bdev;
+	iomap->flags |= IOMAP_F_BDEV;
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	if (iomap->offset >= isize)
 		return -EIO;
@@ -402,6 +403,7 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
 	bh->b_bdev = I_BDEV(inode);
 	bh->b_blocknr = iblock;
 	set_buffer_mapped(bh);
+	set_buffer_bdev(bh);
 	return 0;
 }
 
@@ -665,7 +667,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
diff --git a/block/genhd.c b/block/genhd.c
index a911d2969c07..8e64cc5172c5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -656,7 +656,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -745,7 +745,7 @@ void invalidate_disk(struct gendisk *disk)
 	struct block_device *bdev = disk->part0;
 
 	invalidate_bdev(bdev);
-	bdev->bd_inode->i_mapping->wb_err = 0;
+	bdev_inode(bdev)->i_mapping->wb_err = 0;
 	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL(invalidate_disk);
@@ -1191,7 +1191,7 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
-	iput(disk->part0->bd_inode);	/* frees the disk */
+	iput(bdev_inode(disk->part0));	/* frees the disk */
 }
 
 static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -1381,7 +1381,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-	iput(disk->part0->bd_inode);
+	iput(bdev_inode(disk->part0));
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_bioset:
diff --git a/block/ioctl.c b/block/ioctl.c
index 5d0619e02e4c..376339e0db6c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -92,7 +92,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -146,12 +146,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 	return err;
 }
 
@@ -161,7 +161,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index cab0d76a828e..2808c5a2f19e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -242,8 +242,9 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
-	put_disk(dev_to_bdev(dev)->bd_disk);
-	iput(dev_to_bdev(dev)->bd_inode);
+	struct block_device *bdev = dev_to_bdev(dev);
+	put_disk(bdev->bd_disk);
+	iput(bdev_inode(bdev));
 }
 
 static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -475,7 +476,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	 * Just delete the partition and invalidate it.
 	 */
 
-	remove_inode_hash(part->bd_inode);
+	remove_inode_hash(bdev_inode(part));
 	invalidate_bdev(part);
 	drop_partition(part);
 	ret = 0;
@@ -661,7 +662,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		 * it cannot be looked up any more even when openers
 		 * still hold references.
 		 */
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 
 		/*
 		 * If @disk->open_partitions isn't elevated but there's
@@ -710,7 +711,7 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(state->disk->part0)->i_mapping;
 	struct folio *folio;
 
 	if (n >= get_capacity(state->disk)) {
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index b67eafa55715..ce9c2d51f1f6 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -935,7 +935,7 @@ static int bo_driver_move(struct ttm_buffer_object *bo,
 static int bo_driver_io_mem_reserve(struct ttm_device *bdev,
 				    struct ttm_resource *mem)
 {
-	struct drm_vram_mm *vmm = drm_vram_mm_of_bdev(bdev);
+	struct drm_vram_mm *vmm = drm_vram_mm_obdev_file(bdev);
 
 	switch (mem->mem_type) {
 	case TTM_PL_SYSTEM:	/* nothing to do */
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d00b3abab133..8971e769d5e7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -171,7 +171,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	struct page *page;
 	unsigned int i;
 
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
+	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping,
 				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
 	if (IS_ERR(page))
 		return "IO error";
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
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 97a00ec9a4d4..dc3df3a600cf 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -291,7 +291,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev->bd_inode->i_size % erase_size) {
+	if ((long)bdev_inode(bdev)->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -309,7 +309,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = bdev_inode(bdev)->i_size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index de85a5e4e21b..c6295ef35437 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -221,7 +221,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		block->gdp->part0->bd_inode->i_blkbits =
+		bdev_inode(block->gdp->part0)->i_blkbits =
 			blksize_bits(fdata->blksize);
 	}
 
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e2c7d8ef205f..de40a5ef7d96 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,7 +32,7 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev_whole(dev))->i_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
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
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index df67bf55fe2b..5ab765d056d6 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -554,7 +554,7 @@ int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
 
 static inline sector_t bdev_sectors(struct block_device *bdev)
 {
-	return bdev->bd_inode->i_size >> 9;
+	return bdev_inode(bdev)->i_size >> 9;
 }
 
 #define closure_bio_submit(bio, cl)					\
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c6907d533fe8..7d5d022b0bde 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3639,7 +3639,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	struct btrfs_super_block *super;
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -3726,7 +3726,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(device->bdev)->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3843,7 +3843,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(bdev_inode(device->bdev)->i_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 809b11472a80..449922af0a18 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7660,7 +7660,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap->bdev_file = fs_info->fs_devices->latest_dev->bdev_file;
 	iomap->length = len;
 	free_extent_map(em);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 769a1dc4b756..1f12122ae7ce 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1268,7 +1268,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping, index, GFP_KERNEL);
 
 	if (IS_ERR(page))
 		return ERR_CAST(page);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5bd76813b23f..42893771532f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -120,7 +120,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
diff --git a/fs/buffer.c b/fs/buffer.c
index d3bcf601d3e5..3f3677668a80 100644
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
+	struct inode *bd_inode = bdev_file_inode(bdev_file);
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
@@ -655,10 +655,10 @@ EXPORT_SYMBOL(generic_buffers_fsync);
  * `bblock + 1' is probably a dirty indirect block.  Hunt it down and, if it's
  * dirty, schedule it for IO.  So that indirects merge nicely with their data.
  */
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *bdev_file,
 			sector_t bblock, unsigned blocksize)
 {
-	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
+	struct buffer_head *bh = __find_get_block(bdev_file, bblock + 1, blocksize);
 	if (bh) {
 		if (buffer_dirty(bh))
 			write_dirty_buffer(bh, 0);
@@ -994,8 +994,9 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
  * Initialise the state of a blockdev folio's buffers.
  */ 
 static sector_t folio_init_buffers(struct folio *folio,
-		struct block_device *bdev, unsigned size)
+		struct file *bdev_file, unsigned size)
 {
+	struct block_device *bdev = file_bdev(bdev_file);
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
 	bool uptodate = folio_test_uptodate(folio);
@@ -1006,7 +1007,7 @@ static sector_t folio_init_buffers(struct folio *folio,
 		if (!buffer_mapped(bh)) {
 			bh->b_end_io = NULL;
 			bh->b_private = NULL;
-			bh->b_bdev = bdev;
+			bh->b_bdev_file = bdev_file;
 			bh->b_blocknr = block;
 			if (uptodate)
 				set_buffer_uptodate(bh);
@@ -1031,10 +1032,10 @@ static sector_t folio_init_buffers(struct folio *folio,
  * Returns false if we have a failure which cannot be cured by retrying
  * without sleeping.  Returns true if we succeeded, or the caller should retry.
  */
-static bool grow_dev_folio(struct block_device *bdev, sector_t block,
+static bool grow_dev_folio(struct file *bdev_file, sector_t block,
 		pgoff_t index, unsigned size, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_file_inode(bdev_file);
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block = 0;
@@ -1047,7 +1048,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = folio_init_buffers(folio, bdev, size);
+			end_block = folio_init_buffers(folio, bdev_file, size);
 			goto unlock;
 		}
 
@@ -1075,7 +1076,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->i_private_lock);
 	link_dev_buffers(folio, bh);
-	end_block = folio_init_buffers(folio, bdev, size);
+	end_block = folio_init_buffers(folio, bdev_file, size);
 	spin_unlock(&inode->i_mapping->i_private_lock);
 unlock:
 	folio_unlock(folio);
@@ -1088,7 +1089,8 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
  * that folio was dirty, the buffers are set dirty also.  Returns false
  * if we've hit a permanent error.
  */
-static bool grow_buffers(struct block_device *bdev, sector_t block,
+
+static bool grow_buffers(struct file *bdev_file, sector_t block,
 		unsigned size, gfp_t gfp)
 {
 	loff_t pos;
@@ -1100,25 +1102,25 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
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
+__getblk_slow(struct file *bdev_file, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
 	/* Size must be multiple of hard sectorsize */
-	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
+	if (unlikely(size & (bdev_logical_block_size(file_bdev(bdev_file))-1) ||
 			(size < 512 || size > PAGE_SIZE))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
 		printk(KERN_ERR "logical block size: %d\n",
-					bdev_logical_block_size(bdev));
+					bdev_logical_block_size(file_bdev(bdev_file)));
 
 		dump_stack();
 		return NULL;
@@ -1127,11 +1129,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
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
@@ -1367,7 +1369,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 
-		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
+		if (bh && bh->b_blocknr == block && bh_bdev(bh) == bdev &&
 		    bh->b_size == size) {
 			if (i) {
 				while (i) {
@@ -1392,13 +1394,13 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
  * NULL
  */
 struct buffer_head *
-__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
+__find_get_block(struct file *bdev_file, sector_t block, unsigned size)
 {
-	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
+	struct buffer_head *bh = lookup_bh_lru(file_bdev(bdev_file), block, size);
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev_file, block);
 		if (bh)
 			bh_lru_install(bh);
 	} else
@@ -1410,32 +1412,32 @@ EXPORT_SYMBOL(__find_get_block);
 
 /**
  * bdev_getblk - Get a buffer_head in a block device's buffer cache.
- * @bdev: The block device.
+ * @bdev_file: The block device.
  * @block: The block number.
- * @size: The size of buffer_heads for this @bdev.
+ * @size: The size of buffer_heads for this @bdev_file.
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
+void __breadahead(struct file *bdev_file, sector_t block, unsigned size)
 {
-	struct buffer_head *bh = bdev_getblk(bdev, block, size,
+	struct buffer_head *bh = bdev_getblk(bdev_file, block, size,
 			GFP_NOWAIT | __GFP_MOVABLE);
 
 	if (likely(bh)) {
@@ -1447,7 +1449,7 @@ EXPORT_SYMBOL(__breadahead);
 
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
+ *  @bdev_file: the block_device to read from
  *  @block: number of block
  *  @size: size (in bytes) to read
  *  @gfp: page allocation flag
@@ -1458,12 +1460,12 @@ EXPORT_SYMBOL(__breadahead);
  *  It returns NULL if the block was unreadable.
  */
 struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
+__bread_gfp(struct file *bdev_file, sector_t block,
 		   unsigned size, gfp_t gfp)
 {
 	struct buffer_head *bh;
 
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= mapping_gfp_constraint(bdev_file_inode(bdev_file)->i_mapping, ~__GFP_FS);
 
 	/*
 	 * Prefer looping in the allocator rather than here, at least that
@@ -1471,7 +1473,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 	 */
 	gfp |= __GFP_NOFAIL;
 
-	bh = bdev_getblk(bdev, block, size, gfp);
+	bh = bdev_getblk(bdev_file, block, size, gfp);
 
 	if (likely(bh) && !buffer_uptodate(bh))
 		bh = __bread_slow(bh);
@@ -1556,7 +1558,7 @@ EXPORT_SYMBOL(folio_set_bh);
 /* Bits that are cleared during an invalidate */
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
-	 1 << BH_Delay | 1 << BH_Unwritten)
+	 1 << BH_Delay | 1 << BH_Unwritten | 1 << BH_Bdev)
 
 static void discard_buffer(struct buffer_head * bh)
 {
@@ -1564,7 +1566,7 @@ static void discard_buffer(struct buffer_head * bh)
 
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
-	bh->b_bdev = NULL;
+	bh->b_bdev_file = NULL;
 	b_state = READ_ONCE(bh->b_state);
 	do {
 	} while (!try_cmpxchg(&bh->b_state, &b_state,
@@ -1694,9 +1696,9 @@ EXPORT_SYMBOL(create_empty_buffers);
  * I/O in bforget() - it's more efficient to wait on the I/O only if we really
  * need to.  That happens here.
  */
-void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
+void __clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
 	pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
@@ -1746,7 +1748,6 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 			break;
 	}
 }
-EXPORT_SYMBOL(clean_bdev_aliases);
 
 static struct buffer_head *folio_create_buffers(struct folio *folio,
 						struct inode *inode,
@@ -2003,7 +2004,17 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
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
@@ -2778,7 +2789,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	if (buffer_prio(bh))
 		opf |= REQ_PRIO;
 
-	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), 1, opf, GFP_NOIO);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 39e75131fd5a..1df4dd89350e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -183,7 +183,7 @@ static int next_buffer;
 static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 				unsigned int len)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = sb->s_bdev_file->f_mapping;
 	struct file_ra_state ra = {};
 	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 60456263a338..cc77c86d17db 100644
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
@@ -1102,10 +1102,11 @@ static inline int drop_refcount(struct dio *dio)
  * for the whole file.
  */
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
-		struct block_device *bdev, struct iov_iter *iter,
+		struct file *bdev_file, struct iov_iter *iter,
 		get_block_t get_block, dio_iodone_t end_io,
 		int flags)
 {
+	struct block_device *bdev = file_bdev(bdev_file);
 	unsigned i_blkbits = READ_ONCE(inode->i_blkbits);
 	unsigned blkbits = i_blkbits;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 433fc39ba423..8b4780395b2f 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -70,7 +70,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	if (erofs_is_fscache_mode(sb))
 		buf->inode = EROFS_SB(sb)->s_fscache->inode;
 	else
-		buf->inode = sb->s_bdev->bd_inode;
+		buf->inode = bdev_file_inode(sb->s_bdev_file);
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
@@ -204,6 +204,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	int id;
 
 	map->m_bdev = sb->s_bdev;
+	map->f_m_bdev = sb->s_bdev_file;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
@@ -278,7 +279,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_daxdev;
 	else
-		iomap->bdev = mdev.m_bdev;
+		iomap->bdev_file = mdev.f_m_bdev;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0f0706325b7b..140188c28f9d 100644
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
index 5a4272b2c6b0..3dcd03b5bad6 100644
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
index e849241ebb8f..e4df3f82fbe1 100644
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
index 5af1b0b8680e..4594af99be27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1797,11 +1797,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
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
@@ -3241,7 +3241,7 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
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
index 312bc6813357..8317877d83ce 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -93,7 +93,7 @@ struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end)
 static void buffer_io_error(struct buffer_head *bh)
 {
 	printk_ratelimited(KERN_ERR "Buffer I/O error on device %pg, logical block %llu\n",
-		       bh->b_bdev,
+		       bh_bdev(bh),
 			(unsigned long long)bh->b_blocknr);
 }
 
@@ -397,7 +397,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index edb7221dce18..6a0c2e15b48b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -261,7 +261,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = bdev_getblk(file_bdev(sb->s_bdev_file), block,
+	struct buffer_head *bh = bdev_getblk(sb->s_bdev_file, block,
 			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
@@ -5878,7 +5878,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
 	set_blocksize(bdev, blocksize);
-	bh = __bread(bdev, sb_block, blocksize);
+	bh = __bread(bdev_file, sb_block, blocksize);
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
@@ -5934,8 +5934,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	journal = jbd2_journal_init_dev(file_bdev(bdev_file),
-					file_bdev(sb->s_bdev_file), j_start,
+	journal = jbd2_journal_init_dev(bdev_file, sb->s_bdev_file, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
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
index 26e317696b33..fd2a6db57d67 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1605,6 +1605,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto out;
 
 	map->m_bdev = inode->i_sb->s_bdev;
+	map->f_m_bdev = inode->i_sb->s_bdev_file;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
 
@@ -1723,8 +1724,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
 
-		if (map->m_multidev_dio)
+		if (map->m_multidev_dio) {
 			map->m_bdev = FDEV(bidx).bdev;
+			map->f_m_bdev = FDEV(bidx).bdev_file;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
@@ -4248,7 +4251,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
-		iomap->bdev = map.m_bdev;
+		iomap->bdev_file = map.f_m_bdev;
 		iomap->addr = blks_to_bytes(inode, map.m_pblk);
 	} else {
 		if (flags & IOMAP_WRITE)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6fc172c99915..0e3a5b86276b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -691,6 +691,7 @@ struct extent_tree_info {
 				F2FS_MAP_DELALLOC)
 
 struct f2fs_map_blocks {
+	struct file *f_m_bdev;	/* for multi-device dio */
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
index d9ccfd27e4f1..e20627a2353d 100644
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
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..9ae09a48d83c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1227,7 +1227,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_inode;
+		mapping->host = bdev_file_inode(s->s_bdev_file);
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->i_private_data = NULL;
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
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1281e60be639..ca7324cfbad5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -114,7 +114,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	address_space_init_once(mapping);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_inode;
+	mapping->host = bdev_file_inode(sb->s_bdev_file);
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
 	mapping->i_private_data = NULL;
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
index 093c4515b22a..8b143676c4d2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -377,7 +377,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+		ctx->bio = bio_alloc(iomap_bdev(iomap), bio_max_segs(nr_vecs),
 				     REQ_OP_READ, gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
@@ -385,7 +385,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+			ctx->bio = bio_alloc(iomap_bdev(iomap), 1, REQ_OP_READ,
 					     orig_gfp);
 		}
 		if (ctx->rac)
@@ -624,7 +624,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
+	bio_init(&bio, iomap_bdev(iomap), &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_add_folio_nofail(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
@@ -1663,7 +1663,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+	bio = bio_alloc_bioset(iomap_bdev(&wpc->iomap), BIO_MAX_VECS,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..9e875a4dde24 100644
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
@@ -316,7 +316,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
 		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
+		    (bdev_fua(iomap_bdev(iomap)) || !bdev_write_cache(iomap_bdev(iomap))))
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
index b6c114c11b97..fd0d99b98c5f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -434,7 +434,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
-	new_bh->b_bdev = journal->j_dev;
+	new_bh->b_bdev_file = journal->j_bdev_file;
 	new_bh->b_blocknr = blocknr;
 	new_bh->b_private = bh_in;
 	set_buffer_mapped(new_bh);
@@ -880,7 +880,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (ret)
 		return ret;
 
-	bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
+	bh = __getblk(journal->j_bdev_file, pblock, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -1007,7 +1007,7 @@ jbd2_journal_get_descriptor_buffer(transaction_t *transaction, int type)
 	if (err)
 		return NULL;
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->j_bdev_file, blocknr, journal->j_blocksize);
 	if (!bh)
 		return NULL;
 	atomic_dec(&transaction->t_outstanding_credits);
@@ -1461,7 +1461,7 @@ static int journal_load_superblock(journal_t *journal)
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
 
-	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
+	bh = getblk_unmovable(journal->j_bdev_file, journal->j_blk_offset,
 			      journal->j_blocksize);
 	if (bh)
 		err = bh_read(bh, 0);
@@ -1516,11 +1516,12 @@ static int journal_load_superblock(journal_t *journal)
  * very few fields yet: that has to wait until we have created the
  * journal structures from from scratch, or loaded them from disk. */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
+static journal_t *journal_init_common(struct file *bdev_file,
+			struct file *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
 	static struct lock_class_key jbd2_trans_commit_key;
+	struct block_device *bdev = file_bdev(bdev_file);
 	journal_t *journal;
 	int err;
 	int n;
@@ -1530,8 +1531,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 		return ERR_PTR(-ENOMEM);
 
 	journal->j_blocksize = blocksize;
-	journal->j_dev = bdev;
-	journal->j_fs_dev = fs_dev;
+	journal->j_bdev_file = bdev_file;
+	journal->j_fs_bdev_file = fs_dev;
+	journal->j_dev = file_bdev(bdev_file);
+	journal->j_fs_dev = file_bdev(fs_dev);
 	journal->j_blk_offset = start;
 	journal->j_total_len = len;
 	jbd2_init_fs_dev_write_error(journal);
@@ -1640,13 +1643,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
+journal_t *jbd2_journal_init_dev(struct file *bdev_file,
+			struct file *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev_file, fs_dev, start, len, blocksize);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1683,7 +1686,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
-	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
+	journal = journal_init_common(inode->i_sb->s_bdev_file, inode->i_sb->s_bdev_file,
 			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
 			inode->i_sb->s_blocksize);
 	if (IS_ERR(journal))
@@ -2009,7 +2012,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		byte_count = (block_stop - block_start + 1) *
 				journal->j_blocksize;
 
-		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+		truncate_inode_pages_range(journal->j_bdev_file->f_mapping,
 				byte_start, byte_stop);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..0740ba6b5802 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -92,7 +92,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 			goto failed;
 		}
 
-		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+		bh = __getblk(journal->j_bdev_file, blocknr, journal->j_blocksize);
 		if (!bh) {
 			err = -ENOMEM;
 			goto failed;
@@ -148,7 +148,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 		return err;
 	}
 
-	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	bh = __getblk(journal->j_bdev_file, blocknr, journal->j_blocksize);
 	if (!bh)
 		return -ENOMEM;
 
@@ -672,7 +672,7 @@ static int do_one_pass(journal_t *journal,
 
 					/* Find a buffer for the new
 					 * data being restored */
-					nbh = __getblk(journal->j_fs_dev,
+					nbh = __getblk(journal->j_fs_bdev_file,
 							blocknr,
 							journal->j_blocksize);
 					if (nbh == NULL) {
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..cb0bfb0cd248 100644
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
+		bh = __find_get_block(journal->j_fs_bdev_file, blocknr, journal->j_blocksize);
 		if (bh)
 			BUFFER_TRACE(bh, "found on hash");
 	}
@@ -355,7 +353,7 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
 
 		/* If there is a different buffer_head lying around in
 		 * memory anywhere... */
-		bh2 = __find_get_block(bdev, blocknr, journal->j_blocksize);
+		bh2 = __find_get_block(journal->j_fs_bdev_file, blocknr, journal->j_blocksize);
 		if (bh2) {
 			/* ... and it has RevokeValid status... */
 			if (bh2 != bh && buffer_revokevalid(bh2))
@@ -466,7 +464,7 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 	 * state machine will get very upset later on. */
 	if (need_cancel) {
 		struct buffer_head *bh2;
-		bh2 = __find_get_block(bh->b_bdev, bh->b_blocknr, bh->b_size);
+		bh2 = __find_get_block(bh->b_bdev_file, bh->b_blocknr, bh->b_size);
 		if (bh2) {
 			if (bh2 != bh)
 				clear_buffer_revoked(bh2);
@@ -495,7 +493,7 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 			struct jbd2_revoke_record_s *record;
 			struct buffer_head *bh;
 			record = (struct jbd2_revoke_record_s *)list_entry;
-			bh = __find_get_block(journal->j_fs_dev,
+			bh = __find_get_block(journal->j_fs_bdev_file,
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
index 738882e0766d..dea42c440373 100644
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
+	struct file *f_boundary_bdev = NULL;
 	size_t length;
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
@@ -513,9 +518,9 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 			boundary = buffer_boundary(bh);
 			if (boundary) {
 				boundary_block = bh->b_blocknr;
-				boundary_bdev = bh->b_bdev;
+				f_boundary_bdev = bh->b_bdev_file;
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
+			f_boundary_bdev = map_bh.b_bdev_file;
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
+			write_boundary_block(f_boundary_bdev,
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
index e45c01a559c0..8c2d32e9ba06 100644
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
index 5c2eba1987bd..1bd4630ad5c5 100644
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
index 0955b657938f..7d407dd63ff3 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -107,7 +107,7 @@ static int nilfs_compute_checksum(struct the_nilfs *nilfs,
 		do {
 			struct buffer_head *bh;
 
-			bh = __bread(nilfs->ns_bdev, ++start, blocksize);
+			bh = __bread(nilfs->ns_bdev_file, ++start, blocksize);
 			if (!bh)
 				return -EIO;
 			check_bytes -= size;
@@ -136,7 +136,7 @@ int nilfs_read_super_root_block(struct the_nilfs *nilfs, sector_t sr_block,
 	int ret;
 
 	*pbh = NULL;
-	bh_sr = __bread(nilfs->ns_bdev, sr_block, nilfs->ns_blocksize);
+	bh_sr = __bread(nilfs->ns_bdev_file, sr_block, nilfs->ns_blocksize);
 	if (unlikely(!bh_sr)) {
 		ret = NILFS_SEG_FAIL_IO;
 		goto failed;
@@ -183,7 +183,7 @@ nilfs_read_log_header(struct the_nilfs *nilfs, sector_t start_blocknr,
 {
 	struct buffer_head *bh_sum;
 
-	bh_sum = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh_sum = __bread(nilfs->ns_bdev_file, start_blocknr, nilfs->ns_blocksize);
 	if (bh_sum)
 		*sum = (struct nilfs_segment_summary *)bh_sum->b_data;
 	return bh_sum;
@@ -250,7 +250,7 @@ static void *nilfs_read_summary_info(struct the_nilfs *nilfs,
 	if (bytes > (*pbh)->b_size - *offset) {
 		blocknr = (*pbh)->b_blocknr;
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + 1,
+		*pbh = __bread(nilfs->ns_bdev_file, blocknr + 1,
 			       nilfs->ns_blocksize);
 		if (unlikely(!*pbh))
 			return NULL;
@@ -289,7 +289,7 @@ static void nilfs_skip_summary_info(struct the_nilfs *nilfs,
 		*offset = bytes * (count - (bcnt - 1) * nitem_per_block);
 
 		brelse(*pbh);
-		*pbh = __bread(nilfs->ns_bdev, blocknr + bcnt,
+		*pbh = __bread(nilfs->ns_bdev_file, blocknr + bcnt,
 			       nilfs->ns_blocksize);
 	}
 }
@@ -318,7 +318,7 @@ static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 
 	sumbytes = le32_to_cpu(sum->ss_sumbytes);
 	blocknr = start_blocknr + DIV_ROUND_UP(sumbytes, nilfs->ns_blocksize);
-	bh = __bread(nilfs->ns_bdev, start_blocknr, nilfs->ns_blocksize);
+	bh = __bread(nilfs->ns_bdev_file, start_blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh))
 		goto out;
 
@@ -477,7 +477,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 	struct buffer_head *bh_org;
 	void *kaddr;
 
-	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
+	bh_org = __bread(nilfs->ns_bdev_file, rb->blocknr, nilfs->ns_blocksize);
 	if (unlikely(!bh_org))
 		return -EIO;
 
@@ -696,7 +696,7 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	    nilfs_get_segnum_of_block(nilfs, ri->ri_super_root))
 		return;
 
-	bh = __getblk(nilfs->ns_bdev, ri->ri_lsegs_start, nilfs->ns_blocksize);
+	bh = __getblk(nilfs->ns_bdev_file, ri->ri_lsegs_start, nilfs->ns_blocksize);
 	BUG_ON(!bh);
 	memset(bh->b_data, 0, bh->b_size);
 	set_buffer_dirty(bh);
@@ -822,7 +822,7 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 	/* Read ahead segment */
 	b = seg_start;
 	while (b <= seg_end)
-		__breadahead(nilfs->ns_bdev, b++, nilfs->ns_blocksize);
+		__breadahead(nilfs->ns_bdev_file, b++, nilfs->ns_blocksize);
 
 	for (;;) {
 		brelse(bh_sum);
@@ -868,7 +868,7 @@ int nilfs_search_super_root(struct the_nilfs *nilfs,
 		if (pseg_start == seg_start) {
 			nilfs_get_segment_range(nilfs, nextnum, &b, &end);
 			while (b <= end)
-				__breadahead(nilfs->ns_bdev, b++,
+				__breadahead(nilfs->ns_bdev_file, b++,
 					     nilfs->ns_blocksize);
 		}
 		if (!(flags & NILFS_SS_SR)) {
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2590a0860eab..642015cd6d1c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2825,7 +2825,7 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	if (!nilfs->ns_writer)
 		return -ENOMEM;
 
-	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
+	inode_attach_wb(bdev_file_inode(nilfs->ns_bdev_file), NULL);
 
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
 	if (unlikely(err))
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 71400496ed36..30776f67cb9b 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -63,6 +63,7 @@ struct the_nilfs *alloc_nilfs(struct super_block *sb)
 
 	nilfs->ns_sb = sb;
 	nilfs->ns_bdev = sb->s_bdev;
+	nilfs->ns_bdev_file = sb->s_bdev_file;
 	atomic_set(&nilfs->ns_ndirtyblks, 0);
 	init_rwsem(&nilfs->ns_sem);
 	mutex_init(&nilfs->ns_snapshot_mount_mutex);
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index cd4ae1b8ae16..d47243774181 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -97,6 +97,7 @@ struct the_nilfs {
 	int			ns_flushed_device;
 
 	struct super_block     *ns_sb;
+	struct file            *ns_bdev_file;
 	struct block_device    *ns_bdev;
 	struct rw_semaphore	ns_sem;
 	struct mutex		ns_snapshot_mount_mutex;
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 2d01517a2d59..1c56fd2cb0f3 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -227,7 +227,7 @@ static int ntfs_read_block(struct folio *folio)
 			arr[nr++] = bh;
 			continue;
 		}
-		bh->b_bdev = vol->sb->s_bdev;
+		bh->b_bdev_file = vol->sb->s_bdev_file;
 		/* Is the block within the allowed limits? */
 		if (iblock < lblock) {
 			bool is_retry = false;
@@ -678,7 +678,7 @@ static int ntfs_write_block(struct folio *folio, struct writeback_control *wbc)
 			continue;
 
 		/* Unmapped, dirty buffer. Need to map it. */
-		bh->b_bdev = vol->sb->s_bdev;
+		bh->b_bdev_file = vol->sb->s_bdev_file;
 
 		/* Convert block into corresponding vcn and offset. */
 		vcn = (VCN)block << blocksize_bits;
@@ -988,7 +988,7 @@ static int ntfs_write_mst_block(struct page *page,
 			LCN lcn;
 			unsigned int vcn_ofs;
 
-			bh->b_bdev = vol->sb->s_bdev;
+			bh->b_bdev_file = vol->sb->s_bdev_file;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = (VCN)block << bh_size_bits;
 			vcn_ofs = vcn & vol->cluster_size_mask;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 297c0b9db621..894be07d2971 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -680,7 +680,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			continue;
 		}
 		/* Unmapped buffer.  Need to map it. */
-		bh->b_bdev = vol->sb->s_bdev;
+		bh->b_bdev_file = vol->sb->s_bdev_file;
 		/*
 		 * If the current buffer is in the same clusters as the map
 		 * cache, there is no need to check the runlist again.  The
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6fd1dc4b08c8..88a61448522b 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -526,7 +526,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			LCN lcn;
 			unsigned int vcn_ofs;
 
-			bh->b_bdev = vol->sb->s_bdev;
+			bh->b_bdev_file = vol->sb->s_bdev_file;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
@@ -719,7 +719,7 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
 			LCN lcn;
 			unsigned int vcn_ofs;
 
-			bh->b_bdev = vol->sb->s_bdev;
+			bh->b_bdev_file = vol->sb->s_bdev_file;
 			/* Obtain the vcn and offset of the current block. */
 			vcn = ((VCN)ni->mft_no << vol->mft_record_size_bits) +
 					(block_start - m_start);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index fbfe21dbb425..b01b0e1f6990 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1015,7 +1015,7 @@ int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
 	u32 op = blocksize - off;
 
 	for (; bytes; block += 1, off = 0, op = blocksize) {
-		struct buffer_head *bh = __bread(bdev, block, blocksize);
+		struct buffer_head *bh = __bread(sb->s_bdev_file, block, blocksize);
 
 		if (!bh)
 			return -EIO;
@@ -1052,14 +1052,14 @@ int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
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
@@ -2673,4 +2673,4 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 out:
 	__putname(uni);
 	return err;
-}
\ No newline at end of file
+}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 5e3d71374918..8a39600b834d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -611,7 +611,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	lbo = ((u64)lcn << cluster_bits) + off;
 
 	set_buffer_mapped(bh);
-	bh->b_bdev = sb->s_bdev;
+	bh->b_bdev_file = sb->s_bdev_file;
 	bh->b_blocknr = lbo >> sb->s_blocksize_bits;
 
 	valid = ni->i_valid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..fb426cf1887a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1632,7 +1632,7 @@ void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
 		limit >>= 1;
 
 	while (blocks--) {
-		clean_bdev_aliases(bdev, devblock++, 1);
+		clean_bdev_aliases(sb->s_bdev_file, devblock++, 1);
 		if (cnt++ >= limit) {
 			sync_blockdev(bdev);
 			cnt = 0;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index b82185075de7..e976950b0a2b 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2459,7 +2459,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	else
 		get_block = ocfs2_dio_wr_get_block;
 
-	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
+	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev_file,
 				    iter, get_block,
 				    ocfs2_dio_end_io, 0);
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
index 6474529c4253..11652650264c 100644
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
index 0554903f42a9..0bf515815b5d 100644
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
index 6ab2318a9c8e..e8dd9125213a 100644
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
index f288c94374b3..f51ff7261c4d 100644
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
index 4b7080e56e44..b08289492e51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -212,9 +212,11 @@ struct gendisk {
 	struct blk_independent_access_ranges *ia_ranges;
 };
 
+struct inode *bdev_inode(struct block_device *bdev);
+
 static inline bool disk_live(struct gendisk *disk)
 {
-	return !inode_unhashed(disk->part0->bd_inode);
+	return !inode_unhashed(bdev_inode(disk->part0));
 }
 
 /**
@@ -1319,7 +1321,7 @@ static inline unsigned int blksize_bits(unsigned int size)
 
 static inline unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << bdev_inode(bdev)->i_blkbits;
 }
 
 int kblockd_schedule_work(struct work_struct *work);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..d41a55005515 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -9,6 +9,7 @@
 #define _LINUX_BUFFER_HEAD_H
 
 #include <linux/types.h>
+#include <linux/blkdev.h>
 #include <linux/blk_types.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
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
@@ -212,24 +225,31 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
 				  bool datasync);
 int generic_buffers_fsync(struct file *file, loff_t start, loff_t end,
 			  bool datasync);
-void clean_bdev_aliases(struct block_device *bdev, sector_t block,
-			sector_t len);
+void __clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len);
+static inline void clean_bdev_aliases(struct file *bdev_file, sector_t block,
+				      sector_t len)
+{
+	__clean_bdev_aliases(file_bdev(bdev_file), block, len);
+}
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
 {
-	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
+	if (buffer_bdev(bh))
+		__clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
+	else
+		__clean_bdev_aliases(file_bdev(bh->b_bdev_file), bh->b_blocknr, 1);
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
+void __breadahead(struct file *, sector_t block, unsigned int size);
+struct buffer_head *__bread_gfp(struct file *,
 				sector_t block, unsigned size, gfp_t gfp);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
@@ -239,7 +259,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void submit_bh(blk_opf_t, struct buffer_head *);
-void write_boundary_block(struct block_device *bdev,
+void write_boundary_block(struct file *bdev_file,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
@@ -318,66 +338,66 @@ static inline void bforget(struct buffer_head *bh)
 static inline struct buffer_head *
 sb_bread(struct super_block *sb, sector_t block)
 {
-	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+	return __bread_gfp(sb->s_bdev_file, block, sb->s_blocksize, __GFP_MOVABLE);
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
+	gfp = mapping_gfp_constraint(bdev_file_inode(bdev_file)->i_mapping, ~__GFP_FS);
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
+	gfp = mapping_gfp_constraint(bdev_file_inode(bdev_file)->i_mapping, ~__GFP_FS);
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
@@ -447,9 +467,9 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
  *  It returns NULL if the block was unreadable.
  */
 static inline struct buffer_head *
-__bread(struct block_device *bdev, sector_t block, unsigned size)
+__bread(struct file *bdev_file, sector_t block, unsigned size)
 {
-	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
+	return __bread_gfp(bdev_file, block, size, __GFP_MOVABLE);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e0714d35d9b..039df1dacf7d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3105,7 +3105,7 @@ enum {
 };
 
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
-			     struct block_device *bdev, struct iov_iter *iter,
+			     struct file *bdev_file, struct iov_iter *iter,
 			     get_block_t get_block,
 			     dio_iodone_t end_io,
 			     int flags);
@@ -3115,7 +3115,7 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
 					 struct iov_iter *iter,
 					 get_block_t get_block)
 {
-	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
+	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev_file, iter,
 			get_block, NULL, DIO_LOCKING | DIO_SKIP_HOLES);
 }
 #endif
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..a99b27b290e8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -77,6 +77,7 @@ struct vm_fault;
  */
 #define IOMAP_F_SIZE_CHANGED	(1U << 8)
 #define IOMAP_F_STALE		(1U << 9)
+#define IOMAP_F_BDEV		(1U << 10)
 
 /*
  * Flags from 0x1000 up are for file system specific usage:
@@ -97,7 +98,10 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
-	struct block_device	*bdev;	/* block device for I/O */
+	union {
+		struct file		*bdev_file;
+		struct block_device	*bdev;
+	};
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
@@ -105,6 +109,13 @@ struct iomap {
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
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..3a68308674ad 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -967,6 +967,7 @@ struct journal_s
 	 * @j_dev: Device where we store the journal.
 	 */
 	struct block_device	*j_dev;
+	struct file		*j_bdev_file;
 
 	/**
 	 * @j_blocksize: Block size for the location where we store the journal.
@@ -992,6 +993,7 @@ struct journal_s
 	 * equal to j_dev.
 	 */
 	struct block_device	*j_fs_dev;
+	struct file		*j_fs_bdev_file;
 
 	/**
 	 * @j_fs_dev_wb_err:
@@ -1533,8 +1535,8 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
+extern journal_t * jbd2_journal_init_dev(struct file *bdev_file,
+				struct file *fs_dev,
 				unsigned long long start, int len, int bsize);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);
@@ -1696,7 +1698,7 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
 
 static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_bdev_file->f_mapping;
 
 	/*
 	 * Save the original wb_err value of client fs's bdev mapping which
@@ -1707,7 +1709,7 @@ static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 
 static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_bdev_file->f_mapping;
 
 	return errseq_check(&mapping->wb_err,
 			    READ_ONCE(journal->j_fs_dev_wb_err));
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
2.43.0


