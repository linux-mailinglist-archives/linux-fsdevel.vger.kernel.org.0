Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD75A90E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiIAHoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiIAHnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970B1257F1;
        Thu,  1 Sep 2022 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BcknqeZiBU7AfUTFnagzOoaBAn7P6DlrRAHe430S5NY=; b=l8ySUqRFcax7ifTq824G4bo2uG
        +ez/WKKM34hhZ1j9okNSPxOPmm83PfkHWYcMdBfcO4f9eL9Uv43YsRUTVliezK4uGKPXdx7AkUZzq
        nTIWjqzmbjdOyEdSOQh9b80OI4ns1n/UyUtGDGoCWVT4GS549E+22DoHEDdMTN8SDJ9LnpexTnjBF
        PXjDuiGe0yxMe9/jE2yIc6o91Q/3f2wuMELt82+ZYriwEkpuk6gH0LxGA8TC4kAVvn3irnhWz/cqO
        sUIqBFA+wjDkJ6VDnMwO5Q6fcxj7JY30s7Y/ghKE/G2LOcP4qcTrA1b9jfW509FTnKzzOSniiHSzE
        40YUsBow==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTer6-00ANmz-SF; Thu, 01 Sep 2022 07:43:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/17] btrfs: remove now spurious bio submission helpers
Date:   Thu,  1 Sep 2022 10:42:13 +0300
Message-Id: <20220901074216.1849941-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just call btrfs_submit_bio and btrfs_submit_compressed_read directly from
submit_one_bio now that all additional functionality has moved into
btrfs_submit_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h     |  3 ---
 fs/btrfs/disk-io.c   |  6 ------
 fs/btrfs/disk-io.h   |  1 -
 fs/btrfs/extent_io.c | 11 ++++++-----
 fs/btrfs/inode.c     | 22 ----------------------
 5 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 33c3c394e43e3..5e57e3c6a1fd6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3372,9 +3372,6 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
-void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
-void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
-			int mirror_num, enum btrfs_compression_type compress_type);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ceee039b65ea0..014c06c74155f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -648,12 +648,6 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
 	return ret;
 }
 
-void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num)
-{
-	bio->bi_opf |= REQ_META;
-	btrfs_submit_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
-}
-
 #ifdef CONFIG_MIGRATION
 static int btree_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9d4e0e36f7bb9..3a7ef2352c968 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -80,7 +80,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
-void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46a3f0e33fb69..33e80f8dd0b1b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -198,12 +198,13 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
 	if (!is_data_inode(inode))
-		btrfs_submit_metadata_bio(inode, bio, mirror_num);
-	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_submit_data_write_bio(inode, bio, mirror_num);
+		bio->bi_opf |= REQ_META;
+
+	if (btrfs_op(bio) == BTRFS_MAP_READ &&
+	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
+		btrfs_submit_compressed_read(inode, bio, mirror_num);
 	else
-		btrfs_submit_data_read_bio(inode, bio, mirror_num,
-					   bio_ctrl->compress_type);
+		btrfs_submit_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
 
 	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 25194e75c0812..9c562d36e4570 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2662,28 +2662,6 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	return ret;
 }
 
-void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	btrfs_submit_bio(fs_info, bio, mirror_num);
-}
-
-void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
-			int mirror_num, enum btrfs_compression_type compress_type)
-{
-	if (compress_type != BTRFS_COMPRESS_NONE) {
-		/*
-		 * btrfs_submit_compressed_read will handle completing the bio
-		 * if there were any errors, so just return here.
-		 */
-		btrfs_submit_compressed_read(inode, bio, mirror_num);
-		return;
-	}
-
-	btrfs_submit_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
-}
-
 /*
  * given a list of ordered sums record them in the inode.  This happens
  * at IO completion time based on sums calculated at bio submission time.
-- 
2.30.2

