Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07961610F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ1LLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1LLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F31D1004
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 04:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EF4627B9
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 11:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3458C433D7;
        Fri, 28 Oct 2022 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666955492;
        bh=/s+quVGlTCt4m2PJixQI4s285Vf+QnvZ+jRedHrmYW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWMOOBu0LiGSKuzg1uJsRJFrCroG0U/K8StjyKAj4UPseI+kz3/EjfnLXMq3verII
         JQx5ouV7hihixlftT50nSQbepvByftk4+VjF2fylu7NLQYVHu5+y0mKj9trglLZw3b
         MgmywiGx+scqNRzlIsghpLt/6klCZ2LSNb8gAeTOr/L3LyYT1cip92gRIo6HbISjHf
         FlrdSoW9nGALeDa8uD55Y6u36Z5H5dIQrJMAhj/dWAq6yngBwnnu/15AoIhrrQRfgn
         3Z4xhaY92/JSyaEg1R+5tFSkrAPXliLUhmOdaqEX+ki7dc9gbwu+qzxDYCVQK1x0i0
         t/+gEZKvzK/gw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>
Subject: [PATCH 2/2] acl: conver higher-level helpers to rely on mnt_idmap
Date:   Fri, 28 Oct 2022 13:10:42 +0200
Message-Id: <20221028111041.448001-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028111041.448001-1-brauner@kernel.org>
References: <20221028111041.448001-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11184; i=brauner@kernel.org; h=from:subject; bh=/s+quVGlTCt4m2PJixQI4s285Vf+QnvZ+jRedHrmYW0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRH71hi++5AdK98pO79iB8ney1//N/sYrZdU7b9/J+pW+bu ie9J6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIhx0jw4ugunbtQ1HLiv9IJOZrc5 8yW3mMobkpXETf/lm3f/rJ2Qz/A4zfh3662+8daHjzYjh/hNJ3a5mt+sIFjTwWebxmf/N4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert an initial portion to rely on struct mnt_idmap by converting the
high level xattr helpers.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/internal.h    | 12 ++++++------
 fs/posix_acl.c   | 15 ++++++++-------
 fs/xattr.c       | 39 ++++++++++++++++++++-------------------
 io_uring/xattr.c |  6 +++---
 4 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 0c8812fe7ca4..a803cc3cf716 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -227,28 +227,28 @@ struct xattr_ctx {
 };
 
 
-ssize_t do_getxattr(struct user_namespace *mnt_userns,
+ssize_t do_getxattr(struct mnt_idmap *idmap,
 		    struct dentry *d,
 		    struct xattr_ctx *ctx);
 
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
-int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
 
 #ifdef CONFIG_FS_POSIX_ACL
-int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int do_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	       const char *acl_name, const void *kvalue, size_t size);
-ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ssize_t do_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   const char *acl_name, void *kvalue, size_t size);
 #else
-static inline int do_set_acl(struct user_namespace *mnt_userns,
+static inline int do_set_acl(struct mnt_idmap *idmap,
 			     struct dentry *dentry, const char *acl_name,
 			     const void *kvalue, size_t size)
 {
 	return -EOPNOTSUPP;
 }
-static inline ssize_t do_get_acl(struct user_namespace *mnt_userns,
+static inline ssize_t do_get_acl(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *acl_name,
 				 void *kvalue, size_t size)
 {
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 989bbf280bfe..47b5263ba92e 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -871,7 +871,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);
 
 /**
  * vfs_posix_acl_to_xattr - convert from kernel to userspace representation
- * @mnt_userns: user namespace of the mount
+ * @idmap: idmap of the mount
  * @inode: inode the posix acls are set on
  * @acl: the posix acls as represented by the vfs
  * @buffer: the buffer into which to convert @acl
@@ -884,7 +884,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);
  * Return: On success, the size of the stored uapi posix acls, on error a
  * negative errno.
  */
-static ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
+static ssize_t vfs_posix_acl_to_xattr(struct mnt_idmap *idmap,
 				      struct inode *inode,
 				      const struct posix_acl *acl, void *buffer,
 				      size_t size)
@@ -893,6 +893,7 @@ static ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 	struct posix_acl_xattr_header *ext_acl = buffer;
 	struct posix_acl_xattr_entry *ext_entry;
 	struct user_namespace *fs_userns, *caller_userns;
+	struct user_namespace *mnt_userns = idmap->owner;
 	ssize_t real_size, n;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -1227,7 +1228,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(vfs_remove_acl);
 
-int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+int do_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	       const char *acl_name, const void *kvalue, size_t size)
 {
 	int error;
@@ -1243,22 +1244,22 @@ int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 			return PTR_ERR(acl);
 	}
 
-	error = vfs_set_acl(mnt_userns, dentry, acl_name, acl);
+	error = vfs_set_acl(idmap->owner, dentry, acl_name, acl);
 	posix_acl_release(acl);
 	return error;
 }
 
-ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+ssize_t do_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		   const char *acl_name, void *kvalue, size_t size)
 {
 	ssize_t error;
 	struct posix_acl *acl;
 
-	acl = vfs_get_acl(mnt_userns, dentry, acl_name);
+	acl = vfs_get_acl(idmap->owner, dentry, acl_name);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 
-	error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(dentry),
+	error = vfs_posix_acl_to_xattr(idmap, d_inode(dentry),
 				       acl, kvalue, size);
 	posix_acl_release(acl);
 	return error;
diff --git a/fs/xattr.c b/fs/xattr.c
index df3af9fa8c77..1c01cca472ea 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -597,19 +597,19 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 	return error;
 }
 
-int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		struct xattr_ctx *ctx)
 {
 	if (is_posix_acl_xattr(ctx->kname->name))
-		return do_set_acl(mnt_userns, dentry, ctx->kname->name,
+		return do_set_acl(idmap, dentry, ctx->kname->name,
 				  ctx->kvalue, ctx->size);
 
-	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
+	return vfs_setxattr(idmap->owner, dentry, ctx->kname->name,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
 
 static long
-setxattr(struct user_namespace *mnt_userns, struct dentry *d,
+setxattr(struct mnt_idmap *idmap, struct dentry *d,
 	const char __user *name, const void __user *value, size_t size,
 	int flags)
 {
@@ -627,7 +627,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error)
 		return error;
 
-	error = do_setxattr(mnt_userns, d, &ctx);
+	error = do_setxattr(idmap, d, &ctx);
 
 	kvfree(ctx.kvalue);
 	return error;
@@ -646,7 +646,7 @@ static int path_setxattr(const char __user *pathname,
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = setxattr(mnt_user_ns(path.mnt), path.dentry, name,
+		error = setxattr(mnt_idmapping(path.mnt), path.dentry, name,
 				 value, size, flags);
 		mnt_drop_write(path.mnt);
 	}
@@ -683,7 +683,7 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(file_mnt_user_ns(f.file),
+		error = setxattr(file_mnt_idmap(f.file),
 				 f.file->f_path.dentry, name,
 				 value, size, flags);
 		mnt_drop_write_file(f.file);
@@ -696,7 +696,7 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
  * Extended attribute GET operations
  */
 ssize_t
-do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
+do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
 	struct xattr_ctx *ctx)
 {
 	ssize_t error;
@@ -711,9 +711,9 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	}
 
 	if (is_posix_acl_xattr(ctx->kname->name))
-		error = do_get_acl(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+		error = do_get_acl(idmap, d, kname, ctx->kvalue, ctx->size);
 	else
-		error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+		error = vfs_getxattr(idmap->owner, d, kname, ctx->kvalue, ctx->size);
 	if (error > 0) {
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
@@ -727,7 +727,7 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 }
 
 static ssize_t
-getxattr(struct user_namespace *mnt_userns, struct dentry *d,
+getxattr(struct mnt_idmap *idmap, struct dentry *d,
 	 const char __user *name, void __user *value, size_t size)
 {
 	ssize_t error;
@@ -746,7 +746,7 @@ getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error < 0)
 		return error;
 
-	error =  do_getxattr(mnt_userns, d, &ctx);
+	error =  do_getxattr(idmap, d, &ctx);
 
 	kvfree(ctx.kvalue);
 	return error;
@@ -762,7 +762,8 @@ static ssize_t path_getxattr(const char __user *pathname,
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
-	error = getxattr(mnt_user_ns(path.mnt), path.dentry, name, value, size);
+	error = getxattr(mnt_idmapping(path.mnt), path.dentry,
+			 name, value, size);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -792,7 +793,7 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 	if (!f.file)
 		return error;
 	audit_file(f.file);
-	error = getxattr(file_mnt_user_ns(f.file), f.file->f_path.dentry,
+	error = getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
 	fdput(f);
 	return error;
@@ -877,7 +878,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct user_namespace *mnt_userns, struct dentry *d,
+removexattr(struct mnt_idmap *idmap, struct dentry *d,
 	    const char __user *name)
 {
 	int error;
@@ -890,9 +891,9 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 		return error;
 
 	if (is_posix_acl_xattr(kname))
-		return vfs_remove_acl(mnt_userns, d, kname);
+		return vfs_remove_acl(idmap->owner, d, kname);
 
-	return vfs_removexattr(mnt_userns, d, kname);
+	return vfs_removexattr(idmap->owner, d, kname);
 }
 
 static int path_removexattr(const char __user *pathname,
@@ -906,7 +907,7 @@ static int path_removexattr(const char __user *pathname,
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(mnt_user_ns(path.mnt), path.dentry, name);
+		error = removexattr(mnt_idmapping(path.mnt), path.dentry, name);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -939,7 +940,7 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	audit_file(f.file);
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = removexattr(file_mnt_user_ns(f.file),
+		error = removexattr(file_mnt_idmap(f.file),
 				    f.file->f_path.dentry, name);
 		mnt_drop_write_file(f.file);
 	}
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 99df641594d7..1da0f06f3634 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -112,7 +112,7 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags)
 	if (issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
-	ret = do_getxattr(mnt_user_ns(req->file->f_path.mnt),
+	ret = do_getxattr(mnt_idmapping(req->file->f_path.mnt),
 			req->file->f_path.dentry,
 			&ix->ctx);
 
@@ -133,7 +133,7 @@ int io_getxattr(struct io_kiocb *req, unsigned int issue_flags)
 retry:
 	ret = filename_lookup(AT_FDCWD, ix->filename, lookup_flags, &path, NULL);
 	if (!ret) {
-		ret = do_getxattr(mnt_user_ns(path.mnt),
+		ret = do_getxattr(mnt_idmapping(path.mnt),
 				path.dentry,
 				&ix->ctx);
 
@@ -213,7 +213,7 @@ static int __io_setxattr(struct io_kiocb *req, unsigned int issue_flags,
 
 	ret = mnt_want_write(path->mnt);
 	if (!ret) {
-		ret = do_setxattr(mnt_user_ns(path->mnt), path->dentry, &ix->ctx);
+		ret = do_setxattr(mnt_idmapping(path->mnt), path->dentry, &ix->ctx);
 		mnt_drop_write(path->mnt);
 	}
 
-- 
2.34.1

