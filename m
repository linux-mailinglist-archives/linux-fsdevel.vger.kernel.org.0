Return-Path: <linux-fsdevel+bounces-53056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00296AE95DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9438C3A9F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0825C6E5;
	Thu, 26 Jun 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBUemkcT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tO6ZIH+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF8239E69;
	Thu, 26 Jun 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918225; cv=none; b=NEjJdX3IleZ6Cb26bNH+mwyd4F3yxh7nfE4ADB4UGdcWN3lSBazmgwyO0dYciOU7rWox2xPO1rZACtrOMJMEW6xVRcCE08qMtb0dEQwTN/ugzn5YhSlfDkJDHkV5xjdVvp7Xt+1SvY8EPjnOtTlGDb19X5hZIoUb4+HQYmo+yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918225; c=relaxed/simple;
	bh=sBjfYGI0Ye62nwsuUzArqmK5roAkvp0KfDA11tMTt7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4H4GskXfB5Tm8gYdl/zv9VEnp98XS8MQZBi0D3It70AoasQ+VXoQlR+Pr4BkF4IKZB8fHNAK0D8LqOCAF9+WFBtRTozoM6pbPjXjGue/WUnC32M5vm3bmCR5Bw6ziCVNnocZQsUSfdBc9BxQrDJ7Fr7/ScOSfaLniKGkguE+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBUemkcT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tO6ZIH+h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvxDeHqReCMnKL0ZkklMAI73M6eNLpJ24PnvZxi/D5I=;
	b=lBUemkcTrECzCAtqtNXrwears5+/0uqhMeUhAZ8T7iXoRP2CS4hfkRVW69OJqophFMggnx
	411UniDm6MMffmuuw49Fbegvvc8AVCl8VhnJVr6HRv2XlwlS4oyt/DlgjBLKgpCvIoLnUe
	VNTCdBDpJYggwmlSRyvZnFkjueruXuhvD49yvfuQaFf1OWrQr3ftsKdz3bkht09PQV/j+e
	d425AIC9Lo/v58kWbBmn45RwIHJJvvtbAw423lpQlT/3Bs0pyB/9ls+A/YZnOnZvYF1j2b
	yJx6HKJv+/MSWJudwZmemNnZslJgTIyQizxNL/EcODHyaMGWAdjqoHMbIzRj5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvxDeHqReCMnKL0ZkklMAI73M6eNLpJ24PnvZxi/D5I=;
	b=tO6ZIH+ht1kx3JfAie1o3QKCp5+JqjvIAYyfRyZSwqxPJvW9/YxiS9bM2e/jztjaQyFg/x
	0ClAyqEWHohUBiAw==
Date: Thu, 26 Jun 2025 08:10:14 +0200
Subject: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for KUnit
 UAPI support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=5134;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sBjfYGI0Ye62nwsuUzArqmK5roAkvp0KfDA11tMTt7M=;
 b=vrDbmutA8uylluHH9xjOd5CW4G8kx/DVbirsPADi4HdNHbf8GZ+SCKc07p2MdW4kDWDs9XKZi
 jF6BhMMbyzqCGRSU8X11C2Qv6GxF57woQXwfQI9mbn2dpj5+qiG+U3H
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The KUnit UAPI infrastructure starts userspace processes.
As it should be able to be built as a module, export the necessary symbols.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
To: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org

./get_maintainer.pl would have also Cc-ed all of the memory management and
scheduler maintainers. I trimmed the list to only BINFMT/EXEC and VFS.
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


