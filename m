Return-Path: <linux-fsdevel+bounces-16267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2789A9DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE20B221EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5D2943F;
	Sat,  6 Apr 2024 09:17:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4A1862A;
	Sat,  6 Apr 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395068; cv=none; b=uTLCxkxYhPVon+5JR/qp2iC2qlm+bU+SgGm0HZiNsbaXRh4AR8O3ApkrNC3XWN73IwIWv/JfykYZIFHYySBjKCl3RVv/9OLEFyV3Hqw0R068S+LQBKv6A0wSTzs4qb9k1vIleInJ/vGz8W6fMAMdppy493rKVU/MQDSBFm3wOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395068; c=relaxed/simple;
	bh=YaUJHyGS36XvrDajQBrXYYb4F/pVSj/DeaXUDCcINNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWn44NNAxaAq1JwYI0qsOAekTKzkaCnPzMThr0qZXJNRcdSaTKJbsW1grD/QrVjyj5PDy9taeM3JT/zdptPoHebIuhBjAHVgddqH302WQomWNW+vXraxs/FL++kxjjZDXZbB6koWnpMripvQDKBtwbEhR9cz+rPizVjw56dfP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VBVB82s1Wz4f3kGJ;
	Sat,  6 Apr 2024 17:17:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0FC4D1A0C75;
	Sat,  6 Apr 2024 17:17:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S6;
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
Subject: [PATCH vfs.all 02/26] block: remove sync_blockdev_nowait()
Date: Sat,  6 Apr 2024 17:09:06 +0800
Message-Id: <20240406090930.2252838-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJr17WF13ury5CF47twb_yoW5ZFy3pF
	nxAFZ7GrW8WF18WFs2vw4DZrySg3Wqk3yxCFyFvw1YvFWqqrs2gF9YyFyrAFW0vrZ7ArW2
	qFWxury5uFy5C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fcTPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that all filesystems stash the bdev file, it's ok to flush the file
mapping directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 8 --------
 fs/fat/inode.c         | 2 +-
 fs/ntfs3/inode.c       | 2 +-
 fs/sync.c              | 9 ++++++---
 include/linux/blkdev.h | 5 -----
 5 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 621b9163c0f6..c9b056782c96 100644
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
index d9e6fbb6f246..ef2ac3e7c3a8 100644
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
index 2c0d3a89002c..433c880299a6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1533,7 +1533,6 @@ unsigned int block_size(struct block_device *bdev);
 void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
-int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
@@ -1546,10 +1545,6 @@ static inline int sync_blockdev(struct block_device *bdev)
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


