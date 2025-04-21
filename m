Return-Path: <linux-fsdevel+bounces-46765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF7FA94ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 04:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7669D16F23D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB8256C80;
	Mon, 21 Apr 2025 02:25:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982518DB3D;
	Mon, 21 Apr 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202334; cv=none; b=a5zyugJDx8FK6giEINLYbYcqIwLNyqbipLufs/KoCcjKhx6ZAjr9vMLbJYYi47hvljs6qa9mkpHDzH+rfSc0BVr8NDubuF5fV9slTMCI4+waegryyntDmeYsA22XYHd04tGT+YSOrFwQq0yQEuaUKNXIJ55OJu6KSuoM2tuYp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202334; c=relaxed/simple;
	bh=d8NKu11c0L/6hqcAgEPl8hg1PgWhSyhd6iLgSLVkYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY+M6q9f2PxqBNVwJ0Tj33XrYeXuiG+qG9p0E7nL+rJkM9ijbwb+2tXsBK5zkTY7xab7FYsQwYzfULbG0ZLFUl41UA5mk6s7eZaRrwa+1rctDFdqMF8M/bZGfn5yuImWfsVBeWymmbZgX3qfVOD3UDV72tKNxRGfIEgWs3noFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zgq2l12ypz4f3mHR;
	Mon, 21 Apr 2025 10:25:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 839BD1A058E;
	Mon, 21 Apr 2025 10:25:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+MrAVoFxZkKA--.3102S5;
	Mon, 21 Apr 2025 10:25:28 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v4 01/11] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Date: Mon, 21 Apr 2025 10:14:59 +0800
Message-ID: <20250421021509.2366003-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1+MrAVoFxZkKA--.3102S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF45JFW3uw4rCFWDAw1rXrb_yoWxWr1kpF
	y8KFyUtry0gF17u3Z7A3W7uF1a939Ykry3G39Fkw1ruw42gr1xWF1vqFyYq348J3s3Way0
	qa1UKr98uayUCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRlJPiUUUUU=
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
state (this is a best effort, not a mandatory requirement, some devices
may partially fall back to writing physical zeroes due to factors such
as receiving unaligned commands). However, it is difficult to determine
whether the storage device supports unmap write zeroes. We cannot
determine this by querying bdev_limits(bdev)->max_write_zeroes_sectors.

Therefore, add a new queue limit feature, BLK_FEAT_WRITE_ZEROES_UNMAP
and the corresponding sysfs entry, to indicate whether the block device
explicitly supports the unmapped write zeroes command. Each device
driver should set this bit if it is certain that the attached disk
supports this command. If the bit is not set, the disk either does not
support it, or its support status is unknown.

For the stacked devices cases, the BLK_FEAT_WRITE_ZEROES_UNMAP should be
supported both by the stacking driver and all underlying devices.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 18 ++++++++++++++++++
 block/blk-settings.c                 |  6 ++++++
 block/blk-sysfs.c                    |  3 +++
 include/linux/blkdev.h               |  8 ++++++++
 4 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 3879963f0f01..6531cdfcaacf 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -763,6 +763,24 @@ Description:
 		0, write zeroes is not supported by the device.
 
 
+What:		/sys/block/<disk>/queue/write_zeroes_unmap
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RO] Devices that explicitly support the unmap write zeroes
+		operation in which a single write zeroes request with the unmap
+		bit set to zero out the range of contiguous blocks on storage
+		by freeing blocks, rather than writing physical zeroes to the
+		media. If the write_zeroes_unmap is set to 1, this indicates
+		that the device explicitly supports the write zero command.
+		However, this may be a best-effort optimization rather than a
+		mandatory requirement, some devices may partially fall back to
+		writing physical zeroes due to factors such as receiving
+		unaligned commands. If the parameter is set to 0, the device
+		either does not support this operation, or its support status is
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
index a2882751f0d2..7a9c20bd3779 100644
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
index e39c45bc0a97..7c8752578e36 100644
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
@@ -1341,6 +1344,11 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
 
+static inline bool bdev_write_zeroes_unmap(struct block_device *bdev)
+{
+	return bdev_limits(bdev)->features & BLK_FEAT_WRITE_ZEROES_UNMAP;
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
-- 
2.46.1


