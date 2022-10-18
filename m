Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22AF602AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJRMAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJRL7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310DBE2EB;
        Tue, 18 Oct 2022 04:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9435B61525;
        Tue, 18 Oct 2022 11:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65255C4347C;
        Tue, 18 Oct 2022 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094316;
        bh=iwd2iQRd20Wfq9FpRkV1rvyg0up9vB32Itp3gbQykUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYrn/a7utTcF2H46SlHhaPmJqK/Lgq1d9IYHf/YOv2k+I7Si4/zth42oH67cJtq2U
         +UibA/iBOhWwOIsKbcglyB3pQQiXWOTiuG6L1moaRB0xkQ9yxQHoE2hEsyVMFTsdWS
         WNQY5vkNLb4q7J+MCXEPDB9agXp0pow3hsMaH5eRkuuMnfBywr2+pfpE9JbrJlbSOY
         66zaSZA7ZjMRbGtqYIGsYwcE4KzHO0ICr0O5R1uvlli3AceO6GmcU95VFOwrlQQTV7
         fxNmgcpNr3F3fzTT4kzBxBwecNyz6/XuhzqBQI9/GbWOshJh9L9aFGRHAk3gq98/Lh
         vmjSn3HBF/9yQ==
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
Subject: [PATCH v5 29/30] 9p: use stub posix acl handlers
Date:   Tue, 18 Oct 2022 13:56:59 +0200
Message-Id: <20221018115700.166010-30-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5489; i=brauner@kernel.org; h=from:subject; bh=iwd2iQRd20Wfq9FpRkV1rvyg0up9vB32Itp3gbQykUs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdHa16qXfC4soppp0eHjR1nsNvRoNPfqm03ctUDUwzp3 el16RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESqoxn+F+44eVyT3WGui8eZRNX1z/ 7aqU/de/cc10ytJfN95k/mu83IsEutTqL93YPW9m3fel7v3PnqX0IH982HB/VFT3tOf6V/lhUA
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
    
    /* v5 */
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

