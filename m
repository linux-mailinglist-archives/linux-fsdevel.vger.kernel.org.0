Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360F66962D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjAMLyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbjAMLw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471243F10C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9866F616A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF1FC433EF;
        Fri, 13 Jan 2023 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610619;
        bh=GPnatmD/vWIp+6PUD1X8AV+huuB5HFFll7DD1Crcg7U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=C/ZkajSS3shzBqwsYCKRJSKXhxGJeGjPkJqyLJ+eX97Dg36vBCb7lO9EQz+v8DA8p
         6Os7o1UFnCIgl0WDl34reX3Am/E2NKfuuokpPb+FmTNucJjd9uSiN6q8DWqOcSAjqb
         +/n8FPvTvI2mmBQ9Ibkn8NNK3h4A42byEupeZH/F4JSj1Mei6W5vYW1Ub8d8w5PdMf
         SyYZRtyUoSvct7/81FZl/Fa6xF+jfPttSNjawOHl1/0CAD4cj7eQr1HX7pkftGAF37
         gYostqveCONRumC0X/sb23q1l3DhmzRYDi2x/qWv8OTLHRxFWv+NKxM4/JscCZl0C1
         QO2/FrePS2Lfw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:31 +0100
Subject: [PATCH 23/25] fs: port fs{g,u}id helpers to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-23-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=10441; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GPnatmD/vWIp+6PUD1X8AV+huuB5HFFll7DD1Crcg7U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA3R+dv9oO977Jf87V/+L9h+Uz4m9vOv4ztlmD0VpLsZ
 OHe+7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIsXWMDOdkUzO490y3zA6KVnJo7O
 KUY136wX6a+PLdWh/tmO982snIMOFcRHuwQkU7q+bVzcy23vbdXDJCzLoN6Z9Y5tj16d7kBwA=
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
 fs/ext4/ialloc.c              |  3 +--
 fs/inode.c                    |  6 ++----
 fs/xfs/xfs_inode.c            | 13 +++++--------
 fs/xfs/xfs_symlink.c          |  5 ++---
 include/linux/fs.h            | 21 ++++++++++-----------
 include/linux/mnt_idmapping.h | 18 ++++++++++--------
 6 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 1024b0c02431..157663031f8c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -943,7 +943,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	ext4_group_t flex_group;
 	struct ext4_group_info *grp = NULL;
 	bool encrypt = false;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
@@ -973,7 +972,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		i_gid_write(inode, owner[1]);
 	} else if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
-		inode_fsuid_set(inode, mnt_userns);
+		inode_fsuid_set(inode, idmap);
 		inode->i_gid = dir->i_gid;
 	} else
 		inode_init_owner(idmap, inode, dir, mode);
diff --git a/fs/inode.c b/fs/inode.c
index 1aec92141fab..1b05e0e4b5c8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2293,9 +2293,7 @@ EXPORT_SYMBOL(init_special_inode);
 void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 		      const struct inode *dir, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	inode_fsuid_set(inode, mnt_userns);
+	inode_fsuid_set(inode, idmap);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2303,7 +2301,7 @@ void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else
-		inode_fsgid_set(inode, mnt_userns);
+		inode_fsgid_set(inode, idmap);
 	inode->i_mode = mode;
 }
 EXPORT_SYMBOL(inode_init_owner);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 59fb064e2df3..7f1d715faab5 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -788,7 +788,6 @@ xfs_init_new_inode(
 	bool			init_xattrs,
 	struct xfs_inode	**ipp)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode		*dir = pip ? VFS_I(pip) : NULL;
 	struct xfs_mount	*mp = tp->t_mountp;
 	struct xfs_inode	*ip;
@@ -824,7 +823,7 @@ xfs_init_new_inode(
 	ip->i_projid = prid;
 
 	if (dir && !(dir->i_mode & S_ISGID) && xfs_has_grpid(mp)) {
-		inode_fsuid_set(inode, mnt_userns);
+		inode_fsuid_set(inode, idmap);
 		inode->i_gid = dir->i_gid;
 		inode->i_mode = mode;
 	} else {
@@ -955,7 +954,6 @@ xfs_create(
 	bool			init_xattrs,
 	xfs_inode_t		**ipp)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	int			is_dir = S_ISDIR(mode);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_inode	*ip = NULL;
@@ -980,8 +978,8 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
+			mapped_fsgid(idmap, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1109,7 +1107,6 @@ xfs_create_tmpfile(
 	umode_t			mode,
 	struct xfs_inode	**ipp)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_inode	*ip = NULL;
 	struct xfs_trans	*tp = NULL;
@@ -1130,8 +1127,8 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
+			mapped_fsgid(idmap, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 24cf0a16bf35..85e433df6a3f 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -151,7 +151,6 @@ xfs_symlink(
 	umode_t			mode,
 	struct xfs_inode	**ipp)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans	*tp = NULL;
 	struct xfs_inode	*ip = NULL;
@@ -194,8 +193,8 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(idmap, &init_user_ns),
+			mapped_fsgid(idmap, &init_user_ns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 173c5274a63a..54a95ed68322 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1744,29 +1744,29 @@ static inline void i_gid_update(struct mnt_idmap *idmap,
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  *
  * Initialize the i_uid field of @inode. If the inode was found/created via
- * an idmapped mount map the caller's fsuid according to @mnt_users.
+ * an idmapped mount map the caller's fsuid according to @idmap.
  */
 static inline void inode_fsuid_set(struct inode *inode,
-				   struct user_namespace *mnt_userns)
+				   struct mnt_idmap *idmap)
 {
-	inode->i_uid = mapped_fsuid(mnt_userns, i_user_ns(inode));
+	inode->i_uid = mapped_fsuid(idmap, i_user_ns(inode));
 }
 
 /**
  * inode_fsgid_set - initialize inode's i_gid field with callers fsgid
  * @inode: inode to initialize
- * @mnt_userns: user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  *
  * Initialize the i_gid field of @inode. If the inode was found/created via
- * an idmapped mount map the caller's fsgid according to @mnt_users.
+ * an idmapped mount map the caller's fsgid according to @idmap.
  */
 static inline void inode_fsgid_set(struct inode *inode,
-				   struct user_namespace *mnt_userns)
+				   struct mnt_idmap *idmap)
 {
-	inode->i_gid = mapped_fsgid(mnt_userns, i_user_ns(inode));
+	inode->i_gid = mapped_fsgid(idmap, i_user_ns(inode));
 }
 
 /**
@@ -1784,14 +1784,13 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 					struct mnt_idmap *idmap)
 {
 	struct user_namespace *fs_userns = sb->s_user_ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	kuid_t kuid;
 	kgid_t kgid;
 
-	kuid = mapped_fsuid(mnt_userns, fs_userns);
+	kuid = mapped_fsuid(idmap, fs_userns);
 	if (!uid_valid(kuid))
 		return false;
-	kgid = mapped_fsgid(mnt_userns, fs_userns);
+	kgid = mapped_fsgid(idmap, fs_userns);
 	if (!gid_valid(kgid))
 		return false;
 	return kuid_has_mapping(fs_userns, kuid) &&
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 0ccca33a7a6d..d63e7c84a389 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -375,8 +375,8 @@ static inline kgid_t vfsgid_into_kgid(vfsgid_t vfsgid)
 }
 
 /**
- * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
- * @mnt_userns: the mount's idmapping
+ * mapped_fsuid - return caller's fsuid mapped according to an idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
@@ -385,18 +385,19 @@ static inline kgid_t vfsgid_into_kgid(vfsgid_t vfsgid)
  * O_CREAT. Other examples include the allocation of quotas for a specific
  * user.
  *
- * Return: the caller's current fsuid mapped up according to @mnt_userns.
+ * Return: the caller's current fsuid mapped up according to @idmap.
  */
-static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
+static inline kuid_t mapped_fsuid(struct mnt_idmap *idmap,
 				  struct user_namespace *fs_userns)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return from_vfsuid(mnt_userns, fs_userns,
 			   VFSUIDT_INIT(current_fsuid()));
 }
 
 /**
- * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
- * @mnt_userns: the mount's idmapping
+ * mapped_fsgid - return caller's fsgid mapped according to an idmapping
+ * @idmap: the mount's idmapping
  * @fs_userns: the filesystem's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
@@ -405,11 +406,12 @@ static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns,
  * O_CREAT. Other examples include the allocation of quotas for a specific
  * user.
  *
- * Return: the caller's current fsgid mapped up according to @mnt_userns.
+ * Return: the caller's current fsgid mapped up according to @idmap.
  */
-static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns,
+static inline kgid_t mapped_fsgid(struct mnt_idmap *idmap,
 				  struct user_namespace *fs_userns)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return from_vfsgid(mnt_userns, fs_userns,
 			   VFSGIDT_INIT(current_fsgid()));
 }

-- 
2.34.1

