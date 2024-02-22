Return-Path: <linux-fsdevel+bounces-12460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A085F8B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A261C23E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFE1353E1;
	Thu, 22 Feb 2024 12:51:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653012E1D6;
	Thu, 22 Feb 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606301; cv=none; b=ENbeXTdbDcqSBRK4Hf4y4oWGJXE8ryLKiN0dRleYyoxXrfhOPL8k7ppfHbx0H7HTmntk8+vCL5Sm9/DK5yt13e/7m4VLKCEFH9yAJVQKMwrohYrZlbuvG2y6q9drlRdJ0FwHYDa0jy43FmJbtFILYHhMaHlFFcdXxlBX++6ayug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606301; c=relaxed/simple;
	bh=DCuxTdjRAuF/R8xLIGoKHbWpSl7hTRhlx4d89qyPjQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehEaMov57ia8Bus4BCjTcMrIUVKLEQRaVLxtzuRJkiOZHpNGQlfO7Oa7StFLebOoIaVu6ig0Q3+Hx3dd0yHXJ3+m3czK+TaxigpRdxXHilZjc/PL5zH9xw3UBsTShhxIrnWlAMtXdgPtjDq1IzMB6hHiufMo9ySUgFoAGwxKcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY1B4cmLz4f3m75;
	Thu, 22 Feb 2024 20:51:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C7AC61A09FA;
	Thu, 22 Feb 2024 20:51:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S7;
	Thu, 22 Feb 2024 20:51:33 +0800 (CST)
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
Subject: [RFC v4 linux-next 03/19] block: remove sync_blockdev_range()
Date: Thu, 22 Feb 2024 20:45:39 +0800
Message-Id: <20240222124555.2049140-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1fCr13tr1UAF1UtF4xJFb_yoW7tF47pr
	9xAF93GrWUGr1DWF4DGa1xAw1Sqw1qk3yxAr9xZ3y0g3yUtr9Igr9Ykw1jy3yYqrZ7Jry7
	ZF1Y9a4rKF1xCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to flush the file
mapping directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c           |  7 -------
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/volumes.c     | 19 +++++++++++--------
 fs/btrfs/volumes.h     |  2 +-
 fs/exfat/fatent.c      |  2 +-
 include/linux/blkdev.h |  1 -
 6 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 49dcff483289..e493d5c72edb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -200,13 +200,6 @@ int sync_blockdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(sync_blockdev);
 
-int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
-{
-	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
-			lstart, lend);
-}
-EXPORT_SYMBOL(sync_blockdev_range);
-
 /**
  * bdev_freeze - lock a filesystem and force it into a consistent state
  * @bdev:	blockdevice to lock
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7057221a46c3..88d45118cc64 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -982,7 +982,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_sysfs_remove_device(src_device);
 	btrfs_sysfs_update_devid(tgt_device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
-		btrfs_scratch_superblocks(fs_info, src_device->bdev,
+		btrfs_scratch_superblocks(fs_info, src_device->bdev_file,
 					  src_device->name->str);
 
 	/* write back the superblocks */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 493e33b4ae94..e12451ff911a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2033,14 +2033,14 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 }
 
 static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
-				     struct block_device *bdev, int copy_num)
+				     struct file *bdev_file, int copy_num)
 {
 	struct btrfs_super_block *disk_super;
 	const size_t len = sizeof(disk_super->magic);
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
+	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
 
@@ -2048,26 +2048,29 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 	folio_mark_dirty(virt_to_folio(disk_super));
 	btrfs_release_disk_super(disk_super);
 
-	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
+	ret = filemap_write_and_wait_range(bdev_file->f_mapping,
+					   bytenr, bytenr + len - 1);
 	if (ret)
 		btrfs_warn(fs_info, "error clearing superblock number %d (%d)",
 			copy_num, ret);
 }
 
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
+			       struct file *bdev_file,
 			       const char *device_path)
 {
+	struct block_device *bdev;
 	int copy_num;
 
-	if (!bdev)
+	if (!bdev_file)
 		return;
 
+	bdev = file_bdev(bdev_file);
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
 		if (bdev_is_zoned(bdev))
 			btrfs_reset_sb_log_zones(bdev, copy_num);
 		else
-			btrfs_scratch_superblock(fs_info, bdev, copy_num);
+			btrfs_scratch_superblock(fs_info, bdev_file, copy_num);
 	}
 
 	/* Notify udev that device has changed */
@@ -2209,7 +2212,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 *  just flush the device and let the caller do the final bdev_release.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
-		btrfs_scratch_superblocks(fs_info, device->bdev,
+		btrfs_scratch_superblocks(fs_info, device->bdev_file,
 					  device->name->str);
 		if (device->bdev) {
 			sync_blockdev(device->bdev);
@@ -2323,7 +2326,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
+	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev_file,
 				  tgtdev->name->str);
 
 	btrfs_close_bdev(tgtdev);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2ef78d3cc4c3..1d566f40b83d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -818,7 +818,7 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
 bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-			       struct block_device *bdev,
+			       struct file *bdev_file,
 			       const char *device_path);
 
 enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 56b870d9cc0d..1c86ec2465b7 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -296,7 +296,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	}
 
 	if (IS_DIRSYNC(dir))
-		return sync_blockdev_range(sb->s_bdev,
+		return filemap_write_and_wait_range(sb->s_bdev_file->f_mapping,
 				EXFAT_BLK_TO_B(blknr, sb),
 				EXFAT_BLK_TO_B(last_blknr, sb) - 1);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9e96811c8915..c510f334c84f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1527,7 +1527,6 @@ unsigned int block_size(struct block_device *bdev);
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
-- 
2.39.2


