Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37433468A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhCJSUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:20:47 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:56516 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233435AbhCJSUW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:20:22 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id CBCE54176A;
        Wed, 10 Mar 2021 18:20:20 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v5 4/5] proc: Relax check of mount visibility
Date:   Wed, 10 Mar 2021 19:19:59 +0100
Message-Id: <eeba37cf1db2fb81bd4509efce9063156ebb83dc.1615400395.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615400395.git.gladkov.alexey@gmail.com>
References: <cover.1615400395.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Wed, 10 Mar 2021 18:20:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow to mount of procfs with subset=pid option even if the entire
procfs is not fully accessible to the user.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/namespace.c     | 27 ++++++++++++++++-----------
 fs/proc/root.c     | 17 ++++++++++-------
 include/linux/fs.h |  1 +
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9d33909d0f9e..f9a38584f865 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3971,18 +3971,23 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
 			continue;
 
-		/* This mount is not fully visible if there are any
-		 * locked child mounts that cover anything except for
-		 * empty directories.
+		/* If this filesystem is completely dynamic, then it
+		 * makes no sense to check for any child mounts.
 		 */
-		list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
-			struct inode *inode = child->mnt_mountpoint->d_inode;
-			/* Only worry about locked mounts */
-			if (!(child->mnt.mnt_flags & MNT_LOCKED))
-				continue;
-			/* Is the directory permanetly empty? */
-			if (!is_empty_dir_inode(inode))
-				goto next;
+		if (!(sb->s_iflags & SB_I_DYNAMIC)) {
+			/* This mount is not fully visible if there are any
+			 * locked child mounts that cover anything except for
+			 * empty directories.
+			 */
+			list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+				struct inode *inode = child->mnt_mountpoint->d_inode;
+				/* Only worry about locked mounts */
+				if (!(child->mnt.mnt_flags & MNT_LOCKED))
+					continue;
+				/* Is the directory permanetly empty? */
+				if (!is_empty_dir_inode(inode))
+					goto next;
+			}
 		}
 		/* Preserve the locked attributes */
 		*new_mnt_flags |= mnt_flags & (MNT_LOCK_READONLY | \
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 0d20bb67e79a..049d5c125f8f 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -145,18 +145,21 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static int proc_apply_options(struct proc_fs_info *fs_info,
+static int proc_apply_options(struct super_block *s,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
+	struct proc_fs_info *fs_info = proc_sb_info(s);
 
 	if (ctx->mask & (1 << Opt_gid))
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset)) {
-		if (ctx->pidonly != PROC_PIDONLY_ON && fs_info->pidonly == PROC_PIDONLY_ON)
+		if (ctx->pidonly == PROC_PIDONLY_ON)
+			s->s_iflags |= SB_I_DYNAMIC;
+		else if (fs_info->pidonly == PROC_PIDONLY_ON)
 			return invalf(fc, "proc: subset=pid cannot be unset\n");
 		fs_info->pidonly = ctx->pidonly;
 	}
@@ -176,9 +179,6 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	fs_info->mounter_cred = get_cred(fc->cred);
-	ret = proc_apply_options(fs_info, fc, current_user_ns());
-	if (ret)
-		return ret;
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -190,6 +190,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_gran = 1;
 	s->s_fs_info = fs_info;
 
+	ret = proc_apply_options(s, fc, current_user_ns());
+	if (ret)
+		return ret;
+
 	/*
 	 * procfs isn't actually a stacking filesystem; however, there is
 	 * too much magic going on inside it to permit stacking things on
@@ -223,14 +227,13 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 static int proc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
-	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	sync_filesystem(sb);
 
 	put_cred(fs_info->mounter_cred);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	return proc_apply_options(fs_info, fc, current_user_ns());
+	return proc_apply_options(sb, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..2c9a47bad796 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1390,6 +1390,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
+#define SB_I_DYNAMIC			0x00000080
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 
-- 
2.29.2

