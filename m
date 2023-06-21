Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBA7387AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjFUOtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjFUOsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67A19AB;
        Wed, 21 Jun 2023 07:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C81761536;
        Wed, 21 Jun 2023 14:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE27DC433C8;
        Wed, 21 Jun 2023 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358875;
        bh=MMiHJmJBNyH0712JDFBQLINvQMhdjt5Al9Z5DaYQAOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6kC0+XzDaO9aaR2d2QH26S46NyMvGMFpyfpkUyHHnQZkNcVo2QR4IWpE10dRmx0c
         gJjBKfrFG3dK3aLxdi5ozDCdfXTOKbB/AHPWRwnqM0IgtZHpRPFd11A5wXuOfaPbTE
         DjpxYC6Sb5EXHL6Fau+1J77wBFTv3EsNz6XX0lnPdJgKk+H1YCCQeaihkWkvw2/g7D
         ysT4N+AhnHqmaWRjU8bDfSnB8wNRZRpujPwUQB1USSqCnE+BaSaypAUFshv0CMR/Ex
         fr7lcbdsvZl9zhdP5mjI28tAC39Z/qe8pW1hfVFLBLjy+lSo8bmtYPTFx9a+tY4XL4
         mJLu49+a0gZmQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 12/79] fs: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:25 -0400
Message-ID: <20230621144735.55953-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c                |  2 +-
 fs/bad_inode.c           |  3 +--
 fs/binfmt_misc.c         |  3 +--
 fs/inode.c               | 12 ++++++++----
 fs/libfs.c               | 32 +++++++++++++++++---------------
 fs/nsfs.c                |  2 +-
 fs/pipe.c                |  2 +-
 fs/posix_acl.c           |  2 +-
 fs/stack.c               |  2 +-
 fs/stat.c                |  2 +-
 include/linux/fs_stack.h |  2 +-
 11 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index d60dc1edb526..2750e5f98dfb 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -312,7 +312,7 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_ctime_set(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index db649487d58c..bd3762e1b670 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -209,8 +209,7 @@ void make_bad_inode(struct inode *inode)
 	remove_inode_hash(inode);
 
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode->i_ctime =
-		current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_op = &bad_inode_ops;	
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &bad_file_ops;	
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index bb202ad369d5..6af92eb1b871 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -547,8 +547,7 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode->i_mode = mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-			current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	}
 	return inode;
 }
diff --git a/fs/inode.c b/fs/inode.c
index c005e7328fbb..a7f484e9e7c1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1851,6 +1851,7 @@ EXPORT_SYMBOL(bmap);
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
 {
+	struct timespec64 ctime;
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
@@ -1862,7 +1863,8 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 	/*
 	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
-	if (timespec64_compare(&inode->i_ctime, &inode->i_atime) >= 0)
+	ctime = inode_ctime_peek(inode);
+	if (timespec64_compare(&ctime, &inode->i_atime) >= 0)
 		return 1;
 
 	/*
@@ -1885,7 +1887,7 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 		if (flags & S_ATIME)
 			inode->i_atime = *time;
 		if (flags & S_CTIME)
-			inode->i_ctime = *time;
+			inode_ctime_set(inode, *time);
 		if (flags & S_MTIME)
 			inode->i_mtime = *time;
 
@@ -2071,6 +2073,7 @@ EXPORT_SYMBOL(file_remove_privs);
 static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 {
 	int sync_it = 0;
+	struct timespec64 ctime;
 
 	/* First try to exhaust all avenues to not sync */
 	if (IS_NOCMTIME(inode))
@@ -2079,7 +2082,8 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (!timespec64_equal(&inode->i_mtime, now))
 		sync_it = S_MTIME;
 
-	if (!timespec64_equal(&inode->i_ctime, now))
+	ctime = inode_ctime_peek(inode);
+	if (!timespec64_equal(&ctime, now))
 		sync_it |= S_CTIME;
 
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
@@ -2510,7 +2514,7 @@ struct timespec64 inode_ctime_set_current(struct inode *inode)
 {
 	struct timespec64 now = current_time(inode);
 
-	inode_set_ctime(inode, now);
+	inode_ctime_set(inode, now);
 	return now;
 }
 EXPORT_SYMBOL(inode_ctime_set_current);
diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..4a914f09fa87 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -275,7 +275,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		while ((child = find_next_child(this, victim)) == NULL) {
 			// kill and ascend
 			// update metadata while it's still locked
-			inode->i_ctime = current_time(inode);
+			inode_ctime_set_current(inode);
 			clear_nlink(inode);
 			inode_unlock(inode);
 			victim = this;
@@ -293,8 +293,7 @@ void simple_recursive_removal(struct dentry *dentry,
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-				inode->i_ctime = inode->i_mtime =
-					current_time(inode);
+				inode->i_mtime = inode_ctime_set_current(inode);
 				if (d_is_dir(dentry))
 					drop_nlink(inode);
 				inode_unlock(inode);
@@ -335,7 +334,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	root->i_ino = 1;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_atime = root->i_mtime = root->i_ctime = current_time(root);
+	root->i_atime = root->i_mtime = inode_ctime_set_current(root);
 	s->s_root = d_make_root(root);
 	if (!s->s_root)
 		return -ENOMEM;
@@ -391,7 +390,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode_ctime_set_current(inode);
+	inode->i_mtime = inode_ctime_set_current(dir);
 	inc_nlink(inode);
 	ihold(inode);
 	dget(dentry);
@@ -425,7 +425,8 @@ int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode_ctime_set_current(inode);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	drop_nlink(inode);
 	dput(dentry);
 	return 0;
@@ -459,10 +460,10 @@ int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 			inc_nlink(old_dir);
 		}
 	}
-	old_dir->i_ctime = old_dir->i_mtime =
-	new_dir->i_ctime = new_dir->i_mtime =
-	d_inode(old_dentry)->i_ctime =
-	d_inode(new_dentry)->i_ctime = current_time(old_dir);
+	old_dir->i_mtime = inode_ctime_set_current(old_dir);
+	new_dir->i_mtime = inode_ctime_set_current(new_dir);
+	inode_ctime_set_current(d_inode(old_dentry));
+	inode_ctime_set_current(d_inode(new_dentry));
 
 	return 0;
 }
@@ -495,8 +496,9 @@ int simple_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		inc_nlink(new_dir);
 	}
 
-	old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
-		new_dir->i_mtime = inode->i_ctime = current_time(old_dir);
+	old_dir->i_mtime = inode_ctime_set_current(old_dir);
+	new_dir->i_mtime = inode_ctime_set_current(new_dir);
+	inode_ctime_set_current(inode);
 
 	return 0;
 }
@@ -659,7 +661,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 	 */
 	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
@@ -685,7 +687,7 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 			goto out;
 		}
 		inode->i_mode = S_IFREG | files->mode;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		inode->i_fop = files->ops;
 		inode->i_ino = i;
 		d_add(dentry, inode);
@@ -1253,7 +1255,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	return inode;
 }
 EXPORT_SYMBOL(alloc_anon_inode);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index f602a96a1afe..c052cc55eacd 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -84,7 +84,7 @@ static int __ns_get_path(struct path *path, struct ns_common *ns)
 		return -ENOMEM;
 	}
 	inode->i_ino = ns->inum;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_flags |= S_IMMUTABLE;
 	inode->i_mode = S_IFREG | S_IRUGO;
 	inode->i_fop = &ns_file_operations;
diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..bb90b6fc4a96 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -899,7 +899,7 @@ static struct inode * get_pipe_inode(void)
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 
 	return inode;
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7fa1b738bbab..cc9c390fd2af 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1027,7 +1027,7 @@ int simple_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			return error;
 	}
 
-	inode->i_ctime = current_time(inode);
+	inode_ctime_set_current(inode);
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
 	set_cached_acl(inode, type, acl);
diff --git a/fs/stack.c b/fs/stack.c
index c9830924eb12..efd0de85bace 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -68,7 +68,7 @@ void fsstack_copy_attr_all(struct inode *dest, const struct inode *src)
 	dest->i_rdev = src->i_rdev;
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
+	inode_ctime_set(dest, inode_ctime_peek(src));
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
 	set_nlink(dest, src->i_nlink);
diff --git a/fs/stat.c b/fs/stat.c
index 7c238da22ef0..5d87e34d6dd5 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -58,7 +58,7 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
 	stat->mtime = inode->i_mtime;
-	stat->ctime = inode->i_ctime;
+	stat->ctime = inode_ctime_peek(inode);
 	stat->blksize = i_blocksize(inode);
 	stat->blocks = inode->i_blocks;
 }
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 54210a42c30d..1488a118fe91 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -24,7 +24,7 @@ static inline void fsstack_copy_attr_times(struct inode *dest,
 {
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
-	dest->i_ctime = src->i_ctime;
+	inode_ctime_set(dest, inode_ctime_peek(src));
 }
 
 #endif /* _LINUX_FS_STACK_H */
-- 
2.41.0

