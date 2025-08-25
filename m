Return-Path: <linux-fsdevel+bounces-58974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58656B33969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD3D3B811D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B022D3237;
	Mon, 25 Aug 2025 08:33:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C429E117;
	Mon, 25 Aug 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110829; cv=none; b=e0+bgwWVpePDXtzEV6uOBMOEqAfSIO0uQCVJ8kVzFsZk/z8CZJTVm3FK08Gh1X8oVEQlCfvTAHpYqO903b9BjGtYztpinhdgG8Ml+6O69drjSt7/0UQ1xkz9m0nUIsAwEjHNjvWKulYsNo5knWHYiI+TlSrHpeCsfIO8/Ps8eyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110829; c=relaxed/simple;
	bh=0iEqQPLLAmWNrPQn1UdxO/H2XVGiOFiEsuuW52MpOdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piJmhvQZxvGmJl04vBsaHdr850stohImHf2RJ2bLEDzzhcVPCzT0w3LZjqnRYSj0qX5rjXaBp5cSaBPXi1jzWiogjdX2dpEtYPYfFuI3sBJjYgsvJFnuipXpkhdCBPLS+TWGAZqbKLwijNrEUG9D9Nt/71FNq2Rz4kjx4pF0BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9PG03RxmzKHNk4;
	Mon, 25 Aug 2025 16:33:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 140EC1A0C3D;
	Mon, 25 Aug 2025 16:33:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAncIzcH6xoZc7rAA--.43322S5;
	Mon, 25 Aug 2025 16:33:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	martin.petersen@oracle.com,
	axboe@kernel.dk,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
Date: Mon, 25 Aug 2025 16:33:19 +0800
Message-ID: <20250825083320.797165-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIzcH6xoZc7rAA--.43322S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWUXw1rJryrXw4rXw48Crg_yoWrGr48p3
	y7XFySvryUJayxAaykJ347uF4Fq345KrW2kFy3Zws5uFy7ur9xXF4Sqa98XrsrXw15Ja43
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

Fix this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
zero.

Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
Reported-by: John Garry <john.g.garry@oracle.com>
Closes: https://lore.kernel.org/linux-block/803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
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
index 408c26398321..35c6498b4917 100644
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


