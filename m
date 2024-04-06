Return-Path: <linux-fsdevel+bounces-16287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF19989AA08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62092B223C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0B3FB1D;
	Sat,  6 Apr 2024 09:17:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864D39FE5;
	Sat,  6 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395075; cv=none; b=qhDrcRwU08iow2hK/KG08exWAy45h9YcpJ7iNW4TubKjMxIUD0PTyTJmLBSgZA5NWYiuJCiIhAk3pH3sg7keo9fzcTQxLiBYqHNkDfxdINMiWrq8i/oVCHiOh/n3VL1SH2kMIQytSQ3WaHPF7Fu2I0b9M+Z3lDVpORfttPyd+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395075; c=relaxed/simple;
	bh=pcjMvX4iWAJQ9J9m7Y1CdP7psXkpgzQlz5ovJqA3F8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3adgCiQj3HEKuoKrPRiguIty/YtIJaW3FnLK8KKlaBsABOOJRKFyx/ix5R11RERJjDv96qHdqD9al4EML2o9RZ+2+I7eUCgHKM+IjFh41KjZDCwnT8Qua0BwThbMDsopBpbGwvDbQVsng2gHOaYMtWlSOrIEPmzMRXx/ritBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBL6xfcz4f3jMM;
	Sat,  6 Apr 2024 17:17:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 47F721A058D;
	Sat,  6 Apr 2024 17:17:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S26;
	Sat, 06 Apr 2024 17:17:51 +0800 (CST)
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
Subject: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw blcok_device
Date: Sat,  6 Apr 2024 17:09:26 +0800
Message-Id: <20240406090930.2252838-23-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S26
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kZF4rKw4DCr4xGF13XFb_yoW7CF48pr
	Z5GFZ8tryqgas7WFWIqanrur1agw48Jw1UZasxWr9ay3yDtrna9a48KrW5uFy8t34kAF1Y
	qFW5WryUCFy3CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that iomap and bffer_head can convert to use bdev_file in following
patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c              | 137 +++++++++++++++++++++++++++++---------
 include/linux/blk_types.h |   1 +
 2 files changed, 107 insertions(+), 31 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 86db97b0709e..3d300823da6b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -846,6 +846,101 @@ static void init_bdev_file(struct file *bdev_file, struct block_device *bdev,
 	bdev_file->private_data = holder;
 }
 
+/*
+ * If BLK_OPEN_WRITE_IOCTL is set then this is a historical quirk
+ * associated with the floppy driver where it has allowed ioctls if the
+ * file was opened for writing, but does not allow reads or writes.
+ * Make sure that this quirk is reflected in @f_flags.
+ *
+ * It can also happen if a block device is opened as O_RDWR | O_WRONLY.
+ */
+static unsigned blk_to_file_flags(blk_mode_t mode)
+{
+	unsigned int flags = 0;
+
+	if ((mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) ==
+	    (BLK_OPEN_READ | BLK_OPEN_WRITE))
+		flags |= O_RDWR;
+	else if (mode & BLK_OPEN_WRITE_IOCTL)
+		flags |= O_RDWR | O_WRONLY;
+	else if (mode & BLK_OPEN_WRITE)
+		flags |= O_WRONLY;
+	else if (mode & BLK_OPEN_READ)
+		flags |= O_RDONLY; /* homeopathic, because O_RDONLY is 0 */
+	else
+		WARN_ON_ONCE(true);
+
+	if (mode & BLK_OPEN_NDELAY)
+		flags |= O_NDELAY;
+
+	return flags;
+}
+
+static int __stash_bdev_file(struct block_device *bdev)
+{
+	struct inode *inode = bdev_inode(bdev);
+	unsigned int flags = blk_to_file_flags(BLK_OPEN_READ | BLK_OPEN_WRITE);
+	struct file *file;
+	static struct file_operations stash_fops;
+
+	file = inode->i_private;
+	if (!file) {
+		/*
+		 * This file is used for iomap/buffer_head for raw block_device
+		 * read/write operations to access block_device.
+		 */
+		file = alloc_file_pseudo_noaccount(bdev_inode(bdev),
+				blockdev_mnt, "", flags | O_LARGEFILE,
+				&stash_fops);
+
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+
+		ihold(inode);
+		init_bdev_file(file, bdev, 0, NULL);
+
+		inode->i_private = file;
+		WARN_ON_ONCE(bdev->stash_count != 0);
+	}
+
+	bdev->stash_count++;
+	return 0;
+}
+
+static void __unstash_bdev_file(struct block_device *bdev)
+{
+
+	WARN_ON_ONCE(bdev->stash_count <= 0);
+	if (--bdev->stash_count == 0) {
+		struct inode *inode = bdev_inode(bdev);
+		struct file *file = inode->i_private;
+
+		inode->i_private = NULL;
+		fput(file);
+	}
+}
+
+static int stash_bdev_file(struct block_device *bdev)
+{
+	int ret = __stash_bdev_file(bdev);
+
+	if (ret || !bdev_is_partition(bdev))
+		return ret;
+
+	ret = __stash_bdev_file(bdev_whole(bdev));
+	if (ret)
+		__unstash_bdev_file(bdev);
+
+	return ret;
+}
+
+static void unstash_bdev_file(struct block_device *bdev)
+{
+	__unstash_bdev_file(bdev);
+	if (bdev_is_partition(bdev))
+		__unstash_bdev_file(bdev_whole(bdev));
+}
+
 /**
  * bdev_open - open a block device
  * @bdev: block device to open
@@ -891,12 +986,17 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
 		goto put_module;
+
+	ret = stash_bdev_file(bdev);
+	if (ret)
+		goto put_module;
+
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
 		ret = blkdev_get_whole(bdev, mode);
 	if (ret)
-		goto put_module;
+		goto unstash_bdev_file;
 	bdev_claim_write_access(bdev, mode);
 	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
@@ -922,6 +1022,9 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	init_bdev_file(bdev_file, bdev, mode, holder);
 
 	return 0;
+
+unstash_bdev_file:
+	unstash_bdev_file(bdev);
 put_module:
 	module_put(disk->fops->owner);
 abort_claiming:
@@ -932,36 +1035,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	return ret;
 }
 
-/*
- * If BLK_OPEN_WRITE_IOCTL is set then this is a historical quirk
- * associated with the floppy driver where it has allowed ioctls if the
- * file was opened for writing, but does not allow reads or writes.
- * Make sure that this quirk is reflected in @f_flags.
- *
- * It can also happen if a block device is opened as O_RDWR | O_WRONLY.
- */
-static unsigned blk_to_file_flags(blk_mode_t mode)
-{
-	unsigned int flags = 0;
-
-	if ((mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) ==
-	    (BLK_OPEN_READ | BLK_OPEN_WRITE))
-		flags |= O_RDWR;
-	else if (mode & BLK_OPEN_WRITE_IOCTL)
-		flags |= O_RDWR | O_WRONLY;
-	else if (mode & BLK_OPEN_WRITE)
-		flags |= O_WRONLY;
-	else if (mode & BLK_OPEN_READ)
-		flags |= O_RDONLY; /* homeopathic, because O_RDONLY is 0 */
-	else
-		WARN_ON_ONCE(true);
-
-	if (mode & BLK_OPEN_NDELAY)
-		flags |= O_NDELAY;
-
-	return flags;
-}
-
 struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 				   const struct blk_holder_ops *hops)
 {
@@ -1073,6 +1146,8 @@ void bdev_release(struct file *bdev_file)
 		blkdev_put_part(bdev);
 	else
 		blkdev_put_whole(bdev);
+
+	unstash_bdev_file(bdev);
 	mutex_unlock(&disk->open_mutex);
 
 	module_put(disk->fops->owner);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..22f736908cbe 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -70,6 +70,7 @@ struct block_device {
 #endif
 	bool			bd_ro_warned;
 	int			bd_writers;
+	int			stash_count;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
-- 
2.39.2


