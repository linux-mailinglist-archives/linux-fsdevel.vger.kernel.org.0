Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA02266799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIKRpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:45:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgIKMd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827639; x=1631363639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1PL/k295pCRz+zaD9m9g4LmgnY9w/wyaaJRUqvK14PA=;
  b=Lj9RJEfLjEeFXzfKZHctl5LGwpZVHtPXIA+BDXB0NEI1B+U/nhnhT8eZ
   CIFDrXglgGb9Ul1g99xJqHKYJAB8zcvFt+dTsEyxbajc3zZ0oqLLetqr2
   gBAwzOwPFEoJ06cRzOpX7OTG+MiqynhHdIpDfEFwyPwjG1TwvUBQJCZBj
   Gs+eKVWeUthPIMNQzQ+kQzAMC4/y8RhFixbl+3LiyrTfsG3k7pvbBq+da
   IHhKhnfosdu1ZLGaBpRZ4USMldSSRWt88gF7Huv8H/UEIZVmqo7B6mUUi
   GiVtqNNpwJSluAz0sx34PlIu7GaGwwI7J9e0lkGKer0vmzjG6hkExP2aE
   w==;
IronPort-SDR: 7IY9yytVa5dhUEv3KJph2itrpkW4Bj+lt7FwawPtbuxG7vKsUygmRcRV9WxdrXsNm8kQHWNih9
 eeiBV8NmQAQtY1dtFgL1LFxgFkH08SufvARmnlMU0KM4IWi01g2QbHAMYT/RtDfDAipIIAdOwm
 KpZHGcPShJsws3xoX55SRUHm/HcWW1JFl8ohuLguqwkHxsf4lHT+rcbnpsCl/Cm9eskKlxpz9g
 V910WGBmiG0z5EnbevJ69Sq7ypOzxSKvT7fggfWImb7jIoP630cKs5UTWllDGNYpkzbJs99370
 y1Q=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125957"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:14 +0800
IronPort-SDR: 3Jml6WinPMT4WGe06eem72DPz/Eo5vtCpxcSPf70jCU46JmTLyWjlGfZZA5Uo1SlW7DCPd7mRT
 7y+nFxnqGKWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:34 -0700
IronPort-SDR: OX0FofCBQ4BJc9ydSdHdA/0WhdmOShNi3N+3Lf8b2jnImC7c9wJOSrabyeDAateHs5iL2mP4Y5
 0fCTJFutOGfQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 04/39] btrfs: introduce max_zone_append_size
Date:   Fri, 11 Sep 2020 21:32:24 +0900
Message-Id: <20200911123259.3782926-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index f5ed8f5519dd..54c22ad0d633 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -582,6 +582,8 @@ struct btrfs_fs_info {
 
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

