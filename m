Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A321F2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGNNee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:34:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49368 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgGNNed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:34:33 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL4q-0007hJ-Dn; Tue, 14 Jul 2020 07:34:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL4n-0006tw-W9; Tue, 14 Jul 2020 07:34:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
Date:   Tue, 14 Jul 2020 08:31:40 -0500
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 14 Jul 2020 08:27:41 -0500")
Message-ID: <87wo365ikj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL4n-0006tw-W9;;;mid=<87wo365ikj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fV97egYUdztXu6oLqZ7O0Th26wzy3roE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,T_TooManySym_01,
        XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2006 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (0.2%), b_tie_ro: 3.2 (0.2%), parse: 1.62
        (0.1%), extract_message_metadata: 14 (0.7%), get_uri_detail_list: 4.6
        (0.2%), tests_pri_-1000: 2.9 (0.1%), tests_pri_-950: 1.06 (0.1%),
        tests_pri_-900: 0.88 (0.0%), tests_pri_-90: 169 (8.4%), check_bayes:
        155 (7.7%), b_tokenize: 30 (1.5%), b_tok_get_all: 17 (0.9%),
        b_comp_prob: 4.2 (0.2%), b_tok_touch_all: 99 (4.9%), b_finish: 0.76
        (0.0%), tests_pri_0: 1798 (89.6%), check_dkim_signature: 0.81 (0.0%),
        check_dkim_adsp: 2.6 (0.1%), poll_dns_idle: 0.78 (0.0%), tests_pri_10:
        2.7 (0.1%), tests_pri_500: 8 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/7] exec: Implement kernel_execve
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


To allow the kernel not to play games with set_fs to call exec
implement kernel_execve.  The function kernel_execve takes pointers
into kernel memory and copies the values pointed to onto the new
userspace stack.

The calls with arguments from kernel space of do_execve are replaced
with calls to kernel_execve.

The calls do_execve and do_execveat are made static as there are now
no callers outside of exec.

The comments that mention do_execve are updated to refer to
kernel_execve or execve depending on the circumstances.  In addition
to correcting the comments, this makes it easy to grep for do_execve
and verify it is not used.

Inspired-by: https://lkml.kernel.org/r/20200627072704.2447163-1-hch@lst.de
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/entry/entry_32.S      |  2 +-
 arch/x86/entry/entry_64.S      |  2 +-
 arch/x86/kernel/unwind_frame.c |  2 +-
 fs/exec.c                      | 88 +++++++++++++++++++++++++++++++++-
 include/linux/binfmts.h        |  9 +---
 init/main.c                    |  4 +-
 kernel/umh.c                   |  6 +--
 security/tomoyo/common.h       |  2 +-
 security/tomoyo/domain.c       |  4 +-
 security/tomoyo/tomoyo.c       |  4 +-
 10 files changed, 100 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 024d7d276cd4..8f4e085ee06d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -854,7 +854,7 @@ SYM_CODE_START(ret_from_fork)
 	CALL_NOSPEC ebx
 	/*
 	 * A kernel thread is allowed to return here after successfully
-	 * calling do_execve().  Exit to userspace to complete the execve()
+	 * calling kernel_execve().  Exit to userspace to complete the execve()
 	 * syscall.
 	 */
 	movl	$0, PT_EAX(%esp)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2a00c97e53f..73c7e255256b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -293,7 +293,7 @@ SYM_CODE_START(ret_from_fork)
 	CALL_NOSPEC rbx
 	/*
 	 * A kernel thread is allowed to return here after successfully
-	 * calling do_execve().  Exit to userspace to complete the execve()
+	 * calling kernel_execve().  Exit to userspace to complete the execve()
 	 * syscall.
 	 */
 	movq	$0, RAX(%rsp)
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 722a85f3b2dd..e40b4942157f 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -275,7 +275,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		 * This user_mode() check is slightly broader than a PF_KTHREAD
 		 * check because it also catches the awkward situation where a
 		 * newly forked kthread transitions into a user task by calling
-		 * do_execve(), which eventually clears PF_KTHREAD.
+		 * kernel_execve(), which eventually clears PF_KTHREAD.
 		 */
 		if (!user_mode(regs))
 			goto the_end;
diff --git a/fs/exec.c b/fs/exec.c
index f8135dc149b3..3698252719a3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -448,6 +448,23 @@ static int count(struct user_arg_ptr argv, int max)
 	return i;
 }
 
+static int count_strings_kernel(const char *const *argv)
+{
+	int i;
+
+	if (!argv)
+		return 0;
+
+	for (i = 0; argv[i]; ++i) {
+		if (i >= MAX_ARG_STRINGS)
+			return -E2BIG;
+		if (fatal_signal_pending(current))
+			return -ERESTARTNOHAND;
+		cond_resched();
+	}
+	return i;
+}
+
 static int bprm_stack_limits(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
@@ -624,6 +641,20 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 }
 EXPORT_SYMBOL(copy_string_kernel);
 
+static int copy_strings_kernel(int argc, const char *const *argv,
+			       struct linux_binprm *bprm)
+{
+	while (argc-- > 0) {
+		int ret = copy_string_kernel(argv[argc], bprm);
+		if (ret < 0)
+			return ret;
+		if (fatal_signal_pending(current))
+			return -ERESTARTNOHAND;
+		cond_resched();
+	}
+	return 0;
+}
+
 #ifdef CONFIG_MMU
 
 /*
@@ -1991,7 +2022,60 @@ static int do_execveat_common(int fd, struct filename *filename,
 	return retval;
 }
 
-int do_execve(struct filename *filename,
+int kernel_execve(const char *kernel_filename,
+		  const char *const *argv, const char *const *envp)
+{
+	struct filename *filename;
+	struct linux_binprm *bprm;
+	int fd = AT_FDCWD;
+	int retval;
+
+	filename = getname_kernel(kernel_filename);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
+
+	bprm = alloc_bprm(fd, filename);
+	if (IS_ERR(bprm)) {
+		retval = PTR_ERR(bprm);
+		goto out_ret;
+	}
+
+	retval = count_strings_kernel(argv);
+	if (retval < 0)
+		goto out_free;
+	bprm->argc = retval;
+
+	retval = count_strings_kernel(envp);
+	if (retval < 0)
+		goto out_free;
+	bprm->envc = retval;
+
+	retval = bprm_stack_limits(bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_string_kernel(bprm->filename, bprm);
+	if (retval < 0)
+		goto out_free;
+	bprm->exec = bprm->p;
+
+	retval = copy_strings_kernel(bprm->envc, envp, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = copy_strings_kernel(bprm->argc, argv, bprm);
+	if (retval < 0)
+		goto out_free;
+
+	retval = bprm_execve(bprm, fd, filename, 0);
+out_free:
+	free_bprm(bprm);
+out_ret:
+	putname(filename);
+	return retval;
+}
+
+static int do_execve(struct filename *filename,
 	const char __user *const __user *__argv,
 	const char __user *const __user *__envp)
 {
@@ -2000,7 +2084,7 @@ int do_execve(struct filename *filename,
 	return do_execveat_common(AT_FDCWD, filename, argv, envp, 0);
 }
 
-int do_execveat(int fd, struct filename *filename,
+static int do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *__argv,
 		const char __user *const __user *__envp,
 		int flags)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8e9e1b0c8eb8..0571701ab1c5 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -135,12 +135,7 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
-extern int do_execve(struct filename *,
-		     const char __user * const __user *,
-		     const char __user * const __user *);
-extern int do_execveat(int, struct filename *,
-		       const char __user * const __user *,
-		       const char __user * const __user *,
-		       int);
+int kernel_execve(const char *filename,
+		  const char *const *argv, const char *const *envp);
 
 #endif /* _LINUX_BINFMTS_H */
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..78ccec5c28f3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1329,9 +1329,7 @@ static int run_init_process(const char *init_filename)
 	pr_debug("  with environment:\n");
 	for (p = envp_init; *p; p++)
 		pr_debug("    %s\n", *p);
-	return do_execve(getname_kernel(init_filename),
-		(const char __user *const __user *)argv_init,
-		(const char __user *const __user *)envp_init);
+	return kernel_execve(init_filename, argv_init, envp_init);
 }
 
 static int try_to_run_init_process(const char *init_filename)
diff --git a/kernel/umh.c b/kernel/umh.c
index 6ca2096298b9..a25433f9cd9a 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -98,9 +98,9 @@ static int call_usermodehelper_exec_async(void *data)
 
 	commit_creds(new);
 
-	retval = do_execve(getname_kernel(sub_info->path),
-			   (const char __user *const __user *)sub_info->argv,
-			   (const char __user *const __user *)sub_info->envp);
+	retval = kernel_execve(sub_info->path,
+			       (const char *const *)sub_info->argv,
+			       (const char *const *)sub_info->envp);
 out:
 	sub_info->retval = retval;
 	/*
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 050473df5809..85246b9df7ca 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -425,7 +425,7 @@ struct tomoyo_request_info {
 	struct tomoyo_obj_info *obj;
 	/*
 	 * For holding parameters specific to execve() request.
-	 * NULL if not dealing do_execve().
+	 * NULL if not dealing execve().
 	 */
 	struct tomoyo_execve *ee;
 	struct tomoyo_domain_info *domain;
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 7869d6a9980b..53b3e1f5f227 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -767,7 +767,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 
 	/*
 	 * Check for domain transition preference if "file execute" matched.
-	 * If preference is given, make do_execve() fail if domain transition
+	 * If preference is given, make execve() fail if domain transition
 	 * has failed, for domain transition preference should be used with
 	 * destination domain defined.
 	 */
@@ -810,7 +810,7 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		snprintf(ee->tmp, TOMOYO_EXEC_TMPSIZE - 1, "<%s>",
 			 candidate->name);
 		/*
-		 * Make do_execve() fail if domain transition across namespaces
+		 * Make execve() fail if domain transition across namespaces
 		 * has failed.
 		 */
 		reject_on_transition_failure = true;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index f9adddc42ac8..1f3cd432d830 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -93,7 +93,7 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/*
-	 * Execute permission is checked against pathname passed to do_execve()
+	 * Execute permission is checked against pathname passed to execve()
 	 * using current domain.
 	 */
 	if (!s->old_domain_info) {
@@ -307,7 +307,7 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
  */
 static int tomoyo_file_open(struct file *f)
 {
-	/* Don't check read permission here if called from do_execve(). */
+	/* Don't check read permission here if called from execve(). */
 	if (current->in_execve)
 		return 0;
 	return tomoyo_check_open_permission(tomoyo_domain(), &f->f_path,
-- 
2.25.0

