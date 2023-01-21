Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38AA67648D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAUGwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjAUGwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6557D73ADE;
        Fri, 20 Jan 2023 22:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=giIibskDV7YHRTPHfGoUrgZ1mRSF6LWWjM1H4i5djSQ=; b=gWwcAognE6IbMqlgnudb8C7A2A
        EgkZY1z38FSEzU9xofpEAJmLEgyKNnpYHk/1ChOh5G7cXJ69KsWJIT3ZXg7qwGR4V5UQn0TlZXjVN
        mJVf7jlTkyQEg4P1xtCJAZ/lH5Mf23F/CJFG1GXKjoDvJtUhY+wiQhxKkS9TrIMspFac4Ralb7RGt
        nr60LUwmcBe1zCHa38HWweWidxodkdDiIgvnVYWNGZ0Ckq7KsiKudKipJ9n2uDVSRypUMzxi6y4bo
        /MNzYgTd56sUu1vi8ZOxtWFShRtVLFpylx+WsOZin4DVIENAzdkErP+1G2r9lUq/x42vDbI8c6sAK
        c5H+yvTA==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jI-00DRiJ-46; Sat, 21 Jan 2023 06:51:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 31/34] btrfs: remove now spurious bio submission helpers
Date:   Sat, 21 Jan 2023 07:50:28 +0100
Message-Id: <20230121065031.1139353-32-hch@lst.de>
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

Just call btrfs_submit_bio and btrfs_submit_compressed_read directly from
submit_one_bio now that all additional functionality has moved into
btrfs_submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/btrfs_inode.h |  3 ---
 fs/btrfs/disk-io.c     |  6 ------
 fs/btrfs/disk-io.h     |  1 -
 fs/btrfs/extent_io.c   | 19 ++++++++++---------
 fs/btrfs/inode.c       | 20 --------------------
 5 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b83b731c63e13e..49a92aa65de1f6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -405,9 +405,6 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
-void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
-			int mirror_num, enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a84b662fdd220d..0da0bde347e54a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -699,12 +699,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	return ret;
 }
 
-void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
-{
-	bio->bi_opf |= REQ_META;
-	btrfs_submit_bio(bio, mirror_num);
-}
-
 #ifdef CONFIG_MIGRATION
 static int btree_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f2dd4c6d9c258b..3b53fc29a85888 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -86,7 +86,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
-void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c7346bc6d8bdd7..66134bb75f8941 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -125,7 +125,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
 	struct bio_vec *bv;
-	struct btrfs_inode *inode;
+	struct inode *inode;
 	int mirror_num;
 
 	if (!bio_ctrl->bio)
@@ -133,7 +133,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	bio = bio_ctrl->bio;
 	bv = bio_first_bvec_all(bio);
-	inode = BTRFS_I(bv->bv_page->mapping->host);
+	inode = bv->bv_page->mapping->host;
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
@@ -141,7 +141,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
-	if (!is_data_inode(&inode->vfs_inode)) {
+	if (!is_data_inode(inode)) {
 		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 			/*
 			 * For metadata read, we should have the parent_check,
@@ -152,14 +152,15 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 			       bio_ctrl->parent_check,
 			       sizeof(struct btrfs_tree_parent_check));
 		}
-		btrfs_submit_metadata_bio(inode, bio, mirror_num);
-	} else if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_submit_data_write_bio(inode, bio, mirror_num);
-	} else {
-		btrfs_submit_data_read_bio(inode, bio, mirror_num,
-					   bio_ctrl->compress_type);
+		bio->bi_opf |= REQ_META;
 	}
 
+	if (btrfs_op(bio) == BTRFS_MAP_READ &&
+	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
+		btrfs_submit_compressed_read(inode, bio, mirror_num);
+	else
+		btrfs_submit_bio(bio, mirror_num);
+
 	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0c3e0ec842933e..383219f51d86ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2695,26 +2695,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	return errno_to_blk_status(ret);
 }
 
-void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
-{
-	btrfs_submit_bio(bio, mirror_num);
-}
-
-void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
-			int mirror_num, enum btrfs_compression_type compress_type)
-{
-	if (compress_type != BTRFS_COMPRESS_NONE) {
-		/*
-		 * btrfs_submit_compressed_read will handle completing the bio
-		 * if there were any errors, so just return here.
-		 */
-		btrfs_submit_compressed_read(&inode->vfs_inode, bio, mirror_num);
-		return;
-	}
-
-	btrfs_submit_bio(bio, mirror_num);
-}
-
 /*
  * given a list of ordered sums record them in the inode.  This happens
  * at IO completion time based on sums calculated at bio submission time.
-- 
2.39.0

