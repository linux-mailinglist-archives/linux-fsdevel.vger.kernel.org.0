Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BBA104358
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKTSZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34748 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfKTSY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so153418pff.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UITnFvX5GeaGsArn5VbTQFbb6fm1+utex+H31BrX7lo=;
        b=pa4rOzYVpCl1ER8VDX3Dpc8SFMEJYr/HjJcgJGnRllnNNBz7ogCa52/eZATRyF3bFe
         J5S4B3dUOID0x0xQHW5r5bYurYacDKknQYpZUWjJCgDXyW8G81M37fzPXj4zzscKPdbm
         DlGlKF6MmC9BjpyyKUg+2JMstIlbKzJq70HdwYyMRukIg0SOcreh3IzP4kDooJGleJkK
         mi37w6UwJ2ZOtnwseDOGewkPPl2psssSbRhxK3invITC4WAfB9zkCQZjyLpaRALxJpoz
         hmhwGuWEJJqgQBENc9FiFsI2s072RSfzetBXsxCRbNdnuW1kPIQHqmv7kNHqUaGUcZPn
         WfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UITnFvX5GeaGsArn5VbTQFbb6fm1+utex+H31BrX7lo=;
        b=Z5C3xRP5pjTgJYlHJdauHZuwyz+BuAZLWOykr2/EBS0k8uYRpiTAsWz+q3Ef9j9Vtv
         THJ8jwGsqqlPXGjx1bPob4bBAkD79wUavCHhLDPAagH9vTPc/fMvjDCgpgmiAcqjcuxh
         CFzHr10KInNTScx0LnNBVOixLhJCetwZJT2OSn4esiguze68lPcwy5REwuBtj3qf6Gs6
         FUmArZKWaM0si3jHX8RN3FfjigmW4MAx0pcmGzeujtw1iJbOcA9vwpKKlDBxSdCrs2X6
         t5JqecaQKzpgezvkjUZmfYrp0Q8X5oviH7GmdhOXvU+7bL4DdHPbxMH3ART6ZlkL3pWP
         0R0A==
X-Gm-Message-State: APjAAAU7b2w1A8dGa63c2iWrUwyRtt9Vsnhxki4KPqf4tvjsx3jT8iuK
        LL9RaVJIcF+1pVfbShg6vI6vkiQaTD4=
X-Google-Smtp-Source: APXvYqwdQwafgTnP2BIYzZtBSm+F64wF+CtZELHdbpht99PXCMxbYZ73F61WALyYtXO/slg6GU158w==
X-Received: by 2002:a65:4342:: with SMTP id k2mr4906215pgq.63.1574274297353;
        Wed, 20 Nov 2019 10:24:57 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:56 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 05/12] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Wed, 20 Nov 2019 10:24:25 -0800
Message-Id: <a669365a9165b18814c635f61ed566fdcd47a96f.1574273658.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_csum_one_bio() loops over each sector in the bio while keeping a
cursor of its current logical position in the file in order to look up
the ordered extent to add the checksums to. However, this doesn't make
much sense for compressed extents, as a sector on disk does not
correspond to a sector of decompressed file data. It happens to work
because 1) the compressed bio always covers one ordered extent and 2)
the size of the bio is always less than the size of the ordered extent.
However, the second point will not always be true for encoded writes.

Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
it can assume that the bio only covers one ordered extent. Since we're
already changing the signature, let's make contig bool instead of int,
too.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  5 +++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 19 +++++++++++--------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4df6f0c58dc9..05b6e404a291 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -374,7 +374,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */
 
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true, true);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -405,7 +406,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, true, true);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4bc40bf49b0e..c32741879088 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2802,7 +2802,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
-		       u64 file_start, int contig);
+				u64 file_start, bool contig, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a87c40502267..c95772949b00 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -423,13 +423,14 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
  * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contains potentially discontigous bio vecs
- *		 so the logical offset of each should be calculated separately.
+ * @contig:      If true, all bio vecs in @bio are contiguous and they begin at
+ *               @file_start in the file. If false, @bio may contain
+ *               discontigous bio vecs, so the logical offset of each should be
+ *               calculated separately (@file_start is ignored).
+ * @one_ordered: If true, @bio only refers to one ordered extent.
  */
 blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 file_start, bool contig, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -482,8 +483,9 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < nr_sectors; i++) {
-			if (offset >= ordered->file_offset + ordered->len ||
-				offset < ordered->file_offset) {
+			if (!one_ordered &&
+			    (offset >= ordered->file_offset + ordered->len ||
+			     offset < ordered->file_offset)) {
 				unsigned long bytes_left;
 
 				sums->len = this_sum_bytes;
@@ -515,7 +517,8 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
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
index ad5bffb24199..4c1ed6dddfd8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2039,7 +2039,7 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	struct inode *inode = private_data;
 	blk_status_t ret = 0;
 
-	ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+	ret = btrfs_csum_one_bio(inode, bio, 0, false, false);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -2104,7 +2104,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  0, inode, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+		ret = btrfs_csum_one_bio(inode, bio, 0, false, false);
 		if (ret)
 			goto out;
 	}
@@ -8272,7 +8272,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 {
 	struct inode *inode = private_data;
 	blk_status_t ret;
-	ret = btrfs_csum_one_bio(inode, bio, offset, 1);
+	ret = btrfs_csum_one_bio(inode, bio, offset, true, false);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -8379,7 +8379,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(inode, bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(inode, bio, file_offset, true, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.24.0

