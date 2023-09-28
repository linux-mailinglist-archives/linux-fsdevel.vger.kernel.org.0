Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD597B1986
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjI1LEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjI1LES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BCCE0;
        Thu, 28 Sep 2023 04:04:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CDC433CC;
        Thu, 28 Sep 2023 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899055;
        bh=UA17NieiKuJUQtAvlfYpTNXdsMGRKLLOw/Cz8ngzkD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6CAZGurZISIkQMn+b7qANzD5KkJ97vaooKgKjDX0Cks6k8TEzUpepVAKk4oIlWwG
         +jzZnGzmicw5BtfxrPApbAGLtk/nvnTQ9Jv5ftuLQnDZfLM3d7WMfTSLDLANOnprnD
         D/mwlEpY82WLyYRan0BMiKRvcSd4JFXXqoXYLCSAZDxaDWLf2nc6sEoEg8+eUfCBAv
         7JWU5Ug2iCxLmiKovVzNi+U0ye7uC7YDSrGbPNkjbeysP1E8oTSNAnrj2sLl7jo+Sp
         5PrpsKTxEDXT9eYDzu2B5nmLgbMV6ozOr+FCNbxbj2dfcUC4IxYnKsLUmfp2/y31CZ
         mKGPuQvOuScJA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Subject: [PATCH 02/87] fs: convert core infrastructure to new {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:11 -0400
Message-ID: <20230928110413.33032-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110300.32891-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
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

Convert the core filesystem code to use the new atime and mtime accessor
functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c                |  4 ++--
 fs/bad_inode.c           |  2 +-
 fs/binfmt_misc.c         |  2 +-
 fs/inode.c               | 35 +++++++++++++++++++++--------------
 fs/libfs.c               | 32 +++++++++++++++++++-------------
 fs/nsfs.c                |  2 +-
 fs/pipe.c                |  2 +-
 fs/stack.c               |  4 ++--
 fs/stat.c                |  4 ++--
 include/linux/fs_stack.h |  6 +++---
 10 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..bdf5deb06ea9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -308,9 +308,9 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = attr->ia_atime;
+		inode_set_atime_to_ts(inode, attr->ia_atime);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = attr->ia_mtime;
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
 	if (ia_valid & ATTR_CTIME)
 		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 83f9566c973b..316d88da2ce1 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -208,7 +208,7 @@ void make_bad_inode(struct inode *inode)
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e0108d17b085..5d2be9b0a0a5 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -547,7 +547,7 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 	return inode;
 }
diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..0612ad9c0227 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1837,27 +1837,29 @@ EXPORT_SYMBOL(bmap);
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
 {
-	struct timespec64 ctime;
+	struct timespec64 atime, mtime, ctime;
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
 	/*
 	 * Is mtime younger than or equal to atime? If yes, update atime:
 	 */
-	if (timespec64_compare(&inode->i_mtime, &inode->i_atime) >= 0)
+	atime = inode_get_atime(inode);
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&mtime, &atime) >= 0)
 		return 1;
 	/*
 	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
 	ctime = inode_get_ctime(inode);
-	if (timespec64_compare(&ctime, &inode->i_atime) >= 0)
+	if (timespec64_compare(&ctime, &atime) >= 0)
 		return 1;
 
 	/*
 	 * Is the previous atime value older than a day? If yes,
 	 * update atime:
 	 */
-	if ((long)(now.tv_sec - inode->i_atime.tv_sec) >= 24*60*60)
+	if ((long)(now.tv_sec - atime.tv_sec) >= 24*60*60)
 		return 1;
 	/*
 	 * Good, we can skip the atime update:
@@ -1888,12 +1890,13 @@ int inode_update_timestamps(struct inode *inode, int flags)
 
 	if (flags & (S_MTIME|S_CTIME|S_VERSION)) {
 		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
 
 		now = inode_set_ctime_current(inode);
 		if (!timespec64_equal(&now, &ctime))
 			updated |= S_CTIME;
-		if (!timespec64_equal(&now, &inode->i_mtime)) {
-			inode->i_mtime = now;
+		if (!timespec64_equal(&now, &mtime)) {
+			inode_set_mtime_to_ts(inode, now);
 			updated |= S_MTIME;
 		}
 		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, updated))
@@ -1903,8 +1906,10 @@ int inode_update_timestamps(struct inode *inode, int flags)
 	}
 
 	if (flags & S_ATIME) {
-		if (!timespec64_equal(&now, &inode->i_atime)) {
-			inode->i_atime = now;
+		struct timespec64 atime = inode_get_atime(inode);
+
+		if (!timespec64_equal(&now, &atime)) {
+			inode_set_atime_to_ts(inode, now);
 			updated |= S_ATIME;
 		}
 	}
@@ -1963,7 +1968,7 @@ EXPORT_SYMBOL(inode_update_time);
 bool atime_needs_update(const struct path *path, struct inode *inode)
 {
 	struct vfsmount *mnt = path->mnt;
-	struct timespec64 now;
+	struct timespec64 now, atime;
 
 	if (inode->i_flags & S_NOATIME)
 		return false;
@@ -1989,7 +1994,8 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 	if (!relatime_need_update(mnt, inode, now))
 		return false;
 
-	if (timespec64_equal(&inode->i_atime, &now))
+	atime = inode_get_atime(inode);
+	if (timespec64_equal(&atime, &now))
 		return false;
 
 	return true;
@@ -2106,17 +2112,18 @@ static int inode_needs_update_time(struct inode *inode)
 {
 	int sync_it = 0;
 	struct timespec64 now = current_time(inode);
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
 		return 0;
 
-	if (!timespec64_equal(&inode->i_mtime, &now))
+	ts = inode_get_mtime(inode);
+	if (!timespec64_equal(&ts, &now))
 		sync_it = S_MTIME;
 
-	ctime = inode_get_ctime(inode);
-	if (!timespec64_equal(&ctime, &now))
+	ts = inode_get_ctime(inode);
+	if (!timespec64_equal(&ts, &now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
diff --git a/fs/libfs.c b/fs/libfs.c
index f5cdc7f7f5b5..abe2b5a40ba1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -541,7 +541,8 @@ void simple_recursive_removal(struct dentry *dentry,
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-				inode->i_mtime = inode_set_ctime_current(inode);
+				inode_set_mtime_to_ts(inode,
+						      inode_set_ctime_current(inode));
 				if (d_is_dir(dentry))
 					drop_nlink(inode);
 				inode_unlock(inode);
@@ -582,7 +583,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_atime = root->i_mtime = inode_set_ctime_current(root);
+	simple_inode_init_ts(root);
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
 		return -ENOMEM;
@@ -638,8 +639,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inc_nlink(inode);
 	ihold(inode);
 	dget(dentry);
@@ -673,8 +674,8 @@ int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	drop_nlink(inode);
 	dput(dentry);
 	return 0;
@@ -709,9 +710,10 @@ void simple_rename_timestamp(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct inode *newino = d_inode(new_dentry);
 
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
 	if (new_dir != old_dir)
-		new_dir->i_mtime = inode_set_ctime_current(new_dir);
+		inode_set_mtime_to_ts(new_dir,
+				      inode_set_ctime_current(new_dir));
 	inode_set_ctime_current(d_inode(old_dentry));
 	if (newino)
 		inode_set_ctime_current(newino);
@@ -926,7 +928,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 	 */
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
@@ -952,7 +954,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 			goto out;
 		}
 		inode->i_mode = S_IFREG | files->mode;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_fop = files->ops;
 		inode->i_ino = i;
 		d_add(dentry, inode);
@@ -1520,7 +1522,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	return inode;
 }
 EXPORT_SYMBOL(alloc_anon_inode);
@@ -1920,8 +1922,12 @@ EXPORT_SYMBOL_GPL(direct_write_fallback);
  * When a new inode is created, most filesystems set the timestamps to the
  * current time. Add a helper to do this.
  */
-struct timespec64 simple_inode_init_ts(struct inode *inode);
+struct timespec64 simple_inode_init_ts(struct inode *inode)
 {
-	return inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	struct timespec64 ts = inode_set_ctime_current(inode);
+
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
+	return ts;
 }
 EXPORT_SYMBOL(simple_inode_init_ts);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 647a22433bd8..9a4b228d42fa 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -84,7 +84,7 @@ static int __ns_get_path(struct path *path, struct ns_common *ns)
 		return -ENOMEM;
 	}
 	inode->i_ino = ns->inum;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_flags |= S_IMMUTABLE;
 	inode->i_mode = S_IFREG | S_IRUGO;
 	inode->i_fop = &ns_file_operations;
diff --git a/fs/pipe.c b/fs/pipe.c
index 139190165a1c..b96a5918d064 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -898,7 +898,7 @@ static struct inode * get_pipe_inode(void)
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	return inode;
 
diff --git a/fs/stack.c b/fs/stack.c
index b5e01bdb5f5f..f18920119944 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -66,8 +66,8 @@ void fsstack_copy_attr_all(struct inode *dest, const struct inode *src)
 	dest->i_uid = src->i_uid;
 	dest->i_gid = src->i_gid;
 	dest->i_rdev = src->i_rdev;
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
+	inode_set_mtime_to_ts(dest, inode_get_mtime(src));
 	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..24bb0209e459 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -57,8 +57,8 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
-	stat->atime = inode->i_atime;
-	stat->mtime = inode->i_mtime;
+	stat->atime = inode_get_atime(inode);
+	stat->mtime = inode_get_mtime(inode);
 	stat->ctime = inode_get_ctime(inode);
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 010d39d0dc1c..2b1f74b24070 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -16,14 +16,14 @@ extern void fsstack_copy_inode_size(struct inode *dst, struct inode *src);
 static inline void fsstack_copy_attr_atime(struct inode *dest,
 					   const struct inode *src)
 {
-	dest->i_atime = src->i_atime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
 }
 
 static inline void fsstack_copy_attr_times(struct inode *dest,
 					   const struct inode *src)
 {
-	dest->i_atime = src->i_atime;
-	dest->i_mtime = src->i_mtime;
+	inode_set_atime_to_ts(dest, inode_get_atime(src));
+	inode_set_mtime_to_ts(dest, inode_get_mtime(src));
 	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
 }
 
-- 
2.41.0

