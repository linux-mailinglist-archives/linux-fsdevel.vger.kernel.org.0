Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F749266779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgIKRnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:43:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIKMgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827773; x=1631363773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kKRjEpMb1plEY26COWVdyUchowLlJUVQkFHc7CHHKI=;
  b=YQlU/i0v8KAfuClbH0P+POzx3f50Z2R4Tj65JJb37ZbgcHsysVxA3JIX
   9EcFd8KXjWOhwi+CHy1VmfjxMcskWcFUw+1+nbEdZHxg+MPUvZ4wA27zA
   jT9DsR8d/S5D0Aq7APu+Hgu1g6Y0lKq3J4vtiYi8Zo6RCASmZ0Gs7z2Z6
   7FVFZXsyRpIm13XpWoiXWZjxkY4RqTb6IXYaBCeGDRq+ROGcqaCJikzPQ
   yyMbFJ0SwKWDov5MMyjMH02FbYZENSU8kj5fhCf2XKdtE5vKHW4NLmjRw
   7/H97KAW+wD2sue0MdVCtKdl5adJbhnmaA/o4VEy7KY2ErbVtn6hwm3DU
   w==;
IronPort-SDR: Re4iltSrpXpn7zTWQvCt/zr+b+//Ba/bWVe9pOYrXSYzssPjIvr0v1obBxYM5cYuHC19jPqTn/
 9QED2XdIkrmmTt74cfVWywZAdiedQ4u9MRqWCPTp9QDKIlk32rTu0vhZzvLIn4Iw8GaiiH3TS/
 VaiNb2j/RrvVCCPBMKzo+eXyiRwMcWAWYX6b3X4TJwrZ5Q/pTtFLw6nlqSGastxXV+lGqlOS1s
 +4OAk/Dr+u3guqfYVgousmwzXqWm/7L2SxUDrX5rz43V7g/oouKCYbw1O0EpH4B/3uPnL0/6o9
 MZM=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125988"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:30 +0800
IronPort-SDR: eTwyPSv/p4NT4jy5md+sW/NGtU8Cqtce0HlcpeBdSu/koymq3UtCHWcXJklu0LJVO+j2vFLtBO
 Ll3JH/LEcx7A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:50 -0700
IronPort-SDR: EOalRsz66TAJvvJtcu7cL4pcAaQsNmT8zmCLwU741h9krVEa2tugZoi7F9Lwj10UuMAcv35RJd
 X2PUkV7zKd3w==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 15/39] btrfs: track unusable bytes for zones
Date:   Fri, 11 Sep 2020 21:32:35 +0900
Message-Id: <20200911123259.3782926-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zoned btrfs, once written, then freed region is never usable until
resetting underlying zones. We need to distinguish such unusable space from
usable free space. So, this commit introduces "zone_unusable" to block
group, and "bytes_zone_unusable" to space_info to track the unusable space.

Pinned bytes are always reclaimed to the unsable space. But, when an
allocated region is returned before using e.g., the block group becomes
read-only between allocation time and reservation time, we can safely
return the region to the block group. For the situation, this commit
introduces "btrfs_add_free_space_unused". This behave as the same as
btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      | 19 +++++++++-----
 fs/btrfs/block-group.h      |  1 +
 fs/btrfs/extent-tree.c      | 15 ++++++++---
 fs/btrfs/free-space-cache.c | 52 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-cache.h |  4 +++
 fs/btrfs/space-info.c       | 13 ++++++----
 fs/btrfs/space-info.h       |  4 ++-
 fs/btrfs/sysfs.c            |  2 ++
 fs/btrfs/zoned.c            | 22 ++++++++++++++++
 fs/btrfs/zoned.h            |  2 ++
 10 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3ce685a10631..324a1ef1bf04 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1080,12 +1080,15 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		WARN_ON(block_group->space_info->total_bytes
 			< block_group->length);
 		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length);
+			< block_group->length - block_group->zone_unusable);
+		WARN_ON(block_group->space_info->bytes_zone_unusable
+			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	block_group->space_info->bytes_readonly -= block_group->length;
+	block_group->space_info->bytes_readonly -=
+		(block_group->length - block_group->zone_unusable);
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1229,7 +1232,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	}
 
 	num_bytes = cache->length - cache->reserved - cache->pinned -
-		    cache->bytes_super - cache->used;
+		    cache->bytes_super - cache->zone_unusable - cache->used;
 
 	/*
 	 * Data never overcommits, even in mixed mode, so do just the straight
@@ -1983,6 +1986,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	}
 
+	btrfs_calc_zone_unusable(cache);
+
 	ret = btrfs_add_block_group_cache(info, cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
@@ -1990,7 +1995,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
 	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+				cache->used, cache->bytes_super,
+				cache->zone_unusable, &space_info);
 
 	cache->space_info = space_info;
 
@@ -2204,7 +2210,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+				cache->bytes_super, 0, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
@@ -2312,7 +2318,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->length - cache->reserved -
-			    cache->pinned - cache->bytes_super - cache->used;
+			    cache->pinned - cache->bytes_super -
+			    cache->zone_unusable - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
 	}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 14e3043c9ce7..5be47f4bfea7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -189,6 +189,7 @@ struct btrfs_block_group {
 	 * allocation. This is used only with ZONED mode enabled.
 	 */
 	u64 alloc_offset;
+	u64 zone_unusable;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e9eedc053fc5..4f486277fb6e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "rcu-string.h"
+#include "zoned.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -2790,9 +2791,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			cache = btrfs_lookup_block_group(fs_info, start);
 			BUG_ON(!cache); /* Logic error */
 
-			cluster = fetch_cluster_info(fs_info,
-						     cache->space_info,
-						     &empty_cluster);
+			if (!btrfs_fs_incompat(fs_info, ZONED))
+				cluster = fetch_cluster_info(fs_info,
+							     cache->space_info,
+							     &empty_cluster);
+
 			empty_cluster <<= 1;
 		}
 
@@ -2829,7 +2832,11 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
-		if (cache->ro) {
+		if (btrfs_fs_incompat(fs_info, ZONED)) {
+			/* need reset before reusing in zoned Block Group */
+			space_info->bytes_zone_unusable += len;
+			readonly = true;
+		} else if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dc82fd0c80cb..7701b39b4d57 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2470,6 +2470,8 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	u64 filter_bytes = bytes;
 
+	ASSERT(!btrfs_fs_incompat(fs_info, ZONED));
+
 	info = kmem_cache_zalloc(btrfs_free_space_cachep, GFP_NOFS);
 	if (!info)
 		return -ENOMEM;
@@ -2527,11 +2529,44 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
+				 u64 bytenr, u64 size, bool used)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 offset = bytenr - block_group->start;
+	u64 to_free, to_unusable;
+
+	spin_lock(&ctl->tree_lock);
+	if (!used)
+		to_free = size;
+	else if (offset >= block_group->alloc_offset)
+		to_free = size;
+	else if (offset + size <= block_group->alloc_offset)
+		to_free = 0;
+	else
+		to_free = offset + size - block_group->alloc_offset;
+	to_unusable = size - to_free;
+
+	ctl->free_space += to_free;
+	block_group->zone_unusable += to_unusable;
+	spin_unlock(&ctl->tree_lock);
+	if (!used) {
+		spin_lock(&block_group->lock);
+		block_group->alloc_offset -= size;
+		spin_unlock(&block_group->lock);
+	}
+	return 0;
+}
+
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size)
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_fs_incompat(block_group->fs_info, ZONED))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
@@ -2540,6 +2575,16 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 				      bytenr, size, trim_state);
 }
 
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size)
+{
+	if (btrfs_fs_incompat(block_group->fs_info, ZONED))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    false);
+
+	return btrfs_add_free_space(block_group, bytenr, size);
+}
+
 /*
  * This is a subtle distinction because when adding free space back in general,
  * we want it to be added as untrimmed for async. But in the case where we add
@@ -2550,6 +2595,10 @@ int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (btrfs_fs_incompat(block_group->fs_info, ZONED))
+		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
+						    true);
+
 	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC) ||
 	    btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		trim_state = BTRFS_TRIM_STATE_TRIMMED;
@@ -2567,6 +2616,9 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
+	if (btrfs_fs_incompat(block_group->fs_info, ZONED))
+		return 0;
+
 	spin_lock(&ctl->tree_lock);
 
 again:
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index e3d5e0ad8f8e..7081216257a8 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -114,8 +114,12 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
 			   u64 bytenr, u64 size,
 			   enum btrfs_trim_state trim_state);
+int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
+				 u64 bytenr, u64 size, bool used);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
+int btrfs_add_free_space_unused(struct btrfs_block_group *block_group,
+				u64 bytenr, u64 size);
 int btrfs_add_free_space_async_trimmed(struct btrfs_block_group *block_group,
 				       u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 475968ccbd1d..bcf7c41746d8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -163,6 +163,7 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 	ASSERT(s_info);
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
 		(may_use_included ? s_info->bytes_may_use : 0);
 }
 
@@ -259,7 +260,7 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info)
 {
 	struct btrfs_space_info *found;
@@ -275,6 +276,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 	found->bytes_used += bytes_used;
 	found->disk_used += bytes_used * factor;
 	found->bytes_readonly += bytes_readonly;
+	found->bytes_zone_unusable += bytes_zone_unusable;
 	if (total_bytes > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
@@ -433,10 +435,10 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		   info->total_bytes - btrfs_space_info_used(info, true),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu",
+		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
-		info->bytes_readonly);
+		info->bytes_readonly, info->bytes_zone_unusable);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
@@ -465,9 +467,10 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(cache, &info->block_groups[index], list) {
 		spin_lock(&cache->lock);
 		btrfs_info(fs_info,
-			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
+			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu zone_unusable %s",
 			cache->start, cache->length, cache->used, cache->pinned,
-			cache->reserved, cache->ro ? "[readonly]" : "");
+			cache->reserved, cache->zone_unusable,
+			cache->ro ? "[readonly]" : "");
 		spin_unlock(&cache->lock);
 		btrfs_dump_free_space(cache, bytes);
 	}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c3c64019950a..3799b703f0eb 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -17,6 +17,8 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
+	u64 bytes_zone_unusable;	/* total bytes that are unusable until
+					   resetting the device zone */
 
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
@@ -119,7 +121,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+			     u64 bytes_readonly, u64 bytes_zone_unusable,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 38c7a57789d8..1709f5e0e375 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -626,6 +626,7 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
@@ -639,6 +640,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ca090a5cdc6e..68f8224d74c3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1006,3 +1006,25 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
 	return ret;
 }
+
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
+{
+	u64 unusable, free;
+
+	if (!btrfs_fs_incompat(cache->fs_info, ZONED))
+		return;
+
+	WARN_ON(cache->bytes_super != 0);
+	unusable = cache->alloc_offset - cache->used;
+	free = cache->length - cache->alloc_offset;
+	/* we only need ->free_space in ALLOC_SEQ BGs */
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->free_space_ctl->free_space = free;
+	cache->zone_unusable = unusable;
+	/*
+	 * Should not have any excluded extents. Just
+	 * in case, though.
+	 */
+	btrfs_free_excluded_extents(cache);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 1fd7cad19e18..3e3eff8dd0b4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -46,6 +46,7 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
+void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -113,6 +114,7 @@ static inline int btrfs_load_block_group_zone_info(
 {
 	return 0;
 }
+static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

