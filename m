Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B046426674F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgIKRli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgIKMl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828118; x=1631364118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DdJ2WoO+IKj9YOAKkTk0KAiDzgVmtP5MBJprXieter4=;
  b=qKxWpvZErV1uG55tRdZm+8O1JeiLuW81Q8+v5dTCv48mjeYxY0NDlCHi
   XNrFz025K5pu8c7yQftCUij/c0nTcCwdCGCdQb9eG+CY20gzWonCO7T7J
   a9h8o+P5wvJFPLBZkyhs/XdpBkPGmAzjLzPk2Lqo8IxX24IVbNJiTgwyW
   wf8sRNR8Tz8e49SXZcgrYg4eh/MgwQSUEEPIWSP8hrEZoBfw787PMqwS0
   rKbcAFltzdL6M5a0lIEl5kwfyJcmLDYgMn056Mi4qOaEa97kLZGbVp+SU
   QfEBjVJeBoMY3wfxBV1t5p8WEtFtFj38hqjymA0kXB/B+74dKPilh9qx/
   Q==;
IronPort-SDR: 1wY9GhyNQsDOQ22geyO6ea0R9GhHEWsUKsM/ggpMxR0qTmcxuiMCZlN8OWKkvC23b6r2c5cFnd
 e9U3pchlR4nvHcM5Z4wSAIq3nodh0CT1ubLOOfS4Rpi1sAU9Np0Ktu22FBcsPs844bsb9x/y8f
 Fm17E6zdb7LUc0IqRQISt2BDbPyT7z9/w+dncsShB1hh1XW9H0OZeXi6C8VH+9pxtfSCo3e4zR
 inzK+boWqf2bc7uPfDjjr7t0hsW+AUU/KUzGstOmzMx0RQ53gpnzeY4yUQAt/VFQj7XdcZ0uZ5
 Zpo=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126043"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:59 +0800
IronPort-SDR: OAoPuWySs4gAVqvodxI7K9MfLZjlfNloh3Xm1RVDLni5mpxIQupowRSx96Lciu5+ZwUC9kmlYQ
 ZvaObtULyfZg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:20 -0700
IronPort-SDR: 7QrXEQkDh7S4BcldhZ3S5TeDZFY74EQhk24DBwxf7PzGFlEM3drpd/5P7NrWcXpgVZvbGoYVRR
 rHNYrV6popjQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 36/39] btrfs: extend zoned allocator to use dedicated tree-log block group
Date:   Fri, 11 Sep 2020 21:32:56 +0900
Message-Id: <20200911123259.3782926-37-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/3 patch to enable tree log on ZONED mode.

The tree-log feature does not work on ZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing from a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes that ZONED mode must avoid.

We can introduce a dedicated block group for tree-log blocks so that
tree-log blocks and other metadata blocks can be separated write streams.
As a result, each write stream can now be written to devices separately.
"fs_info->treelog_bg" tracks the dedicated block group and btrfs assign
"treelog_bg" on-demand on tree-log block allocation time.

This commit extends the zoned block allocator to use the block group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  7 +++++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent-tree.c | 68 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index be5394c8ec3a..d30eba3c484a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -939,6 +939,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&cluster->refill_lock);
 
+	if (btrfs_fs_incompat(fs_info, ZONED)) {
+		spin_lock(&fs_info->treelog_bg_lock);
+		if (fs_info->treelog_bg == block_group->start)
+			fs_info->treelog_bg = 0;
+		spin_unlock(&fs_info->treelog_bg_lock);
+	}
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e08fe341cd81..6e05eb180a77 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -942,6 +942,8 @@ struct btrfs_fs_info {
 	int send_in_progress;
 
 	struct mutex zoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 79ac8fcc5c35..9e576977f416 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3506,6 +3506,9 @@ struct find_free_extent_ctl {
 
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
+
+	/* Allocation is called for tree-log */
+	bool for_treelog;
 };
 
 
@@ -3706,23 +3709,54 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			       struct find_free_extent_ctl *ffe_ctl,
 			       struct btrfs_block_group **bg_ret)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_space_info *space_info = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 start = block_group->start;
 	u64 num_bytes = ffe_ctl->num_bytes;
 	u64 avail;
+	u64 bytenr = block_group->start;
+	u64 log_bytenr;
 	int ret = 0;
+	bool skip;
 
 	ASSERT(btrfs_fs_incompat(block_group->fs_info, ZONED));
 
+	/*
+	 * Do not allow non-tree-log blocks in the dedicated tree-log block
+	 * group, and vice versa.
+	 */
+	spin_lock(&fs_info->treelog_bg_lock);
+	log_bytenr = fs_info->treelog_bg;
+	skip = log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
+			      (!ffe_ctl->for_treelog && bytenr == log_bytenr));
+	spin_unlock(&fs_info->treelog_bg_lock);
+	if (skip)
+		return 1;
+
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
+	spin_lock(&fs_info->treelog_bg_lock);
+
+	ASSERT(!ffe_ctl->for_treelog ||
+	       block_group->start == fs_info->treelog_bg ||
+	       fs_info->treelog_bg == 0);
 
 	if (block_group->ro) {
 		ret = 1;
 		goto out;
 	}
 
+	/*
+	 * Do not allow currently using block group to be tree-log dedicated
+	 * block group.
+	 */
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
+	    (block_group->used || block_group->reserved)) {
+		ret = 1;
+		goto out;
+	}
+
 	avail = block_group->length - block_group->alloc_offset;
 	if (avail < num_bytes) {
 		ffe_ctl->max_extent_size = avail;
@@ -3730,6 +3764,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		goto out;
 	}
 
+	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = block_group->start;
+
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3737,10 +3774,13 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	spin_unlock(&ctl->tree_lock);
 
 	ASSERT(IS_ALIGNED(ffe_ctl->found_offset,
-			  block_group->fs_info->stripesize));
+			  fs_info->stripesize));
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 
 out:
+	if (ret && ffe_ctl->for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -3990,7 +4030,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 		return prepare_allocation_clustered(fs_info, ffe_ctl,
 						    space_info, ins);
 	case BTRFS_EXTENT_ALLOC_ZONED:
-		/* nothing to do */
+		if (ffe_ctl->for_treelog) {
+			spin_lock(&fs_info->treelog_bg_lock);
+			if (fs_info->treelog_bg)
+				ffe_ctl->hint_byte = fs_info->treelog_bg;
+			spin_unlock(&fs_info->treelog_bg_lock);
+		}
 		return 0;
 	default:
 		BUG();
@@ -4025,7 +4070,7 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
 				u64 hint_byte_orig, struct btrfs_key *ins,
-				u64 flags, int delalloc)
+				u64 flags, int delalloc, bool for_treelog)
 {
 	int ret = 0;
 	int cache_block_group_error = 0;
@@ -4046,6 +4091,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
 	ffe_ctl.hint_byte = hint_byte_orig;
+	ffe_ctl.for_treelog = for_treelog;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	/* For clustered allocation */
@@ -4120,8 +4166,15 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		struct btrfs_block_group *bg_ret;
 
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro))
+		if (unlikely(block_group->ro)) {
+			if (btrfs_fs_incompat(fs_info, ZONED) && for_treelog) {
+				spin_lock(&fs_info->treelog_bg_lock);
+				if (block_group->start == fs_info->treelog_bg)
+					fs_info->treelog_bg = 0;
+				spin_unlock(&fs_info->treelog_bg_lock);
+			}
 			continue;
+		}
 
 		btrfs_grab_block_group(block_group, delalloc);
 		ffe_ctl.search_start = block_group->start;
@@ -4309,12 +4362,13 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
 	ret = find_free_extent(fs_info, ram_bytes, num_bytes, empty_size,
-			       hint_byte, ins, flags, delalloc);
+			       hint_byte, ins, flags, delalloc, for_treelog);
 	if (!ret && !is_data) {
 		btrfs_dec_block_group_reservations(fs_info, ins->objectid);
 	} else if (ret == -ENOSPC) {
@@ -4332,8 +4386,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-				  "allocation failed flags %llu, wanted %llu",
-				  flags, num_bytes);
+			"allocation failed flags %llu, wanted %llu treelog %d",
+				  flags, num_bytes, for_treelog);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
-- 
2.27.0

