Return-Path: <linux-fsdevel+bounces-16280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DCF89A9FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB61C20F4C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53839FC6;
	Sat,  6 Apr 2024 09:17:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC636B09;
	Sat,  6 Apr 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395073; cv=none; b=Y8x8Fl9E++iguOG1j6hDsrbYnPu3SlHdve8J+B46WvQ9kPt9OaxCPIAcNMBIpgfvxD39hjkCGK1jHcz19lNetpa1ijvKWFshaTpe9jz319eZJ4NHKrjbvNNbHOKi9HPr5BvgqsnuklAY/AsIEod2TuXIPJR/398wmSm0CvhxaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395073; c=relaxed/simple;
	bh=sBI5IP7HEIeGWKPvU1m2LBx55GGf+8Pouw7yjWnEM6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fgm99dmbE5RmIV9AeZcuuqYypv1t+LI2UgGH0iKDRuw3XxiPyxKNcKlvw19r+RKVtTG4BtlvEInWLmrESx88SlSzY6YcHKa0q5YbAUKgQzD5OgDiEIpvbEkTTb6RwuRMxaLnZau7m5RIWN80GScSauQUpPUZ1QkodPLFioZjWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBB1m0nz4f3lg0;
	Sat,  6 Apr 2024 17:17:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B76B51A0175;
	Sat,  6 Apr 2024 17:17:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S15;
	Sat, 06 Apr 2024 17:17:46 +0800 (CST)
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
Subject: [PATCH vfs.all 11/26] btrfs: prevent direct access of bd_inode
Date: Sat,  6 Apr 2024 17:09:15 +0800
Message-Id: <20240406090930.2252838-12-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S15
X-Coremail-Antispam: 1UD129KBjvJXoW3CrW7JrWDZw1DurWkJFykAFb_yoWktr4Upr
	98Aas5JrWUJr1DWayDWa1kAw1Sgw1vkayxCF93J3ySg39rtr90qFyqyr12yryrtrWkJr17
	ZF4UK347Cr1IkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now that all filesystems stash the bdev file, it's ok to get inode or
mapping from the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/disk-io.c | 17 +++++++++--------
 fs/btrfs/disk-io.h |  4 ++--
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 15 +++++++--------
 fs/btrfs/zoned.c   | 20 +++++++++++---------
 fs/btrfs/zoned.h   |  4 ++--
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3df5477d48a8..b565eef527a4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3233,7 +3233,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
+	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev_file);
 	if (IS_ERR(disk_super)) {
 		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3645,17 +3645,18 @@ static void btrfs_end_super_write(struct bio *bio)
 	bio_put(bio);
 }
 
-struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
+struct btrfs_super_block *btrfs_read_dev_one_super(struct file *bdev_file,
 						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct block_device *bdev = file_bdev(bdev_file);
+	struct address_space *mapping = bdev_file->f_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
-	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
+	ret = btrfs_sb_log_location_bdev(bdev_file, copy_num, READ, &bytenr);
 	if (ret == -ENOENT)
 		return ERR_PTR(-EINVAL);
 	else if (ret)
@@ -3696,7 +3697,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 }
 
 
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
+struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file)
 {
 	struct btrfs_super_block *super, *latest = NULL;
 	int i;
@@ -3708,7 +3709,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i, false);
+		super = btrfs_read_dev_one_super(bdev_file, i, false);
 		if (IS_ERR(super))
 			continue;
 
@@ -3738,7 +3739,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = device->bdev_file->f_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3855,7 +3856,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(device->bdev_file->f_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 76eb53fe7a11..8470426cd8e8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,8 +60,8 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
index 7e44ccaf348f..cbe64e9e22a8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2289,7 +2289,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		return 0;
 
 	/* Only need to check the primary super block. */
-	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	sb = btrfs_read_dev_one_super(dev->bdev_file, 0, true);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6f130c749dbc..e6c8b3a40ef7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -488,7 +488,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		goto error;
 	}
 	invalidate_bdev(bdev);
-	*disk_super = btrfs_read_dev_super(bdev);
+	*disk_super = btrfs_read_dev_super(*bdev_file);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
 		fput(*bdev_file);
@@ -1248,7 +1248,7 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+static struct btrfs_super_block *btrfs_read_disk_super(struct file *bdev_file,
 						       u64 bytenr, u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
@@ -1257,7 +1257,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	pgoff_t index;
 
 	/* make sure our super fits in the device */
-	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
+	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(file_bdev(bdev_file)))
 		return ERR_PTR(-EINVAL);
 
 	/* make sure our super fits in the page */
@@ -1270,7 +1270,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev_file->f_mapping, index, GFP_KERNEL);
 
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -1388,14 +1388,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
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
@@ -2057,7 +2056,7 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr, bytenr);
+	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5a3d5ec75c5a..b9b78374a612 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -81,7 +81,7 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data
 	return 0;
 }
 
-static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
+static int sb_write_pointer(struct file *bdev_file, struct blk_zone *zones,
 			    u64 *wp_ret)
 {
 	bool empty[BTRFS_NR_SB_LOG_ZONES];
@@ -118,7 +118,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct address_space *mapping = bdev_file->f_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
@@ -562,7 +562,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		    BLK_ZONE_TYPE_CONVENTIONAL)
 			continue;
 
-		ret = sb_write_pointer(device->bdev,
+		ret = sb_write_pointer(device->bdev_file,
 				       &zone_info->sb_zones[sb_pos], &sb_wp);
 		if (ret != -ENOENT && ret) {
 			btrfs_err_in_rcu(device->fs_info,
@@ -798,7 +798,7 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount
 	return 0;
 }
 
-static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
+static int sb_log_location(struct file *bdev_file, struct blk_zone *zones,
 			   int rw, u64 *bytenr_ret)
 {
 	u64 wp;
@@ -809,7 +809,7 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 		return 0;
 	}
 
-	ret = sb_write_pointer(bdev, zones, &wp);
+	ret = sb_write_pointer(bdev_file, zones, &wp);
 	if (ret != -ENOENT && ret < 0)
 		return ret;
 
@@ -827,7 +827,8 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 			ASSERT(sb_zone_is_full(reset));
 
 			nofs_flags = memalloc_nofs_save();
-			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+			ret = blkdev_zone_mgmt(file_bdev(bdev_file),
+					       REQ_OP_ZONE_RESET,
 					       reset->start, reset->len);
 			memalloc_nofs_restore(nofs_flags);
 			if (ret)
@@ -859,10 +860,11 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 
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
@@ -896,7 +898,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	if (ret != BTRFS_NR_SB_LOG_ZONES)
 		return -EIO;
 
-	return sb_log_location(bdev, zones, rw, bytenr_ret);
+	return sb_log_location(bdev_file, zones, rw, bytenr_ret);
 }
 
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -920,7 +922,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return -ENOENT;
 
-	return sb_log_location(device->bdev,
+	return sb_log_location(device->bdev_file,
 			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
 			       rw, bytenr_ret);
 }
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 77c4321e331f..32680a04aa1f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -61,7 +61,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount_opt);
-int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+int btrfs_sb_log_location_bdev(struct file *bdev_file, int mirror, int rw,
 			       u64 *bytenr_ret);
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
@@ -142,7 +142,7 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
 	return 0;
 }
 
-static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
+static inline int btrfs_sb_log_location_bdev(struct file *bdev_file,
 					     int mirror, int rw, u64 *bytenr_ret)
 {
 	*bytenr_ret = btrfs_sb_offset(mirror);
-- 
2.39.2


