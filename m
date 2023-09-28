Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591A7B19B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjI1LFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjI1LEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442F1A4;
        Thu, 28 Sep 2023 04:04:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEA5C433C9;
        Thu, 28 Sep 2023 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899077;
        bh=ruBVBlbxk43QmbfwYylX+XKh2opy3/NQx5bRlLNo8m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiewGpLq2Ju9FF4X5MfXOLjuyzPXKBGx+Dp4rMCgVoZr8X5Nhm8d142DHdibiaZP+
         ua5iyJ+YAOv4lHl/ygQTjt2hzLx/vaRiJF6DZHRTju11SbID1WA31rEZHMATOqdYBO
         IVhB23S3lFZvugNAb0+RfA1TjpI6tiZcc0GefmMD6LOQBof/r2fi5n5x5pyQjIRzs7
         S8/dlv8sr4TEBDdj9yuyZAujIM65oX5Sk4W7ybZeYbuAOfSwtjq255CjVmHyo7RO9z
         5oonsTrCFKd4T51EiDXSUjpOm61C8IUuUVhumDolbhEEA6PV64+EVnAy1rgrDN/AMj
         igRYnN5RZgMpw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 22/87] fs/btrfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:31 -0400
Message-ID: <20230928110413.33032-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/delayed-inode.c | 16 ++++++++--------
 fs/btrfs/file.c          | 18 ++++++++++--------
 fs/btrfs/inode.c         | 39 ++++++++++++++++++++-------------------
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/transaction.c   |  3 ++-
 fs/btrfs/tree-log.c      |  8 ++++----
 6 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index caf0bbd028d1..c578a6fc796c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1834,14 +1834,14 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_inode_block_group(inode_item, 0);
 
 	btrfs_set_stack_timespec_sec(&inode_item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime(inode).tv_sec);
 	btrfs_set_stack_timespec_nsec(&inode_item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime(inode).tv_nsec);
 
 	btrfs_set_stack_timespec_sec(&inode_item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime(inode).tv_sec);
 	btrfs_set_stack_timespec_nsec(&inode_item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime(inode).tv_nsec);
 
 	btrfs_set_stack_timespec_sec(&inode_item->ctime,
 				     inode_get_ctime(inode).tv_sec);
@@ -1891,11 +1891,11 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	btrfs_inode_split_flags(btrfs_stack_inode_flags(inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
 
-	inode->i_atime.tv_sec = btrfs_stack_timespec_sec(&inode_item->atime);
-	inode->i_atime.tv_nsec = btrfs_stack_timespec_nsec(&inode_item->atime);
+	inode_set_atime(inode, btrfs_stack_timespec_sec(&inode_item->atime),
+			btrfs_stack_timespec_nsec(&inode_item->atime));
 
-	inode->i_mtime.tv_sec = btrfs_stack_timespec_sec(&inode_item->mtime);
-	inode->i_mtime.tv_nsec = btrfs_stack_timespec_nsec(&inode_item->mtime);
+	inode_set_mtime(inode, btrfs_stack_timespec_sec(&inode_item->mtime),
+			btrfs_stack_timespec_nsec(&inode_item->mtime));
 
 	inode_set_ctime(inode, btrfs_stack_timespec_sec(&inode_item->ctime),
 			btrfs_stack_timespec_nsec(&inode_item->ctime));
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 361535c71c0f..278a4ea651e1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1108,17 +1108,18 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 
 static void update_time_for_write(struct inode *inode)
 {
-	struct timespec64 now, ctime;
+	struct timespec64 now, ts;
 
 	if (IS_NOCMTIME(inode))
 		return;
 
 	now = current_time(inode);
-	if (!timespec64_equal(&inode->i_mtime, &now))
-		inode->i_mtime = now;
+	ts = inode_get_mtime(inode);
+	if (!timespec64_equal(&ts, &now))
+		inode_set_mtime_to_ts(inode, now);
 
-	ctime = inode_get_ctime(inode);
-	if (!timespec64_equal(&ctime, &now))
+	ts = inode_get_ctime(inode);
+	if (!timespec64_equal(&ts, &now))
 		inode_set_ctime_to_ts(inode, now);
 
 	if (IS_I_VERSION(inode))
@@ -2473,7 +2474,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		inode_inc_iversion(&inode->vfs_inode);
 
 		if (!extent_info || extent_info->update_times)
-			inode->vfs_inode.i_mtime = inode_set_ctime_current(&inode->vfs_inode);
+			inode_set_mtime_to_ts(&inode->vfs_inode,
+					      inode_set_ctime_current(&inode->vfs_inode));
 
 		ret = btrfs_update_inode(trans, root, inode);
 		if (ret)
@@ -2714,7 +2716,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	updated_inode = true;
 	btrfs_end_transaction(trans);
@@ -2734,7 +2736,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		struct timespec64 now = inode_set_ctime_current(inode);
 
 		inode_inc_iversion(inode);
-		inode->i_mtime = now;
+		inode_set_mtime_to_ts(inode, now);
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7814b9d654ce..e35939e68fc5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3754,11 +3754,11 @@ static int btrfs_read_locked_inode(struct inode *inode,
 	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
 			round_up(i_size_read(inode), fs_info->sectorsize));
 
-	inode->i_atime.tv_sec = btrfs_timespec_sec(leaf, &inode_item->atime);
-	inode->i_atime.tv_nsec = btrfs_timespec_nsec(leaf, &inode_item->atime);
+	inode_set_atime(inode, btrfs_timespec_sec(leaf, &inode_item->atime),
+			btrfs_timespec_nsec(leaf, &inode_item->atime));
 
-	inode->i_mtime.tv_sec = btrfs_timespec_sec(leaf, &inode_item->mtime);
-	inode->i_mtime.tv_nsec = btrfs_timespec_nsec(leaf, &inode_item->mtime);
+	inode_set_mtime(inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
+			btrfs_timespec_nsec(leaf, &inode_item->mtime));
 
 	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
@@ -3922,14 +3922,14 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
 
 	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime(inode).tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime(inode).tv_nsec);
 
 	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime(inode).tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime(inode).tv_nsec);
 
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode_get_ctime(inode).tv_sec);
@@ -4133,7 +4133,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
-	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, root, dir);
 out:
 	return ret;
@@ -4306,7 +4306,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
 	inode_inc_iversion(&dir->vfs_inode);
-	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode_fallback(trans, root, dir);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -4956,7 +4956,8 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	if (newsize != oldsize) {
 		inode_inc_iversion(inode);
 		if (!(mask & (ATTR_CTIME | ATTR_MTIME))) {
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		}
 	}
 
@@ -5600,9 +5601,9 @@ static struct inode *new_simple_dir(struct inode *dir,
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
-	inode->i_mtime = inode_set_ctime_current(inode);
-	inode->i_atime = dir->i_atime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	inode_set_atime_to_ts(inode, inode_get_atime(dir));
+	BTRFS_I(inode)->i_otime = inode_get_mtime(inode);
 	inode->i_uid = dir->i_uid;
 	inode->i_gid = dir->i_gid;
 
@@ -6277,9 +6278,9 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		goto discard;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
-	inode->i_atime = inode->i_mtime;
-	BTRFS_I(inode)->i_otime = inode->i_mtime;
+	simple_inode_init_ts(inode);
+	
+	BTRFS_I(inode)->i_otime = inode_get_mtime(inode);
 
 	/*
 	 * We're going to fill the inode item now, so at this point the inode
@@ -6444,8 +6445,8 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	 * values (the ones it had when the fsync was done).
 	 */
 	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
-		parent_inode->vfs_inode.i_mtime =
-			inode_set_ctime_current(&parent_inode->vfs_inode);
+		inode_set_mtime_to_ts(&parent_inode->vfs_inode,
+				      inode_set_ctime_current(&parent_inode->vfs_inode));
 
 	ret = btrfs_update_inode(trans, root, parent_inode);
 	if (ret)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 65d2bd6910f2..13ecb4f85941 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -30,7 +30,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 
 	inode_inc_iversion(inode);
 	if (!no_time_update) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	/*
 	 * We round up to the block size at eof when determining which
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c780d3729463..38a2775c5c7b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1860,7 +1860,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
 						  fname.disk_name.len * 2);
-	parent_inode->i_mtime = inode_set_ctime_current(parent_inode);
+	inode_set_mtime_to_ts(parent_inode,
+			      inode_set_ctime_current(parent_inode));
 	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cbb17b542131..3f33e18f6d3e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4138,14 +4138,14 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
 
 	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime(inode).tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime(inode).tv_nsec);
 
 	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime(inode).tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime(inode).tv_nsec);
 
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode_get_ctime(inode).tv_sec);
-- 
2.41.0

