Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65646350F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhDAGwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhDAGvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:51:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E8C0613E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k8so959316pgf.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWL4NP/Pga4+ky8vYPTY6bfeYaB2nM9Xxj59JaaRzeg=;
        b=uBetcGaIEsrs+j60X51y61eu+5nE4HR0xUhIa192zi30J26/7II7p2xUs3d3t5mdJW
         Tk70Bz+ZV7AzxzjqFug0QxAgcKs3XHvxfweMVLMo0maEhRPE6EFyX6D24yw2zg6WzN3i
         9sfOPee1zZEVrVzY/wWEEfpl5EFfDknPf04xvmYOm2kiNtm1MIc1qg4Jdeh4COrsh6tv
         dAeJXfc0YlDhE3yll22typEwxKxnIU2BsOq3oTF+M1MMJp/GeHVG3o5RleoL3en5hCnu
         A9hHnyPbqJyuJtVt00HRx0zMOAa7UnJSGz5uf0q1JqIV2HlM99JULN1rosPJQaMg+ILv
         XSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWL4NP/Pga4+ky8vYPTY6bfeYaB2nM9Xxj59JaaRzeg=;
        b=TwXi+FzkPH84ZLSYDCeXMwbplRnpS+tsgb+8GPN1PGmdha0bLcYopbVE/jYx6LvhfT
         XH3WhZE0RZsqgzJ8szG59Gw4/D47mzCO/l7yIMPxD2yhRSPiw4EALKu+ejD6/S1hgdGv
         uhHmmqzLyT+BwVdRa9aNhNBVCpuD1EBMWg3RfnPRwAjguN7kpepXoBzHWtR3/UCs1w87
         owL/vpTjqFjy4DFs3be0BOE+LM8qnxWhJR1hWoMvD3cTdzJApIgtiTo/ykKEpJVWLNc5
         X/BvhSJQ2uDGyDSkwEs3c/3VPSVNVfL2+C7nJ/klQKolRrb9KjuTF3Bp2slzo1NFIa1b
         CQog==
X-Gm-Message-State: AOAM530K54nY8fFcir2rzf5ax/PdDXhDolyHUhT/ZXNoeATOuf5JFWVW
        lwcu0gnQDGDYsa1SQQ8drmAYi5+2HEarBw==
X-Google-Smtp-Source: ABdhPJzsjtKtLMk7lWoPxZtz/1N6/DWX1BlJNXfaigBvmCTlGYvttiBwDtZa+ixLvubtcP8sS0h33A==
X-Received: by 2002:a62:d414:0:b029:217:24b8:a5b9 with SMTP id a20-20020a62d4140000b029021724b8a5b9mr6519413pfh.41.1617259900223;
        Wed, 31 Mar 2021 23:51:40 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:3734])
        by smtp.gmail.com with ESMTPSA id kk6sm4158345pjb.51.2021.03.31.23.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:51:39 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v9 6/9] btrfs: support different disk extent size for delalloc
Date:   Wed, 31 Mar 2021 23:51:11 -0700
Message-Id: <b99c820f855d1d1e8e46cee51ae907a1a201045e.1617258892.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617258892.git.osandov@fb.com>
References: <cover.1617258892.git.osandov@fb.com>
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
index ae764f6155d5..a2f93c038399 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2752,7 +2752,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 56642ca7af10..3af8a477a5cc 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -267,11 +267,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
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
@@ -285,7 +285,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -315,6 +316,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -326,8 +328,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
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
@@ -346,7 +348,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -451,7 +453,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 42634658815f..bc47e53d2985 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1727,7 +1727,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
index 8345efb275eb..3d644e6453d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4863,7 +4863,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bf269ee17e68..d706b4fe0e77 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2683,8 +2683,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
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
2.31.1

