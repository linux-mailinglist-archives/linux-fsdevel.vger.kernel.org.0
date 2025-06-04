Return-Path: <linux-fsdevel+bounces-50559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3CACD54F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E33C3A0453
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477621624C5;
	Wed,  4 Jun 2025 02:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB972602;
	Wed,  4 Jun 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003707; cv=none; b=f4kHXd8Fne1zRkoYNnhE0yTSa+Zvq/xJOk+Jp1q8rxyX+VR1ljRm5fJxBPF1EjuTtpDZLT6rDNIMktjk4R9grEb23+rZSq+2WOaDpgos+cpOjGx6UUoZiFOxjAPoYgNdmSH8ESMLr4zgvYXgtAzE2SjP5siPvfzW3kyD1q3/4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003707; c=relaxed/simple;
	bh=5+F2POqYVAGyc2lZEbWs+hLGB/t0LKP98L0ZQfpGSXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvR9CfrSmGoCQfN56TtAV8abXCQ9qg2bsKO71PVRYwicBycMeOaHIBCvVe+zTJvC3CW4h3abMhmS3YBr74RouarIufV87R9Q9cJfW0wk/o5upisd9dBP+fw8UnvUzzEVEftCNhsuzFAYS4r8eqlDI2t/rWjKJ0PIxHam5RPvoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBrtd12MwzKHN5m;
	Wed,  4 Jun 2025 10:21:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 82E611A156E;
	Wed,  4 Jun 2025 10:21:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+nrT9oedfBOQ--.14997S5;
	Wed, 04 Jun 2025 10:21:43 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Date: Wed,  4 Jun 2025 10:08:41 +0800
Message-ID: <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+nrT9oedfBOQ--.14997S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF45JFW3uw4rCF1UCFWktFb_yoW3ZFW5pF
	WDKFyrt3W8KF17u3Z3A3W7Wr1a9w4rCFWfG3yIkwnYvw43Xr1IgF1vqa4YqrWxGr93Way8
	XF4UtFZ09ay5C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUU9N3UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, disks primarily implement the write zeroes command (aka
REQ_OP_WRITE_ZEROES) through two mechanisms: the first involves
physically writing zeros to the disk media (e.g., HDDs), while the
second performs an unmap operation on the logical blocks, effectively
putting them into a deallocated state (e.g., SSDs). The first method is
generally slow, while the second method is typically very fast.

For example, on certain NVMe SSDs that support NVME_NS_DEAC, submitting
REQ_OP_WRITE_ZEROES requests with the NVME_WZ_DEAC bit can accelerate
the write zeros operation by placing disk blocks into a deallocated
state, which opportunistically avoids writing zeroes to media while
still guaranteeing that subsequent reads from the specified block range
will return zeroed data. This is a best-effort optimization, not a
mandatory requirement, some devices may partially fall back to writing
physical zeroes due to factors such as misalignment or being asked to
clear a block range smaller than the device's internal allocation unit.
Therefore, the speed of this operation is not guaranteed.

It is difficult to determine whether the storage device supports unmap
write zeroes operation. We cannot determine this by only querying
bdev_limits(bdev)->max_write_zeroes_sectors. First, add a new queue
limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP, to indicate whether a device
supports this unmap write zeroes operation. Then, add a new counterpart
flag, BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED and a sysfs entry, which
allow users to disable this operation if the speed is very slow on some
sepcial devices.

Finally, for the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP
should be supported both by the stacking driver and all underlying
devices.

Thanks to Martin K. Petersen for optimizing the documentation of the
write_zeroes_unmap sysfs interface.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 20 ++++++++++++++++++++
 block/blk-settings.c                 |  6 ++++++
 block/blk-sysfs.c                    | 25 +++++++++++++++++++++++++
 include/linux/blkdev.h               | 18 ++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..8e7d513286c4 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -778,6 +778,26 @@ Description:
 		0, write zeroes is not supported by the device.
 
 
+What:		/sys/block/<disk>/queue/write_zeroes_unmap
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RW] When read, this file will display whether the device has
+		enabled the unmap write zeroes operation. This operation
+		indicates that the device supports zeroing data in a specified
+		block range without incurring the cost of physically writing
+		zeroes to media for each individual block. It implements a
+		zeroing operation which opportunistically avoids writing zeroes
+		to media while still guaranteeing that subsequent reads from the
+		specified block range will return zeroed data. This operation is
+		a best-effort optimization, a device may fall back to physically
+		writing zeroes to media due to other factors such as
+		misalignment or being asked to clear a block range smaller than
+		the device's internal allocation unit. So the speed of this
+		operation is not guaranteed. Writing a value of '0' to this file
+		disables this operation.
+
+
 What:		/sys/block/<disk>/queue/zone_append_max_bytes
 Date:		May 2020
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..de99763fd668 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -698,6 +698,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->features &= ~BLK_FEAT_NOWAIT;
 	if (!(b->features & BLK_FEAT_POLL))
 		t->features &= ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_WRITE_ZEROES_UNMAP))
+		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
 
 	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
 
@@ -820,6 +822,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->zone_write_granularity = 0;
 		t->max_zone_append_sectors = 0;
 	}
+
+	if (!t->max_write_zeroes_sectors)
+		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
+
 	blk_stack_atomic_writes_limits(t, b, start);
 
 	return ret;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967..e918b2c93aed 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -457,6 +457,29 @@ static int queue_wc_store(struct gendisk *disk, const char *page,
 	return 0;
 }
 
+static ssize_t queue_write_zeroes_unmap_show(struct gendisk *disk, char *page)
+{
+	return sysfs_emit(page, "%u\n",
+			  blk_queue_write_zeroes_unmap(disk->queue));
+}
+
+static int queue_write_zeroes_unmap_store(struct gendisk *disk,
+		const char *page, size_t count, struct queue_limits *lim)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	ret = queue_var_store(&val, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (val)
+		lim->flags &= ~BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED;
+	else
+		lim->flags |= BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED;
+	return 0;
+}
+
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr	= { .name = _name, .mode = 0444 },	\
@@ -514,6 +537,7 @@ QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RW_ENTRY(queue_write_zeroes_unmap, "write_zeroes_unmap");
 QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -662,6 +686,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
+	&queue_write_zeroes_unmap_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d9..6f1cf97b1f00 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -340,6 +340,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES \
 	((__force blk_features_t)(1u << 16))
 
+/* supports unmap write zeroes command */
+#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
@@ -360,6 +363,10 @@ typedef unsigned int __bitwise blk_flags_t;
 /* passthrough command IO accounting */
 #define BLK_FLAG_IOSTATS_PASSTHROUGH	((__force blk_flags_t)(1u << 2))
 
+/* disable the unmap write zeroes operation */
+#define BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED \
+					((__force blk_flags_t)(1u << 3))
+
 struct queue_limits {
 	blk_features_t		features;
 	blk_flags_t		flags;
@@ -1378,6 +1385,17 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
 
+static inline bool blk_queue_write_zeroes_unmap(struct request_queue *q)
+{
+	return (q->limits.features & BLK_FEAT_WRITE_ZEROES_UNMAP) &&
+		!(q->limits.flags & BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED);
+}
+
+static inline bool bdev_write_zeroes_unmap(struct block_device *bdev)
+{
+	return blk_queue_write_zeroes_unmap(bdev_get_queue(bdev));
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
-- 
2.46.1


