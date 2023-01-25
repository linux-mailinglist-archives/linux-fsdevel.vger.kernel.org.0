Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F067B141
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjAYLaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjAYL3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF9322A33
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A4C614BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C5CC4339C;
        Wed, 25 Jan 2023 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646173;
        bh=YJdMOaNTSboPBakdGZtb5/eAxnhlrj+MEmcYvcegqDI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=geEHcHBT/tSZlrxP9TQvnG3fA6sh6dzT6qH8Nl3DfslAFxwvPSM2Yv9hisA5fJMGn
         QXypa5WDCgg8wJduLduKZiEk9OWJSFOOdvUm1ZQpIl0/fKb9vNfNbGwAmbLabXkdPK
         GgTD+wtGZg7gWGo7Lqww3ovwOqe1X2RejWO8mBguoiEF8Z+awY3OglyW5O5VbT+ulu
         PojneqLNUElPOahcguXMEIwIs5ISpyBlZh+iw7gyyPikUFxPG8cx1pDKlz2u5bJb27
         dii+R8egwp4N8NfZvw95gJYPLfQUi+it5UnHAN/rFnFwEQUOVbJ2B9X4eK2EEExx+9
         6r5ctvfWPxA/Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:49 +0100
Subject: [PATCH 04/12] fs: drop unused posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-4-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8360; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YJdMOaNTSboPBakdGZtb5/eAxnhlrj+MEmcYvcegqDI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJo4z+9QvzxTy7LVJtdPbKj5Xch6mWeC25rJ4kzPXv7P
 TN/L01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARy2RGhk3zDDO7XA+nrf7rx37r1s
 bfOgnZv+4pebQotthFv2DZZMjI8GfaQYcPbpEF8rV3Tq45whD+mG/NrNxPG6LqlQSOvfpnzwYA
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

Remove struct posix_acl_{access,default}_handler for all filesystems
that don't depend on the xattr handler in their inode->i_op->listxattr()
method in any way. There's nothing more to do than to simply remove the
handler. It's been effectively unused ever since we introduced the new
posix acl api.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/9p/xattr.c        | 4 ----
 fs/btrfs/xattr.c     | 4 ----
 fs/ceph/xattr.c      | 4 ----
 fs/cifs/xattr.c      | 4 ----
 fs/ecryptfs/inode.c  | 4 ----
 fs/gfs2/xattr.c      | 2 --
 fs/jfs/xattr.c       | 4 ----
 fs/nfs/nfs3_fs.h     | 1 -
 fs/nfs/nfs3acl.c     | 6 ------
 fs/nfs/nfs3super.c   | 3 ---
 fs/ntfs3/xattr.c     | 4 ----
 fs/orangefs/xattr.c  | 2 --
 fs/overlayfs/super.c | 8 --------
 fs/xfs/xfs_xattr.c   | 4 ----
 mm/shmem.c           | 4 ----
 15 files changed, 58 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index b6984311e00a..1d2df17b450f 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -183,10 +183,6 @@ static struct xattr_handler v9fs_xattr_security_handler = {
 const struct xattr_handler *v9fs_xattr_handlers[] = {
 	&v9fs_xattr_user_handler,
 	&v9fs_xattr_trusted_handler,
-#ifdef CONFIG_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 #ifdef CONFIG_9P_FS_SECURITY
 	&v9fs_xattr_security_handler,
 #endif
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 0ed4b119a7ca..a6abe528c5d8 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -444,10 +444,6 @@ static const struct xattr_handler btrfs_btrfs_xattr_handler = {
 
 const struct xattr_handler *btrfs_xattr_handlers[] = {
 	&btrfs_security_xattr_handler,
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&btrfs_trusted_xattr_handler,
 	&btrfs_user_xattr_handler,
 	&btrfs_btrfs_xattr_handler,
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f31350cda960..22e22e8dc226 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1411,10 +1411,6 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
  * attributes are handled directly.
  */
 const struct xattr_handler *ceph_xattr_handlers[] = {
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&ceph_other_xattr_handler,
 	NULL,
 };
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 5f2fb2fd2e37..1b50814eadbb 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -487,9 +487,5 @@ const struct xattr_handler *cifs_xattr_handlers[] = {
 	&smb3_ntsd_xattr_handler, /* alias for above since avoiding "cifs" */
 	&cifs_cifs_ntsd_full_xattr_handler,
 	&smb3_ntsd_full_xattr_handler, /* alias for above since avoiding "cifs" */
-#ifdef CONFIG_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	NULL
 };
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index f3cd00fac9c3..5802b93b2cda 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1210,10 +1210,6 @@ static const struct xattr_handler ecryptfs_xattr_handler = {
 };
 
 const struct xattr_handler *ecryptfs_xattr_handlers[] = {
-#ifdef CONFIG_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&ecryptfs_xattr_handler,
 	NULL
 };
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 518c0677e12a..88c78dc526fa 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1501,8 +1501,6 @@ const struct xattr_handler *gfs2_xattr_handlers_max[] = {
 	/* GFS2_FS_FORMAT_MIN */
 	&gfs2_xattr_user_handler,
 	&gfs2_xattr_security_handler,
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 	NULL,
 };
 
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index f9273f6901c8..dfdc0c1f6e25 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -986,10 +986,6 @@ static const struct xattr_handler jfs_trusted_xattr_handler = {
 };
 
 const struct xattr_handler *jfs_xattr_handlers[] = {
-#ifdef CONFIG_JFS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&jfs_os2_xattr_handler,
 	&jfs_user_xattr_handler,
 	&jfs_security_xattr_handler,
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index df9ca56db347..a6d1314dbe56 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -17,7 +17,6 @@ extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry
 extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl);
 extern ssize_t nfs3_listxattr(struct dentry *, char *, size_t);
-extern const struct xattr_handler *nfs3_xattr_handlers[];
 #else
 static inline int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl)
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index 74d11e3c4205..aeb158e3bd99 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -300,12 +300,6 @@ int nfs3_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	goto out;
 }
 
-const struct xattr_handler *nfs3_xattr_handlers[] = {
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-	NULL,
-};
-
 static int
 nfs3_list_one_acl(struct inode *inode, int type, const char *name, void *data,
 		size_t size, ssize_t *result)
diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
index 7c5809431e61..8a9be9e47f76 100644
--- a/fs/nfs/nfs3super.c
+++ b/fs/nfs/nfs3super.c
@@ -14,9 +14,6 @@ struct nfs_subversion nfs_v3 = {
 	.rpc_vers = &nfs_version3,
 	.rpc_ops  = &nfs_v3_clientops,
 	.sops     = &nfs_sops,
-#ifdef CONFIG_NFS_V3_ACL
-	.xattr    = nfs3_xattr_handlers,
-#endif
 };
 
 static int __init init_nfs_v3(void)
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 616df209feea..1eb9f3d9ba8c 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -1033,10 +1033,6 @@ static const struct xattr_handler ntfs_other_xattr_handler = {
 };
 
 const struct xattr_handler *ntfs_xattr_handlers[] = {
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&ntfs_other_xattr_handler,
 	NULL,
 };
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 9a5b757fbd2f..3203abc89b9f 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -555,8 +555,6 @@ static const struct xattr_handler orangefs_xattr_default_handler = {
 };
 
 const struct xattr_handler *orangefs_xattr_handlers[] = {
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 	&orangefs_xattr_default_handler,
 	NULL
 };
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 85b891152a2c..559d416e06a3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1055,20 +1055,12 @@ static const struct xattr_handler ovl_other_xattr_handler = {
 };
 
 static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
-#ifdef CONFIG_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&ovl_own_trusted_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
 };
 
 static const struct xattr_handler *ovl_user_xattr_handlers[] = {
-#ifdef CONFIG_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&ovl_own_user_xattr_handler,
 	&ovl_other_xattr_handler,
 	NULL
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 10aa1fd39d2b..379e1dc97225 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -179,10 +179,6 @@ const struct xattr_handler *xfs_xattr_handlers[] = {
 	&xfs_xattr_user_handler,
 	&xfs_xattr_trusted_handler,
 	&xfs_xattr_security_handler,
-#ifdef CONFIG_XFS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	NULL
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..081a82edf7c0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3333,10 +3333,6 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
 };
 
 static const struct xattr_handler *shmem_xattr_handlers[] = {
-#ifdef CONFIG_TMPFS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&shmem_security_xattr_handler,
 	&shmem_trusted_xattr_handler,
 	NULL

-- 
2.34.1

