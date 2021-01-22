Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5EC300E23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbhAVUvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730609AbhAVUuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:50:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861FC0611C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so3988524plh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kw3F5rWDMcL6nOv1EKwx/gx++jd0GsSbmo5x3yxoxT0=;
        b=0Idg9QUUqpDhVaSM4ZrUNVzHPYRC9BwAS1R/vQP+EGu1+AtS6iFj5eHoyqtnTOZXZk
         ID3mwfTUpUa2zNhB1zOyxdbCPoEyQL5yzHoREmzTfYDPT5jwJybSKTZgMpWoOZKoJapI
         UyQ/M5r7mQl+nZfYxu4/3MQxldAQCEXuxIZbp0YpmA/SFT3mm4i4W12FnMaFH6fXcsNR
         WqmJnB7ygbXpqWLNcPZkfscUAgbpKYPWbWV+3Hx3aA3e5g8hXReBzUqsf4/zP6Uh5PWc
         haqqGpQ+MtYdVTs8p6SGdeWX7OX82ULXD1JIKkHBLdtZixTku8sWt486YDIglboAdpnN
         n1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kw3F5rWDMcL6nOv1EKwx/gx++jd0GsSbmo5x3yxoxT0=;
        b=rqtQA0TvlVIM2v7GYHSQmpzJafXUdR6LW6vTem/imy3mPxB0dpRZYS+r+W2fJQeVxI
         libxhJHf/gqPRB3fUfu7tGuW/4jBAfjj78NO0e1V/jjmBLhs2kNwIJCg+4jaG2l5frO0
         tZU/jmYyQ27En2XBnei8mWgLidSQYvZQ3R1jdMKjZ2zmZYyBhWCOmEnNcKJFDFwKMxhF
         n1h4uvHwp/42EQYGzwJ6pRaYro04uWFb+Llw0DZgM/UL2erMRnPpwtfVgrpAZGgajbvV
         +WgouFN+kZgfmNqE5HissPd027wfzQYs3/xCoJ6y4GJVM731Ox52ORrbFLfLlTVTORT/
         +0fg==
X-Gm-Message-State: AOAM5331z0aoVaoNLXFVO9zYYAusJv5Mnq9gOeAW0QjKtA1Hs67yLQw6
        kj8RiNhGhBsFlUvkF0X81nF6UJFGltzsUA==
X-Google-Smtp-Source: ABdhPJx2Kbm4mC28XaaS1EC0zEMrJVAG7ReNdBuiUIt311GT2CnHbpO7sKgNAuS3rmUIQtSzt0qrmw==
X-Received: by 2002:a17:902:7102:b029:de:aa85:e04e with SMTP id a2-20020a1709027102b02900deaa85e04emr6425718pll.23.1611348455821;
        Fri, 22 Jan 2021 12:47:35 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:34 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 07/10] btrfs: support different disk extent size for delalloc
Date:   Fri, 22 Jan 2021 12:46:54 -0800
Message-Id: <781bf3370a61ad265cff3b89fc8c168d6146ad01.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
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
index f1b9a9e42cc6..3a0c4fb4c657 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2746,7 +2746,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
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
index d81ae1f518f2..32578f31cf43 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1733,7 +1733,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
index 139d690f171e..3c1f1297c9d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4712,7 +4712,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9f2289bcdde6..85e9e7287bfd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2660,8 +2660,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
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
2.30.0

