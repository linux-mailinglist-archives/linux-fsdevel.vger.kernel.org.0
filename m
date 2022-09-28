Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668975EE185
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiI1QPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiI1QNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4BB14FB;
        Wed, 28 Sep 2022 09:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568E961F2C;
        Wed, 28 Sep 2022 16:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFFEC43470;
        Wed, 28 Sep 2022 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381626;
        bh=cIdJn3dfHGCjWIy2DMwJh2jl99+QFNIufqGe9kRZdHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYcA+EcdYxCpID56+aJIEqoNE0VstSZuMAH50b+pnnbGUhclfvVzhYn1WyLHrhg3b
         CymjIX0ZqYAQkixS3vcgFld41ZwN0pI766mRs+AAGN3VHaYG9zRc7CVerFBu33oigT
         U/Hy+utIJHcixl1zDv+DmQNHECGFA/zQJ6p72tcqwCCtwIDXQJuXBKdhCqpUhd/wuq
         vpyXT/gD8TyX/bVvY8nlbJOp/rCmW5AdFCkdHN3Z0/QL78PrHX/QlDRqA8xqVyzzGW
         qAhYAjYqoR4WILJIrSJmixSLH8qWuIwFLenQvenU8Q3He8clrVzlUDr1b3RilTvhQb
         fHRDq5Zmz5xcg==
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
Subject: [PATCH v3 22/29] ovl: use posix acl api
Date:   Wed, 28 Sep 2022 18:08:36 +0200
Message-Id: <20220928160843.382601-23-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928160843.382601-1-brauner@kernel.org>
References: <20220928160843.382601-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6920; i=brauner@kernel.org; h=from:subject; bh=cIdJn3dfHGCjWIy2DMwJh2jl99+QFNIufqGe9kRZdHI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSbFNa9Xrz5G4vUvRih6y+PrRaXaLQ83nmz4/ENUxGGifd3 rHUN7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIbwjDP02HhS1srg4Wk+bX3hLq2n y7RfmxzYrOiBo2Je4g+bXlmgz/6z5e3LqCI2TFm8yr16/9ZO+21z/2QVyh3WfVfcW9z+tf8gEA
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

Now that posix acls have a proper api us it to copy them.

All filesystems that can serve as lower or upper layers for overlayfs
have gained support for the new posix acl api in previous patches.
So switch all internal overlayfs codepaths for copying posix acls to the
new posix acl api.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Miklos Szeredi <miklos@szeredi.hu>:
    - Move ovl_copy_acl() from util.c to copy_up.c
    - Unconditionally clone posix acls
    
    /* v3 */
    unchanged

 fs/overlayfs/copy_up.c   | 38 ++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c       | 20 ++------------------
 fs/overlayfs/inode.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  7 +++++++
 fs/overlayfs/super.c     |  6 ++----
 fs/xattr.c               |  6 ------
 include/linux/xattr.h    |  6 ++++++
 7 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index fdde6c56cc3d..f2e36c841d6f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -44,6 +44,35 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
+static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
+			struct dentry *dentry, const char *acl_name)
+{
+	int err;
+	struct posix_acl *clone, *real_acl = NULL;
+
+	real_acl = ovl_get_acl_path(path, acl_name);
+	if (!real_acl)
+		return 0;
+
+	if (IS_ERR(real_acl)) {
+		err = PTR_ERR(real_acl);
+		if (err == -ENODATA || err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	clone = posix_acl_clone(real_acl, GFP_KERNEL);
+	posix_acl_release(real_acl); /* release original acl */
+	if (!clone)
+		return -ENOMEM;
+
+	err = ovl_do_set_acl(ofs, dentry, acl_name, clone);
+
+	/* release cloned acl */
+	posix_acl_release(clone);
+	return err;
+}
+
 int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -93,6 +122,15 @@ int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *
 			error = 0;
 			continue; /* Discard */
 		}
+
+		if (is_posix_acl_xattr(name)) {
+			error = ovl_copy_acl(OVL_FS(sb), oldpath, new, name);
+			if (!error)
+				continue;
+			/* POSIX ACLs must be copied. */
+			break;
+		}
+
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
 		if (size == -ERANGE)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0e817ebce92c..cbb569d5d234 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -435,28 +435,12 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 }
 
 static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
-			     const char *name, const struct posix_acl *acl)
+			     const char *acl_name, struct posix_acl *acl)
 {
-	void *buffer;
-	size_t size;
-	int err;
-
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !acl)
 		return 0;
 
-	size = posix_acl_xattr_size(acl->a_count);
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
-	if (err < 0)
-		goto out_free;
-
-	err = ovl_do_setxattr(ofs, upperdentry, name, buffer, size, XATTR_CREATE);
-out_free:
-	kfree(buffer);
-	return err;
+	return ovl_do_set_acl(ofs, upperdentry, acl_name, acl);
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index fc4c2d821343..12b34b01ed54 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -550,8 +550,8 @@ struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu)
 	return clone;
 }
 
-static struct posix_acl *ovl_get_acl_path(const struct path *path,
-					  const char *acl_name)
+struct posix_acl *ovl_get_acl_path(const struct path *path,
+				   const char *acl_name)
 {
 	struct posix_acl *real_acl, *clone;
 	struct user_namespace *mnt_userns;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b2645baeba2f..f3b6d6625604 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -614,10 +614,17 @@ int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 void ovl_idmap_posix_acl(struct inode *realinode,
 			 struct user_namespace *mnt_userns,
 			 struct posix_acl *acl);
+struct posix_acl *ovl_get_acl_path(const struct path *path,
+				   const char *acl_name);
 #else
 #define ovl_get_inode_acl	NULL
 #define ovl_get_acl		NULL
 #define ovl_set_acl		NULL
+static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
+						 const char *acl_name)
+{
+	return NULL;
+}
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5da771b218d1..8a13319db1d3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -812,13 +812,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = ovl_do_removexattr(ofs, work,
-					 XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = ovl_do_removexattr(ofs, work,
-					 XATTR_NAME_POSIX_ACL_ACCESS);
+		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index e16d7bde4935..0b9a84921c4d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -281,12 +281,6 @@ __vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
-static inline bool is_posix_acl_xattr(const char *name)
-{
-	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
-}
-
 int
 vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 8267e547e631..d44d59177026 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -22,6 +22,12 @@
 struct inode;
 struct dentry;
 
+static inline bool is_posix_acl_xattr(const char *name)
+{
+	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
+}
+
 /*
  * struct xattr_handler: When @name is set, match attributes with exactly that
  * name.  When @prefix is set instead, match attributes with that prefix and
-- 
2.34.1

