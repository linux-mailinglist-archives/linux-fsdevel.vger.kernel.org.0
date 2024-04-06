Return-Path: <linux-fsdevel+bounces-16268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428589A9E1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB342834AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EF32C1A6;
	Sat,  6 Apr 2024 09:17:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB07EEBB;
	Sat,  6 Apr 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395069; cv=none; b=mYjzEGhRSEMWl1qjtDiN4loFUmnvgFvchKxm3Lk4x/Y9k3uaaqgWL6LakUMbqRJJj2uOxDKzAkfVbQ+VaIdplnek2C6der411yiRQo3PgzZ88waybk1HwNTuhJ6mWmpEMN1yISR1vD4XeOxUsb0HGCoDrlG9Y0+iCrX7RjhUrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395069; c=relaxed/simple;
	bh=dNBqjZwjTaP+9WqGKegPiWuES3qTPoMZqb7CTuS6A4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akKtkwIvScaHBWUc1RVLTwVXdXVXBVflLm+SROOHHb8KXCQmqOnbMenfSqck9X21iLDYgxzgnX+iYEvzays2yf3QVxWSXc92DR4CARazqLFpnM8in590Fp0t2+xI+TKXTySf9sV6GKn9c9RYaHH4LUkiRECpx3NS+hmuxgcQK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVB61DVqz4f3lVn;
	Sat,  6 Apr 2024 17:17:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A1F1A1A016E;
	Sat,  6 Apr 2024 17:17:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S5;
	Sat, 06 Apr 2024 17:17:42 +0800 (CST)
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
Subject: [PATCH vfs.all 01/26] block: move two helpers into bdev.c
Date: Sat,  6 Apr 2024 17:09:05 +0800
Message-Id: <20240406090930.2252838-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45CFy3KF1ruryxJr17trb_yoW5Jr1UpF
	ZxGFW8G3yUCFyjgF40va1fZr1agw1kK34xJa4a934rKFyDtr4IgF1kJry8ZrWSqrZ7uFsx
	ZF43Ary0kryjk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1M7K7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

disk_live() and block_size() access bd_inode directly, prepare to remove
the field bd_inode from block_device, and only access bd_inode in block
layer.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 12 ++++++++++++
 include/linux/blkdev.h | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index dd26d37356aa..621b9163c0f6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1251,6 +1251,18 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 	blkdev_put_no_open(bdev);
 }
 
+bool disk_live(struct gendisk *disk)
+{
+	return !inode_unhashed(disk->part0->bd_inode);
+}
+EXPORT_SYMBOL_GPL(disk_live);
+
+unsigned int block_size(struct block_device *bdev)
+{
+	return 1 << bdev->bd_inode->i_blkbits;
+}
+EXPORT_SYMBOL_GPL(block_size);
+
 static int __init setup_bdev_allow_write_mounted(char *str)
 {
 	if (kstrtobool(str, &bdev_allow_write_mounted))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 172c91879999..2c0d3a89002c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -211,11 +211,6 @@ struct gendisk {
 	struct blk_independent_access_ranges *ia_ranges;
 };
 
-static inline bool disk_live(struct gendisk *disk)
-{
-	return !inode_unhashed(disk->part0->bd_inode);
-}
-
 /**
  * disk_openers - returns how many openers are there for a disk
  * @disk: disk to check
@@ -1364,11 +1359,6 @@ static inline unsigned int blksize_bits(unsigned int size)
 	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
 }
 
-static inline unsigned int block_size(struct block_device *bdev)
-{
-	return 1 << bdev->bd_inode->i_blkbits;
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
@@ -1536,6 +1526,8 @@ void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
+bool disk_live(struct gendisk *disk);
+unsigned int block_size(struct block_device *bdev);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2


