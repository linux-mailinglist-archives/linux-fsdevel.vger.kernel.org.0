Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3161742C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgB1XOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 18:14:25 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38117 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgB1XOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so1560486pju.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHE0kAC46n4gp3MuT1CeCeiS+qaMIXqXUZw5kd0etTo=;
        b=Hyr7OLv4ljRhHWx4LBtpG6KCcoBbacso2xQ3KlLedQ9riowEExNV5TP7WP8sk54+1k
         D5WTNc8mBhtNSnf+7Z8LDSltY8EZXNmZ3Zldf3IGWh1uEyHp3dF9+P3QL6QgDEHivoCX
         vaNiVoNTrxE5HjIGb3u8wh798rUpX6FuI+s/nXRh54k0cQYGMzp0kCYKFIybLXgLrb17
         vRyxu2r3EuXmzvl7CUt6+5dzLdPKrpN0toEG7v48PPk2X0IhuJpd2HbLzVZcyAD8YO8E
         yXB+SoyGpt+Ocl/FQQSEzAFCEUtaRJ2lQjRqQAkC9ba+ms/cXmopKLKdt/xY721Zw88c
         9dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHE0kAC46n4gp3MuT1CeCeiS+qaMIXqXUZw5kd0etTo=;
        b=uGmDOejmbkA3ymNmVMYoM4DbopV/x+oKT7nL47EKlJsSVhAEnskkNe5DVuyVPQN9TR
         COqPVrOdgEtQf+ftPy7ah3UxZnlW/Dj94C3i6HHQdarwVLH7S3t6MNiCZkuimXlyUXqu
         P25NSJt+RGRa+PS3ePdz2cEbzq1cCyhehSsPKTDVBjJqE5xSHY0bY7im1+xcZz8pc1yT
         Te7MEw3za5i3yaNHVG58UYRa25V7xgDoKmfkaGPZ0Znfalr1HFEmrDLroipQ/GTxE83O
         IbcvikTEoViGsNTS3ulgRrNCZZi/wXJKOfbuW5UEJD9c/Qxtnl2sIAYSTUDsC3dsyUum
         9A5Q==
X-Gm-Message-State: APjAAAW4MEPsYj7o5zoiBVB1Qc4lhy/IE674L4/kQAbvOMaFpDLoq7ap
        Ttp4ZqgHbtqTFT/HEIvJl0iswSFV0gw=
X-Google-Smtp-Source: APXvYqwIY6viGyNkcTRk/+mZX77hJgxRmIEYvoQJxuzjq2hKYs2rHAszNHqit66DNX/9V+xwyes0OQ==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr5905532plb.274.1582931658243;
        Fri, 28 Feb 2020 15:14:18 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:17 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 4/9] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Fri, 28 Feb 2020 15:13:56 -0800
Message-Id: <1de8ec77e3d57e5c9b339e2cd860cf9358f3ff41.1582930832.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1582930832.git.osandov@fb.com>
References: <cover.1582930832.git.osandov@fb.com>
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
index 9ab610cc9114..b66846272971 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -477,7 +477,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */
 
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -509,7 +510,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, true);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 36df977b64d9..d97983ab94fe 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2851,7 +2851,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
-		       u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c2f365662d55..fe4f0700e033 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -422,28 +422,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
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
 blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
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
 
@@ -458,18 +458,13 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
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
@@ -477,13 +472,14 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
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
@@ -515,7 +511,8 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 			kunmap_atomic(data);
 			crypto_shash_final(shash, (char *)(sums->sums + index));
 			index += csum_size;
-			offset += fs_info->sectorsize;
+			if (!one_ordered)
+				offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ccb3f8d528d..303613e6ec38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2075,7 +2075,7 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	struct inode *inode = private_data;
 	blk_status_t ret = 0;
 
-	ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+	ret = btrfs_csum_one_bio(inode, bio, (u64)-1, false);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -2140,7 +2140,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  0, inode, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+		ret = btrfs_csum_one_bio(inode, bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -7731,7 +7731,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 {
 	struct inode *inode = private_data;
 	blk_status_t ret;
-	ret = btrfs_csum_one_bio(inode, bio, offset, 1);
+	ret = btrfs_csum_one_bio(inode, bio, offset, false);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -7838,7 +7838,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(inode, bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(inode, bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.25.1

