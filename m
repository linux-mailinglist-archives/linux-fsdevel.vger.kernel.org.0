Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F16666DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjALJMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjALJKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095705328B;
        Thu, 12 Jan 2023 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GPwGfVub3xcDboebFOItyevq/Q6H+ZHaKJSGOJQpWfs=; b=Hl4BWJnsjyYIxa1YitgfxFqWca
        B0uyGHzEogHoPxB7Yg6JXh7zZ8+SQ8lSo986bkgMTxmOsRucaSqipj22qWFMAa9F87wp5TeELyR/w
        D8ZylLeayU5G0kGlHD5QGs7aAMvRGkSohDMSQ5U5dnH9jth/PPw5O9ZPIWe5UmeF5Aazm7yuWFJKn
        xe6uFzKbVYiscPDPah2XbduQnaO2VmQ4CrYO05g8R2rg1yTboM+vvaAZX4gx1tOCFpLp195SDjA6p
        b0lL7oEngGCIombqJ9Lmom3kWEHvN1OP7/AjSd1sqAb2zFXE8s9QbDxXMEH8sNVvJhXau3QJ3dcMI
        YTQZBFcA==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtXU-00EGZJ-5o; Thu, 12 Jan 2023 09:06:24 +0000
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
Date:   Thu, 12 Jan 2023 10:05:29 +0100
Message-Id: <20230112090532.1212225-18-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/fs.h    |  5 ++++-
 fs/btrfs/zoned.c | 52 ++++++++++++++++++++++++------------------------
 fs/btrfs/zoned.h |  1 -
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 37b86acfcbcf88..8311768b8586b1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
@@ -742,8 +743,10 @@ struct btrfs_fs_info {
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
2.35.1

