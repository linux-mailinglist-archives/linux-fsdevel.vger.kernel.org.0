Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC42806DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgJASiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgJASii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577518; x=1633113518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70huaWDX98UzfF79GMzQzDz1K+t8l0FjZgA50bJ/GYI=;
  b=Y2JJn5IqS0HRQsjJNgXhiqk6uHWE13q8v3wnjC314lQ1jBSlnEkk28Rq
   0cLjmhIrcEKU+PAwJOkQTc99c7Vs45/i22oKloFR0OEOHbzUsb8/gMVdT
   aIsZZ3hPTmNpzRtL2HA4puDYuhoPmJfYO5kEXuNixSSP7wR6gs0r7xIIF
   Ad/3HXzaPb9SPY2AnVCxBkPKo0akK8n2mSDn1k8cquyodHKT30Annr7MR
   VpbYMUpIURFdtGiMQjbeSpGeTKrryO0/FqsqHiCnR+2pNmI4U2mwX1n+q
   UCK3hVfgJM0KA8kc+InP6Hze6zkacGcRNJTNWhyg34FzV73Y+D1Sjk0R0
   w==;
IronPort-SDR: heP25J9XF5+q2jcgRCK/2tYfYJVVGVeBmqrFsi6M0mOU3NYwiWbQMNsUj1yb0VCAcPk/wpJZ9S
 9nG6nVsiA+492i2gMWr6ItP9C+va10njWUoe+WjTPiZLvyoxmvtbCKGMaBjDacmLYGPAZLRQRk
 xEyuqvNxgsJ1GgexLzcjSwC0hN0CYW34MzCne4c09kxRpPuoHjuZ6afkQSOWSvRdHpi+vEa+oB
 qzneLb/WXD/Mzyvahgw/j7HlOj5+HKlBE3eIfdiV9wcOfL5PskcsKb1yDXzRV0MorVivwAVQYw
 DaE=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:19 +0800
IronPort-SDR: tHsrkk+tiFRskOdHUu7eHQqbu6Hkmwp07Gy4tpycOqRttBkvbEINaV5UmayP8Ob1W9u46WStUS
 ZDpwdq8xFT6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:16 -0700
IronPort-SDR: XX39Q6I4OcTGB6pLfxNwA032JYVjh3rW4EjlS2yXoTxRbYqJuQbnfx5mOFYccWOy3/dHY3hPN1
 6CtPvu0t58PA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:18 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 15/41] btrfs: emulate write pointer for conventional zones
Date:   Fri,  2 Oct 2020 03:36:22 +0900
Message-Id: <62d6c1774cf7ecffeacd66caec23d96dd4fdd70a.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conventional zones do not have a write pointer. So, we cannot use it to
determine the allocation offset if a block group contains a conventional
zone. Instead, we can consider the end of the last allocated extent int the
block group as an allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 33853f4d5a8b..3f65da0c4942 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -742,6 +742,104 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
+static int emulate_write_pointer(struct btrfs_block_group *cache,
+				 u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	int slot;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = cache->start + cache->length;
+	search_key.type = 0;
+	search_key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	ASSERT(ret != 0);
+	slot = path->slots[0];
+	leaf = path->nodes[0];
+	ASSERT(slot != 0);
+	slot--;
+	btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+	if (found_key.objectid < cache->start) {
+		*offset_ret = 0;
+	} else if (found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		struct btrfs_key extent_item_key;
+
+		if (found_key.objectid != cache->start) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		length = 0;
+
+		/* metadata may have METADATA_ITEM_KEY */
+		if (slot == 0) {
+			btrfs_set_path_blocking(path);
+			ret = btrfs_prev_leaf(root, path);
+			if (ret < 0)
+				goto out;
+			if (ret == 0) {
+				slot = btrfs_header_nritems(leaf) - 1;
+				btrfs_item_key_to_cpu(leaf, &extent_item_key,
+						      slot);
+			}
+		} else {
+			btrfs_item_key_to_cpu(leaf, &extent_item_key, slot - 1);
+			ret = 0;
+		}
+
+		if (ret == 0 &&
+		    extent_item_key.objectid == cache->start) {
+			if (extent_item_key.type == BTRFS_METADATA_ITEM_KEY)
+				length = fs_info->nodesize;
+			else if (extent_item_key.type == BTRFS_EXTENT_ITEM_KEY)
+				length = extent_item_key.offset;
+			else {
+				ret = -EUCLEAN;
+				goto out;
+			}
+		}
+
+		*offset_ret = length;
+	} else if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
+		   found_key.type == BTRFS_METADATA_ITEM_KEY) {
+
+		if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+			length = found_key.offset;
+		else
+			length = fs_info->nodesize;
+
+		if (!(found_key.objectid >= cache->start &&
+		       found_key.objectid + length <=
+		       cache->start + cache->length)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		*offset_ret = found_key.objectid + length - cache->start;
+	} else {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -756,6 +854,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_fs_incompat(fs_info, ZONED))
@@ -856,12 +955,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 	if (num_conventional > 0) {
-		/*
-		 * Since conventional zones does not have write pointer, we
-		 * cannot determine alloc_offset from the pointer
-		 */
-		ret = -EINVAL;
-		goto out;
+		ret = emulate_write_pointer(cache, &emulated_offset);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = emulated_offset;
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -883,6 +982,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 out:
+	/* an extent is allocated after the write pointer */
+	if (num_conventional && emulated_offset > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, emulated_offset, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
-- 
2.27.0

