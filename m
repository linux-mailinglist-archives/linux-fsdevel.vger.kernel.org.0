Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B863141B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKTMss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKTMsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B670EE11;
        Sun, 20 Nov 2022 04:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ICXLrr0YYpaXy2kt4njuHLnWRc6h2Er+3jvQphQalXI=; b=H8Zi8VRJfZp1d8crn4JhmVDiVW
        dnFREEvFZTpxKREm+ASOX9yKABm8NEOmw3KGy9iPNTEhZ37i+Pjkku5xrs/QTHYDI2fDQbBDpi5eW
        NAiKn+1Vt7sEe6Qrm3W/x149DqGzRSLyyMyEL3ckt6EykaWHI2vjl4jTALk+FaQNl/8Uqzi+3JxBo
        7T5u1gUL8sQ+fsfLmRHSlV0WORMiIv+gMgx/gHGomroJ/eihTkqanw0x8Gn2ztao1LrLj3sLieEVv
        ZrbI85X2XXtvq7L0qV23m38+hIlgOx2LaMPODu7ZzfcICyhd4/xtreew6YMGA0RCAOOdNVlqzWvnI
        hfpw6IJQ==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjk5-004IEr-LK; Sun, 20 Nov 2022 12:48:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/19] btrfs: remove struct btrfs_io_geometry
Date:   Sun, 20 Nov 2022 13:47:28 +0100
Message-Id: <20221120124734.18634-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that btrfs_get_io_geometry has a single caller, we can massage it
into a form that is more suitable for that caller and remove the
marshalling into and out of struct btrfs_io_geometry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 115 +++++++++++++--------------------------------
 fs/btrfs/volumes.h |  18 -------
 2 files changed, 32 insertions(+), 101 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index acab20f2863d5..b386cb4b9aaa1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6257,91 +6257,43 @@ static bool need_full_stripe(enum btrfs_map_op op)
 	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
 }
 
-/*
- * Calculate the geometry of a particular (address, len) tuple. This
- * information is used to calculate how big a particular bio can get before it
- * straddles a stripe.
- *
- * @fs_info: the filesystem
- * @em:      mapping containing the logical extent
- * @op:      type of operation - write or read
- * @logical: address that we want to figure out the geometry of
- * @io_geom: pointer used to return values
- *
- * Returns < 0 in case a chunk for the given logical address cannot be found,
- * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
- */
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom)
+static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
+			    u64 offset, u64 *stripe_nr, u64 *stripe_offset,
+			    u64 *full_stripe_start)
 {
-	struct map_lookup *map;
-	u64 len;
-	u64 offset;
-	u64 stripe_offset;
-	u64 stripe_nr;
-	u32 stripe_len;
-	u64 raid56_full_stripe_start = (u64)-1;
-	int data_stripes;
+	u32 stripe_len = map->stripe_len;
 
 	ASSERT(op != BTRFS_MAP_DISCARD);
 
-	map = em->map_lookup;
-	/* Offset of this logical address in the chunk */
-	offset = logical - em->start;
-	/* Len of a stripe in a chunk */
-	stripe_len = map->stripe_len;
 	/*
-	 * Stripe_nr is where this block falls in
-	 * stripe_offset is the offset of this block in its stripe.
+	 * Stripe_nr is the stripe where this block falls.
+	 * Stripe_offset is the offset of this block in its stripe.
 	 */
-	stripe_nr = div64_u64_rem(offset, stripe_len, &stripe_offset);
-	ASSERT(stripe_offset < U32_MAX);
+	*stripe_nr = div64_u64_rem(offset, stripe_len, stripe_offset);
+	ASSERT(*stripe_offset < U32_MAX);
 
-	data_stripes = nr_data_stripes(map);
+	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		unsigned long full_stripe_len =
+			stripe_len * nr_data_stripes(map);
 
-	/* Only stripe based profiles needs to check against stripe length. */
-	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) {
-		u64 max_len = stripe_len - stripe_offset;
+		*full_stripe_start =
+			div64_u64(offset, full_stripe_len) * full_stripe_len;
 
 		/*
-		 * In case of raid56, we need to know the stripe aligned start
+		 * For writes to RAID[56], allow to write a full stripe set, but
+		 * no straddling of stripe sets.
 		 */
-		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-			unsigned long full_stripe_len = stripe_len * data_stripes;
-			raid56_full_stripe_start = offset;
-
-			/*
-			 * Allow a write of a full stripe, but make sure we
-			 * don't allow straddling of stripes
-			 */
-			raid56_full_stripe_start = div64_u64(raid56_full_stripe_start,
-					full_stripe_len);
-			raid56_full_stripe_start *= full_stripe_len;
-
-			/*
-			 * For writes to RAID[56], allow a full stripeset across
-			 * all disks. For other RAID types and for RAID[56]
-			 * reads, just allow a single stripe (on a single disk).
-			 */
-			if (op == BTRFS_MAP_WRITE) {
-				max_len = stripe_len * data_stripes -
-					  (offset - raid56_full_stripe_start);
-			}
-		}
-		len = min_t(u64, em->len - offset, max_len);
-	} else {
-		len = em->len - offset;
+		if (op == BTRFS_MAP_WRITE)
+			return full_stripe_len - (offset - *full_stripe_start);
 	}
 
-	io_geom->len = len;
-	io_geom->offset = offset;
-	io_geom->stripe_len = stripe_len;
-	io_geom->stripe_nr = stripe_nr;
-	io_geom->stripe_offset = stripe_offset;
-	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
-
-	return 0;
+	/*
+	 * For other RAID types and for RAID[56] reads, just allow a single
+	 * stripe (on a single disk).
+	 */
+	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK)
+		return stripe_len - *stripe_offset;
+	return U64_MAX;
 }
 
 static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
@@ -6360,6 +6312,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 {
 	struct extent_map *em;
 	struct map_lookup *map;
+	u64 map_offset;
 	u64 stripe_offset;
 	u64 stripe_nr;
 	u64 stripe_len;
@@ -6378,7 +6331,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	int patch_the_first_stripe_for_dev_replace = 0;
 	u64 physical_to_patch_in_first_stripe = 0;
 	u64 raid56_full_stripe_start = (u64)-1;
-	struct btrfs_io_geometry geom;
+	u64 max_len;
 
 	ASSERT(bioc_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
@@ -6386,18 +6339,14 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
-	if (ret < 0)
-		return ret;
-
 	map = em->map_lookup;
-
-	*length = geom.len;
-	stripe_len = geom.stripe_len;
-	stripe_nr = geom.stripe_nr;
-	stripe_offset = geom.stripe_offset;
-	raid56_full_stripe_start = geom.raid56_stripe_offset;
 	data_stripes = nr_data_stripes(map);
+	stripe_len = map->stripe_len;
+
+	map_offset = logical - em->start;
+	max_len = btrfs_max_io_len(map, op, map_offset, &stripe_nr,
+				   &stripe_offset, &raid56_full_stripe_start);
+	*length = min_t(u64, em->len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6b7a05f6cf823..7e51f2238f72e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -53,21 +53,6 @@ enum btrfs_raid_types {
 	BTRFS_NR_RAID_TYPES
 };
 
-struct btrfs_io_geometry {
-	/* remaining bytes before crossing a stripe */
-	u64 len;
-	/* offset of logical address in chunk */
-	u64 offset;
-	/* length of single IO stripe */
-	u32 stripe_len;
-	/* offset of address in stripe */
-	u32 stripe_offset;
-	/* number of stripe where address falls */
-	u64 stripe_nr;
-	/* offset of raid56 stripe into the chunk */
-	u64 raid56_stripe_offset;
-};
-
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
@@ -545,9 +530,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
 					       u32 *num_stripes);
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-- 
2.30.2

