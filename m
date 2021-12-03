Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530F646760F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380343AbhLCLVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47882 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380338AbhLCLVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD7B2B826A9
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B481C53FAD;
        Fri,  3 Dec 2021 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530270;
        bh=KyJqZQJAJ3dNdk7dApzDGKaTyNSu1TBobl2f127by9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moQriyMjJbVjlkCKy6db91qY0qlRusv1WFxxGMIaTKr8S1nbmEk4mPkGPE+ni08YO
         sHeweG0wP+srAnYu77Qn3Ax/k8EWKPvYwWmLyIPQK8TG76saMqVuapHwZS/1peaUfQ
         QLMu6zeh8vGsfd3+OTGjMrqA1njtfsw3LkO/Y+SGrqpQfXJgtkCj0lvWIaQVEg3JKg
         9j8PIA1UMkw9vqD52AVG8PvhIz7hf57RsXAJXTgg8D+PDnRTAkL2IR1bsUArBF4saC
         6L02ntVKWiKFm6FlnSc66jdOhkdADg16ucIaJ5wX3B1Smsb/ATcup9+LUmgLn3Opds
         NG+cQ8tbpr2ng==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 08/10] fs: port higher-level mapping helpers
Date:   Fri,  3 Dec 2021 12:17:05 +0100
Message-Id: <20211203111707.3901969-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6134; h=from:subject; bh=48VsC7kaV3NbMUgXYordVTg4oyONn3GI3bw65+haP3w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DP9wcyolKtGr899e5Dfbexp3O+96dapmzviBP5/vLf+ S4X4+45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJLNrH8Ff0kJXEX3WXvXMvd2zo6P j5UdJmTj+Pa9oDj3LJqSYLZtgx/NMzyDh4++ZBMZWWG8rBRjuC1H5VN388p5eUdfzLT70tCzkB
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

Link: https://lore.kernel.org/r/20211123114227.3124056-9-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-9-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Amir Goldstein <amir73il@gmail.com>:
  - Avoid using local variable and simply pass down initial idmapping
    directly.

/* v3 */
unchanged
---
 fs/xfs/xfs_inode.c            |  8 ++++----
 fs/xfs/xfs_symlink.c          |  4 ++--
 include/linux/fs.h            |  8 ++++----
 include/linux/mnt_idmapping.h | 12 ++++++++----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 64b9bf334806..5ca689459bed 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -988,8 +988,8 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
+			mapped_fsgid(mnt_userns, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1142,8 +1142,8 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
+			mapped_fsgid(mnt_userns, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index fc2c6a404647..a31d2e5d0321 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -184,8 +184,8 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
-			mapped_fsgid(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
+			mapped_fsgid(mnt_userns, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 57aee6ebba72..e1f28f757f1b 100644
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
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index c4b604a0c256..afd9bde6ba0d 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
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

