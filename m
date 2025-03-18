Return-Path: <linux-fsdevel+bounces-44275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D529A66C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B857A9732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560921F8743;
	Tue, 18 Mar 2025 07:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664841E5B8C;
	Tue, 18 Mar 2025 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283855; cv=none; b=E6pXF00ymqFoE+/T4HVucxnD/cNtlmjnwPoTKpdOCYvnIm6NgP1e4YnBzn3ybpQvGbiuWaZpa5o3LisFZA8mRDSpTf+MVBHVeqROLooQ/32JpOCnyLuBEoFYiYRMHUKGAtLdaKD+GOGz43vNy/lmXeesFRc0e1On+GZYOCUruL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283855; c=relaxed/simple;
	bh=GylhaAIc/h2GTc00wGX0KruoW2QEqgB7uTz8ssTNFJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUpx/dxc/ujlQHBE0Q2fAeOAf4pluo0h9qrp9+n/Rg3BD+N2yy6J7BO5E8BsdKo4aYEKN/tumlEsbBZ9oeo79igK/ss8vc9bvxCOaoOLNu3pYvlTxhbsKZOlVxTpg+4GL1TFkDLaExLfF9nElyeNok1jYyc+a8IGLdTfr8vkSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kC4y3Lz4f3khW;
	Tue, 18 Mar 2025 15:43:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4B3DF1A058E;
	Tue, 18 Mar 2025 15:44:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S5;
	Tue, 18 Mar 2025 15:44:09 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH -next v3 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Date: Tue, 18 Mar 2025 15:35:36 +0800
Message-ID: <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF45JFW3uw4rCrW7Jry3XFb_yoW7Zry8pa
	4DKF1Utry0gF47A3Z7C3W7Wr1a93ykCry3G3yqkw15uw42gr1IgF4kKFy5X348J3sxWay0
	qa1UKrZ8uayUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
	6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWx
	JrUvcSsGvfC2KfnxnUUI43ZEXa7sRMRRRJUUUUU==
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
state. However, it is difficult to ascertain whether the storage device
supports unmap write zeroes. We cannot determine this solely by querying
bdev_limits(bdev)->max_write_zeroes_sectors.

Therefore, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP
and the corresponding sysfs entry, to indicate whether the block device
explicitly supports the unmapped write zeroes command. Each device
driver should set this bit if it is certain that the attached disk
supports this command. If the bit is not set, the disk either does not
support it, or its support status is unknown.

For the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP should be
supported both by the stacking driver and all underlying devices.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/ABI/stable/sysfs-block | 14 ++++++++++++++
 block/blk-settings.c                 |  6 ++++++
 block/blk-sysfs.c                    |  3 +++
 include/linux/blkdev.h               |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 890cde28bf90..67513c0d9233 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -742,6 +742,20 @@ Description:
 		0, write zeroes is not supported by the device.
 
 
+What:		/sys/block/<disk>/queue/write_zeroes_unmap
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RO] Devices that explicitly support the unmap write zeroes
+		operation in which a single write zeroes request with the unmap
+		bit set to zero out the range of contiguous blocks on storage
+		by freeing blocks, rather than writing physical zeroes to the
+		media. If write_zeroes_unmap is 1, this indicates that the
+		device explicitly supports the write zero command. Otherwise,
+		the device either does not support it, or its support status is
+		unknown.
+
+
 What:		/sys/block/<disk>/queue/zone_append_max_bytes
 Date:		May 2020
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6b2dbe645d23..3331d07bd5d9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -697,6 +697,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->features &= ~BLK_FEAT_NOWAIT;
 	if (!(b->features & BLK_FEAT_POLL))
 		t->features &= ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_WRITE_ZEROES_UNMAP))
+		t->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
 
 	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
 
@@ -819,6 +821,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
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
index d584461a1d84..6f00e9a8f8b6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -261,6 +261,7 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 
 QUEUE_SYSFS_FEATURE_SHOW(fua, BLK_FEAT_FUA);
 QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
+QUEUE_SYSFS_FEATURE_SHOW(write_zeroes_unmap, BLK_FEAT_WRITE_ZEROES_UNMAP);
 
 static ssize_t queue_poll_show(struct gendisk *disk, char *page)
 {
@@ -510,6 +511,7 @@ QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_write_zeroes_unmap, "write_zeroes_unmap");
 QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -656,6 +658,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
+	&queue_write_zeroes_unmap_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39c45bc0a97..5d280c7fba65 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -342,6 +342,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES \
 	((__force blk_features_t)(1u << 16))
 
+/* supports unmap write zeroes command */
+#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
-- 
2.46.1


