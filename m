Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0745EF29B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiI2Js4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiI2JsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CF149D09;
        Thu, 29 Sep 2022 02:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C2960EA5;
        Thu, 29 Sep 2022 09:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF56C433C1;
        Thu, 29 Sep 2022 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664444788;
        bh=Rwq3hiekO4F6jvuoY+faDtF7tm+6xI/7ktSr4YHXZ38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cE1KMYZWbu/u5V+JFFf6ekuVKJxUAzatNZoCQ+bc6E4kA4t0SBkmsPsjhYIIXaLzh
         R72H7QsO0uZ3Wv53r62QmXbOy6e4QYSGs7Y66a1J6Mrj7AtNhYSz+uc3fz4EmAePde
         QOhILsdZ2F3u8KTzhoDcYAb3MIgjtG6gncBOt7idIEj8R95hzL0Qh7A1ieQhezPZGA
         FwlUCFYL1IudWIVmUafCfChH7twGG+e6MFD/Dy5oYDMERGjuZdMi+2ghQm0VIuk86D
         atlKr8CURR990fEn2s8iUZmAalnJHP8GRIBj7kfYKI8USxVYExltXO+DRBsk4WgLeR
         PnK24nz31sEpg==
Date:   Thu, 29 Sep 2022 11:46:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 23/29] xattr: use posix acl api
Message-ID: <20220929094623.ajw7kauqwwwovd44@wittgenstein>
References: <20220928160843.382601-1-brauner@kernel.org>
 <20220928160843.382601-24-brauner@kernel.org>
 <20220929082535.GC3699@lst.de>
 <20220929091027.ddw6kbdy2s7ywvh4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929091027.ddw6kbdy2s7ywvh4@wittgenstein>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:10:32AM +0200, Christian Brauner wrote:
> On Thu, Sep 29, 2022 at 10:25:35AM +0200, Christoph Hellwig wrote:
> > On Wed, Sep 28, 2022 at 06:08:37PM +0200, Christian Brauner wrote:
> > > +static int setxattr_convert(struct user_namespace *mnt_userns, struct dentry *d,
> > > +			    struct xattr_ctx *ctx)
> > >  {
> > > -	if (ctx->size && is_posix_acl_xattr(ctx->kname->name))
> > > -		posix_acl_fix_xattr_from_user(ctx->kvalue, ctx->size);
> > > +	struct posix_acl *acl;
> > > +
> > > +	if (!ctx->size || !is_posix_acl_xattr(ctx->kname->name))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Note that posix_acl_from_xattr() uses GFP_NOFS when it probably
> > > +	 * doesn't need to here.
> > > +	 */
> > > +	acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue, ctx->size);
> > > +	if (IS_ERR(acl))
> > > +		return PTR_ERR(acl);
> > > +
> > > +	ctx->acl = acl;
> > > +	return 0;
> > 
> > why is this called setxattr_convert when it is clearly about ACLs only?
> 
> I think that's from Stefan's (Roesch) series to add xattr support to io_uring.
> 
> > 
> > > +
> > > +	error = setxattr_convert(mnt_userns, dentry, ctx);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	if (is_posix_acl_xattr(ctx->kname->name))
> > > +		return vfs_set_acl(mnt_userns, dentry,
> > > +				   ctx->kname->name, ctx->acl);
> > 
> > Also instead of doing two checks for ACLs why not do just one?  And then
> > have a comment helper to convert and set which can live in posix_acl.c.
> > 
> > No need to store anything in a context with that either.
> > 
> > > @@ -610,6 +642,7 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
> > >  	error = do_setxattr(mnt_userns, d, &ctx);
> > >  
> > >  	kvfree(ctx.kvalue);
> > > +	posix_acl_release(ctx.acl);
> > >  	return error;
> > 
> > And I don't think there is any good reason to not release the ACL
> > right after the call to vfs_set_acl.  Which means there is no need to
> > store anything in the ctx.
> > 
> > > +	if (is_posix_acl_xattr(ctx->kname->name)) {
> > > +		ctx->acl = vfs_get_acl(mnt_userns, d, ctx->kname->name);
> > > +		if (IS_ERR(ctx->acl))
> > > +			return PTR_ERR(ctx->acl);
> > > +
> > > +		error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(d), ctx->acl,
> > > +					       ctx->kvalue, ctx->size);
> > > +		posix_acl_release(ctx->acl);
> > 
> > An while this is just a small function body I still think splitting it
> > into a helper and moving it to posix_acl.c would be a bit cleaner.
> 
> All good points. I'll see how workable this is.

Yeah, I think that looks much nicer:

commit c2e1457520fe2a2c1d99e2ffa80d1db1013eee63
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Thu Sep 22 17:17:22 2022 +0200
Commit:     Christian Brauner (Microsoft) <brauner@kernel.org>
CommitDate: Thu Sep 29 11:42:44 2022 +0200

    xattr: use posix acl api
    
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

Notes:
    To: linux-fsdevel@vger.kernel.org
    Cc: Seth Forshee <sforshee@kernel.org>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Cc: linux-security-module@vger.kernel.org
    
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    Christoph Hellwig <hch@lst.de>:
    - Add do_set_acl() and do_get_acl() to fs/posix_acl.c and fs/internal.h that
      wrap all the conversion and call them from fs/xattr.c. This allows to
      simplify the whole patch and remove unneeded helpers.

diff --git a/fs/internal.h b/fs/internal.h
index a95b1500ed65..e88a2272ac58 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -222,3 +222,7 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 int may_write_xattr(struct user_namespace *mnt_userns, struct inode *inode);
+int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       struct xattr_ctx *ctx);
+ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct xattr_ctx *ctx);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 01209603afc9..ebc8d9076223 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1551,3 +1551,41 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_remove_acl);
+
+int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+	       struct xattr_ctx *ctx)
+{
+	int error;
+	struct posix_acl *acl = NULL;
+
+	if (ctx->size) {
+		/*
+		 * Note that posix_acl_from_xattr() uses GFP_NOFS when it
+		 * probably doesn't need to here.
+		 */
+		acl = posix_acl_from_xattr(current_user_ns(), ctx->kvalue,
+					   ctx->size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+	}
+
+	error = vfs_set_acl(mnt_userns, dentry, ctx->kname->name, acl);
+	posix_acl_release(acl);
+	return error;
+}
+
+ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct xattr_ctx *ctx)
+{
+	ssize_t error;
+	struct posix_acl *acl;
+
+	acl = vfs_get_acl(mnt_userns, dentry, ctx->kname->name);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	error = vfs_posix_acl_to_xattr(mnt_userns, d_inode(dentry), acl,
+				       ctx->kvalue, ctx->size);
+	posix_acl_release(acl);
+	return error;
+}
diff --git a/fs/xattr.c b/fs/xattr.c
index 6303f1c62796..1d794172487a 100644
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
@@ -588,17 +597,12 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
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
+		return do_set_acl(mnt_userns, dentry, ctx);
+
 	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
@@ -705,10 +709,11 @@ do_getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
+	if (is_posix_acl_xattr(ctx->kname->name))
+		error = do_get_acl(mnt_userns, d, ctx);
+	else
+		error = vfs_getxattr(mnt_userns, d, kname, ctx->kvalue, ctx->size);
 	if (error > 0) {
-		if (is_posix_acl_xattr(kname))
-			posix_acl_fix_xattr_to_user(ctx->kvalue, error);
 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
@@ -883,6 +888,9 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
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
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 84180afd090b..b766ddfc6bc3 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include <linux/io_uring.h>
 #include <linux/xattr.h>
+#include <linux/posix_acl_xattr.h>
 
 #include <uapi/linux/io_uring.h>
 
