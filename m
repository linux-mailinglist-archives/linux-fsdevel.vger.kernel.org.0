Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD0E46250D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhK2Weu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhK2WeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057CC09B197;
        Mon, 29 Nov 2021 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3tiVVBq/gI28N2+UgtNKbwCLNO9nM3fgPRTuk9WUMUI=; b=1IHc35v9+or5SOX9E1YigpCjGO
        U2PnIWZdbqh1WA+8+Ip+saD0NVKDNA5h9Ewy+RRwnei9/RUltR2YBSgLyzKNEp3lNpqZfsK1MWq0Q
        dGErcpOvcEnGlT7bByc1p3fzvVJB6Kn+AYKRV4POfqWn62U1HoWq1ygCUFws9QbgsF+axqWEyC21X
        Z8nkeiOXvz8cxB0h1uBc0argxu7rj2LkU23ihK8ga3QKPbwAudHc53X21rhqP9vQJz6HDSd5BtDR4
        8Xnq8y/dUy77m223RFxUDWNDq9zCofEn6rgW0zCy+Ov0ML8AQzPiCOBBd+wfZ1mt2g0N0MvH07Nyh
        GqO0fIDg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3t-002gaW-1C; Mon, 29 Nov 2021 21:19:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] kprobe: move sysctl_kprobes_optimization to kprobes.c
Date:   Mon, 29 Nov 2021 13:19:43 -0800
Message-Id: <20211129211943.640266-7-mcgrof@kernel.org>
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

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

Move sysctl_kprobes_optimization from kernel/sysctl.c to kernel/kprobes.c.
Use register_sysctl() to register the sysctl interface.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: fix compile issue when CONFIG_OPTPROBES is disabled]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/kprobes.h |  6 ------
 kernel/kprobes.c        | 30 ++++++++++++++++++++++++++----
 kernel/sysctl.c         | 12 ------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e974caf39d3e..e9c3687c84d5 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -346,12 +346,6 @@ extern void opt_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 DEFINE_INSN_CACHE_OPS(optinsn);
 
-#ifdef CONFIG_SYSCTL
-extern int sysctl_kprobes_optimization;
-extern int proc_kprobes_optimization_handler(struct ctl_table *table,
-					     int write, void *buffer,
-					     size_t *length, loff_t *ppos);
-#endif /* CONFIG_SYSCTL */
 extern void wait_for_kprobe_optimizer(void);
 #else /* !CONFIG_OPTPROBES */
 static inline void wait_for_kprobe_optimizer(void) { }
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e9db0c810554..ee76ff64b49e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -48,6 +48,9 @@
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
+#if !defined(CONFIG_OPTPROBES) || !defined(CONFIG_SYSCTL)
+#define kprobe_sysctls_init() do { } while (0)
+#endif
 
 static int kprobes_initialized;
 /* kprobe_table can be accessed by
@@ -938,10 +941,10 @@ static void unoptimize_all_kprobes(void)
 }
 
 static DEFINE_MUTEX(kprobe_sysctl_mutex);
-int sysctl_kprobes_optimization;
-int proc_kprobes_optimization_handler(struct ctl_table *table, int write,
-				      void *buffer, size_t *length,
-				      loff_t *ppos)
+static int sysctl_kprobes_optimization;
+static int proc_kprobes_optimization_handler(struct ctl_table *table,
+					     int write, void *buffer,
+					     size_t *length, loff_t *ppos)
 {
 	int ret;
 
@@ -957,6 +960,24 @@ int proc_kprobes_optimization_handler(struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static struct ctl_table kprobe_sysctls[] = {
+	{
+		.procname	= "kprobes-optimization",
+		.data		= &sysctl_kprobes_optimization,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_kprobes_optimization_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{}
+};
+
+static void __init kprobe_sysctls_init(void)
+{
+	register_sysctl_init("debug", kprobe_sysctls);
+}
 #endif /* CONFIG_SYSCTL */
 
 /* Put a breakpoint for a probe. */
@@ -2581,6 +2602,7 @@ static int __init init_kprobes(void)
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);
+	kprobe_sysctls_init();
 	return err;
 }
 early_initcall(init_kprobes);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a4c352f0a514..7f07b058b180 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -55,7 +55,6 @@
 #include <linux/reboot.h>
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
-#include <linux/kprobes.h>
 #include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
@@ -2817,17 +2816,6 @@ static struct ctl_table debug_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-#endif
-#if defined(CONFIG_OPTPROBES)
-	{
-		.procname	= "kprobes-optimization",
-		.data		= &sysctl_kprobes_optimization,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_kprobes_optimization_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 #endif
 	{ }
 };
-- 
2.33.0

