Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE314E4383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiCVP5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiCVP5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5546606E9;
        Tue, 22 Mar 2022 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+jigdb2uz9jAenLPsaQGux6F8nfDCZstHWKKAm6vIkE=; b=xd5v9XL4E8W47NRLqPxF6rFpeP
        KTOjqzdGGqe2BDGOOs1qjja46b/L6Yx6JEaUPZz4Adzf/2b+BYszb5J5WwnIEonTSYucTIBfK8dxP
        niFvR7HvnXW0o9KLdduPtHyFMRWXjO1uyVH7ENNEKdvYvQAekjVSl0GxNGhd1g+oWjkDsEw7NZkwt
        bbmr4f/E6+2lfXCWkwwfcDB4Pg/4sXAqK9gVn/rkEtewATz57FqUTKKy4fMZy0t+JLNmim/6Ty6Xc
        qwlFOSKjuyRMYPlZf4ZAtnV4amFxTB128ng54JHWfSAPohWPgW7ZErL3brBUb3+7N6tHWJHDPQ6XP
        kIuP9txg==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgrm-00Babm-4x; Tue, 22 Mar 2022 15:56:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/40] btrfs: fix direct I/O read repair for split bios
Date:   Tue, 22 Mar 2022 16:55:28 +0100
Message-Id: <20220322155606.1267165-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a bio is split in btrfs_submit_direct, dip->file_offset contains
the file offset for the first bio.  But this means the start value used
in btrfs_check_read_dio_bio is incorrect for subsequent bios.  Add
a file_offset field to struct btrfs_bio to pass along the correct offset.

Given that check_data_csum only uses start of an error message this
means problems with this miscalculation will only show up when I/O
fails or checksums mismatch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c |  1 +
 fs/btrfs/inode.c     | 13 +++++--------
 fs/btrfs/volumes.h   |  3 +++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e9fa0f6d605ee..7ca4e9b80f023 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2662,6 +2662,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 	repair_bio = btrfs_bio_alloc(1);
 	repair_bbio = btrfs_bio(repair_bio);
+	repair_bbio->file_offset = start;
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3ef8b63bb1b5c..93f00e9150ed0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7773,8 +7773,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	const u64 orig_file_offset = dip->file_offset;
-	u64 start = orig_file_offset;
 	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
 
@@ -7784,6 +7782,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
 		pgoff = bvec.bv_offset;
 		for (i = 0; i < nr_sectors; i++) {
+			u64 start = bbio->file_offset + bio_offset;
+
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, bbio,
@@ -7796,17 +7796,13 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			} else {
 				int ret;
 
-				ASSERT((start - orig_file_offset) < UINT_MAX);
-				ret = btrfs_repair_one_sector(inode,
-						&bbio->bio,
-						start - orig_file_offset,
-						bvec.bv_page, pgoff,
+				ret = btrfs_repair_one_sector(inode, &bbio->bio,
+						bio_offset, bvec.bv_page, pgoff,
 						start, bbio->mirror_num,
 						submit_dio_repair_bio);
 				if (ret)
 					err = errno_to_blk_status(ret);
 			}
-			start += sectorsize;
 			ASSERT(bio_offset + sectorsize > bio_offset);
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
@@ -8009,6 +8005,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
 		bio->bi_private = dip;
 		bio->bi_end_io = btrfs_end_dio_bio;
+		btrfs_bio(bio)->file_offset = file_offset;
 
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			status = extract_ordered_extent(BTRFS_I(inode), bio,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 005c9e2a491a1..c22148bebc2f5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -323,6 +323,9 @@ struct btrfs_fs_devices {
 struct btrfs_bio {
 	unsigned int mirror_num;
 
+	/* for direct I/O */
+	u64 file_offset;
+
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
 	u8 *csum;
-- 
2.30.2

