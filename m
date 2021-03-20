Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADF342CC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 13:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTM1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 08:27:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCTM0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:26:47 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNagk-0004Pf-9S; Sat, 20 Mar 2021 12:26:42 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/4] fs: document and rename fsid helpers
Date:   Sat, 20 Mar 2021 13:26:22 +0100
Message-Id: <20210320122623.599086-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210320122623.599086-1-christian.brauner@ubuntu.com>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek pointed out that the fs{g,u}id_into_mnt() naming scheme can be
misleading as it could be understood as implying they do the exact same
thing as i_{g,u}id_into_mnt(). The original motivation for this naming
scheme was to signal to callers that the helpers will always take care
to map the k{g,u}id such that the ownership is expressed in terms of the
mnt_users.
Get rid of the confusion by renaming those helpers to something more
sensible. Al suggested mapped_fs{g,u}id() which seems a really good fit.
Usually filesystems don't need to bother with these helpers directly
only in some cases where they allocate objects that carry {g,u}ids which
are either filesystem specific (e.g. xfs quota objects) or don't have a
clean set of helpers as inodes have.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Inspired-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Add kernel docs to helpers.

- Al Viro <viro@zeniv.linux.org.uk>:
  - s/idmapped_{fsuid,fsgid}/mapped_{fsuid,fsgid}/g
---
 fs/ext4/ialloc.c     |  2 +-
 fs/inode.c           |  4 ++--
 fs/namei.c           |  8 ++++----
 fs/xfs/xfs_inode.c   | 10 +++++-----
 fs/xfs/xfs_symlink.c |  4 ++--
 include/linux/fs.h   | 28 ++++++++++++++++++++++++++--
 6 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 633ae7becd61..d0dc12197346 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -970,7 +970,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		i_gid_write(inode, owner[1]);
 	} else if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
-		inode->i_uid = fsuid_into_mnt(mnt_userns);
+		inode->i_uid = mapped_fsuid(mnt_userns);
 		inode->i_gid = dir->i_gid;
 	} else
 		inode_init_owner(mnt_userns, inode, dir, mode);
diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..81a6a59b7dd3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2148,7 +2148,7 @@ EXPORT_SYMBOL(init_special_inode);
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode)
 {
-	inode->i_uid = fsuid_into_mnt(mnt_userns);
+	inode->i_uid = mapped_fsuid(mnt_userns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2160,7 +2160,7 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
-		inode->i_gid = fsgid_into_mnt(mnt_userns);
+		inode->i_gid = mapped_fsgid(mnt_userns);
 	inode->i_mode = mode;
 }
 EXPORT_SYMBOL(inode_init_owner);
diff --git a/fs/namei.c b/fs/namei.c
index 216f16e74351..6b5424d34962 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2830,8 +2830,8 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
 	s_user_ns = dir->i_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
-	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
+	if (!kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) ||
+	    !kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns)))
 		return -EOVERFLOW;
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
@@ -3040,8 +3040,8 @@ static int may_o_create(struct user_namespace *mnt_userns,
 		return error;
 
 	s_user_ns = dir->dentry->d_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
-	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
+	if (!kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) ||
+	    !kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns)))
 		return -EOVERFLOW;
 
 	error = inode_permission(mnt_userns, dir->dentry->d_inode,
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f93370bd7b1e..dc91f8c34d35 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -812,7 +812,7 @@ xfs_init_new_inode(
 
 	if (dir && !(dir->i_mode & S_ISGID) &&
 	    (mp->m_flags & XFS_MOUNT_GRPID)) {
-		inode->i_uid = fsuid_into_mnt(mnt_userns);
+		inode->i_uid = mapped_fsuid(mnt_userns);
 		inode->i_gid = dir->i_gid;
 		inode->i_mode = mode;
 	} else {
@@ -1007,8 +1007,8 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
+			mapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1158,8 +1158,8 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
+			mapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 7f368b10ded1..63edb4dbed4a 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -182,8 +182,8 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
+			mapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4795a632ef0d..c8603969d21f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1658,12 +1658,36 @@ static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
 	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
 }
 
-static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
+/**
+ * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ *
+ * Return the caller's current fsuid mapped up according to @mnt_userns.
+ *
+ * Use this helper to initialize a new vfs or filesystem object based on
+ * the caller's fsuid. A common example is initializing the i_uid field of
+ * a newly allocated inode triggered by a creation event such as mkdir or
+ * O_CREAT. Other examples include the allocation of quotas for a specific
+ * user.
+ */
+static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
 {
 	return kuid_from_mnt(mnt_userns, current_fsuid());
 }
 
-static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
+/**
+ * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ *
+ * Return the caller's current fsgid mapped up according to @mnt_userns.
+ *
+ * Use this helper to initialize a new vfs or filesystem object based on
+ * the caller's fsgid. A common example is initializing the i_gid field of
+ * a newly allocated inode triggered by a creation event such as mkdir or
+ * O_CREAT. Other examples include the allocation of quotas for a specific
+ * user.
+ */
+static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
 {
 	return kgid_from_mnt(mnt_userns, current_fsgid());
 }
-- 
2.27.0

