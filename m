Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D1609FF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJXLNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJXLNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E63C15F
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 04:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52015B810FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 11:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBDCC433D7;
        Mon, 24 Oct 2022 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609982;
        bh=h4fqric+rvQ4K/hF+aFxuDdUtIc/rw0XwM7MvofQLbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm2u2cxrQ5LYrJTfayhmimiLqFzSi162c5qAWG/VPMU45N+j5oVxp+Lzoyn7KskEw
         Il4L3niijNktC7Fsxrbp8HBoPiLcSIZO/E3+zFIa0vi38MvidQMk9Fnlx1Br9plUC1
         BvU5SwQqDXn9PeXkZoKxMp3iWIoJxFbeskAc5TFnJQKfYnge+rcIFBO9ZqFcQUMaKW
         FToN+zmr5jwpKj0ysiltwSDFEsb6Ab37Ya7WsfnVBtUAl7aaRFfbqsaBDrt0zCF8kn
         42ySlW18+wSZKiFV/BjhcLemgZXg0S57GkfoCcgqztBtq5bjSrjRnWvpj4APWwS5K7
         JhyktB/vs7mug==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/8] fs: use type safe idmapping helpers
Date:   Mon, 24 Oct 2022 13:12:43 +0200
Message-Id: <20221024111249.477648-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9608; i=brauner@kernel.org; h=from:subject; bh=h4fqric+rvQ4K/hF+aFxuDdUtIc/rw0XwM7MvofQLbY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFeu+M/RTkDRWWnapSWV5JX+/1GwVt46rlUyVO08tq+6X PPSmo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIq7gz/k6w3Luh/u7Wh1i9Vy/bBhC V37+gYX+W8ynVKsfnjK7GTQYwMO1arrEgTfH310Vw98aXyvXV1FtumLPq0v0xo3sYPEp7z2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already ported most parts and filesystems over for v6.0 to the new
vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
places so we can remove all the old helpers.
This is a non-functional change.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 fs/coredump.c    |  4 ++--
 fs/exec.c        | 16 ++++++++--------
 fs/inode.c       |  8 ++++----
 fs/namei.c       | 40 ++++++++++++++++++++--------------------
 fs/remap_range.c |  2 +-
 fs/stat.c        |  7 +++++--
 6 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..a133103eb721 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -716,8 +716,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * filesystem.
 		 */
 		mnt_userns = file_mnt_user_ns(cprm.file);
-		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode),
-			    current_fsuid())) {
+		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
+				    current_fsuid())) {
 			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
 					    cn.corename);
 			goto close_fail;
diff --git a/fs/exec.c b/fs/exec.c
index 349a5da91efe..dd91adec7a11 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1591,8 +1591,8 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	struct user_namespace *mnt_userns;
 	struct inode *inode = file_inode(file);
 	unsigned int mode;
-	kuid_t uid;
-	kgid_t gid;
+	vfsuid_t vfsuid;
+	vfsgid_t vfsgid;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1611,23 +1611,23 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 
 	/* reload atomically mode/uid/gid now that lock held */
 	mode = inode->i_mode;
-	uid = i_uid_into_mnt(mnt_userns, inode);
-	gid = i_gid_into_mnt(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 	inode_unlock(inode);
 
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
-	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
-		 !kgid_has_mapping(bprm->cred->user_ns, gid))
+	if (!vfsuid_has_mapping(bprm->cred->user_ns, vfsuid) ||
+	    !vfsgid_has_mapping(bprm->cred->user_ns, vfsgid))
 		return;
 
 	if (mode & S_ISUID) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
-		bprm->cred->euid = uid;
+		bprm->cred->euid = vfsuid_into_kuid(vfsuid);
 	}
 
 	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
-		bprm->cred->egid = gid;
+		bprm->cred->egid = vfsgid_into_kgid(vfsgid);
 	}
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 8c4078889754..757cac29bd5a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2326,15 +2326,15 @@ EXPORT_SYMBOL(inode_init_owner);
 bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 			    const struct inode *inode)
 {
-	kuid_t i_uid;
+	vfsuid_t vfsuid;
 	struct user_namespace *ns;
 
-	i_uid = i_uid_into_mnt(mnt_userns, inode);
-	if (uid_eq(current_fsuid(), i_uid))
+	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
 		return true;
 
 	ns = current_user_ns();
-	if (kuid_has_mapping(ns, i_uid) && ns_capable(ns, CAP_FOWNER))
+	if (vfsuid_has_mapping(ns, vfsuid) && ns_capable(ns, CAP_FOWNER))
 		return true;
 	return false;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..d5c5cb7dd023 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -336,11 +336,11 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
 				struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
-	kuid_t i_uid;
+	vfsuid_t vfsuid;
 
 	/* Are we the owner? If so, ACL's don't matter */
-	i_uid = i_uid_into_mnt(mnt_userns, inode);
-	if (likely(uid_eq(current_fsuid(), i_uid))) {
+	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	if (likely(vfsuid_eq_kuid(vfsuid, current_fsuid()))) {
 		mask &= 7;
 		mode >>= 6;
 		return (mask & ~mode) ? -EACCES : 0;
@@ -362,8 +362,8 @@ static int acl_permission_check(struct user_namespace *mnt_userns,
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
-		if (in_group_p(kgid))
+		vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+		if (vfsgid_in_group_p(vfsgid))
 			mode >>= 3;
 	}
 
@@ -581,7 +581,7 @@ struct nameidata {
 	struct nameidata *saved;
 	unsigned	root_seq;
 	int		dfd;
-	kuid_t		dir_uid;
+	vfsuid_t	dir_vfsuid;
 	umode_t		dir_mode;
 } __randomize_layout;
 
@@ -1095,15 +1095,15 @@ fs_initcall(init_fs_namei_sysctls);
 static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
 {
 	struct user_namespace *mnt_userns;
-	kuid_t i_uid;
+	vfsuid_t vfsuid;
 
 	if (!sysctl_protected_symlinks)
 		return 0;
 
 	mnt_userns = mnt_user_ns(nd->path.mnt);
-	i_uid = i_uid_into_mnt(mnt_userns, inode);
+	vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	/* Allowed if owner and follower match. */
-	if (uid_eq(current_cred()->fsuid, i_uid))
+	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
 		return 0;
 
 	/* Allowed if parent directory not sticky and world-writable. */
@@ -1111,7 +1111,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 		return 0;
 
 	/* Allowed if parent directory and link owner match. */
-	if (uid_valid(nd->dir_uid) && uid_eq(nd->dir_uid, i_uid))
+	if (vfsuid_valid(nd->dir_vfsuid) && vfsuid_eq(nd->dir_vfsuid, vfsuid))
 		return 0;
 
 	if (nd->flags & LOOKUP_RCU)
@@ -1183,8 +1183,8 @@ int may_linkat(struct user_namespace *mnt_userns, const struct path *link)
 	struct inode *inode = link->dentry->d_inode;
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!uid_valid(i_uid_into_mnt(mnt_userns, inode)) ||
-	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
+	if (!vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
+	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	if (!sysctl_protected_hardlinks)
@@ -1232,13 +1232,13 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
 				struct nameidata *nd, struct inode *const inode)
 {
 	umode_t dir_mode = nd->dir_mode;
-	kuid_t dir_uid = nd->dir_uid;
+	vfsuid_t dir_vfsuid = nd->dir_vfsuid;
 
 	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
-	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
-	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
+	    vfsuid_eq(i_uid_into_vfsuid(mnt_userns, inode), dir_vfsuid) ||
+	    vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), current_fsuid()))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
@@ -2307,7 +2307,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 OK:
 			/* pathname or trailing symlink, done */
 			if (!depth) {
-				nd->dir_uid = i_uid_into_mnt(mnt_userns, nd->inode);
+				nd->dir_vfsuid = i_uid_into_vfsuid(mnt_userns, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
@@ -2885,9 +2885,9 @@ int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
 {
 	kuid_t fsuid = current_fsuid();
 
-	if (uid_eq(i_uid_into_mnt(mnt_userns, inode), fsuid))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), fsuid))
 		return 0;
-	if (uid_eq(i_uid_into_mnt(mnt_userns, dir), fsuid))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, dir), fsuid))
 		return 0;
 	return !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FOWNER);
 }
@@ -2926,8 +2926,8 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
 	BUG_ON(victim->d_parent->d_inode != dir);
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!uid_valid(i_uid_into_mnt(mnt_userns, inode)) ||
-	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
+	if (!vfsuid_valid(i_uid_into_vfsuid(mnt_userns, inode)) ||
+	    !vfsgid_valid(i_gid_into_vfsgid(mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 654912d06862..290743c8d226 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -429,7 +429,7 @@ static bool allow_file_dedupe(struct file *file)
 		return true;
 	if (file->f_mode & FMODE_WRITE)
 		return true;
-	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode), current_fsuid()))
 		return true;
 	if (!inode_permission(mnt_userns, inode, MAY_WRITE))
 		return true;
diff --git a/fs/stat.c b/fs/stat.c
index ef50573c72a2..d6cc74ca8486 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -44,12 +44,15 @@
 void generic_fillattr(struct user_namespace *mnt_userns, struct inode *inode,
 		      struct kstat *stat)
 {
+	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
+	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
+
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
-	stat->uid = i_uid_into_mnt(mnt_userns, inode);
-	stat->gid = i_gid_into_mnt(mnt_userns, inode);
+	stat->uid = vfsuid_into_kuid(vfsuid);
+	stat->gid = vfsgid_into_kgid(vfsgid);
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
-- 
2.34.1

