Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853566962A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjAMLxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjAMLwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49305392
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBAB661697
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F2EC433EF;
        Fri, 13 Jan 2023 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610600;
        bh=QmJfmWG3+7PU2hyJWWNBTMeKfwYLDwZJmwlxeSQ17jE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PiH6IY7dUbYF9mCzNxhSD3Kw4fXelFwrLI7DJDwlt57rMxW9Gvu1U5AiCrIcpT4+7
         YNWauK8UawaeTazPvV6DlSHPZH4cjOSHP72MlsZQ+OebIdkMuSZRSkLHTieal0c8U3
         rNk35bE2myBB6HFm5uAD17IpvSzXvq5DD76czxOyrAMl5jD5p39NLlDl9SAGOT7NRx
         soNDeBF8FGjGvqJOztnefrz+00HMzUVL5/lqSFiJP6vIS59kr1wQFUfan5yq2RtvZ+
         10zyZwOIQoJJlu30rQykJjvPKwiKeqGJZAAwh20s/hS7vSTZTNE/rhTOqeZL0/B9O2
         cASu1NloV6obw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:19 +0100
Subject: [PATCH 11/25] fs: port ->get_acl() to pass mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-11-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=13025; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QmJfmWG3+7PU2hyJWWNBTMeKfwYLDwZJmwlxeSQ17jE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2SlLx7iYn9d122yPftbbvqCvOjDnS+Lepely+rdsU9
 bs6djlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8uc7wh6PxweLD/z5w7LZmTz396s
 S1CnMxlSk3ohXvvVMJfv73RygjQ+fj+db7l10RE6i+ueGYV9vDv8Xb/tgd4Ow6tEVw66Rz03kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to struct mnt_idmap.

Last cycle we merged the necessary infrastructure in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
This is just the conversion to struct mnt_idmap.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to
conflate namespaces that are relevant on the filesystem with namespaces
that are relevent on the mount level. Especially for non-vfs developers
without detailed knowledge in this area this can be a potential source for
bugs.

Once the conversion to struct mnt_idmap is done all helpers down to the
really low-level helpers will take a struct mnt_idmap argument instead of
two namespace arguments. This way it becomes impossible to conflate the two
eliminating the possibility of any bugs. All of the vfs and all filesystems
only operate on struct mnt_idmap.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/9p/acl.c                           |  2 +-
 fs/9p/acl.h                           |  2 +-
 fs/cifs/cifsacl.c                     |  2 +-
 fs/cifs/cifsproto.h                   |  2 +-
 fs/ecryptfs/inode.c                   |  4 ++--
 fs/overlayfs/inode.c                  | 10 ++++++----
 fs/overlayfs/overlayfs.h              |  8 ++++----
 fs/posix_acl.c                        | 15 ++++++++-------
 include/linux/fs.h                    |  2 +-
 include/linux/posix_acl.h             |  4 ++--
 12 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 429b8e4a6284..d42d7b8de2f5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -84,7 +84,7 @@ prototypes::
 	int (*fileattr_set)(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
-	struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
+	struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 
 locking rules:
 	all may block
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 3fcadfcf4e3a..056e446c70e0 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -443,7 +443,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
-		struct posix_acl * (*get_acl)(struct user_namespace *, struct dentry *, int);
+		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	        int (*set_acl)(struct user_namespace *, struct dentry *, struct posix_acl *, int);
 		int (*fileattr_set)(struct user_namespace *mnt_userns,
 				    struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 9848a245fa6f..cfd4545f2d02 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -139,7 +139,7 @@ struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type, bool rcu
 
 }
 
-struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *v9fs_iop_get_acl(struct mnt_idmap *idmap,
 				   struct dentry *dentry, int type)
 {
 	struct v9fs_session_info *v9ses;
diff --git a/fs/9p/acl.h b/fs/9p/acl.h
index 4c60a2bce5de..e0e58967d916 100644
--- a/fs/9p/acl.h
+++ b/fs/9p/acl.h
@@ -10,7 +10,7 @@
 int v9fs_get_acl(struct inode *inode, struct p9_fid *fid);
 struct posix_acl *v9fs_iop_get_inode_acl(struct inode *inode, int type,
 				   bool rcu);
-struct posix_acl *v9fs_iop_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *v9fs_iop_get_acl(struct mnt_idmap *idmap,
 					  struct dentry *dentry, int type);
 int v9fs_iop_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		     struct posix_acl *acl, int type);
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bbf58c2439da..1fae9b60e48f 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1674,7 +1674,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	return rc;
 }
 
-struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
 			       struct dentry *dentry, int type)
 {
 #if defined(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) && defined(CONFIG_CIFS_POSIX)
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 1207b39686fb..aeae6544cdd8 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -225,7 +225,7 @@ extern struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *, struct inode *,
 				      const char *, u32 *, u32);
 extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
 				const struct cifs_fid *, u32 *, u32);
-extern struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
+extern struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
 				      struct dentry *dentry, int type);
 extern int cifs_set_acl(struct user_namespace *mnt_userns,
 			struct dentry *dentry, struct posix_acl *acl, int type);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index cf85901d7a5d..8487ac0cc239 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1122,10 +1122,10 @@ static int ecryptfs_fileattr_set(struct user_namespace *mnt_userns,
 	return rc;
 }
 
-static struct posix_acl *ecryptfs_get_acl(struct user_namespace *mnt_userns,
+static struct posix_acl *ecryptfs_get_acl(struct mnt_idmap *idmap,
 					  struct dentry *dentry, int type)
 {
-	return vfs_get_acl(mnt_userns, ecryptfs_dentry_to_lower(dentry),
+	return vfs_get_acl(idmap, ecryptfs_dentry_to_lower(dentry),
 			   posix_acl_xattr_name(type));
 }
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ad33253ed7e9..3ea4fc54f469 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -515,14 +515,16 @@ struct posix_acl *ovl_get_acl_path(const struct path *path,
 {
 	struct posix_acl *real_acl, *clone;
 	struct user_namespace *mnt_userns;
+	struct mnt_idmap *idmap;
 	struct inode *realinode = d_inode(path->dentry);
 
-	mnt_userns = mnt_user_ns(path->mnt);
+	idmap = mnt_idmap(path->mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 
 	if (noperm)
 		real_acl = get_inode_acl(realinode, posix_acl_type(acl_name));
 	else
-		real_acl = vfs_get_acl(mnt_userns, path->dentry, acl_name);
+		real_acl = vfs_get_acl(idmap, path->dentry, acl_name);
 	if (IS_ERR_OR_NULL(real_acl))
 		return real_acl;
 
@@ -555,7 +557,7 @@ struct posix_acl *ovl_get_acl_path(const struct path *path,
  *
  * This is obviously only relevant when idmapped layers are used.
  */
-struct posix_acl *do_ovl_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 				 struct inode *inode, int type,
 				 bool rcu, bool noperm)
 {
@@ -618,7 +620,7 @@ static int ovl_set_or_remove_acl(struct dentry *dentry, struct inode *inode,
 
 		ovl_path_lower(dentry, &realpath);
 		old_cred = ovl_override_creds(dentry->d_sb);
-		real_acl = vfs_get_acl(mnt_user_ns(realpath.mnt), realdentry,
+		real_acl = vfs_get_acl(mnt_idmap(realpath.mnt), realdentry,
 				       acl_name);
 		revert_creds(old_cred);
 		if (IS_ERR(real_acl)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b6e17f631b53..1e8b0be85e4b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -610,18 +610,18 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 
 #ifdef CONFIG_FS_POSIX_ACL
-struct posix_acl *do_ovl_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 				 struct inode *inode, int type,
 				 bool rcu, bool noperm);
 static inline struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type,
 						  bool rcu)
 {
-	return do_ovl_get_acl(&init_user_ns, inode, type, rcu, true);
+	return do_ovl_get_acl(&nop_mnt_idmap, inode, type, rcu, true);
 }
-static inline struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
+static inline struct posix_acl *ovl_get_acl(struct mnt_idmap *idmap,
 					    struct dentry *dentry, int type)
 {
-	return do_ovl_get_acl(mnt_userns, d_inode(dentry), type, false, false);
+	return do_ovl_get_acl(idmap, d_inode(dentry), type, false, false);
 }
 int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct posix_acl *acl, int type);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..17e141a94671 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -111,7 +111,7 @@ void forget_all_cached_acls(struct inode *inode)
 }
 EXPORT_SYMBOL(forget_all_cached_acls);
 
-static struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
+static struct posix_acl *__get_acl(struct mnt_idmap *idmap,
 				   struct dentry *dentry, struct inode *inode,
 				   int type)
 {
@@ -154,7 +154,7 @@ static struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
 	 * we'll just create the negative cache entry.
 	 */
 	if (dentry && inode->i_op->get_acl) {
-		acl = inode->i_op->get_acl(mnt_userns, dentry, type);
+		acl = inode->i_op->get_acl(idmap, dentry, type);
 	} else if (inode->i_op->get_inode_acl) {
 		acl = inode->i_op->get_inode_acl(inode, type, false);
 	} else {
@@ -181,7 +181,7 @@ static struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
 
 struct posix_acl *get_inode_acl(struct inode *inode, int type)
 {
-	return __get_acl(&init_user_ns, NULL, inode, type);
+	return __get_acl(&nop_mnt_idmap, NULL, inode, type);
 }
 EXPORT_SYMBOL(get_inode_acl);
 
@@ -1121,7 +1121,7 @@ EXPORT_SYMBOL_GPL(vfs_set_acl);
 
 /**
  * vfs_get_acl - get posix acls
- * @mnt_userns: user namespace of the mount
+ * @idmap: idmap of the mount
  * @dentry: the dentry based on which to retrieve the posix acls
  * @acl_name: the name of the posix acl
  *
@@ -1130,9 +1130,10 @@ EXPORT_SYMBOL_GPL(vfs_set_acl);
  *
  * Return: On success POSIX ACLs in VFS format, on error negative errno.
  */
-struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	struct posix_acl *acl;
 	int acl_type, error;
@@ -1154,7 +1155,7 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 	if (S_ISLNK(inode->i_mode))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	acl = __get_acl(mnt_userns, dentry, inode, acl_type);
+	acl = __get_acl(idmap, dentry, inode, acl_type);
 	if (IS_ERR(acl))
 		return acl;
 	if (!acl)
@@ -1256,7 +1257,7 @@ ssize_t do_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	ssize_t error;
 	struct posix_acl *acl;
 
-	acl = vfs_get_acl(mnt_idmap_owner(idmap), dentry, acl_name);
+	acl = vfs_get_acl(idmap, dentry, acl_name);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4855fd071bf8..31a714377ba2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2164,7 +2164,7 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
-	struct posix_acl *(*get_acl)(struct user_namespace *, struct dentry *,
+	struct posix_acl *(*get_acl)(struct mnt_idmap *, struct dentry *,
 				     int);
 	int (*set_acl)(struct user_namespace *, struct dentry *,
 		       struct posix_acl *, int);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index ee608d22ecb9..042ef62f9276 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -102,7 +102,7 @@ static inline void cache_no_acl(struct inode *inode)
 
 int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl);
-struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name);
 int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   const char *acl_name);
@@ -141,7 +141,7 @@ static inline int vfs_set_acl(struct user_namespace *mnt_userns,
 	return -EOPNOTSUPP;
 }
 
-static inline struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+static inline struct posix_acl *vfs_get_acl(struct mnt_idmap *idmap,
 					    struct dentry *dentry,
 					    const char *acl_name)
 {

-- 
2.34.1

