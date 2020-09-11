Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDC266764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgIKRmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgIKMhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827842; x=1631363842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OuUoXYeTteufgkIDhZ+l/S5PrF5wExbCumkNAr7eq8=;
  b=kG5sh6rntdLoLypD2QSIB9ho9Qj9w5vGLtWqGnGEcNbUwjkE3jKf7RQj
   V/OsFUbKoUCzefDY+pdedLNJP1j4Ofizg0iw5n7clYYjSiWcGe4jM59lV
   7f7TT5lly4tNGLzwbo9Q0aEQhYEAlvG2VhzzfpqlQFAVf9DUhXkf4766g
   b4cHGirjMq9yh+r6lDGZ1e5KJg269XaNk5iidpno9v2nMMepdtuZIcrVw
   ZhcuMzNmQxzWs+n5zVPdCO0pg3/YI2q+aw6V+IOwFtwJ0JAnuvBy2EPVm
   u3t9RDL+w1AffhQ059ADNNvC0o4dOO/60eUsQT0MnkfyVKsIDhLCT2HL1
   g==;
IronPort-SDR: IUKJCWWn9e2t0OPB0ndv12cnF7o8lebHHs4y4Mtw8EcTNmhp/v1nSXnmpmbBcNlcaDU4hFrTk9
 Uk11x3CkbyHdcZ+D9eD0bhE+75ZbzheesoZu5p9L4vpxtk+mnj6kNPwVl/HfmjK3xet6ihT0dE
 Fe7DPtMZT6W7DHVbUe4eo2IgBU2UQE53K7m+T6X5lbT4loIVyWSdWJbIo6r9OcUSqAPM3hkw0l
 yXvCQ9OFGeD0oQYudTeW7smtEIEb5QA/2SKS21KN64gNlekiUjsseuHfwj59rlvjlyfHguXKE6
 vMQ=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126006"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:40 +0800
IronPort-SDR: jqTjVE1hEQH33kpphlgU9/vW1aUiPuUIU4+skeARM9yBh5IvuFKZB+MpZlar4BRH7poPDu8/0m
 mKXYhTfnNP6g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:00 -0700
IronPort-SDR: tVXb407wN/RQZfPXO5/sny2Q8niB+ebBFpRppQOrhat83aG5I7SKbVO9X8BE7eO0+EUZuWTt4C
 +qIjBnX5sQfg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 22/39] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Fri, 11 Sep 2020 21:32:42 +0900
Message-Id: <20200911123259.3782926-23-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c    |  4 +++
 fs/btrfs/inode.c        | 12 ++++++-
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  4 +++
 fs/btrfs/volumes.c      |  9 ++++++
 fs/btrfs/zoned.c        | 70 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        |  9 ++++++
 7 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c21d1dbe314e..00a07cefffeb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2749,6 +2749,10 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 end;
 	struct bvec_iter_all iter_all;
 
+	btrfs_record_physical_zoned(bio_iovec(bio).bv_page->mapping->host,
+				    page_offset(bio_iovec(bio).bv_page) + bio_iovec(bio).bv_offset,
+				    bio);
+
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ca0be689e7ad..7fe28a77f9b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -49,6 +49,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2198,7 +2199,13 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (bio_op(bio) == REQ_OP_WRITE && btrfs_fs_incompat(fs_info, ZONED)) {
+		/* use zone append writing */
+		bio->bi_opf &= ~REQ_OP_MASK;
+		bio->bi_opf |= REQ_OP_ZONE_APPEND;
+	}
+
+	if (bio_op(bio) != REQ_OP_WRITE && bio_op(bio) != REQ_OP_ZONE_APPEND) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
 			goto out;
@@ -2594,6 +2601,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ebac13389e7e..3cb0d92a3bcf 100644
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
index d61ea9c880a3..7872d566ae1b 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -118,6 +118,10 @@ struct btrfs_ordered_extent {
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
index 086cd308e5b6..6337ce95a088 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6505,6 +6505,15 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
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
index 855acbc61d47..1744e2649087 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1065,3 +1065,73 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
 }
+
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	struct bio_vec bvec = bio_iovec(bio);
+	u64 physical = ((u64)bio->bi_iter.bi_sector << SECTOR_SHIFT) +
+		bvec.bv_offset;
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
index cdb84c758a61..5f4bc746e3e2 100644
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
@@ -121,6 +124,12 @@ static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
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

