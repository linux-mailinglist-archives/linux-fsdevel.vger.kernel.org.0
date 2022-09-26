Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D95EAAEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiIZP0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiIZPYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DF33E0D;
        Mon, 26 Sep 2022 07:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954BB60DEF;
        Mon, 26 Sep 2022 14:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C43C43141;
        Mon, 26 Sep 2022 14:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201391;
        bh=OG4oY2BAy3VXyJdjDoNyWSOuP5VC2qvzPpQAEMpU/Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpLACuFpUlAKzOH7mep6qM/ESg3mr/7NC9B7mgNsgIjgKMFqkw0CgGaNMUW9nrmU2
         qExOjnocUpB5d10G4vWDad5dHqCsCPEL4i/NGEQS6OXOSrMt4ojUfII/XXbcAd0C+V
         DebLvUtzxmFfQ9eMdsnTnTN+lvUsCBTnsUYSkdUaWUSlvn4B3uoW1aQSKl9eDIftCc
         Y1zw3i7KGQstkh0kGO3IAf8deQTQbTN5Gn/Q9lKGNC67Im3Nq8G8maik5YsKBx8iXZ
         zYS/CLHFBBHFo7XFc08Ls0fNQfO/aVzaLEADYockaUdU6Wt+GO0IgocuUmXi+ivGvU
         MWNYrjdVDHRJg==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 27/30] ovl: use stub posix acl handlers
Date:   Mon, 26 Sep 2022 16:08:24 +0200
Message-Id: <20220926140827.142806-28-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5066; i=brauner@kernel.org; h=from:subject; bh=OG4oY2BAy3VXyJdjDoNyWSOuP5VC2qvzPpQAEMpU/Vo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnI6UvKpfH7WGVvvybJvNwVms93evnAuZ6Rmxs/SHzyi K1jDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaipM/w38V4lkvilCmBR7M4N7hZKd gZruh8myybIVX9mn2N8t2odwz/S7nK5mczXbu8xbh33wZDNxFBleey2g9XsT1NP+AS9m8xAwA=
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

Now that ovl supports the get and set acl inode operations and the vfs
has been switched to the new posi api, ovl can simply rely on the stub
posix acl handlers. The custom xattr handlers and associated unused
helpers can be removed.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/overlayfs/super.c | 101 ++-----------------------------------------
 1 file changed, 4 insertions(+), 97 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8a13319db1d3..0c7ae79b10b1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -998,83 +998,6 @@ static unsigned int ovl_split_lowerdirs(char *str)
 	return ctr;
 }
 
-static int __maybe_unused
-ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
-			struct dentry *dentry, struct inode *inode,
-			const char *name, void *buffer, size_t size)
-{
-	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
-}
-
-static int __maybe_unused
-ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
-			struct user_namespace *mnt_userns,
-			struct dentry *dentry, struct inode *inode,
-			const char *name, const void *value,
-			size_t size, int flags)
-{
-	struct dentry *workdir = ovl_workdir(dentry);
-	struct inode *realinode = ovl_inode_real(inode);
-	struct posix_acl *acl = NULL;
-	int err;
-
-	/* Check that everything is OK before copy-up */
-	if (value) {
-		/* The above comment can be understood in two ways:
-		 *
-		 * 1. We just want to check whether the basic POSIX ACL format
-		 *    is ok. For example, if the header is correct and the size
-		 *    is sane.
-		 * 2. We want to know whether the ACL_{GROUP,USER} entries can
-		 *    be mapped according to the underlying filesystem.
-		 *
-		 * Currently, we only check 1. If we wanted to check 2. we
-		 * would need to pass the mnt_userns and the fs_userns of the
-		 * underlying filesystem. But frankly, I think checking 1. is
-		 * enough to start the copy-up.
-		 */
-		acl = vfs_set_acl_prepare(&init_user_ns, &init_user_ns, value, size);
-		if (IS_ERR(acl))
-			return PTR_ERR(acl);
-	}
-	err = -EOPNOTSUPP;
-	if (!IS_POSIXACL(d_inode(workdir)))
-		goto out_acl_release;
-	if (!realinode->i_op->set_acl)
-		goto out_acl_release;
-	if (handler->flags == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode)) {
-		err = acl ? -EACCES : 0;
-		goto out_acl_release;
-	}
-	err = -EPERM;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		goto out_acl_release;
-
-	posix_acl_release(acl);
-
-	/*
-	 * Check if sgid bit needs to be cleared (actual setacl operation will
-	 * be done with mounter's capabilities and so that won't do it for us).
-	 */
-	if (unlikely(inode->i_mode & S_ISGID) &&
-	    handler->flags == ACL_TYPE_ACCESS &&
-	    !in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
-		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
-
-		err = ovl_setattr(&init_user_ns, dentry, &iattr);
-		if (err)
-			return err;
-	}
-
-	err = ovl_xattr_set(dentry, inode, handler->name, value, size, flags);
-	return err;
-
-out_acl_release:
-	posix_acl_release(acl);
-	return err;
-}
-
 static int ovl_own_xattr_get(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, void *buffer, size_t size)
@@ -1107,22 +1030,6 @@ static int ovl_other_xattr_set(const struct xattr_handler *handler,
 	return ovl_xattr_set(dentry, inode, name, value, size, flags);
 }
 
-static const struct xattr_handler __maybe_unused
-ovl_posix_acl_access_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags = ACL_TYPE_ACCESS,
-	.get = ovl_posix_acl_xattr_get,
-	.set = ovl_posix_acl_xattr_set,
-};
-
-static const struct xattr_handler __maybe_unused
-ovl_posix_acl_default_xattr_handler = {
-	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags = ACL_TYPE_DEFAULT,
-	.get = ovl_posix_acl_xattr_get,
-	.set = ovl_posix_acl_xattr_set,
-};
-
 static const struct xattr_handler ovl_own_trusted_xattr_handler = {
 	.prefix	= OVL_XATTR_TRUSTED_PREFIX,
 	.get = ovl_own_xattr_get,
@@ -1143,8 +1050,8 @@ static const struct xattr_handler ovl_other_xattr_handler = {
 
 static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
 #ifdef CONFIG_FS_POSIX_ACL
-	&ovl_posix_acl_access_xattr_handler,
-	&ovl_posix_acl_default_xattr_handler,
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
 #endif
 	&ovl_own_trusted_xattr_handler,
 	&ovl_other_xattr_handler,
@@ -1153,8 +1060,8 @@ static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
 
 static const struct xattr_handler *ovl_user_xattr_handlers[] = {
 #ifdef CONFIG_FS_POSIX_ACL
-	&ovl_posix_acl_access_xattr_handler,
-	&ovl_posix_acl_default_xattr_handler,
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
 #endif
 	&ovl_own_user_xattr_handler,
 	&ovl_other_xattr_handler,
-- 
2.34.1

