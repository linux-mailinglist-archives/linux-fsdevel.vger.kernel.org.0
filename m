Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74099C7BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfHZDR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfHZDR4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:17:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C842173E;
        Mon, 26 Aug 2019 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789474;
        bh=G/qyW272NUfoEDDIFCzOPjWsNmGzvP4vyJnf2Deq0nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffQlKwF42ln7Cshrpieg6v9bZuPeW3eFetJYLHFyRvjwmZQrGP5GVJSBpZSr3Iqpf
         S+9bpaT+F2gITjF2waiMVjgLo4WQBj1axwqn6D0qj9W1b20HtHEKLJZF/c8b+w6R01
         5NQN6A3gRbQV1fLQBjHN5mKF78L3OEJyqmhX47fs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 11/19] tracing/boot: Add boot-time tracing by supplemental kernel cmdline
Date:   Mon, 26 Aug 2019 12:17:48 +0900
Message-Id: <156678946837.21459.17052750937661704310.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setup tracing options by supplemental kernel cmdline (skc) in addition
to kernel parameters. In this patch, add following commands support

 - ftrace.options = OPT1[,OPT2...];
   Enable given ftrace options.

 - ftrace.trace_clock = CLOCK;
   Set given CLOCK to ftrace's trace_clock.

 - ftrace.dump_on_oops [= MODE];
   Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
   on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.

 - ftrace.traceoff_on_warning;
   Stop tracing if WARN_ON() occurs.

 - ftrace.tp_printk;
   Output trace-event data on printk buffer too.

 - ftrace.buffer_size = SIZE;
   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
   for that SIZE.

 - ftrace.alloc_snapshot;
   Allocate snapshot buffer.

 - ftrace.events = EVENT[, EVENT2...];
   Enable given events on boot. You can use a wild card in EVENT.

 - ftrace.tracer = TRACER;
   Set TRACER to current tracer on boot. (e.g. function)

Since the kernel parameter is limited length, sometimes there is
no space to setup the tracing options. This will read the tracing
options from skc "ftrace" prefix and setup tracers at boot.

Note that this is not replacing the kernel parameters, because
this skc based setting is later than that. If you want to
trace earlier boot events, you still need kernel parameters.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/Kconfig      |    9 +++
 kernel/trace/Makefile     |    1 
 kernel/trace/trace.c      |   38 ++++++++----
 kernel/trace/trace_boot.c |  137 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 13 deletions(-)
 create mode 100644 kernel/trace/trace_boot.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 98da8998c25c..0f831adb4e4a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -797,6 +797,15 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config BOOTTIME_TRACING
+	bool "Boot-time Tracing support"
+	depends on SKC && TRACING
+	default y
+	help
+	  Enable developer to setup ftrace subsystem via supplemental
+	  kernel cmdline at boot time for debugging (tracing) driver
+	  initialization and boot process.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..f9d3c2c72fb5 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -82,6 +82,7 @@ endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
+obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 605faf584164..69400a87e48f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -158,7 +158,7 @@ union trace_eval_map_item {
 static union trace_eval_map_item *trace_eval_maps;
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf);
+int tracing_set_tracer(struct trace_array *tr, const char *buf);
 static void ftrace_trace_userstack(struct ring_buffer *buffer,
 				   unsigned long flags, int pc);
 
@@ -178,6 +178,11 @@ static int __init set_cmdline_ftrace(char *str)
 }
 __setup("ftrace=", set_cmdline_ftrace);
 
+void __init trace_init_dump_on_oops(int mode)
+{
+	ftrace_dump_on_oops = mode;
+}
+
 static int __init set_ftrace_dump_on_oops(char *str)
 {
 	if (*str++ != '=' || !*str) {
@@ -4614,7 +4619,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	return 0;
 }
 
-static int trace_set_options(struct trace_array *tr, char *option)
+int trace_set_options(struct trace_array *tr, char *option)
 {
 	char *cmp;
 	int neg = 0;
@@ -5505,8 +5510,8 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	return ret;
 }
 
-static ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
-					  unsigned long size, int cpu_id)
+ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+				  unsigned long size, int cpu_id)
 {
 	int ret = size;
 
@@ -5585,7 +5590,7 @@ static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 	create_trace_option_files(tr, t);
 }
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf)
+int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
 	struct tracer *t;
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -9170,16 +9175,23 @@ __init static int tracer_alloc_buffers(void)
 	return ret;
 }
 
+void __init trace_init_tracepoint_printk(void)
+{
+	tracepoint_printk = 1;
+
+	tracepoint_print_iter =
+		kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
+	if (WARN_ON(!tracepoint_print_iter))
+		tracepoint_printk = 0;
+	else
+		static_key_enable(&tracepoint_printk_key.key);
+}
+
 void __init early_trace_init(void)
 {
-	if (tracepoint_printk) {
-		tracepoint_print_iter =
-			kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
-		if (WARN_ON(!tracepoint_print_iter))
-			tracepoint_printk = 0;
-		else
-			static_key_enable(&tracepoint_printk_key.key);
-	}
+	if (tracepoint_printk)
+		trace_init_tracepoint_printk();
+
 	tracer_alloc_buffers();
 }
 
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
new file mode 100644
index 000000000000..cc5e81368065
--- /dev/null
+++ b/kernel/trace/trace_boot.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace_boot.c
+ * Tracing kernel boot-time
+ */
+
+#define pr_fmt(fmt)	"trace_boot: " fmt
+
+#include <linux/ftrace.h>
+#include <linux/init.h>
+#include <linux/skc.h>
+
+#include "trace.h"
+
+#define MAX_BUF_LEN 256
+
+extern int trace_set_options(struct trace_array *tr, char *option);
+extern enum ftrace_dump_mode ftrace_dump_on_oops;
+extern int __disable_trace_on_warning;
+extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
+extern void __init trace_init_tracepoint_printk(void);
+extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+					  unsigned long size, int cpu_id);
+
+static void __init
+trace_boot_set_ftrace_options(struct trace_array *tr, struct skc_node *node)
+{
+	struct skc_node *anode;
+	const char *p;
+	char buf[MAX_BUF_LEN];
+	unsigned long v = 0;
+	int err;
+
+	/* Common ftrace options */
+	skc_node_for_each_array_value(node, "options", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("String is too long: %s\n", p);
+			continue;
+		}
+
+		if (trace_set_options(tr, buf) < 0)
+			pr_err("Failed to set option: %s\n", buf);
+	}
+
+	p = skc_node_find_value(node, "trace_clock", NULL);
+	if (p && *p != '\0') {
+		if (tracing_set_clock(tr, p) < 0)
+			pr_err("Failed to set trace clock: %s\n", p);
+	}
+
+	/* Command line boot options */
+	p = skc_node_find_value(node, "dump_on_oops", NULL);
+	if (p) {
+		err = kstrtoul(p, 0, &v);
+		if (err || v == 1)
+			ftrace_dump_on_oops = DUMP_ALL;
+		else if (!err && v == 2)
+			ftrace_dump_on_oops = DUMP_ORIG;
+	}
+
+	if (skc_node_find_value(node, "traceoff_on_warning", NULL))
+		__disable_trace_on_warning = 1;
+
+	if (skc_node_find_value(node, "tp_printk", NULL))
+		trace_init_tracepoint_printk();
+
+	p = skc_node_find_value(node, "buffer_size", NULL);
+	if (p && *p != '\0') {
+		v = memparse(p, NULL);
+		if (v < PAGE_SIZE)
+			pr_err("Buffer size is too small: %s\n", p);
+		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
+			pr_err("Failed to resize trace buffer to %s\n", p);
+	}
+
+	if (skc_node_find_value(node, "alloc_snapshot", NULL))
+		if (tracing_alloc_snapshot() < 0)
+			pr_err("Failed to allocate snapshot buffer\n");
+}
+
+#ifdef CONFIG_EVENT_TRACING
+extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+
+static void __init
+trace_boot_enable_events(struct trace_array *tr, struct skc_node *node)
+{
+	struct skc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *p;
+
+	skc_node_for_each_array_value(node, "events", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("String is too long: %s\n", p);
+			continue;
+		}
+
+		if (ftrace_set_clr_event(tr, buf, 1) < 0)
+			pr_err("Failed to enable event: %s\n", p);
+	}
+}
+#else
+#define trace_boot_enable_events(tr, node) do {} while (0)
+#endif
+
+static void __init
+trace_boot_enable_tracer(struct trace_array *tr, struct skc_node *node)
+{
+	const char *p;
+
+	p = skc_node_find_value(node, "tracer", NULL);
+	if (p && *p != '\0') {
+		if (tracing_set_tracer(tr, p) < 0)
+			pr_err("Failed to set given tracer: %s\n", p);
+	}
+}
+
+static int __init trace_boot_init(void)
+{
+	struct skc_node *trace_node;
+	struct trace_array *tr;
+
+	trace_node = skc_find_node("ftrace");
+	if (!trace_node)
+		return 0;
+
+	tr = top_trace_array();
+	if (!tr)
+		return 0;
+
+	trace_boot_set_ftrace_options(tr, trace_node);
+	trace_boot_enable_events(tr, trace_node);
+	trace_boot_enable_tracer(tr, trace_node);
+
+	return 0;
+}
+
+fs_initcall(trace_boot_init);

