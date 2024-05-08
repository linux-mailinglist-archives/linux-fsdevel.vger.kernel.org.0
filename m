Return-Path: <linux-fsdevel+bounces-19017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B988BF67B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF221F23C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B3A2837F;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nPy4yH1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4B1EB45
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150696; cv=none; b=Y+P93Ss3S5dGeznZbFdD4Xa0nD6ZZqxcI5pt4QOOw7XuA4qyG7ZgdyKfooB4gCs389WSepg6ImT19QrSX37XtV+fzHINfPLcOuIYp+HKsHEbamz12OMwwDYDFyrljK2GIggg3lXX+AoVzn9hoouJW7rD9vvz8LFX9YiQESiwxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150696; c=relaxed/simple;
	bh=xvHRj0sNwm/qnUOV5WJ0eagjVhHodiqbIUvQiAciqWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNeghT7bshOj3v7bRThf0o9FKC54txe0Nbtm9+U9pAP8fk57asS9/KjSYsGF5tq31zTUiOjLLKsZzAZTP0NS21kEfr03YgZ1f7L4CrJQjhXMV17DehwlubGLtCXr46FiMbTp3/LPQuuoc6KuZrkQG0Uj9rGzXLuUvL08saqsTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nPy4yH1n; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BkOrbdiJzP9QQlQw0aPqksmh7HOdg5AX9srOQ6chyYk=; b=nPy4yH1n38xIxQiWLKq5wwwPeM
	drg/OGqHpEUNiKHt0FhewQ/ptxQCA/gCDHh/0pvuHTKEJnJOjptbSUcLB3t9AV7+6Elk+nA0SwiaU
	lvRZNxe8ADLjHmB1/3GgH+utyGxmNYKTyVoTOro+mg/jC0dcBP+rKauDWGdY5NFwjDqY4xLvnxQcM
	moJErELu/FYTutHQxrT65cIRzzl8UdVYWJsDtpsjhPUJMla+IDb/vDcA/iG7gmYC6a7EE8k89Y7DD
	4fVKh7pjhRr7/3oJJfC3b3OxWwaN+ZcMpIJMRF67Sxt9W+Njj4H5OxAi+2htqeGj+tSaKagArxdj+
	2r8jUf4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2q-00FvzL-1n;
	Wed, 08 May 2024 06:44:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 02/10] use ->bd_mapping instead of ->bd_inode->i_mapping
Date: Wed,  8 May 2024 07:44:44 +0100
Message-Id: <20240508064452.3797817-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Just the low-hanging fruit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-2-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c                | 18 +++++++++---------
 block/blk-zoned.c           |  4 ++--
 block/genhd.c               |  2 +-
 block/ioctl.c               |  4 ++--
 block/partitions/core.c     |  2 +-
 drivers/md/bcache/super.c   |  2 +-
 drivers/scsi/scsicam.c      |  2 +-
 fs/btrfs/disk-io.c          |  6 +++---
 fs/btrfs/volumes.c          |  2 +-
 fs/btrfs/zoned.c            |  2 +-
 fs/buffer.c                 |  2 +-
 fs/cramfs/inode.c           |  2 +-
 fs/erofs/data.c             |  2 +-
 fs/ext4/dir.c               |  2 +-
 fs/ext4/ext4_jbd2.c         |  2 +-
 fs/ext4/super.c             |  6 +++---
 fs/jbd2/journal.c           |  2 +-
 include/linux/buffer_head.h |  4 ++--
 include/linux/jbd2.h        |  4 ++--
 19 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 8e19101cbbb0..00017af92a51 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -76,7 +76,7 @@ static void bdev_write_inode(struct block_device *bdev)
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev->bd_mapping;
 
 	if (mapping_empty(mapping))
 		return;
@@ -88,7 +88,7 @@ static void kill_bdev(struct block_device *bdev)
 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev->bd_mapping;
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
@@ -116,7 +116,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			goto invalidate;
 	}
 
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	truncate_inode_pages_range(bdev->bd_mapping, lstart, lend);
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
@@ -126,7 +126,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * Someone else has handle exclusively open. Try invalidating instead.
 	 * The 'end' argument is inclusive so the rounding is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(bdev->bd_mapping,
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
@@ -198,7 +198,7 @@ int sync_blockdev_nowait(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_flush(bdev->bd_inode->i_mapping);
+	return filemap_flush(bdev->bd_mapping);
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
@@ -210,13 +210,13 @@ int sync_blockdev(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	return filemap_write_and_wait(bdev->bd_mapping);
 }
 EXPORT_SYMBOL(sync_blockdev);
 
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
 {
-	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
+	return filemap_write_and_wait_range(bdev->bd_mapping,
 			lstart, lend);
 }
 EXPORT_SYMBOL(sync_blockdev_range);
@@ -445,7 +445,7 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
 	if (bdev_stable_writes(bdev))
-		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
+		mapping_set_stable_writes(bdev->bd_mapping);
 	bdev->bd_dev = dev;
 	bdev->bd_inode->i_rdev = dev;
 	bdev->bd_inode->i_ino = dev;
@@ -925,7 +925,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		bdev_file->f_mode |= FMODE_NOWAIT;
 	if (mode & BLK_OPEN_RESTRICT_WRITES)
 		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
-	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
+	bdev_file->f_mapping = bdev->bd_mapping;
 	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
 	bdev_file->private_data = holder;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index da0f4b2a8fa0..b008bcd4889c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -398,7 +398,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_lock(bdev->bd_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
@@ -420,7 +420,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	if (cmd == BLKRESETZONE)
-		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_unlock(bdev->bd_mapping);
 
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index 93f5118b7d41..2bf05bd0f071 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -745,7 +745,7 @@ void invalidate_disk(struct gendisk *disk)
 	struct block_device *bdev = disk->part0;
 
 	invalidate_bdev(bdev);
-	bdev->bd_inode->i_mapping->wb_err = 0;
+	bdev->bd_mapping->wb_err = 0;
 	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL(invalidate_disk);
diff --git a/block/ioctl.c b/block/ioctl.c
index 1c800364bc70..7c13d8bed453 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -152,12 +152,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_unlock(bdev->bd_mapping);
 	return err;
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 2b75e325c63b..63ee317dfff0 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -704,7 +704,7 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
+	struct address_space *mapping = state->disk->part0->bd_mapping;
 	struct folio *folio;
 
 	if (n >= get_capacity(state->disk)) {
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0ee5e17ae2dd..277ad958cf53 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -171,7 +171,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	struct page *page;
 	unsigned int i;
 
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
+	page = read_cache_page_gfp(bdev->bd_mapping,
 				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
 	if (IS_ERR(page))
 		return "IO error";
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e2c7d8ef205f..dd69342bbe78 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,7 +32,7 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_whole(dev)->bd_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3df5477d48a8..f10e894b0bf5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3651,7 +3651,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	struct btrfs_super_block *super;
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev->bd_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -3738,7 +3738,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = device->bdev->bd_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3855,7 +3855,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(device->bdev->bd_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 65c03ddecc59..33d357e5f9c5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1290,7 +1290,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev->bd_mapping, index, GFP_KERNEL);
 
 	if (IS_ERR(page))
 		return ERR_CAST(page);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4cba80b34387..9b43fa493219 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -118,7 +118,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct address_space *mapping = bdev->bd_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c46..d5a0932ae68d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1463,7 +1463,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 {
 	struct buffer_head *bh;
 
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= mapping_gfp_constraint(bdev->bd_mapping, ~__GFP_FS);
 
 	/*
 	 * Prefer looping in the allocator rather than here, at least that
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9901057a15ba..460690ca0174 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -183,7 +183,7 @@ static int next_buffer;
 static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 				unsigned int len)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = sb->s_bdev->bd_mapping;
 	struct file_ra_state ra = {};
 	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e1a170e45c70..5fc03c1e2757 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -68,7 +68,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	if (erofs_is_fscache_mode(sb))
 		buf->mapping = EROFS_SB(sb)->s_fscache->inode->i_mapping;
 	else
-		buf->mapping = sb->s_bdev->bd_inode->i_mapping;
+		buf->mapping = sb->s_bdev->bd_mapping;
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..ff4514e4626b 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
+					sb->s_bdev->bd_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 5d8055161acd..da4a82456383 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = sb->s_bdev->bd_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b255f798f449..02042eb91806 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -5556,7 +5556,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&sb->s_bdev->bd_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..03c4b9214f56 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2009,7 +2009,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		byte_count = (block_stop - block_start + 1) *
 				journal->j_blocksize;
 
-		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+		truncate_inode_pages_range(journal->j_dev->bd_mapping,
 				byte_start, byte_stop);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..e58a0d63409a 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -338,7 +338,7 @@ static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev->bd_mapping, ~__GFP_FS);
 	gfp |= __GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
@@ -349,7 +349,7 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev->bd_mapping, ~__GFP_FS);
 	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..ac31c37816f7 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1696,7 +1696,7 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
 
 static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_dev->bd_mapping;
 
 	/*
 	 * Save the original wb_err value of client fs's bdev mapping which
@@ -1707,7 +1707,7 @@ static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
 
 static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
 {
-	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	struct address_space *mapping = journal->j_fs_dev->bd_mapping;
 
 	return errseq_check(&mapping->wb_err,
 			    READ_ONCE(journal->j_fs_dev_wb_err));
-- 
2.39.2


