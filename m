Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF825669632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjAMLyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjAMLw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D03E0CD
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D20BDB82131
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FA0C433F0;
        Fri, 13 Jan 2023 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610617;
        bh=/u0Wcm3hEJ1uG+ucY++ONitx1AHznsQn9PGaLso7kIU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nRL8AahtPu+qTE5nJ9UhskSVLNapzNVNp8IhrwqhwDPlaKEM5gr+++Ze0U3ChaHAd
         Nyq8cyxYcc/eq/nNBBDOQ287ZNx6VGt0iLqZy8vPo+6asCuFcLhoZPsiz8AsC1JO05
         n3omrTKVH968EbL3t/TMIn0pLuGhlOBgQJIqyHQ9+R+qX2YjU4sDeNPwdWqot51dUf
         md9WuVXYcpANowNv5rrY5DUoptPOxwteYCpOZOlGkV8PLdVYqWz8I2JT/6y/yDJpLy
         o9+5uoLmh6mZ0HgCEPNxBh4KdTBsQKivfZU9mpdLlY9FVB1WaO2b1Yi1Mq+d5V2vVk
         1vUsRED4AuHcw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:30 +0100
Subject: [PATCH 22/25] fs: port i_{g,u}id_into_vfs{g,u}id() to mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-22-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=45976; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/u0Wcm3hEJ1uG+ucY++ONitx1AHznsQn9PGaLso7kIU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA25s3x3I/sr9dsX1KWVyrjqbbn1v6je8F1ncu+03ZQb
 JjdWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8j/DX9mUX6vvMzDmXHS8LJmV0e
 UqYfTjy8eU5Z7iHOXnryuITmP477D/7QPmM78d9xxdyhmkM3FZIaugWkvi2dd3BAL4z8oe4AAA
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
Remove legacy file_mnt_user_ns() and mnt_user_ns().

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
 fs/attr.c                           | 24 ++++++------------
 fs/coredump.c                       |  4 +--
 fs/exec.c                           |  8 +++---
 fs/f2fs/acl.c                       |  3 +--
 fs/f2fs/file.c                      |  3 +--
 fs/f2fs/recovery.c                  |  4 +--
 fs/fat/file.c                       |  8 +++---
 fs/fuse/acl.c                       |  2 +-
 fs/inode.c                          |  8 ++----
 fs/ksmbd/ndr.c                      |  6 ++---
 fs/ksmbd/ndr.h                      |  2 +-
 fs/ksmbd/oplock.c                   |  6 ++---
 fs/ksmbd/smb2pdu.c                  | 16 ++++++------
 fs/ksmbd/vfs.c                      |  4 +--
 fs/namei.c                          | 50 ++++++++++++++++---------------------
 fs/namespace.c                      | 26 -------------------
 fs/overlayfs/util.c                 |  8 +++---
 fs/posix_acl.c                      |  7 +++---
 fs/remap_range.c                    |  3 +--
 fs/stat.c                           |  6 ++---
 fs/xfs/xfs_inode.c                  |  2 +-
 fs/xfs/xfs_ioctl.c                  |  4 +--
 fs/xfs/xfs_ioctl32.c                |  2 +-
 fs/xfs/xfs_iops.c                   |  5 ++--
 fs/xfs/xfs_itable.c                 | 14 +++++------
 fs/xfs/xfs_itable.h                 |  2 +-
 include/linux/fs.h                  | 37 +++++++++++----------------
 include/linux/mount.h               |  1 -
 kernel/capability.c                 |  6 ++---
 security/apparmor/domain.c          |  2 +-
 security/apparmor/file.c            |  2 +-
 security/apparmor/lsm.c             | 16 ++++++------
 security/integrity/ima/ima_policy.c |  5 ++--
 33 files changed, 113 insertions(+), 183 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bbb9118c6c8b..a627ac74c4b1 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -36,15 +36,13 @@
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode = inode->i_mode;
 
 	if (!(mode & S_ISGID))
 		return 0;
 	if (mode & S_IXGRP)
 		return ATTR_KILL_SGID;
-	if (!in_group_or_capable(idmap, inode,
-				 i_gid_into_vfsgid(mnt_userns, inode)))
+	if (!in_group_or_capable(idmap, inode, i_gid_into_vfsgid(idmap, inode)))
 		return ATTR_KILL_SGID;
 	return 0;
 }
@@ -98,9 +96,7 @@ EXPORT_SYMBOL(setattr_should_drop_suidgid);
 static bool chown_ok(struct mnt_idmap *idmap,
 		     const struct inode *inode, vfsuid_t ia_vfsuid)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid()) &&
 	    vfsuid_eq(ia_vfsuid, vfsuid))
 		return true;
@@ -127,10 +123,8 @@ static bool chown_ok(struct mnt_idmap *idmap,
 static bool chgrp_ok(struct mnt_idmap *idmap,
 		     const struct inode *inode, vfsgid_t ia_vfsgid)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid())) {
 		if (vfsgid_eq(ia_vfsgid, vfsgid))
 			return true;
@@ -169,7 +163,6 @@ static bool chgrp_ok(struct mnt_idmap *idmap,
 int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		    struct iattr *attr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -207,7 +200,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (ia_valid & ATTR_GID)
 			vfsgid = attr->ia_vfsgid;
 		else
-			vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+			vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 		/* Also check the setgid bit! */
 		if (!in_group_or_capable(idmap, inode, vfsgid))
@@ -308,7 +301,6 @@ EXPORT_SYMBOL(inode_newsize_ok);
 void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 		  const struct iattr *attr)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int ia_valid = attr->ia_valid;
 
 	i_uid_update(idmap, attr, inode);
@@ -322,7 +314,7 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
-					 i_gid_into_vfsgid(mnt_userns, inode)))
+					 i_gid_into_vfsgid(idmap, inode)))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
@@ -473,10 +465,10 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * gids unless those uids & gids are being made valid.
 	 */
 	if (!(ia_valid & ATTR_UID) &&
-	    !vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)))
+	    !vfsuid_valid(i_uid_into_vfsuid(idmap, inode)))
 		return -EOVERFLOW;
 	if (!(ia_valid & ATTR_GID) &&
-	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
+	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
 		return -EOVERFLOW;
 
 	error = security_inode_setattr(idmap, dentry, attr);
diff --git a/fs/coredump.c b/fs/coredump.c
index 27847d16d2b8..b31ea0f87ccb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -645,7 +645,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 	} else {
 		struct mnt_idmap *idmap;
-		struct user_namespace *mnt_userns;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
@@ -724,8 +723,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * filesystem.
 		 */
 		idmap = file_mnt_idmap(cprm.file);
-		mnt_userns = mnt_idmap_owner(idmap);
-		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
+		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
 				    current_fsuid())) {
 			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
 					    cn.corename);
diff --git a/fs/exec.c b/fs/exec.c
index c6278141b467..3d2b80d8d58e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1596,7 +1596,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 {
 	/* Handle suid and sgid on files */
-	struct user_namespace *mnt_userns;
+	struct mnt_idmap *idmap;
 	struct inode *inode = file_inode(file);
 	unsigned int mode;
 	vfsuid_t vfsuid;
@@ -1612,15 +1612,15 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	if (!(mode & (S_ISUID|S_ISGID)))
 		return;
 
-	mnt_userns = file_mnt_user_ns(file);
+	idmap = file_mnt_idmap(file);
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
 	/* reload atomically mode/uid/gid now that lock held */
 	mode = inode->i_mode;
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
-	vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid = i_gid_into_vfsgid(idmap, inode);
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index dd5cea743036..ec2aeccb69a3 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -209,7 +209,6 @@ static int f2fs_acl_update_mode(struct mnt_idmap *idmap,
 				struct posix_acl **acl)
 {
 	umode_t mode = inode->i_mode;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error;
 
 	if (is_inode_flag_set(inode, FI_ACL_MODE))
@@ -220,7 +219,7 @@ static int f2fs_acl_update_mode(struct mnt_idmap *idmap,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
+	if (!vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
 	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 577c1613b6cf..48ed2d0c8543 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -907,7 +907,6 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 			   struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
@@ -919,7 +918,7 @@ static void __setattr_copy(struct mnt_idmap *idmap,
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-		vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 		if (!vfsgid_in_group_p(vfsgid) &&
 		    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index ac0149e0e98c..dfd41908b12d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -258,9 +258,9 @@ static int recover_quota_data(struct inode *inode, struct page *page)
 	attr.ia_vfsuid = VFSUIDT_INIT(make_kuid(inode->i_sb->s_user_ns, i_uid));
 	attr.ia_vfsgid = VFSGIDT_INIT(make_kgid(inode->i_sb->s_user_ns, i_gid));
 
-	if (!vfsuid_eq(attr.ia_vfsuid, i_uid_into_vfsuid(&init_user_ns, inode)))
+	if (!vfsuid_eq(attr.ia_vfsuid, i_uid_into_vfsuid(&nop_mnt_idmap, inode)))
 		attr.ia_valid |= ATTR_UID;
-	if (!vfsgid_eq(attr.ia_vfsgid, i_gid_into_vfsgid(&init_user_ns, inode)))
+	if (!vfsgid_eq(attr.ia_vfsgid, i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
 		attr.ia_valid |= ATTR_GID;
 
 	if (!attr.ia_valid)
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 32c04fdf7275..b48ad8acd2c5 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -456,14 +456,14 @@ static int fat_sanitize_mode(const struct msdos_sb_info *sbi,
 	return 0;
 }
 
-static int fat_allow_set_time(struct user_namespace *mnt_userns,
+static int fat_allow_set_time(struct mnt_idmap *idmap,
 			      struct msdos_sb_info *sbi, struct inode *inode)
 {
 	umode_t allow_utime = sbi->options.allow_utime;
 
-	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
+	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
 			    current_fsuid())) {
-		if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)))
+		if (vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return 1;
@@ -489,7 +489,7 @@ int fat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Check for setting the inode time. */
 	ia_valid = attr->ia_valid;
 	if (ia_valid & TIMES_SET_FLAGS) {
-		if (fat_allow_set_time(mnt_userns, sbi, inode))
+		if (fat_allow_set_time(idmap, sbi, inode))
 			attr->ia_valid &= ~TIMES_SET_FLAGS;
 	}
 
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index cbb066b22da2..23d1c263891f 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -99,7 +99,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			return ret;
 		}
 
-		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&init_user_ns, inode)) &&
+		if (!vfsgid_in_group_p(i_gid_into_vfsgid(&nop_mnt_idmap, inode)) &&
 		    !capable_wrt_inode_uidgid(&nop_mnt_idmap, inode, CAP_FSETID))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
diff --git a/fs/inode.c b/fs/inode.c
index 03f4eded2a35..1aec92141fab 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2327,9 +2327,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 {
 	vfsuid_t vfsuid;
 	struct user_namespace *ns;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
 		return true;
 
@@ -2498,14 +2497,11 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
 umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 			const struct inode *dir, umode_t mode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
 		return mode;
 	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
 		return mode;
-	if (in_group_or_capable(idmap, dir,
-				i_gid_into_vfsgid(mnt_userns, dir)))
+	if (in_group_or_capable(idmap, dir, i_gid_into_vfsgid(idmap, dir)))
 		return mode;
 	return mode & ~S_ISGID;
 }
diff --git a/fs/ksmbd/ndr.c b/fs/ksmbd/ndr.c
index 0ae8d08d85a8..0c6717fb4656 100644
--- a/fs/ksmbd/ndr.c
+++ b/fs/ksmbd/ndr.c
@@ -338,7 +338,7 @@ static int ndr_encode_posix_acl_entry(struct ndr *n, struct xattr_smb_acl *acl)
 }
 
 int ndr_encode_posix_acl(struct ndr *n,
-			 struct user_namespace *user_ns,
+			 struct mnt_idmap *idmap,
 			 struct inode *inode,
 			 struct xattr_smb_acl *acl,
 			 struct xattr_smb_acl *def_acl)
@@ -374,11 +374,11 @@ int ndr_encode_posix_acl(struct ndr *n,
 	if (ret)
 		return ret;
 
-	vfsuid = i_uid_into_vfsuid(user_ns, inode);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	ret = ndr_write_int64(n, from_kuid(&init_user_ns, vfsuid_into_kuid(vfsuid)));
 	if (ret)
 		return ret;
-	vfsgid = i_gid_into_vfsgid(user_ns, inode);
+	vfsgid = i_gid_into_vfsgid(idmap, inode);
 	ret = ndr_write_int64(n, from_kgid(&init_user_ns, vfsgid_into_kgid(vfsgid)));
 	if (ret)
 		return ret;
diff --git a/fs/ksmbd/ndr.h b/fs/ksmbd/ndr.h
index 60ca265d1bb0..f3c108c8cf4d 100644
--- a/fs/ksmbd/ndr.h
+++ b/fs/ksmbd/ndr.h
@@ -14,7 +14,7 @@ struct ndr {
 
 int ndr_encode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da);
 int ndr_decode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da);
-int ndr_encode_posix_acl(struct ndr *n, struct user_namespace *user_ns,
+int ndr_encode_posix_acl(struct ndr *n, struct mnt_idmap *idmap,
 			 struct inode *inode, struct xattr_smb_acl *acl,
 			 struct xattr_smb_acl *def_acl);
 int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl);
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index d7d47b82451d..2e54ded4d92c 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1608,9 +1608,9 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 {
 	struct create_posix_rsp *buf;
 	struct inode *inode = file_inode(fp->filp);
-	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(user_ns, inode);
-	vfsgid_t vfsgid = i_gid_into_vfsgid(user_ns, inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	buf = (struct create_posix_rsp *)cc;
 	memset(buf, 0, sizeof(struct create_posix_rsp));
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 189f96a7e96f..2d182aa31364 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2476,11 +2476,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 }
 
 static void ksmbd_acls_fattr(struct smb_fattr *fattr,
-			     struct user_namespace *mnt_userns,
+			     struct mnt_idmap *idmap,
 			     struct inode *inode)
 {
-	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
-	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	fattr->cf_uid = vfsuid_into_kuid(vfsuid);
 	fattr->cf_gid = vfsgid_into_kgid(vfsgid);
@@ -2985,7 +2985,7 @@ int smb2_open(struct ksmbd_work *work)
 					struct smb_ntsd *pntsd;
 					int pntsd_size, ace_num = 0;
 
-					ksmbd_acls_fattr(&fattr, user_ns, inode);
+					ksmbd_acls_fattr(&fattr, idmap, inode);
 					if (fattr.cf_acls)
 						ace_num = fattr.cf_acls->a_count;
 					if (fattr.cf_dacls)
@@ -4725,9 +4725,9 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 {
 	struct smb311_posix_qinfo *file_info;
 	struct inode *inode = file_inode(fp->filp);
-	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(user_ns, inode);
-	vfsgid_t vfsgid = i_gid_into_vfsgid(user_ns, inode);
+	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 	u64 time;
 	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
 
@@ -5178,7 +5178,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 	idmap = file_mnt_idmap(fp->filp);
 	user_ns = mnt_idmap_owner(idmap);
 	inode = file_inode(fp->filp);
-	ksmbd_acls_fattr(&fattr, user_ns, inode);
+	ksmbd_acls_fattr(&fattr, idmap, inode);
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_ACL_XATTR))
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 98e07c9f9869..a1b3e4ef8045 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1468,7 +1468,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
 							     ACL_TYPE_DEFAULT);
 
-	rc = ndr_encode_posix_acl(&acl_ndr, user_ns, inode,
+	rc = ndr_encode_posix_acl(&acl_ndr, idmap, inode,
 				  smb_acl, def_smb_acl);
 	if (rc) {
 		pr_err("failed to encode ndr to posix acl\n");
@@ -1531,7 +1531,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(user_ns, inode,
 							     ACL_TYPE_DEFAULT);
 
-	rc = ndr_encode_posix_acl(&acl_ndr, user_ns, inode, smb_acl,
+	rc = ndr_encode_posix_acl(&acl_ndr, idmap, inode, smb_acl,
 				  def_smb_acl);
 	if (rc) {
 		pr_err("failed to encode ndr to posix acl\n");
diff --git a/fs/namei.c b/fs/namei.c
index ed9e877f72c7..1bf6256daffd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -335,12 +335,11 @@ static int check_acl(struct mnt_idmap *idmap,
 static int acl_permission_check(struct mnt_idmap *idmap,
 				struct inode *inode, int mask)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	unsigned int mode = inode->i_mode;
 	vfsuid_t vfsuid;
 
 	/* Are we the owner? If so, ACL's don't matter */
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	if (likely(vfsuid_eq_kuid(vfsuid, current_fsuid()))) {
 		mask &= 7;
 		mode >>= 6;
@@ -363,7 +362,7 @@ static int acl_permission_check(struct mnt_idmap *idmap,
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+		vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 		if (vfsgid_in_group_p(vfsgid))
 			mode >>= 3;
 	}
@@ -1095,14 +1094,14 @@ fs_initcall(init_fs_namei_sysctls);
  */
 static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
 {
-	struct user_namespace *mnt_userns;
+	struct mnt_idmap *idmap;
 	vfsuid_t vfsuid;
 
 	if (!sysctl_protected_symlinks)
 		return 0;
 
-	mnt_userns = mnt_user_ns(nd->path.mnt);
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	idmap = mnt_idmap(nd->path.mnt);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	/* Allowed if owner and follower match. */
 	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
 		return 0;
@@ -1181,12 +1180,11 @@ static bool safe_hardlink_source(struct mnt_idmap *idmap,
  */
 int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = link->dentry->d_inode;
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
-	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
+	if (!vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
+	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
 		return -EOVERFLOW;
 
 	if (!sysctl_protected_hardlinks)
@@ -1207,7 +1205,7 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
  * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
  *			  should be allowed, or not, on files that already
  *			  exist.
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap: idmap of the mount the inode was found from
  * @nd: nameidata pathwalk data
  * @inode: the inode of the file to open
  *
@@ -1222,15 +1220,15 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
  * the directory doesn't have to be world writable: being group writable will
  * be enough.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply pass @nop_mnt_idmap.
  *
  * Returns 0 if the open is allowed, -ve on error.
  */
-static int may_create_in_sticky(struct user_namespace *mnt_userns,
+static int may_create_in_sticky(struct mnt_idmap *idmap,
 				struct nameidata *nd, struct inode *const inode)
 {
 	umode_t dir_mode = nd->dir_mode;
@@ -1239,8 +1237,8 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
 	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
-	    vfsuid_eq(i_uid_into_vfsuid(mnt_userns, inode), dir_vfsuid) ||
-	    vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), current_fsuid()))
+	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
+	    vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
@@ -2256,13 +2254,11 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	/* At this point we know we have a real path component. */
 	for(;;) {
 		struct mnt_idmap *idmap;
-		struct user_namespace *mnt_userns;
 		const char *link;
 		u64 hash_len;
 		int type;
 
 		idmap = mnt_idmap(nd->path.mnt);
-		mnt_userns = mnt_idmap_owner(idmap);
 		err = may_lookup(idmap, nd);
 		if (err)
 			return err;
@@ -2311,7 +2307,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 OK:
 			/* pathname or trailing symlink, done */
 			if (!depth) {
-				nd->dir_vfsuid = i_uid_into_vfsuid(mnt_userns, nd->inode);
+				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
@@ -2888,11 +2884,10 @@ int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode)
 {
 	kuid_t fsuid = current_fsuid();
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), fsuid))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), fsuid))
 		return 0;
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, dir), fsuid))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, dir), fsuid))
 		return 0;
 	return !capable_wrt_inode_uidgid(idmap, inode, CAP_FOWNER);
 }
@@ -2921,7 +2916,6 @@ EXPORT_SYMBOL(__check_sticky);
 static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = d_backing_inode(victim);
 	int error;
 
@@ -2932,8 +2926,8 @@ static int may_delete(struct mnt_idmap *idmap, struct inode *dir,
 	BUG_ON(victim->d_parent->d_inode != dir);
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
-	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
+	if (!vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
+	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
 		return -EOVERFLOW;
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
@@ -3522,7 +3516,6 @@ static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct mnt_idmap *idmap;
-	struct user_namespace *mnt_userns;
 	int open_flag = op->open_flag;
 	bool do_truncate;
 	int acc_mode;
@@ -3536,13 +3529,12 @@ static int do_open(struct nameidata *nd,
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
 	idmap = mnt_idmap(nd->path.mnt);
-	mnt_userns = mnt_idmap_owner(idmap);
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
-		error = may_create_in_sticky(mnt_userns, nd,
+		error = may_create_in_sticky(idmap, nd,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
 			return error;
diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..b7a2af5c896e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -230,32 +230,6 @@ struct user_namespace *mnt_idmap_owner(const struct mnt_idmap *idmap)
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_owner);
 
-/**
- * mnt_user_ns - retrieve owner of an idmapped mount
- * @mnt: the relevant vfsmount
- *
- * This helper will go away once the conversion to use struct mnt_idmap
- * everywhere has finished at which point the helper will be unexported.
- *
- * Only code that needs to perform permission checks based on the owner of the
- * idmapping will get access to it. All other code will solely rely on
- * idmappings. This will get us type safety so it's impossible to conflate
- * filesystems idmappings with mount idmappings.
- *
- * Return: The owner of the idmapped.
- */
-struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
-{
-	struct mnt_idmap *idmap = mnt_idmap(mnt);
-
-	/* Return the actual owner of the filesystem instead of the nop. */
-	if (idmap == &nop_mnt_idmap &&
-	    !initial_idmapping(mnt->mnt_sb->s_user_ns))
-		return mnt->mnt_sb->s_user_ns;
-	return mnt_idmap_owner(idmap);
-}
-EXPORT_SYMBOL_GPL(mnt_user_ns);
-
 /**
  * alloc_mnt_idmap - allocate a new idmapping for the mount
  * @mnt_userns: owning userns of the idmapping
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 1166f7b22bc7..923d66d131c1 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1101,16 +1101,16 @@ void ovl_copyattr(struct inode *inode)
 {
 	struct path realpath;
 	struct inode *realinode;
-	struct user_namespace *real_mnt_userns;
+	struct mnt_idmap *real_idmap;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
 
 	ovl_i_path_real(inode, &realpath);
 	realinode = d_inode(realpath.dentry);
-	real_mnt_userns = mnt_user_ns(realpath.mnt);
+	real_idmap = mnt_idmap(realpath.mnt);
 
-	vfsuid = i_uid_into_vfsuid(real_mnt_userns, realinode);
-	vfsgid = i_gid_into_vfsgid(real_mnt_userns, realinode);
+	vfsuid = i_uid_into_vfsuid(real_idmap, realinode);
+	vfsgid = i_gid_into_vfsgid(real_idmap, realinode);
 
 	inode->i_uid = vfsuid_into_kuid(vfsuid);
 	inode->i_gid = vfsgid_into_kgid(vfsgid);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 64d108a83871..7e0a8a068f98 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -388,7 +388,7 @@ posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
                 switch(pa->e_tag) {
                         case ACL_USER_OBJ:
 				/* (May have been checked already) */
-				vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+				vfsuid = i_uid_into_vfsuid(idmap, inode);
 				if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
                                         goto check_perm;
                                 break;
@@ -399,7 +399,7 @@ posix_acl_permission(struct mnt_idmap *idmap, struct inode *inode,
                                         goto mask;
 				break;
                         case ACL_GROUP_OBJ:
-				vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+				vfsgid = i_gid_into_vfsgid(idmap, inode);
 				if (vfsgid_in_group_p(vfsgid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
@@ -708,7 +708,6 @@ int posix_acl_update_mode(struct mnt_idmap *idmap,
 			  struct inode *inode, umode_t *mode_p,
 			  struct posix_acl **acl)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	umode_t mode = inode->i_mode;
 	int error;
 
@@ -717,7 +716,7 @@ int posix_acl_update_mode(struct mnt_idmap *idmap,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
+	if (!vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
 	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 87e5a47bee09..1331a890f2f2 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -420,14 +420,13 @@ EXPORT_SYMBOL(vfs_clone_file_range);
 static bool allow_file_dedupe(struct file *file)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = file_inode(file);
 
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 	if (file->f_mode & FMODE_WRITE)
 		return true;
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), current_fsuid()))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
 		return true;
 	if (!inode_permission(idmap, inode, MAY_WRITE))
 		return true;
diff --git a/fs/stat.c b/fs/stat.c
index cb91bc7c9efd..f540047e1177 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -44,10 +44,8 @@
 void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		      struct kstat *stat)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
-	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f6e27224bd59..59fb064e2df3 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -837,7 +837,7 @@ xfs_init_new_inode(
 	 * (and only if the irix_sgid_inherit compatibility variable is set).
 	 */
 	if (irix_sgid_inherit && (inode->i_mode & S_ISGID) &&
-	    !vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)))
+	    !vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)))
 		inode->i_mode &= ~S_ISGID;
 
 	ip->i_disk_size = 0;
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ca172e2a00ac..fbb6f5483687 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -665,7 +665,7 @@ xfs_ioc_fsbulkstat(
 	struct xfs_fsop_bulkreq	bulkreq;
 	struct xfs_ibulk	breq = {
 		.mp		= mp,
-		.mnt_userns	= file_mnt_user_ns(file),
+		.idmap		= file_mnt_idmap(file),
 		.ocount		= 0,
 	};
 	xfs_ino_t		lastino;
@@ -844,7 +844,7 @@ xfs_ioc_bulkstat(
 	struct xfs_bulk_ireq		hdr;
 	struct xfs_ibulk		breq = {
 		.mp			= mp,
-		.mnt_userns		= file_mnt_user_ns(file),
+		.idmap			= file_mnt_idmap(file),
 	};
 	int				error;
 
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 2f54b701eead..ee35eea1ecce 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -204,7 +204,7 @@ xfs_compat_ioc_fsbulkstat(
 	struct xfs_fsop_bulkreq	bulkreq;
 	struct xfs_ibulk	breq = {
 		.mp		= mp,
-		.mnt_userns	= file_mnt_user_ns(file),
+		.idmap		= file_mnt_idmap(file),
 		.ocount		= 0,
 	};
 	xfs_ino_t		lastino;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index c6284fb9e136..d54423311831 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -554,12 +554,11 @@ xfs_vn_getattr(
 	u32			request_mask,
 	unsigned int		query_flags)
 {
-	struct user_namespace	*mnt_userns = mnt_idmap_owner(idmap);
 	struct inode		*inode = d_inode(path->dentry);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	vfsuid_t		vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
-	vfsgid_t		vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+	vfsuid_t		vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid_t		vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	trace_xfs_getattr(ip);
 
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index a1c2bcf65d37..f225413a993c 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -55,7 +55,7 @@ struct xfs_bstat_chunk {
 STATIC int
 xfs_bulkstat_one_int(
 	struct xfs_mount	*mp,
-	struct user_namespace	*mnt_userns,
+	struct mnt_idmap	*idmap,
 	struct xfs_trans	*tp,
 	xfs_ino_t		ino,
 	struct xfs_bstat_chunk	*bc)
@@ -83,8 +83,8 @@ xfs_bulkstat_one_int(
 	ASSERT(ip != NULL);
 	ASSERT(ip->i_imap.im_blkno != 0);
 	inode = VFS_I(ip);
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
-	vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
+	vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	/* xfs_iget returns the following without needing
 	 * further change.
@@ -178,7 +178,7 @@ xfs_bulkstat_one(
 	struct xfs_trans	*tp;
 	int			error;
 
-	if (breq->mnt_userns != &init_user_ns) {
+	if (breq->idmap != &nop_mnt_idmap) {
 		xfs_warn_ratelimited(breq->mp,
 			"bulkstat not supported inside of idmapped mounts.");
 		return -EINVAL;
@@ -199,7 +199,7 @@ xfs_bulkstat_one(
 	if (error)
 		goto out;
 
-	error = xfs_bulkstat_one_int(breq->mp, breq->mnt_userns, tp,
+	error = xfs_bulkstat_one_int(breq->mp, breq->idmap, tp,
 			breq->startino, &bc);
 	xfs_trans_cancel(tp);
 out:
@@ -225,7 +225,7 @@ xfs_bulkstat_iwalk(
 	struct xfs_bstat_chunk	*bc = data;
 	int			error;
 
-	error = xfs_bulkstat_one_int(mp, bc->breq->mnt_userns, tp, ino, data);
+	error = xfs_bulkstat_one_int(mp, bc->breq->idmap, tp, ino, data);
 	/* bulkstat just skips over missing inodes */
 	if (error == -ENOENT || error == -EINVAL)
 		return 0;
@@ -270,7 +270,7 @@ xfs_bulkstat(
 	unsigned int		iwalk_flags = 0;
 	int			error;
 
-	if (breq->mnt_userns != &init_user_ns) {
+	if (breq->idmap != &nop_mnt_idmap) {
 		xfs_warn_ratelimited(breq->mp,
 			"bulkstat not supported inside of idmapped mounts.");
 		return -EINVAL;
diff --git a/fs/xfs/xfs_itable.h b/fs/xfs/xfs_itable.h
index e2d0eba43f35..1659f13f17a8 100644
--- a/fs/xfs/xfs_itable.h
+++ b/fs/xfs/xfs_itable.h
@@ -8,7 +8,7 @@
 /* In-memory representation of a userspace request for batch inode data. */
 struct xfs_ibulk {
 	struct xfs_mount	*mp;
-	struct user_namespace   *mnt_userns;
+	struct mnt_idmap	*idmap;
 	void __user		*ubuffer; /* user output buffer */
 	xfs_ino_t		startino; /* start with this inode */
 	unsigned int		icount;   /* number of elements in ubuffer */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3611d459bf88..173c5274a63a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1632,16 +1632,17 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 }
 
 /**
- * i_uid_into_vfsuid - map an inode's i_uid down into a mnt_userns
- * @mnt_userns: user namespace of the mount the inode was found from
+ * i_uid_into_vfsuid - map an inode's i_uid down according to an idmapping
+ * @idmap: idmap of the mount the inode was found from
  * @inode: inode to map
  *
- * Return: whe inode's i_uid mapped down according to @mnt_userns.
+ * Return: whe inode's i_uid mapped down according to @idmap.
  * If the inode's i_uid has no mapping INVALID_VFSUID is returned.
  */
-static inline vfsuid_t i_uid_into_vfsuid(struct user_namespace *mnt_userns,
+static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return make_vfsuid(mnt_userns, i_user_ns(inode), inode->i_uid);
 }
 
@@ -1660,11 +1661,9 @@ static inline bool i_uid_needs_update(struct mnt_idmap *idmap,
 				      const struct iattr *attr,
 				      const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	return ((attr->ia_valid & ATTR_UID) &&
 		!vfsuid_eq(attr->ia_vfsuid,
-			   i_uid_into_vfsuid(mnt_userns, inode)));
+			   i_uid_into_vfsuid(idmap, inode)));
 }
 
 /**
@@ -1688,16 +1687,17 @@ static inline void i_uid_update(struct mnt_idmap *idmap,
 }
 
 /**
- * i_gid_into_vfsgid - map an inode's i_gid down into a mnt_userns
- * @mnt_userns: user namespace of the mount the inode was found from
+ * i_gid_into_vfsgid - map an inode's i_gid down according to an idmapping
+ * @idmap: idmap of the mount the inode was found from
  * @inode: inode to map
  *
- * Return: the inode's i_gid mapped down according to @mnt_userns.
+ * Return: the inode's i_gid mapped down according to @idmap.
  * If the inode's i_gid has no mapping INVALID_VFSGID is returned.
  */
-static inline vfsgid_t i_gid_into_vfsgid(struct user_namespace *mnt_userns,
+static inline vfsgid_t i_gid_into_vfsgid(struct mnt_idmap *idmap,
 					 const struct inode *inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	return make_vfsgid(mnt_userns, i_user_ns(inode), inode->i_gid);
 }
 
@@ -1716,11 +1716,9 @@ static inline bool i_gid_needs_update(struct mnt_idmap *idmap,
 				      const struct iattr *attr,
 				      const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
 	return ((attr->ia_valid & ATTR_GID) &&
 		!vfsgid_eq(attr->ia_vfsgid,
-			   i_gid_into_vfsgid(mnt_userns, inode)));
+			   i_gid_into_vfsgid(idmap, inode)));
 }
 
 /**
@@ -2334,10 +2332,8 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 				   struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	return !vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
-	       !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode));
+	return !vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
+	       !vfsgid_valid(i_gid_into_vfsgid(idmap, inode));
 }
 
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
@@ -2732,11 +2728,6 @@ struct filename {
 };
 static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
-static inline struct user_namespace *file_mnt_user_ns(struct file *file)
-{
-	return mnt_user_ns(file->f_path.mnt);
-}
-
 static inline struct mnt_idmap *file_mnt_idmap(struct file *file)
 {
 	return mnt_idmap(file->f_path.mnt);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 62475996fac6..02db5909d5c2 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -74,7 +74,6 @@ struct vfsmount {
 	struct mnt_idmap *mnt_idmap;
 } __randomize_layout;
 
-struct user_namespace *mnt_user_ns(const struct vfsmount *mnt);
 struct user_namespace *mnt_idmap_owner(const struct mnt_idmap *idmap);
 static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 {
diff --git a/kernel/capability.c b/kernel/capability.c
index 509a9cfb29f2..339a44dfe2f4 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -489,10 +489,8 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 				 struct mnt_idmap *idmap,
 				 const struct inode *inode)
 {
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
-
-	return vfsuid_has_mapping(ns, i_uid_into_vfsuid(mnt_userns, inode)) &&
-	       vfsgid_has_mapping(ns, i_gid_into_vfsgid(mnt_userns, inode));
+	return vfsuid_has_mapping(ns, i_uid_into_vfsuid(idmap, inode)) &&
+	       vfsgid_has_mapping(ns, i_gid_into_vfsgid(idmap, inode));
 }
 
 /**
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index a8da32fecbe7..f3715cda59c5 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -862,7 +862,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
 	const char *info = NULL;
 	int error = 0;
 	bool unsafe = false;
-	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(bprm->file),
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(bprm->file),
 					    file_inode(bprm->file));
 	struct path_cond cond = {
 		vfsuid_into_kuid(vfsuid),
diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index cb3d3060d104..9119ddda6217 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -459,7 +459,7 @@ static int __file_path_perm(const char *op, struct aa_label *label,
 {
 	struct aa_profile *profile;
 	struct aa_perms perms = {};
-	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_user_ns(file),
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(file),
 					    file_inode(file));
 	struct path_cond cond = {
 		.uid = vfsuid_into_kuid(vfsuid),
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c6728a629437..d6cc4812ca53 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -227,8 +227,7 @@ static int common_perm(const char *op, const struct path *path, u32 mask,
  */
 static int common_perm_cond(const char *op, const struct path *path, u32 mask)
 {
-	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns,
+	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_idmap(path->mnt),
 					    d_backing_inode(path->dentry));
 	struct path_cond cond = {
 		vfsuid_into_kuid(vfsuid),
@@ -273,14 +272,13 @@ static int common_perm_rm(const char *op, const struct path *dir,
 			  struct dentry *dentry, u32 mask)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct user_namespace *mnt_userns = mnt_user_ns(dir->mnt);
 	struct path_cond cond = { };
 	vfsuid_t vfsuid;
 
 	if (!inode || !path_mediated_fs(dentry))
 		return 0;
 
-	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(mnt_idmap(dir->mnt), inode);
 	cond.uid = vfsuid_into_kuid(vfsuid);
 	cond.mode = inode->i_mode;
 
@@ -379,7 +377,7 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 
 	label = begin_current_label_crit_section();
 	if (!unconfined(label)) {
-		struct user_namespace *mnt_userns = mnt_user_ns(old_dir->mnt);
+		struct mnt_idmap *idmap = mnt_idmap(old_dir->mnt);
 		vfsuid_t vfsuid;
 		struct path old_path = { .mnt = old_dir->mnt,
 					 .dentry = old_dentry };
@@ -388,14 +386,14 @@ static int apparmor_path_rename(const struct path *old_dir, struct dentry *old_d
 		struct path_cond cond = {
 			.mode = d_backing_inode(old_dentry)->i_mode
 		};
-		vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
+		vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
 		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		if (flags & RENAME_EXCHANGE) {
 			struct path_cond cond_exchange = {
 				.mode = d_backing_inode(new_dentry)->i_mode,
 			};
-			vfsuid = i_uid_into_vfsuid(mnt_userns, d_backing_inode(old_dentry));
+			vfsuid = i_uid_into_vfsuid(idmap, d_backing_inode(old_dentry));
 			cond_exchange.uid = vfsuid_into_kuid(vfsuid);
 
 			error = aa_path_perm(OP_RENAME_SRC, label, &new_path, 0,
@@ -460,13 +458,13 @@ static int apparmor_file_open(struct file *file)
 
 	label = aa_get_newest_cred_label(file->f_cred);
 	if (!unconfined(label)) {
-		struct user_namespace *mnt_userns = file_mnt_user_ns(file);
+		struct mnt_idmap *idmap = file_mnt_idmap(file);
 		struct inode *inode = file_inode(file);
 		vfsuid_t vfsuid;
 		struct path_cond cond = {
 			.mode = inode->i_mode,
 		};
-		vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+		vfsuid = i_uid_into_vfsuid(idmap, inode);
 		cond.uid = vfsuid_into_kuid(vfsuid);
 
 		error = aa_path_perm(OP_OPEN, label, &file->f_path, 0,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2ba72bc5d9c2..fc128a6b4abe 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -572,7 +572,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	bool result = false;
 	struct ima_rule_entry *lsm_rule = rule;
 	bool rule_reinitialized = false;
-	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -625,11 +624,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			return false;
 	}
 	if ((rule->flags & IMA_FOWNER) &&
-	    !rule->fowner_op(i_uid_into_vfsuid(mnt_userns, inode),
+	    !rule->fowner_op(i_uid_into_vfsuid(idmap, inode),
 			     rule->fowner))
 		return false;
 	if ((rule->flags & IMA_FGROUP) &&
-	    !rule->fgroup_op(i_gid_into_vfsgid(mnt_userns, inode),
+	    !rule->fgroup_op(i_gid_into_vfsgid(idmap, inode),
 			     rule->fgroup))
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {

-- 
2.34.1

