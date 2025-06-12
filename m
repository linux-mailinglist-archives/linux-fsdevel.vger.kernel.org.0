Return-Path: <linux-fsdevel+bounces-51471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE46AD71FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8233C3B2401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C141257AF9;
	Thu, 12 Jun 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7AYhb1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6F2571DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734751; cv=none; b=C2esoGyKeqIGQO5lve3/C21sCJz91TZAMaVBb4A29CMenpG4qGDBsDvhkb/fXFkAOt8Nc88qhDXTqVUAsRQkVqIYuVJaHB95DRuEqURLl6YPlnRTUc5g+ZaiO/I+Pfynub/vgIiLaH3CY32BrIy4hwQ/hsvps80BF/DyEp2MFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734751; c=relaxed/simple;
	bh=IDIa024yZAHUGtoale6xtWHR3k0VvT8i3PXeBv3+HV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4pZ7Ae4lmJiwHLnuj64nFSj96ri9W9cfKRO3o4alho09YeupCA+A+bdi4QkdiVANJHzn7rBNxvWVUW7FtC15hC/ulKYE4Cn7veiWhse9WR5zSb77iehNfGEXI1/PDpPBiglYGCNQzyxdw42E4ygLSACAEbXlxkz3I5sMQdFpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7AYhb1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775CDC4CEEA;
	Thu, 12 Jun 2025 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734751;
	bh=IDIa024yZAHUGtoale6xtWHR3k0VvT8i3PXeBv3+HV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K7AYhb1xz4rP/PncIRveuORdft8Ua6c9cFfX4ytTYD0k7uc7XgqvWBXgUZePHCpqm
	 hVMQiCYZKVQJ6a1YcaVFFSn4huvfsj4+cFkB6XNSJwMkQLoGHMMI43i4lrpUcJwRjc
	 Bbif98FkCS7xDCcMOjAJrTg3Xavc5OPsSjXSAqkW6a9Nyfmt0SKqVOH9b6OJ5b0OwW
	 wpYsL/iVOHhh/RyS4vdSrIBKoeG/6KsCjBLGcJ9ut7LQfkZnUwtWRNcDuWocudWehp
	 NT7jeNguP4DnBOgdK/pbjfp79CmCTyfiz7EEkMTTgEiKtebQ5TcHdQPqMLbU0n/RvQ
	 jKsx0ylrPZKaA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:24 +0200
Subject: [PATCH 10/24] coredump: split file coredumping into
 coredump_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-10-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=8985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IDIa024yZAHUGtoale6xtWHR3k0VvT8i3PXeBv3+HV0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXX/OkFymdyfOd0LehYUCLOqC3OHrA6vzN4/1dOKQ
 XzpC8X6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInI9DMydJ34c1L7zkYmJ4lp
 pg/Sp3/pu/xz2WKtC9XWl+KniWceZGBk2DWFK02f9dXe4PWdf+b6nJdaYlsvw23yz+eLYqlXXYg
 sMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* Move that whole mess into a separate helper instead of having all that
  hanging around in vfs_coredump() directly.

* Stop using that need_suid_safe variable and add an inline helper that
  clearly communicates what's going on everywhere consistently. The mm
  flag snapshot is stable and can't change so nothing's gained with that
  boolean.

* Only setup cprm->file once everything else succeeded, using RAII for
  the coredump file before. That allows to don't care to what goto label
  we jump in vfs_coredump().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 207 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 106 insertions(+), 101 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 8a401eeee940..9f9d8ae29359 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -865,6 +865,108 @@ static inline void coredump_sock_wait(struct file *file) { }
 static inline void coredump_sock_shutdown(struct file *file) { }
 #endif
 
+/* cprm->mm_flags contains a stable snapshot of dumpability flags. */
+static inline bool coredump_force_suid_safe(const struct coredump_params *cprm)
+{
+	/* Require nonrelative corefile path and be extra careful. */
+	return __get_dumpable(cprm->mm_flags) == SUID_DUMP_ROOT;
+}
+
+static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
+			  const struct linux_binfmt *binfmt)
+{
+	struct mnt_idmap *idmap;
+	struct inode *inode;
+	struct file *file __free(fput) = NULL;
+	int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW | O_LARGEFILE | O_EXCL;
+
+	if (cprm->limit < binfmt->min_coredump)
+		return false;
+
+	if (coredump_force_suid_safe(cprm) && cn->corename[0] != '/') {
+		coredump_report_failure("this process can only dump core to a fully qualified path, skipping core dump");
+		return false;
+	}
+
+	/*
+	 * Unlink the file if it exists unless this is a SUID
+	 * binary - in that case, we're running around with root
+	 * privs and don't want to unlink another user's coredump.
+	 */
+	if (!coredump_force_suid_safe(cprm)) {
+		/*
+		 * If it doesn't exist, that's fine. If there's some
+		 * other problem, we'll catch it at the filp_open().
+		 */
+		do_unlinkat(AT_FDCWD, getname_kernel(cn->corename));
+	}
+
+	/*
+	 * There is a race between unlinking and creating the
+	 * file, but if that causes an EEXIST here, that's
+	 * fine - another process raced with us while creating
+	 * the corefile, and the other process won. To userspace,
+	 * what matters is that at least one of the two processes
+	 * writes its coredump successfully, not which one.
+	 */
+	if (coredump_force_suid_safe(cprm)) {
+		/*
+		 * Using user namespaces, normal user tasks can change
+		 * their current->fs->root to point to arbitrary
+		 * directories. Since the intention of the "only dump
+		 * with a fully qualified path" rule is to control where
+		 * coredumps may be placed using root privileges,
+		 * current->fs->root must not be used. Instead, use the
+		 * root directory of init_task.
+		 */
+		struct path root;
+
+		task_lock(&init_task);
+		get_fs_root(init_task.fs, &root);
+		task_unlock(&init_task);
+		file = file_open_root(&root, cn->corename, open_flags, 0600);
+		path_put(&root);
+	} else {
+		file = filp_open(cn->corename, open_flags, 0600);
+	}
+	if (IS_ERR(file))
+		return false;
+
+	inode = file_inode(file);
+	if (inode->i_nlink > 1)
+		return false;
+	if (d_unhashed(file->f_path.dentry))
+		return false;
+	/*
+	 * AK: actually i see no reason to not allow this for named
+	 * pipes etc, but keep the previous behaviour for now.
+	 */
+	if (!S_ISREG(inode->i_mode))
+		return false;
+	/*
+	 * Don't dump core if the filesystem changed owner or mode
+	 * of the file during file creation. This is an issue when
+	 * a process dumps core while its cwd is e.g. on a vfat
+	 * filesystem.
+	 */
+	idmap = file_mnt_idmap(file);
+	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid())) {
+		coredump_report_failure("Core dump to %s aborted: cannot preserve file owner", cn->corename);
+		return false;
+	}
+	if ((inode->i_mode & 0677) != 0600) {
+		coredump_report_failure("Core dump to %s aborted: cannot preserve file permissions", cn->corename);
+		return false;
+	}
+	if (!(file->f_mode & FMODE_CAN_WRITE))
+		return false;
+	if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
+		return false;
+
+	cprm->file = no_free_ptr(file);
+	return true;
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -876,8 +978,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	int retval = 0;
 	size_t *argv = NULL;
 	int argc = 0;
-	/* require nonrelative corefile path and be extra careful */
-	bool need_suid_safe = false;
 	bool core_dumped = false;
 	static atomic_t core_dump_count = ATOMIC_INIT(0);
 	struct coredump_params cprm = {
@@ -910,11 +1010,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	 * so we dump it as root in mode 2, and only into a controlled
 	 * environment (pipe handler or fully qualified path).
 	 */
-	if (__get_dumpable(cprm.mm_flags) == SUID_DUMP_ROOT) {
-		/* Setuid core dump mode */
-		cred->fsuid = GLOBAL_ROOT_UID;	/* Dump root private */
-		need_suid_safe = true;
-	}
+	if (coredump_force_suid_safe(&cprm))
+		cred->fsuid = GLOBAL_ROOT_UID;
 
 	retval = coredump_wait(siginfo->si_signo, &core_state);
 	if (retval < 0)
@@ -928,102 +1025,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 	switch (cn.core_type) {
-	case COREDUMP_FILE: {
-		struct mnt_idmap *idmap;
-		struct inode *inode;
-		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
-				 O_LARGEFILE | O_EXCL;
-
-		if (cprm.limit < binfmt->min_coredump)
-			goto fail_unlock;
-
-		if (need_suid_safe && cn.corename[0] != '/') {
-			coredump_report_failure(
-				"this process can only dump core to a fully qualified path, skipping core dump");
-			goto fail_unlock;
-		}
-
-		/*
-		 * Unlink the file if it exists unless this is a SUID
-		 * binary - in that case, we're running around with root
-		 * privs and don't want to unlink another user's coredump.
-		 */
-		if (!need_suid_safe) {
-			/*
-			 * If it doesn't exist, that's fine. If there's some
-			 * other problem, we'll catch it at the filp_open().
-			 */
-			do_unlinkat(AT_FDCWD, getname_kernel(cn.corename));
-		}
-
-		/*
-		 * There is a race between unlinking and creating the
-		 * file, but if that causes an EEXIST here, that's
-		 * fine - another process raced with us while creating
-		 * the corefile, and the other process won. To userspace,
-		 * what matters is that at least one of the two processes
-		 * writes its coredump successfully, not which one.
-		 */
-		if (need_suid_safe) {
-			/*
-			 * Using user namespaces, normal user tasks can change
-			 * their current->fs->root to point to arbitrary
-			 * directories. Since the intention of the "only dump
-			 * with a fully qualified path" rule is to control where
-			 * coredumps may be placed using root privileges,
-			 * current->fs->root must not be used. Instead, use the
-			 * root directory of init_task.
-			 */
-			struct path root;
-
-			task_lock(&init_task);
-			get_fs_root(init_task.fs, &root);
-			task_unlock(&init_task);
-			cprm.file = file_open_root(&root, cn.corename,
-						   open_flags, 0600);
-			path_put(&root);
-		} else {
-			cprm.file = filp_open(cn.corename, open_flags, 0600);
-		}
-		if (IS_ERR(cprm.file))
-			goto fail_unlock;
-
-		inode = file_inode(cprm.file);
-		if (inode->i_nlink > 1)
-			goto close_fail;
-		if (d_unhashed(cprm.file->f_path.dentry))
-			goto close_fail;
-		/*
-		 * AK: actually i see no reason to not allow this for named
-		 * pipes etc, but keep the previous behaviour for now.
-		 */
-		if (!S_ISREG(inode->i_mode))
-			goto close_fail;
-		/*
-		 * Don't dump core if the filesystem changed owner or mode
-		 * of the file during file creation. This is an issue when
-		 * a process dumps core while its cwd is e.g. on a vfat
-		 * filesystem.
-		 */
-		idmap = file_mnt_idmap(cprm.file);
-		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
-				    current_fsuid())) {
-			coredump_report_failure("Core dump to %s aborted: "
-				"cannot preserve file owner", cn.corename);
-			goto close_fail;
-		}
-		if ((inode->i_mode & 0677) != 0600) {
-			coredump_report_failure("Core dump to %s aborted: "
-				"cannot preserve file permissions", cn.corename);
-			goto close_fail;
-		}
-		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
-			goto close_fail;
-		if (do_truncate(idmap, cprm.file->f_path.dentry,
-				0, 0, cprm.file))
+	case COREDUMP_FILE:
+		if (!coredump_file(&cn, &cprm, binfmt))
 			goto close_fail;
 		break;
-	}
 	case COREDUMP_PIPE: {
 		int argi;
 		int dump_count;

-- 
2.47.2


