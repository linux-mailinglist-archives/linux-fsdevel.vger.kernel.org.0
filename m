Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91082B84A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKRTSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgKRTSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:51 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB268C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so2067031pfu.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71rZq3Al2a1KiY9b6apg0dcxww/Zvx2T9Uz1qDLxpkI=;
        b=nQ6RFW0ngEpzH4FF9AMzBJRcgMyCRgMfY1mDTVNJjbM47XE3VH8QRB2znOAcc1Ih0x
         gHOfwxADaQSkCOtAsYmtWFVtz7ypzyhkkhq06PAJty3Z0Z2F386sJMYZLx3pAxrrKX4R
         qgyfMo2Qo0hTmgbPBTd3ubBKqkilWO8cv14Bn2jTV/y995j+emOxSK7V1icfj8ZuJ9lE
         c4C4v6K5GRyFG2lU7NlCO9RD9qMvH3rJjLiq1i0VvWge0sukmeqCi/6bmt6mDgOU3icS
         kPr5QKwjkGZes3KTXq7jMPivy/rFhX1JrpLHK8lrWewb4isA97ihKyJpkGGXq3EojGMI
         TAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71rZq3Al2a1KiY9b6apg0dcxww/Zvx2T9Uz1qDLxpkI=;
        b=EZI7YDLyMUVI08cIjXio9OS1s0bcpfqFkMpiBvRip0Ews4VpgtjZvQlI7UFrk80cct
         tE1TB+XXa26RSMwf3HC2TXzZnU4+7j8Fcoi6wSC3lFg2GdljU7UXlb28QNJgVYWqDNiK
         0dNOLoz1QY3opsSt/S6SPiBdYeuP0in5OdutCyyvkeiyC1BDB6umrIPykry2gVGMNK75
         QGRvjnnr4ksOEjoaMXjUmyvt8mRzoypbn7fz601cEwVn0salNnBqVNboMm553rbCwWvQ
         ss41ALvUPI90ew/4L8u0PZYTcj0AP/d7pVIPo3NrIvCKEGBaC66y5TDP0engDqEp+7+c
         QvoQ==
X-Gm-Message-State: AOAM531PBNzDMV60jt7e217jyXwEP8CdtFgfJXKx5GGhQshDCXtNUTE6
        0A3qejT1LeXuVNH73kmo19IrRLqgTHvjJA==
X-Google-Smtp-Source: ABdhPJwMxgOqhQ4jEWyOFCgd40PCcrW04oR5TRxpdaDQmP6odnj62TqOIlc3FtzTUZfEXsfvS4qxrw==
X-Received: by 2002:aa7:8397:0:b029:197:6f51:8c48 with SMTP id u23-20020aa783970000b02901976f518c48mr5609218pfm.52.1605727130721;
        Wed, 18 Nov 2020 11:18:50 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:49 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 08/11] btrfs: support different disk extent size for delalloc
Date:   Wed, 18 Nov 2020 11:18:15 -0800
Message-Id: <17719a263eeb1abdc46ce2f92dff61a38fe62034.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723568.git.osandov@fb.com>
References: <cover.1605723568.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, we always reserve the same extent size in the file and extent
size on disk for delalloc because the former is the worst case for the
latter. For RWF_ENCODED writes, we know the exact size of the extent on
disk, which may be less than or greater than (for bookends) the size in
the file. Add a disk_num_bytes parameter to
btrfs_delalloc_reserve_metadata() so that we can reserve the correct
amount of csum bytes. No functional change.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h          |  3 ++-
 fs/btrfs/delalloc-space.c | 18 ++++++++++--------
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/relocation.c     |  4 ++--
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09536ecd62c7..6ab2ab002bf6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2737,7 +2737,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bacee09b7bfd..948b78f03f63 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -265,11 +265,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 }
 
 static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
-				    u64 num_bytes, u64 *meta_reserve,
-				    u64 *qgroup_reserve)
+				    u64 num_bytes, u64 disk_num_bytes,
+				    u64 *meta_reserve, u64 *qgroup_reserve)
 {
 	u64 nr_extents = count_max_extents(num_bytes);
-	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
@@ -283,7 +283,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -313,6 +314,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -324,8 +326,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 * everything out and try again, which is bad.  This way we just
 	 * over-reserve slightly, and clean up the mess when we are done.
 	 */
-	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
-				&qgroup_reserve);
+	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
+				&meta_reserve, &qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		return ret;
@@ -344,7 +346,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -448,7 +450,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7225b63b62a9..224295f8f1e1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1734,7 +1734,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					 fs_info->sectorsize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
+						      reserve_bytes,
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f261be36d1b..8e5ceeb4c686 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4697,7 +4697,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c5774a8e6ff7..038182f8233d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2678,8 +2678,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	index = (cluster->start - offset) >> PAGE_SHIFT;
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	while (index <= last_index) {
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				PAGE_SIZE);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), PAGE_SIZE,
+						      PAGE_SIZE);
 		if (ret)
 			goto out;
 
-- 
2.29.2

