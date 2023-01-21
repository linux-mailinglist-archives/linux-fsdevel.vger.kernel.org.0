Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2091676498
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjAUGwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjAUGwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8697317D;
        Fri, 20 Jan 2023 22:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PNG/XXiUfHQn+RbJCu1Xgp0CIBe6mxkfQ45JR/TPrbo=; b=ajOjbZUnakfG0wNcXHp0DMR6HA
        nHEKRoykHij0gabP1YZz3i/91EvYZZor6L+SmbsJdzTz/7/gfpD/XtzOKnoBVcYhqTXtGRnwubkCy
        EVquNlwZHg1TkXAAPB+9jCtsn8qeolIM4s8X8Q+aAhsgetxmL8j7z52YLAgnauxdF8yizCwGQDGPV
        bKvaZPMDr8IBYXU5zI0ebsFuHghmOsOoPa9MI6J536vao5YLPuT0daTUPNtGsYi+w6rfrQBvnbnCx
        dCGn9+BY+STv5y65Z7O/i3702szI3nW/hpm5eZzGmXRW2yajPVRD88A5svs4uDHwTIHw71VH8vMe/
        LBqVpYSw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jK-00DRjV-K5; Sat, 21 Jan 2023 06:51:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/34] btrfs: calculate file system wide queue limit for zoned mode
Date:   Sat, 21 Jan 2023 07:50:29 +0100
Message-Id: <20230121065031.1139353-33-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To be able to split a write into properly sized zone append commands,
we need a queue_limits structure that contains the least common
denominator suitable for all devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h    |  5 ++++-
 fs/btrfs/zoned.c | 52 ++++++++++++++++++++++++------------------------
 fs/btrfs/zoned.h |  1 -
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3d8156fc8523f2..4c477eae689148 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
@@ -748,8 +749,10 @@ struct btrfs_fs_info {
 	 */
 	u64 zone_size;
 
-	/* Max size to emit ZONE_APPEND write command */
+	/* Constraints for ZONE_APPEND commands: */
+	struct queue_limits limits;
 	u64 max_zone_append_size;
+
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5bf67c3c9f846f..d6a8f8a07d7581 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -421,25 +421,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
-	/*
-	 * We limit max_zone_append_size also by max_segments *
-	 * PAGE_SIZE. Technically, we can have multiple pages per segment. But,
-	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
-	 * increase the metadata reservation even if it increases the number of
-	 * extents, it is safe to stick with the limit.
-	 *
-	 * With the zoned emulation, we can have non-zoned device on the zoned
-	 * mode. In this case, we don't have a valid max zone append size. So,
-	 * use max_segments * PAGE_SIZE as the pseudo max_zone_append_size.
-	 */
-	if (bdev_is_zoned(bdev)) {
-		zone_info->max_zone_append_size = min_t(u64,
-			(u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
-			(u64)bdev_max_segments(bdev) << PAGE_SHIFT);
-	} else {
-		zone_info->max_zone_append_size =
-			(u64)bdev_max_segments(bdev) << PAGE_SHIFT;
-	}
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
@@ -719,9 +700,9 @@ static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)
 
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 {
+	struct queue_limits *lim = &fs_info->limits;
 	struct btrfs_device *device;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	int ret;
 
 	/*
@@ -731,6 +712,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	if (!btrfs_fs_incompat(fs_info, ZONED))
 		return btrfs_check_for_zoned_device(fs_info);
 
+	blk_set_stacking_limits(lim);
+
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
 		struct btrfs_zoned_device_info *zone_info = device->zone_info;
 
@@ -745,10 +728,17 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				  zone_info->zone_size, zone_size);
 			return -EINVAL;
 		}
-		if (!max_zone_append_size ||
-		    (zone_info->max_zone_append_size &&
-		     zone_info->max_zone_append_size < max_zone_append_size))
-			max_zone_append_size = zone_info->max_zone_append_size;
+
+		/*
+		 * With the zoned emulation, we can have non-zoned device on the
+		 * zoned mode. In this case, we don't have a valid max zone
+		 * append size.
+		 */
+		if (bdev_is_zoned(device->bdev)) {
+			blk_stack_limits(lim,
+					 &bdev_get_queue(device->bdev)->limits,
+					 0);
+		}
 	}
 
 	/*
@@ -769,8 +759,18 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = ALIGN_DOWN(max_zone_append_size,
-						   fs_info->sectorsize);
+	/*
+	 * Also limit max_zone_append_size by max_segments * PAGE_SIZE.
+	 * Technically, we can have multiple pages per segment. But,
+	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
+	 * increase the metadata reservation even if it increases the number of
+	 * extents, it is safe to stick with the limit.
+	 */
+	fs_info->max_zone_append_size = ALIGN_DOWN(
+		min3((u64)lim->max_zone_append_sectors << SECTOR_SHIFT,
+		     (u64)lim->max_sectors << SECTOR_SHIFT,
+		     (u64)lim->max_segments << PAGE_SHIFT),
+		fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
 		fs_info->max_extent_size = fs_info->max_zone_append_size;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index bc93a740e7cf34..f25f332b772859 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -20,7 +20,6 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
-	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned int max_active_zones;
 	atomic_t active_zones_left;
-- 
2.39.0

