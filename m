Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F15EE160
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiI1QNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiI1QNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2BB2489;
        Wed, 28 Sep 2022 09:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE51B82153;
        Wed, 28 Sep 2022 16:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98102C433B5;
        Wed, 28 Sep 2022 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381588;
        bh=YckADM5XMNo3Jl9DhKl5uru6vEig7gTSu6a0XqzvYwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hF2so1qvbiLOfFkGnVm7hzATQV3u1qNsJaX0VH6UxtafPlx05iYOVREuT6gjcAkau
         jwSerGvvBGHpBlv2Dd2niqg7EsKHw8mzjApQxD4LNO8duhREhzNyZzE0j8qqDdxR7V
         qhDcRZ/bprD3AE18XMIUJqbz6hp6xQ8nDJJHm6pfJARJg1NIwGb4xwwCXI2lCM8Jon
         aqMFGlxx64Vegy8n9bPfjMc8U+hbAa1/ExOGRO/SHPA6AqbaaUjRoeG+/z8SAi22nQ
         30NN7vQKL9oz0w8cAycim+SrupcrwOui/YTAaXSJTYUdujnvByf1yeA6quuemUOIeq
         IZC/Xm3rRrp8g==
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
Subject: [PATCH v3 07/29] 9p: implement get acl method
Date:   Wed, 28 Sep 2022 18:08:21 +0200
Message-Id: <20220928160843.382601-8-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7862; i=brauner@kernel.org; h=from:subject; bh=YckADM5XMNo3Jl9DhKl5uru6vEig7gTSu6a0XqzvYwc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFFb71LsKS6fdCKnrL1fc/NWzqLOEfb6BwPT6SQs3qbKk qi7pKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEj0FkaGu4x/yk36T+bs+TzjaN/syj 33sy72r5Ldsja+d8ZeAwZ5UUaGfwrnVU8vS+ev2VzVv+H28+6FB89nhnoESt1vWtHeJaLPBwA=
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

This is mostly a refactoring of the codepaths currently used in 9p posix
acl xattr handler. After we have fully implemented the posix acl api and
switched the vfs over to it, the 9p specific posix acl xattr handler and
associated code will be removed.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Al Viro <viro@zeniv.linux.org.uk>:
    - Simplify v9fs_iop_get_acl().
    - Simplify v9fs_fid_get_acl() and associated callers.
    
    /* v3 */
    unchanged

 fs/9p/acl.c                     | 80 +++++++++++++++++++++++++--------
 fs/9p/acl.h                     |  5 ++-
 fs/9p/vfs_inode_dotl.c          |  6 ++-
 include/linux/posix_acl_xattr.h | 11 +++++
 4 files changed, 80 insertions(+), 22 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 4dac4a0dc5f4..67f8b57c67e0 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -17,34 +17,64 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
-static struct posix_acl *__v9fs_get_acl(struct p9_fid *fid, char *name)
+static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 {
 	ssize_t size;
 	void *value = NULL;
 	struct posix_acl *acl = NULL;
 
 	size = v9fs_fid_xattr_get(fid, name, NULL, 0);
-	if (size > 0) {
-		value = kzalloc(size, GFP_NOFS);
-		if (!value)
-			return ERR_PTR(-ENOMEM);
-		size = v9fs_fid_xattr_get(fid, name, value, size);
-		if (size > 0) {
-			acl = posix_acl_from_xattr(&init_user_ns, value, size);
-			if (IS_ERR(acl))
-				goto err_out;
-		}
-	} else if (size == -ENODATA || size == 0 ||
-		   size == -ENOSYS || size == -EOPNOTSUPP) {
-		acl = NULL;
-	} else
-		acl = ERR_PTR(-EIO);
-
-err_out:
+	if (size < 0)
+		return ERR_PTR(size);
+	if (size == 0)
+		return ERR_PTR(-ENODATA);
+
+	value = kzalloc(size, GFP_NOFS);
+	if (!value)
+		return ERR_PTR(-ENOMEM);
+
+	size = v9fs_fid_xattr_get(fid, name, value, size);
+	if (size < 0)
+		acl = ERR_PTR(size);
+	else if (size == 0)
+		acl = ERR_PTR(-ENODATA);
+	else
+		acl = posix_acl_from_xattr(&init_user_ns, value, size);
 	kfree(value);
 	return acl;
 }
 
+static struct posix_acl *v9fs_acl_get(struct dentry *dentry, const char *name)
+{
+	struct p9_fid *fid;
+	struct posix_acl *acl = NULL;
+
+	fid = v9fs_fid_lookup(dentry);
+	if (IS_ERR(fid))
+		return ERR_CAST(fid);
+
+	acl = v9fs_fid_get_acl(fid, name);
+	p9_fid_put(fid);
+	return acl;
+}
+
+static struct posix_acl *__v9fs_get_acl(struct p9_fid *fid, const char *name)
+{
+	int retval;
+	struct posix_acl *acl = NULL;
+
+	acl = v9fs_fid_get_acl(fid, name);
+	if (!IS_ERR(acl))
+		return acl;
+
+	retval = PTR_ERR(acl);
+	if (retval == -ENODATA || retval == -ENOSYS || retval == -EOPNOTSUPP)
+		return NULL;
+
+	/* map everything else to -EIO */
+	return ERR_PTR(-EIO);
+}
+
 int v9fs_get_acl(struct inode *inode, struct p9_fid *fid)
 {
 	int retval = 0;
@@ -89,7 +119,7 @@ static struct posix_acl *v9fs_get_cached_acl(struct inode *inode, int type)
 	return acl;
 }
 
-struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, bool rcu)
+struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type, bool rcu)
 {
 	struct v9fs_session_info *v9ses;
 
@@ -109,6 +139,18 @@ struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type, bool rcu)
 
 }
 
+struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
+				   struct dentry *dentry, int type)
+{
+	struct v9fs_session_info *v9ses;
+
+	v9ses = v9fs_dentry2v9ses(dentry);
+	/* We allow set/get/list of acl when access=client is not specified. */
+	if ((v9ses->flags & V9FS_ACCESS_MASK) != V9FS_ACCESS_CLIENT)
+		return v9fs_acl_get(dentry, posix_acl_xattr_name(type));
+	return v9fs_get_cached_acl(d_inode(dentry), type);
+}
+
 static int v9fs_set_acl(struct p9_fid *fid, int type, struct posix_acl *acl)
 {
 	int retval;
diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index ce5175d463dd..359dab4da900 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -8,8 +8,10 @@
 
 #ifdef CONFIG_9P_FS_POSIX_ACL
 int v9fs_get_acl(struct inode *inode, struct p9_fid *fid);
-struct posix_acl *v9fs_iop_get_acl(struct inode *inode, int type,
+struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type,
 				   bool rcu);
+struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
+					  struct dentry *dentry, int type);
 int v9fs_acl_chmod(struct inode *inode, struct p9_fid *fid);
 int v9fs_set_create_acl(struct inode *inode, struct p9_fid *fid,
 			struct posix_acl *dacl, struct posix_acl *acl);
@@ -17,6 +19,7 @@ int v9fs_acl_mode(struct inode *dir, umode_t *modep,
 		  struct posix_acl **dpacl, struct posix_acl **pacl);
 void v9fs_put_acl(struct posix_acl *dacl, struct posix_acl *acl);
 #else
+#define v9fs_iop_get_inode_acl	NULL
 #define v9fs_iop_get_acl NULL
 static inline int v9fs_get_acl(struct inode *inode, struct p9_fid *fid)
 {
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0d1a7f2c579d..a4211fcb9168 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -983,14 +983,16 @@ const struct inode_operations v9fs_dir_inode_operations_dotl = {
 	.getattr = v9fs_vfs_getattr_dotl,
 	.setattr = v9fs_vfs_setattr_dotl,
 	.listxattr = v9fs_listxattr,
-	.get_inode_acl = v9fs_iop_get_acl,
+	.get_inode_acl = v9fs_iop_get_inode_acl,
+	.get_acl = v9fs_iop_get_acl,
 };
 
 const struct inode_operations v9fs_file_inode_operations_dotl = {
 	.getattr = v9fs_vfs_getattr_dotl,
 	.setattr = v9fs_vfs_setattr_dotl,
 	.listxattr = v9fs_listxattr,
-	.get_inode_acl = v9fs_iop_get_acl,
+	.get_inode_acl = v9fs_iop_get_inode_acl,
+	.get_acl = v9fs_iop_get_acl,
 };
 
 const struct inode_operations v9fs_symlink_inode_operations_dotl = {
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 8163dd48c430..ebfa11ac7046 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -60,6 +60,17 @@ int posix_acl_to_xattr(struct user_namespace *user_ns,
 struct posix_acl *vfs_set_acl_prepare(struct user_namespace *mnt_userns,
 				      struct user_namespace *fs_userns,
 				      const void *value, size_t size);
+static inline const char *posix_acl_xattr_name(int type)
+{
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		return XATTR_NAME_POSIX_ACL_ACCESS;
+	case ACL_TYPE_DEFAULT:
+		return XATTR_NAME_POSIX_ACL_DEFAULT;
+	}
+
+	return "";
+}
 
 extern const struct xattr_handler posix_acl_access_xattr_handler;
 extern const struct xattr_handler posix_acl_default_xattr_handler;
-- 
2.34.1

