Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25228676485
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAUGwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAUGwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA373170;
        Fri, 20 Jan 2023 22:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QH4VNOaAeIhXdDrcAt2uaZcNGmN2i9+M0uT2ZRxeduE=; b=2C29l5jcDnjGnNwA3RDZWF3CwE
        nkX5wU1ys7Zg7LNMpgDvR94xgpMmru9xEsfZtXB8uyYYFdJThfrsiDfgqK9W5rvwVEuBxwMOsT3Pe
        Pim1rDnexKH1EzOi/Pk88pxK2O9O24rcRhPlfE6G5HPHTh/1kj8BZJhLQ9hmuzctPBeYTJCsmgZyP
        OAYcDX2/kmdLCKbh/X0aAnsWT3Cnigxdk1TGjF00Jrm/vrrsyt92ZzA+WimTAPfXC3jtvZK+GF2JM
        ja5/Hf+bI6LxXLLznScjom79bhqMLEZGwwkl36eBaxYLX0ezm6dVZfp1dOE5TN/azOr3Zyis94R5F
        gqUNfANg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jF-00DRh1-KY; Sat, 21 Jan 2023 06:51:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 30/34] btrfs: remove the fs_info argument to btrfs_submit_bio
Date:   Sat, 21 Jan 2023 07:50:27 +0100
Message-Id: <20230121065031.1139353-31-hch@lst.de>
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

btrfs_submit_bio can derive it trivially from bbio->inode, so stop
bothering in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 13 ++++++-------
 fs/btrfs/bio.h         |  3 +--
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/inode.c       | 11 ++++-------
 5 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5d4b67fc44f4de..38a2d2bb5c2fa9 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -154,7 +154,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 			goto done;
 		}
 
-		btrfs_submit_bio(fs_info, &repair_bbio->bio, mirror);
+		btrfs_submit_bio(&repair_bbio->bio, mirror);
 		return;
 	}
 
@@ -224,7 +224,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
 	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
-	btrfs_submit_bio(fs_info, repair_bio, mirror);
+	btrfs_submit_bio(repair_bio, mirror);
 	return fbio;
 }
 
@@ -603,10 +603,10 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 	return true;
 }
 
-static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
-			       int mirror_num)
+static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
@@ -678,10 +678,9 @@ static bool btrfs_submit_chunk(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return true;
 }
 
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-		      int mirror_num)
+void btrfs_submit_bio(struct bio *bio, int mirror_num)
 {
-	while (!btrfs_submit_chunk(fs_info, bio, mirror_num))
+	while (!btrfs_submit_chunk(bio, mirror_num))
 		;
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 5acbcc18026d52..20105806c8acc3 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -88,8 +88,7 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 /* bio only refers to one ordered extent */
 #define REQ_BTRFS_ONE_ORDERED	REQ_DRV
 
-void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-		      int mirror_num);
+void btrfs_submit_bio(struct bio *bio, int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 547cb626dfdeb9..41c1f8937bf5d6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -402,7 +402,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		if (submit) {
 			ASSERT(bio->bi_iter.bi_size);
-			btrfs_submit_bio(fs_info, bio, 0);
+			btrfs_submit_bio(bio, 0);
 			bio = NULL;
 		}
 		cond_resched();
@@ -699,7 +699,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	btrfs_bio(comp_bio)->file_offset = file_offset;
 
 	ASSERT(comp_bio->bi_iter.bi_size);
-	btrfs_submit_bio(fs_info, comp_bio, mirror_num);
+	btrfs_submit_bio(comp_bio, mirror_num);
 	return;
 
 fail:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2ae329b5ce9804..a84b662fdd220d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -702,7 +702,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 void btrfs_submit_metadata_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
 	bio->bi_opf |= REQ_META;
-	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
+	btrfs_submit_bio(bio, mirror_num);
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aad802d100e134..0c3e0ec842933e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2697,14 +2697,12 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 
 void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
-	btrfs_submit_bio(inode->root->fs_info, bio, mirror_num);
+	btrfs_submit_bio(bio, mirror_num);
 }
 
 void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * btrfs_submit_compressed_read will handle completing the bio
@@ -2714,7 +2712,7 @@ void btrfs_submit_data_read_bio(struct btrfs_inode *inode, struct bio *bio,
 		return;
 	}
 
-	btrfs_submit_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(bio, mirror_num);
 }
 
 /*
@@ -7796,7 +7794,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	dip->bytes = bio->bi_iter.bi_size;
 
 	dio_data->submitted += bio->bi_iter.bi_size;
-	btrfs_submit_bio(btrfs_sb(iter->inode->i_sb), bio, 0);
+	btrfs_submit_bio(bio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -9961,7 +9959,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -9993,7 +9990,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			if (!bytes ||
 			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
 				atomic_inc(&priv.pending);
-				btrfs_submit_bio(fs_info, bio, 0);
+				btrfs_submit_bio(bio, 0);
 				bio = NULL;
 				continue;
 			}
-- 
2.39.0

