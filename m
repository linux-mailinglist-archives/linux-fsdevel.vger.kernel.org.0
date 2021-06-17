Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F853ABFD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 01:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhFQXyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 19:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhFQXyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:54:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487C4C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u18so912457pfk.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmJvDLFDa5sRRYtY5SXanZph43xz2GdyexdACCVl3EM=;
        b=PlIzkHWk9mjh/PrctO0WBhXoAKSlh5pdv7cdpNL25wKN2giPQ9FJ8yt4oL+i1lTZk+
         ab1ww5j7eEO/nBpH5o0phOQMUhMdOFqTlq37//9W7wAFW1p2WwbTKJuhHhNZNWm1C5vh
         BQYmflgfp5qR+RYY4Ap1TPdUin6srs+np6pD65sMvqbv0GAcA/BuQITYfKCin9QvM8aH
         3jNTkVfdgnLdAog5lQ8g+nx23zGEZ1eh1mphlAj/6g7/3O9MAn5maN6UIszhVbRnV4fI
         vna+gPJuyks8WKJ9aeh/YxD0KqvoRrHzwRzdPsSyueywbN/btMxyvuxyTkWpcnudKCbM
         AEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmJvDLFDa5sRRYtY5SXanZph43xz2GdyexdACCVl3EM=;
        b=K65rtMcr83QpmSEDOUtnilfL83FUj2hmrXWT4dpiDOk/yYrwIKP4bTRzeDYvNqxy60
         IvqbqHhdq/CybxvgftOoUDNtaUQfZTUjIOKs9KDd7E+cBMffbd8XMDkkL7dJPP0XhoYk
         LzU/H/X62CbexhCqyk2shm/a6ojInbcLy91U+OCrMSu+Yf2YUgDszCjMRkbb/fMvTY2i
         BkYQl9PGICYCSGvnwSfnesSn9N7cZMRHpQeFmY1GKP9FHUcaQWv8tBaW4mFj/HZI4qhE
         ybC+UYIuqNYFgc1124iDyTS1chVPl7j5v5una+B0OfH1c165jArD31Drpf/5oUqVpdiI
         Dtmw==
X-Gm-Message-State: AOAM530Oyopa8hzrWLputtMsZphs2thrtkGYqQjPoykazLqXduJkfbSp
        NGuLbn5Pd2t1QvfGEdnZBnHaFpGTHFN3QQ==
X-Google-Smtp-Source: ABdhPJwT9ALvrhyEk4eqKrSZ3tdp3+DyHsCrNle5MtmNnAwVjlVbS0Rjmc8mkXEeWWjP2DgfjLVitA==
X-Received: by 2002:a62:78d4:0:b029:2ea:ba:234c with SMTP id t203-20020a6278d40000b02902ea00ba234cmr2096916pfc.53.1623973913343;
        Thu, 17 Jun 2021 16:51:53 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:2f0e])
        by smtp.gmail.com with ESMTPSA id a187sm6087517pfb.66.2021.06.17.16.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:51:52 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH RESEND x3 v9 4/9] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Thu, 17 Jun 2021 16:51:27 -0700
Message-Id: <37c7aa80d64e67d99d558a811d45f7edd22ba085.1623972519.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623972518.git.osandov@fb.com>
References: <cover.1623972518.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  5 +++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 35 ++++++++++++++++-------------------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9a023ae0f98b..59733573ed08 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -481,7 +481,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */
 
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -517,7 +518,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, true);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6131b58f779f..dd37ec16f22a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3094,7 +3094,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index df6631eefc65..2ab1494c32d5 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -615,28 +615,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
- * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contain potentially discontiguous bio vecs
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
 
 	nofs_flag = memalloc_nofs_save();
@@ -650,18 +650,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	if (contig)
-		offset = file_start;
-	else
-		offset = 0; /* shut up gcc */
-
 	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!contig)
+		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 
 		if (!ordered) {
@@ -669,13 +664,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
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
@@ -706,7 +702,8 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 					    sums->sums + index);
 			kunmap_atomic(data);
 			index += fs_info->csum_size;
-			offset += fs_info->sectorsize;
+			if (!one_ordered)
+				offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2494c645681..994f9cea72cb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2268,7 +2268,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 					   u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
 
 static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
@@ -2431,7 +2431,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -7994,7 +7994,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 						     struct bio *bio,
 						     u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -8053,7 +8053,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.32.0

