Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AD7B8BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbjJDSy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbjJDSyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299619A6;
        Wed,  4 Oct 2023 11:54:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8596C433CA;
        Wed,  4 Oct 2023 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445652;
        bh=wcoGb0eczeeES9BQXcCkzd9FnbAJEJPkUTNGutZl0cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5Q19qQqpqsh3uJtw2Uxvm9Ec1seNJLC54Us6Z81PXy0APeLUDcqy9mxGIFCBx+NG
         tjZqNVrZ+7fSJd8W7Ofj0vvx/p/49sDUhllSSUr/13m3OEZo6Dqs18OEVkx8A69uNc
         lB8ay1rHS6RIfB+2CgDfatfSpJBieyMvSpE0xrl/FANsN/PS0BObFgMMw0eGKgYCRh
         sU1+/9b90uKkiaoxYO2Phw3C85YhaFQ/S+E/B7BrMTnjSx6Mv+6lKRp9HSInzAV4Rb
         335BO6OrkjkoB6v2wmaiWWff+NbQrRmMr9Sp7Hrc1pRDGHkMGR4xEWAw8XsK9cx735
         fEVRkOiu98RiQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 23/89] btrfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:08 -0400
Message-ID: <20231004185347.80880-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/delayed-inode.c | 20 +++++++++----------
 fs/btrfs/file.c          | 18 +++++++++--------
 fs/btrfs/inode.c         | 43 ++++++++++++++++++++--------------------
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/transaction.c   |  3 ++-
 fs/btrfs/tree-log.c      | 12 +++++------
 6 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 35d7616615c1..63454bf3dc52 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1833,19 +1833,19 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_inode_block_group(inode_item, 0);
 
 	btrfs_set_stack_timespec_sec(&inode_item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime_sec(inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime_nsec(inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime_sec(inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime_nsec(inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->ctime,
-				     inode_get_ctime(inode).tv_sec);
+				     inode_get_ctime_sec(inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
-				      inode_get_ctime(inode).tv_nsec);
+				      inode_get_ctime_nsec(inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
@@ -1890,11 +1890,11 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
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
index 004c53482f05..04a045663f7b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1111,17 +1111,18 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 
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
@@ -2477,7 +2478,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		inode_inc_iversion(&inode->vfs_inode);
 
 		if (!extent_info || extent_info->update_times)
-			inode->vfs_inode.i_mtime = inode_set_ctime_current(&inode->vfs_inode);
+			inode_set_mtime_to_ts(&inode->vfs_inode,
+					      inode_set_ctime_current(&inode->vfs_inode));
 
 		ret = btrfs_update_inode(trans, inode);
 		if (ret)
@@ -2718,7 +2720,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = btrfs_update_inode(trans, BTRFS_I(inode));
 	updated_inode = true;
 	btrfs_end_transaction(trans);
@@ -2738,7 +2740,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		struct timespec64 now = inode_set_ctime_current(inode);
 
 		inode_inc_iversion(inode);
-		inode->i_mtime = now;
+		inode_set_mtime_to_ts(inode, now);
 		trans = btrfs_start_transaction(root, 1);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 52576deda654..25298eed0b26 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3763,11 +3763,11 @@ static int btrfs_read_locked_inode(struct inode *inode,
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
@@ -3931,19 +3931,19 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
 
 	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime_nsec(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime_nsec(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
-				     inode_get_ctime(inode).tv_sec);
+				     inode_get_ctime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode_get_ctime(inode).tv_nsec);
+				      inode_get_ctime_nsec(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
@@ -4141,7 +4141,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
-	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);
 out:
 	return ret;
@@ -4314,7 +4314,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
 	inode_inc_iversion(&dir->vfs_inode);
-	dir->vfs_inode.i_mtime = inode_set_ctime_current(&dir->vfs_inode);
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode_fallback(trans, dir);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -4964,7 +4964,8 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	if (newsize != oldsize) {
 		inode_inc_iversion(inode);
 		if (!(mask & (ATTR_CTIME | ATTR_MTIME))) {
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		}
 	}
 
@@ -5608,9 +5609,9 @@ static struct inode *new_simple_dir(struct inode *dir,
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
 
@@ -6285,9 +6286,9 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
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
@@ -6452,8 +6453,8 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	 * values (the ones it had when the fsync was done).
 	 */
 	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
-		parent_inode->vfs_inode.i_mtime =
-			inode_set_ctime_current(&parent_inode->vfs_inode);
+		inode_set_mtime_to_ts(&parent_inode->vfs_inode,
+				      inode_set_ctime_current(&parent_inode->vfs_inode));
 
 	ret = btrfs_update_inode(trans, parent_inode);
 	if (ret)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index fabd856e5079..f88b0c2ac3fe 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -29,7 +29,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 
 	inode_inc_iversion(inode);
 	if (!no_time_update) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	/*
 	 * We round up to the block size at eof when determining which
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 77f8175d464b..d2105bfa6297 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1911,7 +1911,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
 						  fname.disk_name.len * 2);
-	parent_inode->i_mtime = inode_set_ctime_current(parent_inode);
+	inode_set_mtime_to_ts(parent_inode,
+			      inode_set_ctime_current(parent_inode));
 	ret = btrfs_update_inode_fallback(trans, BTRFS_I(parent_inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6b98e0dbc0a4..8c024ab22086 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4134,19 +4134,19 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
 
 	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode->i_atime.tv_sec);
+				     inode_get_atime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode->i_atime.tv_nsec);
+				      inode_get_atime_nsec(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode->i_mtime.tv_sec);
+				     inode_get_mtime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode->i_mtime.tv_nsec);
+				      inode_get_mtime_nsec(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
-				     inode_get_ctime(inode).tv_sec);
+				     inode_get_ctime_sec(inode));
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode_get_ctime(inode).tv_nsec);
+				      inode_get_ctime_nsec(inode));
 
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
-- 
2.41.0

