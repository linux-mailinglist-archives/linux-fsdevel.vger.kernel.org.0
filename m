Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F97266784
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgIKRoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgIKMfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827725; x=1631363725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxo9Odb/qo2j/4umy3Y6zUiJfT8+7IC+FNN0J9tCzSQ=;
  b=dv9F348t7+80FiXK7d0WojklPF6QubWeQpWkkrGt9q1oJ49CXjYOcC5B
   m5iMPlgc6KAtAd8G5fTa0de9/6dFGmkwSZi1UnNBpHZvcZZN1by/xm6Ou
   hNTR5+jtjeUdKcXfMPRoGmMy+uARfnm9voItHDEpTafie++Mji7gSx12X
   3QzdyDIeio3OZ3bJVmBAXBFdawZbeBE8iFEMrzjU2KHUOH4aeeJNsn42Z
   nr3CHrgfczAGI1zJhLmjZ7eFfszpOoN8SVRvzIkEvMM8pN1Cp5ltfahAw
   0pUWm880oV+UR2YYUGQKkKsPikup4Me4m+53YH7kZ1K3M/ZFkI4/Kadaw
   Q==;
IronPort-SDR: 3QCmPIGcy/4HHUYOTw9mRujX4Iw32TrkQlM+VS7M1OZjXMLD/ysk9hkJplJQM4QGtDerAO8fHU
 1finCXwQ/3/gEArlsdoFOimKESyUQR+3vvVQcv9aH6+uIm7DCkxfEsmBcZuhPwUR9tdtL4NnmO
 LIl6delrMJu+RuntjgMvtpyJPjn9gGVgFAlhD2BNfokgTMr0UsH9uAh9vPjgTpyS69/mpN/ZMj
 PkS36zwaTqncESop8m80K85El5nBbJdi1qf1YZCANMrXw9KWwwZ8xh+EIKX8GmOWBdI9Bu0XPV
 sd4=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:24 +0800
IronPort-SDR: JOYBCJRtUntso7F/kdGo2zZ14Rv6bunqD8WRh+zx/Vp2waVBSYBzk3R9iWgEdEyidApaLIvYsP
 ORPSoVcFGsOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:45 -0700
IronPort-SDR: YwdEAHJiIrA3eApNGK0xmBgPlTT+/i6GAByvb7xr2QBlH351aI/tYkheBpHW2uzc6YyJ7u/4P4
 /K8DfDskuUcA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 11/39] btrfs: implement zoned chunk allocator
Date:   Fri, 11 Sep 2020 21:32:31 +0900
Message-Id: <20200911123259.3782926-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit implements zoned chunk/dev_extent allocator. The zoned
allocator align the device extents to zone boundaries so that a zone
reset affects only the device extent and does not change the state of
blocks in the neighbor device extents.

Also, it checks that a region allocation is not over any locations of
super block zones, and ensures the region is empty.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 133 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |   1 +
 fs/btrfs/zoned.c   | 128 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h   |  30 ++++++++++
 4 files changed, 292 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 22384c803ead..8c439d1ae4c5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1407,6 +1407,14 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
+static inline u64 dev_extent_search_start_zoned(struct btrfs_device *device,
+						u64 start)
+{
+	start = max_t(u64, start,
+		      max_t(u64, device->zone_info->zone_size, SZ_1M));
+	return btrfs_zone_align(device, start);
+}
+
 static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
@@ -1417,11 +1425,57 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * make sure to start at an offset of at least 1MB.
 		 */
 		return max_t(u64, start, SZ_1M);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return dev_extent_search_start_zoned(device, start);
 	default:
 		BUG();
 	}
 }
 
+static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
+					u64 *hole_start, u64 *hole_size,
+					u64 num_bytes)
+{
+	u64 zone_size = device->zone_info->zone_size;
+	u64 pos;
+	int ret;
+	int changed = 0;
+
+	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+
+	while (*hole_size > 0) {
+		pos = btrfs_find_allocatable_zones(device, *hole_start,
+						   *hole_start + *hole_size,
+						   num_bytes);
+		if (pos != *hole_start) {
+			*hole_size = *hole_start + *hole_size - pos;
+			*hole_start = pos;
+			changed = 1;
+			if (*hole_size < num_bytes)
+				break;
+		}
+
+		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
+
+		/* range is ensured to be empty */
+		if (!ret)
+			return changed;
+
+		/* given hole range was invalid (outside of device) */
+		if (ret == -ERANGE) {
+			*hole_start += *hole_size;
+			*hole_size = 0;
+			return 1;
+		}
+
+		*hole_start += zone_size;
+		*hole_size -= zone_size;
+		changed = 1;
+	}
+
+	return changed;
+}
+
 /**
  * dev_extent_hole_check - check if specified hole is suitable for allocation
  * @device:	the device which we have the hole
@@ -1454,6 +1508,10 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		/* No extra check */
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		changed |= dev_extent_hole_check_zoned(device, hole_start,
+						       hole_size, num_bytes);
+		break;
 	default:
 		BUG();
 	}
@@ -1508,6 +1566,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 
 	search_start = dev_extent_search_start(device, search_start);
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -4912,6 +4973,39 @@ static void init_alloc_chunk_ctl_policy_regular(
 	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
+static void
+init_alloc_chunk_ctl_policy_zoned(struct btrfs_fs_devices *fs_devices,
+				  struct alloc_chunk_ctl *ctl)
+{
+	u64 zone_size = fs_devices->fs_info->zone_size;
+	u64 limit;
+	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
+	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
+	u64 min_chunk_size = min_data_stripes * zone_size;
+	u64 type = ctl->type;
+
+	ctl->max_stripe_size = zone_size;
+	if (type & BTRFS_BLOCK_GROUP_DATA) {
+		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
+						 zone_size);
+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+		ctl->max_chunk_size = ctl->max_stripe_size;
+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
+		ctl->devs_max = min_t(int, ctl->devs_max,
+				      BTRFS_MAX_DEVS_SYS_CHUNK);
+	} else {
+		BUG();
+	}
+
+	/* We don't want a chunk larger than 10% of writable space */
+	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
+			       zone_size),
+		    min_chunk_size);
+	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
+	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
+}
+
 static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 				 struct alloc_chunk_ctl *ctl)
 {
@@ -4932,6 +5026,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
 		break;
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
+		break;
 	default:
 		BUG();
 	}
@@ -5058,6 +5155,40 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 	return 0;
 }
 
+static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
+				    struct btrfs_device_info *devices_info)
+{
+	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
+	int data_stripes;	/* number of stripes that count for
+				   block group size */
+
+	/*
+	 * It should hold because:
+	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
+	 */
+	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
+
+	ctl->stripe_size = zone_size;
+	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+
+	/*
+	 * stripe_size is fixed in ZONED. Reduce ndevs instead.
+	 */
+	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
+		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
+					     ctl->stripe_size) + ctl->nparity,
+				     ctl->dev_stripes);
+		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
+		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
+		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
+	}
+
+	ctl->chunk_size = ctl->stripe_size * data_stripes;
+
+	return 0;
+}
+
 static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 			      struct alloc_chunk_ctl *ctl,
 			      struct btrfs_device_info *devices_info)
@@ -5085,6 +5216,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	switch (fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		return decide_stripe_size_regular(ctl, devices_info);
+	case BTRFS_CHUNK_ALLOC_ZONED:
+		return decide_stripe_size_zoned(ctl, devices_info);
 	default:
 		BUG();
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7ae1a02c6d2..88b1d59fbc12 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
+	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
 struct btrfs_fs_devices {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6912b66f3130..916d358dea27 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -6,12 +6,16 @@
  *	Damien Le Moal	<damien.lemoal@wdc.com>
  */
 
+#include "asm-generic/bitops/find.h"
+#include "linux/blk_types.h"
+#include "linux/kernel.h"
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "zoned.h"
 #include "rcu-string.h"
+#include "disk-io.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -324,6 +328,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 
 	btrfs_info(fs_info, "ZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
@@ -618,3 +623,126 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 				sb_zone << zone_sectors_shift, zone_sectors * 2,
 				GFP_NOFS);
 }
+
+/*
+ * btrfs_check_allocatable_zones - find allocatable zones within give region
+ * @device:	the device to allocate a region
+ * @hole_start: the position of the hole to allocate the region
+ * @num_bytes:	the size of wanted region
+ * @hole_size:	the size of hole
+ *
+ * Allocatable region should not contain any superblock locations.
+ */
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u8 shift = zinfo->zone_size_shift;
+	u64 nzones = num_bytes >> shift;
+	u64 pos = hole_start;
+	u64 begin, end;
+	u64 sb_pos;
+	bool have_sb;
+	int i;
+
+	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+
+	while (pos < hole_end) {
+		begin = pos >> shift;
+		end = begin + nzones;
+
+		if (end > zinfo->nr_zones)
+			return hole_end;
+
+		/* check if zones in the region are all empty */
+		if (btrfs_dev_is_sequential(device, pos) &&
+		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
+			pos += zinfo->zone_size;
+			continue;
+		}
+
+		have_sb = false;
+		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+			sb_pos = sb_zone_number(zinfo->zone_size, i);
+			if (!(end < sb_pos || sb_pos + 1 < begin)) {
+				have_sb = true;
+				pos = (sb_pos + 2) << shift;
+				break;
+			}
+		}
+		if (!have_sb)
+			break;
+	}
+
+	return pos;
+}
+
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes)
+{
+	int ret;
+
+	*bytes = 0;
+	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
+			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
+			       GFP_NOFS);
+	if (ret)
+		return ret;
+
+	*bytes = length;
+	while (length) {
+		btrfs_dev_set_zone_empty(device, physical);
+		physical += device->zone_info->zone_size;
+		length -= device->zone_info->zone_size;
+	}
+
+	return 0;
+}
+
+int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u8 shift = zinfo->zone_size_shift;
+	unsigned long begin = start >> shift;
+	unsigned long end = (start + size) >> shift;
+	u64 pos;
+	int ret;
+
+	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
+	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
+
+	if (end > zinfo->nr_zones)
+		return -ERANGE;
+
+	/* all the zones are conventional */
+	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
+		return 0;
+
+	/* all the zones are sequential and empty */
+	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
+	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
+		return 0;
+
+	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
+		u64 reset_bytes;
+
+		if (!btrfs_dev_is_sequential(device, pos) ||
+		    btrfs_dev_is_empty_zone(device, pos))
+			continue;
+
+		/* free regions should be empty */
+		btrfs_warn_in_rcu(
+			device->fs_info,
+			"resetting device %s zone %llu for allocation",
+			rcu_str_deref(device->name), pos >> shift);
+		WARN_ON_ONCE(1);
+
+		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
+					      &reset_bytes);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index e33c0e409b7d..0be58861d922 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -40,6 +40,11 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 			  u64 *bytenr_ret);
 int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
+u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
+				 u64 hole_end, u64 num_bytes);
+int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
+			    u64 length, u64 *bytes);
+int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -85,6 +90,23 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
 {
 	return 0;
 }
+static inline u64 btrfs_find_allocatable_zones(struct btrfs_device *device,
+					       u64 hole_start, u64 hole_end,
+					       u64 num_bytes)
+{
+	return hole_start;
+}
+static inline int btrfs_reset_device_zone(struct btrfs_device *device,
+					  u64 physical, u64 length, u64 *bytes)
+{
+	*bytes = 0;
+	return 0;
+}
+static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
+					   u64 start, u64 size)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -163,4 +185,12 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device,
 	       !btrfs_dev_is_sequential(device, pos);
 }
 
+static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
+{
+	if (!device->zone_info)
+		return pos;
+
+	return ALIGN(pos, device->zone_info->zone_size);
+}
+
 #endif
-- 
2.27.0

