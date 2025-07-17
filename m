Return-Path: <linux-fsdevel+bounces-55223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8179B08859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E633D1AA7214
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2684D28B511;
	Thu, 17 Jul 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d8oTzFqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZ6uFZe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED728030E;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742146; cv=none; b=XldYuDdIfmzKhS4iP+PpYI6+EyZ4mJy+uW9sMJJdeTM4L8LQUMkATAbZVWEt54AAE7U1ulZT/6VCzlxabeGLl79/I8lkLjRP7fWvlot0Dzzv+pH674bprUQeh49mWt3i2Qgqps6breg46vIBl4iFcUgmAIP/Rzr5zYgOtl+7E+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742146; c=relaxed/simple;
	bh=e5INoDiN3Ni8QRATpOXYa4LnNZtNpkknNpkiBqwwmSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQ+aCHwa+tvrmvQgYd1DlktDFa//5/MLH46/klwjhgl6l9Z64wb6WsFV5ZhxSe89hBNUOs5FV4/I7XqlPlkPSFr1/e/Ps/80ihva5eJpgOw6yg78sxCnFl0ZPf+V9C/d9PjoS7dP89vNBaflvIBwp+b4nGrhrfo+mxY9T8GwloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d8oTzFqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZ6uFZe1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MpYHuvMjFWWKu6Z/zYB3Mv8gm+e0pCu+LkUQrZSY3U=;
	b=d8oTzFqJXGnBOvO4zb6cDa5rul2gJUTTSkcahTe/BRpx/iywuRWwT4xroLXY6VNdnh3QZO
	RHV/IsU6AgdRkJxSFPZ7vIZP6F6jO33pX5kuHPHJGKUTJZYBPdGiDBtIJ/XHMAGEm/x4s2
	ywLUAaHuzknRTE+wI83TTNrERZ7Rl1Ved/qv0OIMfaJd8jW9PdCqSZ9lR5xkQZZzGwVy2y
	n1fL3jCk/xaG/3+VrkeFrvHhEMimW3KwNzytnF1TI0iPHaKMHAL5z7oBRJSv9QM/cxO9q8
	MPecXmf0A+I+NgNkN0GmLg8gxNIvH46QRwHVzubjmX+YMeVg9WnQ/9nUqa0oxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MpYHuvMjFWWKu6Z/zYB3Mv8gm+e0pCu+LkUQrZSY3U=;
	b=HZ6uFZe1pV6FRTSkcaX2SUoimPLdA9eDlpPYStwgYkLBSXHxZvPT4cQryUWLjvl4xnegwW
	BtIPfJ3KSAFlMtAg==
Date: Thu, 17 Jul 2025 10:48:08 +0200
Subject: [PATCH v5 06/15] fs,fork,exit: export symbols necessary for KUnit
 UAPI support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-6-442b711cde2e@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=4941;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=e5INoDiN3Ni8QRATpOXYa4LnNZtNpkknNpkiBqwwmSY=;
 b=wfPAfz0Y4PnhHoB3TtD/RceiqTS+353VN2/ItMuXvqsLsEeUYNcSU3SR921UGRtIT0MxXYMPk
 5poxQGlxv/wBEgVJPydBHOSY4lgE3Iw4v8Bg9/g2pPQIzqWk9ZPNFN8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The KUnit UAPI infrastructure starts userspace processes.
As it should be able to be built as a module, export the necessary symbols.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
For details on how these are used, see patch 12:
"kunit: Introduce UAPI testing framework".
Any ideas on how to make this work without new exports are very welcome.
---
 fs/exec.c        | 2 ++
 fs/file.c        | 1 +
 fs/filesystems.c | 2 ++
 fs/fs_struct.c   | 1 +
 fs/pipe.c        | 2 ++
 kernel/exit.c    | 3 +++
 kernel/fork.c    | 2 ++
 7 files changed, 13 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e392b342f122d35aba4cf035441c7..13f7f27641942eddcb179bdd93d99b799d155813 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/export.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1919,6 +1920,7 @@ int kernel_execve(const char *kernel_filename,
 	putname(filename);
 	return retval;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(kernel_execve, "kunit-uapi");
 
 static int do_execve(struct filename *filename,
 	const char __user *const __user *__argv,
diff --git a/fs/file.c b/fs/file.c
index 3a3146664cf37115624e12f7f06826d48827e9d7..89d07feb9c328337451ce40cb0f368b6cb986c2c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1317,6 +1317,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	spin_unlock(&files->file_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(replace_fd, "kunit-uapi");
 
 /**
  * receive_fd() - Install received file into file descriptor table
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 95e5256821a53494d88f496193305a2e50e04444..a3a588f387bbd8268246d1026389deaadf265d0b 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/fs_parser.h>
+#include <linux/export.h>
 
 /*
  * Handling of filesystem drivers list.
@@ -45,6 +46,7 @@ void put_filesystem(struct file_system_type *fs)
 {
 	module_put(fs->owner);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
 
 static struct file_system_type **find_filesystem(const char *name, unsigned len)
 {
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6889cc12603410e6e9dc44089586f..26340d225deba3f2ec30252293fdf417235a6a4a 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -46,6 +46,7 @@ void set_fs_pwd(struct fs_struct *fs, const struct path *path)
 	if (old_pwd.dentry)
 		path_put(&old_pwd);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(set_fs_pwd, "kunit-uapi");
 
 static inline int replace_path(struct path *p, const struct path *old, const struct path *new)
 {
diff --git a/fs/pipe.c b/fs/pipe.c
index 45077c37bad154ef146b047834d35d489fcc4d8d..d6cb743d2cfc041f08b498a5a764e9a96dc34069 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -27,6 +27,7 @@
 #include <linux/watch_queue.h>
 #include <linux/sysctl.h>
 #include <linux/sort.h>
+#include <linux/export.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -971,6 +972,7 @@ int create_pipe_files(struct file **res, int flags)
 	file_set_fsnotify_mode(res[1], FMODE_NONOTIFY_PERM);
 	return 0;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(create_pipe_files, "kunit-uapi");
 
 static int __do_pipe_flags(int *fd, struct file **files, int flags)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index bd743900354ca5fc6c550f80e30393a632eb9a4e..610dffb1276ac60b475708587ca053f315fea9c3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/export.h>
 
 #include <uapi/linux/wait.h>
 
@@ -1005,6 +1006,7 @@ void __noreturn do_exit(long code)
 	lockdep_free_task(tsk);
 	do_task_dead();
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(do_exit, "kunit-uapi");
 
 void __noreturn make_task_dead(int signr)
 {
@@ -1887,6 +1889,7 @@ int kernel_wait(pid_t pid, int *stat)
 	put_pid(wo.wo_pid);
 	return ret;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(kernel_wait, "kunit-uapi");
 
 SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
 		int, options, struct rusage __user *, ru)
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38bae1d2eb6de9494aea94b7a19e6c3..5de7a9bc005ade6dcfbdfe1a63cadbef8782658c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/export.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2676,6 +2677,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 
 	return kernel_clone(&args);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(user_mode_thread, "kunit-uapi");
 
 #ifdef __ARCH_WANT_SYS_FORK
 SYSCALL_DEFINE0(fork)

-- 
2.50.0


