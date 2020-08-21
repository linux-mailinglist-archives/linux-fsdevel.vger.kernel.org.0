Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8D24CF7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHUHj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgHUHjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:39:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BBC061346
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so524620plr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXisnxwmeoeObWMPR3mFNC4S4siYwhBR12pikg1nHJw=;
        b=t3PlAiOQmshc7a03MNXk5DSrA1ePUHGJUbsggq/VtCTRy/j3KzDbvw7ii815XMnr2N
         VDeWLsqV9U/6DqyRnjb10yzmerpezZXJ1TGrDM3Q+EcRikM+YvyatBl1iGf+5qeIsStJ
         nwi9LxsmC95pZIkURiNSuOX0900wBa0M1Dx/eyydKrI0pCZBz24nd2BUQ9fApR77YrQ1
         ZAHk82UXIsJ7tWZKE2eTPnf5oIDc+UbcgKIWdMCznpj7gNuEKidNvGbQDP2s3FWz2a8E
         ruLO6gFOMHbY9hfNqHhAfWtjAYi2y2IkMhHCCsG61/RWCMNeHT/qlnrON+qxpeV4UNwo
         EvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXisnxwmeoeObWMPR3mFNC4S4siYwhBR12pikg1nHJw=;
        b=MAdYjivThgmJNlQEvkclivyM1wUo1bOFwe8tLI6V1TXshTknBvDJEzT5r/Gc/r7gOu
         YOSFvdTlUfXOFjQovqRxO/+yvspYvWE2/JH9gtGMHiDIGgTWevYtJy7u1jpMHiyruXL4
         n4Kzp380heqFB86Y8M06Df4/pST1CUFxPeYXlp+JPPp5/9wdzZba2VmARdfpEg3xDlxV
         yO9fa+JDnJvVyJ4sgouso+Mr7nAd6W/VQcrXzYUvJB3Cxxc+BPD6aoGJ1+fCsZ+T65hS
         dvuy4Xms/0HE/OANMjRXzP7MFLUX6KCtdyv2e4gMVxbbqAQDIN1PiqpKUlxNRlsiVM8r
         5Zzg==
X-Gm-Message-State: AOAM5317Kd85EVOthfR+Fh5eM89ctW6OpH+BnQQ4+WUJJMFYif3mdVps
        BHDeg48XUxf+qTFj0mCi3evLcVd5Q0fAAQ==
X-Google-Smtp-Source: ABdhPJwVILao6rR4zT7AnI9ql7lDhQJxxNwBKPtlI4d4Gkr7/iewsNfEM/3e8ijIEx+iPSeLFIw5kg==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr1309399plb.143.1597995540347;
        Fri, 21 Aug 2020 00:39:00 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:59 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 4/9] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Fri, 21 Aug 2020 00:38:35 -0700
Message-Id: <27758a7a731919591194696ddc651623481b9691.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_csum_one_bio() loops over each filesystem block in the bio while
keeping a cursor of its current logical position in the file in order to
look up the ordered extent to add the checksums to. However, this
doesn't make much sense for compressed extents, as a sector on disk does
not correspond to a sector of decompressed file data. It happens to work
because 1) the compressed bio always covers one ordered extent and 2)
the size of the bio is always less than the size of the ordered extent.
However, the second point will not always be true for encoded writes.

Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
it can assume that the bio only covers one ordered extent. Since we're
already changing the signature, let's get rid of the contig parameter
and make it implied by the offset parameter, similar to the change we
recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
nr_sectors to blockcount to make it clear that it's the number of
filesystem blocks, not the number of 512-byte sectors.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  5 +++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 35 ++++++++++++++++-------------------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index eeface30facd..aa292d285550 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -438,7 +438,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */
 
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -470,7 +471,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, true);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3b110ffbc93..cbbfaedd6e3c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2917,7 +2917,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7d5ec71615b8..96026ba5c58d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -516,28 +516,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
- * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contains potentially discontigous bio vecs
- *		 so the logical offset of each should be calculated separately.
+ * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
+ *               file offsets are determined from the page offsets in the bio.
+ *               Otherwise, this is the starting file offset of the bio vecs in
+ *               @bio, which must be contiguous.
+ * @one_ordered: If true, @bio only refers to one ordered extent.
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
+	const bool page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	int index;
-	int nr_sectors;
+	int blockcount;
 	unsigned long total_bytes = 0;
 	unsigned long this_sum_bytes = 0;
 	int i;
-	u64 offset;
 	unsigned nofs_flag;
 	const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
@@ -552,18 +552,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	if (contig)
-		offset = file_start;
-	else
-		offset = 0; /* shut up gcc */
-
 	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!contig)
+		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 
 		if (!ordered) {
@@ -571,13 +566,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 			BUG_ON(!ordered); /* Logic error */
 		}
 
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
+		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
 						 bvec.bv_len + fs_info->sectorsize
 						 - 1);
 
-		for (i = 0; i < nr_sectors; i++) {
-			if (offset >= ordered->file_offset + ordered->num_bytes ||
-			    offset < ordered->file_offset) {
+		for (i = 0; i < blockcount; i++) {
+			if (!one_ordered &&
+			    (offset >= ordered->file_offset + ordered->num_bytes ||
+			     offset < ordered->file_offset)) {
 				unsigned long bytes_left;
 
 				sums->len = this_sum_bytes;
@@ -608,7 +604,8 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 					    sums->sums + index);
 			kunmap_atomic(data);
 			index += csum_size;
-			offset += fs_info->sectorsize;
+			if (!one_ordered)
+				offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 144b9bd79cfb..847b92c93a7f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2162,7 +2162,7 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 {
 	struct inode *inode = private_data;
 
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
 
 /*
@@ -2225,7 +2225,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  0, inode, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -7609,7 +7609,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 {
 	struct inode *inode = private_data;
 
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, false);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -7668,7 +7668,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.28.0

