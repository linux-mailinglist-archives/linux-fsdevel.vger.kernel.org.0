Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B5535F01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351244AbiE0LK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351222AbiE0LK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 07:10:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CD131F20
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 04:10:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v15so3657552pgk.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIHYvm2K7nibOvcUritOjONU5u9cYsOry1JPgOzcrJ4=;
        b=7vQ+6n4itBAKx3GAx1doP/A1+RLQntp+PUZ65lR80ZQfMCSy0UJjDAgrppd9EVdmAd
         aI+COuNHHfFwn7enHezaf+J8+hTQfQCngk+6v0cPDOutpOCpAZla3EriqO+qh0fgyvbT
         TqkVKnA5MMPTLMyRdJxMInnGZVKeSsdGDiZ9UIbpb7jOJcbe2Mqt537osw9XkVF+CCEr
         ojNEDAWJowtD4firQNU3MzFjp/59H/ZshUA7YCqz+6/lKfKLJzKxh6iIx6+EP2059DO9
         QF1uG5ChZz4gqMtqjp3IkIroitSTp2kX1ObNDDzt2UZe4djWqnPGKGK2O1Tu7tTgqH1x
         g0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIHYvm2K7nibOvcUritOjONU5u9cYsOry1JPgOzcrJ4=;
        b=vJoX0GwJhcyGYzdgjRXDKsydDY2f6C7OdGku29LXsVa1DMFUIBjjG1q4ykh2a0RE99
         dRG1rYJP5Mu2U9DIF5QwK4Lh3lJrO1QHXX6N6xK4ve3O4z8SPWNwaU0fDMpipJmD7a/1
         FGWkqI748ha/burIIoAlSb2BfAIyJrw4CB3V82DXzsuKVkExkyj66+kyJMtoqTLmMk4Y
         2jmAhihXlW+sFQaxeyGFj9OSM/EivPEhI/8jwvaqimuJKKMosNIPbnQg7g9eSYNRyQy6
         rPmrcuhaV27pJ9j2hpN2cips2z7F5fSJwT/Xz68EE5EJ6kLPynahakA84HD4/n113t3u
         9LVQ==
X-Gm-Message-State: AOAM530MMU0CF8xr95ZyheMc+bu+fAFAJf4CjZkMt4wSTn4Ip12NpVrx
        d2AH5DjPHzLk1cyGbL7lSkiU+w==
X-Google-Smtp-Source: ABdhPJyUhg9mYKRTWaeNWG1metTMJhlddg/09vUDN3DGgAQwHufJJrQn/XrtDBVi9TZypY7cy/d9Lw==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id t19-20020a656093000000b003739c7519ecmr37546462pgu.539.1653649824394;
        Fri, 27 May 2022 04:10:24 -0700 (PDT)
Received: from C02GF2LXMD6R.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id w9-20020aa78589000000b0051827128aeasm3152176pfn.131.2022.05.27.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 04:10:24 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com, peterz@infradead.org,
        mingo@redhat.com, ast@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-api@vger.kernel.org,
        fam.zheng@bytedance.com,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH] procfs: add syscall statistics
Date:   Fri, 27 May 2022 19:09:59 +0800
Message-Id: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add /proc/syscalls to display percpu syscall count.

We need a less resource-intensive way to count syscall per cpu
for system problem location.

There is a similar utility syscount in the BCC project, but syscount
has a high performance cost.

The following is a comparison on the same machine, using UnixBench
System Call Overhead:

    ┏━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
    ┃ Change        ┃ Unixbench Score ┃ Loss   ┃
    ┡━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
    │ no change     │ 1072.6          │ ---    │
    │ syscall count │ 982.5           │ 8.40%  │
    │ bpf syscount  │ 614.2           │ 42.74% │
    └───────────────┴─────────────────┴────────┘

UnixBench System Call Use sys_gettid to test, this system call only reads
one variable, so the performance penalty seems large. When tested with
fork, the test scores were almost the same.

So the conclusion is that it does not have a significant impact on system
call performance.

This function depends on CONFIG_FTRACE_SYSCALLS because the system call
number is stored in syscall_metadata.

Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
---
 Documentation/filesystems/proc.rst       | 28 +++++++++
 arch/arm64/include/asm/syscall_wrapper.h |  2 +-
 arch/s390/include/asm/syscall_wrapper.h  |  4 +-
 arch/x86/include/asm/syscall_wrapper.h   |  2 +-
 fs/proc/Kconfig                          |  7 +++
 fs/proc/Makefile                         |  1 +
 fs/proc/syscall.c                        | 79 ++++++++++++++++++++++++
 include/linux/syscalls.h                 | 51 +++++++++++++--
 8 files changed, 165 insertions(+), 9 deletions(-)
 create mode 100644 fs/proc/syscall.c

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..80394a98a192 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,6 +686,7 @@ files are there, and which are missing.
  fs 	      File system parameters, currently nfs/exports	(2.4)
  ide          Directory containing info about the IDE subsystem
  interrupts   Interrupt usage
+ syscalls     Syscall count for each cpu
  iomem 	      Memory map					(2.4)
  ioports      I/O port usage
  irq 	      Masks for irq to cpu affinity			(2.4)(smp?)
@@ -1225,6 +1226,33 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
+syscalls
+~~~~~~~~
+
+Provides counts of syscall since boot time, for each cpu.
+
+::
+
+    > cat /proc/syscalls
+               CPU0       CPU1       CPU2       CPU3
+      0:       3743       3099       3770       3242   sys_read
+      1:        222        559        822        522   sys_write
+      2:          0          0          0          0   sys_open
+      3:       6481      18754      12077       7349   sys_close
+      4:      11362      11120      11343      10665   sys_newstat
+      5:       5224      13880       8578       5971   sys_newfstat
+      6:       1228       1269       1459       1508   sys_newlstat
+      7:         90         43         64         67   sys_poll
+      8:       1635       1000       2071       1161   sys_lseek
+    .... omit the middle line ....
+    441:          0          0          0          0   sys_epoll_pwait2
+    442:          0          0          0          0   sys_mount_setattr
+    443:          0          0          0          0   sys_quotactl_fd
+    447:          0          0          0          0   sys_memfd_secret
+    448:          0          0          0          0   sys_process_mrelease
+    449:          0          0          0          0   sys_futex_waitv
+    450:          0          0          0          0   sys_set_mempolicy_home_node
+
 1.3 Networking info in /proc/net
 --------------------------------
 
diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index b383b4802a7b..d9ec21df4c44 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -66,7 +66,7 @@ struct pt_regs;
 	}									\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
-#define SYSCALL_DEFINE0(sname)							\
+#define __SYSCALL_DEFINE0(sname)							\
 	SYSCALL_METADATA(_##sname, 0);						\
 	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
 	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index fde7e6b1df48..f8d7d9010de2 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -77,7 +77,7 @@
 	ALLOW_ERROR_INJECTION(__s390_compat_sys_##sname, ERRNO);	\
 	long __s390_compat_sys_##sname(void)
 
-#define SYSCALL_DEFINE0(sname)						\
+#define __SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
 	long __s390x_sys_##sname(void);					\
 	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
@@ -128,7 +128,7 @@
 
 #define __S390_SYS_STUBx(x, fullname, name, ...)
 
-#define SYSCALL_DEFINE0(sname)						\
+#define __SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
 	long __s390x_sys_##sname(void);					\
 	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 59358d1bf880..1f16436c13bd 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -246,7 +246,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * SYSCALL_DEFINEx() -- which is essential for the COND_SYSCALL() and SYS_NI()
  * macros to work correctly.
  */
-#define SYSCALL_DEFINE0(sname)						\
+#define __SYSCALL_DEFINE0(sname)						\
 	SYSCALL_METADATA(_##sname, 0);					\
 	static long __do_sys_##sname(const struct pt_regs *__unused);	\
 	__X64_SYS_STUB0(sname)						\
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index c930001056f9..9e5fa75ebd2a 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -100,6 +100,13 @@ config PROC_CHILDREN
 	  Say Y if you are running any user-space software which takes benefit from
 	  this interface. For example, rkt is such a piece of software.
 
+config PROC_SYSCALLS
+	bool "Include /proc/syscalls file" if EXPERT
+	depends on PROC_FS && FTRACE_SYSCALLS
+	default n
+	help
+	  Provides a file that shows the number of syscall on each cpu.
+
 config PROC_PID_ARCH_STATUS
 	def_bool n
 	depends on PROC_FS
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..f381a7aa90ae 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -31,6 +31,7 @@ proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
 proc-$(CONFIG_NET)		+= proc_net.o
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
+proc-$(CONFIG_PROC_SYSCALLS)	+= syscall.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
 proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
diff --git a/fs/proc/syscall.c b/fs/proc/syscall.c
new file mode 100644
index 000000000000..88196b16f430
--- /dev/null
+++ b/fs/proc/syscall.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+#include <asm/syscall.h>
+
+DEFINE_PER_CPU(u64 [NR_syscalls], __per_cpu_syscall_count);
+
+extern const char *get_syscall_name(int syscall_nr);
+
+int show_syscalls(struct seq_file *p, void *v)
+{
+	int i = *(loff_t *)v, j;
+	static int prec;
+	const char *syscall_name = get_syscall_name(i);
+
+	if (i > NR_syscalls)
+		return 0;
+
+	/* print header and calculate the width of the first column */
+	if (i == 0) {
+		for (prec = 3, j = 1000; prec < 10 && j <= NR_syscalls; ++prec)
+			j *= 10;
+		seq_printf(p, "%*s", prec + 8, "");
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%-8d", j);
+		seq_putc(p, '\n');
+	}
+
+	if (syscall_name == NULL)
+		return 0;
+
+	seq_printf(p, "%*d: ", prec, i);
+	for_each_online_cpu(j)
+		seq_printf(p, "%10llu ",
+			   per_cpu(__per_cpu_syscall_count, j)[i]);
+	seq_printf(p, "  %s", syscall_name);
+	seq_putc(p, '\n');
+
+	return 0;
+}
+
+/*
+ * /proc/syscalls
+ */
+static void *int_seq_start(struct seq_file *f, loff_t *pos)
+{
+	return (*pos <= NR_syscalls) ? pos : NULL;
+}
+
+static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	(*pos)++;
+	if (*pos > NR_syscalls)
+		return NULL;
+	return pos;
+}
+
+static void int_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static const struct seq_operations int_seq_ops = {
+	.start = int_seq_start,
+	.next  = int_seq_next,
+	.stop  = int_seq_stop,
+	.show  = show_syscalls
+};
+
+static int __init proc_syscall_init(void)
+{
+	proc_create_seq("syscalls", 0, NULL, &int_seq_ops);
+	return 0;
+}
+
+fs_initcall(proc_syscall_init);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..a3d50b8d39d8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -86,6 +86,7 @@ enum landlock_rule_type;
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <trace/syscall.h>
+#include <asm/syscall.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /*
@@ -206,8 +207,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
-#ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)					\
+#ifndef __SYSCALL_DEFINE0
+#define __SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
@@ -223,9 +224,49 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINE_MAXARGS	6
 
-#define SYSCALL_DEFINEx(x, sname, ...)				\
-	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
-	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
+#ifdef CONFIG_PROC_SYSCALLS
+DECLARE_PER_CPU(u64[], __per_cpu_syscall_count);
+
+#define SYSCALL_COUNT_DECLAREx(sname, x, ...) \
+	static inline long __count_sys##sname(__MAP(x, __SC_DECL, __VA_ARGS__));
+
+#define __SYSCALL_COUNT(syscall_nr) \
+	this_cpu_inc(__per_cpu_syscall_count[(syscall_nr)])
+
+#define SYSCALL_COUNT_FUNCx(sname, x, ...)					\
+	{									\
+		__SYSCALL_COUNT(__syscall_meta_##sname.syscall_nr);		\
+		return __count_sys##sname(__MAP(x, __SC_CAST, __VA_ARGS__));	\
+	}									\
+	static inline long __count_sys##sname(__MAP(x, __SC_DECL, __VA_ARGS__))
+
+#define SYSCALL_COUNT_DECLARE0(sname) \
+	static inline long __count_sys_##sname(void);
+
+#define SYSCALL_COUNT_FUNC0(sname)					\
+	{								\
+		__SYSCALL_COUNT(__syscall_meta__##sname.syscall_nr);	\
+		return __count_sys_##sname();				\
+	}								\
+	static inline long __count_sys_##sname(void)
+
+#else
+#define SYSCALL_COUNT_DECLAREx(sname, x, ...)
+#define SYSCALL_COUNT_FUNCx(sname, x, ...)
+#define SYSCALL_COUNT_DECLARE0(sname)
+#define SYSCALL_COUNT_FUNC0(sname)
+#endif
+
+#define SYSCALL_DEFINEx(x, sname, ...)			\
+	SYSCALL_METADATA(sname, x, __VA_ARGS__)		\
+	SYSCALL_COUNT_DECLAREx(sname, x, __VA_ARGS__)	\
+	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)	\
+	SYSCALL_COUNT_FUNCx(sname, x, __VA_ARGS__)
+
+#define SYSCALL_DEFINE0(sname)		\
+	SYSCALL_COUNT_DECLARE0(sname)	\
+	__SYSCALL_DEFINE0(sname)	\
+	SYSCALL_COUNT_FUNC0(sname)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
 
-- 
2.30.2

