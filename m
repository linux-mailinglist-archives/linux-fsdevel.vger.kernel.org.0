Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352FB38B1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfFGNLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfFGNLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913114; x=1591449114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JsJEksBAd4pxlAoho7ymddDsmZQUseg8FYJnpzL5RF0=;
  b=qoHz+JKWu+POwXs4RmFgIkOxbICaOnJdaOOWJ4dxonRnCZ8s188/cjG9
   2vEQ8BXMZFUiWEgh3WuRyXMmj436WKuOlK6o/yh9s8L2oFOHIeeEM2Gv4
   5peKdTADelyczDTh4q24axb3PArJwAQNoBqyCSK9HbTpIAmOGA/mckQ8+
   yRYRJDt4DURkOn+UDY2XyX5Gu8tkg1rzZkO82edCytEzYcIujVHo/hVVJ
   4KrONAUckff68T+lw7mkBouDZXo2qoiaTNskDZlpzJOyXaFgDv6NmISwp
   Vlfiw1KO+gfSvmRQtvoCkFSXaqmTnSH7gbQja02m3s1Lu+iuHDnejsVxF
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027836"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:54 +0800
IronPort-SDR: TFRe6NKM4mF7cFUbS7qO2XUpJktKuC9XqWPvbQBLnhxv0C27cGhi8y7HIhfWc5o4qssK7uku0O
 N3PmNfh/cKAlwLbqZivK6gAxWI3kJf35jAxYdtIh3t7P8sFnFx4hAGpdzjnu+7lDf9btJ8bLZG
 bvuiYVwpFIV+IlkVB4yuumMDtUR1Tt2Qa0gctT6lVlcT0cyaiUgYeUn307yZjJQNrIlABMwf+X
 4pPTF93yRcxcCenTKlMIFbiJkc7ge182uF9ZQn6DT+BFGv4fJH+9RI+vGsp2LD/5rbKQwrlgpG
 EZRBtyE2nGInfUE1q/pksg7N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:11 -0700
IronPort-SDR: fNhUCvGk1hpWIQkOdSVYVao56ook/uvyTJ0C0ii4bVedeCMgNsQ+z20OA6sGJXjedY2cUkYH2L
 8YokaYA7y8m9wJ5wtCco0EF1AOzKb8QQG/mT02KYIpOHlIq95wVRoVH/JG6WYLNrcZyJi743HM
 TMvBEK/PqzQ5oiaeI/JNcb3BG0hN6M3ECiukBJhcC9lRrXQQtWYh/EDeBOhPP6EZt1qKfKvPW0
 6/AOtLiDCfsejHAOm1DkqgyoA1+wOkr8AGPP3uPF1en/FG0+gTiNvFbaDDiX/Cm/kLOjNY2xbw
 U6E=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:52 -0700
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
Subject: [PATCH 18/19] btrfs: support dev-replace in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:24 +0900
Message-Id: <20190607131025.31996-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, dev-replace copy all the device extents on source device to the
target device, and it also clones new incoming write I/Os from users to the
source device into the target device.

Cloning incoming IOs can break the sequential write rule in the target
device. When write is mapped in the middle of block group, that I/O is
directed in the middle of a zone of target device, which breaks the
sequential write rule.

However, the cloning function cannot be simply disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether bio
is going to not yet copied region.  Since we have time gap between
finishing btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have newly allocated device extent
which is never cloned (by handle_ops_on_dev_replace) nor copied (by the
dev-replace process).

So the point is to copy only already existing device extents. This patch
introduce mark_block_group_to_copy() to mark existing block group as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

This patch also handles empty region between used extents. Since
dev-replace is smart to copy only used extents on source device, we have to
fill the gap to honor the sequential write rule in the target device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |   1 +
 fs/btrfs/dev-replace.c |  96 +++++++++++++++++++++++
 fs/btrfs/extent-tree.c |  32 +++++++-
 fs/btrfs/scrub.c       | 169 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c     |  27 ++++++-
 5 files changed, 319 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dad8ea5c3b99..a0be2b96117a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -639,6 +639,7 @@ struct btrfs_block_group_cache {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int wp_broken:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index fbe5ea2a04ed..5011b5ce0e75 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -263,6 +263,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
+	if (bdev_is_zoned(bdev)) {
+		ret = btrfs_get_dev_zonetypes(device);
+		if (ret) {
+			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+			goto error;
+		}
+	}
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	fs_info->fs_devices->num_devices++;
 	fs_info->fs_devices->open_devices++;
@@ -396,6 +403,88 @@ static char* btrfs_dev_name(struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
+static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+				    struct btrfs_device *src_dev)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_dev_extent *dev_extent = NULL;
+	struct btrfs_block_group_cache *cache;
+	struct extent_buffer *l;
+	int slot;
+	int ret;
+	u64 chunk_offset, length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	path->reada = READA_FORWARD;
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	key.objectid = src_dev->devid;
+	key.offset = 0ull;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+
+	while (1) {
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			if (path->slots[0] >=
+			    btrfs_header_nritems(path->nodes[0])) {
+				ret = btrfs_next_leaf(root, path);
+				if (ret < 0)
+					break;
+				if (ret > 0) {
+					ret = 0;
+					break;
+				}
+			} else {
+				ret = 0;
+			}
+		}
+
+		l = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(l, &found_key, slot);
+
+		if (found_key.objectid != src_dev->devid)
+			break;
+
+		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
+			break;
+
+		if (found_key.offset < key.offset)
+			break;
+
+		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
+		length = btrfs_dev_extent_length(l, dev_extent);
+
+		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
+
+		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
+		if (!cache)
+			goto skip;
+
+		cache->to_copy = 1;
+
+		btrfs_put_block_group(cache);
+
+skip:
+		key.offset = found_key.offset + length;
+		btrfs_release_path(path);
+	}
+
+	btrfs_free_path(path);
+
+	return ret;
+}
+
 static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
 		int read_src)
@@ -439,6 +528,13 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	}
 
 	need_unlock = true;
+
+	mutex_lock(&fs_info->chunk_mutex);
+	ret = mark_block_group_to_copy(fs_info, src_device);
+	mutex_unlock(&fs_info->chunk_mutex);
+	if (ret)
+		return ret;
+
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ff4d55d6ef04..268365dd9a5d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -29,6 +29,7 @@
 #include "qgroup.h"
 #include "ref-verify.h"
 #include "rcu-string.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2022,7 +2023,31 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			if (btrfs_dev_is_sequential(stripe->dev,
 						    stripe->physical) &&
 			    stripe->length == stripe->dev->zone_size) {
-				ret = blkdev_reset_zones(stripe->dev->bdev,
+				struct btrfs_device *dev = stripe->dev;
+
+				ret = blkdev_reset_zones(dev->bdev,
+							 stripe->physical >>
+								 SECTOR_SHIFT,
+							 stripe->length >>
+								 SECTOR_SHIFT,
+							 GFP_NOFS);
+				if (!ret)
+					discarded_bytes += stripe->length;
+				else
+					break;
+				set_bit(stripe->physical >>
+					dev->zone_size_shift,
+					dev->empty_zones);
+
+				if (!btrfs_dev_replace_is_ongoing(
+					    &fs_info->dev_replace) ||
+				    stripe->dev != fs_info->dev_replace.srcdev)
+					continue;
+
+				/* send to target as well */
+				dev = fs_info->dev_replace.tgtdev;
+
+				ret = blkdev_reset_zones(dev->bdev,
 							 stripe->physical >>
 								 SECTOR_SHIFT,
 							 stripe->length >>
@@ -2033,8 +2058,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				else
 					break;
 				set_bit(stripe->physical >>
-						stripe->dev->zone_size_shift,
-					stripe->dev->empty_zones);
+					dev->zone_size_shift,
+					dev->empty_zones);
+
 				continue;
 			}
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 36ad4fad7eaf..7bfc19c50224 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -165,6 +165,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1646,6 +1647,19 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	sbio = sctx->wr_curr_bio;
 	if (sbio->page_count == 0) {
 		struct bio *bio;
+		u64 physical = spage->physical_for_dev_replace;
+
+		if (btrfs_fs_incompat(sctx->fs_info, HMZONED) &&
+		    sctx->write_pointer < physical) {
+			u64 length = physical - sctx->write_pointer;
+
+			ret = blkdev_issue_zeroout(
+				sctx->wr_tgtdev->bdev,
+				sctx->write_pointer >> SECTOR_SHIFT,
+				length >> SECTOR_SHIFT,
+				GFP_NOFS, 0);
+			sctx->write_pointer = physical;
+		}
 
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
@@ -1708,6 +1722,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_fs_incompat(sctx->fs_info, HMZONED))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3030,6 +3048,43 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
+	int nmirrors;
+	int i, ret;
+
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &mapped_length, &bbio);
+	if (ret || !bbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_bbio(bbio);
+		return -EIO;
+	}
+
+	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return -EINVAL;
+
+	nmirrors = min(scrub_nr_raid_mirrors(bbio), BTRFS_MAX_MIRRORS);
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone, GFP_NOFS);
+		/* failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3161,6 +3216,15 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	blk_start_plug(&plug);
 
+	if (btrfs_fs_incompat(fs_info, HMZONED) && sctx->is_dev_replace &&
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+		mutex_lock(&sctx->wr_lock);
+		sctx->write_pointer = physical;
+		mutex_unlock(&sctx->wr_lock);
+	}
+
+	sctx->flush_all_writes = true;
+
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
@@ -3333,6 +3397,15 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			sctx->flush_all_writes = true;
+			scrub_submit(sctx);
+			mutex_lock(&sctx->wr_lock);
+			scrub_wr_submit(sctx);
+			mutex_unlock(&sctx->wr_lock);
+
+			wait_event(sctx->list_wait,
+				   atomic_read(&sctx->bios_in_flight) == 0);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3400,6 +3473,45 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (btrfs_fs_incompat(fs_info, HMZONED) && sctx->is_dev_replace &&
+	    ret >= 0) {
+		wait_event(sctx->list_wait,
+			   atomic_read(&sctx->bios_in_flight) == 0);
+
+		mutex_lock(&sctx->wr_lock);
+		if (sctx->write_pointer < physical_end &&
+		    btrfs_dev_is_sequential(sctx->wr_tgtdev,
+					    sctx->write_pointer)) {
+			struct blk_zone zone;
+			u64 wp;
+
+			ret = read_zone_info(fs_info, base + offset, &zone);
+			if (ret) {
+				btrfs_err(fs_info,
+					  "cannot recover write pointer");
+				goto out_zone_sync;
+			}
+
+			wp = map->stripes[num].physical +
+				((zone.wp - zone.start) << SECTOR_SHIFT);
+			if (sctx->write_pointer < wp) {
+				u64 length = wp - sctx->write_pointer;
+
+				ret = blkdev_issue_zeroout(
+					sctx->wr_tgtdev->bdev,
+					sctx->write_pointer >> SECTOR_SHIFT,
+					length >> SECTOR_SHIFT,
+					GFP_NOFS, 0);
+			}
+		}
+out_zone_sync:
+		mutex_unlock(&sctx->wr_lock);
+		clear_bit(map->stripes[num].physical >>
+			  sctx->wr_tgtdev->zone_size_shift,
+			  sctx->wr_tgtdev->empty_zones);
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -3468,11 +3580,14 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	int ret = 0;
 	int ro_set;
 	int slot;
+	int i, num_extents, cur_extent;
 	struct extent_buffer *l;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	struct extent_map *em;
+	struct map_lookup *map;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3487,6 +3602,23 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
 	while (1) {
+		if (btrfs_fs_incompat(fs_info, HMZONED) &&
+		    sctx->is_dev_replace) {
+			struct btrfs_trans_handle *trans;
+
+			scrub_pause_on(fs_info);
+			trans = btrfs_join_transaction(root);
+			if (IS_ERR(trans))
+				ret = PTR_ERR(trans);
+			else
+				ret = btrfs_commit_transaction(trans);
+			if (ret) {
+				scrub_pause_off(fs_info);
+				break;
+			}
+			scrub_pause_off(fs_info);
+		}
+
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		if (ret < 0)
 			break;
@@ -3541,6 +3673,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+		if (sctx->is_dev_replace && !cache->to_copy) {
+			ro_set = 0;
+			goto done;
+		}
+
 		/*
 		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
 		 * to avoid deadlock caused by:
@@ -3651,6 +3788,38 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 
+		if (sctx->is_dev_replace) {
+			em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+			BUG_ON(IS_ERR(em));
+			map = em->map_lookup;
+
+			num_extents = cur_extent = 0;
+			for (i = 0; i < map->num_stripes; i++) {
+				/* we have more device extent to copy */
+				if (dev_replace->srcdev != map->stripes[i].dev)
+					continue;
+
+				num_extents++;
+				if (found_key.offset ==
+				    map->stripes[i].physical)
+					cur_extent = i;
+			}
+
+			free_extent_map(em);
+
+			if (num_extents > 1) {
+				if (cur_extent == 0) {
+					btrfs_inc_block_group_ro(cache);
+				} else if (cur_extent == num_extents - 1) {
+					btrfs_dec_block_group_ro(cache);
+					cache->to_copy = 0;
+				}
+			} else {
+				cache->to_copy = 0;
+			}
+		}
+
+done:
 		down_write(&fs_info->dev_replace.rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a04379e440fb..e0a37466bb2d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1841,6 +1841,8 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 	else
 		search_start = max_t(u64, search_start, SZ_1M);
 
+	WARN_ON(device->zone_size && !IS_ALIGNED(num_bytes, device->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -6180,6 +6182,7 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      struct btrfs_bio **bbio_ret,
 				      struct btrfs_dev_replace *dev_replace,
+				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
 	struct btrfs_bio *bbio = *bbio_ret;
@@ -6190,7 +6193,18 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	int i;
 
 	if (op == BTRFS_MAP_WRITE) {
+		struct btrfs_block_group_cache *cache;
+		struct btrfs_fs_info *fs_info = dev_replace->srcdev->fs_info;
 		int index_where_to_add;
+		int hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
+
+		cache = btrfs_lookup_block_group(fs_info, logical);
+		BUG_ON(!cache);
+		if (hmzoned && cache->to_copy) {
+			btrfs_put_block_group(cache);
+			return;
+		}
+		btrfs_put_block_group(cache);
 
 		/*
 		 * duplicate the write operations while the dev replace
@@ -6215,10 +6229,17 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				new->physical = old->physical;
 				new->length = old->length;
 				new->dev = dev_replace->tgtdev;
-				bbio->tgtdev_map[i] = index_where_to_add;
+				bbio->tgtdev_map[i] =
+					index_where_to_add;
 				index_where_to_add++;
 				max_errors++;
 				tgtdev_indexes++;
+
+				/* mark this zone as non-empty */
+				if (hmzoned)
+					clear_bit(new->physical >>
+						  new->dev->zone_size_shift,
+						  new->dev->empty_zones);
 			}
 		}
 		num_stripes = index_where_to_add;
@@ -6551,8 +6572,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
-- 
2.21.0

