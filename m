Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43ED7F54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfJOSnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:43:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40211 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389241AbfJOSnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so13024708pfb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ob1ielu62scvCPElhOPfrcp3zV8IJ5Kidb991l7KPUg=;
        b=vMK9lfe6h4wUzziMJqGb+LzhC7kdqjIgQ/t7j4EXBi95ZBGjQIqjiBMtOLPlQ47GMH
         nQ7/48j09w8ejBIzROr6RjYby0ipQYyRd0seWiVNl9nh5RmniOYXeM8zBnji5yd/uXej
         NDQW7I1RWdqiwggXmjReo/kGiAiStU6+zJLuzbuequ7Q6nzV/ZCvepoJYQffovmsAvEw
         +ainHyOxj0TVN+dukoNY5xW7Rr556DOsEFFxy0mAlpNPA+LyWzt6xQttqxiGJyOWz/0r
         yVk9KCy/kGafxGG8E1vLb3e66KttxoYZeU2bkBAcGjhSrilbwNFspOCQ82XJMj6wnliS
         ZSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ob1ielu62scvCPElhOPfrcp3zV8IJ5Kidb991l7KPUg=;
        b=MB4+MnfZ5i1yaPpyrE1yTdiAUBxhoyk4Vevs8/8CMbpYo6RFMMDZJJZY/FTfh5U7Pl
         hTckVpN8gkGtp1/MhskazIXhn29siBsTIlnlGxDbqc0slgwgMwWVWzYn2jlnkm0tPpHg
         qImBYnVToIMtmNBmoreJnA/RGWhgUaI439N385EyQ1VqUK95msZpwEwPnRDKXvrf453t
         Odl+y6RsDostMl7fezQwjRAs0QP8Rbg4drPJe3XsZCHzc5Koa1uTdoFCjU0cD+q9aG0N
         5dsJqFiAWTl5CAqRZ/ifzftE6wjwxv1warpuR896LDi7+3FmW8/xxZMxSpwztrwcnZKy
         d3WA==
X-Gm-Message-State: APjAAAUVvytkEVMhmeOFKFL9goThOdcppKX2pPiYQXRs2gRa9QqB+XC1
        7MJqxkD42HnqjOEtHGvhrDLGN8+Ws3E=
X-Google-Smtp-Source: APXvYqyCuLWWk3+rz48gsDKb6ODVF6rPO2+LUEEMtEsd5P65CRiCp7LwHG20me+uMf/Lc24soBCOng==
X-Received: by 2002:a17:90a:8003:: with SMTP id b3mr44492032pjn.43.1571164986984;
        Tue, 15 Oct 2019 11:43:06 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:06 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 3/5] btrfs: generalize btrfs_lookup_bio_sums_dio()
Date:   Tue, 15 Oct 2019 11:42:41 -0700
Message-Id: <01fdb646d7572f7d0d123937835db5c605e25a5e.1571164762.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571164762.git.osandov@fb.com>
References: <cover.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This isn't actually dio-specific; it just looks up the csums starting at
the given offset instead of using the page index. Rename it to
btrfs_lookup_bio_sums_at_offset() and add the dst parameter. We might
even want to expose __btrfs_lookup_bio_sums() as the public API instead
of having two trivial wrappers, but I'll leave that for another day.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h     |  5 +++--
 fs/btrfs/file-item.c | 18 +++++++++---------
 fs/btrfs/inode.c     |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..71552b2ca340 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2791,8 +2791,9 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 				   u8 *dst);
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
-			      u64 logical_offset);
+blk_status_t btrfs_lookup_bio_sums_at_offset(struct inode *inode,
+					     struct bio *bio, u64 offset,
+					     u8 *dst);
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     u64 objectid, u64 pos,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1a599f50837b..d98f06fc2978 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -148,8 +148,9 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
-				   u64 logical_offset, u8 *dst, int dio)
+static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode,
+					    struct bio *bio,
+					    bool at_offset, u64 offset, u8 *dst)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio_vec bvec;
@@ -159,7 +160,6 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_path *path;
 	u8 *csum;
-	u64 offset = 0;
 	u64 item_start_offset = 0;
 	u64 item_last_offset = 0;
 	u64 disk_bytenr;
@@ -205,15 +205,13 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
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
@@ -291,12 +289,14 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 				   u8 *dst)
 {
-	return __btrfs_lookup_bio_sums(inode, bio, 0, dst, 0);
+	return __btrfs_lookup_bio_sums(inode, bio, false, 0, dst);
 }
 
-blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio, u64 offset)
+blk_status_t btrfs_lookup_bio_sums_at_offset(struct inode *inode,
+					     struct bio *bio, u64 offset,
+					     u8 *dst)
 {
-	return __btrfs_lookup_bio_sums(inode, bio, offset, NULL, 1);
+	return __btrfs_lookup_bio_sums(inode, bio, true, offset, dst);
 }
 
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f2754eaa05b..8bce46122ef7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8319,8 +8319,8 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 	 * contention.
 	 */
 	if (dip->logical_offset == file_offset) {
-		ret = btrfs_lookup_bio_sums_dio(inode, dip->orig_bio,
-						file_offset);
+		ret = btrfs_lookup_bio_sums_at_offset(inode, dip->orig_bio,
+						      file_offset, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.23.0

