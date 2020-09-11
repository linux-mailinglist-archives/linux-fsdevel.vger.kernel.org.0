Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1025426678F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIKRow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38375 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgIKMeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827639; x=1631363639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HD+BgJLJ5iYEE3GK9sh/eKr8LmZtJRAzTb+fU7X+CHg=;
  b=PF4/gKjo3pRsN0nyi/6azBSilrZ+945HhqAnZ0gj3WPhM5k2CT+MVP/K
   9gYsCqNMSxPaQwSSKIlQq573tZbSJJWOPyyDO1oHBL8+wZimyGuHCqMDf
   k93OGkuJk0vGuJRbStKgVBmG11sas3gjIHEhEKvMqbSm8LCPdUd8MME8R
   P+qtEamatxxYSGa6VpxK2uUGS+B4LbTfeiv9JOzrHWdZLT0dYMFrlFL1H
   BMxvK2b66iU4TAaRc5ZbMcC6eAWZX8NUIVMJQpG0mPGHv7PVxFkH5DZWZ
   UXv1D2IvPjUC4I2YIjBQxoeyivzX5H7qiOhbRIyiVt0GtWXHvCJd6R31R
   g==;
IronPort-SDR: PS7cKqnw0ZgLmr1V1ZHgLif25ssSv1GEpLAzJrxRfyB7houP7zvVdazQwYGX0WYqWOGVG0Kjk5
 HOw2rBL7NekAJByLjud0vnwJ2fbMBAR0nkw92geUtWDu/TrGDj8prgo69Mb7VCEzzdJ5X6D7RK
 idmzu5+R7H4HffyzHYAT1Gy8s5cfoZgYTMhZSZntUpTKu5w8y/sP50bdhAy79V2S5hoXGs8N2s
 StQIfAFLgiN1fgivIUIwvJFczwKx0CiDBTP7vG+pnsXgFlUaukHBL14HnrZ9/9zTcL60vK4zef
 M20=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125951"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:11 +0800
IronPort-SDR: P3VUD/I9xG1aRB4aEZyzk5sQsFMWkbD5BRKS8iClLHxcaFGx2kp+kbWH4GO1Tl6MFM/SxdtgX9
 xBd1Mi0wwgZw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:31 -0700
IronPort-SDR: v/dNXFXSFxhyjKmd0X4wvKXhOtuNxyMzlN327FLzqrZbiJhpMfBlB5cldUTl7BizaaXCl7DnuD
 PMifqPo5UR0Q==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v7 02/39] btrfs: Get zone information of zoned block devices
Date:   Fri, 11 Sep 2020 21:32:22 +0900
Message-Id: <20200911123259.3782926-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a zoned block device is found, get its zone information (number of zones
and zone size) using the new helper function btrfs_get_dev_zone_info().  To
avoid costly run-time zone report commands to test the device zones type
during block allocation, attach the seq_zones bitmap to the device
structure to indicate if a zone is sequential or accept random writes. Also
it attaches the empty_zones bitmap to indicate if a zone is empty or not.

This patch also introduces the helper function btrfs_dev_is_sequential() to
test if the zone storing a block is a sequential write required zone and
btrfs_dev_is_empty_zone() to test if the zone is a empty zone.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/Makefile      |   1 +
 fs/btrfs/dev-replace.c |   5 ++
 fs/btrfs/volumes.c     |  18 ++++-
 fs/btrfs/volumes.h     |   4 +
 fs/btrfs/zoned.c       | 179 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  92 +++++++++++++++++++++
 6 files changed, 297 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/zoned.c
 create mode 100644 fs/btrfs/zoned.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index e738f6206ea5..0497fdc37f90 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -16,6 +16,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
+btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..83ee7371136c 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -21,6 +21,7 @@
 #include "rcu-string.h"
 #include "dev-replace.h"
 #include "sysfs.h"
+#include "zoned.h"
 
 /*
  * Device replace overview
@@ -297,6 +298,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error;
+
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	fs_info->fs_devices->num_devices++;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 214856c4ccb1..ce612cb900cd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -30,6 +30,7 @@
 #include "space-info.h"
 #include "block-group.h"
 #include "discard.h"
+#include "zoned.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
@@ -372,6 +373,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	bio_put(device->flush_bio);
+	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
 
@@ -666,6 +668,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret != 0)
+		goto error_free_page;
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -2553,6 +2560,14 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 	rcu_assign_pointer(device->name, name);
 
+	device->fs_info = fs_info;
+	device->bdev = bdev;
+
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error_free_device;
+
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -2569,8 +2584,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 					 fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
-	device->fs_info = fs_info;
-	device->bdev = bdev;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->mode = FMODE_EXCL;
@@ -2713,6 +2726,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		sb->s_flags |= SB_RDONLY;
 	if (trans)
 		btrfs_end_transaction(trans);
+	btrfs_destroy_dev_zone_info(device);
 error_free_device:
 	btrfs_free_device(device);
 error:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5eea93916fbf..a7ae1a02c6d2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -51,6 +51,8 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 
+struct btrfs_zoned_device_info;
+
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
 	struct list_head dev_alloc_list; /* chunk mutex */
@@ -64,6 +66,8 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	struct btrfs_zoned_device_info *zone_info;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
new file mode 100644
index 000000000000..0c908f0e9469
--- /dev/null
+++ b/fs/btrfs/zoned.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *	Naohiro Aota	<naohiro.aota@wdc.com>
+ *	Damien Le Moal	<damien.lemoal@wdc.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "zoned.h"
+#include "rcu-string.h"
+
+/* Maximum number of zones to report per blkdev_report_zones() call */
+#define BTRFS_REPORT_NR_ZONES   4096
+
+static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
+			     void *data)
+{
+	struct blk_zone *zones = data;
+
+	memcpy(&zones[idx], zone, sizeof(*zone));
+
+	return 0;
+}
+
+static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
+			       struct blk_zone *zones, unsigned int *nr_zones)
+{
+	int ret;
+
+	if (!*nr_zones)
+		return 0;
+
+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
+				  copy_zone_info_cb, zones);
+	if (ret < 0) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "get zone at %llu on %s failed %d", pos,
+				 rcu_str_deref(device->name), ret);
+		return ret;
+	}
+	*nr_zones = ret;
+	if (!ret)
+		return -EIO;
+
+	return 0;
+}
+
+int btrfs_get_dev_zone_info(struct btrfs_device *device)
+{
+	struct btrfs_zoned_device_info *zone_info = NULL;
+	struct block_device *bdev = device->bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t sector = 0;
+	struct blk_zone *zones = NULL;
+	unsigned int i, nreported = 0, nr_zones;
+	unsigned int zone_sectors;
+	int ret;
+	char devstr[sizeof(device->fs_info->sb->s_id) +
+		    sizeof(" (device )") - 1];
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	zone_info = kzalloc(sizeof(*zone_info), GFP_KERNEL);
+	if (!zone_info)
+		return -ENOMEM;
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	ASSERT(is_power_of_2(zone_sectors));
+	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
+	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
+	zone_info->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
+	if (!IS_ALIGNED(nr_sectors, zone_sectors))
+		zone_info->nr_zones++;
+
+	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->seq_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zone_info->empty_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
+	if (!zone_info->empty_zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	zones = kcalloc(BTRFS_REPORT_NR_ZONES,
+			sizeof(struct blk_zone), GFP_KERNEL);
+	if (!zones) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
+					  &nr_zones);
+		if (ret)
+			goto out;
+
+		for (i = 0; i < nr_zones; i++) {
+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
+				set_bit(nreported, zone_info->seq_zones);
+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
+				set_bit(nreported, zone_info->empty_zones);
+			nreported++;
+		}
+		sector = zones[nr_zones - 1].start + zones[nr_zones - 1].len;
+	}
+
+	if (nreported != zone_info->nr_zones) {
+		btrfs_err_in_rcu(device->fs_info,
+				 "inconsistent number of zones on %s (%u / %u)",
+				 rcu_str_deref(device->name), nreported,
+				 zone_info->nr_zones);
+		ret = -EIO;
+		goto out;
+	}
+
+	kfree(zones);
+
+	device->zone_info = zone_info;
+
+	devstr[0] = 0;
+	if (device->fs_info)
+		snprintf(devstr, sizeof(devstr), " (device %s)",
+			 device->fs_info->sb->s_id);
+
+	rcu_read_lock();
+	pr_info(
+"BTRFS info%s: host-%s zoned block device %s, %u zones of %llu sectors",
+		devstr,
+		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+		rcu_str_deref(device->name), zone_info->nr_zones,
+		zone_info->zone_size >> SECTOR_SHIFT);
+	rcu_read_unlock();
+
+	return 0;
+
+out:
+	kfree(zones);
+	bitmap_free(zone_info->empty_zones);
+	bitmap_free(zone_info->seq_zones);
+	kfree(zone_info);
+
+	return ret;
+}
+
+void btrfs_destroy_dev_zone_info(struct btrfs_device *device)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return;
+
+	bitmap_free(zone_info->seq_zones);
+	bitmap_free(zone_info->empty_zones);
+	kfree(zone_info);
+	device->zone_info = NULL;
+}
+
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone)
+{
+	unsigned int nr_zones = 1;
+	int ret;
+
+	ret = btrfs_get_dev_zones(device, pos, zone, &nr_zones);
+	if (ret != 0 || !nr_zones)
+		return ret ? ret : -EIO;
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
new file mode 100644
index 000000000000..e4a08ae0a96b
--- /dev/null
+++ b/fs/btrfs/zoned.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *	Naohiro Aota	<naohiro.aota@wdc.com>
+ *	Damien Le Moal	<damien.lemoal@wdc.com>
+ */
+
+#ifndef BTRFS_ZONED_H
+#define BTRFS_ZONED_H
+
+struct btrfs_zoned_device_info {
+	/*
+	 * Number of zones, zone size and types of zones if bdev is a
+	 * zoned block device.
+	 */
+	u64 zone_size;
+	u8  zone_size_shift;
+	u32 nr_zones;
+	unsigned long *seq_zones;
+	unsigned long *empty_zones;
+};
+
+#ifdef CONFIG_BLK_DEV_ZONED
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone);
+int btrfs_get_dev_zone_info(struct btrfs_device *device);
+void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+				     struct blk_zone *zone)
+{
+	return 0;
+}
+static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
+{
+	return 0;
+}
+static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *device) { }
+#endif
+
+static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return false;
+
+	return test_bit(pos >> zone_info->zone_size_shift,
+			zone_info->seq_zones);
+}
+
+static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+
+	if (!zone_info)
+		return true;
+
+	return test_bit(pos >> zone_info->zone_size_shift,
+			zone_info->empty_zones);
+}
+
+static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
+						u64 pos, bool set)
+{
+	struct btrfs_zoned_device_info *zone_info = device->zone_info;
+	unsigned int zno;
+
+	if (!zone_info)
+		return;
+
+	zno = pos >> zone_info->zone_size_shift;
+	if (set)
+		set_bit(zno, zone_info->empty_zones);
+	else
+		clear_bit(zno, zone_info->empty_zones);
+}
+
+static inline void btrfs_dev_set_zone_empty(struct btrfs_device *device,
+					    u64 pos)
+{
+	btrfs_dev_set_empty_zone_bit(device, pos, true);
+}
+
+static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device,
+					      u64 pos)
+{
+	btrfs_dev_set_empty_zone_bit(device, pos, false);
+}
+
+#endif
-- 
2.27.0

