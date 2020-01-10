Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C3137259
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgAJQGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgAJQGZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:06:25 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B870E206ED;
        Fri, 10 Jan 2020 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672384;
        bh=fCqOhwnPLKrFZ8zen3kBGy0eZbhUcjjOMKGs+Y/wACE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgRjZN1OP1JX8KYDZqot5Gfb9skIryQorbGnC2hDFxecPx3a0aHbSlTctb/eIx4do
         WFsOkHEJOr3tAbMZIRB8X/Tl/K1aM3CR0JIZw2D4eeT/AJo8Y6FjzxFMA9ScAJ4sP0
         OSwrEoTBtbwqlAMvLBeQiAV6CpR/4I+VAxM9b3Cg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: [PATCH v6 15/22] tracing/boot: Add boot-time tracing
Date:   Sat, 11 Jan 2020 01:06:17 +0900
Message-Id: <157867237723.17873.17494943526320587488.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setup tracing options via extra boot config in addition to kernel
command line.

This adds following commands support. These are applied to
the global trace instance.

 - ftrace.options = OPT1[,OPT2...]
   Enable given ftrace options.

 - ftrace.trace_clock = CLOCK
   Set given CLOCK to ftrace's trace_clock.

 - ftrace.buffer_size = SIZE
   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
   for that SIZE.

 - ftrace.events = EVENT[, EVENT2...]
   Enable given events on boot. You can use a wild card in EVENT.

 - ftrace.tracer = TRACER
   Set TRACER to current tracer on boot. (e.g. function)

Note that this is NOT replacing the kernel parameters, because
this boot config based setting is later than that. If you want to
trace earlier boot events, you still need kernel parameters.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v4:
   - Remove parameter which is not related to instance.
   - Use bootconfig.
---
 kernel/trace/Kconfig      |    9 ++++
 kernel/trace/Makefile     |    1 
 kernel/trace/trace.c      |   10 ++--
 kernel/trace/trace_boot.c |  113 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 5 deletions(-)
 create mode 100644 kernel/trace/trace_boot.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 25a0fcfa7a5d..75326d8ab1af 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -814,6 +814,15 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config BOOTTIME_TRACING
+	bool "Boot-time Tracing support"
+	depends on BOOT_CONFIG && TRACING
+	default y
+	help
+	  Enable developer to setup ftrace subsystem via supplemental
+	  kernel cmdline at boot time for debugging (tracing) driver
+	  initialization and boot process.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 0e63db62225f..395e2db9c742 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -83,6 +83,7 @@ endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
+obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 970bac1299b5..c2e1b33aec17 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -162,7 +162,7 @@ union trace_eval_map_item {
 static union trace_eval_map_item *trace_eval_maps;
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf);
+int tracing_set_tracer(struct trace_array *tr, const char *buf);
 static void ftrace_trace_userstack(struct ring_buffer *buffer,
 				   unsigned long flags, int pc);
 
@@ -4747,7 +4747,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	return 0;
 }
 
-static int trace_set_options(struct trace_array *tr, char *option)
+int trace_set_options(struct trace_array *tr, char *option)
 {
 	char *cmp;
 	int neg = 0;
@@ -5647,8 +5647,8 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	return ret;
 }
 
-static ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
-					  unsigned long size, int cpu_id)
+ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+				  unsigned long size, int cpu_id)
 {
 	int ret = size;
 
@@ -5727,7 +5727,7 @@ static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 	create_trace_option_files(tr, t);
 }
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf)
+int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
 	struct tracer *t;
 #ifdef CONFIG_TRACER_MAX_TRACE
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
new file mode 100644
index 000000000000..4b41310184df
--- /dev/null
+++ b/kernel/trace/trace_boot.c
@@ -0,0 +1,113 @@
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
+#include <linux/bootconfig.h>
+
+#include "trace.h"
+
+#define MAX_BUF_LEN 256
+
+extern int trace_set_options(struct trace_array *tr, char *option);
+extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
+extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+					  unsigned long size, int cpu_id);
+
+static void __init
+trace_boot_set_ftrace_options(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *anode;
+	const char *p;
+	char buf[MAX_BUF_LEN];
+	unsigned long v = 0;
+
+	/* Common ftrace options */
+	xbc_node_for_each_array_value(node, "options", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("String is too long: %s\n", p);
+			continue;
+		}
+
+		if (trace_set_options(tr, buf) < 0)
+			pr_err("Failed to set option: %s\n", buf);
+	}
+
+	p = xbc_node_find_value(node, "trace_clock", NULL);
+	if (p && *p != '\0') {
+		if (tracing_set_clock(tr, p) < 0)
+			pr_err("Failed to set trace clock: %s\n", p);
+	}
+
+	p = xbc_node_find_value(node, "buffer_size", NULL);
+	if (p && *p != '\0') {
+		v = memparse(p, NULL);
+		if (v < PAGE_SIZE)
+			pr_err("Buffer size is too small: %s\n", p);
+		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
+			pr_err("Failed to resize trace buffer to %s\n", p);
+	}
+}
+
+#ifdef CONFIG_EVENT_TRACING
+extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+
+static void __init
+trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *p;
+
+	xbc_node_for_each_array_value(node, "events", anode, p) {
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
+trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
+{
+	const char *p;
+
+	p = xbc_node_find_value(node, "tracer", NULL);
+	if (p && *p != '\0') {
+		if (tracing_set_tracer(tr, p) < 0)
+			pr_err("Failed to set given tracer: %s\n", p);
+	}
+}
+
+static int __init trace_boot_init(void)
+{
+	struct xbc_node *trace_node;
+	struct trace_array *tr;
+
+	trace_node = xbc_find_node("ftrace");
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

