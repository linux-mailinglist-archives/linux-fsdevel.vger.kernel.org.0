Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA329602AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJRMA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJRL7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E33BE2CC;
        Tue, 18 Oct 2022 04:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B886153D;
        Tue, 18 Oct 2022 11:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E02C433B5;
        Tue, 18 Oct 2022 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094293;
        bh=sv7Gy9Nh8JlpOkZbUnA9a4nqK2IF+zKefoWNNUPNVns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLrT1vmZc2QdV8GPRpWg7mtgoVG78/PQ5ghOw5KZtYq0Gu2d2rMP9OG53B2OjW2T1
         zCjKsRfSXRB0pbjhMQ+4XDzBPuykt5QT+Z4qQ5WdqmKKClnLT5UzmzL9Wx2S/r7oRy
         dg+8vvseYi7lG4qrbeDsztFK/+HALoF4wOBSKqhjpgc679MK9TpT1msn8COySW/fYq
         uev1Ewkx7DkVv2QaX7Y2bfgMfmXebfYwoWWQuz3fxGm+xo73hrLs1UYZG4eEcE6fLG
         DCYko9fz7y8owrr/o7tM4m+eGXUsJogFZEZXh2bbC0OW8/pFdqjYHkBtu90NugcNG1
         qp7PgZHF1R0Qg==
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
Subject: [PATCH v5 21/30] ovl: implement get acl method
Date:   Tue, 18 Oct 2022 13:56:51 +0200
Message-Id: <20221018115700.166010-22-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9851; i=brauner@kernel.org; h=from:subject; bh=sv7Gy9Nh8JlpOkZbUnA9a4nqK2IF+zKefoWNNUPNVns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdHQ0F+1cVO4YVmGh+W/i90a9Q0c+3/HPXsaJlPGZLwg zoKlo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJT5BkZpl72tbjyc3fPCcGGKe5b5l ery0ZuqN5f8W7NFP+Ff5Zdi2BkWFaeee9FiLhX0Fvvpqu289/dXtL1TebHm1XPj+8vTTj/hwMA
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

Now that we have added get and set acl inode operations that allow easy
access to the dentry we give overlayfs it's own get and set acl inode
operations.

Since overlayfs is a stacking filesystem it will use the newly added
posix acl api when retrieving posix acls from the relevant layer.

Since overlayfs can also be mounted on top of idmapped layers. If
idmapped layers are used overlayfs must take the layer's idmapping into
account after it retrieved the posix acls from the relevant layer.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Miklos Szeredi <mszeredi@redhat.com>
    - Use IS_ERR_OR_NULL() macro.
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged
    
    /* v5 */
    Miklos Szeredi <miklos@szeredi.hu>:
    - Consolidate get acl methods into one.
    - Add comment why we temporarily implement two instead of one because we are
      skipping permission checks on accident for a long time.

 fs/overlayfs/dir.c       |   3 +-
 fs/overlayfs/inode.c     | 109 ++++++++++++++++++++++++++++-----------
 fs/overlayfs/overlayfs.h |  17 +++++-
 3 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 7bece7010c00..eb49d5d7b56f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1311,7 +1311,8 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_inode_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_inode_acl,
+	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6eefd8b7868e..74edbd1c1159 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,6 +14,8 @@
 #include <linux/fileattr.h>
 #include <linux/security.h>
 #include <linux/namei.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include "overlayfs.h"
 
 
@@ -460,7 +462,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
  * of the POSIX ACLs retrieved from the lower layer to this function to not
  * alter the POSIX ACLs for the underlying filesystem.
  */
-static void ovl_idmap_posix_acl(struct inode *realinode,
+static void ovl_idmap_posix_acl(const struct inode *realinode,
 				struct user_namespace *mnt_userns,
 				struct posix_acl *acl)
 {
@@ -484,6 +486,64 @@ static void ovl_idmap_posix_acl(struct inode *realinode,
 	}
 }
 
+/*
+ * The @noperm argument is used to skip permission checking and is a temporary
+ * measure. Quoting Miklos from an earlier discussion:
+ *
+ * > So there are two paths to getting an acl:
+ * > 1) permission checking and 2) retrieving the value via getxattr(2).
+ * > This is a similar situation as reading a symlink vs. following it.
+ * > When following a symlink overlayfs always reads the link on the
+ * > underlying fs just as if it was a readlink(2) call, calling
+ * > security_inode_readlink() instead of security_inode_follow_link().
+ * > This is logical: we are reading the link from the underlying storage,
+ * > and following it on overlayfs.
+ * >
+ * > Applying the same logic to acl: we do need to call the
+ * > security_inode_getxattr() on the underlying fs, even if just want to
+ * > check permissions on overlay. This is currently not done, which is an
+ * > inconsistency.
+ * >
+ * > Maybe adding the check to ovl_get_acl() is the right way to go, but
+ * > I'm a little afraid of a performance regression.  Will look into that.
+ *
+ * Until we have made a decision allow this helper to take the @noperm
+ * argument. We should hopefully be able to remove it soon.
+ */
+static struct posix_acl *ovl_get_acl_path(const struct path *path,
+					  const char *acl_name, bool noperm)
+{
+	struct posix_acl *real_acl, *clone;
+	struct user_namespace *mnt_userns;
+	struct inode *realinode = d_inode(path->dentry);
+
+	mnt_userns = mnt_user_ns(path->mnt);
+
+	if (noperm)
+		real_acl = get_inode_acl(realinode, posix_acl_type(acl_name));
+	else
+		real_acl = vfs_get_acl(mnt_userns, path->dentry, acl_name);
+	if (IS_ERR_OR_NULL(real_acl))
+		return real_acl;
+
+	if (!is_idmapped_mnt(path->mnt))
+		return real_acl;
+
+	/*
+        * We cannot alter the ACLs returned from the relevant layer as that
+        * would alter the cached values filesystem wide for the lower
+        * filesystem. Instead we can clone the ACLs and then apply the
+        * relevant idmapping of the layer.
+        */
+	clone = posix_acl_clone(real_acl, GFP_KERNEL);
+	posix_acl_release(real_acl); /* release original acl */
+	if (!clone)
+		return ERR_PTR(-ENOMEM);
+
+	ovl_idmap_posix_acl(realinode, mnt_userns, clone);
+	return clone;
+}
+
 /*
  * When the relevant layer is an idmapped mount we need to take the idmapping
  * of the layer into account and translate any ACL_{GROUP,USER} values
@@ -495,10 +555,12 @@ static void ovl_idmap_posix_acl(struct inode *realinode,
  *
  * This is obviously only relevant when idmapped layers are used.
  */
-struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
+struct posix_acl *do_ovl_get_acl(struct user_namespace *mnt_userns,
+				 struct inode *inode, int type,
+				 bool rcu, bool noperm)
 {
 	struct inode *realinode = ovl_inode_real(inode);
-	struct posix_acl *acl, *clone;
+	struct posix_acl *acl;
 	struct path realpath;
 
 	if (!IS_POSIXACL(realinode))
@@ -512,40 +574,23 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 	}
 
 	if (rcu) {
+		/*
+		 * If the layer is idmapped drop out of RCU path walk
+		 * so we can clone the ACLs.
+		 */
+		if (is_idmapped_mnt(realpath.mnt))
+			return ERR_PTR(-ECHILD);
+
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
 		const struct cred *old_cred;
 
 		old_cred = ovl_override_creds(inode->i_sb);
-		acl = get_inode_acl(realinode, type);
+		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
 		revert_creds(old_cred);
 	}
-	/*
-	 * If there are no POSIX ACLs, or we encountered an error,
-	 * or the layer isn't idmapped we don't need to do anything.
-	 */
-	if (!is_idmapped_mnt(realpath.mnt) || IS_ERR_OR_NULL(acl))
-		return acl;
-
-	/*
-	 * We only get here if the layer is idmapped. So drop out of RCU path
-	 * walk so we can clone the ACLs. There's no need to release the ACLs
-	 * since get_cached_acl_rcu() doesn't take a reference on the ACLs.
-	 */
-	if (rcu)
-		return ERR_PTR(-ECHILD);
 
-	clone = posix_acl_clone(acl, GFP_KERNEL);
-	if (!clone)
-		clone = ERR_PTR(-ENOMEM);
-	else
-		ovl_idmap_posix_acl(realinode, mnt_user_ns(realpath.mnt), clone);
-	/*
-	 * Since we're not in RCU path walk we always need to release the
-	 * original ACLs.
-	 */
-	posix_acl_release(acl);
-	return clone;
+	return acl;
 }
 #endif
 
@@ -721,7 +766,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_inode_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_inode_acl,
+	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -741,7 +787,8 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_inode_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_inode_acl,
+	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index eee8f08d32b6..d334977030c8 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -594,9 +594,22 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 
 #ifdef CONFIG_FS_POSIX_ACL
-struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *do_ovl_get_acl(struct user_namespace *mnt_userns,
+				 struct inode *inode, int type,
+				 bool rcu, bool noperm);
+static inline struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type,
+						  bool rcu)
+{
+	return do_ovl_get_acl(&init_user_ns, inode, type, rcu, true);
+}
+static inline struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
+					    struct dentry *dentry, int type)
+{
+	return do_ovl_get_acl(mnt_userns, d_inode(dentry), type, false, false);
+}
 #else
-#define ovl_get_acl	NULL
+#define ovl_get_inode_acl	NULL
+#define ovl_get_acl		NULL
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
-- 
2.34.1

