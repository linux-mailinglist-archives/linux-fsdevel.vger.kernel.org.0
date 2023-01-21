Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B08676465
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAUGvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUGv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE97314F;
        Fri, 20 Jan 2023 22:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xKhCu8JLJ4NatW9uazoyLPfMiFijTe8Gj4hYaRPjh+c=; b=euM09mK/1uc5I1UyxxQrL6e8JB
        U+tIZuEE4wFM915KqFygK9hiuCZD3Qrg5mbHXljbIfOOUSSB1xNUZ5HadonLhmePE4U+Mer11xVlP
        S0zmUY3JeqJ/SFvnX53Ni3yeFxYDmboJHw38YLmh6maILwCc/VrBn7GWnnLCEX4xhO7GBlHhTe/+v
        Z+JlBy1zkyPIS/UN/22rZMpal0LQY9vj1YaOEYa+8zVV0mQXbRqQWuJI4Vrc40hu37zDo/MAd9IAf
        tUnNuRERt/OD0f+6U60NiOUdrzDC0W8W1Z79jqJdItRcGRsM1su+wQ9iy7Gq6b81bYQTrD2esRWUw
        b/GYBwzw==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7ie-00DRUV-4P; Sat, 21 Jan 2023 06:51:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/34] btrfs: rename the iter field in struct btrfs_bio
Date:   Sat, 21 Jan 2023 07:50:13 +0100
Message-Id: <20230121065031.1139353-17-hch@lst.de>
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

Rename iter to saved_iter and move it next to the repair internals
and nothing outside of bio.c should be touching it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 12 ++++++------
 fs/btrfs/bio.h |  7 +++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e32a2dac97c541..f1566919fdb969 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -109,7 +109,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
-		repair_bbio->bio.bi_iter = repair_bbio->iter;
+		repair_bbio->bio.bi_iter = repair_bbio->saved_iter;
 
 		mirror = next_repair_mirror(fbio, mirror);
 		if (mirror == fbio->bbio->mirror_num) {
@@ -126,7 +126,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 		mirror = prev_repair_mirror(fbio, mirror);
 		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
 				  repair_bbio->file_offset, fs_info->sectorsize,
-				  repair_bbio->iter.bi_sector <<
+				  repair_bbio->saved_iter.bi_sector <<
 					SECTOR_SHIFT,
 				  bv->bv_page, bv->bv_offset, mirror);
 	} while (mirror != fbio->bbio->mirror_num);
@@ -152,7 +152,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	struct btrfs_inode *inode = failed_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
-	const u64 logical = failed_bbio->iter.bi_sector << SECTOR_SHIFT;
+	const u64 logical = failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT;
 	struct btrfs_bio *repair_bbio;
 	struct bio *repair_bio;
 	int num_copies;
@@ -179,7 +179,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
-	repair_bio->bi_iter.bi_sector = failed_bbio->iter.bi_sector;
+	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
 	bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
 
 	repair_bbio = btrfs_bio(repair_bio);
@@ -198,7 +198,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio,
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned int sectorsize = fs_info->sectorsize;
-	struct bvec_iter *iter = &bbio->iter;
+	struct bvec_iter *iter = &bbio->saved_iter;
 	blk_status_t status = bbio->bio.bi_status;
 	struct btrfs_failed_bio *fbio = NULL;
 	u32 offset = 0;
@@ -435,7 +435,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	 * data reads.
 	 */
 	if (bio_op(bio) == REQ_OP_READ && !(bio->bi_opf & REQ_META)) {
-		bbio->iter = bio->bi_iter;
+		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
 			goto fail;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 61a791cf5360f3..c232148348dfe3 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -39,17 +39,20 @@ struct btrfs_bio {
 	 * it's a metadata bio.
 	 */
 	unsigned int is_metadata:1;
-	struct bvec_iter iter;
 
 	/* Inode and offset into it that this I/O operates on. */
 	struct btrfs_inode *inode;
 	u64 file_offset;
 
 	union {
-		/* For data checksum verification. */
+		/*
+		 * Data checksumming and original I/O information for internal
+		 * use in the btrfs_submit_bio machinery.
+		 */
 		struct {
 			u8 *csum;
 			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+			struct bvec_iter saved_iter;
 		};
 
 		/* For metadata parentness verification. */
-- 
2.39.0

