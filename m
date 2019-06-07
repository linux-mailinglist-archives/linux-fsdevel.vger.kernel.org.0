Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5293138B77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfFGNSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfFGNSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913536; x=1591449536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4NWtweua7TkhXD0M6sRjN0MzNkFoyAD3U+9vqG8Tws=;
  b=QIZAnzZRmQxsijP03Gg6EUtjIdqHHPp+PdurIHpl9FWAtCZYzKVq9BY5
   cPmgM2Kit7M6zw2QgCEGUugZaialuotl9c+SU0VIdwKdCApqyJUA5NGUd
   Ku9Nwgzpste4b5L4iaOcKSejXq7HUOvmdl7VbKYllk/tvXJwLiDlpRmCL
   mwBtoByP8z6PmvrQ+vb8LD/R4oRKpMpEw976Aqs7xsQsXKapvpT6FrPm+
   6I/I5shhr0VLCTOiGrwYypf04JWhyH4Rcbaa8TdVom2zAATOBUkbM49lS
   1yfbBbr1In5CxFDWc/n2sXQV5+LAnkhg206hs1+OUVvhaiuYfOiWxurPJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:56 +0800
IronPort-SDR: ZthmMGTQGMOOYvRdROOzND4Fk0u68/P+08GEijdd3cBzqxsEYWJQv3iXqTqVaumJoY1OorHC2f
 e64k2hQqg3JEQ4DEl3W+mp12euvp5aq1r4a3JLCsUJNsJZZhhWDmfR3KdxSWc1a56quZgxSxuy
 pA5bfB+yj8s8cCwD3ojbmMM9PEktrYB76MtDYHJIpV01YFq3nY2DQVcDevf6CoZJJA79SoWUAE
 o8NYAcjg+3nksv2Fo1zoA4kakQ7Lnw6d6PeKgD/SbuIZfndSZxLDwlTPA0UBTI0hdGnH9yF/lp
 YwPGDEgt4VBmWdyelObfnzph
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:38 -0700
IronPort-SDR: LOv5t6VjMVSb81F17hV+/uTNSWRclkqc+qgAuEhG7YA3jTskaMuADsO0/qngMWl6R9M8e/t+a5
 ddwJfDeXemyhN5nlxe8dwnH3ZJ544imnAgaGqXh7hKYfaU0akHJNHCO1wK6PEcd29MNSxRu63K
 fmO78Z7rxgguxszfkLi4eu4CSHar61UgYGhKf3H5QHUEbVQf3OEqaObpFZZwYopC2Q/SMk7wF/
 wHAqVpIhTqdMh1t7zML2pbxQ3fI5aOTUYRZjGY+DddwDHeuywjVjjT4dKFz8kOdmB+RXBs6vPL
 CNA=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:19 -0700
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
Subject: [PATCH 09/12] btrfs-progs: do sequential allocation
Date:   Fri,  7 Jun 2019 22:17:48 +0900
Message-Id: <20190607131751.5359-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131751.5359-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131751.5359-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensures that block allocation in sequential write required zones is always
done sequentially using an allocation pointer which is the zone write
pointer plus the number of blocks already allocated but not yet written.
For conventional zones, the legacy behavior is used.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 ctree.h       |  17 +++++
 extent-tree.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++++++
 transaction.c |  16 +++++
 3 files changed, 219 insertions(+)

diff --git a/ctree.h b/ctree.h
index 9f79686690e0..2e828bf1250e 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1068,15 +1068,32 @@ struct btrfs_space_info {
 	struct list_head list;
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
 	struct cache_extent cache;
 	struct btrfs_key key;
 	struct btrfs_block_group_item item;
 	struct btrfs_space_info *space_info;
 	struct btrfs_free_space_ctl *free_space_ctl;
+	enum btrfs_alloc_type alloc_type;
 	u64 bytes_super;
 	u64 pinned;
 	u64 flags;
+	u64 alloc_offset;
+	u64 write_offset;
 	int cached;
 	int ro;
 	/*
diff --git a/extent-tree.c b/extent-tree.c
index e62ee8c2ba13..528c6875c8fb 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -251,6 +251,14 @@ again:
 	if (cache->ro || !block_group_bits(cache, data))
 		goto new_group;
 
+	if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+		if (cache->key.offset - cache->alloc_offset < num)
+			goto new_group;
+		*start_ret = cache->key.objectid + cache->alloc_offset;
+		cache->alloc_offset += num;
+		return 0;
+	}
+
 	while(1) {
 		ret = find_first_extent_bit(&root->fs_info->free_space_cache,
 					    last, &start, &end, EXTENT_DIRTY);
@@ -277,6 +285,7 @@ out:
 			(unsigned long long)search_start);
 		return -ENOENT;
 	}
+	printf("nospace\n");
 	return -ENOSPC;
 
 new_group:
@@ -3039,6 +3048,176 @@ error:
 	return ret;
 }
 
+#ifdef BTRFS_ZONED
+static int
+btrfs_get_block_group_alloc_offset(struct btrfs_fs_info *fs_info,
+				   struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_device *device;
+	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
+	struct cache_extent *ce;
+	struct map_lookup *map;
+	u64 logical = cache->key.objectid;
+	u64 length = cache->key.offset;
+	u64 physical = 0;
+	int ret = 0;
+	int i;
+	u64 zone_size = fs_info->fs_devices->zone_size;
+	u64 *alloc_offsets = NULL;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	/* Sanity check */
+	if (!IS_ALIGNED(length, zone_size)) {
+		fprintf(stderr, "unaligned block group at %llu", logical);
+		return -EIO;
+	}
+
+	/* Get the chunk mapping */
+	ce = search_cache_extent(&map_tree->cache_tree, logical);
+	if (!ce) {
+		fprintf(stderr, "failed to find block group at %llu", logical);
+		return -ENOENT;
+	}
+	map = container_of(ce, struct map_lookup, ce);
+
+	/*
+	 * Get the zone type: if the group is mapped to a non-sequential zone,
+	 * there is no need for the allocation offset (fit allocation is OK).
+	 */
+	device = map->stripes[0].dev;
+	physical = map->stripes[0].physical;
+	if (!zone_is_random_write(&device->zinfo, physical))
+		cache->alloc_type = BTRFS_ALLOC_SEQ;
+
+	/* check block group mapping */
+	alloc_offsets = calloc(map->num_stripes, sizeof(*alloc_offsets));
+	for (i = 0; i < map->num_stripes; i++) {
+		int is_sequential;
+		struct blk_zone zone;
+
+		device = map->stripes[i].dev;
+		physical = map->stripes[i].physical;
+
+		is_sequential = !zone_is_random_write(&device->zinfo, physical);
+		if ((is_sequential && cache->alloc_type != BTRFS_ALLOC_SEQ) ||
+		    (!is_sequential && cache->alloc_type == BTRFS_ALLOC_SEQ)) {
+			fprintf(stderr,
+				"found block group of mixed zone types");
+			ret = -EIO;
+			goto out;
+		}
+
+		if (!is_sequential)
+			continue;
+
+		WARN_ON(!IS_ALIGNED(physical, zone_size));
+		zone = device->zinfo.zones[physical / zone_size];
+
+		/*
+		 * The group is mapped to a sequential zone. Get the zone write
+		 * pointer to determine the allocation offset within the zone.
+		 */
+		switch (zone.cond) {
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+			fprintf(stderr, "Offline/readonly zone %llu",
+				physical / fs_info->fs_devices->zone_size);
+			ret = -EIO;
+			goto out;
+		case BLK_ZONE_COND_EMPTY:
+			alloc_offsets[i] = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+			alloc_offsets[i] = zone_size;
+			break;
+		default:
+			/* Partially used zone */
+			alloc_offsets[i] = ((zone.wp - zone.start) << 9);
+			break;
+		}
+	}
+
+	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
+		goto out;
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case 0: /* single */
+	case BTRFS_BLOCK_GROUP_DUP:
+	case BTRFS_BLOCK_GROUP_RAID1:
+		for (i = 1; i < map->num_stripes; i++) {
+			if (alloc_offsets[i] != alloc_offsets[0]) {
+				fprintf(stderr,
+					"zones' write pointers mismatch\n");
+				ret = -EIO;
+				goto out;
+			}
+		}
+		cache->alloc_offset = alloc_offsets[0];
+		break;
+	case BTRFS_BLOCK_GROUP_RAID0:
+		cache->alloc_offset = alloc_offsets[0];
+		for (i = 1; i < map->num_stripes; i++) {
+			cache->alloc_offset += alloc_offsets[i];
+			if (alloc_offsets[0] < alloc_offsets[i]) {
+				fprintf(stderr,
+					"zones' write pointers mismatch\n");
+				ret = -EIO;
+				goto out;
+			}
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
+		cache->alloc_offset = 0;
+		for (i = 0; i < map->num_stripes / map->sub_stripes; i++) {
+			int j;
+			int base;
+
+			base = i*map->sub_stripes;
+			for (j = 1; j < map->sub_stripes; j++) {
+				if (alloc_offsets[base] !=
+					alloc_offsets[base+j]) {
+					fprintf(stderr,
+						"zones' write pointer mismatch\n");
+					ret = -EIO;
+					goto out;
+				}
+			}
+
+			if (alloc_offsets[0] < alloc_offsets[base]) {
+				fprintf(stderr,
+					"zones' write pointer mismatch\n");
+				ret = -EIO;
+				goto out;
+			}
+			cache->alloc_offset += alloc_offsets[base];
+		}
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
+		/* RAID5/6 is not supported yet */
+	default:
+		fprintf(stderr, "Unsupported profile %llu\n",
+			map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	cache->write_offset = cache->alloc_offset;
+	free(alloc_offsets);
+	return ret;
+}
+#else
+static int
+btrfs_get_block_group_alloc_offset(struct btrfs_fs_info *fs_info,
+				   struct btrfs_block_group_cache *cache)
+{
+	return 0;
+}
+#endif
+
 int btrfs_read_block_groups(struct btrfs_root *root)
 {
 	struct btrfs_path *path;
@@ -3122,6 +3301,10 @@ int btrfs_read_block_groups(struct btrfs_root *root)
 		BUG_ON(ret);
 		cache->space_info = space_info;
 
+		ret = btrfs_get_block_group_alloc_offset(info, cache);
+		if (ret)
+			goto error;
+
 		/* use EXTENT_LOCKED to prevent merging */
 		set_extent_bits(block_group_cache, found_key.objectid,
 				found_key.objectid + found_key.offset - 1,
@@ -3151,6 +3334,9 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.objectid = chunk_offset;
 	cache->key.offset = size;
 
+	ret = btrfs_get_block_group_alloc_offset(fs_info, cache);
+	BUG_ON(ret);
+
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	btrfs_set_block_group_used(&cache->item, bytes_used);
 	btrfs_set_block_group_chunk_objectid(&cache->item,
diff --git a/transaction.c b/transaction.c
index 138e10f0d6cc..39a52732bc71 100644
--- a/transaction.c
+++ b/transaction.c
@@ -129,16 +129,32 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 {
 	u64 start;
 	u64 end;
+	u64 next = 0;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb;
 	struct extent_io_tree *tree = &fs_info->extent_cache;
+	struct btrfs_block_group_cache *bg = NULL;
 	int ret;
 
 	while(1) {
+again:
 		ret = find_first_extent_bit(tree, 0, &start, &end,
 					    EXTENT_DIRTY);
 		if (ret)
 			break;
+		bg = btrfs_lookup_first_block_group(fs_info, start);
+		BUG_ON(!bg);
+		if (bg->alloc_type == BTRFS_ALLOC_SEQ &&
+		    bg->key.objectid + bg->write_offset < start) {
+			next = bg->key.objectid + bg->write_offset;
+			BUG_ON(next + fs_info->nodesize > start);
+			eb = btrfs_find_create_tree_block(fs_info, next);
+			btrfs_mark_buffer_dirty(eb);
+			free_extent_buffer(eb);
+			goto again;
+		}
+		if (bg->alloc_type == BTRFS_ALLOC_SEQ)
+			bg->write_offset += (end + 1 - start);
 		while(start <= end) {
 			eb = find_first_extent_buffer(tree, start);
 			BUG_ON(!eb || eb->start != start);
-- 
2.21.0

