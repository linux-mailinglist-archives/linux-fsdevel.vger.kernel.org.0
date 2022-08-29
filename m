Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1427C5A4C77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiH2MxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiH2Mwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B97644E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18236B80EE6
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401AFC433D6;
        Mon, 29 Aug 2022 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776899;
        bh=poWjYK9SjTwluvcDdmSPQOBqOLKNVlS/JrJcA+P2qSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ1p0Mw5lmP4Gl06vv62XpGfwz61hKU9BIdV5i3wYCMJcfZsDcoc5DUgDAsCznT+Z
         VF5/VUc8uUZ18kyGFjHE0b7ulBE1USak89Tr81whkDHqiFDX9AZdbRwkIh4tlqQPad
         7JiYCebGpTCpBa2eizPOvYh4gRlQC80lMhdr5862hzFiyIJnRDum/JjWiED2M7Aghz
         AuCV+eWb4KUxOiB20HOZp1nzqvPVxyrdiSSHpmwnPy5GzU1gQnaNsuvZZzXzJHQcdy
         omZapNeYUZWXu35eORszDB5R1MuJfFlnOevX8grztS4CS31NFsrXNi99fgntStxdaN
         tvDnUj9/5OG5g==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 1/6] ntfs3: rework xattr handlers and switch to POSIX ACL VFS helpers
Date:   Mon, 29 Aug 2022 14:38:40 +0200
Message-Id: <20220829123843.1146874-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5415; i=brauner@kernel.org; h=from:subject; bh=poWjYK9SjTwluvcDdmSPQOBqOLKNVlS/JrJcA+P2qSs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPrtfuPynbZvTBf2yjvdPuSpr2oex3pu4s6bvmoauqGn 5t136ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI3GeG/4kMbA0/592/b9/ZElZwc3 5vU/CG57Ht58SKkha0znr+wZ3hv4N0UrJppUWuobVC+GT/Jfmzt7wQ0fjjMCvy71nryhgDXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The xattr code in ntfs3 is currently a bit confused. For example, it
defines a POSIX ACL i_op->set_acl() method but instead of relying on the
generic POSIX ACL VFS helpers it defines its own set of xattr helpers
with the consequence that i_op->set_acl() is currently dead code.

Switch ntfs3 to rely on the VFS POSIX ACL xattr handlers. Also remove
i_op->{g,s}et_acl() methods from symlink inode operations. Symlinks
don't support xattrs.

This is a preliminary change for the following patches which move
handling idmapped mounts directly in posix_acl_xattr_set().

This survives POSIX ACL xfstests.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ntfs3/inode.c |   2 -
 fs/ntfs3/xattr.c | 102 +++--------------------------------------------
 2 files changed, 6 insertions(+), 98 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 51363d4e8636..26a76ebfe58f 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1927,8 +1927,6 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.setattr	= ntfs3_setattr,
 	.listxattr	= ntfs_listxattr,
 	.permission	= ntfs_permission,
-	.get_acl	= ntfs_get_acl,
-	.set_acl	= ntfs_set_acl,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 6ae1f56b7358..7de8718c68a9 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -625,67 +625,6 @@ int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, false);
 }
 
-static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
-			      struct inode *inode, int type, void *buffer,
-			      size_t size)
-{
-	struct posix_acl *acl;
-	int err;
-
-	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
-		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
-		return -EOPNOTSUPP;
-	}
-
-	acl = ntfs_get_acl(inode, type, false);
-	if (IS_ERR(acl))
-		return PTR_ERR(acl);
-
-	if (!acl)
-		return -ENODATA;
-
-	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
-	posix_acl_release(acl);
-
-	return err;
-}
-
-static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
-			      struct inode *inode, int type, const void *value,
-			      size_t size)
-{
-	struct posix_acl *acl;
-	int err;
-
-	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
-		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
-		return -EOPNOTSUPP;
-	}
-
-	if (!inode_owner_or_capable(mnt_userns, inode))
-		return -EPERM;
-
-	if (!value) {
-		acl = NULL;
-	} else {
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
-		if (IS_ERR(acl))
-			return PTR_ERR(acl);
-
-		if (acl) {
-			err = posix_acl_valid(&init_user_ns, acl);
-			if (err)
-				goto release_and_out;
-		}
-	}
-
-	err = ntfs_set_acl(mnt_userns, inode, acl, type);
-
-release_and_out:
-	posix_acl_release(acl);
-	return err;
-}
-
 /*
  * ntfs_init_acl - Initialize the ACLs of a new inode.
  *
@@ -852,23 +791,6 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		goto out;
 	}
 
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
-	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
-		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
-	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
-	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
-		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
-		/* TODO: init_user_ns? */
-		err = ntfs_xattr_get_acl(
-			&init_user_ns, inode,
-			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
-				? ACL_TYPE_ACCESS
-				: ACL_TYPE_DEFAULT,
-			buffer, size);
-		goto out;
-	}
-#endif
 	/* Deal with NTFS extended attribute. */
 	err = ntfs_get_ea(inode, name, name_len, buffer, size, NULL);
 
@@ -981,22 +903,6 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		goto out;
 	}
 
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
-	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
-		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
-	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
-	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
-		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
-		err = ntfs_xattr_set_acl(
-			mnt_userns, inode,
-			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
-				? ACL_TYPE_ACCESS
-				: ACL_TYPE_DEFAULT,
-			value, size);
-		goto out;
-	}
-#endif
 	/* Deal with NTFS extended attribute. */
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
 
@@ -1086,7 +992,7 @@ static bool ntfs_xattr_user_list(struct dentry *dentry)
 }
 
 // clang-format off
-static const struct xattr_handler ntfs_xattr_handler = {
+static const struct xattr_handler ntfs_other_xattr_handler = {
 	.prefix	= "",
 	.get	= ntfs_getxattr,
 	.set	= ntfs_setxattr,
@@ -1094,7 +1000,11 @@ static const struct xattr_handler ntfs_xattr_handler = {
 };
 
 const struct xattr_handler *ntfs_xattr_handlers[] = {
-	&ntfs_xattr_handler,
+#ifdef CONFIG_NTFS3_FS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
+	&ntfs_other_xattr_handler,
 	NULL,
 };
 // clang-format on
-- 
2.34.1

