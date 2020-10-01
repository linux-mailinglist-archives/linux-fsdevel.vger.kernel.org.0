Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4E2806EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbgJASjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgJASjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577543; x=1633113543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nL9Fc9WGfI7JmFd2yFwmGohr+9ZRNKakMbaYwBZP3M4=;
  b=LbqkXs8wlgQ5R75ZweaFwVeeFq2TPDD7eAUHDIjXOggr0HZZkOyqMnkI
   HF4HEf6OaeLZ9TMyUl4l2dxy94EJ30t2HSumpx2lXab+EKNSafg7hXMkc
   yE+vxzm6HlizPT36q8nu3z6KhbURlQ5bj3RyCkXogklLtxwzgugDozuzn
   nahoccZUvBuxHfqKHf1Bu18WnDj/gwZXmzTXDyxnWGFI9A1os0RRWrtZ9
   zMURWo+ar5r3Oa3F34HWDC8zBW926TuuRBc4FiLYUyLpAceOXoeyqS2Wi
   ao0LSKZNehHM6IwFq0l+GZzEGpbaAh5UJtMqYXzHTKdlwqDb0ddQTvxZp
   g==;
IronPort-SDR: 88X4xiX2dejCLJE1xxBfN/5T9V9hclIjVCr73Fbt1YQhiFKRS7vpgDbEXXVB0ns+FcD9+guX+P
 yC6UQE8NLYwgC3uaDR3gHNGj2rL+mDo1eoFSMJkrRFz+d8k+XUAilxqCTnWbjZZU4lihIZUpyj
 DJe1hE2D58scCC/syzLd7om25UI1j6e246VFicMOe+IhIGUADJZD84uYCZo/BieujInNIyM7Jg
 wc+w56H5HnFydcZ0+XE19nzsVWLtoNoQ1Ef8yjsQ6Te8fh2cYIxFCBIsOovbG3Ocx/Lv82DjQz
 4HA=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036828"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:39 +0800
IronPort-SDR: BAEdnzlrn5XZeoQJVRIvC+TpWOCGHY7Mcv2Mk7FFdz9JEG/50qlcqwQPQYfebQDcLBxYfZAB9N
 bBgHccY/QUsA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:36 -0700
IronPort-SDR: MG6yF5uUWI8d6ZiNhRjQuWFu9MpbhKpCsBngh3Z42sCJ9zZ+MJ9Wn5PLBG/khPQDdU5pk8DTkz
 CMT9Mga2RE/A==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 32/41] btrfs: implement cloning for ZONED device-replace
Date:   Fri,  2 Oct 2020 03:36:39 +0900
Message-Id: <c39a5cd7380c8b6e59417cc80294ce808c016e8e.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 2/4 patch to implement device-replace for ZONED mode.

On zoned mode, a block group must be either copied (from the source device
to the destination device) or cloned (to the both device).

This commit implements the cloning part. If a block group targeted by an IO
is marked to copy, we should not clone the IO to the destination device,
because the block group is eventually copied by the replace process.

This commit also handles cloning of device reset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/volumes.c     | 33 +++++++++++++++++++++++++++++++--
 fs/btrfs/zoned.c       | 11 +++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c0e4a577c61c..f44faaf7aca2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1336,6 +1337,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1344,15 +1347,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 			req_q = bdev_get_queue(stripe->dev->bdev);
 			/* zone reset in ZONED mode */
-			if (btrfs_can_zone_reset(dev, physical, length))
+			if (btrfs_can_zone_reset(dev, physical, length)) {
 				ret = btrfs_reset_device_zone(dev, physical,
 							      length, &bytes);
-			else if (blk_queue_discard(req_q))
+				if (ret)
+					goto next;
+				if (!btrfs_dev_replace_is_ongoing(
+					    dev_replace) ||
+				    dev != dev_replace->srcdev)
+					goto next;
+
+				discarded_bytes += bytes;
+				/* send to replace target as well */
+				ret = btrfs_reset_device_zone(
+					dev_replace->tgtdev,
+					physical, length, &bytes);
+			} else if (blk_queue_discard(req_q))
 				ret = btrfs_issue_discard(dev->bdev, physical,
 							  length, &bytes);
 			else
 				continue;
 
+next:
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 924ba96dc8fa..af2ed4d3389f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5965,9 +5965,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+	bool ret;
+
+	/* non-ZONED mode does not use "to_copy" flag */
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return false;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+
+	spin_lock(&cache->lock);
+	ret = cache->to_copy;
+	spin_unlock(&cache->lock);
+
+	btrfs_put_block_group(cache);
+	return ret;
+}
+
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      struct btrfs_bio **bbio_ret,
 				      struct btrfs_dev_replace *dev_replace,
+				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
 	struct btrfs_bio *bbio = *bbio_ret;
@@ -5980,6 +6000,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	if (op == BTRFS_MAP_WRITE) {
 		int index_where_to_add;
 
+		/*
+		 * a block group which have "to_copy" set will
+		 * eventually copied by dev-replace process. We can
+		 * avoid cloning IO here.
+		 */
+		if (is_block_group_to_copy(dev_replace->srcdev->fs_info,
+					   logical))
+			return;
+
 		/*
 		 * duplicate the write operations while the dev replace
 		 * procedure is running. Since the copying of the old disk to
@@ -6375,8 +6404,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 57bd6dbd8f45..f10cc5f49962 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -17,6 +17,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -892,6 +893,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -918,6 +921,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		 */
 		btrfs_dev_clear_zone_empty(device, physical);
 
+		down_read(&dev_replace->rwsem);
+		dev_replace_is_ongoing =
+			btrfs_dev_replace_is_ongoing(dev_replace);
+		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev,
+						   physical);
+		up_read(&dev_replace->rwsem);
+
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
-- 
2.27.0

