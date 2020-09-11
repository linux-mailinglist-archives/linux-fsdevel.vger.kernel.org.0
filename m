Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE78D266778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgIKRnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:43:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgIKMgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827760; x=1631363760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbmbgVqmxW0JeqvL4wMgkAVAzhmn/HJp2we2iWZC6rE=;
  b=lDfNTXeeOrmJv6Qeqzj/WvYC6Q6gyYXn/h7UAZhEOPzzdJPWtaWodDkL
   RVMdF28y0VdtYk+4Kp3jrHF6ZJYcf5/OpGgaDgloEBTOMFKZLTaDloz4x
   uP8BgS6oM/qaB6a8NFiJcOO08u/0VOMMXkMnrHhOLShBoe5b1IzXXXcbm
   ocDipu+zjt1fzjeLpG37epS85QufRSqv9BG0Zdv9h+q/MDPBdYBizeNmr
   MiJjqhTZGnox+ekIKMxKXIhSvH7EXFJhFX9bfxzkGzkH7U2XIbbtIXPDH
   pl3fqQXSoSKTLriX1wPIfCA3e1xpb+VmDqXUttF5mpVEbZ4Jmhc/yEIdB
   A==;
IronPort-SDR: jinznpqEbUOEWPgyeGboIysqvMu/br/OJpRdNXXhXv3NXYWgFFI2+Npz2uEBC7nEeUQ/I/0RpD
 ZNrjC6KvV1kS6MXe72cGho9kAIU800YR1/O6dW4geqZAfAHes2bMrsMcIQmiHYSGPp3DFshyI2
 9o33giMcY94GfjlzNcj9R6TbLfR7m56ajZiysucE+S9ITWDhQn4m35gI8FR88Bl7iYnRCkg3i2
 rlGF+CBiE8hiWJP4Ynv1Uy0aSV+l7KVKE1+qA2GdcHo2uAphl6eboj+qJ5vrqzf7d/67FFMH/G
 Elg=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125985"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:28 +0800
IronPort-SDR: Jsh7kdUNperrM96bbfOp1TsNY8adoQPWOmWSnnQEGrEhQkMg0ZNq80KujrAJxusojThcbd6vH0
 gv2IHRV5q4bA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:49 -0700
IronPort-SDR: xJL6eNhJG/HyZytgjmGx8Gw61wQlhwHifSXa4lkRA3DLLPlpuH7Y/ck7FYANaKkNI9yTvzQ4dA
 uHGh3l/6CE0Q==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 14/39] btrfs: emulate write pointer for conventional zones
Date:   Fri, 11 Sep 2020 21:32:34 +0900
Message-Id: <20200911123259.3782926-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index cc6bc45729b4..ca090a5cdc6e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -753,6 +753,104 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
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
@@ -767,6 +865,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_fs_incompat(fs_info, ZONED))
@@ -867,12 +966,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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
@@ -894,6 +993,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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

