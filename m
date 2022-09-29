Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26B5EF91B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiI2Pev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiI2Pc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDA17A5F7;
        Thu, 29 Sep 2022 08:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C1261484;
        Thu, 29 Sep 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED1BC43140;
        Thu, 29 Sep 2022 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465523;
        bh=Ki6ZaecL1WN2/CKcdKWufpBoACjb05XWERiuFsY24wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GA7n7EJtHxE/twTEUBcJcUDhDcd51oaDTZkoyRHQ/RSGlvh6MgZWcaP8bPJVOmR5a
         YDMEHfCXfADtrfSETl/QqClnX2Iz5S7XdexkNah3rGdCaDqc35MjPVKRifYiGNoY6T
         7Rmx1m9ITipQhNpfQAa4HH0BC+E3/QNtuw/6ioT0t/BdO1P569zd/iqvKR3jonHwk0
         LpQCoO2UihdeXl66ysLgGjFxvzm7ZD6ubBimSHV0bkPdixS/vJxPlrKXLK1MSGKiEa
         3dAnnW9Kv1n8zDj5iJ0/EFZ9ZMkXJv0qwGmrlPpSVBnIrwi5GWAcZE4w2nrsocJCEs
         Jl0fvfIJmPsMQ==
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
Subject: [PATCH v4 27/30] ovl: use stub posix acl handlers
Date:   Thu, 29 Sep 2022 17:30:37 +0200
Message-Id: <20220929153041.500115-28-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5136; i=brauner@kernel.org; h=from:subject; bh=Ki6ZaecL1WN2/CKcdKWufpBoACjb05XWERiuFsY24wg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hJvtbjH8GaB1BRDSwbJimldVgpnb/eJKAa9YL5YtyRc R1e/o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLPrBj+8OxzPzpPeL/+XzVO4eXB64 w9Ftl8f1c9+aevw//LE3SizjAyfNSMcHCxrhFm6+WVnjRbOSr/RTjjqqXHquouNHp4dP5jAwA=
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
    
    /* v3 */
    unchanged
    
    /* v4 */
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

