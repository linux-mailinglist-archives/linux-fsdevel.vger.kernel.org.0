Return-Path: <linux-fsdevel+bounces-9352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1C840352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976232829CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DC5B5DE;
	Mon, 29 Jan 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYZH1Goy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BF5B5C5;
	Mon, 29 Jan 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525845; cv=none; b=fdEnYlJina87D7K+RX4Rs41Sv4yoJnnbst/GA4MzfAHna+PeiqboB8Q9wQNRpDgpJjbGs/hsm2RbM3Zxo6dbxZODer13W7b/PsDpCRYyoo9Lj+3nBARe4nTdkc2EfVLk6L4Dt5WfjRd29PLxYKcXeffk43z94TSSf0CISsXWBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525845; c=relaxed/simple;
	bh=Q1sSgJzPsnW2c/w1RrW1Rt/ULg82b7kgvOY8rPIDf9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8hPPCPDjMf6Fe+ZKmAxF91wq1Qlsz3gx7GvhMdfL8CN7PkDdu6tiCcpN6Cu4vPBAufVc4LOODYDZksiu/5G1m3JaNUBD7NDLGpe2CIWXyCssUs4+NxPC/tIT/KGhGROJNsGkFwWIPq7LrDtWqUuEGaARFWrzR7lAp8N0el1ADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYZH1Goy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24388C433C7;
	Mon, 29 Jan 2024 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706525845;
	bh=Q1sSgJzPsnW2c/w1RrW1Rt/ULg82b7kgvOY8rPIDf9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYZH1GoyFvfa60aNq+OLcVfZcXpOhPT8fUgMkjXHyQNRq9Bn0cR8IRmMXgEbduFzh
	 dUs7IQGU2vRYOX09bfAzauwMQRkPpqDgSaiY9NFUOStVROXSmM7/66t494/621MCRO
	 nKq33SovYrWiZazJ76+IGgP5cZiRGxk6id5Cly5BDl6F6qEwFakPmpf8iajSoXcr4j
	 UxnzmVLaIxOyEPiJPGSsIm9XsoAxKs/gPZIXhA8cuIuBlfOs3wyDANeuJr3v+CtzVY
	 wQfipQj7iH/89UalW+jEwpzQAnxvXZSiYU/T46RsDyhD3/OASAzv3LT2NMthbWOfC/
	 iYTfU9mbUNUvA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside of block layer and drivers
Date: Mon, 29 Jan 2024 11:56:42 +0100
Message-ID: <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17033; i=brauner@kernel.org; h=from:subject:message-id; bh=Q1sSgJzPsnW2c/w1RrW1Rt/ULg82b7kgvOY8rPIDf9E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRubyk4+YTpdVvgwpc/ZE49+hF5Q+jqTgvHvfavapLvF xxWKXG91FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR8tmMDO/uVRSq+O7oqgpO 1bSVuSQ22+Derf79s1pu9K2cumNdmAHDP4O+ss3CnxvP9s3svM99Z/l8LZOo/fHfzXsDUsvkl+k v4wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

There are a few places that use bdev->bd_inode. They don't need to
anymore as they can use the bdev file and bdev_file_inode().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/md/bcache/super.c       |  7 ++++---
 drivers/mtd/devices/block2mtd.c |  4 ++--
 fs/bcachefs/util.h              |  5 -----
 fs/btrfs/dev-replace.c          |  2 +-
 fs/btrfs/disk-io.c              | 17 +++++++++--------
 fs/btrfs/disk-io.h              |  4 ++--
 fs/btrfs/super.c                |  2 +-
 fs/btrfs/volumes.c              | 26 ++++++++++++++------------
 fs/btrfs/volumes.h              |  2 +-
 fs/btrfs/zoned.c                | 18 ++++++++++--------
 fs/btrfs/zoned.h                |  4 ++--
 11 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8971e769d5e7..48af785d8cd7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -163,15 +163,16 @@ static const char *read_super_common(struct cache_sb *sb,  struct block_device *
 }
 
 
-static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
+static const char *read_super(struct cache_sb *sb, struct bdev_file *bdev_file,
 			      struct cache_sb_disk **res)
 {
 	const char *err;
 	struct cache_sb_disk *s;
 	struct page *page;
 	unsigned int i;
+	struct block_device *bdev = file_bdev(bdev_file);
 
-	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping,
+	page = read_cache_page_gfp(bdev_file->f_mapping,
 				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
 	if (IS_ERR(page))
 		return "IO error";
@@ -2557,7 +2558,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (set_blocksize(file_bdev(bdev_file), 4096))
 		goto out_blkdev_put;
 
-	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
+	err = read_super(sb, bdev_file, &sb_disk);
 	if (err)
 		goto out_blkdev_put;
 
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index dc3df3a600cf..b8c224bf4b66 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -291,7 +291,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev_inode(bdev)->i_size % erase_size) {
+	if ((long)bdev_file_inode(bdev_file)->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -309,7 +309,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev_inode(bdev)->i_size & PAGE_MASK;
+	dev->mtd.size = bdev_file_inode(bdev_file)->i_size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 5ab765d056d6..ed869d67bd85 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -552,11 +552,6 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
 void bch2_bio_map(struct bio *bio, void *base, size_t);
 int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
 
-static inline sector_t bdev_sectors(struct block_device *bdev)
-{
-	return bdev_inode(bdev)->i_size >> 9;
-}
-
 #define closure_bio_submit(bio, cl)					\
 do {									\
 	closure_get(cl);						\
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2eb11fe4bd05..bd5498d2a187 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -984,7 +984,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_sysfs_remove_device(src_device);
 	btrfs_sysfs_update_devid(tgt_device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
-		btrfs_scratch_superblocks(fs_info, src_device->bdev,
+		btrfs_scratch_superblocks(fs_info, src_device->bdev_file,
 					  src_device->name->str);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d5d022b0bde..8a652374fa51 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3222,7 +3222,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
+	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev_file);
 	if (IS_ERR(disk_super)) {
 		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3633,17 +3633,18 @@ static void btrfs_end_super_write(struct bio *bio)
 	bio_put(bio);
 }
 
-struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+struct btrfs_super_block *btrfs_read_dev_one_super(struct file *bdev_file,
 						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
+	struct block_device *bdev = file_bdev(bdev_file);
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
+	struct address_space *mapping = bdev_file->f_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
-	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(bdev_file, copy_num, READ, &bytenr);
 	if (ret == -ENOENT)
 		return ERR_PTR(-EINVAL);
 	else if (ret)
@@ -3684,7 +3685,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 }
 
 
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
+struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file)
 {
 	struct btrfs_super_block *super, *latest = NULL;
 	int i;
@@ -3696,7 +3697,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i, false);
+		super = btrfs_read_dev_one_super(bdev_file, i, false);
 		if (IS_ERR(super))
 			continue;
 
@@ -3726,7 +3727,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = bdev_inode(device->bdev)->i_mapping;
+	struct address_space *mapping = device->bdev_file->f_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3843,7 +3844,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(bdev_inode(device->bdev)->i_mapping,
+		page = find_get_page(device->bdev_file->f_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9413726b329b..0e4494ffd7a1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -48,8 +48,8 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 struct btrfs_super_block *sb, int mirror_num);
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
-struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file);
+struct btrfs_super_block *btrfs_read_dev_one_super(struct file *bdev_file,
 						   int copy_num, bool drop_cache);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 896acfda1789..ffa4d0ea6b62 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2280,7 +2280,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		return 0;
 
 	/* Only need to check the primary super block. */
-	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	sb = btrfs_read_dev_one_super(dev->bdev_file, 0, true);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1f12122ae7ce..50d43a0deafe 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -490,7 +490,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		goto error;
 	}
 	invalidate_bdev(bdev);
-	*disk_super = btrfs_read_dev_super(bdev);
+	*disk_super = btrfs_read_dev_super(*bdev_file);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
 		fput(*bdev_file);
@@ -1246,10 +1246,11 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+static struct btrfs_super_block *btrfs_read_disk_super(struct file *bdev_file,
 						       u64 bytenr, u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
+	struct block_device *bdev = file_bdev(bdev_file);
 	struct page *page;
 	void *p;
 	pgoff_t index;
@@ -1268,7 +1269,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping, index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev_file->f_mapping, index, GFP_KERNEL);
 
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -1344,14 +1345,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		return ERR_CAST(bdev_file);
 
 	bytenr_orig = btrfs_sb_offset(0);
-	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(bdev_file, 0, READ, &bytenr);
 	if (ret) {
 		device = ERR_PTR(ret);
 		goto error_bdev_put;
 	}
 
-	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
-					   bytenr_orig);
+	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -2011,14 +2011,15 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 }
 
 static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
-				     struct block_device *bdev, int copy_num)
+				     struct file *bdev_file, int copy_num)
 {
+	struct block_device *bdev = file_bdev(bdev_file);
 	struct btrfs_super_block *disk_super;
 	const size_t len = sizeof(disk_super->magic);
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
+	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
 
@@ -2033,10 +2034,11 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 }
 
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
+			       struct file *bdev_file,
 			       const char *device_path)
 {
 	int copy_num;
+	struct block_device *bdev = file_bdev(bdev_file);
 
 	if (!bdev)
 		return;
@@ -2045,7 +2047,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		if (bdev_is_zoned(bdev))
 			btrfs_reset_sb_log_zones(bdev, copy_num);
 		else
-			btrfs_scratch_superblock(fs_info, bdev, copy_num);
+			btrfs_scratch_superblock(fs_info, bdev_file, copy_num);
 	}
 
 	/* Notify udev that device has changed */
@@ -2187,7 +2189,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 *  just flush the device and let the caller do the final bdev_release.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
-		btrfs_scratch_superblocks(fs_info, device->bdev,
+		btrfs_scratch_superblocks(fs_info, device->bdev_file,
 					  device->name->str);
 		if (device->bdev) {
 			sync_blockdev(device->bdev);
@@ -2301,7 +2303,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
+	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev_file,
 				  tgtdev->name->str);
 
 	btrfs_close_bdev(tgtdev);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a11854912d53..8b2a98a0459f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -781,7 +781,7 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
+			       struct file *bdev_file,
 			       const char *device_path);
 
 enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 42893771532f..d5d200f1a078 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -83,7 +83,7 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data
 	return 0;
 }
 
-static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
+static int sb_write_pointer(struct file *bdev_file, struct blk_zone *zones,
 			    u64 *wp_ret)
 {
 	bool empty[BTRFS_NR_SB_LOG_ZONES];
@@ -120,7 +120,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev_inode(bdev)->i_mapping;
+		struct address_space *mapping = bdev_file->f_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
@@ -564,7 +564,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		    BLK_ZONE_TYPE_CONVENTIONAL)
 			continue;
 
-		ret = sb_write_pointer(device->bdev,
+		ret = sb_write_pointer(device->bdev_file,
 				       &zone_info->sb_zones[sb_pos], &sb_wp);
 		if (ret != -ENOENT && ret) {
 			btrfs_err_in_rcu(device->fs_info,
@@ -800,18 +800,19 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount
 	return 0;
 }
 
-static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
+static int sb_log_location(struct file *bdev_file, struct blk_zone *zones,
 			   int rw, u64 *bytenr_ret)
 {
 	u64 wp;
 	int ret;
+	struct block_device *bdev = file_bdev(bdev_file);
 
 	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
 		return 0;
 	}
 
-	ret = sb_write_pointer(bdev, zones, &wp);
+	ret = sb_write_pointer(bdev_file, zones, &wp);
 	if (ret != -ENOENT && ret < 0)
 		return ret;
 
@@ -858,10 +859,11 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 
 }
 
-int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+int btrfs_sb_log_location_bdev(struct file *bdev_file, int mirror, int rw,
 			       u64 *bytenr_ret)
 {
 	struct blk_zone zones[BTRFS_NR_SB_LOG_ZONES];
+	struct block_device *bdev = file_bdev(bdev_file);
 	sector_t zone_sectors;
 	u32 sb_zone;
 	int ret;
@@ -895,7 +897,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	if (ret != BTRFS_NR_SB_LOG_ZONES)
 		return -EIO;
 
-	return sb_log_location(bdev, zones, rw, bytenr_ret);
+	return sb_log_location(bdev_file, zones, rw, bytenr_ret);
 }
 
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -919,7 +921,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return -ENOENT;
 
-	return sb_log_location(device->bdev,
+	return sb_log_location(device->bdev_file,
 			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
 			       rw, bytenr_ret);
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f573bda496fb..225d1c26d955 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -46,7 +46,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount_opt);
-int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+int btrfs_sb_log_location_bdev(struct file *bdev_file, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
@@ -127,7 +127,7 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
 	return 0;
 }
 
-static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
+static inline int btrfs_sb_log_location_bdev(struct file *bdev_file,
 					     int mirror, int rw, u64 *bytenr_ret)
 {
 	*bytenr_ret = btrfs_sb_offset(mirror);

-- 
2.43.0


