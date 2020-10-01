Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1A2806C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgJASiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24694 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgJASiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577486; x=1633113486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMuHH6RI/+F0H8vO8jzqBgtlIttUzV9YrJ752d/15AA=;
  b=O+oQMatPG2DVTxzRX3dcxMAY21Jxmf5AUf+Vry+xPrgJIXHWGQSwVtxC
   X9VPoLuAgTefUFMU+ogaZwfkr4BqmoA33Vm2g8/ZEHwxQd803lB2ZD4Wy
   X5VSREl7ND6hxOnVMttqjDTzY+7oEe7aBaxWpOL0CBgiAmequdKW4v0+Q
   VIRYOe5Ot4GlkgsIYMS8cOe1pYSC/9Z3gH6WXUet58P/qHbbBqN7uXecq
   4DjcC6AViJjLYsS+1iAEniFUa7+yBF24tR2MLcDF7AgSmbG791JhnCf1B
   4XNNOLSUeXI6PVerQzTv6D+o95T+uBJ+CqkjMOF7USkBXnZge7cWAMyfY
   g==;
IronPort-SDR: lwPYyPTARD+geqpjrUIiNb8yzzHITng6L9/5eZfKx69iTmvQtsI0t1FvpIRDkXkrIaqHfP5ElI
 ENcG0CLglekJvfnPcyuQa2D0iTeLdndlQuKqB4dFPh+DyYLbAv5UMkHkQa7LcNtWwyzRyD8UZb
 U82UErAXX9gzzSb91iH5iAJD7aqgVjncgg7ifarY6hJ9rJgWP5BUc5VXSrQ1e9jyhYPKePJQ7f
 aNEe3ho/Sj4MLr+b8QNzh+cDmQnu3+XQFdfSIwavem+en8wLV8lhExPa2K6oH277dio9xdsErL
 jjE=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036773"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:05 +0800
IronPort-SDR: PHbAU0W3CWfEqpbQLCFTcsOTG6deFVSSIlmNCyUlV1vWGKexTox31r4C0Zz+n2Xunp+xJYMJ3d
 HsIWemKTMndA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:02 -0700
IronPort-SDR: lhMMbaBgpAvAavCjR+c9IueLD07m+H0cy+S+KBXncglhz9Xz1wp/N2oMpVKhHWbeo68U47NxAT
 HP0/QUluePoA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v8 04/41] btrfs: Check and enable ZONED mode
Date:   Fri,  2 Oct 2020 03:36:11 +0900
Message-Id: <c6d9f70f9b9264497aa630d6c95d8d387b012d57.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces the function btrfs_check_zoned_mode() to check if
ZONED flag is enabled on the file system and if the file system consists of
zoned devices with equal zone size.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/dev-replace.c |  7 ++++
 fs/btrfs/disk-io.c     |  9 +++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/volumes.c     |  5 +++
 fs/btrfs/zoned.c       | 78 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       | 26 ++++++++++++++
 7 files changed, 129 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f4e35b..1a51aeb15574 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -588,6 +588,9 @@ struct btrfs_fs_info {
 	struct btrfs_root *free_space_root;
 	struct btrfs_root *data_reloc_root;
 
+	/* Zone size when in ZONED mode */
+	u64 zone_size;
+
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6f6d77224c2b..5e3554482af1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -238,6 +238,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(bdev);
 	}
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		btrfs_err(fs_info,
+			  "zone type of target device mismatch with the filesystem!");
+		ret = -EINVAL;
+		goto error;
+	}
+
 	sync_blockdev(bdev);
 
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..acf374b6e1ab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -42,6 +42,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -3130,7 +3131,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
+	ret = btrfs_check_zoned_mode(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init ZONED mode: %d",
+				ret);
+		goto fail_block_groups;
+	}
+
 	ret = btrfs_sysfs_add_fsid(fs_devices);
+
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
 				ret);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..1b2399c9c94e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -44,6 +44,7 @@
 #include "backref.h"
 #include "space-info.h"
 #include "sysfs.h"
+#include "zoned.h"
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b0a7a820222e..dc21cb8cdea9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2517,6 +2517,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
+	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = 1;
 		down_write(&sb->s_umount);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0c908f0e9469..7509888b457a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -177,3 +177,81 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 
 	return 0;
 }
+
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 hmzoned_devices = 0;
+	u64 nr_devices = 0;
+	u64 zone_size = 0;
+	int incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
+	int ret = 0;
+
+	/* Count zoned devices */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		enum blk_zoned_model model;
+
+		if (!device->bdev)
+			continue;
+
+		model = bdev_zoned_model(device->bdev);
+		if (model == BLK_ZONED_HM ||
+		    (model == BLK_ZONED_HA && incompat_zoned)) {
+			hmzoned_devices++;
+			if (!zone_size) {
+				zone_size = device->zone_info->zone_size;
+			} else if (device->zone_info->zone_size != zone_size) {
+				btrfs_err(fs_info,
+					  "Zoned block devices must have equal zone sizes");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		nr_devices++;
+	}
+
+	if (!hmzoned_devices && !incompat_zoned)
+		goto out;
+
+	if (!hmzoned_devices && incompat_zoned) {
+		/* No zoned block device found on ZONED FS */
+		btrfs_err(fs_info,
+			  "ZONED enabled file system should have zoned devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (hmzoned_devices && !incompat_zoned) {
+		btrfs_err(fs_info,
+			  "Enable ZONED mode to mount HMZONED device");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (hmzoned_devices != nr_devices) {
+		btrfs_err(fs_info,
+			  "zoned devices cannot be mixed with regular devices");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
+	 * __btrfs_alloc_chunk(). Since we want stripe_len == zone_size,
+	 * check the alignment here.
+	 */
+	if (!IS_ALIGNED(zone_size, BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info,
+			  "zone size is not aligned to BTRFS_STRIPE_LEN");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fs_info->zone_size = zone_size;
+
+	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
+		   fs_info->zone_size);
+out:
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e4a08ae0a96b..4341630cb756 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -9,6 +9,8 @@
 #ifndef BTRFS_ZONED_H
 #define BTRFS_ZONED_H
 
+#include <linux/blkdev.h>
+
 struct btrfs_zoned_device_info {
 	/*
 	 * Number of zones, zone size and types of zones if bdev is a
@@ -26,6 +28,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
 int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -37,6 +40,14 @@ static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	return 0;
 }
 static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+static inline int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	btrfs_err(fs_info, "Zoned block devices support is not enabled");
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -89,4 +100,19 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
+static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
+						struct block_device *bdev)
+{
+	u64 zone_size;
+
+	if (btrfs_fs_incompat(fs_info, ZONED)) {
+		zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
+		/* Do not allow non-zoned device */
+		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
+	}
+
+	/* Do not allow Host Manged zoned device */
+	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
+}
+
 #endif
-- 
2.27.0

