Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E01938B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfFGNL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfFGNL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913088; x=1591449088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xBsRKkNWUbngL/HotqrmOsnq8ySlTj6IOvXhxVGScfM=;
  b=bYhHT8CmNOdSHvwe+YC+Z2u0f8vwkJHxjbnhHiyGuTbmjG7evwBf/YjO
   McuKp3YXNvZPtDIh3/oBvDzVwNdMKoVQ8QQ10t32EZUMvz7zcZHKCbnWB
   ZU9BUf+W+SjWhgNJ8B6ZltvU5U3araxPfe73QFSmRM8J0tIMJKKDzu5sO
   58LnJJFjt0FrWtkx/TXjsWrgq0fo51fMcMLtmt+OolorbqNhBTbhi9UTP
   kyfLrgCCMycHD3ztCosBOKFI2Ly5DuDXZCPgl0Xc77VKvxZ8kOtN/+cBr
   9icsp8zibbCvKrVwrk+hXLyEI9ZNhAXMWsj+/N7L0GrzTvxtKxO409i3s
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027798"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:28 +0800
IronPort-SDR: 8YsjyHbGiqb3F979RZGK8KizYd2YhHUA5Ncyp/NthRdeObN6qUVylACnttP3D7ul7TGhZHiU5M
 alnWZx7CwAfh/aD9duS9I+6nRCL8fbXb+lKudfH95w8ABDB5vFMcy2S0NNYJ8RRZJlVaUOQWyj
 9pGFINj9Vvzm+OTmXchCC3Bh0hklhpIxcRTRKqvYfK29GjDSLzBVvaEsbDQKAw01/8gVJ7Z0vI
 lBJygH/wWMxLF3XdfkYZwCJ22Mcl5vu0URnWE29Wzm+NmW9XbnHK1tS1GNwK2hGUTuUUXj98fo
 5rDTHg7OfQEl2fw/JbeIDbp5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:44 -0700
IronPort-SDR: ZpJkImPkJtKlQGDbEDAh4KA0jLciilUBCSDoL45BFmkpCnBH26cXNh8XlKSZCOiMI7UkPZ3qvU
 FTZq8Gd1ktRVsADv9IVQmP4RSSZCDtzdC48nRvNHvmKwqeFDFPKDQmv4pCFEkKiPmuBCumKPZ3
 K8wFLX+QfxLHR85IY8ap11qxAm3x0yrM1P2FomZkEifV0dNGK5PQ+O/SFj5LHRdIoxaLMN089i
 hCpePRP3X0Va6YEamWRpaMf82uZ/5l+hySR69Rm0GLefTjoHqYUCqXEsIQwPuRkTPNHdE8uEPl
 iDg=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:26 -0700
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
Subject: [PATCH 07/19] btrfs: do sequential extent allocation in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:13 +0900
Message-Id: <20190607131025.31996-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On HMZONED drives, writes must always be sequential and directed at a block
group zone write pointer position. Thus, block allocation in a block group
must also be done sequentially using an allocation pointer equal to the
block group zone write pointer plus the number of blocks allocated but not
yet written.

Sequential allocation function find_free_extent_seq() bypass the checks in
find_free_extent() and increase the reserved byte counter by itself. It is
impossible to revert once allocated region in the sequential allocation,
since it might race with other allocations and leave an allocation hole,
which breaks the sequential write rule.

Furthermore, this commit introduce two new variable to struct
btrfs_block_group_cache. "wp_broken" indicate that write pointer is broken
(e.g. not synced on a RAID1 block group) and mark that block group read
only. "unusable" keeps track of the size of once allocated then freed
region. Such region is never usable until resetting underlying zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h            |  24 +++
 fs/btrfs/extent-tree.c      | 378 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/free-space-cache.c |  33 ++++
 fs/btrfs/free-space-cache.h |   5 +
 4 files changed, 426 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6c00101407e4..f4bcd2a6ec12 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -582,6 +582,20 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
+/* Block group allocation types */
+enum btrfs_alloc_type {
+
+	/* Regular first fit allocation */
+	BTRFS_ALLOC_FIT		= 0,
+
+	/*
+	 * Sequential allocation: this is for HMZONED mode and
+	 * will result in ignoring free space before a block
+	 * group allocation offset.
+	 */
+	BTRFS_ALLOC_SEQ		= 1,
+};
+
 struct btrfs_block_group_cache {
 	struct btrfs_key key;
 	struct btrfs_block_group_item item;
@@ -592,6 +606,7 @@ struct btrfs_block_group_cache {
 	u64 reserved;
 	u64 delalloc_bytes;
 	u64 bytes_super;
+	u64 unusable;
 	u64 flags;
 	u64 cache_generation;
 
@@ -621,6 +636,7 @@ struct btrfs_block_group_cache {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int wp_broken:1;
 
 	int disk_cache_state;
 
@@ -694,6 +710,14 @@ struct btrfs_block_group_cache {
 
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+
+	/*
+	 * Allocation offset for the block group to implement sequential
+	 * allocation. This is used only with HMZONED mode enabled and if
+	 * the block group resides on a sequential zone.
+	 */
+	enum btrfs_alloc_type alloc_type;
+	u64 alloc_offset;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 363db58f56b8..ebd0d6eae038 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -28,6 +28,7 @@
 #include "sysfs.h"
 #include "qgroup.h"
 #include "ref-verify.h"
+#include "rcu-string.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -590,6 +591,8 @@ static int cache_block_group(struct btrfs_block_group_cache *cache,
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	WARN_ON(cache->alloc_type == BTRFS_ALLOC_SEQ);
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -6555,6 +6558,19 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache *bg)
 	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
 }
 
+static void __btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+				       u64 ram_bytes, u64 num_bytes,
+				       int delalloc)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+
+	cache->reserved += num_bytes;
+	space_info->bytes_reserved += num_bytes;
+	update_bytes_may_use(space_info, -ram_bytes);
+	if (delalloc)
+		cache->delalloc_bytes += num_bytes;
+}
+
 /**
  * btrfs_add_reserved_bytes - update the block_group and space info counters
  * @cache:	The cache we are manipulating
@@ -6573,17 +6589,16 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	struct btrfs_space_info *space_info = cache->space_info;
 	int ret = 0;
 
+	/* should handled by find_free_extent_seq */
+	WARN_ON(cache->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
-	if (cache->ro) {
+	if (cache->ro)
 		ret = -EAGAIN;
-	} else {
-		cache->reserved += num_bytes;
-		space_info->bytes_reserved += num_bytes;
-		update_bytes_may_use(space_info, -ram_bytes);
-		if (delalloc)
-			cache->delalloc_bytes += num_bytes;
-	}
+	else
+		__btrfs_add_reserved_bytes(cache, ram_bytes, num_bytes,
+					   delalloc);
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -6701,9 +6716,13 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			cache = btrfs_lookup_block_group(fs_info, start);
 			BUG_ON(!cache); /* Logic error */
 
-			cluster = fetch_cluster_info(fs_info,
-						     cache->space_info,
-						     &empty_cluster);
+			if (cache->alloc_type == BTRFS_ALLOC_FIT)
+				cluster = fetch_cluster_info(fs_info,
+							     cache->space_info,
+							     &empty_cluster);
+			else
+				cluster = NULL;
+
 			empty_cluster <<= 1;
 		}
 
@@ -6743,7 +6762,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (cache->ro || cache->alloc_type == BTRFS_ALLOC_SEQ) {
+			/* need reset before reusing in ALLOC_SEQ BG */
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
@@ -7588,6 +7608,60 @@ static int find_free_extent_unclustered(struct btrfs_block_group_cache *bg,
 	return 0;
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserve the bytes as in btrfs_add_reserved_bytes.
+ */
+
+static int find_free_extent_seq(struct btrfs_block_group_cache *cache,
+				struct find_free_extent_ctl *ffe_ctl)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	u64 start = cache->key.objectid;
+	u64 num_bytes = ffe_ctl->num_bytes;
+	u64 avail;
+	int ret = 0;
+
+	/* Sanity check */
+	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
+		return 1;
+
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
+
+	if (cache->ro) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	spin_lock(&ctl->tree_lock);
+	avail = cache->key.offset - cache->alloc_offset;
+	if (avail < num_bytes) {
+		ffe_ctl->max_extent_size = avail;
+		spin_unlock(&ctl->tree_lock);
+		ret = 1;
+		goto out;
+	}
+
+	ffe_ctl->found_offset = start + cache->alloc_offset;
+	cache->alloc_offset += num_bytes;
+	ctl->free_space -= num_bytes;
+	spin_unlock(&ctl->tree_lock);
+
+	BUG_ON(!IS_ALIGNED(ffe_ctl->found_offset,
+			   cache->fs_info->stripesize));
+	ffe_ctl->search_start = ffe_ctl->found_offset;
+	__btrfs_add_reserved_bytes(cache, ffe_ctl->ram_bytes, num_bytes,
+				   ffe_ctl->delalloc);
+
+out:
+	spin_unlock(&cache->lock);
+	spin_unlock(&space_info->lock);
+	return ret;
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -7889,6 +7963,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
+		if (block_group->alloc_type == BTRFS_ALLOC_SEQ) {
+			ret = find_free_extent_seq(block_group, &ffe_ctl);
+			if (ret)
+				goto loop;
+			/* btrfs_find_space_for_alloc_seq should ensure
+			 * that everything is OK and reserve the extent.
+			 */
+			goto nocheck;
+		}
+
 		/*
 		 * Ok we want to try and use the cluster allocator, so
 		 * lets look there
@@ -7944,6 +8028,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 					     num_bytes);
 			goto loop;
 		}
+nocheck:
 		btrfs_inc_block_group_reservations(block_group);
 
 		/* we are all good, lets return */
@@ -9616,7 +9701,8 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 	}
 
 	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
-		    cache->bytes_super - btrfs_block_group_used(&cache->item);
+		    cache->bytes_super - cache->unusable -
+		    btrfs_block_group_used(&cache->item);
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
 	if (sinfo_used + num_bytes + min_allocable_bytes <=
@@ -9766,6 +9852,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	if (!--cache->ro) {
 		num_bytes = cache->key.offset - cache->reserved -
 			    cache->pinned - cache->bytes_super -
+			    cache->unusable -
 			    btrfs_block_group_used(&cache->item);
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
@@ -10200,11 +10287,240 @@ static void link_block_group(struct btrfs_block_group_cache *cache)
 	}
 }
 
+static int
+btrfs_get_block_group_alloc_offset(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree.map_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	struct btrfs_device *device;
+	u64 logical = cache->key.objectid;
+	u64 length = cache->key.offset;
+	u64 physical = 0;
+	int ret, alloc_type;
+	int i, j;
+	u64 *alloc_offsets = NULL;
+
+#define WP_MISSING_DEV ((u64)-1)
+
+	/* Sanity check */
+	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+		btrfs_err(fs_info, "unaligned block group at %llu + %llu",
+			  logical, length);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	em_tree = &fs_info->mapping_tree.map_tree;
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, logical, length);
+	read_unlock(&em_tree->lock);
+
+	if (!em)
+		return -EINVAL;
+
+	map = em->map_lookup;
+
+	/*
+	 * Get the zone type: if the group is mapped to a non-sequential zone,
+	 * there is no need for the allocation offset (fit allocation is OK).
+	 */
+	alloc_type = -1;
+	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets),
+				GFP_NOFS);
+	if (!alloc_offsets) {
+		free_extent_map(em);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < map->num_stripes; i++) {
+		int is_sequential;
+		struct blk_zone zone;
+
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
+
+		if (device->bdev == NULL) {
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		}
+
+		is_sequential = btrfs_dev_is_sequential(device, physical);
+		if (alloc_type == -1)
+			alloc_type = is_sequential ?
+					BTRFS_ALLOC_SEQ : BTRFS_ALLOC_FIT;
+
+		if ((is_sequential && alloc_type != BTRFS_ALLOC_SEQ) ||
+		    (!is_sequential && alloc_type == BTRFS_ALLOC_SEQ)) {
+			btrfs_err(fs_info, "found block group of mixed zone types");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (!is_sequential)
+			continue;
+
+		/* this zone will be used for allocation, so mark this
+		 * zone non-empty
+		 */
+		clear_bit(physical >> device->zone_size_shift,
+			  device->empty_zones);
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		WARN_ON(!IS_ALIGNED(physical, fs_info->zone_size));
+		ret = btrfs_get_dev_zone(device, physical, &zone, GFP_NOFS);
+		if (ret == -EIO || ret == -EOPNOTSUPP) {
+			ret = 0;
+			alloc_offsets[i] = WP_MISSING_DEV;
+			continue;
+		} else if (ret) {
+			goto out;
+		}
+
+
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			btrfs_err(fs_info, "Offline/readonly zone %llu",
+				  physical >> device->zone_size_shift);
+			alloc_offsets[i] = WP_MISSING_DEV;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = fs_info->zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] =
+				((zone.wp - zone.start) << SECTOR_SHIFT);
+			break;
+		}
+	}
+
+	if (alloc_type == BTRFS_ALLOC_FIT)
+		goto out;
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+		cache->alloc_offset = WP_MISSING_DEV;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV)
+				continue;
+			if (cache->alloc_offset == WP_MISSING_DEV)
+				cache->alloc_offset = alloc_offsets[i];
+			if (alloc_offsets[i] == cache->alloc_offset)
+				continue;
+
+			btrfs_err(fs_info,
+				  "write pointer mismatch: block group %llu",
+				  logical);
+			cache->wp_broken = 1;
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] == WP_MISSING_DEV) {
+				btrfs_err(fs_info,
+					  "cannot recover write pointer: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[i]) {
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			cache->alloc_offset += alloc_offsets[i];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		/*
+		 * Pass1: check write pointer of RAID1 level: each pointer
+		 * should be equal.
+		 */
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i*map->sub_stripes;
+			u64 offset = WP_MISSING_DEV;
+
+			for (j = 0; j < map->sub_stripes; j++) {
+				if (alloc_offsets[base+j] == WP_MISSING_DEV)
+					continue;
+				if (offset == WP_MISSING_DEV)
+					offset = alloc_offsets[base+j];
+				if (alloc_offsets[base+j] == offset)
+					continue;
+
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+			}
+			for (j = 0; j < map->sub_stripes; j++)
+				alloc_offsets[base+j] = offset;
+		}
+
+		/* Pass2: check write pointer of RAID1 level */
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int base = i*map->sub_stripes;
+
+			if (alloc_offsets[base] == WP_MISSING_DEV) {
+				btrfs_err(fs_info,
+					  "cannot recover write pointer: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[base]) {
+				btrfs_err(fs_info,
+					  "write pointer mismatch: block group %llu",
+					  logical);
+				cache->wp_broken = 1;
+				continue;
+			}
+
+			cache->alloc_offset += alloc_offsets[base];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* RAID5/6 is not supported yet */
+	default:
+		btrfs_err(fs_info, "Unsupported profile on HMZONED %llu",
+			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	cache->alloc_type = alloc_type;
+	kfree(alloc_offsets);
+	free_extent_map(em);
+
+	return ret;
+}
+
 static struct btrfs_block_group_cache *
 btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 size)
 {
 	struct btrfs_block_group_cache *cache;
+	int ret;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	if (!cache)
@@ -10238,6 +10554,16 @@ btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
 	atomic_set(&cache->trimming, 0);
 	mutex_init(&cache->free_space_lock);
 	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
+	cache->alloc_type = BTRFS_ALLOC_FIT;
+	cache->alloc_offset = 0;
+
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		ret = btrfs_get_block_group_alloc_offset(cache);
+		if (ret) {
+			kfree(cache);
+			return NULL;
+		}
+	}
 
 	return cache;
 }
@@ -10310,6 +10636,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 	u64 feature;
+	u64 unusable;
 	int mixed;
 
 	feature = btrfs_super_incompat_flags(info->super_copy);
@@ -10415,6 +10742,26 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			free_excluded_extents(cache);
 		}
 
+		switch (cache->alloc_type) {
+		case BTRFS_ALLOC_FIT:
+			unusable = cache->bytes_super;
+			break;
+		case BTRFS_ALLOC_SEQ:
+			WARN_ON(cache->bytes_super != 0);
+			unusable = cache->alloc_offset -
+				btrfs_block_group_used(&cache->item);
+			/* we only need ->free_space in ALLOC_SEQ BGs */
+			cache->last_byte_to_unpin = (u64)-1;
+			cache->cached = BTRFS_CACHE_FINISHED;
+			cache->free_space_ctl->free_space =
+				cache->key.offset - cache->alloc_offset;
+			cache->unusable = unusable;
+			free_excluded_extents(cache);
+			break;
+		default:
+			BUG();
+		}
+
 		ret = btrfs_add_block_group_cache(info, cache);
 		if (ret) {
 			btrfs_remove_free_space_cache(cache);
@@ -10425,7 +10772,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		trace_btrfs_add_block_group(info, cache, 0);
 		update_space_info(info, cache->flags, found_key.offset,
 				  btrfs_block_group_used(&cache->item),
-				  cache->bytes_super, &space_info);
+				  unusable, &space_info);
 
 		cache->space_info = space_info;
 
@@ -10438,6 +10785,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
 		}
+
+		if (cache->wp_broken)
+			inc_block_group_ro(cache, 1);
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f74dc259307b..cc69dc71f4c1 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2326,8 +2326,11 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   u64 offset, u64 bytes)
 {
 	struct btrfs_free_space *info;
+	struct btrfs_block_group_cache *block_group = ctl->private;
 	int ret = 0;
 
+	WARN_ON(block_group && block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2376,6 +2379,28 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_group,
+			       u64 bytenr, u64 size)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->key.objectid;
+	u64 to_free, to_unusable;
+
+	spin_lock(&ctl->tree_lock);
+	if (offset >= block_group->alloc_offset)
+		to_free = size;
+	else if (offset + size <= block_group->alloc_offset)
+		to_free = 0;
+	else
+		to_free = offset + size - block_group->alloc_offset;
+	to_unusable = size - to_free;
+	ctl->free_space += to_free;
+	block_group->unusable += to_unusable;
+	spin_unlock(&ctl->tree_lock);
+	return 0;
+
+}
+
 int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 			    u64 offset, u64 bytes)
 {
@@ -2384,6 +2409,8 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 	int ret;
 	bool re_search = false;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&ctl->tree_lock);
 
 again:
@@ -2619,6 +2646,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -2738,6 +2767,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3384,6 +3415,8 @@ int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
 {
 	int ret;
 
+	WARN_ON(block_group->alloc_type == BTRFS_ALLOC_SEQ);
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 8760acb55ffd..d30667784f73 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -73,10 +73,15 @@ void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 bytenr, u64 size);
+int __btrfs_add_free_space_seq(struct btrfs_block_group_cache *block_group,
+			       u64 bytenr, u64 size);
 static inline int
 btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
 		     u64 bytenr, u64 size)
 {
+	if (block_group->alloc_type == BTRFS_ALLOC_SEQ)
+		return __btrfs_add_free_space_seq(block_group, bytenr, size);
+
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
 				      bytenr, size);
-- 
2.21.0

