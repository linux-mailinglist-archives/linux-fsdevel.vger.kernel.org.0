Return-Path: <linux-fsdevel+bounces-17383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6658AC7CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC1C1C20CB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BF537F7;
	Mon, 22 Apr 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="T0pavIqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327153380;
	Mon, 22 Apr 2024 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775840; cv=none; b=m2UEXgG7eLA9BREXILsYH2QnJH9hYn4jyWLrm4mfo2biIGSs3+1gkMw7lHcvjO7eoP2g9JkCTkSDH26mACHdLf8cGKnqN6mtny4ycTdxleWwtYT24jqktImKSlQ8LEYsGo8MNbpSu/hvi1itL5GYNHbLOTq98H1NsK13naICc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775840; c=relaxed/simple;
	bh=aMDFqI1QHzMdU3LnfCn0Y4nQGaZwj7/Cpqj6M74qTjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAq3l9oY0UX1f6TCwyMOfA53kfTQO+e8aHngUzesqISMs4VMJu2cu84SBFCSk+snTIj9tLX6gf4Xyl3kF3vtGjV59D64hq6R6oVIeJpnz9v8IEYNuaobx4hmNzrIM1KpMW7IZEOVcV3WUTRPX2HQebvQUtVhBmJjqQofu9Bg5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=T0pavIqK; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id E16FB6735C;
	Mon, 22 Apr 2024 11:45:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 803BB60B5C;
	Mon, 22 Apr 2024 11:45:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FjEovW2OjiE0-hgQo78bt;
	Mon, 22 Apr 2024 11:45:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713775517; bh=zoDO3lBqhyc8A5W4wSrhQd8zHHet7r7I6aC+G/nOKTQ=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=T0pavIqK9Kzdy0aCbUzPIFOKUzd3gvHHTObOGBeYmAKN/bqEbg1CfEKG1S9hz5q14
	 dMt6w1LFcbvdDTYQOd09hmsFPAUAiyj0rpnaUm6Soc4IbIYUbOpPjBxudEi7AC0bwH
	 4TSS95BoT+ip4nFBMPda4jWaIsxoWGFdxs/sKbK0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Date: Mon, 22 Apr 2024 11:45:05 +0300
Message-ID: <20240422084505.3465238-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422084505.3465238-1-stsp2@yandex.ru>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This flag performs the open operation with the fsuid/fsgid that
were in effect when dir_fd was opened.
This allows the process to pre-open some directories and then
change eUID (and all other UIDs/GIDs) to a less-privileged user,
retaining the ability to open/create files within these directories.

Design goal:
The idea is to provide a very light-weight sandboxing, where the
process, without the use of any heavy-weight techniques like chroot
within namespaces, can restrict the access to the set of pre-opened
directories.
This patch is just a first step to such sandboxing. If things go
well, in the future the same extension can be added to more syscalls.
These should include at least unlinkat(), renameat2() and the
not-yet-upstreamed setxattrat().

Security considerations:
To avoid sandboxing escape, this patch makes sure the restricted
lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
To avoid leaking creds across exec, this patch requires O_CLOEXEC
flag on a directory.

Use cases:
Virtual machines that deal with untrusted code, can use that
instead of a more heavy-weighted approaches.
Currently the approach is being tested on a dosemu2 VM.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Andy Lutomirski <luto@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Aring <alex.aring@gmail.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>
---
 fs/file_table.c              |  2 ++
 fs/internal.h                |  2 +-
 fs/namei.c                   | 54 ++++++++++++++++++++++++++++++++++--
 fs/open.c                    |  2 +-
 include/linux/fcntl.h        |  2 ++
 include/linux/fs.h           |  2 ++
 include/uapi/linux/openat2.h |  3 ++
 7 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..9991bdd538e9 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -160,6 +160,8 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	mutex_init(&f->f_pos_lock);
 	f->f_flags = flags;
 	f->f_mode = OPEN_FMODE(flags);
+	f->f_fsuid = cred->fsuid;
+	f->f_fsgid = cred->fsgid;
 	/* f->f_version: 0 */
 
 	/*
diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..692b53b19aad 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -169,7 +169,7 @@ static inline void sb_end_ro_state_change(struct super_block *sb)
  * open.c
  */
 struct open_flags {
-	int open_flag;
+	u64 open_flag;
 	umode_t mode;
 	int acc_mode;
 	int intent;
diff --git a/fs/namei.c b/fs/namei.c
index 2fde2c320ae9..d1db6ceee4bd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -586,6 +586,8 @@ struct nameidata {
 	int		dfd;
 	vfsuid_t	dir_vfsuid;
 	umode_t		dir_mode;
+	kuid_t		dir_open_fsuid;
+	kgid_t		dir_open_fsgid;
 } __randomize_layout;
 
 #define ND_ROOT_PRESET 1
@@ -2414,6 +2416,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		nd->dir_open_fsuid = current_cred()->fsuid;
+		nd->dir_open_fsgid = current_cred()->fsgid;
 	} else {
 		/* Caller must check execute permissions on the starting path component */
 		struct fd f = fdget_raw(nd->dfd);
@@ -2437,6 +2441,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		nd->dir_open_fsuid = f.file->f_fsuid;
+		nd->dir_open_fsgid = f.file->f_fsgid;
 		fdput(f);
 	}
 
@@ -3653,6 +3659,28 @@ static int do_open(struct nameidata *nd,
 	return error;
 }
 
+static const struct cred *openat2_override_creds(struct nameidata *nd)
+{
+	const struct cred *old_cred;
+	struct cred *override_cred;
+
+	override_cred = prepare_creds();
+	if (!override_cred)
+		return NULL;
+
+	override_cred->fsuid = nd->dir_open_fsuid;
+	override_cred->fsgid = nd->dir_open_fsgid;
+
+	override_cred->non_rcu = 1;
+
+	old_cred = override_creds(override_cred);
+
+	/* override_cred() gets its own ref */
+	put_cred(override_cred);
+
+	return old_cred;
+}
+
 /**
  * vfs_tmpfile - create tmpfile
  * @idmap:	idmap of the mount the inode was found from
@@ -3794,8 +3822,28 @@ static struct file *path_openat(struct nameidata *nd,
 		error = do_o_path(nd, flags, file);
 	} else {
 		const char *s = path_init(nd, flags);
-		file = alloc_empty_file(op->open_flag, current_cred());
-		error = PTR_ERR_OR_ZERO(file);
+		const struct cred *old_cred = NULL;
+
+		error = 0;
+		if (op->open_flag & OA2_INHERIT_CRED) {
+			/* Make sure to work only with restricted
+			 * look-up modes.
+			 */
+			if (!(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
+				error = -EPERM;
+			/* Only work with O_CLOEXEC dirs. */
+			if (!get_close_on_exec(nd->dfd))
+				error = -EPERM;
+
+			if (!error)
+				old_cred = openat2_override_creds(nd);
+		}
+		if (!error) {
+			file = alloc_empty_file(op->open_flag, current_cred());
+			error = PTR_ERR_OR_ZERO(file);
+		} else {
+			file = ERR_PTR(error);
+		}
 		if (!error) {
 			while (!(error = link_path_walk(s, nd)) &&
 			       (s = open_last_lookups(nd, file, op)) != NULL)
@@ -3803,6 +3851,8 @@ static struct file *path_openat(struct nameidata *nd,
 		}
 		if (!error)
 			error = do_open(nd, file, op);
+		if (old_cred)
+			revert_creds(old_cred);
 		terminate_walk(nd);
 		if (IS_ERR(file))
 			return file;
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..6be013182a35 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1225,7 +1225,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..b71f8b162102 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OA2_INHERIT_CRED)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..ea954b6945d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1028,6 +1028,8 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+	kuid_t			f_fsuid;  /* fsUID of the opener */
+	kgid_t			f_fsgid;  /* fsGID of the opener */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..cdd676a10b62 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,7 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+/* openat2-specific flags go to upper 4 bytes. */
+#define OA2_INHERIT_CRED		(1ULL << 32)
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.44.0


