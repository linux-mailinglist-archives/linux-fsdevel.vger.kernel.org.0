Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D438B3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfFGNMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:12:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGNLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913085; x=1591449085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=On1HhV87QhFcsITaz2WTpH7k8b/z+/zuwRi+IH2xmYU=;
  b=DaluEIRL7XQlWU2c1AUm2B4VV0whW5HiYCPx94p9IA72BRa4hzGH9QVn
   8XpAiiinqd8M8Iv1P2I2JjOSZRk85r470CWfIjExOgbG6D2MEW/8nWU2x
   A76P6f5U8nPeFyTVYnlwaP87TF+Yp8dOxw22b3/rQXBffUC316bc1/QJ2
   e6FojHoTANqC96FS9oTOO8vDu5pFaaHjxLMkcrDpRzQNm0tQQrcXaND+n
   VzwYG1Kfay6Yhr1wf4gxqNk1D9P/O10Nb/lMiIJx/swcSHNeh/nsW4MB4
   jBrX7VzE5H7VUqlvDe6Opx4rTKniln1YqSMXNi5wNuNjMx0jHO5QNPD7J
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027793"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:25 +0800
IronPort-SDR: 8IFnJmrUH3mSgTLqJpcVLmTMLhcOkUzWGzi+GSodyA5RwZqqik11peGUAl/xCrw7TQCSA24Msn
 O3gPkf3mYa8QkbxXz2F585pDhvneAwPV/DnH88CfcZfRe3moI5jsxfx7Met+OlwKx+WTZdbz/z
 unrIM481Aa8P2tcUQJYNgAXO0KE6nCSdezBZkhTwybLWCjGTJtqSo5jamX99xLh97PweuEwCzy
 9ebjPLFVy7I8DM3dy4DYmiQ4zec89J28G1QyaRUj5CNjpZugRaROi3Nka1xBCUol8SX/nlu/yh
 ShfIwDjsyDH2/oLcZGC+MzKu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:42 -0700
IronPort-SDR: oasUBg4Wvxp0weaeUclGaB4/Pz8g3U0Tuw1WPIpINufJpmT95434UXbvY1WFw6A/oyHkh5yqdY
 Wi7CKrX+XF+q7bCUDfnfKd9P6TBUJMHFSg7q1edbZ7IKrob24fJPYFiYwEqgCKAuNNFc5OTZSr
 Myv7YR6lY1CKl6Yp2wjte0z4AdeeasBWpD/sK/5yCDE5n3GaQVNBx2apOy3pSYQcN4yzswtY+a
 4GqiBLKCZfp7gqFB/bp7ilRod+olV2knCGGHv8JnojP7h24nwPac/Dldfp7lu5OvFHvhyYRDPx
 T+w=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:23 -0700
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
Subject: [PATCH 06/19] btrfs: align dev extent allocation to zone boundary
Date:   Fri,  7 Jun 2019 22:10:12 +0900
Message-Id: <20190607131025.31996-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In HMZONED mode, align the device extents to zone boundaries so that a zone
reset affects only the device extent and does not change the state of
blocks in the neighbor device extents. Also, check that a region allocation
is always over empty same-type zones.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c |   6 +++
 fs/btrfs/volumes.c     | 100 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1aee51a9f3bf..363db58f56b8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9884,6 +9884,12 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
 		min_free = div64_u64(min_free, dev_min);
 	}
 
+	/* We cannot allocate size less than zone_size anyway */
+	if (index == BTRFS_RAID_DUP)
+		min_free = max_t(u64, min_free, 2 * fs_info->zone_size);
+	else
+		min_free = max_t(u64, min_free, fs_info->zone_size);
+
 	mutex_lock(&fs_info->chunk_mutex);
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
 		u64 dev_offset;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b6f367d19dc9..c1ed3b6e3cfd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1737,6 +1737,46 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
+static u64 dev_zone_align(struct btrfs_device *device, u64 pos)
+{
+	if (device->zone_size)
+		return ALIGN(pos, device->zone_size);
+	return pos;
+}
+
+/*
+ * is_allocatable_region - check if spcecifeid region is suitable for allocation
+ * @device:	the device to allocate a region
+ * @pos:	the position of the region
+ * @num_bytes:	the size of the region
+ *
+ * In non-ZONED device, anywhere is suitable for allocation. In ZONED
+ * device, check if the region is not on non-empty zones. Also, check if
+ * all zones in the region have the same zone type.
+ */
+static bool is_allocatable_region(struct btrfs_device *device, u64 pos,
+				  u64 num_bytes)
+{
+	int is_sequential;
+
+	if (device->zone_size == 0)
+		return true;
+
+	WARN_ON(!IS_ALIGNED(pos, device->zone_size));
+	WARN_ON(!IS_ALIGNED(num_bytes, device->zone_size));
+
+	is_sequential = btrfs_dev_is_sequential(device, pos);
+
+	while (num_bytes > 0) {
+		if (!btrfs_dev_is_empty_zone(device, pos) ||
+		    (is_sequential != btrfs_dev_is_sequential(device, pos)))
+			return false;
+		pos += device->zone_size;
+		num_bytes -= device->zone_size;
+	}
+
+	return true;
+}
 
 /*
  * find_free_dev_extent_start - find free space in the specified device
@@ -1779,9 +1819,14 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 	/*
 	 * We don't want to overwrite the superblock on the drive nor any area
 	 * used by the boot loader (grub for example), so we make sure to start
-	 * at an offset of at least 1MB.
+	 * at an offset of at least 1MB on a regular disk. For a zoned block
+	 * device, skip the first zone of the device entirely.
 	 */
-	search_start = max_t(u64, search_start, SZ_1M);
+	if (device->zone_size)
+		search_start = max_t(u64, dev_zone_align(device, search_start),
+				     device->zone_size);
+	else
+		search_start = max_t(u64, search_start, SZ_1M);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1846,12 +1891,22 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 			 */
 			if (contains_pending_extent(device, &search_start,
 						    hole_size)) {
+				search_start = dev_zone_align(device,
+							      search_start);
 				if (key.offset >= search_start)
 					hole_size = key.offset - search_start;
 				else
 					hole_size = 0;
 			}
 
+			if (!is_allocatable_region(device, search_start,
+						   num_bytes)) {
+				search_start = dev_zone_align(device,
+							      search_start+1);
+				btrfs_release_path(path);
+				goto again;
+			}
+
 			if (hole_size > max_hole_size) {
 				max_hole_start = search_start;
 				max_hole_size = hole_size;
@@ -1876,7 +1931,7 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 		extent_end = key.offset + btrfs_dev_extent_length(l,
 								  dev_extent);
 		if (extent_end > search_start)
-			search_start = extent_end;
+			search_start = dev_zone_align(device, extent_end);
 next:
 		path->slots[0]++;
 		cond_resched();
@@ -1891,6 +1946,14 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 		hole_size = search_end - search_start;
 
 		if (contains_pending_extent(device, &search_start, hole_size)) {
+			search_start = dev_zone_align(device,
+						      search_start);
+			btrfs_release_path(path);
+			goto again;
+		}
+
+		if (!is_allocatable_region(device, search_start, num_bytes)) {
+			search_start = dev_zone_align(device, search_start+1);
 			btrfs_release_path(path);
 			goto again;
 		}
@@ -5177,6 +5240,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	int hmzoned = btrfs_fs_incompat(info, HMZONED);
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -5221,10 +5285,20 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		BUG();
 	}
 
+	if (hmzoned) {
+		max_stripe_size = info->zone_size;
+		max_chunk_size = round_down(max_chunk_size, info->zone_size);
+	}
+
 	/* We don't want a chunk larger than 10% of writable space */
 	max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
 			     max_chunk_size);
 
+	if (hmzoned)
+		max_chunk_size = max(round_down(max_chunk_size,
+						info->zone_size),
+				     info->zone_size);
+
 	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
 			       GFP_NOFS);
 	if (!devices_info)
@@ -5259,6 +5333,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (total_avail == 0)
 			continue;
 
+		if (hmzoned && total_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		ret = find_free_dev_extent(device,
 					   max_stripe_size * dev_stripes,
 					   &dev_offset, &max_avail);
@@ -5277,6 +5354,9 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
+		if (hmzoned && max_avail < max_stripe_size * dev_stripes)
+			continue;
+
 		if (ndevs == fs_devices->rw_devices) {
 			WARN(1, "%s: found more than %llu devices\n",
 			     __func__, fs_devices->rw_devices);
@@ -5310,6 +5390,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 
 	ndevs = min(ndevs, devs_max);
 
+again:
 	/*
 	 * The primary goal is to maximize the number of stripes, so use as
 	 * many devices as possible, even if the stripes are not maximum sized.
@@ -5333,6 +5414,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * we try to reduce stripe_size.
 	 */
 	if (stripe_size * data_stripes > max_chunk_size) {
+		if (hmzoned) {
+			/*
+			 * stripe_size is fixed in HMZONED. Reduce ndevs
+			 * instead.
+			 */
+			WARN_ON(nparity != 0);
+			ndevs = div_u64(max_chunk_size * ncopies,
+					stripe_size * dev_stripes);
+			goto again;
+		}
+
 		/*
 		 * Reduce stripe_size, round it up to a 16MB boundary again and
 		 * then use it, unless it ends up being even bigger than the
@@ -5346,6 +5438,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	/* align to BTRFS_STRIPE_LEN */
 	stripe_size = round_down(stripe_size, BTRFS_STRIPE_LEN);
 
+	WARN_ON(hmzoned && stripe_size != info->zone_size);
+
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
 		ret = -ENOMEM;
-- 
2.21.0

