Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1285EF8D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiI2Pc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiI2Pbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7A8E459;
        Thu, 29 Sep 2022 08:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AF061484;
        Thu, 29 Sep 2022 15:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53BC433B5;
        Thu, 29 Sep 2022 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465474;
        bh=U7fsHZPo9dptzXtrDHRMBH0uX1up5x/P7cui953kXI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLslx1JlU0Bbq8GnO/f+G9IOL0mSEay/jQUecmh/TU1Vnk5Yv+NwbJj89TX/ORHEg
         iPe17bLfdHF7AwyPYqO1zGie6qRlFsZuwQ9W3fJhTUgggxFGXRVCmEFgkDfzHox/s9
         aFamX/YWq0XIR/w2wj5/iTZFpk1bZonsSGMRuIJKTyAiWvgnlOWCuCgo03mGeaoRkH
         74jY6audzNP5mnM0a3it3GzrXeM0HA1vh1Fur261UJHOiCM1OQIJNgEWBIAdJwaRXh
         2XBxOCS/XQjAf7ijtjZ1yKGDCd/x9WVMdjH7TJIZYLMCbc8RsuSPSBUUy8ZDeCZaa0
         RPFwkNowubpjQ==
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
Subject: [PATCH v4 08/30] 9p: implement set acl method
Date:   Thu, 29 Sep 2022 17:30:18 +0200
Message-Id: <20220929153041.500115-9-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6435; i=brauner@kernel.org; h=from:subject; bh=U7fsHZPo9dptzXtrDHRMBH0uX1up5x/P7cui953kXI4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hLeueu4q5/FaenQtRej2543//5m4214ll3A++rzcr6I N4fnd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk3k6GX0xc/xl1L21Y90FPpNvyqQ BXg1ipXGuf+k+JwI+NpWcfv2f4n+HAuf6IV13Cg7fzm+b5fLjOGT5l8Z7bWvICKx1aj16M5AUA
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

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

So far 9p implemented a ->get_inode_acl() operation that didn't require
access to the dentry in order to allow (limited) permission checking via
posix acls in the vfs. Now that we have get and set acl inode operations
that take a dentry argument we can give 9p get and set acl inode
operations.

This is mostly a light refactoring of the codepaths currently used in 9p
posix acl xattr handler. After we have fully implemented the posix acl
api and switched the vfs over to it, the 9p specific posix acl xattr
handler and associated code will be removed.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Al Viro <viro@zeniv.linux.org.uk>:
    - Fix leak due to early return instead of goto.
    
    Christian Brauner (Microsoft) <brauner@kernel.org>:
    - Fix leak and call kfree() when we skip setting posix acls because acl can be
      represented by mode bits.
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged

 fs/9p/acl.c            | 94 ++++++++++++++++++++++++++++++++++++++++++
 fs/9p/acl.h            |  3 ++
 fs/9p/vfs_inode_dotl.c |  2 +
 3 files changed, 99 insertions(+)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 67f8b57c67e0..135b26cee63a 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -151,6 +151,100 @@ struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
 	return v9fs_get_cached_acl(d_inode(dentry), type);
 }
 
+int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct posix_acl *acl, int type)
+{
+	int retval;
+	size_t size = 0;
+	void *value = NULL;
+	const char *acl_name;
+	struct v9fs_session_info *v9ses;
+	struct inode *inode = d_inode(dentry);
+
+	if (acl) {
+		retval = posix_acl_valid(inode->i_sb->s_user_ns, acl);
+		if (retval)
+			goto err_out;
+
+		size = posix_acl_xattr_size(acl->a_count);
+
+		value = kzalloc(size, GFP_NOFS);
+		if (!value) {
+			retval = -ENOMEM;
+			goto err_out;
+		}
+
+		retval = posix_acl_to_xattr(&init_user_ns, acl, value, size);
+		if (retval < 0)
+			goto err_out;
+	}
+
+	/*
+	 * set the attribute on the remote. Without even looking at the
+	 * xattr value. We leave it to the server to validate
+	 */
+	acl_name = posix_acl_xattr_name(type);
+	v9ses = v9fs_dentry2v9ses(dentry);
+	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT) {
+		retval = v9fs_xattr_set(dentry, acl_name, value, size, 0);
+		goto err_out;
+	}
+
+	if (S_ISLNK(inode->i_mode)) {
+		retval = -EOPNOTSUPP;
+		goto err_out;
+	}
+
+	if (!inode_owner_or_capable(&init_user_ns, inode)) {
+		retval = -EPERM;
+		goto err_out;
+	}
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		if (acl) {
+			struct iattr iattr = {};
+			struct posix_acl *acl_mode = acl;
+
+			retval = posix_acl_update_mode(&init_user_ns, inode,
+						       &iattr.ia_mode,
+						       &acl_mode);
+			if (retval)
+				goto err_out;
+			if (!acl_mode) {
+				/*
+				 * ACL can be represented by the mode bits.
+				 * So don't update ACL below.
+				 */
+				kfree(value);
+				value = NULL;
+				size = 0;
+			}
+			iattr.ia_valid = ATTR_MODE;
+			/*
+			 * FIXME should we update ctime ?
+			 * What is the following setxattr update the mode ?
+			 */
+			v9fs_vfs_setattr_dotl(&init_user_ns, dentry, &iattr);
+		}
+		break;
+	case ACL_TYPE_DEFAULT:
+		if (!S_ISDIR(inode->i_mode)) {
+			retval = acl ? -EINVAL : 0;
+			goto err_out;
+		}
+		break;
+	}
+
+	retval = v9fs_xattr_set(dentry, acl_name, value, size, 0);
+	if (!retval)
+		set_cached_acl(inode, type, acl);
+
+err_out:
+	kfree(value);
+	return retval;
+}
+
 static int v9fs_set_acl(struct p9_fid *fid, int type, struct posix_acl *acl)
 {
 	int retval;
diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index 359dab4da900..4c60a2bce5de 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -12,6 +12,8 @@ struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type,
 				   bool rcu);
 struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
 					  struct dentry *dentry, int type);
+int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct posix_acl *acl, int type);
 int v9fs_acl_chmod(struct inode *inode, struct p9_fid *fid);
 int v9fs_set_create_acl(struct inode *inode, struct p9_fid *fid,
 			struct posix_acl *dacl, struct posix_acl *acl);
@@ -21,6 +23,7 @@ void v9fs_put_acl(struct posix_acl *dacl, struct posix_acl *acl);
 #else
 #define v9fs_iop_get_inode_acl	NULL
 #define v9fs_iop_get_acl NULL
+#define v9fs_iop_set_acl NULL
 static inline int v9fs_get_acl(struct inode *inode, struct p9_fid *fid)
 {
 	return 0;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index a4211fcb9168..03c1743c4aff 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -985,6 +985,7 @@ const struct inode_operations v9fs_dir_inode_operations_dotl = {
 	.listxattr = v9fs_listxattr,
 	.get_inode_acl = v9fs_iop_get_inode_acl,
 	.get_acl = v9fs_iop_get_acl,
+	.set_acl = v9fs_iop_set_acl,
 };
 
 const struct inode_operations v9fs_file_inode_operations_dotl = {
@@ -993,6 +994,7 @@ const struct inode_operations v9fs_file_inode_operations_dotl = {
 	.listxattr = v9fs_listxattr,
 	.get_inode_acl = v9fs_iop_get_inode_acl,
 	.get_acl = v9fs_iop_get_acl,
+	.set_acl = v9fs_iop_set_acl,
 };
 
 const struct inode_operations v9fs_symlink_inode_operations_dotl = {
-- 
2.34.1

