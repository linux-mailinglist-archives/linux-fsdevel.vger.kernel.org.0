Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8A462571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhK2Wj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhK2Wiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:38:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98166C0F4B28;
        Mon, 29 Nov 2021 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SN3QYuEftSK2Pg8j8VffGkyIx+IRxVGNaO+Dczkyw/4=; b=w/JorAOsz0h1evBWLQUAoK49kq
        dXAG642cQ0DnBqCh4bvdvkw0lf46dTR7nGLhikypLrkwyV1j4ea2tHHavbhl8gm3rQa9fseJdN2mY
        7BAzQf3zbvOgGTO8gywKOL7IBQkT2zL6GYVdtw9RgRnLznsvsd6hMGfi1aOFrZxu+ULvvfHVOy4J0
        E0sC8uimSRjF5CX+xeOgxxQwoKLweLrVCie15VEWOe3o4zU7gp7I9oBDEDDNVVp5ne7NyWJMNjbz9
        DptQNbtEkjhnOC6Y3MtCfqSvgdrNvkqZvLca9hZjXi8jS0sK8A4RO1OjV3IL/LC10eQIGxt7bW7Ai
        W9g1gCQw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XaH-Ct; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] fs: move fs/exec.c sysctls into its own file
Date:   Mon, 29 Nov 2021 12:55:47 -0800
Message-Id: <20211129205548.605569-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move the fs/exec.c respective sysctls to its own file.

Since checkpatch complains about style issues with the old
code, this move also fixes a few of those minor style issues:

  * Use pr_warn() instead of prink(WARNING
  * New empty lines are wanted at the beginning of routines

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/exec.c       | 90 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c | 66 ------------------------------------
 2 files changed, 90 insertions(+), 66 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fa142638b191..3fd2866edec3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/coredump.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -2097,3 +2098,92 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 				  argv, envp, flags);
 }
 #endif
+
+#ifdef CONFIG_SYSCTL
+
+static void validate_coredump_safety(void)
+{
+#ifdef CONFIG_COREDUMP
+	if (suid_dumpable == SUID_DUMP_ROOT &&
+	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+		pr_warn(
+"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
+"Pipe handler or fully qualified core dump path required.\n"
+"Set kernel.core_pattern before fs.suid_dumpable.\n"
+		);
+	}
+#endif
+}
+
+static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (!error)
+		validate_coredump_safety();
+	return error;
+}
+
+static struct ctl_table fs_exec_sysctls[] = {
+	{
+		.procname	= "suid_dumpable",
+		.data		= &suid_dumpable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax_coredump,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{ }
+};
+
+#ifdef CONFIG_COREDUMP
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
+static struct ctl_table kernel_exec_sysctls[] = {
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
+#endif
+
+static int __init init_fs_exec_sysctls(void)
+{
+	register_sysctl_init("fs", fs_exec_sysctls);
+#ifdef CONFIG_COREDUMP
+	register_sysctl_init("kernel", kernel_exec_sysctls);
+#endif
+	return 0;
+}
+
+fs_initcall(init_fs_exec_sysctls);
+#endif /* CONFIG_SYSCTL */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 39ba8e09ce31..0146fc549978 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1116,40 +1116,6 @@ static int proc_dopipe_max_size(struct ctl_table *table, int write,
 				 do_proc_dopipe_max_size_conv, NULL);
 }
 
-static void validate_coredump_safety(void)
-{
-#ifdef CONFIG_COREDUMP
-	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
-		printk(KERN_WARNING
-"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
-"Pipe handler or fully qualified core dump path required.\n"
-"Set kernel.core_pattern before fs.suid_dumpable.\n"
-		);
-	}
-#endif
-}
-
-static int proc_dointvec_minmax_coredump(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int error = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (!error)
-		validate_coredump_safety();
-	return error;
-}
-
-#ifdef CONFIG_COREDUMP
-static int proc_dostring_coredump(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int error = proc_dostring(table, write, buffer, lenp, ppos);
-	if (!error)
-		validate_coredump_safety();
-	return error;
-}
-#endif
-
 #ifdef CONFIG_MAGIC_SYSRQ
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
@@ -1873,29 +1839,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_COREDUMP
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
-#endif
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "tainted",
@@ -2896,15 +2839,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "suid_dumpable",
-		.data		= &suid_dumpable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_coredump,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
 	{
 		.procname	= "pipe-max-size",
 		.data		= &pipe_max_size,
-- 
2.33.0

