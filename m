Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AC5EF902
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiI2PeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiI2Pci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BA15564D;
        Thu, 29 Sep 2022 08:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EC51B824F8;
        Thu, 29 Sep 2022 15:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55844C433C1;
        Thu, 29 Sep 2022 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664465509;
        bh=FKw385C5yH1om9Vc9Pe5irQuBZjCqwkBowirbqj/DvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF0JQg/PWEOuVooCOqllw5EcIfTT51+dqlHWzkUDiKx8N50eJ2O1OitUYvVeUsOjw
         0nmHdQRtowIe7NJLVQmm4fEiv/mgecC7DRo34DSvh2QzWI/YzItwwMkBcCunHg/MNi
         6NfAenWfDm3bamVs+3xd6ZjJS/YFwtInomR/CauC7KVrk3gPwfPTQNRQmIv3IUEADy
         c/CyuB2OPZK8jq5VHEdR1v2REdWaADhbbtk5IyktCbJTObxEgEqi20W1CgjoMqEHQy
         mLLzyb6T780g1yLe6UgNDb9k9I7TXBgeldD0KXOCS+WGQhRhVpAugSSpTjU2Y9zBIr
         m/WV6eyDW7WIw==
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
Subject: [PATCH v4 21/30] ovl: implement get acl method
Date:   Thu, 29 Sep 2022 17:30:31 +0200
Message-Id: <20220929153041.500115-22-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929153041.500115-1-brauner@kernel.org>
References: <20220929153041.500115-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6985; i=brauner@kernel.org; h=from:subject; bh=FKw385C5yH1om9Vc9Pe5irQuBZjCqwkBowirbqj/DvI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSb7hKda3Xb60DBLaaQ853XWG0n6Ojvmq/oJObx5CvvmoAD B5STOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayopbhn+6kVoOZ79/uMPt37dkkMX dL5Q9MGgc18hr4mz9IRzqe5GVk+GWz20U7/G6Kv153g+LD4O+c7Ne1GYNZOoX2cd+4vvcKEwA=
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

 fs/overlayfs/dir.c       |  3 +-
 fs/overlayfs/inode.c     | 61 ++++++++++++++++++++++++++++++++++++----
 fs/overlayfs/overlayfs.h | 10 +++++--
 3 files changed, 65 insertions(+), 9 deletions(-)

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
index 9bc4582e956b..c25b4fd530db 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,6 +14,8 @@
 #include <linux/fileattr.h>
 #include <linux/security.h>
 #include <linux/namei.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include "overlayfs.h"
 
 
@@ -460,9 +462,9 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
  * of the POSIX ACLs retrieved from the lower layer to this function to not
  * alter the POSIX ACLs for the underlying filesystem.
  */
-static void ovl_idmap_posix_acl(struct inode *realinode,
-				struct user_namespace *mnt_userns,
-				struct posix_acl *acl)
+void ovl_idmap_posix_acl(struct inode *realinode,
+			 struct user_namespace *mnt_userns,
+			 struct posix_acl *acl)
 {
 	struct user_namespace *fs_userns = i_user_ns(realinode);
 
@@ -495,7 +497,7 @@ static void ovl_idmap_posix_acl(struct inode *realinode,
  *
  * This is obviously only relevant when idmapped layers are used.
  */
-struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
+struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu)
 {
 	struct inode *realinode = ovl_inode_real(inode);
 	struct posix_acl *acl, *clone;
@@ -547,6 +549,51 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 	posix_acl_release(acl);
 	return clone;
 }
+
+static struct posix_acl *ovl_get_acl_path(const struct path *path,
+					  const char *acl_name)
+{
+	struct posix_acl *real_acl, *clone;
+	struct user_namespace *mnt_userns;
+
+	mnt_userns = mnt_user_ns(path->mnt);
+
+	real_acl = vfs_get_acl(mnt_userns, path->dentry, acl_name);
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
+	if (clone)
+		ovl_idmap_posix_acl(d_inode(path->dentry), mnt_userns, clone);
+	else
+		clone = ERR_PTR(-ENOMEM);
+	/* Drop reference to original posix acls. */
+	posix_acl_release(real_acl);
+	return clone;
+}
+
+struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, int type)
+{
+	struct posix_acl *acl = NULL;
+	const struct cred *old_cred;
+	struct path realpath;
+
+	ovl_path_real(dentry, &realpath);
+	old_cred = ovl_override_creds(dentry->d_sb);
+	acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type));
+	revert_creds(old_cred);
+	return acl;
+}
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
@@ -721,7 +768,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_inode_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_inode_acl,
+	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -741,7 +789,8 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.permission	= ovl_permission,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
-	.get_inode_acl	= ovl_get_acl,
+	.get_inode_acl	= ovl_get_inode_acl,
+	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ee93c825b06b..68a3030332e9 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -592,9 +592,15 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 
 #ifdef CONFIG_FS_POSIX_ACL
-struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu);
+struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, int type);
+void ovl_idmap_posix_acl(struct inode *realinode,
+			 struct user_namespace *mnt_userns,
+			 struct posix_acl *acl);
 #else
-#define ovl_get_acl	NULL
+#define ovl_get_inode_acl	NULL
+#define ovl_get_acl		NULL
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
-- 
2.34.1

