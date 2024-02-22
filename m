Return-Path: <linux-fsdevel+bounces-12457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5185F8AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B1F286771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C478B52;
	Thu, 22 Feb 2024 12:51:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997560B90;
	Thu, 22 Feb 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606300; cv=none; b=kYYhlUCSqd9dMcxJ4gJFb43+v1tdaWQUSe9Mn+3/wqzmnCLsBA/CGU5tXZXuTLSuUH9LuV4PV2GK4b31G4hqFW2hvexEnLQ9fhL3eI+sICyEtQYvTcsNq0ZhHIXF2CFpfVN8+G7cBocoEmpxAE9zkDPiGP424MyoRSbFZk/03Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606300; c=relaxed/simple;
	bh=07HTBNK+5nbyijzoFRPQLaQJkNcSWcs6crnJi8osP7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3BxOnQqqfXlz7wA0GZb/FfTrSn5ZqcGFO4fIi856T/+K18Quy6bcZuiJP9+RuA+gse2gOvui1SeZbFT10KBTLeLgHuBOLnS1g8KPKvqYb7XUVmegi/hsfTLs/b5zA52USsOBMEBCt2s1J13zMXpGLRD17DiDct9fb4X8oGfZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgY1D2RCSz4f3kFH;
	Thu, 22 Feb 2024 20:51:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5DC341A0232;
	Thu, 22 Feb 2024 20:51:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S6;
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
Subject: [RFC v4 linux-next 02/19] block: remove sync_blockdev_nowait()
Date: Thu, 22 Feb 2024 20:45:38 +0800
Message-Id: <20240222124555.2049140-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJr13CF1xGryUZw48Xrb_yoW5Cw4rpF
	nxAFZ7GrW8WF18WFs2vw4DZrySg3Wvk3yxCFySvw1YvFWqqrs2gF9YyFyrAFW0vrZ7ArW2
	qFWxuFy5uFy5C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to flush the file
mapping directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c           | 8 --------
 fs/fat/inode.c         | 2 +-
 fs/ntfs3/inode.c       | 2 +-
 fs/sync.c              | 9 ++++++---
 include/linux/blkdev.h | 5 -----
 5 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 726a2805a1ce..49dcff483289 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -188,14 +188,6 @@ int sb_min_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_min_blocksize);
 
-int sync_blockdev_nowait(struct block_device *bdev)
-{
-	if (!bdev)
-		return 0;
-	return filemap_flush(bdev->bd_inode->i_mapping);
-}
-EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
-
 /*
  * Write out and wait upon all the dirty data associated with a block
  * device via its mapping.  Does not take the superblock lock.
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 5c813696d1ff..8527aef51841 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1945,7 +1945,7 @@ int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
 	if (!ret && i2)
 		ret = writeback_inode(i2);
 	if (!ret)
-		ret = sync_blockdev_nowait(sb->s_bdev);
+		ret = filemap_flush(sb->s_bdev_file->f_mapping);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fat_flush_inodes);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index eb7a8c9fba01..3c4c878f6d77 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1081,7 +1081,7 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 	if (!ret && i2)
 		ret = writeback_inode(i2);
 	if (!ret)
-		ret = sync_blockdev_nowait(sb->s_bdev);
+		ret = filemap_flush(sb->s_bdev_file->f_mapping);
 	return ret;
 }
 
diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1ed..3a43062790d9 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -57,9 +57,12 @@ int sync_filesystem(struct super_block *sb)
 		if (ret)
 			return ret;
 	}
-	ret = sync_blockdev_nowait(sb->s_bdev);
-	if (ret)
-		return ret;
+
+	if (sb->s_bdev_file) {
+		ret = filemap_flush(sb->s_bdev_file->f_mapping);
+		if (ret)
+			return ret;
+	}
 
 	sync_inodes_sb(sb);
 	if (sb->s_op->sync_fs) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eb1f6eeaddc5..9e96811c8915 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1528,7 +1528,6 @@ unsigned int block_size(struct block_device *bdev);
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
-int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
@@ -1541,10 +1540,6 @@ static inline int sync_blockdev(struct block_device *bdev)
 {
 	return 0;
 }
-static inline int sync_blockdev_nowait(struct block_device *bdev)
-{
-	return 0;
-}
 static inline void sync_bdevs(bool wait)
 {
 }
-- 
2.39.2


