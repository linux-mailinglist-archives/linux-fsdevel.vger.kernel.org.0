Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28B66960E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbjAMLxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbjAMLw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C545B17412
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51ED4B8211C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC42C43392;
        Fri, 13 Jan 2023 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610613;
        bh=BORGmrR44/SPv3Eb54n8Uc5uppAbGzNIfjo18H+31zA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HZKllkF2OZ/IOb1fm4LZ+kGfcGCtPdOlBsrDUlQpBkp2CuXAjcbT5aRNTsofynev7
         vI7pSC2L6g6XnL4BE7HM967EZ0eRi+subjYrKve4SYq5Dk9AvdTpkQu9xoqDzq6FUh
         Soymi+NgSlvE1DnYaHz4VzVBVyee6n7L5OMJ5cLg5Tl3DYcbxPKGEh0DphW9RtAYba
         SXmrNUjCQyrtUboNpjsaer8xP1IZz8wXvtndvTuDE3/xFaAlDJgqAYBWRvScyy/nuf
         3m9nMobr06mTm5Sl9pquTy5t3Pi8B+pHUwV5bs03+ItePeOdK5c9/pcfKNctWf3OEU
         qLrj8f0oEcnQQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:27 +0100
Subject: [PATCH 19/25] fs: port privilege checking helpers to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-19-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=35093; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BORGmrR44/SPv3Eb54n8Uc5uppAbGzNIfjo18H+31zA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA05813/ztSkkkpn40dMd4sfT2eJCZs4R7s1Kivgg/AN
 nk79jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInctWL4XzonXFVt5/eSnhkrRHM+ev
 J/6ry+af32q2oVOici/r5kuMXwv7jMOECrOfwpH8OqIu+td26HnwoJCf+6jVu2YvqWiUtD+AA=
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
 fs/attr.c                  | 53 +++++++++++++++++++++++++---------------------
 fs/btrfs/ioctl.c           |  3 +--
 fs/exec.c                  |  3 +--
 fs/f2fs/acl.c              | 12 +++++------
 fs/f2fs/file.c             |  2 +-
 fs/fuse/acl.c              |  2 +-
 fs/fuse/file.c             |  3 ++-
 fs/inode.c                 | 20 +++++++++--------
 fs/internal.h              |  6 +++---
 fs/namei.c                 | 38 ++++++++++++++-------------------
 fs/ocfs2/file.c            |  4 ++--
 fs/ocfs2/namei.c           |  2 +-
 fs/open.c                  |  5 ++---
 fs/overlayfs/inode.c       |  2 +-
 fs/posix_acl.c             |  2 +-
 fs/xfs/xfs_ioctl.c         |  3 +--
 include/linux/capability.h |  4 ++--
 include/linux/fs.h         | 10 ++++-----
 kernel/capability.c        |  8 ++++---
 security/commoncap.c       |  5 ++---
 20 files changed, 93 insertions(+), 94 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bd8d542e13b9..2cadd055dbf2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -23,7 +23,7 @@
 /**
  * setattr_should_drop_sgid - determine whether the setgid bit needs to be
  *                            removed
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check
  *
  * This function determines whether the setgid bit needs to be removed.
@@ -33,16 +33,17 @@
  *
  * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
  */
-int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode = inode->i_mode;
 
 	if (!(mode & S_ISGID))
 		return 0;
 	if (mode & S_IXGRP)
 		return ATTR_KILL_SGID;
-	if (!in_group_or_capable(mnt_userns, inode,
+	if (!in_group_or_capable(idmap, inode,
 				 i_gid_into_vfsgid(mnt_userns, inode)))
 		return ATTR_KILL_SGID;
 	return 0;
@@ -51,7 +52,7 @@ int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
 /**
  * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
  *                               be dropped
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check
  *
  * This function determines whether the set{g,u}id bits need to be removed.
@@ -63,7 +64,7 @@ int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
  * Return: A mask of ATTR_KILL_S{G,U}ID indicating which - if any - setid bits
  * to remove, 0 otherwise.
  */
-int setattr_should_drop_suidgid(struct user_namespace *mnt_userns,
+int setattr_should_drop_suidgid(struct mnt_idmap *idmap,
 				struct inode *inode)
 {
 	umode_t mode = inode->i_mode;
@@ -73,7 +74,7 @@ int setattr_should_drop_suidgid(struct user_namespace *mnt_userns,
 	if (unlikely(mode & S_ISUID))
 		kill = ATTR_KILL_SUID;
 
-	kill |= setattr_should_drop_sgid(mnt_userns, inode);
+	kill |= setattr_should_drop_sgid(idmap, inode);
 
 	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
 		return kill;
@@ -84,24 +85,26 @@ EXPORT_SYMBOL(setattr_should_drop_suidgid);
 
 /**
  * chown_ok - verify permissions to chown inode
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check permissions on
  * @ia_vfsuid:	uid to chown @inode to
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
  */
-static bool chown_ok(struct user_namespace *mnt_userns,
+static bool chown_ok(struct mnt_idmap *idmap,
 		     const struct inode *inode, vfsuid_t ia_vfsuid)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid()) &&
 	    vfsuid_eq(ia_vfsuid, vfsuid))
 		return true;
-	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
 		return true;
 	if (!vfsuid_valid(vfsuid) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
@@ -111,19 +114,21 @@ static bool chown_ok(struct user_namespace *mnt_userns,
 
 /**
  * chgrp_ok - verify permissions to chgrp inode
- * @mnt_userns:	user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check permissions on
  * @ia_vfsgid:	gid to chown @inode to
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
  */
-static bool chgrp_ok(struct user_namespace *mnt_userns,
+static bool chgrp_ok(struct mnt_idmap *idmap,
 		     const struct inode *inode, vfsgid_t ia_vfsgid)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid())) {
@@ -132,7 +137,7 @@ static bool chgrp_ok(struct user_namespace *mnt_userns,
 		if (vfsgid_in_group_p(ia_vfsgid))
 			return true;
 	}
-	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
 		return true;
 	if (!vfsgid_valid(vfsgid) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
@@ -184,12 +189,12 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	/* Make sure a caller can chown. */
 	if ((ia_valid & ATTR_UID) &&
-	    !chown_ok(mnt_userns, inode, attr->ia_vfsuid))
+	    !chown_ok(idmap, inode, attr->ia_vfsuid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
 	if ((ia_valid & ATTR_GID) &&
-	    !chgrp_ok(mnt_userns, inode, attr->ia_vfsgid))
+	    !chgrp_ok(idmap, inode, attr->ia_vfsgid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
@@ -205,7 +210,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 			vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 
 		/* Also check the setgid bit! */
-		if (!in_group_or_capable(mnt_userns, inode, vfsgid))
+		if (!in_group_or_capable(idmap, inode, vfsgid))
 			attr->ia_mode &= ~S_ISGID;
 	}
 
@@ -316,7 +321,7 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-		if (!in_group_or_capable(mnt_userns, inode,
+		if (!in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(mnt_userns, inode)))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6affe071bdfd..5ba1ff31713b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -902,7 +902,6 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *victim, int isdir)
 {
 	int error;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (d_really_is_negative(victim))
 		return -ENOENT;
@@ -915,7 +914,7 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 		return error;
 	if (IS_APPEND(dir))
 		return -EPERM;
-	if (check_sticky(mnt_userns, dir, d_inode(victim)) ||
+	if (check_sticky(idmap, dir, d_inode(victim)) ||
 	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
 	    IS_SWAPFILE(d_inode(victim)))
 		return -EPERM;
diff --git a/fs/exec.c b/fs/exec.c
index 584d906a6c08..c6278141b467 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1415,7 +1415,6 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	if (inode_permission(idmap, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
@@ -1423,7 +1422,7 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
 		/* Ensure mm->user_ns contains the executable */
 		user_ns = old = bprm->mm->user_ns;
 		while ((user_ns != &init_user_ns) &&
-		       !privileged_wrt_inode_uidgid(user_ns, mnt_userns, inode))
+		       !privileged_wrt_inode_uidgid(user_ns, idmap, inode))
 			user_ns = user_ns->parent;
 
 		if (old != user_ns) {
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 6ced63bce4e4..dd5cea743036 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -204,11 +204,12 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type, bool rcu)
 	return __f2fs_get_acl(inode, type, NULL);
 }
 
-static int f2fs_acl_update_mode(struct user_namespace *mnt_userns,
+static int f2fs_acl_update_mode(struct mnt_idmap *idmap,
 				struct inode *inode, umode_t *mode_p,
 				struct posix_acl **acl)
 {
 	umode_t mode = inode->i_mode;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
 	if (is_inode_flag_set(inode, FI_ACL_MODE))
@@ -220,13 +221,13 @@ static int f2fs_acl_update_mode(struct user_namespace *mnt_userns,
 	if (error == 0)
 		*acl = NULL;
 	if (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
-	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
 }
 
-static int __f2fs_set_acl(struct user_namespace *mnt_userns,
+static int __f2fs_set_acl(struct mnt_idmap *idmap,
 			struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
@@ -240,7 +241,7 @@ static int __f2fs_set_acl(struct user_namespace *mnt_userns,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = f2fs_acl_update_mode(mnt_userns, inode,
+			error = f2fs_acl_update_mode(idmap, inode,
 								&mode, &acl);
 			if (error)
 				return error;
@@ -279,13 +280,12 @@ static int __f2fs_set_acl(struct user_namespace *mnt_userns,
 int f2fs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
-	return __f2fs_set_acl(mnt_userns, inode, type, acl, NULL);
+	return __f2fs_set_acl(idmap, inode, type, acl, NULL);
 }
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 33e6334bc0c6..b1486bdc83fb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -922,7 +922,7 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 		vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 
 		if (!vfsgid_in_group_p(vfsgid) &&
-		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		set_acl_inode(inode, mode);
 	}
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 4eb9adefa914..cbb066b22da2 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -100,7 +100,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		}
 
 		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
-		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 875314ee6f59..5cfd9fb06a5a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1313,7 +1313,8 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(&init_user_ns, file_inode(file))) {
+		    setattr_should_drop_suidgid(&nop_mnt_idmap,
+						file_inode(file))) {
 			goto writethrough;
 		}
 
diff --git a/fs/inode.c b/fs/inode.c
index 0a86c316937e..03f4eded2a35 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1953,7 +1953,7 @@ EXPORT_SYMBOL(touch_atime);
  * response to write or truncate. Return 0 if nothing has to be changed.
  * Negative value on error (change should be denied).
  */
-int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+int dentry_needs_remove_privs(struct mnt_idmap *idmap,
 			      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
@@ -1963,7 +1963,7 @@ int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
 	if (IS_NOSEC(inode))
 		return 0;
 
-	mask = setattr_should_drop_suidgid(mnt_userns, inode);
+	mask = setattr_should_drop_suidgid(idmap, inode);
 	ret = security_inode_need_killpriv(dentry);
 	if (ret < 0)
 		return ret;
@@ -1995,7 +1995,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
-	kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
+	kill = dentry_needs_remove_privs(file_mnt_idmap(file), dentry);
 	if (kill < 0)
 		return kill;
 
@@ -2461,7 +2461,7 @@ EXPORT_SYMBOL(current_time);
 
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
- * @mnt_userns: user namespace of the mount @inode was found from
+ * @idmap:	idmap of the mount @inode was found from
  * @inode:	inode to check
  * @vfsgid:	the new/current vfsgid of @inode
  *
@@ -2471,19 +2471,19 @@ EXPORT_SYMBOL(current_time);
  *
  * Return: true if the caller is sufficiently privileged, false if not.
  */
-bool in_group_or_capable(struct user_namespace *mnt_userns,
+bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid)
 {
 	if (vfsgid_in_group_p(vfsgid))
 		return true;
-	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+	if (capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 		return true;
 	return false;
 }
 
 /**
  * mode_strip_sgid - handle the sgid bit for non-directories
- * @mnt_userns: User namespace of the mount the inode was created from
+ * @idmap: idmap of the mount the inode was created from
  * @dir: parent directory inode
  * @mode: mode of the file to be created in @dir
  *
@@ -2495,14 +2495,16 @@ bool in_group_or_capable(struct user_namespace *mnt_userns,
  *
  * Return: the new mode to use for the file
  */
-umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 			const struct inode *dir, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
 		return mode;
 	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
 		return mode;
-	if (in_group_or_capable(mnt_userns, dir,
+	if (in_group_or_capable(idmap, dir,
 				i_gid_into_vfsgid(mnt_userns, dir)))
 		return mode;
 	return mode & ~S_ISGID;
diff --git a/fs/internal.h b/fs/internal.h
index a4996e86622f..9ac38b411679 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -150,8 +150,8 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-int dentry_needs_remove_privs(struct user_namespace *, struct dentry *dentry);
-bool in_group_or_capable(struct user_namespace *mnt_userns,
+int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
+bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
 
 /*
@@ -261,5 +261,5 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 /*
  * fs/attr.c
  */
-int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
diff --git a/fs/namei.c b/fs/namei.c
index 48dd44251dda..ed9e877f72c7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -398,7 +398,6 @@ int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 		       int mask)
 {
 	int ret;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/*
 	 * Do the basic permission checks.
@@ -410,10 +409,10 @@ int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
 		if (!(mask & MAY_WRITE))
-			if (capable_wrt_inode_uidgid(mnt_userns, inode,
+			if (capable_wrt_inode_uidgid(idmap, inode,
 						     CAP_DAC_READ_SEARCH))
 				return 0;
-		if (capable_wrt_inode_uidgid(mnt_userns, inode,
+		if (capable_wrt_inode_uidgid(idmap, inode,
 					     CAP_DAC_OVERRIDE))
 			return 0;
 		return -EACCES;
@@ -424,7 +423,7 @@ int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 	 */
 	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
 	if (mask == MAY_READ)
-		if (capable_wrt_inode_uidgid(mnt_userns, inode,
+		if (capable_wrt_inode_uidgid(idmap, inode,
 					     CAP_DAC_READ_SEARCH))
 			return 0;
 	/*
@@ -433,7 +432,7 @@ int generic_permission(struct mnt_idmap *idmap, struct inode *inode,
 	 * at least one exec bit set.
 	 */
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
-		if (capable_wrt_inode_uidgid(mnt_userns, inode,
+		if (capable_wrt_inode_uidgid(idmap, inode,
 					     CAP_DAC_OVERRIDE))
 			return 0;
 
@@ -2885,16 +2884,17 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
-int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
+int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode)
 {
 	kuid_t fsuid = current_fsuid();
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), fsuid))
 		return 0;
 	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, dir), fsuid))
 		return 0;
-	return !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FOWNER);
+	return !capable_wrt_inode_uidgid(idmap, inode, CAP_FOWNER);
 }
 EXPORT_SYMBOL(__check_sticky);
 
@@ -2944,7 +2944,7 @@ static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 	if (IS_APPEND(dir))
 		return -EPERM;
 
-	if (check_sticky(mnt_userns, dir, inode) || IS_APPEND(inode) ||
+	if (check_sticky(idmap, dir, inode) || IS_APPEND(inode) ||
 	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) ||
 	    HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
@@ -3050,7 +3050,7 @@ static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
 
 /**
  * vfs_prepare_mode - prepare the mode to be used for a new inode
- * @mnt_userns:		user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	parent directory of the new inode
  * @mode:	mode of the new inode
  * @mask_perms:	allowed permission by the vfs
@@ -3071,11 +3071,11 @@ static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
  *
  * Returns: mode to be passed to the filesystem
  */
-static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
+static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 				       const struct inode *dir, umode_t mode,
 				       umode_t mask_perms, umode_t type)
 {
-	mode = mode_strip_sgid(mnt_userns, dir, mode);
+	mode = mode_strip_sgid(idmap, dir, mode);
 	mode = mode_strip_umask(dir, mode);
 
 	/*
@@ -3107,7 +3107,6 @@ static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
 	error = may_create(idmap, dir, dentry);
@@ -3117,7 +3116,7 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (!dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 
-	mode = vfs_prepare_mode(mnt_userns, dir, mode, S_IALLUGO, S_IFREG);
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3329,7 +3328,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  bool got_write)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
@@ -3378,11 +3376,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (unlikely(!got_write))
 		open_flag &= ~O_TRUNC;
 	idmap = mnt_idmap(nd->path.mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -3600,7 +3597,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		       const struct path *parentpath,
 		       struct file *file, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dentry *child;
 	struct inode *dir = d_inode(parentpath->dentry);
 	struct inode *inode;
@@ -3618,7 +3614,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		return -ENOMEM;
 	file->f_path.mnt = parentpath->mnt;
 	file->f_path.dentry = child;
-	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
+	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(idmap, dir, file, mode);
 	dput(child);
 	if (error)
@@ -3902,7 +3898,6 @@ EXPORT_SYMBOL(user_path_create);
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode, dev_t dev)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
 
@@ -3916,7 +3911,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!dir->i_op->mknod)
 		return -EPERM;
 
-	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
+	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = devcgroup_inode_mknod(mode, dev);
 	if (error)
 		return error;
@@ -4029,7 +4024,6 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
 
@@ -4040,7 +4034,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!dir->i_op->mkdir)
 		return -EPERM;
 
-	mode = vfs_prepare_mode(mnt_userns, dir, mode, S_IRWXUGO | S_ISVTX, 0);
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
 		return error;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 7acc89f47a5a..805a95e35f4c 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1992,7 +1992,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		}
 	}
 
-	if (file && setattr_should_drop_suidgid(&init_user_ns, file_inode(file))) {
+	if (file && setattr_should_drop_suidgid(&nop_mnt_idmap, file_inode(file))) {
 		ret = __ocfs2_write_remove_suid(inode, di_bh);
 		if (ret) {
 			mlog_errno(ret);
@@ -2280,7 +2280,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 		 * inode. There's also the dinode i_size state which
 		 * can be lost via setattr during extending writes (we
 		 * set inode->i_size at the end of a write. */
-		if (setattr_should_drop_suidgid(&init_user_ns, inode)) {
+		if (setattr_should_drop_suidgid(&nop_mnt_idmap, inode)) {
 			if (meta_level == 0) {
 				ocfs2_inode_unlock_for_extent_tree(inode,
 								   &di_bh,
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 892d83576dae..9175dbc47201 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -197,7 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
-	mode = mode_strip_sgid(&init_user_ns, dir, mode);
+	mode = mode_strip_sgid(&nop_mnt_idmap, dir, mode);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
diff --git a/fs/open.c b/fs/open.c
index 94e2afb2c603..e9e5da4815a9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -39,7 +39,6 @@
 int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 		loff_t length, unsigned int time_attrs, struct file *filp)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int ret;
 	struct iattr newattrs;
 
@@ -55,7 +54,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	/* Remove suid, sgid, and file capabilities on truncate too */
-	ret = dentry_needs_remove_privs(mnt_userns, dentry);
+	ret = dentry_needs_remove_privs(idmap, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -729,7 +728,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_lock(inode);
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
-				     setattr_should_drop_sgid(mnt_userns, inode);
+				     setattr_should_drop_sgid(idmap, inode);
 	/* Continue to send actual fs values, not the mount values. */
 	error = security_path_chown(
 		path,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3ba3110243d1..4e56d0cb7cce 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -676,7 +676,7 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	 */
 	if (unlikely(inode->i_mode & S_ISGID) && type == ACL_TYPE_ACCESS &&
 	    !in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
+	    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID)) {
 		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
 
 		err = ovl_setattr(&nop_mnt_idmap, dentry, &iattr);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index ea2620050b40..64d108a83871 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -718,7 +718,7 @@ int posix_acl_update_mode(struct mnt_idmap *idmap,
 	if (error == 0)
 		*acl = NULL;
 	if (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
-	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 27c7876ff526..ca172e2a00ac 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1301,7 +1301,6 @@ xfs_fileattr_set(
 	struct dentry		*dentry,
 	struct fileattr		*fa)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct xfs_inode	*ip = XFS_I(d_inode(dentry));
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -1372,7 +1371,7 @@ xfs_fileattr_set(
 	 */
 
 	if ((VFS_I(ip)->i_mode & (S_ISUID|S_ISGID)) &&
-	    !capable_wrt_inode_uidgid(mnt_userns, VFS_I(ip), CAP_FSETID))
+	    !capable_wrt_inode_uidgid(idmap, VFS_I(ip), CAP_FSETID))
 		VFS_I(ip)->i_mode &= ~(S_ISUID|S_ISGID);
 
 	/* Change the ownerships and register project quota modifications */
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0a8ba82ef1af..03c2a613ad40 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -249,9 +249,9 @@ static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 #endif /* CONFIG_MULTIUSER */
 bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
-				 struct user_namespace *mnt_userns,
+				 struct mnt_idmap *idmap,
 				 const struct inode *inode);
-bool capable_wrt_inode_uidgid(struct user_namespace *mnt_userns,
+bool capable_wrt_inode_uidgid(struct mnt_idmap *idmap,
 			      const struct inode *inode, int cap);
 extern bool file_ns_capable(const struct file *file, struct user_namespace *ns, int cap);
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e6c76f308f5f..696540a86183 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2017,7 +2017,7 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
-umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 			const struct inode *dir, umode_t mode);
 
 /*
@@ -2917,7 +2917,7 @@ static inline int path_permission(const struct path *path, int mask)
 	return inode_permission(mnt_idmap(path->mnt),
 				d_inode(path->dentry), mask);
 }
-int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
+int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode);
 
 static inline bool execute_ok(struct inode *inode)
@@ -3105,7 +3105,7 @@ extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
-extern int setattr_should_drop_suidgid(struct user_namespace *, struct inode *);
+extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
 extern int file_remove_privs(struct file *);
 
 /*
@@ -3539,13 +3539,13 @@ static inline bool is_sxid(umode_t mode)
 	return mode & (S_ISUID | S_ISGID);
 }
 
-static inline int check_sticky(struct user_namespace *mnt_userns,
+static inline int check_sticky(struct mnt_idmap *idmap,
 			       struct inode *dir, struct inode *inode)
 {
 	if (!(dir->i_mode & S_ISVTX))
 		return 0;
 
-	return __check_sticky(mnt_userns, dir, inode);
+	return __check_sticky(idmap, dir, inode);
 }
 
 static inline void inode_has_no_xattr(struct inode *inode)
diff --git a/kernel/capability.c b/kernel/capability.c
index 860fd22117c1..509a9cfb29f2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -486,9 +486,11 @@ EXPORT_SYMBOL(file_ns_capable);
  * Return true if the inode uid and gid are within the namespace.
  */
 bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
-				 struct user_namespace *mnt_userns,
+				 struct mnt_idmap *idmap,
 				 const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+
 	return vfsuid_has_mapping(ns, i_uid_into_vfsuid(mnt_userns, inode)) &&
 	       vfsgid_has_mapping(ns, i_gid_into_vfsgid(mnt_userns, inode));
 }
@@ -502,13 +504,13 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
  * its own user namespace and that the given inode's uid and gid are
  * mapped into the current user namespace.
  */
-bool capable_wrt_inode_uidgid(struct user_namespace *mnt_userns,
+bool capable_wrt_inode_uidgid(struct mnt_idmap *idmap,
 			      const struct inode *inode, int cap)
 {
 	struct user_namespace *ns = current_user_ns();
 
 	return ns_capable(ns, cap) &&
-	       privileged_wrt_inode_uidgid(ns, mnt_userns, inode);
+	       privileged_wrt_inode_uidgid(ns, idmap, inode);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
 
diff --git a/security/commoncap.c b/security/commoncap.c
index b70ba98fbd1c..beda11fa50f9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -546,7 +546,7 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!validheader(size, cap))
 		return -EINVAL;
-	if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
+	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
 	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
@@ -1039,7 +1039,6 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name)
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	/* Ignore non-security xattrs */
 	if (strncmp(name, XATTR_SECURITY_PREFIX,
@@ -1051,7 +1050,7 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 		struct inode *inode = d_backing_inode(dentry);
 		if (!inode)
 			return -EINVAL;
-		if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
+		if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 			return -EPERM;
 		return 0;
 	}

-- 
2.34.1

