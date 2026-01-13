Return-Path: <linux-fsdevel+bounces-73403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B5D179F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259D930BCC0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5938BDBB;
	Tue, 13 Jan 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfDsoafi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD2389DEB;
	Tue, 13 Jan 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296086; cv=none; b=fm6m5WTerWhkwnDg8ZW3f989y0AUIP+nnAzwc8MmTXl7FBZr8hTJ/nBFkdxwjW2Gr1i93onBPZ/F9ggyHCKW0l4kFU4XG0u4ygxW1RnN5UN3qNa0L+qRz0EhmnRNp+6BpG3nwcBLEvv64v3o3Z/HNz6trzIbb/aSmDmGOX8+oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296086; c=relaxed/simple;
	bh=eX+w5EfcvclBT2LFvZ5gN3ESzAkXLUYEfvQmmraqHgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6y4aN3YpbhjmDcl2mWyHICKEfnnqp/VMUY0xLAaKKPDKjK2QCbDQU2rV36Ajpp9hIbl04bDShx5AdmccoLw8ltltgyDKgKT/DYRYTOSjmUp2M4zmj8hu1yBtg583s04VaUhAoY/C+vwx+6S3l9YyAqRmtSK73f3Y39ojmlZCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfDsoafi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA6C19423;
	Tue, 13 Jan 2026 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296080;
	bh=eX+w5EfcvclBT2LFvZ5gN3ESzAkXLUYEfvQmmraqHgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfDsoafiTkOGF4vw0oyVCqdL7p+zyeEKemegkohPRr79xGLYwKj1x3Ub7Sy41k57h
	 oDem4+PXn44UZFDHb5HOqEjGNb874EnIa5NRZoLUyRrmu+hbnteJftXZ4lh2Fct9nu
	 QSd05NzohgmiidgpF34AFXwU6ydLtgp1phHlYXg36csG3gY92GY+tn/FySfp8QKQNa
	 yqcn3rzn9cxCBjLWiB6ExbllpI8SaGEa7A+bVRAYBEZEyoTniCvoP5JbdfIEG38qs8
	 U858jrobTnSnUxnXJgaGVy4YZjigGD0id+4QJNhRbEOYgqB7zn4bH71uN6KF/tHXzC
	 7G1kIgXEeAzCA==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/5] proc: Relax check of mount visibility
Date: Tue, 13 Jan 2026 10:20:36 +0100
Message-ID: <fa2e0a93243c197ae8ba8b9b61f8be04320b11a1.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <20251213050639.735940-1-danilklishch@gmail.com> <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When /proc is mounted with the subset=pid option, all system files from
the root of the file system are not accessible in userspace. Only
dynamic information about processes is available, which cannot be
hidden with overmount.

For this reason, checking for full visibility is not relevant if
mounting is performed with the subset=pid option.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/namespace.c                 | 29 ++++++++++++++++-------------
 fs/proc/root.c                 | 16 ++++++++++------
 include/linux/fs/super_types.h |  2 ++
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..7daa86315c05 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6116,7 +6116,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		/* This mount is not fully visible if it's root directory
 		 * is not the root directory of the filesystem.
 		 */
-		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
+		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING) &&
+		    mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
 			continue;
 
 		/* A local view of the mount flags */
@@ -6136,18 +6137,20 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
 			continue;
 
-		/* This mount is not fully visible if there are any
-		 * locked child mounts that cover anything except for
-		 * empty directories.
-		 */
-		list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
-			struct inode *inode = child->mnt_mountpoint->d_inode;
-			/* Only worry about locked mounts */
-			if (!(child->mnt.mnt_flags & MNT_LOCKED))
-				continue;
-			/* Is the directory permanently empty? */
-			if (!is_empty_dir_inode(inode))
-				goto next;
+		if (!(sb->s_iflags & SB_I_USERNS_ALLOW_REVEALING)) {
+			/* This mount is not fully visible if there are any
+			 * locked child mounts that cover anything except for
+			 * empty directories.
+			 */
+			list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+				struct inode *inode = child->mnt_mountpoint->d_inode;
+				/* Only worry about locked mounts */
+				if (!IS_MNT_LOCKED(child))
+					continue;
+				/* Is the directory permanently empty? */
+				if (!is_empty_dir_inode(inode))
+					goto next;
+			}
 		}
 		/* Preserve the locked attributes */
 		*new_mnt_flags |= mnt_flags & (MNT_LOCK_READONLY | \
diff --git a/fs/proc/root.c b/fs/proc/root.c
index b9f33b67cdd6..354dc13417e3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -223,18 +223,21 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
+			s->s_iflags |= SB_I_USERNS_ALLOW_REVEALING;
+		else if (fs_info->pidonly == PROC_PIDONLY_ON)
 			return invalf(fc, "proc: subset=pid cannot be unset\n");
 		fs_info->pidonly = ctx->pidonly;
 	}
@@ -259,9 +262,6 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	fs_info->mounter_cred = get_cred(fc->cred);
-	ret = proc_apply_options(fs_info, fc, current_user_ns());
-	if (ret)
-		return ret;
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -273,6 +273,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_gran = 1;
 	s->s_fs_info = fs_info;
 
+	ret = proc_apply_options(s, fc, current_user_ns());
+	if (ret)
+		return ret;
+
 	/*
 	 * procfs isn't actually a stacking filesystem; however, there is
 	 * too much magic going on inside it to permit stacking things on
@@ -313,7 +317,7 @@ static int proc_reconfigure(struct fs_context *fc)
 	put_cred(fs_info->mounter_cred);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	return proc_apply_options(fs_info, fc, current_user_ns());
+	return proc_apply_options(sb, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 6bd3009e09b3..5e640b9140df 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -333,4 +333,6 @@ struct super_block {
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 
+#define SB_I_USERNS_ALLOW_REVEALING	0x00008000 /* Skip full visibility check */
+
 #endif /* _LINUX_FS_SUPER_TYPES_H */
-- 
2.52.0


