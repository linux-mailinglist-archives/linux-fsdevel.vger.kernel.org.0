Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223B9104354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfKTSY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:24:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfKTSY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so150119pgn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qMYv5tjBXDa9AgtLdt13OsJPn/dRLq8/h3Hp1LbqA28=;
        b=F98d6NDqUB3szlMIApRztfx+e6G8M2lTvX8Ese0eCyXAmywQqCHlIp0efPnAM4Cfc8
         4QvR39ZWqyqr6vPsX74Pmhe0DbvDWzALLlzZ10K6lB9r/Wswxaw+sF70Z2zbHmqTVKcs
         DGrwkahvKaCcl2WwqdLA3uSzJcxK8TAY9vf4T4hg4C4F5kuyMfA/5DdXshz+w6h/OF68
         /aZ8TKZ7CSAZdH6gi/jxqAP6bzaDTv8nh+V2YeYXeZQzxMhZLqPG820P1XC2E2M0JTrB
         6J91x9J+adKsOapEKpPaz4d1cKnQ8MKgBgfXeutwABGtOnI0n0b74dnmtIV5M03VxN4L
         bTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qMYv5tjBXDa9AgtLdt13OsJPn/dRLq8/h3Hp1LbqA28=;
        b=dTly0tPE1ewXSvmhU/MTGOUM2Se4znUm4PQRhEwuQ4iJyH6i05gQVDuZ1qbsN6qksN
         BcM7R1ROJ1s8EPjCEhVu2L02d8fbFKpijgATJAA1l5pcU26fXSo5QDK8NBW5yCgb2ILT
         596L3Tw2BbxXoB7AirGKB8+8OYo3eo9yVZeGk1fUXA6NTnokpTJo4uSgYux8NKe0NTyM
         rndrO8E5yXb69hkyFrOBqP19jMblh0XtwpUbBzGi93iPv/ZL5u9ZZSYyUP5mlMIT34Qa
         /NQVQ70eQMzZsVEwm4Eiz1Pcv1WV2E2oq4z4ZpbbsDhmwz8iWMFGEgaQQgKA/9CANyul
         18LQ==
X-Gm-Message-State: APjAAAVqX+TjYkyda2mhbaV48UbADgZTUugY2KIbuU2kxvvyz2KbdWYW
        Vp4aH694NOu6+jNb7LQ6YB36EWxliXE=
X-Google-Smtp-Source: APXvYqy0Hh290nMDk9TfBV3dkkZv50HMvndZzeQszGuqRud6bGPb5TAlbldCGmJ68BC3Y79xAypLDg==
X-Received: by 2002:a63:ff1e:: with SMTP id k30mr4668135pgi.273.1574274295768;
        Wed, 20 Nov 2019 10:24:55 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:54 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 04/12] btrfs: get rid of trivial __btrfs_lookup_bio_sums() wrappers
Date:   Wed, 20 Nov 2019 10:24:24 -0800
Message-Id: <bca47beb2f4eef766accebef683137e94313f7d3.1574273658.git.osandov@fb.com>
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

Currently, we have two wrappers for __btrfs_lookup_bio_sums():
btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
btrfs_lookup_bio_sums(), which is used everywhere else. The only
difference is that the _dio variant looks up csums starting at the given
offset instead of using the page index, which isn't actually direct
I/O-specific. Let's clean up the signature and return value of
__btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
rid of the trivial helpers.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/ctree.h       |  4 +---
 fs/btrfs/file-item.c   | 35 +++++++++++++++++------------------
 fs/btrfs/inode.c       |  6 +++---
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..4df6f0c58dc9 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -660,7 +660,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    sums);
+							    false, 0, sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -689,7 +689,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
+		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fe2b8765d9e6..4bc40bf49b0e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2787,9 +2787,7 @@ struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u8 *dst);
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
-			      u64 logical_offset);
+				   bool at_offset, u64 offset, u8 *dst);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1a599f50837b..a87c40502267 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -148,8 +148,21 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 logical_offset, u8 *dst, int dio)
+/**
+ * btrfs_lookup_bio_sums - Look up checksums for a bio.
+ * @inode: inode that the bio is for.
+ * @bio: bio embedded in btrfs_io_bio.
+ * @at_offset: If true, look up checksums for the extent at @c offset.
+ *             If false, use the page offsets from the bio.
+ * @offset: If @at_offset is true, offset in file to look up checksums for.
+ *          Ignored otherwise.
+ * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
+ *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
+ *
+ * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
+ */
+blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
+				   bool at_offset, u64 offset, u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
@@ -159,7 +172,6 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
 	u8 *csum;
-	u64 offset = 0;
 	u64 item_start_offset = 0;
 	u64 item_last_offset = 0;
 	u64 disk_bytenr;
@@ -205,15 +217,13 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	}
 
 	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
-	if (dio)
-		offset = logical_offset;
 
 	bio_for_each_segment(bvec, bio, iter) {
 		page_bytes_left = bvec.bv_len;
 		if (count)
 			goto next;
 
-		if (!dio)
+		if (!at_offset)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
 					       csum, nblocks);
@@ -285,18 +295,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 
 	WARN_ON_ONCE(count);
 	btrfs_free_path(path);
-	return 0;
-}
-
-blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u8 *dst)
-{
-	return __btrfs_lookup_bio_sums(inode, bio, 0, dst, 0);
-}
-
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio, u64 offset)
-{
-	return __btrfs_lookup_bio_sums(inode, bio, offset, NULL, 1);
+	return BLK_STS_OK;
 }
 
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 015910079e73..ad5bffb24199 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2090,7 +2090,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 							   bio_flags);
 			goto out;
 		} else if (!skip_sum) {
-			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+			ret = btrfs_lookup_bio_sums(inode, bio, false, 0, NULL);
 			if (ret)
 				goto out;
 		}
@@ -8332,8 +8332,8 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 	 * contention.
 	 */
 	if (dip->logical_offset == file_offset) {
-		ret = btrfs_lookup_bio_sums_dio(inode, dip->orig_bio,
-						file_offset);
+		ret = btrfs_lookup_bio_sums(inode, dip->orig_bio, true,
+					    file_offset, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.24.0

