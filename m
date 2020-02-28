Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08B1742C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 00:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1XO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 18:14:26 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:33379 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgB1XOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:24 -0500
Received: by mail-pl1-f170.google.com with SMTP id ay11so1823388plb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMR1dHJF2T0R1o27KIYJ1A4ZHpwiykSMWBwp5z2Q0QA=;
        b=H7RY3mtKem3iddViiAfff++CpXy+MWrWolfUqCsABK4NlOubNbiqTsO2ZRVGX7p/Px
         BYsxlnfecKeSsAk8wZASxOR3Ixve/doM6L4u+PSW36viTy54SOeYTy5JAwh6GTufYCPd
         OYNtv7c7qcjudBNaC6D+rsk5k7R8+HWcc0EuuCsVsqimJz+XAujRfTgYjfVkhWurGbs5
         oBW0bgj2vgVeH2fbOZuKm2e0vU0Wp5LVC9Ka4o5/TUTnrOh/LaRcN2mFTZxYnr0036zS
         9Eo/Rxnns00unK1cNnBfzFFZmXBeWtHkHsfXXu7LScObZ1YvfxHPArnDrt5l18RComwd
         aGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMR1dHJF2T0R1o27KIYJ1A4ZHpwiykSMWBwp5z2Q0QA=;
        b=NR0f6tbhvK6N3E0hGGj3E8gNDGCMm711pJ0oGQZ40mzQVGdfjEYVrFgKUGEmh+KJ+P
         llcAqeSDTCbHZzHJBqaSG4Vil6KBiHjXSVlXFTb06VdvDajgYyM/wHTKkkATbv/y3aGS
         vg4YVKX9xENitSo0HsFfwqjo/ed5b71SNF0/eUj81L4RoE0+Y34H2MJcSFpJDY1mpAFf
         IEYx5wgsIZId0myc+BRPnRvh6iXQ0xefMG4yNfjADg5NZnJgF7CKEMfKB/mi0NGLxTow
         G76wMrZ3ikXtr5a+mJCGg7CfgFBsF7QEzP1KumcKfF2W7+7tkbsUfRe3KFM6/FAazW4P
         mltA==
X-Gm-Message-State: APjAAAWoSMjdV/SwnGbpeYsQwX50eBFf+M895jVLeO6Jid/kPqtIuIaN
        /ugFO0SMwUMs8eRdTZh3+eXUs9GOEw4=
X-Google-Smtp-Source: APXvYqx2nB33Td/PpDqijur8Y+XXJxZAOYmX2eKR/ijhMcuLdeu/q4F2ALnUjBJyU/13SVh4t8et4w==
X-Received: by 2002:a17:902:c389:: with SMTP id g9mr5573534plg.47.1582931661308;
        Fri, 28 Feb 2020 15:14:21 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:20 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 6/9] btrfs: support different disk extent size for delalloc
Date:   Fri, 28 Feb 2020 15:13:58 -0800
Message-Id: <c3e932342e1bb360f4df69d2a8ec891e8c2a7d19.1582930832.git.osandov@fb.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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
index d97983ab94fe..72d7c249179d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2540,7 +2540,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4cdac4d834f5..7c4dfa76b8d6 100644
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
@@ -328,6 +323,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -339,8 +335,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
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
@@ -359,7 +355,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -463,7 +459,7 @@ int btrfs_delalloc_reserve_space(struct inode *inode,
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
index a16da274c9aa..bf862f59b2a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1667,7 +1667,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
+						      reserve_bytes,
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0d5b4e14f815..bcde9903d13b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2000,9 +2000,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID &&
 		    do_list && !(state->state & EXTENT_NORESERVE) &&
 		    (*bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(
-					&inode->vfs_inode,
-					state->start, len);
+			btrfs_free_reserved_data_space_noquota(fs_info, len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -7168,8 +7166,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
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
index 995d4b8b1cfd..5316245a065e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3300,8 +3300,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
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
2.25.1

