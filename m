Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6273FE09E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbhIARCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbhIARCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D579C061796
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so166151pjc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIgQo2oChc5R9ppNZcJsRQLeVNqUYk5rwuirJqcFYn4=;
        b=DEye6PY7EhEUN4hCjtn8yscatJN7C0oEm9KAVclR4YfZdsKuwitR/yvLDWK8qDOfFl
         FhM5uSBwJko+7ZooqqMnGtTPAEN8unD9GuIfvDfQqMW5ubz83Os37ajcaeToAFqObAKq
         UHduoQ53WRNYYhNdQZcq9lAIDgVvwTtyf90NAzPqUbNmcSrFmHY80cERhX7wBtRVxGcg
         FRDAawZM8urAI+OBnMVxDRhTDNkjQ3MxSYDI8SBQhtyynMscbS2XyRYj1+zA5a4omxNX
         ya0xPbwYovpLg1jSxcQz8znMlHKjVLjzae1XTbRot9+CdXn0Th9N9+WNrWMatcxj0w0+
         bnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIgQo2oChc5R9ppNZcJsRQLeVNqUYk5rwuirJqcFYn4=;
        b=ApShjjMnCUOFjzDccyyoRscVccf/UzK9GavgLWgTUsmzcQ6Jt/Kpy9+7tN7iSwT7ZQ
         t11dcokjDrSH0MfwdkZc/suSlj3sbHzGWk4aRjnHSqCBVaZfGtvJtbHzt+zfLFyg1xCd
         oFMeuO95Ov8JgTWDQipoIAeJUa1u6/UxaK4aSBDnIHknhqTzvapfWygXtvYNKfcHPy5W
         +CAHdRDohYBwzjUNzKu/tnQcxM2aYGo2ZcjtDzBJhfCZFdvCu719+gWQlAYBGLDih6En
         a92qBbYmeNNIiaEIHfqz/O5qmFGSHmoscN3ARd5gESP4eh92IenGO/XLhQGbwHvjpL6a
         HTCg==
X-Gm-Message-State: AOAM533S5f4jH89ckLRvUfk7C4EpQSIOj+cx/T53+7aw+H4A+jZYeibD
        iuSXZSIhweGCo8MhscZs+lCSyg==
X-Google-Smtp-Source: ABdhPJysZC+9JH5/mXJxiJk1/4qKhDhj4oS4zDVUe1SxvC7TS4gP85j1tl+wl8r/JNCZohQziZCK0w==
X-Received: by 2002:a17:90a:560a:: with SMTP id r10mr417848pjf.86.1630515693937;
        Wed, 01 Sep 2021 10:01:33 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:33 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 05/14] btrfs: support different disk extent size for delalloc
Date:   Wed,  1 Sep 2021 10:01:00 -0700
Message-Id: <84ca9be547a19b69c276942bd99b03da833530dd.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
 fs/btrfs/relocation.c     |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8ea383cac13b..b95ec5fb68d5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2802,7 +2802,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2059d1504149..143650004991 100644
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
index 7ff577005d0f..6f9cb8baffd2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1741,7 +1741,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
index a85c1050ae95..6aad4b641d5c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5043,7 +5043,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 63d2b22cf438..879fa0ea465c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3017,7 +3017,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len);
+						      clamped_len, clamped_len);
 		if (ret)
 			goto release_page;
 
-- 
2.33.0

