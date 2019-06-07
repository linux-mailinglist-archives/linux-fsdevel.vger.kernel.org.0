Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D038B83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfFGNSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56479 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfFGNSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913533; x=1591449533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mupKjZhti+RJeT5nPjQ1XsnqAXflA8i/lJpWsbDUs5g=;
  b=q8ust0ihOp3oa1FRY4OOh0eNdCI2fpU69P3F5W171ZA7MHgUpA7X8W74
   oLRJ93xnAz+MjVdC/RW4Dbm7VJVLaNCA05vQJY5+o9y1mH1e9GAdwEQ6h
   jOtay/WzqvUf+EfJ/mMd18scRurQOf9DULxUXIJVIx/loEvH0CTecS/qD
   vpPtMNXOq2dpAOVZmGHbHvaKDL0ZvczFF1Kj73zQbDjdtynCtuKmOoz/Q
   ai6BxHJf+JeGtmTx+Sjsf6Gf+QdMtPTEqAt6Z+bwKSzDGReglA0qtDQNc
   /HJeXaqVU1KPm2sZqBcr228TjKPR7Fbm0PYrduydFb0JK4Fa/S4NbNeSa
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675016"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:53 +0800
IronPort-SDR: QL7PSejTigskEbVuyqF3ANhyCwH4qzVUVF3d19D7iq8Kcxjrw7GYB+ulxgmzLHDyag5rzPGi/5
 V/E8END2kTUagitlIY13yFx/fRyXxq8T4kHzz6uKZ7pbOQzlNyED4sQh9wEVCHoogq9Ofm8PIZ
 EEgQTnUU0cUWfyDTM2hukuiFMZExdUocW6u42eX1BKNKUc5xtbVUFfO6Y8oIN4BtSJpXC+vCF7
 KtFQsyoW0UT4nF4SLxuSESWmDNyIi4fogfZvPPLyEC0qCbnSceSwMIaGCxxMYXpN18eyIQx1CI
 tWFq097EcXeHtBRBgUELnkRb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:35 -0700
IronPort-SDR: 9McBzwsmq/zufQcdeMvV/PRCGlDdl9a1nWqwfshZWXCEIRHBBCf+LvqkEO6pMUZKolgqHv+YS6
 +kQp3uUEVlBkLbCAp5qqM/VSPsq5B1aF2OZbdBlo92ktrrZdA5bIusVhUBglfr8jWk/WYoggi+
 ZUMrMm6j268gw7VxbMjegABSrkyZNdwVgfCde9UvGwFPYUPTOcl+78+vabUpN65eN8L6nHGnpm
 M84zKrlOXuOSD2z+3ycyNeIjzrSZpY/NXF8CFw2CrV2LYi+c0J8ebL2mxqU5S6hj397Nf2Pt7Q
 bhQ=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:17 -0700
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
Subject: [PATCH 08/12] btrfs-progs: volume: align chunk allocation to zones
Date:   Fri,  7 Jun 2019 22:17:47 +0900
Message-Id: <20190607131751.5359-8-naohiro.aota@wdc.com>
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

To facilitate support for zoned block devices in the extent buffer
allocation, a zoned block device chunk is always aligned to a zone of the
device. With this, the zone write pointer location simply becomes a hint to
allocate new buffers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 volumes.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/volumes.c b/volumes.c
index f6d1b1e9dc7f..64b42643390b 100644
--- a/volumes.c
+++ b/volumes.c
@@ -399,6 +399,34 @@ int btrfs_scan_one_device(int fd, const char *path,
 	return ret;
 }
 
+/* zone size is ensured to be power of 2 */
+static u64 btrfs_zone_align(struct btrfs_zone_info *zinfo, u64 val)
+{
+	if (zinfo && zinfo->zone_size)
+		return (val + zinfo->zone_size - 1) & ~(zinfo->zone_size - 1);
+	return val;
+}
+
+static bool check_dev_zone(struct btrfs_zone_info *zinfo, u64 physical,
+			   u64 num_bytes)
+{
+	u64 zone_size = zinfo->zone_size;
+	int zone_is_random;
+
+	WARN_ON(!IS_ALIGNED(num_bytes, zone_size));
+	zone_is_random = zone_is_random_write(zinfo, physical);
+
+	while (num_bytes) {
+		if (zone_is_random != zone_is_random_write(zinfo, physical))
+			return false;
+
+		physical += zone_size;
+		num_bytes -= zone_size;
+	}
+
+	return true;
+}
+
 /*
  * find_free_dev_extent_start - find free space in the specified device
  * @device:	  the device which we search the free space in
@@ -428,6 +456,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	struct btrfs_root *root = device->dev_root;
 	struct btrfs_dev_extent *dev_extent;
 	struct btrfs_path *path;
+	struct btrfs_zone_info *zinfo = &device->zinfo;
 	u64 hole_size;
 	u64 max_hole_start;
 	u64 max_hole_size;
@@ -445,6 +474,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	 */
 	min_search_start = max(root->fs_info->alloc_start, (u64)SZ_1M);
 	search_start = max(search_start, min_search_start);
+	search_start = btrfs_zone_align(zinfo, search_start);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -497,6 +527,18 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 			goto next;
 
 		if (key.offset > search_start) {
+			if (zinfo && zinfo->zone_size) {
+				while (key.offset > search_start) {
+					hole_size = key.offset - search_start;
+					if (hole_size < num_bytes)
+						break;
+					if (check_dev_zone(zinfo, search_start,
+							   num_bytes))
+						break;
+					search_start += zinfo->zone_size;
+				}
+			}
+
 			hole_size = key.offset - search_start;
 
 			/*
@@ -527,7 +569,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		extent_end = key.offset + btrfs_dev_extent_length(l,
 								  dev_extent);
 		if (extent_end > search_start)
-			search_start = extent_end;
+			search_start =  btrfs_zone_align(&device->zinfo,
+							 extent_end);
 next:
 		path->slots[0]++;
 		cond_resched();
@@ -539,6 +582,18 @@ next:
 	 * search_end may be smaller than search_start.
 	 */
 	if (search_end > search_start) {
+		if (zinfo && zinfo->zone_size) {
+			while (search_end > search_start) {
+				hole_size = search_end - search_start;
+				if (hole_size < num_bytes)
+					break;
+				if (check_dev_zone(zinfo, search_start,
+						   num_bytes))
+					break;
+				search_start += zinfo->zone_size;
+			}
+		}
+
 		hole_size = search_end - search_start;
 
 		if (hole_size > max_hole_size) {
@@ -582,6 +637,9 @@ int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 
+	/* Align to zone for a zoned block device */
+	start = btrfs_zone_align(&device->zinfo, start);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -1065,9 +1123,15 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 				    btrfs_super_stripesize(info->super_copy));
 	}
 
-	/* we don't want a chunk larger than 10% of the FS */
-	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
-	max_chunk_size = min(percent_max, max_chunk_size);
+	if (info->fs_devices->hmzoned) {
+		/* Zoned mode uses zone aligned chunks */
+		calc_size = info->fs_devices->zone_size;
+		max_chunk_size = calc_size * num_stripes;
+	} else {
+		/* we don't want a chunk larger than 10% of the FS */
+		percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
+		max_chunk_size = min(percent_max, max_chunk_size);
+	}
 
 again:
 	if (chunk_bytes_by_type(type, calc_size, num_stripes, sub_stripes) >
@@ -1147,7 +1211,9 @@ again:
 	*num_bytes = chunk_bytes_by_type(type, calc_size,
 					 num_stripes, sub_stripes);
 	index = 0;
+	dev_offset = 0;
 	while(index < num_stripes) {
+		size_t zone_size = device->zinfo.zone_size;
 		struct btrfs_stripe *stripe;
 		BUG_ON(list_empty(&private_devs));
 		cur = private_devs.next;
@@ -1158,11 +1224,16 @@ again:
 		    (index == num_stripes - 1))
 			list_move_tail(&device->dev_list, dev_list);
 
+		if (device->zinfo.zone_size)
+			calc_size = device->zinfo.zone_size;
+
 		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
 			     calc_size, &dev_offset);
 		if (ret < 0)
 			goto out_chunk_map;
 
+		WARN_ON(zone_size && !IS_ALIGNED(dev_offset, zone_size));
+
 		device->bytes_used += calc_size;
 		ret = btrfs_update_device(trans, device);
 		if (ret < 0)
-- 
2.21.0

