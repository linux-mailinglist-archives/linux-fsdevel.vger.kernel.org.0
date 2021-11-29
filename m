Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4253462719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhK2XBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhK2XA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:00:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA7C061A2E;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6N1jMRpULYux0tbSVWUh0jI591u5iEqwKZDvmVVtX3w=; b=E79UubNqV/+N7eMOkZADmtPC6F
        CmibHsMkGqbovGzat85DmUrfZFy+izS75JGyKafcju0dROnoKwk2lasSfo1py1AkY8sIcDpxCPJOR
        1ltE+7j3d3YlE12ht1h082DXyyL1iQaW2Wyum9lq/XyP0MazFmGNUttgcP9AMn/lETzc0vHn5jQJg
        DwFnmIe5ziMmPWlBNzw4yCylWvBDvEklUuuavXlqt9qIkn9tSzSfidHG/yuzXf4U2fe0cynAtAiqB
        SuEuZsk7Xbl4K1F6BoRd8oVWKrizPY/tfBLKu8uctKgCHkkVZfzpe31G1P81/hRgAZ7EZ91WPmJVE
        jzHmPXGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002gaO-UN; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] fs/coredump: move coredump sysctls into its own file
Date:   Mon, 29 Nov 2021 13:19:42 -0800
Message-Id: <20211129211943.640266-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129211943.640266-1-mcgrof@kernel.org>
References: <20211129211943.640266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

This moves the fs/coredump.c respective sysctls to its own file.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/coredump.c            | 66 +++++++++++++++++++++++++++++++++++++---
 fs/exec.c                | 55 ---------------------------------
 include/linux/coredump.h | 10 +++---
 kernel/sysctl.c          |  2 --
 4 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a6b3c196cdef..570d98398668 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -41,6 +41,7 @@
 #include <linux/fs.h>
 #include <linux/path.h>
 #include <linux/timekeeping.h>
+#include <linux/sysctl.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -52,9 +53,9 @@
 
 #include <trace/events/sched.h>
 
-int core_uses_pid;
-unsigned int core_pipe_limit;
-char core_pattern[CORENAME_MAX_SIZE] = "core";
+static int core_uses_pid;
+static unsigned int core_pipe_limit;
+static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 
 struct core_name {
@@ -62,8 +63,6 @@ struct core_name {
 	int used, size;
 };
 
-/* The maximal length of core_pattern is also specified in sysctl.c */
-
 static int expand_corename(struct core_name *cn, int size)
 {
 	char *corename = krealloc(cn->corename, size, GFP_KERNEL);
@@ -895,6 +894,63 @@ int dump_align(struct coredump_params *cprm, int align)
 }
 EXPORT_SYMBOL(dump_align);
 
+#ifdef CONFIG_SYSCTL
+
+void validate_coredump_safety(void)
+{
+	if (suid_dumpable == SUID_DUMP_ROOT &&
+	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+		pr_warn(
+"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
+"Pipe handler or fully qualified core dump path required.\n"
+"Set kernel.core_pattern before fs.suid_dumpable.\n"
+		);
+	}
+}
+
+static int proc_dostring_coredump(struct ctl_table *table, int write,
+		  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int error = proc_dostring(table, write, buffer, lenp, ppos);
+
+	if (!error)
+		validate_coredump_safety();
+	return error;
+}
+
+static struct ctl_table coredump_sysctls[] = {
+	{
+		.procname	= "core_uses_pid",
+		.data		= &core_uses_pid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "core_pattern",
+		.data		= core_pattern,
+		.maxlen		= CORENAME_MAX_SIZE,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring_coredump,
+	},
+	{
+		.procname	= "core_pipe_limit",
+		.data		= &core_pipe_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{ }
+};
+
+static int __init init_fs_coredump_sysctls(void)
+{
+	register_sysctl_init("kernel", coredump_sysctls);
+	return 0;
+}
+fs_initcall(init_fs_coredump_sysctls);
+#endif /* CONFIG_SYSCTL */
+
 /*
  * The purpose of always_dump_vma() is to make sure that special kernel mappings
  * that are useful for post-mortem analysis are included in every core dump.
diff --git a/fs/exec.c b/fs/exec.c
index 3fd2866edec3..cc5ec43df028 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2101,20 +2101,6 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 
 #ifdef CONFIG_SYSCTL
 
-static void validate_coredump_safety(void)
-{
-#ifdef CONFIG_COREDUMP
-	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
-		pr_warn(
-"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
-"Pipe handler or fully qualified core dump path required.\n"
-"Set kernel.core_pattern before fs.suid_dumpable.\n"
-		);
-	}
-#endif
-}
-
 static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -2138,50 +2124,9 @@ static struct ctl_table fs_exec_sysctls[] = {
 	{ }
 };
 
-#ifdef CONFIG_COREDUMP
-
-static int proc_dostring_coredump(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
-
-	if (!error)
-		validate_coredump_safety();
-	return error;
-}
-
-static struct ctl_table kernel_exec_sysctls[] = {
-	{
-		.procname	= "core_uses_pid",
-		.data		= &core_uses_pid,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "core_pattern",
-		.data		= core_pattern,
-		.maxlen		= CORENAME_MAX_SIZE,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring_coredump,
-	},
-	{
-		.procname	= "core_pipe_limit",
-		.data		= &core_pipe_limit,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{ }
-};
-#endif
-
 static int __init init_fs_exec_sysctls(void)
 {
 	register_sysctl_init("fs", fs_exec_sysctls);
-#ifdef CONFIG_COREDUMP
-	register_sysctl_init("kernel", kernel_exec_sysctls);
-#endif
 	return 0;
 }
 
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 78fcd776b185..248a68c668b4 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -14,10 +14,6 @@ struct core_vma_metadata {
 	unsigned long dump_size;
 };
 
-extern int core_uses_pid;
-extern char core_pattern[];
-extern unsigned int core_pipe_limit;
-
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
@@ -37,4 +33,10 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
 static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
 #endif
 
+#if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern void validate_coredump_safety(void);
+#else
+static inline void validate_coredump_safety(void) {}
+#endif
+
 #endif /* _LINUX_COREDUMP_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 421d29a86c73..a4c352f0a514 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -61,12 +61,10 @@
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
-#include <linux/sched/coredump.h>
 #include <linux/kexec.h>
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
-#include <linux/coredump.h>
 #include <linux/latencytop.h>
 #include <linux/pid.h>
 #include <linux/delayacct.h>
-- 
2.33.0

