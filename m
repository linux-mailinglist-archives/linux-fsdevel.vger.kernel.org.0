Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB450266759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIKRmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38375 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgIKMkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828017; x=1631364017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKSnidCJQqviGjW0MLEa/94LIClq0cu6k26aWPVEoTo=;
  b=qjxmLkRATnhLJY9Z/I/+HQcN/zdUkcD7PzBKfM+P4h/Glu0E0IVY8wZt
   2KwgQKUp/TgMd7D6EU+ECMpuQnCtS2xMNm3jOJvuR5DV9zK+wQIKlCSTR
   Amn2aoBtnX/ckTX4k7unhc4fOqBAEbIhpv5M/kxyxNS1+HOdl5OKeoaJV
   dzseJ06DxPnaJ+ptyqEpg8p6957h1i2VAWDRNPYAIeOA31O4AZi6yv95E
   wsFbWzH+CPYmTVUTkBNpIddoIyi3FDAWQHQeVhowqA171zaq5XGJxwqs9
   lqPGSXT1z0t1kA/YC/u7fY490E9tunB1KDvLKhfFMubxUCdHnmiJUfgmU
   g==;
IronPort-SDR: lKe+iYgEvYt1nVQAcIAa8ey0vZ/6sTpTugCkEGZAw1e5tJYEFAwRLyYqYQR8lZVz98AlVqQw3H
 YS+txoiGEtkULpt+261/8sJXVDsuIqK1OpueVc3bl5KqgIjxrT8XVq+CJun1TpmS+m7e0JriKs
 QyoOOb2eNoEOAVbOLw8LDaau87hbYJSEtiYi9uOuEu2Bj0T6SldpDrfXgd1XLyQ64tJz/SBY2k
 Gii1M7UuCPTE8IZrtYmjMv2vn84vCj9WW3OgQwDb+rf/HzzF4yXJ2McXCBd6FiH62NvHxuMfMZ
 eyU=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126024"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:51 +0800
IronPort-SDR: xOsLGngYCT42C/LsIj3DPD2nfmccKAP97shMwJOxenAvUCs+2QD6zajvgm1ArULCpg6zGOgS6o
 GrQ8RfZNAXMw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:12 -0700
IronPort-SDR: Usi2h86qrJ7WSvOAgGm9FRMd+5oVd5TUhGgaSjrd1CKH3emhoPz3fDvyIEPP4SvNb5OfTwawy3
 NDSz279MaG7A==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 30/39] btrfs: implement cloning for ZONED device-replace
Date:   Fri, 11 Sep 2020 21:32:50 +0900
Message-Id: <20200911123259.3782926-31-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 81b9b58d7a9d..79ac8fcc5c35 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -35,6 +35,7 @@
 #include "discard.h"
 #include "rcu-string.h"
 #include "zoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1322,6 +1323,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1330,15 +1333,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
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
index ca139c63f63c..779ee0452c1b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5971,9 +5971,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
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
@@ -5986,6 +6006,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6381,8 +6410,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0f790f3a54e5..2fe659bb0709 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -19,6 +19,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -903,6 +904,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -929,6 +932,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
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

