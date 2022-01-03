Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4C4836E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiACSez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:34:55 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235661AbiACSey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:34:54 -0500
X-Greylist: delayed 855 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:34:52 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKbFZ983578;
        Mon, 3 Jan 2022 10:20:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234037;
        bh=wbAvlr10Npnd0/4eUIwpiZyKKD90fyNSB8BKvn+8AtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuzyqFBlViVazO6XJ+mK55v8TYoU8CSWPvRdS0zLHd2j/JRmo8KF8XPHNiDn7zK8f
         cKmWoGdlOtL+cYCiWXn0kFaBJFoDXFzVx/CwJtpUjqtzdDklwJeZsaKPnrhHMIUe/E
         X+0MBryfanY7Jvp2IFvl2tvrE2gZ/a0jv74eOnqpgaERy8SG0v03EsHZfuvinBjStp
         nAMPbwEXl0VbhyiPYC/MVtu+2OjqrYhLl4CJecOyf+fNVB3wrHaIwZLrl2zIht/lId
         IrdMi9fgeaOXX4b2ECra1EdLY0a0bdPgZHy1KGMB3KvjcdrqZ4r0gfPQXxoFaraRQ3
         rPmms9nrwMkTg==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKb1X983577;
        Mon, 3 Jan 2022 10:20:37 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 7/8] signals: Add signal debugging
Date:   Mon,  3 Jan 2022 10:19:55 -0800
Message-Id: <20220103181956.983342-8-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add CONFIG_SIGNALS_DEBUG, which provides /proc/sys/kern/sigset_size,
/proc/sys/kern/compat_sigset_size (if CONFIG_COMPAT is enabled),
/proc/sys/kern/max_sig and /proc/sys/kern/sigrtmax to indicate sigset
sizes, max signal number (_NSIG) and value of SIGRTMAX respectively.
This also adds /proc/<pid>/signal, which sends a signal number to
<pid> without going through libc.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 fs/proc/base.c         | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/signal.h |  1 +
 kernel/signal.c        | 15 ++++++++-----
 kernel/sysctl.c        | 41 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug      | 10 +++++++++
 5 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..75184abf9af1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3165,6 +3165,51 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_STACKLEAK_METRICS */
 
+#ifdef CONFIG_SIGNALS_DEBUG
+static ssize_t proc_signal_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct task_struct *task = get_proc_task(inode);
+	int ret;
+	pid_t pid;
+	unsigned long sig = (unsigned long) -1;
+
+	if (!task)
+		return -ESRCH;
+	if (*ppos != 0)
+		/* No partial writes. */
+		return -EINVAL;
+
+	if (count > 4 || count <= 1)
+		return -EINVAL;
+
+	ret = kstrtoul_from_user(buf, count, 10, &sig);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (!valid_signal(sig))
+		return -EINVAL;
+	if (sig == 0)
+		return count;
+
+	pid = pid_vnr(get_task_pid(task, PIDTYPE_PID));
+	if (pid == 0)
+		return -EINVAL;
+
+	ret = do_sys_kill(pid, sig);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations proc_signal_operations = {
+	.write		= proc_signal_write,
+	.llseek		= noop_llseek,
+};
+#endif	/* CONFIG_SIGNALS_DEBUG */
+
 /*
  * Thread groups
  */
@@ -3281,6 +3326,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SECCOMP_CACHE_DEBUG
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
+#ifdef CONFIG_SIGNALS_DEBUG
+	REG("signal",  S_IWUSR, proc_signal_operations),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 4084b765a6cc..b77f9472a37c 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -446,6 +446,7 @@ extern bool get_signal(struct ksignal *ksig);
 extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
+extern int do_sys_kill(pid_t pid, int sig);
 
 #define SIG_KTHREAD ((__force __sighandler_t)2)
 #define SIG_KTHREAD_KERNEL ((__force __sighandler_t)3)
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c846a017201..1ed392df55fb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3755,6 +3755,15 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
 	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
 }
 
+int do_sys_kill(pid_t pid, int sig)
+{
+	struct kernel_siginfo info;
+
+	prepare_kill_siginfo(sig, &info);
+
+	return kill_something_info(sig, &info, pid);
+}
+
 /**
  *  sys_kill - send a signal to a process
  *  @pid: the PID of the process
@@ -3762,11 +3771,7 @@ static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
  */
 SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
-	struct kernel_siginfo info;
-
-	prepare_kill_siginfo(sig, &info);
-
-	return kill_something_info(sig, &info, pid);
+	return do_sys_kill(pid, sig);
 }
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..0d7e1d16b75b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -139,6 +139,15 @@ static int minolduid;
 static int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
+#ifdef CONFIG_SIGNALS_DEBUG
+static int max_signal = _NSIG;
+static int sigrtmax = SIGRTMAX;
+static int sigset_size = sizeof(sigset_t);
+# ifdef CONFIG_COMPAT
+static int compat_sigset_size = sizeof(compat_sigset_t);
+# endif
+#endif
+
 /*
  * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
  * and hung_task_check_interval_secs
@@ -2717,6 +2726,38 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#endif
+#ifdef CONFIG_SIGNALS_DEBUG
+	{
+		.procname	= "max_signal",
+		.data		= &max_signal,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "sigrtmax",
+		.data		= &sigrtmax,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "sigset_size",
+		.data		= &sigset_size,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+# ifdef CONFIG_COMPAT
+	{
+		.procname	= "compat_sigset_size",
+		.data		= &compat_sigset_size,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+# endif
 #endif
 	{ }
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..c433356c1070 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2639,4 +2639,14 @@ endmenu # "Kernel Testing and Coverage"
 
 source "Documentation/Kconfig"
 
+config SIGNALS_DEBUG
+       bool "Enable basic signals debugging"
+       default n
+       help
+	 Provides several files in /proc to aid in debugging changes to
+	 the signals code: /proc/sys/kernel/max_signal,
+	 /proc/sys/kernel/sigrtmax and /proc/sys/kernel/sigset_size.
+	 Also adds /proc/<pid>/signal to allow sending a signal number
+	 to <pid> without going through libc.
+
 endmenu # Kernel hacking
-- 
2.30.2

