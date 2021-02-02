Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E64B30C810
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhBBRka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 12:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhBBRiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:38:25 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC047C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 09:37:41 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id o8so5219981ljp.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Yw2AQQjjN0qlybNUjTs4aWik4pvcwC2CB37OFNajzDc=;
        b=rUQDpLeqLdk5w526Fchik4CgVhp8n9H/4HYuYgHbqVQzdpib3ketb8+tnpB3o0B+Ty
         cKh7MHwtHw701wAxuG+UsrxfBeJsTsZynkyO6r+N3S+TIj6c4FizbFLD7GztnTntFHnZ
         gsSzsbXXMLDrszd3BDAQM1YNEphB6CZXZ/9AZmpXHYfvOXTkUy/d8jlN1/4d2wMA7rbp
         ju8p8cViWLsM+oBuJFzi/ouTETYDPDTq7DS0nrFC46ZFC36bzHHRdptfjjFXfusRQn3K
         e4BhoBlEZlaDkzlK3AbURrWoyJGwpgU5NOza3tXHxR56Pd11zv79a52zzeHHroM/AvRE
         cBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Yw2AQQjjN0qlybNUjTs4aWik4pvcwC2CB37OFNajzDc=;
        b=KublewrTibItr5lOwmiahVPGh94rKBQBDVdFfvkwrSp3OlUmvi+UInvGiXXAbj677x
         L95nGT1wbk2JuQ61NcN5JqV4+bAr0xkQz+c7/a2LFkDzaJW1ARUdmwA/op3Sz/Bxr4YC
         r0oiZtyo+IN+iL9GrhH4vCEh5dYRnWnmQqgpDUlQ2OgP9luX+dm0kpsJ+BYKxOpDkVCk
         GEe2K2B7i+w8/MHPZLnmgILdMhf2yzN0ZBFkl3lwUEEJcEYj2g1PzmaBFrooT4nqCsGs
         SlV90j4ijRK2gKltUC5RuEnrZO66IcswszN86rSpCmEjaYnKIo5Mpj4Uj6HK+E3+ULtc
         EqFA==
X-Gm-Message-State: AOAM530WwjIJruj2nvXDVXB8TiinBdv97Oo7rnAOvLX6KLlS7zxsegv3
        KxvkIPydvR8BBtR5uZYwxsdcSlOx4o0=
X-Google-Smtp-Source: ABdhPJyyIQn9cQEMrxTgNqGI7l8PM5GsGgXUNIEpSUKpS2z5j4iyNlyqBnf88lwm0YC7rIRyYgYQjVdegf0=
Sender: "figiel via sendgmr" <figiel@odra.waw.corp.google.com>
X-Received: from odra.waw.corp.google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
 (user=figiel job=sendgmr) by 2002:a05:6512:228b:: with SMTP id
 f11mr11712619lfu.78.1612287459908; Tue, 02 Feb 2021 09:37:39 -0800 (PST)
Date:   Tue,  2 Feb 2021 18:37:09 +0100
Message-Id: <20210202173709.4104221-1-figiel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4] fs/proc: Expose RSEQ configuration
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, Piotr Figiel <figiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For userspace checkpoint and restore (C/R) some way of getting process
state containing RSEQ configuration is needed.

There are two ways this information is going to be used:
 - to re-enable RSEQ for threads which had it enabled before C/R
 - to detect if a thread was in a critical section during C/R

Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
using the address registered before C/R.

Detection whether the thread is in a critical section during C/R is
needed to enforce behavior of RSEQ abort during C/R. Attaching with
ptrace() before registers are dumped itself doesn't cause RSEQ abort.
Restoring the instruction pointer within the critical section is
problematic because rseq_cs may get cleared before the control is
passed to the migrated application code leading to RSEQ invariants not
being preserved.

To achieve above goals expose the RSEQ ABI address and the signature
value with the new procfs file "/proc/<pid>/rseq".

Signed-off-by: Piotr Figiel <figiel@google.com>

---

v4:
 - added documentation and extended comment before task_lock()
v3:
 - added locking so that the proc file always shows consistent pair of
   RSEQ ABI address and the signature
 - changed string formatting to use %px for the RSEQ ABI address
v2:
 - fixed string formatting for 32-bit architectures
v1:
 - https://lkml.kernel.org/r/20210113174127.2500051-1-figiel@google.com

---
 Documentation/filesystems/proc.rst | 16 ++++++++++++++++
 fs/exec.c                          |  2 ++
 fs/proc/base.c                     | 22 ++++++++++++++++++++++
 include/linux/sched/task.h         |  3 ++-
 kernel/rseq.c                      |  4 ++++
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..d887666dc849 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
+  3.13	/proc/<pid>/rseq - RSEQ configuration state
 
   4	Configuring procfs
   4.1	Mount options
@@ -2131,6 +2132,21 @@ AVX512_elapsed_ms
   the task is unlikely an AVX512 user, but depends on the workload and the
   scheduling scenario, it also could be a false negative mentioned above.
 
+3.13	/proc/<pid>/rseq - RSEQ configuration state
+---------------------------------------------------
+This file provides RSEQ configuration of a thread. Available fields correspond
+to the rseq() syscall parameters and are:
+
+ - RSEQ ABI structure address shared between the kernel and user-space
+ - signature value expected before the abort handler code
+
+Both values are in hexadecimal format, for example::
+
+	# cat /proc/12345/rseq
+	0000abcdef12340 aabb0011
+
+This file is only present if CONFIG_RSEQ is enabled.
+
 Chapter 4: Configuring procfs
 =============================
 
diff --git a/fs/exec.c b/fs/exec.c
index 5d4d52039105..5d84f98847f1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1830,7 +1830,9 @@ static int bprm_execve(struct linux_binprm *bprm,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	task_lock(current);
 	rseq_execve(current);
+	task_unlock(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..89232329d966 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -662,6 +662,22 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 
 	return 0;
 }
+
+#ifdef CONFIG_RSEQ
+static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	int res = lock_trace(task);
+
+	if (res)
+		return res;
+	task_lock(task);
+	seq_printf(m, "%px %08x\n", task->rseq, task->rseq_sig);
+	task_unlock(task);
+	unlock_trace(task);
+	return 0;
+}
+#endif /* CONFIG_RSEQ */
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 /************************************************************************/
@@ -3182,6 +3198,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",       S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
@@ -3522,6 +3541,9 @@ static const struct pid_entry tid_base_stuff[] = {
 			 &proc_pid_set_comm_operations, {}),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
+#ifdef CONFIG_RSEQ
+	ONE("rseq",      S_IRUSR, proc_pid_rseq),
+#endif
 #endif
 	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",      S_IRUGO, proc_tid_stat),
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c0f71f2e7160..b6d085ac571b 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -155,7 +155,8 @@ static inline struct vm_struct *task_stack_vm_area(const struct task_struct *t)
  * Protects ->fs, ->files, ->mm, ->group_info, ->comm, keyring
  * subscriptions and synchronises with wait4().  Also used in procfs.  Also
  * pins the final release of task.io_context.  Also protects ->cpuset and
- * ->cgroup.subsys[]. And ->vfork_done.
+ * ->cgroup.subsys[]. And ->vfork_done. And ->rseq and ->rseq_sig to
+ * synchronize changes with procfs reader.
  *
  * Nests both inside and outside of read_lock(&tasklist_lock).
  * It must not be nested with write_lock_irq(&tasklist_lock),
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..6aea67878065 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -322,8 +322,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		ret = rseq_reset_rseq_cpu_id(current);
 		if (ret)
 			return ret;
+		task_lock(current);
 		current->rseq = NULL;
 		current->rseq_sig = 0;
+		task_unlock(current);
 		return 0;
 	}
 
@@ -353,8 +355,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+	task_lock(current);
 	current->rseq = rseq;
 	current->rseq_sig = sig;
+	task_unlock(current);
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.30.0.478.g8a0d178c01-goog

