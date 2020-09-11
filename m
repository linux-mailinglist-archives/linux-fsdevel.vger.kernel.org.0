Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367E6266774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgIKRnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:43:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgIKMgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827774; x=1631363774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9ylhoMUMvMfBh0uJ8EDnluGQ1RXwDp7rM3DVgfS9qw=;
  b=P4Hi+Ae+MlkCQ3f4ZBy/s79M6PzJ7FzIZsHzkmUe0iudKmwMyjatT/Fc
   K09JlaPma1j+osteukMz31QBlW8+d4EmoHHNl47bBmF1TB80tGBKH/UTm
   hsKIE4hCQPE7p2AqqUx8qVxWvMtKEVulUuRn9r1WSaWWnMjnS+nYAHYoj
   aE+kNcG1CyfSBbqDJFN5Ov5zrPtKHvkm4RoMyMunZ/NXMBkFj+0o591UD
   nv0xBz6rN6Btmzz6fwpC+oXmi0EeXKfSI9qDEHHfhHIK0ojxfxB9Vf8vQ
   /Lgumflt3xtNp1EhRBSF7kDJRbK+zFzZT/8hkiD312FpRdAHhWEyTXFIq
   A==;
IronPort-SDR: JjJv/VpA0Jc08QT7ouuchw89NR6jbdu2qhZWOmiCfQtvwmEf/hNgXYLpSuMnBg9zaNUyaZ7FLH
 WVO8W5osaVUAR2EOisKhA+iwmxIE2Feb5yBECfV4tREaqSVz02eeThlVlEatvr61Msw0j4MPN+
 InF5ih9PbguXvQ4Jx1hChOcWJ2eGE47jp3aG+dUaEMVMotZXqoC8D2SS+p02JyaDfjnXuCTRWE
 annM9lmZwhccWUfO2jEZspKJw7jZloDOzRucF2+B3rCbS81DanxwdUIoa/7hLKu8hsUZ9B56Do
 //k=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125990"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:31 +0800
IronPort-SDR: P8/FjH+2EvOQC5YBhqVSY2kIZwfc5jYtsFq38QKZX7n5ascp9ui3GG6fLmT9gZyOgqzU3mBFFV
 TtayScYnmeHA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:52 -0700
IronPort-SDR: 1HP5aheOsDCA7EzKCyk8vvLxFZ89E6a+4Q0n1AwYwppf+4+KrMNGEQQoTTfRlFupLeRtC8kBT7
 JQtqVLEVrG6g==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:29 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 16/39] btrfs: do sequential extent allocation in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:36 +0900
Message-Id: <20200911123259.3782926-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit implement sequential extent allocator for ZONED mode. The
allocator just need to check if there is enough space in the block group.
Since the allocator never manage bitmap or cluster. This commit also add
ASSERTs to the corresponding functions.

Actually, with zone append writing, it is unnecessary to track the
allocation offset. It only needs to check space availability. But, by
tracking the offset and returning the offset as an allocated region, we can
skip modification of ordered extents and checksum information when there is
no IO reordering.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c      |  4 ++
 fs/btrfs/extent-tree.c      | 82 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/free-space-cache.c |  6 +++
 3 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 324a1ef1bf04..9df83e687b92 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -683,6 +683,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
+	/* Allocator for ZONED btrfs do not use the cache at all */
+	if (btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4f486277fb6e..5f86d552c6cb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3412,6 +3412,7 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
+	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
 /*
@@ -3664,6 +3665,55 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
+/*
+ * Simple allocator for sequential only block group. It only allows
+ * sequential allocation. No need to play with trees. This function
+ * also reserve the bytes as in btrfs_add_reserved_bytes.
+ */
+static int do_allocation_zoned(struct btrfs_block_group *block_group,
+			       struct find_free_extent_ctl *ffe_ctl,
+			       struct btrfs_block_group **bg_ret)
+{
+	struct btrfs_space_info *space_info = block_group->space_info;
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	u64 start = block_group->start;
+	u64 num_bytes = ffe_ctl->num_bytes;
+	u64 avail;
+	int ret = 0;
+
+	ASSERT(btrfs_fs_incompat(block_group->fs_info, ZONED));
+
+	spin_lock(&space_info->lock);
+	spin_lock(&block_group->lock);
+
+	if (block_group->ro) {
+		ret = 1;
+		goto out;
+	}
+
+	avail = block_group->length - block_group->alloc_offset;
+	if (avail < num_bytes) {
+		ffe_ctl->max_extent_size = avail;
+		ret = 1;
+		goto out;
+	}
+
+	ffe_ctl->found_offset = start + block_group->alloc_offset;
+	block_group->alloc_offset += num_bytes;
+	spin_lock(&ctl->tree_lock);
+	ctl->free_space -= num_bytes;
+	spin_unlock(&ctl->tree_lock);
+
+	ASSERT(IS_ALIGNED(ffe_ctl->found_offset,
+			  block_group->fs_info->stripesize));
+	ffe_ctl->search_start = ffe_ctl->found_offset;
+
+out:
+	spin_unlock(&block_group->lock);
+	spin_unlock(&space_info->lock);
+	return ret;
+}
+
 static int do_allocation(struct btrfs_block_group *block_group,
 			 struct find_free_extent_ctl *ffe_ctl,
 			 struct btrfs_block_group **bg_ret)
@@ -3671,6 +3721,8 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	switch (ffe_ctl->policy) {
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
 		BUG();
 	}
@@ -3685,6 +3737,9 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		ffe_ctl->retry_clustered = false;
 		ffe_ctl->retry_unclustered = false;
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3713,6 +3768,9 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		found_extent_clustered(ffe_ctl, ins);
 		break;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		break;
 	default:
 		BUG();
 	}
@@ -3728,6 +3786,9 @@ static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
 		 */
 		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
 		return 0;
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* give up here */
+		return -ENOSPC;
 	default:
 		BUG();
 	}
@@ -3896,6 +3957,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_CLUSTERED:
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
+	case BTRFS_EXTENT_ALLOC_ZONED:
+		/* nothing to do */
+		return 0;
 	default:
 		BUG();
 	}
@@ -3958,6 +4022,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.last_ptr = NULL;
 	ffe_ctl.use_cluster = true;
 
+	if (btrfs_fs_incompat(fs_info, ZONED))
+		ffe_ctl.policy = BTRFS_EXTENT_ALLOC_ZONED;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -4100,20 +4167,23 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		/* move on to the next group */
 		if (ffe_ctl.search_start + num_bytes >
 		    block_group->start + block_group->length) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    num_bytes);
 			goto loop;
 		}
 
 		if (ffe_ctl.found_offset < ffe_ctl.search_start)
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-				ffe_ctl.search_start - ffe_ctl.found_offset);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    ffe_ctl.search_start - ffe_ctl.found_offset);
 
 		ret = btrfs_add_reserved_bytes(block_group, ram_bytes,
 				num_bytes, delalloc);
 		if (ret == -EAGAIN) {
-			btrfs_add_free_space(block_group, ffe_ctl.found_offset,
-					     num_bytes);
+			btrfs_add_free_space_unused(block_group,
+						    ffe_ctl.found_offset,
+						    num_bytes);
 			goto loop;
 		}
 		btrfs_inc_block_group_reservations(block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7701b39b4d57..2df8ffd1ef8b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2906,6 +2906,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 align_gap_len = 0;
 	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, ZONED));
+
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
 				block_group->full_stripe_len, max_extent_size);
@@ -3037,6 +3039,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	struct rb_node *node;
 	u64 ret = 0;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, ZONED));
+
 	spin_lock(&cluster->lock);
 	if (bytes > cluster->max_size)
 		goto out;
@@ -3813,6 +3817,8 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	int ret;
 	u64 rem = 0;
 
+	ASSERT(!btrfs_fs_incompat(block_group->fs_info, ZONED));
+
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-- 
2.27.0

