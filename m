Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB8B5EF8FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiI2PeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiI2Pcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53E7F102;
        Thu, 29 Sep 2022 08:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D819DB824FC;
        Thu, 29 Sep 2022 15:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F12BC433D6;
        Thu, 29 Sep 2022 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465516;
        bh=Y0Dv8oZ2kBLQjXHBMHpdSe9JSNhpBV74YIaZbY44/Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehm2/KrWABTPehDDk+QoP6cN1cYxDzL1lar8Vcwt/dReiZD/93M6Dr2Tgc5P77tem
         LbVtUhNHx0sZm68pZPZiFInI0+JwFAMXzXqhIhm/edvk5rKHKRliJ5OaPHcOjgI8gn
         Ev9H1qdLEj4lr3A03XjBk8NjcXv5f/u1FVqgMsaxJNtoYDzPm7QLa9LhKnlg4+3YvW
         NA1keq2u1ToGui+y95YQOuMMIgIOUxMxg3mfgVMSWoFBL284/mOlqCIZO+AXHMHm5l
         XYyKtBMqryPcpCjj+bqOsKJPZeE08O/h+wDDpvtbeuRjrkjYN2XvtQ5h8DB6qPvSPT
         h0TZyGkvcgn0w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 24/30] xattr: use posix acl api
Date:   Thu, 29 Sep 2022 17:30:34 +0200
Message-Id: <20220929153041.500115-25-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7733; i=brauner@kernel.org; h=from:subject; bh=Y0Dv8oZ2kBLQjXHBMHpdSe9JSNhpBV74YIaZbY44/Kg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hIz/ThPu9xKJ6+HzfVCoUrZN38xrxU9ffq/e51fFYRX 6Ct1lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cAXOQnI8M99gOvHGS+LnbjO3nfbu8rp0 OS1jWvDqcdiihZaBol7a7C8Fdyl+GCqgD1X/8m+XPuXzhvq4hc/J7uK3zt5mcWaLLqP2EHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/internal.h                   |  4 ++++
 fs/posix_acl.c                  | 37 +++++++++++++++++++++++++++++++++
 fs/xattr.c                      | 31 +++++++++++++++++----------
 include/linux/posix_acl_xattr.h | 10 +++++++--
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index a95b1500ed65..1e67b4b9a4d1 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -222,3 +222,7 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
+int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       const char *acl_name, const void *kvalue, size_t size);
+ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name, void *kvalue, size_t size);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 01209603afc9..52e72a219daa 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1551,3 +1551,40 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
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
index 6303f1c62796..5417c36588a9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -186,6 +186,9 @@ __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -407,6 +410,9 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 {
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -479,6 +485,9 @@ __vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	const struct xattr_handler *handler;
 
+	if (is_posix_acl_xattr(name))
+		return -EOPNOTSUPP;
+
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
@@ -588,17 +597,13 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
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
@@ -705,10 +710,11 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
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
@@ -883,6 +889,9 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (error < 0)
 		return error;
 
+	if (is_posix_acl_xattr(kname))
+		return vfs_remove_acl(mnt_userns, d, kname);
+
 	return vfs_removexattr(mnt_userns, d, kname);
 }
 
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 3bd8fac436bc..0294b3489a81 100644
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

