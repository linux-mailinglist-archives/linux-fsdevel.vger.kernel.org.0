Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B228345A1C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhKWLqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236441AbhKWLqK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0AF660240;
        Tue, 23 Nov 2021 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667782;
        bh=aHTObxp2QlNutltSti2v81inpBtEPMRjC/7G/erOuls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T33sY07lkcxLui6SPt53uCuXblLmcfwrZRHt7Wuq5TPxm1DNyDr0pJLR4p+nIA6IF
         ZXZySkjWjn7wt0/Y38aGD42JXUVuagqE+7IufeCU7JOkd9ckE2UODkVJM8pBSsece0
         Tmttry71VXh1dp4XJkz7QPyr/870scXUbTmJ+EjLyMj5nF5scRcUqmV2oUF+oyiNdN
         frUGGFhW7N9VNkC3qAzFcEfMVgb1blI0TkOFTJ/AXYOr/Zrt9wXgA8Mtv+wtsSvHww
         WwS5U4rCxKF8jPMSlUhhJX8o+rky86FAMnUSD6x9bKv9yucH8OjHzqTfQ7j8WOcTDC
         Yhq/rCG3rNYlw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 08/10] fs: port higher-level mapping helpers
Date:   Tue, 23 Nov 2021 12:42:25 +0100
Message-Id: <20211123114227.3124056-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6250; h=from:subject; bh=xqFNMn31fegqh0TT9/RZQrtDaVPF2JVrt+Jsn8Qob4w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVxqduy2uF1X9ZaHayd0bciyuqnjfPr/h1vrry07G+vp fDUuo6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAigksZ/vCb7LovkMH3NPzczaV2/2 YcbSuM2LfBc4d5dVbhwcUcs6QZ/oqZnM+0OlhhwLbG7bZ+WY7d6Q4pmZI2KzbZM9LP9/zs4gEA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable the mapped_fs{g,u}id() helpers to support filesystems mounted
with an idmapping. Apart from core mapping helpers that use
mapped_fs{g,u}id() to initialize struct inode's i_{g,u}id fields xfs is
the only place that uses these low-level helpers directly.

The patch only extends the helpers to be able to take the filesystem
idmapping into account. Since we don't actually yet pass the
filesystem's idmapping in no functional changes happen. This will happen
in a final patch.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/xfs/xfs_inode.c          | 10 ++++++----
 fs/xfs/xfs_symlink.c        |  5 +++--
 include/linux/fs.h          |  8 ++++----
 include/linux/mnt_mapping.h | 12 ++++++++----
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 64b9bf334806..7ac8247b5498 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -977,6 +977,7 @@ xfs_create(
 	struct xfs_trans_res	*tres;
 	uint			resblks;
 	xfs_ino_t		ino;
+	struct user_namespace	*fs_userns = &init_user_ns;
 
 	trace_xfs_create(dp, name);
 
@@ -988,8 +989,8 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, fs_userns),
+			mapped_fsgid(mnt_userns, fs_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1133,6 +1134,7 @@ xfs_create_tmpfile(
 	struct xfs_trans_res	*tres;
 	uint			resblks;
 	xfs_ino_t		ino;
+	struct user_namespace	*fs_userns = &init_user_ns;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1142,8 +1144,8 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, fs_userns),
+			mapped_fsgid(mnt_userns, fs_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index fc2c6a404647..bf19c111771c 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -163,6 +163,7 @@ xfs_symlink(
 	struct xfs_dquot	*pdqp = NULL;
 	uint			resblks;
 	xfs_ino_t		ino;
+	struct user_namespace	*fs_userns = &init_user_ns;
 
 	*ipp = NULL;
 
@@ -184,8 +185,8 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, fs_userns),
+			mapped_fsgid(mnt_userns, fs_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b46fb111017b..6ccb0e7f8801 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1664,7 +1664,7 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 static inline void inode_fsuid_set(struct inode *inode,
 				   struct user_namespace *mnt_userns)
 {
-	inode->i_uid = mapped_fsuid(mnt_userns);
+	inode->i_uid = mapped_fsuid(mnt_userns, &init_user_ns);
 }
 
 /**
@@ -1678,7 +1678,7 @@ static inline void inode_fsuid_set(struct inode *inode,
 static inline void inode_fsgid_set(struct inode *inode,
 				   struct user_namespace *mnt_userns)
 {
-	inode->i_gid = mapped_fsgid(mnt_userns);
+	inode->i_gid = mapped_fsgid(mnt_userns, &init_user_ns);
 }
 
 /**
@@ -1699,10 +1699,10 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	kuid_t kuid;
 	kgid_t kgid;
 
-	kuid = mapped_fsuid(mnt_userns);
+	kuid = mapped_fsuid(mnt_userns, &init_user_ns);
 	if (!uid_valid(kuid))
 		return false;
-	kgid = mapped_fsgid(mnt_userns);
+	kgid = mapped_fsgid(mnt_userns, &init_user_ns);
 	if (!gid_valid(kgid))
 		return false;
 	return kuid_has_mapping(fs_userns, kuid) &&
diff --git a/include/linux/mnt_mapping.h b/include/linux/mnt_mapping.h
index f55b62fd27ae..40e3ad7ee795 100644
--- a/include/linux/mnt_mapping.h
+++ b/include/linux/mnt_mapping.h
@@ -196,6 +196,7 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
 /**
  * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
  * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
  * the caller's fsuid. A common example is initializing the i_uid field of
@@ -205,14 +206,16 @@ static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
  *
  * Return: the caller's current fsuid mapped up according to @mnt_userns.
  */
-static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
+static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
+				  struct user_namespace *fs_userns)
 {
-	return mapped_kuid_user(mnt_userns, &init_user_ns, current_fsuid());
+	return mapped_kuid_user(mnt_userns, fs_userns, current_fsuid());
 }
 
 /**
  * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
  * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
  * the caller's fsgid. A common example is initializing the i_gid field of
@@ -222,9 +225,10 @@ static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
  *
  * Return: the caller's current fsgid mapped up according to @mnt_userns.
  */
-static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
+static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns,
+				  struct user_namespace *fs_userns)
 {
-	return mapped_kgid_user(mnt_userns, &init_user_ns, current_fsgid());
+	return mapped_kgid_user(mnt_userns, fs_userns, current_fsgid());
 }
 
 #endif /* _LINUX_MNT_MAPPING_H */
-- 
2.30.2

