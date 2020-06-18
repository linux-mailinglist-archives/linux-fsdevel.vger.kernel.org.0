Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A941FF57D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgFROrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbgFROq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1623C0613EE;
        Thu, 18 Jun 2020 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mURemflipje9eYopYQ4h3uusWn3YXYVAu+uuVrAN7pQ=; b=kA5It9LXoCPgN2BYziDbM80GqD
        HNtc44noe0ziA2eM3+KnyYzL2pd9oPqUGY/hUyInHd4ySLhwj7ScmcxXWYiUZ8X0bzJXAr9xNOTWy
        XAL/Vyg+gWKjvWRc1E46rhhT7AOoW4mrfJlxWuJxTuddQpBofcYrNB89ps71ShaKx3Ry0Bbp3iKes
        MwTRfZBvvCyKfoCWzk8qlqM3YOI5jbBEH3fb+nboMCjgRqJpnZniKVcLE73368aPa8bVLT0gfgBNx
        QfO5mX3WRfFAi9Uo2QBs0WrtGfH5kATksJqu8IWhrMAYgxSqoQwY/z5+BWNKFpsAACV6e9liGk9uR
        obH6TmyQ==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvoT-0006Tl-UP; Thu, 18 Jun 2020 14:46:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] exec: add a kernel_execveat helper
Date:   Thu, 18 Jun 2020 16:46:26 +0200
Message-Id: <20200618144627.114057-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618144627.114057-1-hch@lst.de>
References: <20200618144627.114057-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a kernel_execveat helper to execute a binary with kernel space argv
and envp pointers.  Switch executing init and user mode helpers to this
new helper instead of relying on the implicit set_fs(KERNEL_DS) for early
init code and kernel threads, and move the getname call into the
do_execve helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c               | 109 ++++++++++++++++++++++++++++++++--------
 include/linux/binfmts.h |   6 +--
 init/main.c             |   6 +--
 kernel/umh.c            |   8 ++-
 4 files changed, 95 insertions(+), 34 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 34781db6bf6889..7923b8334ae600 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -435,6 +435,21 @@ static int count_strings(const char __user *const __user *argv)
 	return i;
 }
 
+static int count_kernel_strings(const char *const *argv)
+{
+	int i;
+
+	if (!argv)
+		return 0;
+
+	for (i = 0; argv[i]; i++) {
+		if (i >= MAX_ARG_STRINGS)
+			return -E2BIG;
+	}
+
+	return i;
+}
+
 static int check_arg_limit(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
@@ -611,6 +626,19 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(copy_string_kernel);
 
+static int copy_strings_kernel(int argc, const char *const *argv,
+		struct linux_binprm *bprm)
+{
+	int ret;
+
+	while (argc-- > 0) {
+		ret = copy_string_kernel(argv[argc], bprm);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 #ifdef CONFIG_MMU
 
 /*
@@ -1793,9 +1821,11 @@ static int exec_binprm(struct linux_binprm *bprm)
 	return 0;
 }
 
-int do_execveat(int fd, struct filename *filename,
+static int __do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp,
+		const char *const *kernel_argv,
+		const char *const *kernel_envp,
 		int flags, struct file *file)
 {
 	char *pathbuf = NULL;
@@ -1876,16 +1906,30 @@ int do_execveat(int fd, struct filename *filename,
 	if (retval)
 		goto out_unmark;
 
-	bprm->argc = count_strings(argv);
-	if (bprm->argc < 0) {
-		retval = bprm->argc;
-		goto out;
-	}
+	if (unlikely(kernel_argv)) {
+		bprm->argc = count_kernel_strings(kernel_argv);
+		if (bprm->argc < 0) {
+			retval = bprm->argc;
+			goto out;
+		}
 
-	bprm->envc = count_strings(envp);
-	if (bprm->envc < 0) {
-		retval = bprm->envc;
-		goto out;
+		bprm->envc = count_kernel_strings(kernel_envp);
+		if (bprm->envc < 0) {
+			retval = bprm->envc;
+			goto out;
+		}
+	} else {
+		bprm->argc = count_strings(argv);
+		if (bprm->argc < 0) {
+			retval = bprm->argc;
+			goto out;
+		}
+
+		bprm->envc = count_strings(envp);
+		if (bprm->envc < 0) {
+			retval = bprm->envc;
+			goto out;
+		}
 	}
 
 	retval = check_arg_limit(bprm);
@@ -1902,13 +1946,22 @@ int do_execveat(int fd, struct filename *filename,
 		goto out;
 
 	bprm->exec = bprm->p;
-	retval = copy_strings(bprm->envc, envp, bprm);
-	if (retval < 0)
-		goto out;
 
-	retval = copy_strings(bprm->argc, argv, bprm);
-	if (retval < 0)
-		goto out;
+	if (unlikely(kernel_argv)) {
+		retval = copy_strings_kernel(bprm->envc, kernel_envp, bprm);
+		if (retval < 0)
+			goto out;
+		retval = copy_strings_kernel(bprm->argc, kernel_argv, bprm);
+		if (retval < 0)
+			goto out;
+	} else {
+		retval = copy_strings(bprm->envc, envp, bprm);
+		if (retval < 0)
+			goto out;
+		retval = copy_strings(bprm->argc, argv, bprm);
+		if (retval < 0)
+			goto out;
+	}
 
 	retval = exec_binprm(bprm);
 	if (retval < 0)
@@ -1959,6 +2012,23 @@ int do_execveat(int fd, struct filename *filename,
 	return retval;
 }
 
+static int do_execveat(int fd, const char *filename,
+		       const char __user *const __user *argv,
+		       const char __user *const __user *envp, int flags)
+{
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
+
+	return __do_execveat(fd, name, argv, envp, NULL, NULL, flags, NULL);
+}
+
+int kernel_execveat(int fd, const char *filename, const char *const *argv,
+		const char *const *envp, int flags, struct file *file)
+{
+	return __do_execveat(fd, getname_kernel(filename), NULL, NULL, argv,
+			     envp, flags, file);
+}
+
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct mm_struct *mm = current->mm;
@@ -1988,7 +2058,7 @@ SYSCALL_DEFINE3(execve,
 		const char __user *const __user *, argv,
 		const char __user *const __user *, envp)
 {
-	return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
+	return do_execveat(AT_FDCWD, filename, argv, envp, 0);
 }
 
 SYSCALL_DEFINE5(execveat,
@@ -1997,8 +2067,5 @@ SYSCALL_DEFINE5(execveat,
 		const char __user *const __user *, envp,
 		int, flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
-	struct filename *name = getname_flags(filename, lookup_flags, NULL);
-
-	return do_execveat(fd, name, argv, envp, flags, NULL);
+	return do_execveat(fd, filename, argv, envp, flags);
 }
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index bed702e4b1fbd9..1e61c980c16354 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -134,9 +134,7 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
-int do_execveat(int fd, struct filename *filename,
-		const char __user *const __user *__argv,
-		const char __user *const __user *__envp,
-		int flags, struct file *file);
+int kernel_execveat(int fd, const char *filename, const char *const *argv,
+		const char *const *envp, int flags, struct file *file);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/init/main.c b/init/main.c
index 838950ea7bca22..33de235dc2aa00 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1329,10 +1329,8 @@ static int run_init_process(const char *init_filename)
 	pr_debug("  with environment:\n");
 	for (p = envp_init; *p; p++)
 		pr_debug("    %s\n", *p);
-	return do_execveat(AT_FDCWD, getname_kernel(init_filename),
-			(const char __user *const __user *)argv_init,
-			(const char __user *const __user *)envp_init,
-			0, NULL);
+	return kernel_execveat(AT_FDCWD, init_filename, argv_init, envp_init, 0,
+			       NULL);
 }
 
 static int try_to_run_init_process(const char *init_filename)
diff --git a/kernel/umh.c b/kernel/umh.c
index 7aa9a5817582ca..1284823dbad338 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -103,11 +103,9 @@ static int call_usermodehelper_exec_async(void *data)
 	commit_creds(new);
 
 	sub_info->pid = task_pid_nr(current);
-	retval = do_execveat(AT_FDCWD,
-			sub_info->path ? getname_kernel(sub_info->path) : NULL,
-			(const char __user *const __user *)sub_info->argv,
-			(const char __user *const __user *)sub_info->envp,
-			0, sub_info->file);
+	retval = kernel_execveat(AT_FDCWD, sub_info->path,
+			(const char *const *)sub_info->argv,
+			(const char *const *)sub_info->envp, 0, sub_info->file);
 	if (sub_info->file && !retval)
 		current->flags |= PF_UMH;
 out:
-- 
2.26.2

