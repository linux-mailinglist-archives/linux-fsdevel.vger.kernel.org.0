Return-Path: <linux-fsdevel+bounces-16266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4789A9DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245AE1F21D62
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EB28E34;
	Sat,  6 Apr 2024 09:17:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0213ACC;
	Sat,  6 Apr 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395068; cv=none; b=gObCR1ksnmoUokaVh/pBspLfpjogOOUM1xjp2E4JQ/LC+roeBrqiUrUs0oRuu66imCWPydsrIxvY8JnagHwoVh6+kEczbp3qDpg66ACmL6o+e9iILe01Rpax2hAg9AbFX4QcHUMhwMlVY+tqFOI+fny3FaJLL7FbxZkv8MWeAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395068; c=relaxed/simple;
	bh=H82D58NOgy0o7/74tqwrG1s/n91s+R+aCwnBgkogdlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prHEo+ozUuKnbt3COZ1OgwESnRuCKxpVVp3IQFJlEfnFfpxSMF4/TxsyZprISxKAKuU4xlkWp+94JIHdApbrhklBXc5HqDRAAqLImpRiBJ8GBSLLlEc8qpAGfdV0uXYR6pmK3v/OlafXXDS4ZcRQLoWiwst68ShnTVXKsCW8Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBC13jKz4f3jkT;
	Sat,  6 Apr 2024 17:17:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 725EC1A016E;
	Sat,  6 Apr 2024 17:17:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S7;
	Sat, 06 Apr 2024 17:17:43 +0800 (CST)
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
Subject: [PATCH vfs.all 03/26] block: remove sync_blockdev_range()
Date: Sat,  6 Apr 2024 17:09:07 +0800
Message-Id: <20240406090930.2252838-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJr17WryxJr15ZrW3trb_yoWrXr17pF
	9xCF93GrW8Gr4DWF4UCa1xAw1FgwnFk34xAr9xZ3yFq3yDtr9xKryktr1YyayUtrZ3JrWD
	XFy29a4SgF1xCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to flush the file
mapping directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           |  7 -------
 fs/btrfs/volumes.c     | 12 +++++++-----
 fs/exfat/fatent.c      |  2 +-
 include/linux/blkdev.h |  1 -
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c9b056782c96..d53bf2f46b43 100644
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
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1dc1f1946ae0..6f130c749dbc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2050,14 +2050,14 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
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
 
@@ -2065,7 +2065,8 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 	folio_mark_dirty(virt_to_folio(disk_super));
 	btrfs_release_disk_super(disk_super);
 
-	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
+	ret = filemap_write_and_wait_range(bdev_file->f_mapping,
+					   bytenr, bytenr + len - 1);
 	if (ret)
 		btrfs_warn(fs_info, "error clearing superblock number %d (%d)",
 			copy_num, ret);
@@ -2075,15 +2076,16 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
 {
 	int copy_num;
 	struct block_device *bdev = device->bdev;
+	struct file *bdev_file = device->bdev_file;
 
-	if (!bdev)
+	if (!bdev || !bdev_file)
 		return;
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
 		if (bdev_is_zoned(bdev))
 			btrfs_reset_sb_log_zones(bdev, copy_num);
 		else
-			btrfs_scratch_superblock(fs_info, bdev, copy_num);
+			btrfs_scratch_superblock(fs_info, bdev_file, copy_num);
 	}
 
 	/* Notify udev that device has changed */
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
index 433c880299a6..08d4e6a0940c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1532,7 +1532,6 @@ unsigned int block_size(struct block_device *bdev);
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
-int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
-- 
2.39.2


