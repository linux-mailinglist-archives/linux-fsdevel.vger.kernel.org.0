Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC38602AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJRMAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJRL7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096DBE2E7;
        Tue, 18 Oct 2022 04:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1E96153B;
        Tue, 18 Oct 2022 11:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0DDC433D6;
        Tue, 18 Oct 2022 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094301;
        bh=d7R20C24URxqVFP5c+KFFxTtGzw+K56XdItsDMhVSHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGFRjUd7TGKFAYYGZ8YwU10wROMuDMgsjC078RUFB8raMGh2sOBS4IVg0V8Nq1jy0
         0BL+AGHB0cvJ0CanbD0RcnGJfpACbGB5ia0nxpCZPfGjNIYQueg7AbjhTinGxOuYsI
         2H1GaNdl4106dY5qE20Ybp7fJfQxPcb4mYSYdsjjUOmA30JZxYd8M+wC1tJUftK4FU
         oJJ8dXz7keJz+kgd82G9G6KTJsCGhsmtTHWlPaAedR3FBqt+T0kdegA+GumiRA84OH
         XEFjbZjvQYMZCCJu/SCuKEWIGoDehooC9mCMYVA3i/WHXst7PpTkx2ffs8x3elPQrV
         sYhGD+K2UdFKw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 24/30] xattr: use posix acl api
Date:   Tue, 18 Oct 2022 13:56:54 +0200
Message-Id: <20221018115700.166010-25-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7760; i=brauner@kernel.org; h=from:subject; bh=d7R20C24URxqVFP5c+KFFxTtGzw+K56XdItsDMhVSHk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdGcF2qzsWd5v5e1ZZiyzO4Qxja+nJPfv+xUm7B9/8e/ U+JfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk7ByGv2LF4nXXlafOn/3PJvz/CT bJnqNHvolt3HU4++/vnReTLlox/NPQOx4f9UHGwHzDLBfvyxoJZy5pGExWOv1gYoHmuTWdH3kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In previous patches we built a new posix api solely around get and set
inode operations. Now that we have all the pieces in place we can switch
the system calls and the vfs over to only rely on this api when
interacting with posix acls. This finally removes all type unsafety and
type conversion issues explained in detail in [1] that we aim to get rid
of.

With the new posix acl api we immediately translate into an appropriate
kernel internal struct posix_acl format both when getting and setting
posix acls. This is a stark contrast to before were we hacked unsafe raw
values into the uapi struct that was stored in a void pointer relying
and having filesystems and security modules hack around in the uapi
struct as well.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - Add do_set_acl() and do_get_acl() to fs/posix_acl.c and fs/internal.h that
      wrap all the conversion and call them from fs/xattr.c. This allows to
      simplify the whole patch and remove unneeded helpers.
    
    /* v5 */
    unchanged

 fs/internal.h                   |  4 ++++
 fs/posix_acl.c                  | 37 +++++++++++++++++++++++++++++++++
 fs/xattr.c                      | 31 +++++++++++++++++----------
 include/linux/posix_acl_xattr.h | 10 +++++++--
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index de43795ab7cd..14fac61ee071 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -235,3 +235,7 @@ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
 int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
+int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       const char *acl_name, const void *kvalue, size_t size);
+ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name, void *kvalue, size_t size);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a84be3fdb6c5..35e4caaedfd8 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1544,3 +1544,40 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_remove_acl);
+
+int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       const char *acl_name, const void *kvalue, size_t size)
+{
+	int error;
+	struct posix_acl *acl = NULL;
+
+	if (size) {
+		/*
+		 * Note that posix_acl_from_xattr() uses GFP_NOFS when it
+		 * probably doesn't need to here.
+		 */
+		acl = posix_acl_from_xattr(current_user_ns(), kvalue, size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+	}
+
+	error = vfs_set_acl(mnt_userns, dentry, acl_name, acl);
+	posix_acl_release(acl);
+	return error;
+}
+
+ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name, void *kvalue, size_t size)
+{
+	ssize_t error;
+	struct posix_acl *acl;
+
+	acl = vfs_get_acl(mnt_userns, dentry, acl_name);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(dentry),
+				       acl, kvalue, size);
+	posix_acl_release(acl);
+	return error;
+}
diff --git a/fs/xattr.c b/fs/xattr.c
index 9ed9eea4d1b9..77db5aa26d13 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -189,6 +189,9 @@ __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -410,6 +413,9 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -482,6 +488,9 @@ __vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -591,17 +600,13 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 	return error;
 }
 
-static void setxattr_convert(struct user_namespace *mnt_userns,
-			     struct dentry *d, struct xattr_ctx *ctx)
-{
-	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
-		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
-}
-
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx)
 {
-	setxattr_convert(mnt_userns, dentry, ctx);
+	if (is_posix_acl_xattr(ctx->kname->name))
+		return do_set_acl(mnt_userns, dentry, ctx->kname->name,
+				  ctx->kvalue, ctx->size);
+
 	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
@@ -708,10 +713,11 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+	if (is_posix_acl_xattr(ctx->kname->name))
+		error = do_get_acl(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+	else
+		error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
 	if (error > 0) {
-		if (is_posix_acl_xattr(kname))
-			posix_acl_fix_xattr_to_user(ctx->kvalue, error);
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
@@ -886,6 +892,9 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error < 0)
 		return error;
 
+	if (is_posix_acl_xattr(kname))
+		return vfs_remove_acl(mnt_userns, d, kname);
+
 	return vfs_removexattr(mnt_userns, d, kname);
 }
 
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index bf30296389d7..c5d5fbc348dc 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -33,6 +33,8 @@ posix_acl_xattr_count(size_t size)
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
+struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns,
+				       const void *value, size_t size);
 void posix_acl_fix_xattr_from_user(void *value, size_t size);
 void posix_acl_fix_xattr_to_user(void *value, size_t size);
 void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
@@ -42,6 +44,12 @@ ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 			       struct inode *inode, const struct posix_acl *acl,
 			       void *buffer, size_t size);
 #else
+static inline struct posix_acl *
+posix_acl_from_xattr(struct user_namespace *user_ns, const void *value,
+		     size_t size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
 {
 }
@@ -63,8 +71,6 @@ static inline ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
 }
 #endif
 
-struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns, 
-				       const void *value, size_t size);
 int posix_acl_to_xattr(struct user_namespace *user_ns,
 		       const struct posix_acl *acl, void *buffer, size_t size);
 struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
-- 
2.34.1

