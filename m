Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668ED6F59D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjECOVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjECOVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988216A48;
        Wed,  3 May 2023 07:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE3B362DDD;
        Wed,  3 May 2023 14:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51515C4339B;
        Wed,  3 May 2023 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123654;
        bh=GxZT1sND+VdxzFxlia5wDDrXoToc3H/KuZm7CetwY60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cj5oM7cH+wDZS0lA21ceV3QcQRaj6SD49K7PbUUYYesubx5qnO4L6e3EFfUK4XrTn
         vL3kH6eOpOvxeVKRnsNxygdwXUeCEr4DJQABZzUSX2gVUR8cttJ7COHQ9PGBdlWRG1
         EL4xf8Xpv40Fn983fudsWAr5X5xR+0TX8MpKyRja/Soa7N2wiPMONBLzdeu8jLR1+1
         5yjVLV1dLekk5e7pxl2LVgKNkeVqFI0uC5ZT40qp7DBlRMebKxcz8Th1dm5Qo5tus0
         vhlhMXklC5FKTDgxw4E3XPNf5QHHZ3XVwTF3/x0+sla4CTEJcQVSvRzc0kJd3AEonh
         02XI6JedXmoTw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 6/6] btrfs: convert to multigrain timestamps
Date:   Wed,  3 May 2023 10:20:37 -0400
Message-Id: <20230503142037.153531-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503142037.153531-1-jlayton@kernel.org>
References: <20230503142037.153531-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/delayed-inode.c |  2 +-
 fs/btrfs/file.c          | 10 +++++-----
 fs/btrfs/inode.c         | 25 +++++++++++++------------
 fs/btrfs/ioctl.c         |  6 +++---
 fs/btrfs/reflink.c       |  2 +-
 fs/btrfs/super.c         |  5 +++--
 fs/btrfs/transaction.c   |  2 +-
 fs/btrfs/tree-log.c      |  2 +-
 fs/btrfs/volumes.c       |  2 +-
 fs/btrfs/xattr.c         |  4 ++--
 10 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6b457b010cbc..8307fd69da43 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1810,7 +1810,7 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_sec(&inode_item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5..3344f64f58dc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1113,7 +1113,7 @@ static void update_time_for_write(struct inode *inode)
 	if (IS_NOCMTIME(inode))
 		return;
 
-	now = current_time(inode);
+	now = current_ctime(inode);
 	if (!timespec64_equal(&inode->i_mtime, &now))
 		inode->i_mtime = now;
 
@@ -2473,7 +2473,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		inode_inc_iversion(&inode->vfs_inode);
 
 		if (!extent_info || extent_info->update_times) {
-			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
+			inode->vfs_inode.i_mtime = current_ctime(&inode->vfs_inode);
 			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
 		}
 
@@ -2716,7 +2716,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 
 	ASSERT(trans != NULL);
 	inode_inc_iversion(inode);
-	inode->i_mtime = current_time(inode);
+	inode->i_mtime = current_ctime(inode);
 	inode->i_ctime = inode->i_mtime;
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	updated_inode = true;
@@ -2734,7 +2734,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 		 * for detecting, at fsync time, if the inode isn't yet in the
 		 * log tree or it's there but not up to date.
 		 */
-		struct timespec64 now = current_time(inode);
+		struct timespec64 now = current_ctime(inode);
 
 		inode_inc_iversion(inode);
 		inode->i_mtime = now;
@@ -2809,7 +2809,7 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	i_size_write(inode, end);
 	btrfs_inode_safe_disk_i_size_write(BTRFS_I(inode), 0);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 957e4d76a7b6..889ff97d9595 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4029,7 +4029,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
@@ -4227,7 +4227,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
-	inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+	inode->vfs_inode.i_ctime = current_ctime(&inode->vfs_inode);
 	dir->vfs_inode.i_mtime = inode->vfs_inode.i_ctime;
 	dir->vfs_inode.i_ctime = inode->vfs_inode.i_ctime;
 	ret = btrfs_update_inode(trans, root, dir);
@@ -4409,7 +4409,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
 	inode_inc_iversion(&dir->vfs_inode);
-	dir->vfs_inode.i_mtime = current_time(&dir->vfs_inode);
+	dir->vfs_inode.i_mtime = current_ctime(&dir->vfs_inode);
 	dir->vfs_inode.i_ctime = dir->vfs_inode.i_mtime;
 	ret = btrfs_update_inode_fallback(trans, root, dir);
 	if (ret)
@@ -5052,7 +5052,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	if (newsize != oldsize) {
 		inode_inc_iversion(inode);
 		if (!(mask & (ATTR_CTIME | ATTR_MTIME))) {
-			inode->i_mtime = current_time(inode);
+			inode->i_mtime = current_ctime(inode);
 			inode->i_ctime = inode->i_mtime;
 		}
 	}
@@ -5693,7 +5693,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
-	inode->i_mtime = current_time(inode);
+	inode->i_mtime = current_ctime(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
 	BTRFS_I(inode)->i_otime = inode->i_mtime;
@@ -6335,7 +6335,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		goto discard;
 	}
 
-	inode->i_mtime = current_time(inode);
+	inode->i_mtime = current_ctime(inode);
 	inode->i_atime = inode->i_mtime;
 	inode->i_ctime = inode->i_mtime;
 	BTRFS_I(inode)->i_otime = inode->i_mtime;
@@ -6503,7 +6503,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	 * values (the ones it had when the fsync was done).
 	 */
 	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags)) {
-		struct timespec64 now = current_time(&parent_inode->vfs_inode);
+		struct timespec64 now = current_ctime(&parent_inode->vfs_inode);
 
 		parent_inode->vfs_inode.i_mtime = now;
 		parent_inode->vfs_inode.i_ctime = now;
@@ -6647,7 +6647,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	BTRFS_I(inode)->dir_index = 0ULL;
 	inc_nlink(inode);
 	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
@@ -8659,6 +8659,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(idmap, inode, stat);
+	generic_fill_multigrain_cmtime(request_mask, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
@@ -8682,7 +8683,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
 	struct inode *new_inode = new_dentry->d_inode;
 	struct inode *old_inode = old_dentry->d_inode;
-	struct timespec64 ctime = current_time(old_inode);
+	struct timespec64 ctime = current_ctime(old_inode);
 	struct btrfs_rename_ctx old_rename_ctx;
 	struct btrfs_rename_ctx new_rename_ctx;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
@@ -9082,7 +9083,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	inode_inc_iversion(old_inode);
-	old_dir->i_mtime = current_time(old_dir);
+	old_dir->i_mtime = current_ctime(old_dir);
 	old_dir->i_ctime = old_dir->i_mtime;
 	new_dir->i_mtime = old_dir->i_mtime;
 	new_dir->i_ctime = old_dir->i_mtime;
@@ -9108,7 +9109,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 
 	if (new_inode) {
 		inode_inc_iversion(new_inode);
-		new_inode->i_ctime = current_time(new_inode);
+		new_inode->i_ctime = current_ctime(new_inode);
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 			ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
@@ -9648,7 +9649,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		*alloc_hint = ins.objectid + ins.offset;
 
 		inode_inc_iversion(inode);
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		BTRFS_I(inode)->flags |= BTRFS_INODE_PREALLOC;
 		if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 		    (actual_len > inode->i_size) &&
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ba769a1eb87a..4b862d777fa7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -384,7 +384,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	binode->flags = binode_flags;
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 
  out_end_trans:
@@ -591,7 +591,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *new_root;
 	struct btrfs_block_rsv block_rsv;
-	struct timespec64 cur_time = current_time(dir);
+	struct timespec64 cur_time = current_ctime(dir);
 	struct btrfs_new_inode_args new_inode_args = {
 		.dir = dir,
 		.dentry = dentry,
@@ -3918,7 +3918,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct btrfs_trans_handle *trans;
-	struct timespec64 ct = current_time(inode);
+	struct timespec64 ct = current_ctime(inode);
 	int ret = 0;
 	int received_uuid_changed;
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 0474bbe39da7..59d3ce505098 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -30,7 +30,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 
 	inode_inc_iversion(inode);
 	if (!no_time_update) {
-		inode->i_mtime = current_time(inode);
+		inode->i_mtime = current_ctime(inode);
 		inode->i_ctime = inode->i_mtime;
 	}
 	/*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 366fb4cde145..dc8dddbc12b9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2139,7 +2139,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MULTIGRAIN_TS,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2147,7 +2147,8 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+			  FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS,
 };
 
 MODULE_ALIAS_FS("btrfs");
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b8d5b1fa9a03..277aedfce808 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1838,7 +1838,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
 						  fname.disk_name.len * 2);
-	parent_inode->i_mtime = current_time(parent_inode);
+	parent_inode->i_mtime = current_ctime(parent_inode);
 	parent_inode->i_ctime = parent_inode->i_mtime;
 	ret = btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_inode));
 	if (ret) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 200cea6e49e5..1e0e25dafa47 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4177,7 +4177,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6d592870400..d89f1afde366 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1917,7 +1917,7 @@ static void update_dev_time(const char *device_path)
 	if (ret)
 		return;
 
-	now = current_time(d_inode(path.dentry));
+	now = current_ctime(d_inode(path.dentry));
 	inode_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
 	path_put(&path);
 }
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 0ebeaf4e81f9..30a37333e92a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -264,7 +264,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 		goto out;
 
 	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_ctime(inode);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
@@ -407,7 +407,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	ret = btrfs_set_prop(trans, inode, name, value, size, flags);
 	if (!ret) {
 		inode_inc_iversion(inode);
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_ctime(inode);
 		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-- 
2.40.1

