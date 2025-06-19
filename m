Return-Path: <linux-fsdevel+bounces-52215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D9AE03AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2065D5A2216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD992472BE;
	Thu, 19 Jun 2025 11:31:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CA2367A0;
	Thu, 19 Jun 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332717; cv=none; b=orRg1slu3kkBqoQxjeTHKN56gek4TXbvtKdpz5zYqW78OWl6dVsWn3oD9rlNe5zqGY2OzM+4j5oBEX/yGdV4bw4WyT8J4kIbSHw7a4eKSeRO7Hp0D+icy9aWGJeywW968nYb9AjyQVeVvCqO3KKiVXJeeC/RpzVrs7TVdhYTh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332717; c=relaxed/simple;
	bh=WL4kFYCyy+hkdoxT5TYP7bfXSn52+bDxJkBhjIbS+4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAOGAcGor0EPJcEXgezo9FMwmIOfZ2olkIV7o1TOopIWz3LpbEDQvhVzmUY5Sw8FXYBGue3v4bjXlegfzy4tpCX014MYnSjyHiMLz02sYg/vuwmorqB9F66Slnl1dkhB8hMiTIrs/gfjdkl8Fe4ZfDF1whw7r14/5IfT+EUhvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNJNP06mgzKHN4b;
	Thu, 19 Jun 2025 19:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 55E641A18B9;
	Thu, 19 Jun 2025 19:31:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH618Y9VNoihn_Pw--.51230S5;
	Thu, 19 Jun 2025 19:31:46 +0800 (CST)
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
Subject: [PATCH v2 1/9] block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits
Date: Thu, 19 Jun 2025 19:17:58 +0800
Message-ID: <20250619111806.3546162-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH618Y9VNoihn_Pw--.51230S5
X-Coremail-Antispam: 1UD129KBjvJXoW3KF1UZryUKF4UKw4xKFWDXFb_yoWkJr18pF
	WUJFySq3sFqF47Zwn3J3WjgF1Sv34rCry3Gay7t3Z5C3yxWrnFgF18Ka4aqFWxCr95G3WU
	Xa10yFZ0kayjq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
bdev_limits(bdev)->max_write_zeroes_sectors. Therefore, first, add a new
hardware queue limit parameters, max_hw_wzeroes_unmap_sectors, to
indicate whether a device supports this unmap write zeroes operation.
Then, add two new counterpart software queue limits,
max_wzeroes_unmap_sectors and max_user_wzeroes_unmap_sectors, which
allow users to disable this operation if the speed is very slow on some
sepcial devices.

Finally, for the stacked devices cases, initialize these two parameters
to UINT_MAX. This operation should be enabled by both the stacking
driver and all underlying devices.

Thanks to Martin K. Petersen for optimizing the documentation of the
write_zeroes_unmap sysfs interface.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 33 ++++++++++++++++++++++++++++
 block/blk-settings.c                 | 20 +++++++++++++++--
 block/blk-sysfs.c                    | 26 ++++++++++++++++++++++
 include/linux/blkdev.h               | 10 +++++++++
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..803f578dc023 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -778,6 +778,39 @@ Description:
 		0, write zeroes is not supported by the device.
 
 
+What:		/sys/block/<disk>/queue/write_zeroes_unmap_max_hw_bytes
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RO] This file indicates whether a device supports zeroing data
+		in a specified block range without incurring the cost of
+		physically writing zeroes to the media for each individual
+		block. If this parameter is set to write_zeroes_max_bytes, the
+		device implements a zeroing operation which opportunistically
+		avoids writing zeroes to media while still guaranteeing that
+		subsequent reads from the specified block range will return
+		zeroed data. This operation is a best-effort optimization, a
+		device may fall back to physically writing zeroes to the media
+		due to other factors such as misalignment or being asked to
+		clear a block range smaller than the device's internal
+		allocation unit. If this parameter is set to 0, the device may
+		have to write each logical block media during a zeroing
+		operation.
+
+
+What:		/sys/block/<disk>/queue/write_zeroes_unmap_max_bytes
+Date:		January 2025
+Contact:	Zhang Yi <yi.zhang@huawei.com>
+Description:
+		[RW] While write_zeroes_unmap_max_hw_bytes is the hardware limit
+		for the device, this setting is the software limit. Since the
+		unmap write zeroes operation is a best-effort optimization, some
+		devices may still physically writing zeroes to media. So the
+		speed of this operation is not guaranteed. Writing a value of
+		'0' to this file disables this operation. Otherwise, this
+		parameter should be equal to write_zeroes_unmap_max_hw_bytes.
+
+
 What:		/sys/block/<disk>/queue/zone_append_max_bytes
 Date:		May 2020
 Contact:	linux-block@vger.kernel.org
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..b5c75f0ac3e9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -50,6 +50,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_hw_wzeroes_unmap_sectors = UINT_MAX;
+	lim->max_user_wzeroes_unmap_sectors = UINT_MAX;
 	lim->max_hw_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
 }
@@ -333,6 +335,12 @@ int blk_validate_limits(struct queue_limits *lim)
 	if (!lim->max_segments)
 		lim->max_segments = BLK_MAX_SEGMENTS;
 
+	if (lim->max_hw_wzeroes_unmap_sectors &&
+	    lim->max_hw_wzeroes_unmap_sectors != lim->max_write_zeroes_sectors)
+		return -EINVAL;
+	lim->max_wzeroes_unmap_sectors = min(lim->max_hw_wzeroes_unmap_sectors,
+			lim->max_user_wzeroes_unmap_sectors);
+
 	lim->max_discard_sectors =
 		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
 
@@ -418,10 +426,11 @@ int blk_set_default_limits(struct queue_limits *lim)
 {
 	/*
 	 * Most defaults are set by capping the bounds in blk_validate_limits,
-	 * but max_user_discard_sectors is special and needs an explicit
-	 * initialization to the max value here.
+	 * but these limits are special and need an explicit initialization to
+	 * the max value here.
 	 */
 	lim->max_user_discard_sectors = UINT_MAX;
+	lim->max_user_wzeroes_unmap_sectors = UINT_MAX;
 	return blk_validate_limits(lim);
 }
 
@@ -708,6 +717,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_user_wzeroes_unmap_sectors =
+			min(t->max_user_wzeroes_unmap_sectors,
+			    b->max_user_wzeroes_unmap_sectors);
+	t->max_hw_wzeroes_unmap_sectors =
+			min(t->max_hw_wzeroes_unmap_sectors,
+			    b->max_hw_wzeroes_unmap_sectors);
+
 	t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
 					b->max_hw_zone_append_sectors);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967..48c7ecbb531f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -161,6 +161,8 @@ static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_write_zeroes_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_wzeroes_unmap_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_wzeroes_unmap_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_zone_append_sectors)
@@ -205,6 +207,24 @@ static int queue_max_discard_sectors_store(struct gendisk *disk,
 	return 0;
 }
 
+static int queue_max_wzeroes_unmap_sectors_store(struct gendisk *disk,
+		const char *page, size_t count, struct queue_limits *lim)
+{
+	unsigned long max_zeroes_bytes, max_hw_zeroes_bytes;
+	ssize_t ret;
+
+	ret = queue_var_store(&max_zeroes_bytes, page, count);
+	if (ret < 0)
+		return ret;
+
+	max_hw_zeroes_bytes = lim->max_hw_wzeroes_unmap_sectors << SECTOR_SHIFT;
+	if (max_zeroes_bytes != 0 && max_zeroes_bytes != max_hw_zeroes_bytes)
+		return -EINVAL;
+
+	lim->max_user_wzeroes_unmap_sectors = max_zeroes_bytes >> SECTOR_SHIFT;
+	return 0;
+}
+
 static int
 queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count,
 		struct queue_limits *lim)
@@ -514,6 +534,10 @@ QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_wzeroes_unmap_sectors,
+		"write_zeroes_unmap_max_hw_bytes");
+QUEUE_LIM_RW_ENTRY(queue_max_wzeroes_unmap_sectors,
+		"write_zeroes_unmap_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
 QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -662,6 +686,8 @@ static struct attribute *queue_attrs[] = {
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
+	&queue_max_hw_wzeroes_unmap_sectors_entry.attr,
+	&queue_max_wzeroes_unmap_sectors_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..1a5725c1f93d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -383,6 +383,9 @@ struct queue_limits {
 	unsigned int		max_user_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_wzeroes_unmap_sectors;
+	unsigned int		max_hw_wzeroes_unmap_sectors;
+	unsigned int		max_user_wzeroes_unmap_sectors;
 	unsigned int		max_hw_zone_append_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
@@ -1042,6 +1045,7 @@ static inline void blk_queue_disable_secure_erase(struct request_queue *q)
 static inline void blk_queue_disable_write_zeroes(struct request_queue *q)
 {
 	q->limits.max_write_zeroes_sectors = 0;
+	q->limits.max_wzeroes_unmap_sectors = 0;
 }
 
 /*
@@ -1378,6 +1382,12 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
 
+static inline unsigned int
+bdev_write_zeroes_unmap_sectors(struct block_device *bdev)
+{
+	return bdev_limits(bdev)->max_wzeroes_unmap_sectors;
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
-- 
2.46.1


