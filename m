Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441A7631427
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKTMtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKTMsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEC15728;
        Sun, 20 Nov 2022 04:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ihECBtxlSvrkWfIUHrv/MgTQk0vfH1hSDnXcMhV0EiE=; b=sY8/O50fIkkDTnGUWSpidB859u
        Z7ebbWCaVUqbpPb9huMlpokAKMm7Ul+KjdvlVC2535VgpekABbrOb79JhAO90HxBEpvvrqxsirIrN
        7aIo22QfiN7gY6/j4IX9TmMFP8dC8muW0ZkoXQN8KdiktUECf3SHowBPuqHgIZvI7D9ZJjSWx5MhS
        u/9FKqX9iPffg01Nu2ywb3/TlIFH3iUt6pUXWPDiIJI2Etox20g4nPvP40YFkskjh/8mqjCKc77Vq
        REqIcvhHkDO8+dkF7KWDBdby6kVfqzZuv3mp1NJcDuxHZInNPMzDkyAXrVN9cVKU+GwQ6kHF+LMUL
        ZFBMQPQA==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjkF-004IHg-Qf; Sun, 20 Nov 2022 12:48:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/19] btrfs: calculate file system wide queue limit for zoned mode
Date:   Sun, 20 Nov 2022 13:47:32 +0100
Message-Id: <20221120124734.18634-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
---
 fs/btrfs/fs.h    |  5 ++++-
 fs/btrfs/zoned.c | 52 ++++++++++++++++++++++++------------------------
 fs/btrfs/zoned.h |  1 -
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index a749367e5ae2a..d5224df7468b8 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
@@ -736,8 +737,10 @@ struct btrfs_fs_info {
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
index 04a16d70ed7a5..2d14f5ad79a39 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -418,25 +418,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
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
 
@@ -714,9 +695,9 @@ static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)
 
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 {
+	struct queue_limits *lim = &fs_info->limits;
 	struct btrfs_device *device;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	int ret;
 
 	/*
@@ -726,6 +707,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	if (!btrfs_fs_incompat(fs_info, ZONED))
 		return btrfs_check_for_zoned_device(fs_info);
 
+	blk_set_stacking_limits(lim);
+
 	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
 		struct btrfs_zoned_device_info *zone_info = device->zone_info;
 
@@ -740,10 +723,17 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
@@ -764,8 +754,18 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
index bc93a740e7cf3..f25f332b77285 100644
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
2.30.2

