Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD06313F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKTMrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTMrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:47:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933838A5;
        Sun, 20 Nov 2022 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1t5D8XNQfnnyi7WG90AzrXGKT54zrCNdvtEaxPWyocA=; b=t5aJBzChIm/fTSPLnCZ0OB0A0h
        S7Y1rmqEbKA9UTe04aixOWBI1/RRnM+oI2UBuQ+BnHLOTaZ4Is5s44LNpzvAXcaWEw6ZdCk+j0GSx
        XQQwxE/suUaFCZPMBIk28CtQVh4mhGIDY3xIknxRqVNFpZSFx6qffdiXdkFYnpXmZUrlPcPRHkK+m
        3TNdVtdrxMk1CaCgeJy1xRtTQXIGBl7kwUQQXLR7kcXl320iCHXj8M/3IjzwNuVHxB9yio6ZhfupQ
        l3xp4RqcopZ5xQ1MuJ9GxBPNNTwoI+zjOMq/B6bzgI16EsJLS/UosmQjxWo+VNraNx0r9qq3i7r+9
        PPodOBaQ==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjje-004I5C-1h; Sun, 20 Nov 2022 12:47:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/19] btrfs: remove the submit_bio_start helpers
Date:   Sun, 20 Nov 2022 13:47:18 +0100
Message-Id: <20221120124734.18634-4-hch@lst.de>
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

Just call btrfs_csum_one_bio and btree_csum_one_bio directly.

Note that btree_csum_one_bio has to be moved up in the file a bit
to avoid a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  4 ----
 fs/btrfs/disk-io.c     | 54 ++++++++++++++++++------------------------
 fs/btrfs/disk-io.h     |  1 -
 fs/btrfs/inode.c       | 20 ----------------
 4 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 78c7979b8dcac..ba5f023aaf557 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -408,10 +408,6 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
-blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio);
-blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
-					      struct bio *bio,
-					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 74455977afe73..9aad0d7e05a54 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "file-item.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -448,6 +449,24 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	return csum_one_extent_buffer(eb);
 }
 
+static blk_status_t btree_csum_one_bio(struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct btrfs_root *root;
+	int ret = 0;
+	struct bvec_iter_all iter_all;
+
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
+		ret = csum_dirty_buffer(root->fs_info, bvec);
+		if (ret)
+			break;
+	}
+
+	return errno_to_blk_status(ret);
+}
+
 static int check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -698,14 +717,14 @@ static void run_one_async_start(struct btrfs_work *work)
 	async = container_of(work, struct  async_submit_bio, work);
 	switch (async->submit_cmd) {
 	case WQ_SUBMIT_METADATA:
-		ret = btree_submit_bio_start(async->bio);
+		ret = btree_csum_one_bio(async->bio);
 		break;
 	case WQ_SUBMIT_DATA:
-		ret = btrfs_submit_bio_start(async->inode, async->bio);
+		ret = btrfs_csum_one_bio(async->inode, async->bio, (u64)-1, false);
 		break;
 	case WQ_SUBMIT_DATA_DIO:
-		ret = btrfs_submit_bio_start_direct_io(async->inode,
-				async->bio, async->dio_file_offset);
+		ret = btrfs_csum_one_bio(async->inode, async->bio,
+					 async->dio_file_offset, false);
 		break;
 	}
 	if (ret)
@@ -786,33 +805,6 @@ bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_
 	return true;
 }
 
-static blk_status_t btree_csum_one_bio(struct bio *bio)
-{
-	struct bio_vec *bvec;
-	struct btrfs_root *root;
-	int ret = 0;
-	struct bvec_iter_all iter_all;
-
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec);
-		if (ret)
-			break;
-	}
-
-	return errno_to_blk_status(ret);
-}
-
-blk_status_t btree_submit_bio_start(struct bio *bio)
-{
-	/*
-	 * when we're called for a write, we're already in the async
-	 * submission context.  Just jump into btrfs_submit_bio.
-	 */
-	return btree_csum_one_bio(bio);
-}
-
 static bool should_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 363935cfc0844..07ac66d693aee 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -122,7 +122,6 @@ enum btrfs_wq_submit_cmd {
 
 bool btrfs_wq_submit_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num,
 			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
-blk_status_t btree_submit_bio_start(struct bio *bio);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 539fa462b473d..18b298c8e4385 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2532,19 +2532,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-/*
- * in order to insert checksums into the metadata in large chunks,
- * we wait until bio submission time.   All the pages in the bio are
- * checksummed and sums are attached onto the ordered extent record.
- *
- * At IO completion time the cums attached on the ordered extent record
- * are inserted into the btree
- */
-blk_status_t btrfs_submit_bio_start(struct btrfs_inode *inode, struct bio *bio)
-{
-	return btrfs_csum_one_bio(inode, bio, (u64)-1, false);
-}
-
 /*
  * Split an extent_map at [start, start + len]
  *
@@ -7833,13 +7820,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
-					      struct bio *bio,
-					      u64 dio_file_offset)
-{
-	return btrfs_csum_one_bio(inode, bio, dio_file_offset, false);
-}
-
 static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 {
 	struct btrfs_dio_private *dip = bbio->private;
-- 
2.30.2

