Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088635EF90F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiI2Pe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiI2Pc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5BF81682;
        Thu, 29 Sep 2022 08:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2D9DB824F8;
        Thu, 29 Sep 2022 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD7BC433D6;
        Thu, 29 Sep 2022 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465529;
        bh=sGGzKDwsgYREgfGdXM5JE9oiQ6rtrLxNQvP1idj7M38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F59vtkDBGdmxwE45iqh4d/8LkWxhbivmVy3l0VUDPzuG+LpkoWwqIP3gC4gCoU+1K
         etCIr2pL283GHJnxCAzXDrsjBnf5jIZBxWP4qJ7txTrh2D7A7sL7zAC88fOM34QTi+
         qB2BJhi2R+PunI/3VzvVkN8HDpUCUoZfHRyIrzJWrKMLwvpf+5wMxNU5T9LFoe67Z1
         YPYvgBarmrZceB/1Uo13CRfgECmWwtiMVbI7jX77Xod7kCNfEeFfd6BiLaTtUYiOZP
         y9MScbBTvYCvSQz6f2DngP6ySVAvGV9BJTKADbJWCjLWfgpqzZ/dGYgRLPwEN7hY9M
         BfZNt0QUjr4Fw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 29/30] 9p: use stub posix acl handlers
Date:   Thu, 29 Sep 2022 17:30:39 +0200
Message-Id: <20220929153041.500115-30-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5454; i=brauner@kernel.org; h=from:subject; bh=sGGzKDwsgYREgfGdXM5JE9oiQ6rtrLxNQvP1idj7M38=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hKv5WJedWf3ncTiC1J3DS8/l15rcE6lPcC8/dztJ2zb przc2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARuXWMDGceVc/4uLD+Okvcx8Kr5x stuUU5pk9557j0UnbJ3MrtKdUM//OV37HmNzKpTbzgdPXLbOYllzLczn/raMoW4sxMZWm+xAoA
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

Now that 9p supports the get and set acl inode operations and the vfs
has been switched to the new posi api, 9p can simply rely on the stub
posix acl handlers. The custom xattr handlers and associated unused
helpers can be removed.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged

 fs/9p/acl.c   | 121 --------------------------------------------------
 fs/9p/xattr.c |   7 +--
 fs/9p/xattr.h |   2 -
 3 files changed, 4 insertions(+), 126 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 135b26cee63a..c397c51f80d9 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -343,124 +343,3 @@ int v9fs_acl_mode(struct inode *dir, umode_t *modep,
 	*modep  = mode;
 	return 0;
 }
-
-static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
-			      struct dentry *dentry, struct inode *inode,
-			      const char *name, void *buffer, size_t size)
-{
-	struct v9fs_session_info *v9ses;
-	struct posix_acl *acl;
-	int error;
-
-	v9ses = v9fs_dentry2v9ses(dentry);
-	/*
-	 * We allow set/get/list of acl when access=client is not specified
-	 */
-	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
-		return v9fs_xattr_get(dentry, handler->name, buffer, size);
-
-	acl = v9fs_get_cached_acl(inode, handler->flags);
-	if (IS_ERR(acl))
-		return PTR_ERR(acl);
-	if (acl == NULL)
-		return -ENODATA;
-	error = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
-	posix_acl_release(acl);
-
-	return error;
-}
-
-static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
-			      struct user_namespace *mnt_userns,
-			      struct dentry *dentry, struct inode *inode,
-			      const char *name, const void *value,
-			      size_t size, int flags)
-{
-	int retval;
-	struct posix_acl *acl;
-	struct v9fs_session_info *v9ses;
-
-	v9ses = v9fs_dentry2v9ses(dentry);
-	/*
-	 * set the attribute on the remote. Without even looking at the
-	 * xattr value. We leave it to the server to validate
-	 */
-	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
-		return v9fs_xattr_set(dentry, handler->name, value, size,
-				      flags);
-
-	if (S_ISLNK(inode->i_mode))
-		return -EOPNOTSUPP;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		return -EPERM;
-	if (value) {
-		/* update the cached acl value */
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
-		if (IS_ERR(acl))
-			return PTR_ERR(acl);
-		else if (acl) {
-			retval = posix_acl_valid(inode->i_sb->s_user_ns, acl);
-			if (retval)
-				goto err_out;
-		}
-	} else
-		acl = NULL;
-
-	switch (handler->flags) {
-	case ACL_TYPE_ACCESS:
-		if (acl) {
-			struct iattr iattr = { 0 };
-			struct posix_acl *old_acl = acl;
-
-			retval = posix_acl_update_mode(&init_user_ns, inode,
-						       &iattr.ia_mode, &acl);
-			if (retval)
-				goto err_out;
-			if (!acl) {
-				/*
-				 * ACL can be represented
-				 * by the mode bits. So don't
-				 * update ACL.
-				 */
-				posix_acl_release(old_acl);
-				value = NULL;
-				size = 0;
-			}
-			iattr.ia_valid = ATTR_MODE;
-			/* FIXME should we update ctime ?
-			 * What is the following setxattr update the
-			 * mode ?
-			 */
-			v9fs_vfs_setattr_dotl(&init_user_ns, dentry, &iattr);
-		}
-		break;
-	case ACL_TYPE_DEFAULT:
-		if (!S_ISDIR(inode->i_mode)) {
-			retval = acl ? -EINVAL : 0;
-			goto err_out;
-		}
-		break;
-	default:
-		BUG();
-	}
-	retval = v9fs_xattr_set(dentry, handler->name, value, size, flags);
-	if (!retval)
-		set_cached_acl(inode, handler->flags, acl);
-err_out:
-	posix_acl_release(acl);
-	return retval;
-}
-
-const struct xattr_handler v9fs_xattr_acl_access_handler = {
-	.name	= XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags	= ACL_TYPE_ACCESS,
-	.get	= v9fs_xattr_get_acl,
-	.set	= v9fs_xattr_set_acl,
-};
-
-const struct xattr_handler v9fs_xattr_acl_default_handler = {
-	.name	= XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags	= ACL_TYPE_DEFAULT,
-	.get	= v9fs_xattr_get_acl,
-	.set	= v9fs_xattr_set_acl,
-};
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 1f9298a4bd42..ae6a93871338 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/uio.h>
+#include <linux/posix_acl_xattr.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -182,9 +183,9 @@ static struct xattr_handler v9fs_xattr_security_handler = {
 const struct xattr_handler *v9fs_xattr_handlers[] = {
 	&v9fs_xattr_user_handler,
 	&v9fs_xattr_trusted_handler,
-#ifdef CONFIG_9P_FS_POSIX_ACL
-	&v9fs_xattr_acl_access_handler,
-	&v9fs_xattr_acl_default_handler,
+#ifdef CONFIG_FS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
 #endif
 #ifdef CONFIG_9P_FS_SECURITY
 	&v9fs_xattr_security_handler,
diff --git a/fs/9p/xattr.h b/fs/9p/xattr.h
index 3e11fc3331eb..b5636e544c8a 100644
--- a/fs/9p/xattr.h
+++ b/fs/9p/xattr.h
@@ -11,8 +11,6 @@
 #include <net/9p/client.h>
 
 extern const struct xattr_handler *v9fs_xattr_handlers[];
-extern const struct xattr_handler v9fs_xattr_acl_access_handler;
-extern const struct xattr_handler v9fs_xattr_acl_default_handler;
 
 ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 			   void *buffer, size_t buffer_size);
-- 
2.34.1

