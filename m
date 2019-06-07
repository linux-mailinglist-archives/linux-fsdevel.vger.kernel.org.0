Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69D38B42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfFGNLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53156 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfFGNLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913076; x=1591449076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QliUIFG/v+yws6IlsTxN0SCd2dbN9LJ1vfQ0z2PLAQM=;
  b=Gh/nOvaIFzPE6BJ1ojN8heS8VHgSOonqlOptDcDMKU2p5/lyh8sgaK9i
   H7WFZmTEVFwkvAV9wfdEZGe4gaUf6g7UyUcKEFA7NZjNdvq/WZvMaaaUB
   Qo05wlX00bo6lY/13DdJ+U1H0T3Xvv8gkSRnmkh51/Np3gzrvQgEjkoWi
   /zEXCW2AZ/Vy3oGZs9ESzEP9FMBlU5mcH0TWxRL1m4TwuhFlJVdirgHeI
   tpg3NbXWuLdKSnRIGhWZuLJZWiWUph7d0BbYE9JdxQDP1xC1B7qJt479T
   35xEG5S8woyVUG7iiqLIsG8Wi1Hz/0/gzShQMAdmJoDE5DtWyGZ7/WJXu
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027768"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:16 +0800
IronPort-SDR: k5fYwwych66gL/sICCyt5O0lOfVooOie5jO5cwT7PlS4ocPmHbDmJUYWZW2YGhgTUskLw/nk7T
 qG0SdrKOiIW6ekumUuIfdvh+J3q7BmN5MyrOr6V5nmUE5sf7rANGOFZkXvAP/Q1K/T8CiqpsMk
 ZHG56+6+w+miAZI5wyO3X/hjw/4hP8FTqkCcg7BOv3wnfBatLQpyQpmQB798WS1TNIzMLnLCwZ
 lF91FTNNSEksioW/r3z6FRaIgdjB+9NSWABIk+lSKf1XmPDJnIxVHgPU6oe+Jz4lX6vzWGOrKY
 dbKglBUSqwGUuWLjkBOIh2Qy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:33 -0700
IronPort-SDR: YkFT809UwetK/2akVNMwPFNQIpJ6hZvBTC0wGTL01WPT+RQYhcV5Hm1VGCh3iOWlHmdcrP9eD5
 iubinUFsceC9F+3nV3qKcDv/+UlH8RoIxErJJb86fTQNluDkVPkEymxKN+qBFvYLV5+F5awtbj
 a4D0qhChRAHJk/AxFjLMOsjRvHgK6RxvHNZo8gXR3RvwMI9LA0bRFkY+0lbht2TUbCOdDS70wj
 JJLPDDX1LXraYXBnqhTn4vffuOSJ+IZP+9s58k+f2TC9nWEgUQQb8/cWwZDtXzf2X1m0PsV0TD
 6XU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Date:   Fri,  7 Jun 2019 22:10:08 +0900
Message-Id: <20190607131025.31996-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a zoned block device is found, get its zone information (number of zones
and zone size) using the new helper function btrfs_get_dev_zonetypes().  To
avoid costly run-time zone report commands to test the device zones type
during block allocation, attach the seqzones bitmap to the device structure
to indicate if a zone is sequential or accept random writes.

This patch also introduces the helper function btrfs_dev_is_sequential() to
test if the zone storing a block is a sequential write required zone.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 143 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  33 +++++++++++
 2 files changed, 176 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c2a6e4b39da..b673178718e3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -786,6 +786,135 @@ static int btrfs_free_stale_devices(const char *path,
 	return ret;
 }
 
+static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
+				 struct blk_zone **zones,
+				 unsigned int *nr_zones, gfp_t gfp_mask)
+{
+	struct blk_zone *z = *zones;
+	int ret;
+
+	if (!z) {
+		z = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
+		if (!z)
+			return -ENOMEM;
+	}
+
+	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT,
+				  z, nr_zones, gfp_mask);
+	if (ret != 0) {
+		btrfs_err(device->fs_info, "Get zone at %llu failed %d\n",
+			  pos, ret);
+		return ret;
+	}
+
+	*zones = z;
+
+	return 0;
+}
+
+static void btrfs_destroy_dev_zonetypes(struct btrfs_device *device)
+{
+	kfree(device->seq_zones);
+	kfree(device->empty_zones);
+	device->seq_zones = NULL;
+	device->empty_zones = NULL;
+	device->nr_zones = 0;
+	device->zone_size = 0;
+	device->zone_size_shift = 0;
+}
+
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask)
+{
+	unsigned int nr_zones = 1;
+	int ret;
+
+	ret = __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
+	if (ret != 0 || !nr_zones)
+		return ret ? ret : -EIO;
+
+	return 0;
+}
+
+int btrfs_get_dev_zonetypes(struct btrfs_device *device)
+{
+	struct block_device *bdev = device->bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t sector = 0;
+	struct blk_zone *zones = NULL;
+	unsigned int i, n = 0, nr_zones;
+	int ret;
+
+	device->zone_size = 0;
+	device->zone_size_shift = 0;
+	device->nr_zones = 0;
+	device->seq_zones = NULL;
+	device->empty_zones = NULL;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	device->zone_size = (u64)bdev_zone_sectors(bdev) << SECTOR_SHIFT;
+	device->zone_size_shift = ilog2(device->zone_size);
+	device->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
+	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
+		device->nr_zones++;
+
+	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
+				    sizeof(*device->seq_zones), GFP_KERNEL);
+	if (!device->seq_zones)
+		return -ENOMEM;
+
+	device->empty_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
+				      sizeof(*device->empty_zones), GFP_KERNEL);
+	if (!device->empty_zones)
+		return -ENOMEM;
+
+#define BTRFS_REPORT_NR_ZONES   4096
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = __btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
+					    &zones, &nr_zones, GFP_KERNEL);
+		if (ret != 0 || !nr_zones) {
+			if (!ret)
+				ret = -EIO;
+			goto out;
+		}
+
+		for (i = 0; i < nr_zones; i++) {
+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
+				set_bit(n, device->seq_zones);
+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
+				set_bit(n, device->empty_zones);
+			sector = zones[i].start + zones[i].len;
+			n++;
+		}
+	}
+
+	if (n != device->nr_zones) {
+		btrfs_err(device->fs_info,
+			  "Inconsistent number of zones (%u / %u)\n", n,
+			  device->nr_zones);
+		ret = -EIO;
+		goto out;
+	}
+
+	btrfs_info(device->fs_info,
+		   "host-%s zoned block device, %u zones of %llu sectors\n",
+		   bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+		   device->nr_zones, device->zone_size >> SECTOR_SHIFT);
+
+out:
+	kfree(zones);
+
+	if (ret)
+		btrfs_destroy_dev_zonetypes(device);
+
+	return ret;
+}
+
 static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, fmode_t flags,
 			void *holder)
@@ -842,6 +971,11 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zonetypes(device);
+	if (ret != 0)
+		goto error_brelse;
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1243,6 +1377,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 	}
 
 	blkdev_put(device->bdev, device->mode);
+	btrfs_destroy_dev_zonetypes(device);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -2664,6 +2799,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
+	/* Get zone type information of zoned block devices */
+	ret = btrfs_get_dev_zonetypes(device);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto error_sysfs;
+	}
+
 	if (seeding_dev) {
 		mutex_lock(&fs_info->chunk_mutex);
 		ret = init_first_rw_device(trans);
@@ -2729,6 +2871,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
+	btrfs_destroy_dev_zonetypes(device);
 	btrfs_sysfs_rm_device_link(fs_devices, device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b8a0e8d0672d..1599641e216c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -62,6 +62,16 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	/*
+	 * Number of zones, zone size and types of zones if bdev is a
+	 * zoned block device.
+	 */
+	u64 zone_size;
+	u8  zone_size_shift;
+	u32 nr_zones;
+	unsigned long *seq_zones;
+	unsigned long *empty_zones;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
@@ -476,6 +486,28 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 				       u64 logical, u64 length);
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask);
+
+static inline int btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	unsigned int zno = pos >> device->zone_size_shift;
+
+	if (!device->seq_zones)
+		return 1;
+
+	return test_bit(zno, device->seq_zones);
+}
+
+static inline int btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	unsigned int zno = pos >> device->zone_size_shift;
+
+	if (!device->empty_zones)
+		return 0;
+
+	return test_bit(zno, device->empty_zones);
+}
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
@@ -568,5 +600,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 
 int btrfs_bg_type_to_factor(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_get_dev_zonetypes(struct btrfs_device *device);
 
 #endif
-- 
2.21.0

