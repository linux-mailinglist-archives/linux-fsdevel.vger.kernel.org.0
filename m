Return-Path: <linux-fsdevel+bounces-12474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E085F8D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40587B260D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6714A083;
	Thu, 22 Feb 2024 12:51:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50026137C3B;
	Thu, 22 Feb 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606306; cv=none; b=D3WZ/vxQL9kmj6H3uz+Smb0vL7UytOkn+D28OQrRS6wsAVZdZ+b0FrbErRwfv27M/LZYmq8Npods5BkDjOpMclmKWu4j/AtpGnkRw5aBzf+44w6z56gUYJz7WvfgGBk1kC5KOiuDnEltgAMWzohrijCLLEBjchgOA1F8j6Zr5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606306; c=relaxed/simple;
	bh=2AyS9xWODVDrP7RTwAtArfZw2cxIdVjOpPcLsDrpFcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHSrDagrK9I/E8hfuIO1dyOtPMKmBKfVoXyLPJrnK8835OFdeoXz54RlkIjsX659Da6XqylSJ/fgC52KcQeY/9FLSHFvmhUr37FN8vVNMY5VOjBhWoSqIABKNuRv7Ne59dthWfIwuOwRWjgdO6T+1sZvXPhq3ONaB/dVP264YY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY1G1ht7z4f3mHK;
	Thu, 22 Feb 2024 20:51:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 625351A0232;
	Thu, 22 Feb 2024 20:51:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S15;
	Thu, 22 Feb 2024 20:51:37 +0800 (CST)
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
Subject: [RFC v4 linux-next 11/19] btrfs: prevent direct access of bd_inode
Date: Thu, 22 Feb 2024 20:45:47 +0800
Message-Id: <20240222124555.2049140-12-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S15
X-Coremail-Antispam: 1UD129KBjvJXoW3CrWrCF1rKr1DCF4UWr1ftFb_yoWkurWfpr
	98Aas5JrWUJr1DWayDWa1kAw1Sgw1vkayxCF93J3ySg39rtr90qF90yr17AryrtrWkJr17
	ZF4UKa47Cr1IkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Now that all filesystems stash the bdev file, it's ok to get inode or
mapping from the file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/btrfs/disk-io.c | 17 +++++++++--------
 fs/btrfs/disk-io.h |  4 ++--
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 15 +++++++--------
 fs/btrfs/zoned.c   | 20 +++++++++++---------
 fs/btrfs/zoned.h   |  4 ++--
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bececdd63b4d..344955765f3e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3235,7 +3235,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
+	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev_file);
 	if (IS_ERR(disk_super)) {
 		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3656,17 +3656,18 @@ static void btrfs_end_super_write(struct bio *bio)
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
@@ -3707,7 +3708,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 }
 
 
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
+struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file)
 {
 	struct btrfs_super_block *super, *latest = NULL;
 	int i;
@@ -3719,7 +3720,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
 	for (i = 0; i < 1; i++) {
-		super = btrfs_read_dev_one_super(bdev, i, false);
+		super = btrfs_read_dev_one_super(bdev_file, i, false);
 		if (IS_ERR(super))
 			continue;
 
@@ -3749,7 +3750,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = device->bdev_file->f_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3866,7 +3867,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(device->bdev_file->f_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 375f62ae3709..2c627885d8d1 100644
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
index 40ae264fd3ed..9f50f20a1ba4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2286,7 +2286,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		return 0;
 
 	/* Only need to check the primary super block. */
-	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
+	sb = btrfs_read_dev_one_super(dev->bdev_file, 0, true);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e12451ff911a..9fccfb156bd2 100644
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
@@ -1244,7 +1244,7 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 	put_page(page);
 }
 
-static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
+static struct btrfs_super_block *btrfs_read_disk_super(struct file *bdev_file,
 						       u64 bytenr, u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
@@ -1253,7 +1253,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	pgoff_t index;
 
 	/* make sure our super fits in the device */
-	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
+	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(file_bdev(bdev_file)))
 		return ERR_PTR(-EINVAL);
 
 	/* make sure our super fits in the page */
@@ -1266,7 +1266,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
+	page = read_cache_page_gfp(bdev_file->f_mapping, index, GFP_KERNEL);
 
 	if (IS_ERR(page))
 		return ERR_CAST(page);
@@ -1368,14 +1368,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
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
@@ -2040,7 +2039,7 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr, bytenr);
+	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 12d77aba0148..9e4e2951cdf5 100644
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


