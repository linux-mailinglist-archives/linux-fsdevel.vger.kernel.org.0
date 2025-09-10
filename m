Return-Path: <linux-fsdevel+bounces-60759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7CB51532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762225633AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806E31C57B;
	Wed, 10 Sep 2025 11:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8A319872;
	Wed, 10 Sep 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502750; cv=none; b=jhDg7DEQzptT1xkUSd5gnTyNP1gYvG87cVl1nrH/zsXEqtpUH32Vqzsm71qnz3Bv9VT175Rnla/K369FuG/QpQ+62Ek4blyVoWHyFB2v50rqCJWWDbxHUw4xRkuGzHw3TLTFYJtbGXHc2KdZcZutjWKsj2iBUwVadY8xgbvTepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502750; c=relaxed/simple;
	bh=1zKt8d9RuFs5wmRU/AZF+NO4rZEEe0oY+FRvaXlFP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRSgaPp7Kjz48m1u+VpQAzg8AuX5Ay6NqineMUDRWBZwXx4iVwWS/Os8LYca18qAehh5CV5b3wf++LHhni59+lf2Tx7JqYOBn6DnMVGXkazyr7heG+PO8H80lSJ4fRhcNVoSB8DUUGJAoDf5oVksc6E/bTr/1SpUj81YB3/TlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMJ1h0fhwzKHN4Z;
	Wed, 10 Sep 2025 19:12:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C50A1A1B4C;
	Wed, 10 Sep 2025 19:12:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y0OXcFonCkfCA--.57678S5;
	Wed, 10 Sep 2025 19:12:24 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.g.garry@oracle.com,
	pmenzel@molgen.mpg.de,
	hch@lst.de,
	martin.petersen@oracle.com,
	axboe@kernel.dk,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
Date: Wed, 10 Sep 2025 19:11:06 +0800
Message-ID: <20250910111107.3247530-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y0OXcFonCkfCA--.57678S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWUXw1rJr1UAr4xtw17trb_yoWrZw4Dpa
	y7XFySvryUJayUAaykJ347uF4rX345GrW2kFy7ZwnY9Fy7Wr9rWF4rta98XrsrJw15Jasx
	t3W0k3yDu3WjgrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JU4OJ5UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The parameter max_hw_wzeroes_unmap_sectors in queue_limits should be
equal to max_write_zeroes_sectors if it is set to a non-zero value.
However, the stacked md drivers call md_init_stacking_limits() to
initialize this parameter to UINT_MAX but only adjust
max_write_zeroes_sectors when setting limits. Therefore, this
discrepancy triggers a value check failure in blk_validate_limits().

 $ modprobe scsi_debug num_parts=2 dev_size_mb=8 lbprz=1 lbpws=1
 $ mdadm --create /dev/md0 --level=0 --raid-device=2 /dev/sda1 /dev/sda2
   mdadm: Defaulting to version 1.2 metadata
   mdadm: RUN_ARRAY failed: Invalid argument

Fix this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
max_write_zeroes_sectors. Since the linear and raid0 drivers support
write zeroes, so they can support unmap write zeroes operation if all of
the backend devices support it. However, the raid1/10/5 drivers don't
support write zeroes, so we have to set it to zero.

Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
Reported-by: John Garry <john.g.garry@oracle.com>
Closes: https://lore.kernel.org/linux-block/803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Li Nan <linan122@huawei.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-linear.c | 1 +
 drivers/md/raid0.c     | 1 +
 drivers/md/raid1.c     | 1 +
 drivers/md/raid10.c    | 1 +
 drivers/md/raid5.c     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 5d9b08115375..3e1f165c2d20 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -73,6 +73,7 @@ static int linear_set_limits(struct mddev *mddev)
 	md_init_stacking_limits(&lim);
 	lim.max_hw_sectors = mddev->chunk_sectors;
 	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
+	lim.max_hw_wzeroes_unmap_sectors = mddev->chunk_sectors;
 	lim.io_min = mddev->chunk_sectors << 9;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
 	if (err)
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f1d8811a542a..419139ad7663 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -382,6 +382,7 @@ static int raid0_set_limits(struct mddev *mddev)
 	md_init_stacking_limits(&lim);
 	lim.max_hw_sectors = mddev->chunk_sectors;
 	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
+	lim.max_hw_wzeroes_unmap_sectors = mddev->chunk_sectors;
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.io_opt = lim.io_min * mddev->raid_disks;
 	lim.chunk_sectors = mddev->chunk_sectors;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bf44878ec640..d30b82beeb92 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3211,6 +3211,7 @@ static int raid1_set_limits(struct mddev *mddev)
 
 	md_init_stacking_limits(&lim);
 	lim.max_write_zeroes_sectors = 0;
+	lim.max_hw_wzeroes_unmap_sectors = 0;
 	lim.features |= BLK_FEAT_ATOMIC_WRITES;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
 	if (err)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b60c30bfb6c7..9832eefb2f15 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4008,6 +4008,7 @@ static int raid10_set_queue_limits(struct mddev *mddev)
 
 	md_init_stacking_limits(&lim);
 	lim.max_write_zeroes_sectors = 0;
+	lim.max_hw_wzeroes_unmap_sectors = 0;
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.chunk_sectors = mddev->chunk_sectors;
 	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 023649fe2476..e385ef1355e8 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7732,6 +7732,7 @@ static int raid5_set_limits(struct mddev *mddev)
 	lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
 	lim.discard_granularity = stripe;
 	lim.max_write_zeroes_sectors = 0;
+	lim.max_hw_wzeroes_unmap_sectors = 0;
 	mddev_stack_rdev_limits(mddev, &lim, 0);
 	rdev_for_each(rdev, mddev)
 		queue_limits_stack_bdev(&lim, rdev->bdev, rdev->new_data_offset,
-- 
2.46.1


