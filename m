Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574D95A90EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiIAHoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIAHnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4781257FE;
        Thu,  1 Sep 2022 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=STwYbSO0Izmp+1f3nnFS1hp97GJ6kHn4j/tdcQ/e/24=; b=xH18PWLefCm9R1AjbvzOcidgo4
        nukbqy9Qggn1Vlgq/8yPXV7djtDV+08cNMHoJLDRpzwTCLWHa/eEqcpgFrWZ4R6VJoeart4lNjd2L
        c41NXI+lH5ffd9RaElqT3pRqUKjLjkkPiJjDS6L7m2e4yzQceMwwHPqtAxXsuEPDpeeW62AJYd88s
        WrFjP+FLK8BIIq5XE0eDZwdOlwlCcZmFDs9S6VbOoO2TJvS4VcYNZfghbi0cFlrgbT713VO+suZHK
        3xmyNlm8+m7hm4ehNxOnScG7rqo8qmBqlZv94tQ0GTeaag6VUhWgDmEK+GotGr/3XD2qzmCiTLqmn
        XusE6y9A==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTerA-00ANo2-5B; Thu, 01 Sep 2022 07:43:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/17] btrfs: calculate file system wide queue limit for zoned mode
Date:   Thu,  1 Sep 2022 10:42:14 +0300
Message-Id: <20220901074216.1849941-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/ctree.h |  4 +++-
 fs/btrfs/zoned.c | 36 ++++++++++++++++++------------------
 fs/btrfs/zoned.h |  1 -
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e57e3c6a1fd6..a37129363e184 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1071,8 +1071,10 @@ struct btrfs_fs_info {
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
index 2638f71eec4b6..6e04fbbd76b92 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -415,16 +415,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
-	/*
-	 * We limit max_zone_append_size also by max_segments *
-	 * PAGE_SIZE. Technically, we can have multiple pages per segment. But,
-	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
-	 * increase the metadata reservation even if it increases the number of
-	 * extents, it is safe to stick with the limit.
-	 */
-	zone_info->max_zone_append_size =
-		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
-		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
 	if (!IS_ALIGNED(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
@@ -646,14 +636,16 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct queue_limits *lim = &fs_info->limits;
 	struct btrfs_device *device;
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
+	blk_set_stacking_limits(lim);
+
 	/* Count zoned devices */
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		enum blk_zoned_model model;
@@ -685,11 +677,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
-			if (!max_zone_append_size ||
-			    (zone_info->max_zone_append_size &&
-			     zone_info->max_zone_append_size < max_zone_append_size))
-				max_zone_append_size =
-					zone_info->max_zone_append_size;
+			blk_stack_limits(lim,
+					 &bdev_get_queue(device->bdev)->limits,
+					 0);
 		}
 		nr_devices++;
 	}
@@ -739,8 +729,18 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
index cafa639927050..0f22b22fe359f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -19,7 +19,6 @@ struct btrfs_zoned_device_info {
 	 */
 	u64 zone_size;
 	u8  zone_size_shift;
-	u64 max_zone_append_size;
 	u32 nr_zones;
 	unsigned int max_active_zones;
 	atomic_t active_zones_left;
-- 
2.30.2

