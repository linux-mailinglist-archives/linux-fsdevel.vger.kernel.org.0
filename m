Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D244266761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIKRmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgIKMkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828017; x=1631364017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMz7+myZMpHXv+TqaDSg+IRlaO1Dux1SprQ8ZqsYWqY=;
  b=Er0UYca0/OPVpqjcS6FHiuZMz90rihQBKVz+7m4lw8h5r/IW+bHRLf+s
   r9ZfdEa3d/28ogGI5KWYwZJWe+UkcTLJDi5wGb7qtfI4Cmq1iiZPX/RCa
   Lp+QFCeXTXrm2iH3Z3WAQAF+dtOm3vA1m0X54DL1Xj6pEI7I2yL642E68
   eX2kVYLXeqsK5MF4G6/njtTOFMNjuVEav1Rmt6B544ESaTloWkIfKPWp8
   JJOzeCfHWLqQ8sHCcKd0M79EF3hQ+ZpXvB6xBiQlybFQjlov4fvXOIznf
   Rg9VIbpZG3OeL2/99cygcWGXAUj/eAXOUogkwmv4OheAW1r6UeZOxeI25
   g==;
IronPort-SDR: 6oFxab158RDWmY05/9nhwfD346W5F0MDFjrPZOUuXy5fn5kVvw0LkeV7B71Qexu6KSzRA0noS+
 Pt5+qquUH/TzyPsTHM2mki0ESLllL2zzKAVRWaKAiCC381okF+imV5kQ6PAbQObO8LH2BXKpym
 YCvlwVGfiteESZBVYsOOWF3YXVYgk/IP/uk5DT7InExqNxeNaAQWOYe4mWx4kGhlR4NLoCg5T5
 Xvp3RME+8pcz5AExn+8tQM5L3ZQl+ogOETgjNn8yXOfLwJWE0vlk88Qa9ePgiFHOXrC9g0/EGV
 Y8c=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:52 +0800
IronPort-SDR: BjcBFY6tbv8fUrdjxKtbIzpgTEr9K7pNYHWKISi2Fv0kcg1a894XmmIfe54eIhJUCFYppgumY6
 02ZRyt13yTsA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:13 -0700
IronPort-SDR: EEvLqJWsyoBh8gxGmLjK+xrbKh1DH7c64EKAY4g7SrfLGVSxMNn04jECHsOZbBHSe2XOe4pREN
 09JbDJZGauyQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 31/39] btrfs: implement copying for ZONED device-replace
Date:   Fri, 11 Sep 2020 21:32:51 +0900
Message-Id: <20200911123259.3782926-32-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 3/4 patch to implement device-replace on ZONED mode.

This commit implement copying. So, it track the write pointer during device
replace process. Device-replace's copying is smart to copy only used
extents on source device, we have to fill the gap to honor the sequential
write rule in the target device.

Device-replace process in ZONED mode must copy or clone all the extents in
the source device exactly once.  So, we need to use to ensure allocations
started just before the dev-replace process to have their corresponding
extent information in the B-trees. finish_extent_writes_for_zoned()
implements that functionality, which basically is the removed code in the
commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
error during device replace").

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 12 +++++++
 fs/btrfs/zoned.h |  7 ++++
 3 files changed, 105 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d750b32cfb..568d90214446 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -169,6 +169,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1623,6 +1624,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
+static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
+{
+	int ret = 0;
+	u64 length;
+
+	if (!btrfs_fs_incompat(sctx->fs_info, ZONED))
+		return 0;
+
+	if (sctx->write_pointer < physical) {
+		length = physical - sctx->write_pointer;
+
+		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
+						sctx->write_pointer, length);
+		if (!ret)
+			sctx->write_pointer = physical;
+	}
+	return ret;
+}
+
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage)
 {
@@ -1645,6 +1665,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
+		ret = fill_writer_pointer_gap(sctx,
+					      spage->physical_for_dev_replace);
+		if (ret) {
+			mutex_unlock(&sctx->wr_lock);
+			return ret;
+		}
+
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
 		sbio->dev = sctx->wr_tgtdev;
@@ -1706,6 +1733,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_fs_incompat(sctx->fs_info, ZONED))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -2973,6 +3004,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+static void sync_replace_for_zoned(struct scrub_ctx *sctx)
+{
+	if (!btrfs_fs_incompat(sctx->fs_info, ZONED))
+		return;
+
+	sctx->flush_all_writes = true;
+	scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+
+	wait_event(sctx->list_wait,
+		   atomic_read(&sctx->bios_in_flight) == 0);
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3105,6 +3151,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	blk_start_plug(&plug);
 
+	if (sctx->is_dev_replace &&
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+		mutex_lock(&sctx->wr_lock);
+		sctx->write_pointer = physical;
+		mutex_unlock(&sctx->wr_lock);
+		sctx->flush_all_writes = true;
+	}
+
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
@@ -3292,6 +3346,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_zoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3414,6 +3471,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int finish_extent_writes_for_zoned(struct btrfs_root *root,
+					  struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+
+	if (!btrfs_fs_incompat(fs_info, ZONED))
+		return 0;
+
+	btrfs_wait_block_group_reservations(cache);
+	btrfs_wait_nocow_writers(cache);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
+
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -3569,6 +3645,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * group is not RO.
 		 */
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
+		if (!ret && sctx->is_dev_replace) {
+			ret = finish_extent_writes_for_zoned(root, cache);
+			if (ret) {
+				btrfs_dec_block_group_ro(cache);
+				scrub_pause_off(fs_info);
+				btrfs_put_block_group(cache);
+				break;
+			}
+		}
+
 		if (ret == 0) {
 			ro_set = 1;
 		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2fe659bb0709..ac88d26f1119 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1196,3 +1196,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
 }
+
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length)
+{
+	if (!btrfs_dev_is_sequential(device, physical))
+		return -EOPNOTSUPP;
+
+	return blkdev_issue_zeroout(device->bdev,
+				    physical >> SECTOR_SHIFT,
+				    length >> SECTOR_SHIFT,
+				    GFP_NOFS, 0);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5d4b132a4d95..dea313a61a3e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,6 +58,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+			      u64 length);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -147,6 +149,11 @@ btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				struct extent_buffer *eb)
 {
 }
+static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
+					    u64 physical, u64 length)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

