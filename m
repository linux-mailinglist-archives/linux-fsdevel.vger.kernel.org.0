Return-Path: <linux-fsdevel+bounces-12458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9485F8B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541631F22011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55162134CFA;
	Thu, 22 Feb 2024 12:51:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF812E1DB;
	Thu, 22 Feb 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606300; cv=none; b=sSy2pfxKRH6Rl2bwMdUjdcGHmrp5oSpwrx9g+E6Gbp7SjcCoz0remLjupbnRZDQ5XHWYh7BrlgOMNAnExw456OaF1aGRv2WiG0LLZcuShIsxuyfejA7E5ojOPrwrwOgHl3h1/F2IkQqZzzvqw517tpCyKKv40lz5Xfd15jZUoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606300; c=relaxed/simple;
	bh=MtUkDFYx5n2XNdciUUYtBWVksOOTShK5x/pRDnUqQ20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLTjkq5VEdPSCSpdnGZlSPIfGqDIDjRIllIftoIIufu57ZXcCpOc27+zww4k7AK962gfG88oyiXcyAB+bDK1MrkL1kghEF5i/qhwQUvsF49ejotqCD5PohLjrvN/FVwqoUVUtPMJ7PSY2begHpSneBK3ioLT80mgOO9otsaKwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY195YXmz4f3lVm;
	Thu, 22 Feb 2024 20:51:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E8AD51A09FA;
	Thu, 22 Feb 2024 20:51:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S5;
	Thu, 22 Feb 2024 20:51:32 +0800 (CST)
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
Subject: [RFC v4 linux-next 01/19] block: move two helpers into bdev.c
Date: Thu, 22 Feb 2024 20:45:37 +0800
Message-Id: <20240222124555.2049140-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45CFy3KF4rKFWkCrW5trb_yoW8KryfpF
	ZxGFW8G3yUCFyjgF4jva1fZr1agw4kK34fJa43u34rKryDtr4IgF1kJryrZrWSqrZ7uFsx
	ZF45JrW0kry0k3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

disk_live() and block_size() access bd_inode directly, prepare to remove
the field bd_inode from block_device, and only access bd_inode in block
layer.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c           | 12 ++++++++++++
 include/linux/blkdev.h | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 140093c99bdc..726a2805a1ce 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1196,6 +1196,18 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
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
index 06e854186947..eb1f6eeaddc5 100644
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
@@ -1359,11 +1354,6 @@ static inline unsigned int blksize_bits(unsigned int size)
 	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
 }
 
-static inline unsigned int block_size(struct block_device *bdev)
-{
-	return 1 << bdev->bd_inode->i_blkbits;
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
@@ -1531,6 +1521,8 @@ void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
+bool disk_live(struct gendisk *disk);
+unsigned int block_size(struct block_device *bdev);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2


