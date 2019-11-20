Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D9104361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfKTSZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:25:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfKTSZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:25:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so137489plz.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dktaVG6NUYwKd02u9LQ9D8V9u7xDbqFt2b9bnH5B8nA=;
        b=nts3UtoRpLg1FN4AgAEDqhILGDQsrkR/8hrokDg2BsSHzIx2WT8OGtv0vxOQYvQeCj
         VHZUC2rJLBxbJDsR7cNexkQZJ59H5ln0K+Uvpi1E9ngs/DCkkvIvHUVL60x/W78KBqS6
         4pWqIC9SvxDmDHUFUC/G1Yf0lGlqrMOMrypUCyZBEMVA19Xs3w6RbfimvgrzyanX1+Jz
         LBE2UqWJIIme5ElD5vAvXXC4glVjg5vCF6IbStMrGDnkVWcvqQK5iXk3IP45ckU7atYZ
         Q585VPlxeasHVyfvrd+PShnOHkTyczN1mbOvquoLAs4zFkN7pTlN1ZidvQphTeOdulkm
         jV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dktaVG6NUYwKd02u9LQ9D8V9u7xDbqFt2b9bnH5B8nA=;
        b=H8hXKyI+TNGvJn1AM7CQoAgPulHUjkG+CsgDNyA4jvlF7m3DZjPtAb9XhmSXqekYw5
         wdKRKHHt6baAYcaREeYRgj5t3ncJLmJf91YQabo0B3CGwSj1q7XkZT7JpKPv7xHItLoQ
         j+bry0QnKQctFq2iYueEfuRfFTo3/UrHsjq/lD93u3TGUIn2ZuXIBOsRYzTPYd7sygIq
         1ZwS0avjWzw1sGEoDatteiRhdCOEwOiRg5WEzLjffBXICXHxPiWed78JTbHfF7RUDddS
         RHWv15KQYJ6krOiw0m2Wudf5cWzpCAWLG6xrijALCfFuX9fTdpBlPvN10ekNOITVcxAo
         tNgQ==
X-Gm-Message-State: APjAAAXrpJ8Mpl5MY35c0PnzNEqf9rqIbobRfgGTYHumCOPW+BNxkhNA
        Wmz1HxzG/4K3soeAGqd00fllow1f8us=
X-Google-Smtp-Source: APXvYqxJDL9K0/2qfRjcaAu01VnU5dCKBy/twAcCzTnsoxMEJ32DQF4D5DRh+eBns61AJ52iCECmuw==
X-Received: by 2002:a17:90a:b28c:: with SMTP id c12mr5728261pjr.22.1574274302874;
        Wed, 20 Nov 2019 10:25:02 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:25:02 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 09/12] btrfs: support different disk extent size for delalloc
Date:   Wed, 20 Nov 2019 10:24:29 -0800
Message-Id: <bfa7cb307be92418aee1cec4e23f98bf32a171de.1574273658.git.osandov@fb.com>
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

Currently, we always reserve the same extent size in the file and extent
size on disk for delalloc because the former is the worst case for the
latter. For RWF_ENCODED writes, we know the exact size of the extent on
disk, which may be less than or greater than (for bookends) the size in
the file. Add a disk_num_bytes parameter to
btrfs_delalloc_reserve_metadata() so that we can reserve the correct
amount of csum bytes. Additionally, make
btrfs_free_reserve_data_space_noquota() take a number of bytes instead
of a range, as it refers to the extent size on disk, not in the file. No
functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h          |  3 ++-
 fs/btrfs/delalloc-space.c | 38 +++++++++++++++++---------------------
 fs/btrfs/delalloc-space.h |  4 ++--
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  7 ++-----
 fs/btrfs/relocation.c     |  4 ++--
 6 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c32741879088..f9ac05d1ca60 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2489,7 +2489,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index db9f2c58eb4a..720b246772fb 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -153,34 +153,28 @@ int btrfs_check_data_free_space(struct inode *inode,
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
 	if (ret < 0)
-		btrfs_free_reserved_data_space_noquota(inode, start, len);
+		btrfs_free_reserved_data_space_noquota(fs_info, len);
 	else
 		ret = 0;
 	return ret;
 }
 
 /*
- * Called if we need to clear a data reservation for this inode
- * Normally in a error case.
+ * Called if we need to clear a data reservation, normally in an error case.
  *
  * This one will *NOT* use accurate qgroup reserved space API, just for case
  * which we can't sleep and is sure it won't affect qgroup reserved space.
  * Like clear_bit_hook().
  */
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len)
+void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+					    u64 num_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_space_info *data_sinfo;
 
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
-
+	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
 	data_sinfo = fs_info->data_sinfo;
 	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
+	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -num_bytes);
 	spin_unlock(&data_sinfo->lock);
 }
 
@@ -201,7 +195,7 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 	      round_down(start, root->fs_info->sectorsize);
 	start = round_down(start, root->fs_info->sectorsize);
 
-	btrfs_free_reserved_data_space_noquota(inode, start, len);
+	btrfs_free_reserved_data_space_noquota(root->fs_info, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len);
 }
 
@@ -280,11 +274,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
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
@@ -298,7 +292,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -333,6 +328,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 		mutex_lock(&inode->delalloc_mutex);
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -344,8 +340,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 * everything out and try again, which is bad.  This way we just
 	 * over-reserve slightly, and clean up the mess when we are done.
 	 */
-	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
-				&qgroup_reserve);
+	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
+				&meta_reserve, &qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		goto out_fail;
@@ -362,7 +358,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -474,7 +470,7 @@ int btrfs_delalloc_reserve_space(struct inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 54466fbd7075..f847f0a80409 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -13,8 +13,8 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 void btrfs_delalloc_release_space(struct inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len);
+void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+					    u64 num_bytes);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct inode *inode,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 34c1a2284e03..bc7ee7c4180e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1669,7 +1669,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
+						      reserve_bytes,
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d53580ad2c46..a8bc193c99ca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1963,9 +1963,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID &&
 		    do_list && !(state->state & EXTENT_NORESERVE) &&
 		    (*bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(
-					&inode->vfs_inode,
-					state->start, len);
+			btrfs_free_reserved_data_space_noquota(fs_info, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -7025,8 +7023,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			 * use the existing or preallocated extent, so does not
 			 * need to adjust btrfs_space_info's bytes_may_use.
 			 */
-			btrfs_free_reserved_data_space_noquota(inode, start,
-							       len);
+			btrfs_free_reserved_data_space_noquota(fs_info, len);
 			goto skip_cow;
 		}
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e3cec29813ee..af61e07b5094 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3262,8 +3262,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
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
2.24.0

