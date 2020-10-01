Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3B2806D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbgJASii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24722 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732864AbgJASiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577495; x=1633113495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmClhOPtDrFea7ar7p3G7l33bFEnRhz6PBpq4eUFmdI=;
  b=J1c8u4auvGqZJObDHMH1tnr7UH/+wSDUxPwRumZpBZKIBRngX/J93ACh
   nFkUw8nOf9rtBhMOzNfIOEheS0JhoWq0y6dMIX3qdFkbmjvbQwJRvFr+U
   H0I9I1yqnqKm0O0tCPY9IM2ndgs2RPO1eklE27guaA/n6oxJUt/mJAKN7
   J/CW9RywxwWKBIXQmV3LRn5MCPurH6uz79ehe6AjxQgs+cxJhoxCRTzwZ
   GSdHOStaCSdC4iH0CfAaemQwI/y3fR7dM5IN5oNABoTaWrXwvSU8TmWU2
   C8dPNWAAY3+r9vFAhQa52fTVSo9YN28ki6FbqiMAafrrQstvtqRQt4wHT
   A==;
IronPort-SDR: gCgoDBRk3eKAJMjREhT+GrCjntOkfccI0nLzcHz+SOSVcJU4gg9fIWs4Cwzuyf0GiGNQb2QPbh
 SElWUDBsg6OhtMtNCG7p9Q8HxX9TTcgEavgD+Ey0aAd0nfd6URhDlzYn6fNZLixcwKugKJv5F3
 J+HJaJRpY+jMQreUgrUlmbL/8BSdQ1oIeneQn4h6VIpBTud0N6LUfbgsS4ckPKfyc5zOd7IYyy
 jPMDn6FlovncsLpLDUxRd5MiuEWBDCr7LCYSUfz3qMOON5DLwmS6iJf1tWsJ56e0N4pFe2r7q0
 8mY=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036793"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:14 +0800
IronPort-SDR: HBd9FXbXBSVC5OEZYWShYev7O/Kgey/A+InlwfVZwbuv0nfjW5H7EHuGsCnfB5x+x+6mzIFee7
 DtYmOywopNsA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:11 -0700
IronPort-SDR: 4fEC6BYik2znt+i27daZJzh1Dgvs6UhVzhbIvGU3yLOSyg0eFHcP/fvn4BOluL4H9/nxIdYjeJ
 8YA9xlv4jTlw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 11/41] btrfs: implement log-structured superblock for ZONED mode
Date:   Fri,  2 Oct 2020 03:36:18 +0900
Message-Id: <6e76f3f26ab5ba9973b81d0db069dd0001b63b25.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Superblock (and its copies) is the only data structure in btrfs which has a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone. One easy solution is
limiting superblock and copies to be placed only in conventional zones.
However, this method has two downsides: one is reduced number of superblock
copies. The location of the second copy of superblock is 256GB, which is in
a sequential write required zone on typical devices in the market today.
So, the number of superblock and copies is limited to be two.  Second
downside is that we cannot support devices which have no conventional zones
at all.

To solve these two problems, we employ superblock log writing. It uses two
zones as a circular buffer to write updated superblocks. Once the first
zone is filled up, start writing into the second buffer. Then, when the
both zones are filled up and before start writing to the first zone again,
it reset the first zone.

We can determine the position of the latest superblock by reading write
pointer information from a device. One corner case is when the both zones
are full. For this situation, we read out the last superblock of each
zone, and compare them to determine which zone is older.

The following zones are reserved as the circular buffer on ZONED btrfs.

- The primary superblock: zones 0 and 1
- The first copy: zones 16 and 17
- The second copy: zones 1024 or zone at 256GB which is minimum, and next
  to it

If these reserved zones are conventional, superblock is written fixed at
the start of the zone without logging.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |   9 ++
 fs/btrfs/disk-io.c     |  41 +++++-
 fs/btrfs/scrub.c       |   3 +
 fs/btrfs/volumes.c     |  21 ++-
 fs/btrfs/zoned.c       | 304 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  40 ++++++
 6 files changed, 406 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0f1d6818df7..0ce68aef2dd7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1723,6 +1723,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
+	bool zoned = btrfs_fs_incompat(fs_info, ZONED);
 	u64 bytenr;
 	u64 *logical;
 	int stripe_len;
@@ -1744,6 +1745,14 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 		if (ret)
 			return ret;
 
+		/* shouldn't have super stripes in sequential zones */
+		if (zoned && nr) {
+			btrfs_err(fs_info,
+				  "Zoned btrfs's block group %llu should not have super blocks",
+				  cache->start);
+			return -EUCLEAN;
+		}
+
 		while (nr--) {
 			u64 len = min_t(u64, stripe_len,
 				cache->start + cache->length - logical[nr]);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index acf374b6e1ab..61b50a7df27b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3421,10 +3421,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 {
 	struct btrfs_super_block *super;
 	struct page *page;
-	u64 bytenr;
+	u64 bytenr, bytenr_orig;
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	int ret;
+
+	bytenr_orig = btrfs_sb_offset(copy_num);
+	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
+	if (ret == -ENOENT)
+		return ERR_PTR(-EINVAL);
+	else if (ret)
+		return ERR_PTR(ret);
 
-	bytenr = btrfs_sb_offset(copy_num);
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
 		return ERR_PTR(-EINVAL);
 
@@ -3438,7 +3445,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 		return ERR_PTR(-ENODATA);
 	}
 
-	if (btrfs_super_bytenr(super) != bytenr) {
+	if (btrfs_super_bytenr(super) != bytenr_orig) {
 		btrfs_release_disk_super(super);
 		return ERR_PTR(-EINVAL);
 	}
@@ -3493,7 +3500,8 @@ static int write_dev_supers(struct btrfs_device *device,
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
-	u64 bytenr;
+	int ret;
+	u64 bytenr, bytenr_orig;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3505,12 +3513,21 @@ static int write_dev_supers(struct btrfs_device *device,
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
 
-		bytenr = btrfs_sb_offset(i);
+		bytenr_orig = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
+		if (ret == -ENOENT)
+			continue;
+		else if (ret < 0) {
+			btrfs_err(device->fs_info, "couldn't get super block location for mirror %d",
+				  i);
+			errors++;
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
 
-		btrfs_set_super_bytenr(sb, bytenr);
+		btrfs_set_super_bytenr(sb, bytenr_orig);
 
 		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
@@ -3555,6 +3572,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			bio->bi_opf |= REQ_FUA;
 
 		btrfsic_submit_bio(bio);
+		btrfs_advance_sb_log(device, i);
 	}
 	return errors < i ? 0 : -1;
 }
@@ -3571,6 +3589,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	int i;
 	int errors = 0;
 	bool primary_failed = false;
+	int ret;
 	u64 bytenr;
 
 	if (max_mirrors == 0)
@@ -3579,7 +3598,15 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
 
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
+		if (ret == -ENOENT)
+			break;
+		else if (ret < 0) {
+			errors++;
+			if (i == 0)
+				primary_failed = true;
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf63f1e27a27..aa1b36cf5c88 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -20,6 +20,7 @@
 #include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
+#include "zoned.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -3704,6 +3705,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc21cb8cdea9..9fd5a2b0a0a7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1281,7 +1281,8 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
 }
 
 static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						       u64 bytenr)
+						       u64 bytenr,
+						       u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
 	struct page *page;
@@ -1312,7 +1313,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	/* align our pointer to the offset of the super block */
 	disk_super = p + offset_in_page(bytenr);
 
-	if (btrfs_super_bytenr(disk_super) != bytenr ||
+	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
 	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(p);
 		return ERR_PTR(-EINVAL);
@@ -1347,7 +1348,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct block_device *bdev;
-	u64 bytenr;
+	u64 bytenr, bytenr_orig;
+	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
@@ -1357,14 +1359,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 * So, we need to add a special mount option to scan for
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
-	bytenr = btrfs_sb_offset(0);
 	flags |= FMODE_EXCL;
 
 	bdev = blkdev_get_by_path(path, flags, holder);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
-	disk_super = btrfs_read_disk_super(bdev, bytenr);
+	bytenr_orig = btrfs_sb_offset(0);
+	ret = btrfs_sb_log_location_bdev(bdev, 0, READ, &bytenr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr_orig);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -2028,6 +2034,11 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 		if (IS_ERR(disk_super))
 			continue;
 
+		if (bdev_is_zoned(bdev)) {
+			btrfs_reset_sb_log_zones(bdev, copy_num);
+			continue;
+		}
+
 		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
 
 		page = virt_to_page(disk_super);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e47698d313a5..897ce30cf1a1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -26,6 +26,27 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
+static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zone,
+			    u64 *wp_ret);
+
+static inline u32 sb_zone_number(u8 shift, int mirror)
+{
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+
+	switch (mirror) {
+	case 0:
+		return 0;
+	case 1:
+		return 16;
+	case 2:
+		return min(btrfs_sb_offset(mirror) >> shift, 1024ULL);
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
 static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
@@ -126,6 +147,40 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		goto out;
 	}
 
+	nr_zones = 2;
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		u32 sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
+		u64 sb_wp;
+
+		if (sb_zone + 1 >= zone_info->nr_zones)
+			continue;
+
+		sector = sb_zone << (zone_info->zone_size_shift - SECTOR_SHIFT);
+		ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT,
+					  &zone_info->sb_zones[2 * i],
+					  &nr_zones);
+		if (ret)
+			goto out;
+		if (nr_zones != 2) {
+			btrfs_err_in_rcu(device->fs_info,
+			"failed to read SB log zone info at device %s zone %u",
+					 rcu_str_deref(device->name), sb_zone);
+			ret = -EIO;
+			goto out;
+		}
+
+		ret = sb_write_pointer(device->bdev,
+				       &zone_info->sb_zones[2 * i], &sb_wp);
+		if (ret != -ENOENT && ret) {
+			btrfs_err_in_rcu(device->fs_info,
+				"SB log zone corrupted: device %s zone %u",
+					 rcu_str_deref(device->name), sb_zone);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
+
 	kfree(zones);
 
 	device->zone_info = zone_info;
@@ -305,3 +360,252 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 
 	return 0;
 }
+
+static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
+			    u64 *wp_ret)
+{
+	bool empty[2];
+	bool full[2];
+	sector_t sector;
+
+	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
+	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
+
+	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
+	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
+	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
+	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
+
+	/*
+	 * Possible state of log buffer zones
+	 *
+	 *   E I F
+	 * E * x 0
+	 * I 0 x 0
+	 * F 1 1 C
+	 *
+	 * Row: zones[0]
+	 * Col: zones[1]
+	 * State:
+	 *   E: Empty, I: In-Use, F: Full
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   C: Compare SBs from zones[0] and zones[1], use the newer one
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* Compare two super blocks */
+		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct page *page[2];
+		struct btrfs_super_block *super[2];
+		int i;
+
+		for (i = 0; i < 2; i++) {
+			u64 bytenr = ((zones[i].start + zones[i].len) << SECTOR_SHIFT) -
+				BTRFS_SUPER_INFO_SIZE;
+
+			page[i] = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
+			if (IS_ERR(page[i])) {
+				if (i == 1)
+					btrfs_release_disk_super(super[0]);
+				return PTR_ERR(page[i]);
+			}
+			super[i] = page_address(page[i]);
+		}
+
+		if (super[0]->generation > super[1]->generation)
+			sector = zones[1].start;
+		else
+			sector = zones[0].start;
+
+		for (i = 0; i < 2; i++)
+			btrfs_release_disk_super(super[i]);
+	} else if (!full[0] && (empty[1] || full[1])) {
+		sector = zones[0].wp;
+	} else if (full[0]) {
+		sector = zones[1].wp;
+	} else {
+		return -EUCLEAN;
+	}
+	*wp_ret = sector << SECTOR_SHIFT;
+	return 0;
+}
+
+static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
+			   int rw, u64 *bytenr_ret)
+{
+	u64 wp;
+	int ret;
+
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
+		return 0;
+	}
+
+	ret = sb_write_pointer(bdev, zones, &wp);
+	if (ret != -ENOENT && ret < 0)
+		return ret;
+
+	if (rw == WRITE) {
+		struct blk_zone *reset = NULL;
+
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			reset = &zones[0];
+		else if (wp == zones[1].start << SECTOR_SHIFT)
+			reset = &zones[1];
+
+		if (reset) {
+			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
+
+			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+					       reset->start, reset->len,
+					       GFP_NOFS);
+			if (ret)
+				return ret;
+
+			reset->cond = BLK_ZONE_COND_EMPTY;
+			reset->wp = reset->start;
+		}
+	} else if (ret != -ENOENT) {
+		/* For READ, we want the precious one */
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+
+	*bytenr_ret = wp;
+	return 0;
+
+}
+
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret)
+{
+	struct blk_zone zones[2];
+	unsigned int zone_sectors;
+	u32 sb_zone;
+	int ret;
+	u64 zone_size;
+	u8 zone_sectors_shift;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	u32 nr_zones;
+
+	if (!bdev_is_zoned(bdev)) {
+		*bytenr_ret = btrfs_sb_offset(mirror);
+		return 0;
+	}
+
+	ASSERT(rw == READ || rw == WRITE);
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	if (!is_power_of_2(zone_sectors))
+		return -EINVAL;
+	zone_size = zone_sectors << SECTOR_SHIFT;
+	zone_sectors_shift = ilog2(zone_sectors);
+	nr_zones = nr_sectors >> zone_sectors_shift;
+
+	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	ret = blkdev_report_zones(bdev, sb_zone << zone_sectors_shift, 2,
+				  copy_zone_info_cb, zones);
+	if (ret < 0)
+		return ret;
+	if (ret != 2)
+		return -EIO;
+
+	return sb_log_location(bdev, zones, rw, bytenr_ret);
+}
+
+int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
+			  u64 *bytenr_ret)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	u32 zone_num;
+
+	if (!zinfo) {
+		*bytenr_ret = btrfs_sb_offset(mirror);
+		return 0;
+	}
+
+	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return -ENOENT;
+
+	return sb_log_location(device->bdev, &zinfo->sb_zones[2 * mirror], rw,
+			       bytenr_ret);
+}
+
+static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
+				  int mirror)
+{
+	u32 zone_num;
+
+	if (!zinfo)
+		return false;
+
+	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	if (zone_num + 1 >= zinfo->nr_zones)
+		return false;
+
+	if (!test_bit(zone_num, zinfo->seq_zones))
+		return false;
+
+	return true;
+}
+
+void btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
+{
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	struct blk_zone *zone;
+
+	if (!is_sb_log_zone(zinfo, mirror))
+		return;
+
+	zone = &zinfo->sb_zones[2 * mirror];
+	if (zone->cond != BLK_ZONE_COND_FULL) {
+		if (zone->cond == BLK_ZONE_COND_EMPTY)
+			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+		zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+		if (zone->wp == zone->start + zone->len)
+			zone->cond = BLK_ZONE_COND_FULL;
+		return;
+	}
+
+	zone++;
+	ASSERT(zone->cond != BLK_ZONE_COND_FULL);
+	if (zone->cond == BLK_ZONE_COND_EMPTY)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	zone->wp += (BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT);
+	if (zone->wp == zone->start + zone->len)
+		zone->cond = BLK_ZONE_COND_FULL;
+}
+
+int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
+{
+	sector_t zone_sectors;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	u8 zone_sectors_shift;
+	u32 sb_zone;
+	u32 nr_zones;
+
+	zone_sectors = bdev_zone_sectors(bdev);
+	zone_sectors_shift = ilog2(zone_sectors);
+	nr_zones = nr_sectors >> zone_sectors_shift;
+
+	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	if (sb_zone + 1 >= nr_zones)
+		return -ENOENT;
+
+	return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+				sb_zone << zone_sectors_shift, zone_sectors * 2,
+				GFP_NOFS);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 2e1983188e6f..60651040532a 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -10,6 +10,8 @@
 #define BTRFS_ZONED_H
 
 #include <linux/blkdev.h>
+#include "volumes.h"
+#include "disk-io.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -22,6 +24,7 @@ struct btrfs_zoned_device_info {
 	u32 nr_zones;
 	unsigned long *seq_zones;
 	unsigned long *empty_zones;
+	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -31,6 +34,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device);
 void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
+int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
+			       u64 *bytenr_ret);
+int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
+			  u64 *bytenr_ret);
+void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
+int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -54,6 +63,26 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 {
 	return 0;
 }
+static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
+					     int mirror, int rw,
+					     u64 *bytenr_ret)
+{
+	*bytenr_ret = btrfs_sb_offset(mirror);
+	return 0;
+}
+static inline int btrfs_sb_log_location(struct btrfs_device *device, int mirror,
+					int rw, u64 *bytenr_ret)
+{
+	*bytenr_ret = btrfs_sb_offset(mirror);
+	return 0;
+}
+static inline void btrfs_advance_sb_log(struct btrfs_device *device,
+					int mirror) { }
+static inline int btrfs_reset_sb_log_zones(struct block_device *bdev,
+					   int mirror)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -121,4 +150,15 @@ static inline bool btrfs_check_device_zone_type(struct btrfs_fs_info *fs_info,
 	return bdev_zoned_model(bdev) != BLK_ZONED_HM;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device,
+					      u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned device,
+	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL ||
+	       !btrfs_dev_is_sequential(device, pos);
+}
+
 #endif
-- 
2.27.0

