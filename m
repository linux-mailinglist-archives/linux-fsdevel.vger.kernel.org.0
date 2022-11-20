Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927BD631424
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKTMtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKTMsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426791571B;
        Sun, 20 Nov 2022 04:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QBz0wl9YdbeAY6H2NhG2/lb9edBICi5UBPy6cPeuME8=; b=KqF2GNFOxQBbaKMXv2SQtT1Wuy
        ZjQQDfLmdrfrAYJ3YP+4ugq9wcPxUCHPX3+0ZGjqObcNHSTK3CxZ0HQtb+L2kotDzmcb2y3oCWhSX
        8VROdEhYdgEE2AyT6vSbdXgkDdHJsFRAKeOCvj8tuZLY1gzWtP8LnHHzLUyetOTqhqGcNmasIhBdK
        7lw8UML7Nbp6uxdhK71oKQrbk4Krnvm4l9Qe/7+U4kupxxhMSq3aet5yKTed63VaS9/v1pUVtyc37
        NocPbel8R4LTU+SkI2EvBFAtFHdZsMrZV0n4K1OuqJxNajPf8//QnhseEUJ8UJD3uByV+edCd2Ubo
        z6GHvGlw==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjkD-004IGj-C4; Sun, 20 Nov 2022 12:48:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/19] btrfs: remove now spurious bio submission helpers
Date:   Sun, 20 Nov 2022 13:47:31 +0100
Message-Id: <20221120124734.18634-17-hch@lst.de>
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
 fs/btrfs/extent_io.c   | 17 +++++++++--------
 fs/btrfs/inode.c       | 20 --------------------
 5 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b83b731c63e13..49a92aa65de1f 100644
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
index d57f1519116a3..f10b946454d71 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -689,12 +689,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
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
index 101260f57e816..bc686de7eb808 100644
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
index b49c82864389c..76bd367e78e9e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -116,7 +116,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
 	struct bio_vec *bv;
-	struct btrfs_inode *inode;
+	struct inode *inode;
 	int mirror_num;
 
 	if (!bio_ctrl->bio)
@@ -124,7 +124,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	bio = bio_ctrl->bio;
 	bv = bio_first_bvec_all(bio);
-	inode = BTRFS_I(bv->bv_page->mapping->host);
+	inode = bv->bv_page->mapping->host;
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
@@ -132,13 +132,14 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
-	if (!is_data_inode(&inode->vfs_inode))
-		btrfs_submit_metadata_bio(inode, bio, mirror_num);
-	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_submit_data_write_bio(inode, bio, mirror_num);
+	if (!is_data_inode(inode))
+		bio->bi_opf |= REQ_META;
+
+	if (btrfs_op(bio) == BTRFS_MAP_READ &&
+	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
+		btrfs_submit_compressed_read(inode, bio, mirror_num);
 	else
-		btrfs_submit_data_read_bio(inode, bio, mirror_num,
-					   bio_ctrl->compress_type);
+		btrfs_submit_bio(bio, mirror_num);
 
 	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6bf15bce8523..61566cdee2564 100644
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
2.30.2

