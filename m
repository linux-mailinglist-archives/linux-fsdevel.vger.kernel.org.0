Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DFF28070B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgJASjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgJASjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577541; x=1633113541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TqYRZkjI+eHOJGvn2Y+h5fswysSdJ99elTXem5Z7Fr4=;
  b=QHk+3SM3PoUmiszRXSuMc2tHs0/z66IOBJHzQ8GtGxVsLz1ch+Zqc/nB
   xwJc762aea+TlJWbztRPNeGgnyG1FPbMOL1kXJHsHUEIuveHCoxfhIpB5
   /luuXiWhmcyJU1BQdZVb+8BnSV0pA2+yWgS84exQ6MLjdvJ8pGrSAlKn4
   bbJQriBJliAY0bjWmnmex+d4+gO8/GkVM/U+HXrj/G8Zvuxn900G/oWBM
   PwZJrcNLQER++35qN+c57/Q3q+7O9mOgpQ3aXjpdMcKTyIV7ky+JemUrw
   SotAs5vNNB6DLdrHMz9tmmPCqHK8+gia5OFD2c69XavATOhex08yteynl
   Q==;
IronPort-SDR: 6pxq+0Z+Klu518EDboleO9catZThsp5vTQ3KXU58si867ZdNc+ZJe3X6I9j4mus/5r/lb2M+9i
 y+uDkT44DbkTDwxru/j9dxZsYpjyQX9oEuZWv/9UW4FtULqYnIU3zrOSRyI3stUVNDl3K9GDOO
 DZLKkoW1RTepZMR33yilt8lA27FQ9uZH5Cj35RSdQof+P2qx3X8k+FSmb1m8KvVZXJsKihpCG3
 +MdMw3QxLXs/oS20PlHNQnQJZMMv3u/RBFBkJ9t4xYel3K1egeqvYTNb+4bh6KsS5q95ljscBw
 vqs=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036818"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:31 +0800
IronPort-SDR: v/XmTWKam1q7rJQWGA4IM3DOdM4lMinxeiOczV5KtqXNe4YFZGpHFFCjz4GNPWq6SsSFBbV4Nh
 uVToN7KLYzeg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:27 -0700
IronPort-SDR: vwCR39jI9LF2+/E8z7NMEyGOCcPB37n9eaMYhFGz87akTpMfsQGManYSJpMea3BA98xKIdhO/7
 9JGZFPRd3cBg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 25/41] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Fri,  2 Oct 2020 03:36:32 +0900
Message-Id: <1727a2fbaa17db7c5d3447d2f547b98cb5f9bf32.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit enables zone append writing for zoned btrfs. Three parts are
necessary to enable it. First, it modifies bio to use REQ_OP_ZONE_APPEND in
btrfs_submit_bio_hook() and adjust the bi_sector to point the beginning of
the zone.

Second, it records returned physical address (and disk/partno) to
the ordered extent in end_bio_extent_writepage().

Finally, it rewrites logical addresses of the extent mapping and checksum
data according to the physical address (using __btrfs_rmap_block). If the
returned address match to the originaly allocated address, we can skip the
rewriting process.

[Johannes] fixed bvec handling
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c    | 12 +++++++-
 fs/btrfs/inode.c        |  6 +++-
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  4 +++
 fs/btrfs/volumes.c      |  9 ++++++
 fs/btrfs/zoned.c        | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        |  9 ++++++
 7 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ee94a2ffa22..bbcdc8dfbd45 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2743,6 +2743,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2769,6 +2770,11 @@ static void end_bio_extent_writepage(struct bio *bio)
 		start = page_offset(page);
 		end = start + bvec->bv_offset + bvec->bv_len - 1;
 
+		if (first_bvec) {
+			btrfs_record_physical_zoned(inode, start, bio);
+			first_bvec = false;
+		}
+
 		end_extent_writepage(page, error, start, end);
 		end_page_writeback(page);
 	}
@@ -3531,6 +3537,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3543,6 +3550,9 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
+	if (btrfs_fs_incompat(inode->root->fs_info, ZONED))
+		opf = REQ_OP_ZONE_APPEND;
+
 	/*
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
@@ -3603,7 +3613,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
+		ret = submit_extent_page(opf | write_flags, wbc,
 					 page, offset, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4bc975eafbd8..b5fdc93b319f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,6 +51,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2279,7 +2280,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			goto out;
 	}
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
 			goto out;
@@ -2674,6 +2675,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 7cd22cb07f26..b32cdbfd408d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,6 +199,9 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
+	entry->physical = (u64)-1;
+	entry->disk = NULL;
+	entry->partno = (u8)-1;
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
 		set_bit(type, &entry->flags);
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index e346b03bd66a..1d5a8dc00373 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -127,6 +127,10 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
+
+	u64 physical;
+	struct gendisk *disk;
+	u8 partno;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 44ef7b2fb46c..924ba96dc8fa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6500,6 +6500,15 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		u64 zone_start = round_down(physical, fs_info->zone_size);
+
+		bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+	}
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 88b45af60e4f..9e1056e2c2c8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1054,3 +1054,71 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
 }
+
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 physical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
+		return;
+
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	if (WARN_ON(!ordered))
+		return;
+
+	ordered->physical = physical;
+	ordered->disk = bio->bi_disk;
+	ordered->partno = bio->bi_partno;
+
+	btrfs_put_ordered_extent(ordered);
+}
+
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct inode *inode = ordered->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ordered_sum *sum;
+	struct block_device *bdev;
+	u64 orig_logical = ordered->disk_bytenr;
+	u64 *logical = NULL;
+	int nr, stripe_len;
+
+	bdev = bdget_disk(ordered->disk, ordered->partno);
+	if (WARN_ON(!bdev))
+		return;
+
+	if (WARN_ON(__btrfs_rmap_block(fs_info, orig_logical, bdev,
+				       ordered->physical, &logical, &nr,
+				       &stripe_len)))
+		goto out;
+
+	WARN_ON(nr != 1);
+
+	if (orig_logical == *logical)
+		goto out;
+
+	ordered->disk_bytenr = *logical;
+
+	em_tree = &BTRFS_I(inode)->extent_tree;
+	write_lock(&em_tree->lock);
+	em = search_extent_mapping(em_tree, ordered->file_offset,
+				   ordered->num_bytes);
+	em->block_start = *logical;
+	free_extent_map(em);
+	write_unlock(&em_tree->lock);
+
+	list_for_each_entry(sum, &ordered->list, list) {
+		if (*logical < orig_logical)
+			sum->bytenr -= orig_logical - *logical;
+		else
+			sum->bytenr += *logical - orig_logical;
+	}
+
+out:
+	kfree(logical);
+	bdput(bdev);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 32446135e882..f6263a893a07 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -50,6 +50,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio);
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -119,6 +122,12 @@ static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
+static inline void btrfs_record_physical_zoned(struct inode *inode,
+					       u64 file_offset, struct bio *bio)
+{
+}
+static inline void
+btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

