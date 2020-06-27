Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8820BF6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 09:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgF0H1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 03:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0H1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:27:35 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562FC03E979;
        Sat, 27 Jun 2020 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R3jVFYS/2IFPi5AjMtMLrTJqX+oMKfiLgBtiR94GLYw=; b=Bn9qUHm8sqZ6dyAsMNQeF1SAQK
        qOz9odcsurHGAun+rlEGFX2naZtghMIA4iNCvdFucZaRqG67gU/BFGYWdiPHinPyemWT8K/dzUAC7
        BVUbz/HKtOV9kKV/EgSZKqY2fG0hCnWFXUMTpwq7lDPtzTsQiuS6/bg/Bz8z2nftTY5L3gSJAoAXB
        Pn6BkPkmQEIAxTwtxkFd96A/2BLD9LG+ifLQGyGRS0vLmAK3CbtSvaZMgTeyuPHWg8dZGx1nW1cWK
        Rr6EilWm74qOfkU1wwZa8elvp1Pu8z7WO97rTp0rUob9lw/SesjmfOOTo/qO94XivoWoxm2YE1gP5
        DmesbwuA==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5F2-0006WL-Mh; Sat, 27 Jun 2020 07:27:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] exec: cleanup the execve wrappers
Date:   Sat, 27 Jun 2020 09:27:00 +0200
Message-Id: <20200627072704.2447163-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627072704.2447163-1-hch@lst.de>
References: <20200627072704.2447163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a whole bunch of wrappers that eventually all call
__do_execve_file, and consolidate the execvce helpers to:

  (1) __do_execveat, which is the lowest level helper implementing the
      actual functionality
  (2) do_execvat, which is used by all callers that want native
      pointers
  (3) do_compat_execve, which is used by all compat syscalls

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c               | 98 +++++++++++------------------------------
 include/linux/binfmts.h | 12 ++---
 init/main.c             |  7 +--
 kernel/umh.c            | 16 +++----
 4 files changed, 41 insertions(+), 92 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a7032784..354fdaa536ae7d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1815,10 +1815,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return 0;
 }
 
-/*
- * sys_execve() executes a new program.
- */
-static int __do_execve_file(int fd, struct filename *filename,
+static int __do_execveat(int fd, struct filename *filename,
 			    struct user_arg_ptr argv,
 			    struct user_arg_ptr envp,
 			    int flags, struct file *file)
@@ -1972,74 +1969,16 @@ static int __do_execve_file(int fd, struct filename *filename,
 	return retval;
 }
 
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
-{
-	return __do_execve_file(fd, filename, argv, envp, flags, NULL);
-}
-
-int do_execve_file(struct file *file, void *__argv, void *__envp)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-
-	return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
-}
-
-int do_execve(struct filename *filename,
-	const char __user *const __user *__argv,
-	const char __user *const __user *__envp)
-{
-	struct user_arg_ptr argv = { .ptr.native = __argv };
-	struct user_arg_ptr envp = { .ptr.native = __envp };
-	return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
-}
-
 int do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *__argv,
 		const char __user *const __user *__envp,
-		int flags)
+		int flags, struct file *file)
 {
 	struct user_arg_ptr argv = { .ptr.native = __argv };
 	struct user_arg_ptr envp = { .ptr.native = __envp };
 
-	return do_execveat_common(fd, filename, argv, envp, flags);
-}
-
-#ifdef CONFIG_COMPAT
-static int compat_do_execve(struct filename *filename,
-	const compat_uptr_t __user *__argv,
-	const compat_uptr_t __user *__envp)
-{
-	struct user_arg_ptr argv = {
-		.is_compat = true,
-		.ptr.compat = __argv,
-	};
-	struct user_arg_ptr envp = {
-		.is_compat = true,
-		.ptr.compat = __envp,
-	};
-	return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
-}
-
-static int compat_do_execveat(int fd, struct filename *filename,
-			      const compat_uptr_t __user *__argv,
-			      const compat_uptr_t __user *__envp,
-			      int flags)
-{
-	struct user_arg_ptr argv = {
-		.is_compat = true,
-		.ptr.compat = __argv,
-	};
-	struct user_arg_ptr envp = {
-		.is_compat = true,
-		.ptr.compat = __envp,
-	};
-	return do_execveat_common(fd, filename, argv, envp, flags);
+	return __do_execveat(fd, filename, argv, envp, flags, file);
 }
-#endif
 
 void set_binfmt(struct linux_binfmt *new)
 {
@@ -2070,7 +2009,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execve(getname(filename), argv, envp);
+	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
 }
 
 SYSCALL_DEFINE5(execveat,
@@ -2080,18 +2019,34 @@ SYSCALL_DEFINE5(execveat,
 		int, flags)
 {
 	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
 
-	return do_execveat(fd,
-			   getname_flags(filename, lookup_flags, NULL),
-			   argv, envp, flags);
+	return do_execveat(fd, name, argv, envp, flags, NULL);
 }
 
 #ifdef CONFIG_COMPAT
+static int do_compat_execve(int fd, struct filename *filename,
+		const compat_uptr_t __user *__argv,
+		const compat_uptr_t __user *__envp,
+		int flags)
+{
+	struct user_arg_ptr argv = {
+		.is_compat = true,
+		.ptr.compat = __argv,
+	};
+	struct user_arg_ptr envp = {
+		.is_compat = true,
+		.ptr.compat = __envp,
+	};
+
+	return __do_execveat(fd, filename, argv, envp, flags, NULL);
+}
+
 COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
 	const compat_uptr_t __user *, argv,
 	const compat_uptr_t __user *, envp)
 {
-	return compat_do_execve(getname(filename), argv, envp);
+	return do_compat_execve(AT_FDCWD, getname(filename), argv, envp, 0);
 }
 
 COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
@@ -2101,9 +2056,8 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 		       int,  flags)
 {
 	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
 
-	return compat_do_execveat(fd,
-				  getname_flags(filename, lookup_flags, NULL),
-				  argv, envp, flags);
+	return do_compat_execve(fd, name, argv, envp, flags);
 }
 #endif
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 4a20b7517dd036..bed702e4b1fbd9 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -134,13 +134,9 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
-extern int do_execve(struct filename *,
-		     const char __user * const __user *,
-		     const char __user * const __user *);
-extern int do_execveat(int, struct filename *,
-		       const char __user * const __user *,
-		       const char __user * const __user *,
-		       int);
-int do_execve_file(struct file *file, void *__argv, void *__envp);
+int do_execveat(int fd, struct filename *filename,
+		const char __user *const __user *__argv,
+		const char __user *const __user *__envp,
+		int flags, struct file *file);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5aa2..838950ea7bca22 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1329,9 +1329,10 @@ static int run_init_process(const char *init_filename)
 	pr_debug("  with environment:\n");
 	for (p = envp_init; *p; p++)
 		pr_debug("    %s\n", *p);
-	return do_execve(getname_kernel(init_filename),
-		(const char __user *const __user *)argv_init,
-		(const char __user *const __user *)envp_init);
+	return do_execveat(AT_FDCWD, getname_kernel(init_filename),
+			(const char __user *const __user *)argv_init,
+			(const char __user *const __user *)envp_init,
+			0, NULL);
 }
 
 static int try_to_run_init_process(const char *init_filename)
diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03c6..7aa9a5817582ca 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -103,15 +103,13 @@ static int call_usermodehelper_exec_async(void *data)
 	commit_creds(new);
 
 	sub_info->pid = task_pid_nr(current);
-	if (sub_info->file) {
-		retval = do_execve_file(sub_info->file,
-					sub_info->argv, sub_info->envp);
-		if (!retval)
-			current->flags |= PF_UMH;
-	} else
-		retval = do_execve(getname_kernel(sub_info->path),
-				   (const char __user *const __user *)sub_info->argv,
-				   (const char __user *const __user *)sub_info->envp);
+	retval = do_execveat(AT_FDCWD,
+			sub_info->path ? getname_kernel(sub_info->path) : NULL,
+			(const char __user *const __user *)sub_info->argv,
+			(const char __user *const __user *)sub_info->envp,
+			0, sub_info->file);
+	if (sub_info->file && !retval)
+		current->flags |= PF_UMH;
 out:
 	sub_info->retval = retval;
 	/*
-- 
2.26.2

