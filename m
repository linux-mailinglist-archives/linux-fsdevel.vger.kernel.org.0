Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56AA676471
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjAUGvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAUGvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B9683D9;
        Fri, 20 Jan 2023 22:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fO8M1STayC2NMZyRacAnKh4WRdxGGm8jm7BaawPi8n4=; b=KrmJaH+BIZAzw5gGPcUU6zd0uj
        NcpBokPft5QngeNAupyw+SOdNK8ZXmYceLFwxlkDeXkCYbyPVu2v7CJNdRVZJkuZDdOJk2lFRQQwo
        +j9pkrB6SQ+mHvBRD/mGBPbh0IpfhwgJ2G2RgP7uAxcmEIP8G/F93EBS2UEZ4o4RRj6ufA/NJppv8
        E3bKcaocK6oiZYJUHP1gfqI7nDAnIJlY5lB6FxvlMoxe1XJ16SRIIP1DcWpjiZWlc9tnoCTMkIVWK
        c6LeEu9OUyMAorQ+rblldkW9MqOLZhqj2DI0Of8FDQcJe44/jd9uQtwP310hxj2jvEFhbbofJABzv
        BHARiwrg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7im-00DRXD-HH; Sat, 21 Jan 2023 06:51:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/34] btrfs: simplify the btrfs_csum_one_bio calling convention
Date:   Sat, 21 Jan 2023 07:50:16 +0100
Message-Id: <20230121065031.1139353-20-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To prepare for further bio submission changes btrfs_csum_one_bio
should be able to take all it's arguments from the btrfs_bio structure.
It can always use the bbio->inode already, and once the compression code
is updated to set ->file_offset that one can be used unconditionally
as well instead of looking at the page mapping now that btrfs doesn't
allow ordered extents to span discontiguous data ranges.

The only slightly tricky bit is the one_ordered flag set by the
compressed writes.  Replace that one with the driver private bio
flag, which gets cleared before the bio is handed off to the block layer
so that we don't get in the way of driver use.

Note: this leaves an argument an a flag to btrfs_wq_submit_bio unused.
But that whole mechanism will be removed in its current form in the
next patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         |  3 +++
 fs/btrfs/bio.h         |  3 +++
 fs/btrfs/compression.c |  6 ++++--
 fs/btrfs/disk-io.c     |  5 +----
 fs/btrfs/file-item.c   | 22 ++++++----------------
 fs/btrfs/file-item.h   |  6 ++++--
 fs/btrfs/inode.c       |  4 ++--
 7 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f1566919fdb969..aae56e226fcdd9 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -441,6 +441,9 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 			goto fail;
 	}
 
+	/* Do not leak our private flag into the block layer */
+	bio->bi_opf &= ~REQ_BTRFS_ONE_ORDERED;
+
 	if (!bioc) {
 		/* Single mirror read/write fast path */
 		bbio->mirror_num = mirror_num;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index a96bcb3f36f684..334dcc3d5feb95 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -86,6 +86,9 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	bbio->end_io(bbio);
 }
 
+/* bio only refers to one ordered extent */
+#define REQ_BTRFS_ONE_ORDERED	REQ_DRV
+
 void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		      int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f84ccb185c2a6f..002af327705605 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -357,7 +357,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	blk_status_t ret = BLK_STS_OK;
 	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
-	const enum req_op bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
+	const enum req_op bio_op = REQ_BTRFS_ONE_ORDERED |
+		(use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE);
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
@@ -395,6 +396,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				ret = errno_to_blk_status(PTR_ERR(bio));
 				break;
 			}
+			btrfs_bio(bio)->file_offset = start;
 			if (blkcg_css)
 				bio->bi_opf |= REQ_CGROUP_PUNT;
 		}
@@ -436,7 +438,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		if (submit) {
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, true);
+				ret = btrfs_csum_one_bio(btrfs_bio(bio));
 				if (ret) {
 					btrfs_bio_end_io(btrfs_bio(bio), ret);
 					break;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d89ba4d0f898e5..27d1df2b80dd38 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -730,11 +730,8 @@ static void run_one_async_start(struct btrfs_work *work)
 		ret = btree_csum_one_bio(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_csum_one_bio(async->inode, async->bio, (u64)-1, false);
-		break;
 	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_csum_one_bio(async->inode, async->bio,
-					 async->dio_file_offset, false);
+		ret = btrfs_csum_one_bio(btrfs_bio(async->bio));
 		break;
 	default:
 		/* Can't happen so return something that would prevent the IO. */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c5324fe8f4be7a..a097b03c0bdcdf 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -771,24 +771,17 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
 }
 
 /*
- * Calculate checksums of the data contained inside a bio.
- *
- * @inode:	 Owner of the data inside the bio
- * @bio:	 Contains the data to be checksummed
- * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
- *               file offsets are determined from the page offsets in the bio.
- *               Otherwise, this is the starting file offset of the bio vecs in
- *               @bio, which must be contiguous.
- * @one_ordered: If true, @bio only refers to one ordered extent.
+ * Calculate checksums of the data contained inside a bio
  */
-blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 offset, bool one_ordered)
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 {
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct bio *bio = &bbio->bio;
+	u64 offset = bbio->file_offset;
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
-	const bool use_page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
@@ -816,9 +809,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (use_page_offsets)
-			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
-
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
 			/*
@@ -840,7 +830,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < blockcount; i++) {
-			if (!one_ordered &&
+			if (!(bio->bi_opf & REQ_BTRFS_ONE_ORDERED) &&
 			    !in_range(offset, ordered->file_offset,
 				      ordered->num_bytes)) {
 				unsigned long bytes_left;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index a2f9747adf3ac0..cd7f2ae515c0ca 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -49,8 +49,10 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 offset, bool one_ordered);
+blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio);
+int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
+			     struct list_head *list, int search_commit,
+			     bool nowait);
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			    struct list_head *list, int search_commit,
 			    bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 014cd6a4544132..2a25ea88a9e8bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2736,7 +2736,7 @@ void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int
 		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_DATA))
 			return;
 
-		ret = btrfs_csum_one_bio(inode, bio, (u64)-1, false);
+		ret = btrfs_csum_one_bio(btrfs_bio(bio));
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
@@ -7863,7 +7863,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct btrfs_inode *inode,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(inode, bio, file_offset, false);
+		ret = btrfs_csum_one_bio(btrfs_bio(bio));
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
-- 
2.39.0

