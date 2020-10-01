Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37772806CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbgJASiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbgJASiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577490; x=1633113490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/QXdtpTvZbJXk7O9rYpJGqOU3WyM2Yv+BRRT6Mwh9s=;
  b=KHwuxTiJP1lj3BwtCTPrZrQQzKB+Sk6JB0N3Ed+mj2rQ9NUsnmJsyxkJ
   8ad7pp5cJh/T9VTjNDkvXGr0u3upSIW63Gl/UyTNhbNZdc1nzizjCDKqe
   ZKsqbUa85kuFnD4OAzLCWOrAfq9UEngvElXp1Rc472K1ZY6eiJ2vCNodR
   zTnyLLrIGi3Zs0PyPVS9EcC3HXHUq7tafPfjKwmDQk6J6/+m4ZlL6nUvW
   1pPzL7cZiJRIswqBq35x0UGhURKkITppcVSsq1kFNO7+NVg/iesAk5RHu
   8PirI4+wtnVO9Fl5C++8cUq6/9tG3d1QlXB+9ZtfdTZ6Ps4lIgCIA7ZPM
   w==;
IronPort-SDR: 1lf0WrMj35tG7+yoAZ2ABNh9s+AC1ZpQIxb140RCRGIyc6H3imYYW+agETE9WScAtmuCXM1fJn
 mDmhKjoq/8pvGf/zKKgO1IczOfzC49vqaKLooDt7KxTQ83xKmGBY0NLHf8wOKB3JNx5yW2WhGX
 1/S9wr2FEPvV5bRS5Qsmqc/qnPq5wGz8Kh5+zTKvUSPpt9Y3o1xODiEWaUKnZOA0Ak3qXA8C3o
 +SaVjcwQ0yHtnc7pkpfupqU55D81vyWZuTGWPOBlGVOEzmTtXZdDDAatHEGcBqmuBdlS9FynoE
 mtc=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036776"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:06 +0800
IronPort-SDR: hhuFp/KiYG7g2GXsxNVyNCzezntVtsi4CWebSP/PGrO3k7eMQ+9Y89xLKNC3a4cH2PMCN1crhR
 762EFTa4ZTnQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:03 -0700
IronPort-SDR: ZkM+ZoC0XNPOnyAL70rXA+ye24OwYPhtB3tH5qshfmWKcVJrIHlUpw3/303sKShvH3Tc5YcjXC
 rrgyT+hGGBeA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 05/41] btrfs: introduce max_zone_append_size
Date:   Fri,  2 Oct 2020 03:36:12 +0900
Message-Id: <16ed33b15dfb6dd2268cb1fa95a9595cdc23982a.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zone append write command has a maximum IO size restriction it accepts.
Introduce max_zone_append_size to zone_info and fs_into to track the value.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/zoned.c | 17 +++++++++++++++--
 fs/btrfs/zoned.h |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1a51aeb15574..e6f0fe1920e9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -590,6 +590,8 @@ struct btrfs_fs_info {
 
 	/* Zone size when in ZONED mode */
 	u64 zone_size;
+	/* max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7509888b457a..2e12fce81abf 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -53,6 +53,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 {
 	struct btrfs_zoned_device_info *zone_info = NULL;
 	struct block_device *bdev = device->bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t nr_sectors = bdev->bd_part->nr_sects;
 	sector_t sector = 0;
 	struct blk_zone *zones = NULL;
@@ -73,6 +74,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	ASSERT(is_power_of_2(zone_sectors));
 	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
+	zone_info->max_zone_append_size =
+		(u64)queue_max_zone_append_sectors(q) << SECTOR_SHIFT;
 	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
@@ -185,6 +188,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 hmzoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
+	u64 max_zone_append_size = 0;
 	int incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -198,15 +202,23 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		model = bdev_zoned_model(device->bdev);
 		if (model == BLK_ZONED_HM ||
 		    (model == BLK_ZONED_HA && incompat_zoned)) {
+			struct btrfs_zoned_device_info *zone_info =
+				device->zone_info;
+
 			hmzoned_devices++;
 			if (!zone_size) {
-				zone_size = device->zone_info->zone_size;
-			} else if (device->zone_info->zone_size != zone_size) {
+				zone_size = zone_info->zone_size;
+			} else if (zone_info->zone_size != zone_size) {
 				btrfs_err(fs_info,
 					  "Zoned block devices must have equal zone sizes");
 				ret = -EINVAL;
 				goto out;
 			}
+			if (!max_zone_append_size ||
+			    (zone_info->max_zone_append_size &&
+			     zone_info->max_zone_append_size < max_zone_append_size))
+				max_zone_append_size =
+					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
@@ -249,6 +261,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
+	fs_info->max_zone_append_size = max_zone_append_size;
 
 	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4341630cb756..f200b46a71fb 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -18,6 +18,7 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
+	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
-- 
2.27.0

