Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6F669607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbjAMLxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbjAMLwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1489313D00
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88AE661697
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4457C433EF;
        Fri, 13 Jan 2023 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610607;
        bh=1FosQIRdprMhu2o4zmGEPAJsS/KB1+p0kI6tFJm/ra8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hb0zpwExU21i7iD4KVrRodgZ6jhv78aRhPs7QSGsGebxVsqakEA5/znMUjnpRE+Uq
         Bcq7CrU0viU4ZwqLKQLVON7NisJelU1A3Du/Toj9sMY/09DcZmGrbVSLwY39XfI6rC
         tVIwHH+7jl6uYzeaCVLQEmo8D+FQzhfJpaP9quKpNUcet0Rvi+r5PKv0Ugj2oJ2Djs
         lzP2vffXUYyEkSltH6PpAKQyeyVnB2Yj/bPcu94SnkE2IEcGbAp1+itpysPeGQ88Dd
         HdgQHRUWEWaY3EWToDYpsQ9uIZSQdIKCaTX7Dwihp8GAcrVdedCSESA6yrIHvSh0UV
         ciyOHY9LIQY4Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:23 +0100
Subject: [PATCH 15/25] fs: port xattr to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-15-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=88967; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1FosQIRdprMhu2o4zmGEPAJsS/KB1+p0kI6tFJm/ra8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA1eP3mXl02+vu/6Vi7rZlVuPsvqYwWnfwp17E/WbfBR
 ebKxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL8TxkZ7qcv/yzgv2KRd46wv1zQpW
 8vHT/8SGSoPpI8RUw6qnexFsN/v7b6uqPBzpXG87/tuS1glR5kf2D+4ecXk15/u5artqiVCQA=
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
 Documentation/filesystems/locking.rst        |  2 +-
 fs/9p/xattr.c                                |  2 +-
 fs/afs/xattr.c                               |  4 +-
 fs/attr.c                                    |  4 +-
 fs/btrfs/xattr.c                             |  4 +-
 fs/ceph/xattr.c                              |  2 +-
 fs/cifs/xattr.c                              |  2 +-
 fs/ecryptfs/crypto.c                         |  2 +-
 fs/ecryptfs/inode.c                          |  4 +-
 fs/ecryptfs/mmap.c                           |  2 +-
 fs/ext2/xattr_security.c                     |  2 +-
 fs/ext2/xattr_trusted.c                      |  2 +-
 fs/ext2/xattr_user.c                         |  2 +-
 fs/ext4/xattr_hurd.c                         |  2 +-
 fs/ext4/xattr_security.c                     |  2 +-
 fs/ext4/xattr_trusted.c                      |  2 +-
 fs/ext4/xattr_user.c                         |  2 +-
 fs/f2fs/xattr.c                              |  4 +-
 fs/fuse/xattr.c                              |  4 +-
 fs/gfs2/xattr.c                              |  2 +-
 fs/hfs/attr.c                                |  2 +-
 fs/hfsplus/xattr.c                           |  2 +-
 fs/hfsplus/xattr_security.c                  |  2 +-
 fs/hfsplus/xattr_trusted.c                   |  2 +-
 fs/hfsplus/xattr_user.c                      |  2 +-
 fs/jffs2/security.c                          |  2 +-
 fs/jffs2/xattr_trusted.c                     |  2 +-
 fs/jffs2/xattr_user.c                        |  2 +-
 fs/jfs/xattr.c                               |  4 +-
 fs/kernfs/inode.c                            |  4 +-
 fs/namei.c                                   |  6 +--
 fs/nfs/nfs4proc.c                            | 10 ++---
 fs/ntfs3/xattr.c                             |  2 +-
 fs/ocfs2/xattr.c                             |  6 +--
 fs/orangefs/xattr.c                          |  2 +-
 fs/overlayfs/super.c                         |  4 +-
 fs/reiserfs/xattr_security.c                 |  2 +-
 fs/reiserfs/xattr_trusted.c                  |  2 +-
 fs/reiserfs/xattr_user.c                     |  2 +-
 fs/ubifs/xattr.c                             |  2 +-
 fs/xattr.c                                   | 27 ++++++-------
 fs/xfs/xfs_xattr.c                           |  2 +-
 include/linux/capability.h                   |  5 ++-
 include/linux/evm.h                          |  8 ++--
 include/linux/ima.h                          | 12 +++---
 include/linux/lsm_hook_defs.h                |  6 +--
 include/linux/lsm_hooks.h                    |  2 +-
 include/linux/security.h                     | 22 +++++------
 include/linux/xattr.h                        |  8 ++--
 kernel/auditsc.c                             |  4 +-
 mm/shmem.c                                   |  2 +-
 net/socket.c                                 |  2 +-
 security/commoncap.c                         | 57 +++++++++++++++-------------
 security/integrity/evm/evm_crypto.c          |  4 +-
 security/integrity/evm/evm_main.c            | 20 +++++-----
 security/integrity/ima/ima.h                 | 10 ++---
 security/integrity/ima/ima_api.c             |  6 +--
 security/integrity/ima/ima_appraise.c        | 14 +++----
 security/integrity/ima/ima_asymmetric_keys.c |  2 +-
 security/integrity/ima/ima_main.c            | 26 ++++++-------
 security/integrity/ima/ima_policy.c          | 11 +++---
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 security/security.c                          | 18 ++++-----
 security/selinux/hooks.c                     |  9 +++--
 security/smack/smack_lsm.c                   | 14 +++----
 65 files changed, 203 insertions(+), 204 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d2750085a1f5..7de7a7272a5e 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -135,7 +135,7 @@ prototypes::
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
 	int (*set)(const struct xattr_handler *handler,
-                   struct user_namespace *mnt_userns,
+                   struct mnt_idmap *idmap,
                    struct dentry *dentry, struct inode *inode, const char *name,
                    const void *buffer, size_t size, int flags);
 
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index b6984311e00a..50f7f3f6b55e 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -150,7 +150,7 @@ static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
-				  struct user_namespace *mnt_userns,
+				  struct mnt_idmap *idmap,
 				  struct dentry *dentry, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 7751b0b3f81d..9048d8ccc715 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -97,7 +97,7 @@ static const struct afs_operation_ops afs_store_acl_operation = {
  * Set a file's AFS3 ACL.
  */
 static int afs_xattr_set_acl(const struct xattr_handler *handler,
-			     struct user_namespace *mnt_userns,
+			     struct mnt_idmap *idmap,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
@@ -228,7 +228,7 @@ static const struct afs_operation_ops yfs_store_opaque_acl2_operation = {
  * Set a file's YFS ACL.
  */
 static int afs_xattr_set_yfs(const struct xattr_handler *handler,
-			     struct user_namespace *mnt_userns,
+			     struct mnt_idmap *idmap,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
diff --git a/fs/attr.c b/fs/attr.c
index 48897e036ce9..1093db43ab9e 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -220,7 +220,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ia_valid & ATTR_KILL_PRIV) {
 		int error;
 
-		error = security_inode_killpriv(mnt_userns, dentry);
+		error = security_inode_killpriv(idmap, dentry);
 		if (error)
 			return error;
 	}
@@ -489,7 +489,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
-		ima_inode_post_setattr(mnt_userns, dentry);
+		ima_inode_post_setattr(idmap, dentry);
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 0ed4b119a7ca..0ebeaf4e81f9 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -370,7 +370,7 @@ static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
@@ -383,7 +383,7 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
-					struct user_namespace *mnt_userns,
+					struct mnt_idmap *idmap,
 					struct dentry *unused, struct inode *inode,
 					const char *name, const void *value,
 					size_t size, int flags)
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f31350cda960..f65b07cc33a2 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1285,7 +1285,7 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 }
 
 static int ceph_set_xattr_handler(const struct xattr_handler *handler,
-				  struct user_namespace *mnt_userns,
+				  struct mnt_idmap *idmap,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 5f2fb2fd2e37..50e762fa1a14 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -89,7 +89,7 @@ static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
 }
 
 static int cifs_xattr_set(const struct xattr_handler *handler,
-			  struct user_namespace *mnt_userns,
+			  struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index e3f5d7f3c8a0..bd3f3c755b24 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1105,7 +1105,7 @@ ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
 	}
 
 	inode_lock(lower_inode);
-	rc = __vfs_setxattr(&init_user_ns, lower_dentry, lower_inode,
+	rc = __vfs_setxattr(&nop_mnt_idmap, lower_dentry, lower_inode,
 			    ECRYPTFS_XATTR_NAME, page_virt, size, 0);
 	if (!rc && ecryptfs_inode)
 		fsstack_copy_attr_all(ecryptfs_inode, lower_inode);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 57bc453415cd..144ace9e0dd9 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1099,7 +1099,7 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 		goto out;
 	}
 	inode_lock(lower_inode);
-	rc = __vfs_removexattr(&init_user_ns, lower_dentry, name);
+	rc = __vfs_removexattr(&nop_mnt_idmap, lower_dentry, name);
 	inode_unlock(lower_inode);
 out:
 	return rc;
@@ -1190,7 +1190,7 @@ static int ecryptfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ecryptfs_xattr_set(const struct xattr_handler *handler,
-			      struct user_namespace *mnt_userns,
+			      struct mnt_idmap *idmap,
 			      struct dentry *dentry, struct inode *inode,
 			      const char *name, const void *value, size_t size,
 			      int flags)
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 19af229eb7ca..373c3e5747e6 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -428,7 +428,7 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
 	if (size < 0)
 		size = 8;
 	put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
-	rc = __vfs_setxattr(&init_user_ns, lower_dentry, lower_inode,
+	rc = __vfs_setxattr(&nop_mnt_idmap, lower_dentry, lower_inode,
 			    ECRYPTFS_XATTR_NAME, xattr_virt, size, 0);
 	inode_unlock(lower_inode);
 	if (rc)
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index ebade1f52451..db47b8ab153e 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -19,7 +19,7 @@ ext2_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_security_set(const struct xattr_handler *handler,
-			struct user_namespace *mnt_userns,
+			struct mnt_idmap *idmap,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index 18a87d5dd1ab..995f931228ce 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -26,7 +26,7 @@ ext2_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_trusted_set(const struct xattr_handler *handler,
-		       struct user_namespace *mnt_userns,
+		       struct mnt_idmap *idmap,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index 58092449f8ff..dd1507231081 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -30,7 +30,7 @@ ext2_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_user_set(const struct xattr_handler *handler,
-		    struct user_namespace *mnt_userns,
+		    struct mnt_idmap *idmap,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
index c78df5790377..8a5842e4cd95 100644
--- a/fs/ext4/xattr_hurd.c
+++ b/fs/ext4/xattr_hurd.c
@@ -32,7 +32,7 @@ ext4_xattr_hurd_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_hurd_set(const struct xattr_handler *handler,
-		    struct user_namespace *mnt_userns,
+		    struct mnt_idmap *idmap,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 8213f66f7b2d..776cf11d24ca 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -23,7 +23,7 @@ ext4_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_security_set(const struct xattr_handler *handler,
-			struct user_namespace *mnt_userns,
+			struct mnt_idmap *idmap,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index 7c21ffb26d25..9811eb0ab276 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -30,7 +30,7 @@ ext4_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_trusted_set(const struct xattr_handler *handler,
-		       struct user_namespace *mnt_userns,
+		       struct mnt_idmap *idmap,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index 2fe7ff0a479c..4b70bf4e7626 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -31,7 +31,7 @@ ext4_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_user_set(const struct xattr_handler *handler,
-		    struct user_namespace *mnt_userns,
+		    struct mnt_idmap *idmap,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index dc2e8637189e..044b74322ec4 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -65,7 +65,7 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
-		struct user_namespace *mnt_userns,
+		struct mnt_idmap *idmap,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
@@ -109,7 +109,7 @@ static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
-		struct user_namespace *mnt_userns,
+		struct mnt_idmap *idmap,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..30aaaa4b3bfb 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -189,7 +189,7 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 }
 
 static int fuse_xattr_set(const struct xattr_handler *handler,
-			  struct user_namespace *mnt_userns,
+			  struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value, size_t size,
 			  int flags)
@@ -216,7 +216,7 @@ static int no_xattr_get(const struct xattr_handler *handler,
 }
 
 static int no_xattr_set(const struct xattr_handler *handler,
-			struct user_namespace *mnt_userns,
+			struct mnt_idmap *idmap,
 			struct dentry *dentry, struct inode *nodee,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 518c0677e12a..adf6d17cf033 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1225,7 +1225,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 }
 
 static int gfs2_xattr_set(const struct xattr_handler *handler,
-			  struct user_namespace *mnt_userns,
+			  struct mnt_idmap *idmap,
 			  struct dentry *unused, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 2bd54efaf416..6341bb248247 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -121,7 +121,7 @@ static int hfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int hfs_xattr_set(const struct xattr_handler *handler,
-			 struct user_namespace *mnt_userns,
+			 struct mnt_idmap *idmap,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value, size_t size,
 			 int flags)
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 49891b12c415..5b476f57eb17 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -857,7 +857,7 @@ static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_osx_setxattr(const struct xattr_handler *handler,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *buffer,
 				size_t size, int flags)
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index c1c7a16cbf21..90f68ec119cd 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -23,7 +23,7 @@ static int hfsplus_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_security_setxattr(const struct xattr_handler *handler,
-				     struct user_namespace *mnt_userns,
+				     struct mnt_idmap *idmap,
 				     struct dentry *unused, struct inode *inode,
 				     const char *name, const void *buffer,
 				     size_t size, int flags)
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index e150372ec564..fdbaebc1c49a 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -22,7 +22,7 @@ static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_trusted_setxattr(const struct xattr_handler *handler,
-				    struct user_namespace *mnt_userns,
+				    struct mnt_idmap *idmap,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *buffer,
 				    size_t size, int flags)
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index a6b60b153916..6464b6c3d58d 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -22,7 +22,7 @@ static int hfsplus_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_user_setxattr(const struct xattr_handler *handler,
-				 struct user_namespace *mnt_userns,
+				 struct mnt_idmap *idmap,
 				 struct dentry *unused, struct inode *inode,
 				 const char *name, const void *buffer,
 				 size_t size, int flags)
diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
index aef5522551db..437f3a2c1b54 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -57,7 +57,7 @@ static int jffs2_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_security_setxattr(const struct xattr_handler *handler,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index cc3f24883e7d..b7c5da2d89bd 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -25,7 +25,7 @@ static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_trusted_setxattr(const struct xattr_handler *handler,
-				  struct user_namespace *mnt_userns,
+				  struct mnt_idmap *idmap,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *buffer,
 				  size_t size, int flags)
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index fb945977c013..f64edce4927b 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -25,7 +25,7 @@ static int jffs2_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_user_setxattr(const struct xattr_handler *handler,
-			       struct user_namespace *mnt_userns,
+			       struct mnt_idmap *idmap,
 			       struct dentry *unused, struct inode *inode,
 			       const char *name, const void *buffer,
 			       size_t size, int flags)
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index f9273f6901c8..f817798fa1eb 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -932,7 +932,7 @@ static int jfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set(const struct xattr_handler *handler,
-			 struct user_namespace *mnt_userns,
+			 struct mnt_idmap *idmap,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value,
 			 size_t size, int flags)
@@ -951,7 +951,7 @@ static int jfs_xattr_get_os2(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set_os2(const struct xattr_handler *handler,
-			     struct user_namespace *mnt_userns,
+			     struct mnt_idmap *idmap,
 			     struct dentry *unused, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index af1a05470131..30494dcb0df3 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -324,7 +324,7 @@ static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				struct dentry *unused, struct inode *inode,
 				const char *suffix, const void *value,
 				size_t size, int flags)
@@ -391,7 +391,7 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 }
 
 static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
-				     struct user_namespace *mnt_userns,
+				     struct mnt_idmap *idmap,
 				     struct dentry *unused, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/fs/namei.c b/fs/namei.c
index e483738b2661..a88017266ee5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3633,7 +3633,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
-	ima_post_create_tmpfile(mnt_userns, inode);
+	ima_post_create_tmpfile(idmap, inode);
 	return 0;
 }
 
@@ -3953,7 +3953,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		unsigned int dev)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	struct dentry *dentry;
 	struct path path;
 	int error;
@@ -3974,13 +3973,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		goto out2;
 
 	idmap = mnt_idmap(path.mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
 			if (!error)
-				ima_post_path_mknod(mnt_userns, dentry);
+				ima_post_path_mknod(idmap, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..d9c332019d06 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7692,7 +7692,7 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 #define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
 
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
@@ -7716,7 +7716,7 @@ static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 #define XATTR_NAME_NFSV4_DACL "system.nfs4_dacl"
 
 static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
-				    struct user_namespace *mnt_userns,
+				    struct mnt_idmap *idmap,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
@@ -7739,7 +7739,7 @@ static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
 #define XATTR_NAME_NFSV4_SACL "system.nfs4_sacl"
 
 static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
-				    struct user_namespace *mnt_userns,
+				    struct mnt_idmap *idmap,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
@@ -7764,7 +7764,7 @@ static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 
 static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
-				     struct user_namespace *mnt_userns,
+				     struct mnt_idmap *idmap,
 				     struct dentry *unused, struct inode *inode,
 				     const char *key, const void *buf,
 				     size_t buflen, int flags)
@@ -7815,7 +7815,7 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 
 #ifdef CONFIG_NFS_V4_2
 static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
-				    struct user_namespace *mnt_userns,
+				    struct mnt_idmap *idmap,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 42b8eec72ba0..55ee27c96a4d 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -837,7 +837,7 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
  * ntfs_setxattr - inode_operations::setxattr
  */
 static noinline int ntfs_setxattr(const struct xattr_handler *handler,
-				  struct user_namespace *mnt_userns,
+				  struct mnt_idmap *idmap,
 				  struct dentry *de, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..389308efe854 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7247,7 +7247,7 @@ static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
-				    struct user_namespace *mnt_userns,
+				    struct mnt_idmap *idmap,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *value,
 				    size_t size, int flags)
@@ -7320,7 +7320,7 @@ static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_trusted_set(const struct xattr_handler *handler,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
@@ -7351,7 +7351,7 @@ static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_user_set(const struct xattr_handler *handler,
-				struct user_namespace *mnt_userns,
+				struct mnt_idmap *idmap,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *value,
 				size_t size, int flags)
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 9a5b757fbd2f..6ecad4f94ae6 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -526,7 +526,7 @@ ssize_t orangefs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 }
 
 static int orangefs_xattr_set_default(const struct xattr_handler *handler,
-				      struct user_namespace *mnt_userns,
+				      struct mnt_idmap *idmap,
 				      struct dentry *unused,
 				      struct inode *inode,
 				      const char *name,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 85b891152a2c..f1d9f75f8786 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1012,7 +1012,7 @@ static int ovl_own_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_own_xattr_set(const struct xattr_handler *handler,
-			     struct user_namespace *mnt_userns,
+			     struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
@@ -1028,7 +1028,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
-			       struct user_namespace *mnt_userns,
+			       struct mnt_idmap *idmap,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, const void *value,
 			       size_t size, int flags)
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 857a65b05726..41c0ea84fbff 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -22,7 +22,7 @@ security_get(const struct xattr_handler *handler, struct dentry *unused,
 
 static int
 security_set(const struct xattr_handler *handler,
-	     struct user_namespace *mnt_userns, struct dentry *unused,
+	     struct mnt_idmap *idmap, struct dentry *unused,
 	     struct inode *inode, const char *name, const void *buffer,
 	     size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index d853cea2afcd..0c0c74d8db0e 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -21,7 +21,7 @@ trusted_get(const struct xattr_handler *handler, struct dentry *unused,
 
 static int
 trusted_set(const struct xattr_handler *handler,
-	    struct user_namespace *mnt_userns, struct dentry *unused,
+	    struct mnt_idmap *idmap, struct dentry *unused,
 	    struct inode *inode, const char *name, const void *buffer,
 	    size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index 65d9cd10a5ea..88195181e1d7 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -18,7 +18,7 @@ user_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-user_set(const struct xattr_handler *handler, struct user_namespace *mnt_userns,
+user_set(const struct xattr_handler *handler, struct mnt_idmap *idmap,
 	 struct dentry *unused,
 	 struct inode *inode, const char *name, const void *buffer,
 	 size_t size, int flags)
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3db8486e3725..349228dd1191 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -699,7 +699,7 @@ static int xattr_get(const struct xattr_handler *handler,
 }
 
 static int xattr_set(const struct xattr_handler *handler,
-			   struct user_namespace *mnt_userns,
+			   struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct inode *inode,
 			   const char *name, const void *value,
 			   size_t size, int flags)
diff --git a/fs/xattr.c b/fs/xattr.c
index d056d9ac247a..1cc1420eccce 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -185,7 +185,7 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 EXPORT_SYMBOL(xattr_supported_namespace);
 
 int
-__vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+__vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	       struct inode *inode, const char *name, const void *value,
 	       size_t size, int flags)
 {
@@ -201,7 +201,7 @@ __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, mnt_userns, dentry, inode, name, value,
+	return handler->set(handler, idmap, dentry, inode, name, value,
 			    size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  __vfs_setxattr_noperm - perform setxattr operation without performing
  *  permission checks.
  *
- *  @mnt_userns: user namespace of the mount the inode was found from
+ *  @idmap: idmap of the mount the inode was found from
  *  @dentry: object to perform setxattr on
  *  @name: xattr name to set
  *  @value: value to set @name to
@@ -223,7 +223,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
-int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
+int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name,
 			  const void *value, size_t size, int flags)
 {
@@ -235,7 +235,7 @@ int __vfs_setxattr_noperm(struct user_namespace *mnt_userns,
 	if (issec)
 		inode->i_flags &= ~S_NOSEC;
 	if (inode->i_opflags & IOP_XATTR) {
-		error = __vfs_setxattr(mnt_userns, dentry, inode, name, value,
+		error = __vfs_setxattr(idmap, dentry, inode, name, value,
 				       size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
@@ -280,7 +280,6 @@ __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *name, const void *value, size_t size,
 		      int flags, struct inode **delegated_inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	int error;
 
@@ -288,7 +287,7 @@ __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		return error;
 
-	error = security_inode_setxattr(mnt_userns, dentry, name, value, size,
+	error = security_inode_setxattr(idmap, dentry, name, value, size,
 					flags);
 	if (error)
 		goto out;
@@ -297,7 +296,7 @@ __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error)
 		goto out;
 
-	error = __vfs_setxattr_noperm(mnt_userns, dentry, name, value,
+	error = __vfs_setxattr_noperm(idmap, dentry, name, value,
 				      size, flags);
 
 out:
@@ -309,14 +308,13 @@ int
 vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	const void  *orig_value = value;
 	int error;
 
 	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(mnt_userns, dentry, &value, size);
+		error = cap_convert_nscap(idmap, dentry, &value, size);
 		if (error < 0)
 			return error;
 		size = error;
@@ -484,7 +482,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 EXPORT_SYMBOL_GPL(vfs_listxattr);
 
 int
-__vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+__vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  const char *name)
 {
 	struct inode *inode = d_inode(dentry);
@@ -498,7 +496,7 @@ __vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, mnt_userns, dentry, inode, name, NULL, 0,
+	return handler->set(handler, idmap, dentry, inode, name, NULL, 0,
 			    XATTR_REPLACE);
 }
 EXPORT_SYMBOL(__vfs_removexattr);
@@ -518,7 +516,6 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 			 struct dentry *dentry, const char *name,
 			 struct inode **delegated_inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	int error;
 
@@ -526,7 +523,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
-	error = security_inode_removexattr(mnt_userns, dentry, name);
+	error = security_inode_removexattr(idmap, dentry, name);
 	if (error)
 		goto out;
 
@@ -534,7 +531,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 	if (error)
 		goto out;
 
-	error = __vfs_removexattr(mnt_userns, dentry, name);
+	error = __vfs_removexattr(idmap, dentry, name);
 
 	if (!error) {
 		fsnotify_xattr(dentry);
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 10aa1fd39d2b..7b9a0ed1b11f 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -133,7 +133,7 @@ xfs_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
 
 static int
 xfs_xattr_set(const struct xattr_handler *handler,
-	      struct user_namespace *mnt_userns, struct dentry *unused,
+	      struct mnt_idmap *idmap, struct dentry *unused,
 	      struct inode *inode, const char *name, const void *value,
 	      size_t size, int flags)
 {
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..0a8ba82ef1af 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -42,6 +42,7 @@ struct inode;
 struct dentry;
 struct task_struct;
 struct user_namespace;
+struct mnt_idmap;
 
 extern const kernel_cap_t __cap_empty_set;
 extern const kernel_cap_t __cap_init_eff_set;
@@ -271,11 +272,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 }
 
 /* audit system wants to get cap info from files as well */
-int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
+int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
 			   struct cpu_vfs_cap_data *cpu_caps);
 
-int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
+int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 1f8f806dd0d1..e06aacd3e315 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -24,14 +24,14 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 extern int evm_inode_setattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
-extern int evm_inode_setxattr(struct user_namespace *mnt_userns,
+extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *name,
 			      const void *value, size_t size);
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
 				    size_t xattr_value_len);
-extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
+extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
@@ -101,7 +101,7 @@ static inline void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 	return;
 }
 
-static inline int evm_inode_setxattr(struct user_namespace *mnt_userns,
+static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
 				     struct dentry *dentry, const char *name,
 				     const void *value, size_t size)
 {
@@ -116,7 +116,7 @@ static inline void evm_inode_post_setxattr(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_removexattr(struct user_namespace *mnt_userns,
+static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
 					struct dentry *dentry,
 					const char *xattr_name)
 {
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5a0b2a285a18..6f470b658082 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,7 +18,7 @@ struct linux_binprm;
 extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
-extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
+extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 				    struct inode *inode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
@@ -30,7 +30,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
 			 bool contents);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
-extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
+extern void ima_post_path_mknod(struct mnt_idmap *idmap,
 				struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
@@ -66,7 +66,7 @@ static inline int ima_file_check(struct file *file, int mask)
 	return 0;
 }
 
-static inline void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
+static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 					   struct inode *inode)
 {
 }
@@ -111,7 +111,7 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	return 0;
 }
 
-static inline void ima_post_path_mknod(struct user_namespace *mnt_userns,
+static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
 				       struct dentry *dentry)
 {
 	return;
@@ -183,7 +183,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 
 #ifdef CONFIG_IMA_APPRAISE
 extern bool is_ima_appraise_enabled(void);
-extern void ima_inode_post_setattr(struct user_namespace *mnt_userns,
+extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
@@ -203,7 +203,7 @@ static inline bool is_ima_appraise_enabled(void)
 	return 0;
 }
 
-static inline void ima_inode_post_setattr(struct user_namespace *mnt_userns,
+static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
 					  struct dentry *dentry)
 {
 	return;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 894f233083e3..f344c0e7387a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -136,14 +136,14 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
@@ -152,7 +152,7 @@ LSM_HOOK(int, 0, inode_get_acl, struct user_namespace *mnt_userns,
 LSM_HOOK(int, 0, inode_remove_acl, struct user_namespace *mnt_userns,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
+LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..6e156d2acffc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -475,7 +475,7 @@
  * @inode_killpriv:
  *	The setuid bit is being removed.  Remove similar security labels.
  *	Called with the dentry->d_inode->i_mutex held.
- *	@mnt_userns: user namespace of the mount.
+ *	@idmap: idmap of the mount.
  *	@dentry is the dentry being changed.
  *	Return 0 on success.  If error is returned, then the operation
  *	causing setuid bit removal is failed.
diff --git a/include/linux/security.h b/include/linux/security.h
index d9cd7b2d16a2..474373e631df 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -153,11 +153,10 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags);
-int cap_inode_removexattr(struct user_namespace *mnt_userns,
+int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name);
 int cap_inode_need_killpriv(struct dentry *dentry);
-int cap_inode_killpriv(struct user_namespace *mnt_userns,
-		       struct dentry *dentry);
+int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int cap_inode_getsecurity(struct mnt_idmap *idmap,
 			  struct inode *inode, const char *name, void **buffer,
 			  bool alloc);
@@ -359,7 +358,7 @@ int security_inode_permission(struct inode *inode, int mask);
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
-int security_inode_setxattr(struct user_namespace *mnt_userns,
+int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
 int security_inode_set_acl(struct user_namespace *mnt_userns,
@@ -373,11 +372,10 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
-int security_inode_removexattr(struct user_namespace *mnt_userns,
+int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
-int security_inode_killpriv(struct user_namespace *mnt_userns,
-			    struct dentry *dentry);
+int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc);
@@ -874,7 +872,7 @@ static inline int security_inode_getattr(const struct path *path)
 	return 0;
 }
 
-static inline int security_inode_setxattr(struct user_namespace *mnt_userns,
+static inline int security_inode_setxattr(struct mnt_idmap *idmap,
 		struct dentry *dentry, const char *name, const void *value,
 		size_t size, int flags)
 {
@@ -918,11 +916,11 @@ static inline int security_inode_listxattr(struct dentry *dentry)
 	return 0;
 }
 
-static inline int security_inode_removexattr(struct user_namespace *mnt_userns,
+static inline int security_inode_removexattr(struct mnt_idmap *idmap,
 					     struct dentry *dentry,
 					     const char *name)
 {
-	return cap_inode_removexattr(mnt_userns, dentry, name);
+	return cap_inode_removexattr(idmap, dentry, name);
 }
 
 static inline int security_inode_need_killpriv(struct dentry *dentry)
@@ -930,10 +928,10 @@ static inline int security_inode_need_killpriv(struct dentry *dentry)
 	return cap_inode_need_killpriv(dentry);
 }
 
-static inline int security_inode_killpriv(struct user_namespace *mnt_userns,
+static inline int security_inode_killpriv(struct mnt_idmap *idmap,
 					  struct dentry *dentry)
 {
-	return cap_inode_killpriv(mnt_userns, dentry);
+	return cap_inode_killpriv(idmap, dentry);
 }
 
 static inline int security_inode_getsecurity(struct mnt_idmap *idmap,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index b39d156e0098..6af72461397d 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -42,7 +42,7 @@ struct xattr_handler {
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
 	int (*set)(const struct xattr_handler *,
-		   struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct mnt_idmap *idmap, struct dentry *dentry,
 		   struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
@@ -59,16 +59,16 @@ ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, si
 ssize_t vfs_getxattr(struct mnt_idmap *, struct dentry *, const char *,
 		     void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
-int __vfs_setxattr(struct user_namespace *, struct dentry *, struct inode *,
+int __vfs_setxattr(struct mnt_idmap *, struct dentry *, struct inode *,
 		   const char *, const void *, size_t, int);
-int __vfs_setxattr_noperm(struct user_namespace *, struct dentry *,
+int __vfs_setxattr_noperm(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int);
 int __vfs_setxattr_locked(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int,
 			  struct inode **);
 int vfs_setxattr(struct mnt_idmap *, struct dentry *, const char *,
 		 const void *, size_t, int);
-int __vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
+int __vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct mnt_idmap *, struct dentry *,
 			     const char *, struct inode **);
 int vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 547c88be8a28..01e33f2d2b1c 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2252,7 +2252,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 	if (!dentry)
 		return 0;
 
-	rc = get_vfs_caps_from_disk(&init_user_ns, dentry, &caps);
+	rc = get_vfs_caps_from_disk(&nop_mnt_idmap, dentry, &caps);
 	if (rc)
 		return rc;
 
@@ -2807,7 +2807,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
 
-	get_vfs_caps_from_disk(&init_user_ns,
+	get_vfs_caps_from_disk(&nop_mnt_idmap,
 			       bprm->file->f_path.dentry, &vcaps);
 
 	ax->fcap.permitted = vcaps.permitted;
diff --git a/mm/shmem.c b/mm/shmem.c
index d2f27ddd481e..ed0fa9ed0a3b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3303,7 +3303,7 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
-				   struct user_namespace *mnt_userns,
+				   struct mnt_idmap *idmap,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
diff --git a/net/socket.c b/net/socket.c
index 6234b07a056f..385f59299492 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -385,7 +385,7 @@ static const struct xattr_handler sockfs_xattr_handler = {
 };
 
 static int sockfs_security_xattr_set(const struct xattr_handler *handler,
-				     struct user_namespace *mnt_userns,
+				     struct mnt_idmap *idmap,
 				     struct dentry *dentry, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/security/commoncap.c b/security/commoncap.c
index 01b68f9311ca..b70ba98fbd1c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -305,24 +305,24 @@ int cap_inode_need_killpriv(struct dentry *dentry)
 /**
  * cap_inode_killpriv - Erase the security markings on an inode
  *
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	The inode/dentry to alter
  *
  * Erase the privilege-enhancing security markings on an inode.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  *
  * Return: 0 if successful, -ve on error.
  */
-int cap_inode_killpriv(struct user_namespace *mnt_userns, struct dentry *dentry)
+int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(mnt_userns, dentry, XATTR_NAME_CAPS);
+	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;
@@ -511,7 +511,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
 /**
  * cap_convert_nscap - check vfs caps
  *
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	used to retrieve inode to check permissions on
  * @ivalue:	vfs caps value which may be modified by this function
  * @size:	size of @ivalue
@@ -519,15 +519,15 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  * User requested a write of security.capability.  If needed, update the
  * xattr to change from v2 to v3, or to fixup the v3 rootid.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  *
  * Return: On success, return the new size; on error, return < 0.
  */
-int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
+int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
@@ -537,6 +537,7 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct inode *inode = d_backing_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	kuid_t rootid;
 	vfsuid_t vfsrootid;
 	size_t newsize;
@@ -547,7 +548,7 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == fs_ns))
+	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
 			return size;
@@ -627,19 +628,19 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 /**
  * get_vfs_caps_from_disk - retrieve vfs caps from disk
  *
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	dentry from which @inode is retrieved
  * @cpu_caps:	vfs capabilities
  *
  * Extract the on-exec-apply capability sets for an executable file.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply passs @nop_mnt_idmap.
  */
-int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
+int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
 			   struct cpu_vfs_cap_data *cpu_caps)
 {
@@ -652,6 +653,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	kuid_t rootkuid;
 	vfsuid_t rootvfsuid;
 	struct user_namespace *fs_ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
 
@@ -748,7 +750,7 @@ static int get_file_caps(struct linux_binprm *bprm, struct file *file,
 	if (!current_in_userns(file->f_path.mnt->mnt_sb->s_user_ns))
 		return 0;
 
-	rc = get_vfs_caps_from_disk(file_mnt_user_ns(file),
+	rc = get_vfs_caps_from_disk(file_mnt_idmap(file),
 				    file->f_path.dentry, &vcaps);
 	if (rc < 0) {
 		if (rc == -EINVAL)
@@ -1017,26 +1019,27 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 /**
  * cap_inode_removexattr - Determine whether an xattr may be removed
  *
- * @mnt_userns:	User namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	The inode/dentry being altered
  * @name:	The name of the xattr to be changed
  *
  * Determine whether an xattr may be removed from an inode, returning 0 if
  * permission is granted, -ve if denied.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  *
  * This is used to make sure security xattrs don't get removed by those who
  * aren't privileged to remove them.
  */
-int cap_inode_removexattr(struct user_namespace *mnt_userns,
+int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name)
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b202edc2ff65..52b811da6989 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -376,12 +376,12 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			   xattr_value_len, &data);
 	if (rc == 0) {
 		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
-		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
+		rc = __vfs_setxattr_noperm(&nop_mnt_idmap, dentry,
 					   XATTR_NAME_EVM,
 					   &data.hdr.xattr.data[1],
 					   SHA1_DIGEST_SIZE + 1, 0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
-		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
+		rc = __vfs_removexattr(&nop_mnt_idmap, dentry, XATTR_NAME_EVM);
 	}
 	return rc;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 45bcd08a9224..99f7bd8af19a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -436,7 +436,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 
 /*
  * evm_xattr_change - check if passed xattr value differs from current value
- * @mnt_userns: user namespace of the idmapped mount
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
@@ -446,7 +446,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
  *
  * Returns 1 if passed xattr value differs from current value, 0 otherwise.
  */
-static int evm_xattr_change(struct user_namespace *mnt_userns,
+static int evm_xattr_change(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *xattr_name,
 			    const void *xattr_value, size_t xattr_value_len)
 {
@@ -482,7 +482,7 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
  * For posix xattr acls only, permit security.evm, even if it currently
  * doesn't exist, to be updated unless the EVM signature is immutable.
  */
-static int evm_protect_xattr(struct user_namespace *mnt_userns,
+static int evm_protect_xattr(struct mnt_idmap *idmap,
 			     struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
 {
@@ -538,7 +538,7 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
 		return 0;
 
 	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
-	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
+	    !evm_xattr_change(idmap, dentry, xattr_name, xattr_value,
 			      xattr_value_len))
 		return 0;
 
@@ -553,7 +553,7 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
 
 /**
  * evm_inode_setxattr - protect the EVM extended attribute
- * @mnt_userns: user namespace of the idmapped mount
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
@@ -565,7 +565,7 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
  * userspace from writing HMAC value.  Writing 'security.evm' requires
  * requires CAP_SYS_ADMIN privileges.
  */
-int evm_inode_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+int evm_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       const char *xattr_name, const void *xattr_value,
 		       size_t xattr_value_len)
 {
@@ -584,20 +584,20 @@ int evm_inode_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
 			return -EPERM;
 	}
-	return evm_protect_xattr(mnt_userns, dentry, xattr_name, xattr_value,
+	return evm_protect_xattr(idmap, dentry, xattr_name, xattr_value,
 				 xattr_value_len);
 }
 
 /**
  * evm_inode_removexattr - protect the EVM extended attribute
- * @mnt_userns: user namespace of the idmapped mount
+ * @idmap: idmap of the mount
  * @dentry: pointer to the affected dentry
  * @xattr_name: pointer to the affected extended attribute name
  *
  * Removing 'security.evm' requires CAP_SYS_ADMIN privileges and that
  * the current value is valid.
  */
-int evm_inode_removexattr(struct user_namespace *mnt_userns,
+int evm_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *xattr_name)
 {
 	/* Policy permits modification of the protected xattrs even though
@@ -606,7 +606,7 @@ int evm_inode_removexattr(struct user_namespace *mnt_userns,
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
-	return evm_protect_xattr(mnt_userns, dentry, xattr_name, NULL, 0);
+	return evm_protect_xattr(idmap, dentry, xattr_name, NULL, 0);
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 03b440921e61..d8530e722515 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -254,7 +254,7 @@ static inline void ima_process_queued_keys(void) {}
 #endif /* CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS */
 
 /* LIM API function definitions */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -268,7 +268,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -285,7 +285,7 @@ void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
 /* IMA policy related functions */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
@@ -318,7 +318,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig);
-int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -346,7 +346,7 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 	return INTEGRITY_UNKNOWN;
 }
 
-static inline int ima_must_appraise(struct user_namespace *mnt_userns,
+static inline int ima_must_appraise(struct mnt_idmap *idmap,
 				    struct inode *inode, int mask,
 				    enum ima_hooks func)
 {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c1e76282b5ee..9345fd66f5b8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -163,7 +163,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 
 /**
  * ima_get_action - appraise & measure decision based on policy.
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: pointer to the inode associated with the object being validated
  * @cred: pointer to credentials structure to validate
  * @secid: secid of the task being validated
@@ -186,7 +186,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * Returns IMA_MEASURE, IMA_APPRAISE mask.
  *
  */
-int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 		   const struct cred *cred, u32 secid, int mask,
 		   enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
@@ -196,7 +196,7 @@ int ima_get_action(struct user_namespace *mnt_userns, struct inode *inode,
 
 	flags &= ima_policy_flag;
 
-	return ima_match_policy(mnt_userns, inode, cred, secid, func, mask,
+	return ima_match_policy(idmap, inode, cred, secid, func, mask,
 				flags, pcr, template_desc, func_data,
 				allowed_algos);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 734a6818a545..4078a9ad8531 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -70,7 +70,7 @@ bool is_ima_appraise_enabled(void)
  *
  * Return 1 to appraise or hash
  */
-int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func)
 {
 	u32 secid;
@@ -79,7 +79,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 		return 0;
 
 	security_current_getsecid_subj(&secid);
-	return ima_match_policy(mnt_userns, inode, current_cred(), secid,
+	return ima_match_policy(idmap, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
 }
@@ -98,7 +98,7 @@ static int ima_fix_xattr(struct dentry *dentry,
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
-	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
+	rc = __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_IMA,
 				   &iint->ima_hash->xattr.data[offset],
 				   (sizeof(iint->ima_hash->xattr) - offset) +
 				   iint->ima_hash->length, 0);
@@ -456,7 +456,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 
 		rc = is_binary_blacklisted(digest, digestsize);
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
+			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
 						   pcr, NULL, false, NULL, 0);
 	}
@@ -622,7 +622,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 
 /**
  * ima_inode_post_setattr - reflect file metadata changes
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:  idmap of the mount the inode was found from
  * @dentry: pointer to the affected dentry
  *
  * Changes to a dentry's metadata might result in needing to appraise.
@@ -630,7 +630,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
  * This function is called from notify_change(), which expects the caller
  * to lock the inode's i_mutex.
  */
-void ima_inode_post_setattr(struct user_namespace *mnt_userns,
+void ima_inode_post_setattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
@@ -641,7 +641,7 @@ void ima_inode_post_setattr(struct user_namespace *mnt_userns,
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(mnt_userns, inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(idmap, inode, MAY_ACCESS, POST_SETATTR);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index f6aa0b47a772..caacfe6860b1 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -60,7 +60,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * if the IMA policy is configured to measure a key linked
 	 * to the given keyring.
 	 */
-	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
+	process_buffer_measurement(&nop_mnt_idmap, NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
 				   keyring->description, false, NULL, 0);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 377300973e6c..358578267fea 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -224,7 +224,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * bitmask based on the appraise/audit/measurement policy.
 	 * Included is the appraise submask.
 	 */
-	action = ima_get_action(file_mnt_user_ns(file), inode, cred, secid,
+	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
@@ -451,7 +451,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 
 	security_current_getsecid_subj(&secid);
 	inode = file_inode(vma->vm_file);
-	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
+	action = ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
 
@@ -638,14 +638,14 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: inode of the newly created tmpfile
  *
  * No measuring, appraising or auditing of newly created tmpfiles is needed.
  * Skip calling process_measurement(), but indicate which newly, created
  * tmpfiles are in policy.
  */
-void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
+void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 			     struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
@@ -654,7 +654,7 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
+	must_appraise = ima_must_appraise(idmap, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
 		return;
@@ -671,13 +671,13 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 
 /**
  * ima_post_path_mknod - mark as a new inode
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @dentry: newly created dentry
  *
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
-void ima_post_path_mknod(struct user_namespace *mnt_userns,
+void ima_post_path_mknod(struct mnt_idmap *idmap,
 			 struct dentry *dentry)
 {
 	struct integrity_iint_cache *iint;
@@ -687,7 +687,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-	must_appraise = ima_must_appraise(mnt_userns, inode, MAY_ACCESS,
+	must_appraise = ima_must_appraise(idmap, inode, MAY_ACCESS,
 					  FILE_CHECK);
 	if (!must_appraise)
 		return;
@@ -869,7 +869,7 @@ int ima_post_load_data(char *buf, loff_t size,
 
 /**
  * process_buffer_measurement - Measure the buffer or the buffer data hash
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
  * @buf: pointer to the buffer that needs to be added to the log.
  * @size: size of buffer(in bytes).
@@ -887,7 +887,7 @@ int ima_post_load_data(char *buf, loff_t size,
  * has been written to the passed location but not added to a measurement entry,
  * a negative value otherwise.
  */
-int process_buffer_measurement(struct user_namespace *mnt_userns,
+int process_buffer_measurement(struct mnt_idmap *idmap,
 			       struct inode *inode, const void *buf, int size,
 			       const char *eventname, enum ima_hooks func,
 			       int pcr, const char *func_data,
@@ -931,7 +931,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	 */
 	if (func) {
 		security_current_getsecid_subj(&secid);
-		action = ima_get_action(mnt_userns, inode, current_cred(),
+		action = ima_get_action(idmap, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data, NULL);
 		if (!(action & IMA_MEASURE) && !digest)
@@ -1011,7 +1011,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	if (!f.file)
 		return;
 
-	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
+	process_buffer_measurement(file_mnt_idmap(f.file), file_inode(f.file),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
@@ -1044,7 +1044,7 @@ int ima_measure_critical_data(const char *event_label,
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
-	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
+	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
 					  event_name, CRITICAL_DATA, 0,
 					  event_label, hash, digest,
 					  digest_len);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6a68ec270822..2ba72bc5d9c2 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -552,7 +552,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 /**
  * ima_match_rules - determine whether an inode matches the policy rule.
  * @rule: a pointer to a rule
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
  * @secid: the secid of the task to be validated
@@ -563,7 +563,7 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
  * Returns true on rule match, false on failure.
  */
 static bool ima_match_rules(struct ima_rule_entry *rule,
-			    struct user_namespace *mnt_userns,
+			    struct mnt_idmap *idmap,
 			    struct inode *inode, const struct cred *cred,
 			    u32 secid, enum ima_hooks func, int mask,
 			    const char *func_data)
@@ -572,6 +572,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	bool result = false;
 	struct ima_rule_entry *lsm_rule = rule;
 	bool rule_reinitialized = false;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -713,7 +714,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 
 /**
  * ima_match_policy - decision based on LSM and other conditions
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @inode: pointer to an inode for which the policy decision is being made
  * @cred: pointer to a credentials structure for which the policy decision is
  *        being made
@@ -732,7 +733,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * list when walking it.  Reads are many orders of magnitude more numerous
  * than writes so ima_match_policy() is classical RCU candidate.
  */
-int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
+int ima_match_policy(struct mnt_idmap *idmap, struct inode *inode,
 		     const struct cred *cred, u32 secid, enum ima_hooks func,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
@@ -752,7 +753,7 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
 		if (!(entry->action & actmask))
 			continue;
 
-		if (!ima_match_rules(entry, mnt_userns, inode, cred, secid,
+		if (!ima_match_rules(entry, idmap, inode, cred, secid,
 				     func, mask, func_data))
 			continue;
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 93056c03bf5a..4f0aea155bf9 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -159,7 +159,7 @@ void ima_process_queued_keys(void)
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
-			process_buffer_measurement(&init_user_ns, NULL,
+			process_buffer_measurement(&nop_mnt_idmap, NULL,
 						   entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
diff --git a/security/security.c b/security/security.c
index df7182fb1291..7e7a12142854 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1375,7 +1375,7 @@ int security_inode_getattr(const struct path *path)
 	return call_int_hook(inode_getattr, 0, path);
 }
 
-int security_inode_setxattr(struct user_namespace *mnt_userns,
+int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
@@ -1387,7 +1387,7 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, mnt_userns, dentry, name, value,
+	ret = call_int_hook(inode_setxattr, 1, idmap, dentry, name, value,
 			    size, flags);
 
 	if (ret == 1)
@@ -1397,7 +1397,7 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	ret = ima_inode_setxattr(dentry, name, value, size);
 	if (ret)
 		return ret;
-	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
+	return evm_inode_setxattr(idmap, dentry, name, value, size);
 }
 
 int security_inode_set_acl(struct user_namespace *mnt_userns,
@@ -1465,7 +1465,7 @@ int security_inode_listxattr(struct dentry *dentry)
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
 
-int security_inode_removexattr(struct user_namespace *mnt_userns,
+int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name)
 {
 	int ret;
@@ -1476,15 +1476,15 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
+	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
 	if (ret == 1)
-		ret = cap_inode_removexattr(mnt_userns, dentry, name);
+		ret = cap_inode_removexattr(idmap, dentry, name);
 	if (ret)
 		return ret;
 	ret = ima_inode_removexattr(dentry, name);
 	if (ret)
 		return ret;
-	return evm_inode_removexattr(mnt_userns, dentry, name);
+	return evm_inode_removexattr(idmap, dentry, name);
 }
 
 int security_inode_need_killpriv(struct dentry *dentry)
@@ -1492,10 +1492,10 @@ int security_inode_need_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_need_killpriv, 0, dentry);
 }
 
-int security_inode_killpriv(struct user_namespace *mnt_userns,
+int security_inode_killpriv(struct mnt_idmap *idmap,
 			    struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, mnt_userns, dentry);
+	return call_int_hook(inode_killpriv, 0, idmap, dentry);
 }
 
 int security_inode_getsecurity(struct mnt_idmap *idmap,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a32a814a694d..706bb440f837 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3145,7 +3145,7 @@ static bool has_cap_mac_admin(bool audit)
 	return true;
 }
 
-static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
+static int selinux_inode_setxattr(struct mnt_idmap *idmap,
 				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
@@ -3154,6 +3154,7 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int rc = 0;
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
@@ -3313,11 +3314,11 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_removexattr(struct user_namespace *mnt_userns,
+static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 				     struct dentry *dentry, const char *name)
 {
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		int rc = cap_inode_removexattr(mnt_userns, dentry, name);
+		int rc = cap_inode_removexattr(idmap, dentry, name);
 		if (rc)
 			return rc;
 
@@ -6588,7 +6589,7 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
  */
 static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SELINUX,
+	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SELINUX,
 				     ctx, ctxlen, 0);
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 15983032220a..306c921759f6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1207,7 +1207,7 @@ static int smack_inode_getattr(const struct path *path)
 
 /**
  * smack_inode_setxattr - Smack check for setting xattrs
- * @mnt_userns: active user namespace
+ * @idmap: idmap of the mount
  * @dentry: the object
  * @name: name of the attribute
  * @value: value of the attribute
@@ -1218,7 +1218,7 @@ static int smack_inode_getattr(const struct path *path)
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_setxattr(struct user_namespace *mnt_userns,
+static int smack_inode_setxattr(struct mnt_idmap *idmap,
 				struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags)
 {
@@ -1334,7 +1334,7 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
 
 /**
  * smack_inode_removexattr - Smack check on removexattr
- * @mnt_userns: active user namespace
+ * @idmap: idmap of the mount
  * @dentry: the object
  * @name: name of the attribute
  *
@@ -1342,7 +1342,7 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_removexattr(struct user_namespace *mnt_userns,
+static int smack_inode_removexattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry, const char *name)
 {
 	struct inode_smack *isp;
@@ -1358,7 +1358,7 @@ static int smack_inode_removexattr(struct user_namespace *mnt_userns,
 		if (!smack_privileged(CAP_MAC_ADMIN))
 			rc = -EPERM;
 	} else
-		rc = cap_inode_removexattr(mnt_userns, dentry, name);
+		rc = cap_inode_removexattr(idmap, dentry, name);
 
 	if (rc != 0)
 		return rc;
@@ -3507,7 +3507,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 			 */
 			if (isp->smk_flags & SMK_INODE_CHANGED) {
 				isp->smk_flags &= ~SMK_INODE_CHANGED;
-				rc = __vfs_setxattr(&init_user_ns, dp, inode,
+				rc = __vfs_setxattr(&nop_mnt_idmap, dp, inode,
 					XATTR_NAME_SMACKTRANSMUTE,
 					TRANS_TRUE, TRANS_TRUE_SIZE,
 					0);
@@ -4686,7 +4686,7 @@ static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_SMACK,
+	return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_SMACK,
 				     ctx, ctxlen, 0);
 }
 

-- 
2.34.1

