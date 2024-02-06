Return-Path: <linux-fsdevel+bounces-10408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3B84ABA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE26286526
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2467C4C69;
	Tue,  6 Feb 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPfzIhge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3E6FB0;
	Tue,  6 Feb 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183178; cv=none; b=ksDrI43oR0OqXFQZK7Afl/3qfjHnRGU14Yn7YXPAABacFzPUubqPl/zE8fzvjPAUtMmtMM88wyDEb2jcJvscsqzTzcM42wNBkeM193zJxwkb5CS+gGaujgcsODNuYGLfYXgHN3unz+ZUpRBx6wIDSIjDxtiiPNr6zZ7V7NNEWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183178; c=relaxed/simple;
	bh=SK7BUVmWI8e3vR555Ph71rlM/avdD4/Eeg+aPP6iOt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdKKkK7XZCIxJ5WiXQU/eG9TJLmCU+Bnhsxf/3PEHC3xyX8D8kvcRks6ZReDY/6d2MAZQymWmMrtTWMTt0Gu57afApW0qXPIZVpGT878BSHla6iAlBBlVvGAWM4N9v+QzTN4zbJ0DPNRB8H5n00btsgzhDMp6bb+5HfZcx7t2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPfzIhge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1D6C433F1;
	Tue,  6 Feb 2024 01:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707183178;
	bh=SK7BUVmWI8e3vR555Ph71rlM/avdD4/Eeg+aPP6iOt4=;
	h=From:To:Cc:Subject:Date:From;
	b=GPfzIhgeaeM7jS/S68VCmgXDwU3b54ge5vhTEAlFasFYm8eaQVjaObBjCke88E9/T
	 n0+aJAE2WFu1rZ+8oonOY2KVhrpBq8QH24KdncABOastyeHEdqKOxL4C+0dQOUQ0gY
	 08O4oy6U7ZR2cfsGfoFGbUqHL3DJQj9YBtoA6gdmqO9umgefzEmSEZtdC6HbTlV8PR
	 wCSbOR6Q0pD+8loCCMB/giVLtjeUO2Of79shn5/teoeD/ddEsK8BxbZtrR6awU4ELx
	 x87YITXtBrqtwgo3fCeOTTxPDqgFIDK8terX3xgnMLnKCHw+dvw+rGsGW7VmuKaawt
	 +3CisSAge8E8g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alfred Piccioni <alpic@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 5.4,4.19] lsm: new security_file_ioctl_compat() hook
Date: Mon,  5 Feb 2024 17:29:53 -0800
Message-ID: <20240206012953.114308-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alfred Piccioni <alpic@google.com>

commit f1bb47a31dff6d4b34fb14e99850860ee74bb003 upstream.
[Please apply to 5.4-stable and 4.19-stable.  The upstream commit failed
to apply to these kernels.  This patch resolves the conflicts.]

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneously, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file
permissions.

This was also noted in a RED-PEN finding from a while back -
"/* RED-PEN how should LSM module know it's handling 32bit? */".

This patch introduces a new hook, security_file_ioctl_compat(), that is
called from the compat ioctl syscall. All current LSMs have been changed
to support this hook.

Reviewing the three places where we are currently using
security_file_ioctl(), it appears that only SELinux needs a dedicated
compat change; TOMOYO and SMACK appear to be functional without any
change.

Cc: stable@vger.kernel.org
Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject tweak, line length fixes, and alignment corrections]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/compat_ioctl.c          |  3 +--
 include/linux/lsm_hooks.h  |  9 +++++++++
 include/linux/security.h   |  9 +++++++++
 security/security.c        | 17 +++++++++++++++++
 security/selinux/hooks.c   | 28 ++++++++++++++++++++++++++++
 security/smack/smack_lsm.c |  1 +
 security/tomoyo/tomoyo.c   |  1 +
 7 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 8fcc53d83af2d..22f7dc6688dee 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -994,8 +994,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (!f.file)
 		goto out;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out_fput;
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a21dc5413653e..0f4897e97c70f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -498,6 +498,12 @@
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
  *	Return 0 if permission is granted.
+ * @file_ioctl_compat:
+ *	@file contains the file structure.
+ *	@cmd contains the operation to perform.
+ *	@arg contains the operational arguments.
+ *	Check permission for a compat ioctl operation on @file.
+ *	Return 0 if permission is granted.
  * @mmap_addr :
  *	Check permissions for a mmap operation at @addr.
  *	@addr contains virtual address that will be used for the operation.
@@ -1602,6 +1608,8 @@ union security_list_options {
 	void (*file_free_security)(struct file *file);
 	int (*file_ioctl)(struct file *file, unsigned int cmd,
 				unsigned long arg);
+	int (*file_ioctl_compat)(struct file *file, unsigned int cmd,
+				unsigned long arg);
 	int (*mmap_addr)(unsigned long addr);
 	int (*mmap_file)(struct file *file, unsigned long reqprot,
 				unsigned long prot, unsigned long flags);
@@ -1907,6 +1915,7 @@ struct security_hook_heads {
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
 	struct hlist_head file_ioctl;
+	struct hlist_head file_ioctl_compat;
 	struct hlist_head mmap_addr;
 	struct hlist_head mmap_file;
 	struct hlist_head file_mprotect;
diff --git a/include/linux/security.h b/include/linux/security.h
index aa5c7141c8d17..1a99958b850b5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -362,6 +362,8 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -907,6 +909,13 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_file_ioctl_compat(struct file *file,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/security/security.c b/security/security.c
index 460c3826f6401..6c06296548c21 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1422,6 +1422,23 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
 }
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit
+ * processes running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c1bf319b459a9..6fec9fba41a84 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3668,6 +3668,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to
+	 * make sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -6933,6 +6960,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9e48c8b36b678..6f2613f874fa9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4648,6 +4648,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 716c92ec941ad..0176612bac967 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -554,6 +554,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),

base-commit: f0602893f43a54097fcf22bd8c2f7b8e75ca643e
-- 
2.43.0


