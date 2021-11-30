Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9B4633F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbhK3MOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbhK3MOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:14:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE00C061746
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 04:11:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8BF3CCE1929
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 12:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3EBC53FC1;
        Tue, 30 Nov 2021 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274268;
        bh=oiI47GK858N3JkUejhkig6/zYQtZ7t4/1ZVQ0FLS+4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soQyHRJcc0pZPgcDXIpLvlPYiQIL+kOWcu07EQuZZ7nhDH6NGPWkeVKmfq2XcAUbb
         1fh6lh7s/AudCJpDbW97Zs9yOrS+xu2+WvxejlRQqTXIrt09IOJbcv0kx/9YfEeGsO
         oG157j2wO1n+v7BeB+xMBXPHpQDD6vGIhKW6bfAQRpav1tsdIJBcX1AdvL8lEp/uxb
         6zLteVNHH1jM+iUyZcmSwg8+dh8p9JI8xzBL7kFq8Cs59v2gvbPNNNyYrPP8hz45N2
         wS0sdjQ8vsvkg4g2Sa//QtBwF6ac8uhnUpRm7xlXg81776FoD6yT+88ReudJDxH7zP
         vQudRVW2hS73Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 08/10] fs: port higher-level mapping helpers
Date:   Tue, 30 Nov 2021 13:10:30 +0100
Message-Id: <20211130121032.3753852-9-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130121032.3753852-1-brauner@kernel.org>
References: <20211130121032.3753852-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5974; h=from:subject; bh=acxMyQ5j0Ukg9Bt9b+d1TQVhsLUNMwhGp4HgYI+WOLI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQuE1mlcPrMNzvm/woeUg1r/v+zU/tiaZ/Cb9jG8/S/9B52 SWG/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl48TL8j1HjnDLDrvo974KqtfP+G7 H43vz/OGjvzbV2twOms+SGqjEyvPnzsKijQ+TDxep9obOrRFjeNXpOi1ZSX/D0gFdT9SNbRgA=
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
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Amir Goldstein <amir73il@gmail.com>:
  - Avoid using local variable and simply pass down initial idmapping
    directly.
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
index 25de7f6ecd81..7c0499b63a02 100644
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

