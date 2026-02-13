Return-Path: <linux-fsdevel+bounces-77130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E4zHsIAj2kAHQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:45:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815913538F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B476930148AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D89355040;
	Fri, 13 Feb 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHcEYQaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1E354ADB;
	Fri, 13 Feb 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979494; cv=none; b=amPXUEG8ij8r86cZ1JyCSKE7hAdxlKSEKLtdN7E2Dch5rkpye4A6qVh0TEdXnW/dgOej+PIp9Ej5PLOH78mncALi+yXihvnN9xaiRcmXf/6Wo2fkD2HNzjz9KPIQMxMIwQtdd1upgfP8bmTfjOQEmHWgt/fgyxGTS1h2AfP1qNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979494; c=relaxed/simple;
	bh=u0rRFolz2hlrLl/jnl2NP+sUOagCjWWVkXRBr2RtN+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sedRjJMxw81KsU/3UETvBaYi2k6lpZckzl3kaBuabHY5iFuIDQ7UugXZzBPrMYpsndjsOjfiP+jmejNazZspidcsCshDfL/vjoBlODp0nO1idmz0aFvFlCiDItwYn/l6DzDyyAXLc5jI4OJSJHTPGKV+StKb66VyBoSqqNumIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHcEYQaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D0C19423;
	Fri, 13 Feb 2026 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979494;
	bh=u0rRFolz2hlrLl/jnl2NP+sUOagCjWWVkXRBr2RtN+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHcEYQaFW3fwFvLCte5ik1tN9tCtd2fyQx2gYUCv9DGvBqgmbrHiVbyWI5OKjUwex
	 ZKsalfcsIFJKrw7tLv/h+FE4PH7jj3pDq1KCJJRxKPK32dEkxopa04pjEYiltc7CcR
	 Bta+GkHvDoGn5SHjxzpUf1OSJLju/GKHUPF5TYRm9grP5WOMp8XhtcY9OSTZU/C7P8
	 IxOWz3STEWnTMUDwCsVgpWfzwfYoaXGylOgrQcZqU1qde8GUE3CUOd6VjPvnzN8ZS+
	 5PJx85Yg+Obf/Mve8VJ8FX4gCin57gjgLZpGk6F8AwkelzuVcdn/KB8MsOzEWl2nwx
	 b34p4MSiE0pag==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/5] proc: Relax check of mount visibility
Date: Fri, 13 Feb 2026 11:44:29 +0100
Message-ID: <0943f113592a25bee341aae25d1cea088791054f.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770979341.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org> <cover.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77130-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9815913538F
X-Rspamd-Action: no action

When /proc is mounted with the subset=pid option, all system files from
the root of the file system are not accessible in userspace. Only
dynamic information about processes is available, which cannot be
hidden with overmount.

For this reason, checking for full visibility is not relevant if
mounting is performed with the subset=pid option.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/namespace.c                 | 29 ++++++++++++++++-------------
 fs/proc/root.c                 | 17 ++++++++++-------
 include/linux/fs/super_types.h |  2 ++
 3 files changed, 28 insertions(+), 20 deletions(-)

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
index 535a168046e3..e029d3587494 100644
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
@@ -306,11 +310,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 static int proc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
-	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	sync_filesystem(sb);
 
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
2.53.0


