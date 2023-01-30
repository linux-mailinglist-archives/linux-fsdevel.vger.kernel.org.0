Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23246816A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjA3Qma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjA3QmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41716366BC
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE199B81338
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 16:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B5C433EF;
        Mon, 30 Jan 2023 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096937;
        bh=9+Xel24tY6Uao7w0IaDfFDR1sWmlEsSMw+wZ1jTfUHM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bFT1keDdNCLwCnXk4HtiHC367VFRsiEjWlNKX7QGXKgSwkKe8KRsJz46OjWcFHRqX
         hYYRJH5zJ22xCgjey9Ee81v8zSN7JFiqMRwmz/KQ91z7snOaT4BJMjBPpgWOClwbvL
         Pda9OcDM7pjjR3EIN8q5C3marbghhzyy3Lgrmn77luf8fRKjo5Y8QWy87WHeD4jOT7
         LweYdwdpdTlUIIQ/ZE40zitzpw5BDoEkFUuQ8anTqEW5rVS7LoJnF9gvYwnqxbGswf
         6Ca7t3Dfmi9ryscXnueK5BGNVstCD4KoIHN7ZNr5IBqSLwMxbz46F2L+OG/6g5eDmh
         03REgxCvPaDMA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 30 Jan 2023 17:42:01 +0100
Subject: [PATCH v2 5/8] fs: drop unused posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v2-5-214cfb88bb56@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11741; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9+Xel24tY6Uao7w0IaDfFDR1sWmlEsSMw+wZ1jTfUHM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf/xz3wTAhb9n17bnWTufqik6Jahdcl2N3OlK8nTNhwiLT
 U1+ndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE4QHD//JtTPt72bqMOb97L50sNW
 3D9IbNHM+kp/dUssz7JiEzn5Phn03YMs23Ox/luiROT9rg2O10bXuCzbsTVVNNnO88/2mnxQYA
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Fold all filesystem changes except reiserfs into this patch.
---
 fs/9p/xattr.c        | 4 ----
 fs/btrfs/xattr.c     | 4 ----
 fs/ceph/xattr.c      | 4 ----
 fs/cifs/xattr.c      | 4 ----
 fs/ecryptfs/inode.c  | 4 ----
 fs/erofs/xattr.c     | 4 ----
 fs/ext2/xattr.c      | 4 ----
 fs/ext4/xattr.c      | 4 ----
 fs/f2fs/xattr.c      | 4 ----
 fs/gfs2/xattr.c      | 2 --
 fs/jffs2/xattr.c     | 4 ----
 fs/jfs/xattr.c       | 4 ----
 fs/nfs/nfs3_fs.h     | 1 -
 fs/nfs/nfs3acl.c     | 6 ------
 fs/nfs/nfs3super.c   | 3 ---
 fs/ntfs3/xattr.c     | 4 ----
 fs/ocfs2/xattr.c     | 2 --
 fs/orangefs/xattr.c  | 2 --
 fs/overlayfs/super.c | 8 --------
 fs/xfs/xfs_xattr.c   | 4 ----
 mm/shmem.c           | 4 ----
 21 files changed, 80 deletions(-)

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
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a62fb8a3318a..2c98a15a92ed 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -469,10 +469,6 @@ const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 
 const struct xattr_handler *erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
 	&erofs_xattr_security_handler,
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 641abfa4b718..262951ffe8d0 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -113,10 +113,6 @@ static const struct xattr_handler *ext2_xattr_handler_map[] = {
 const struct xattr_handler *ext2_xattr_handlers[] = {
 	&ext2_xattr_user_handler,
 	&ext2_xattr_trusted_handler,
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 #ifdef CONFIG_EXT2_FS_SECURITY
 	&ext2_xattr_security_handler,
 #endif
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index a2f04a3808db..ba7f2557adb8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -101,10 +101,6 @@ static const struct xattr_handler * const ext4_xattr_handler_map[] = {
 const struct xattr_handler *ext4_xattr_handlers[] = {
 	&ext4_xattr_user_handler,
 	&ext4_xattr_trusted_handler,
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 #ifdef CONFIG_EXT4_FS_SECURITY
 	&ext4_xattr_security_handler,
 #endif
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index dc2e8637189e..ccb564e328af 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -204,10 +204,6 @@ static const struct xattr_handler *f2fs_xattr_handler_map[] = {
 
 const struct xattr_handler *f2fs_xattr_handlers[] = {
 	&f2fs_xattr_user_handler,
-#ifdef CONFIG_F2FS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&f2fs_xattr_trusted_handler,
 #ifdef CONFIG_F2FS_FS_SECURITY
 	&f2fs_xattr_security_handler,
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
 
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..0eaec4a0f3b1 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -919,10 +919,6 @@ const struct xattr_handler *jffs2_xattr_handlers[] = {
 	&jffs2_user_xattr_handler,
 #ifdef CONFIG_JFFS2_FS_SECURITY
 	&jffs2_security_xattr_handler,
-#endif
-#ifdef CONFIG_JFFS2_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 #endif
 	&jffs2_trusted_xattr_handler,
 	NULL
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
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..482b2ef7ca54 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -89,8 +89,6 @@ static struct ocfs2_xattr_def_value_root def_xv = {
 
 const struct xattr_handler *ocfs2_xattr_handlers[] = {
 	&ocfs2_xattr_user_handler,
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 	&ocfs2_xattr_trusted_handler,
 	&ocfs2_xattr_security_handler,
 	NULL
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
index 0005ab2c29af..06b91b524dfc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3331,10 +3331,6 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
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

