Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0112ACE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLZOHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZOHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:07:11 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE2A2053B;
        Thu, 26 Dec 2019 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369229;
        bh=c2VbXS7A6GBRBIZsYBhBALket98Fg4sAbChfM8QNVas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYZtl4a1JC4YGREdSK1yxHkl2kQrCmhs/7AqR8vwIBUNLSasO3iOg4Dn/IIlUdKqa
         5x7pjOWGhpBDqcUtDyBqct6qnzU90kkPXFZKEpkeMXI2v2++WYuMSLxZ1wsMnDX/39
         12UIL0Y8aQdzfMYClwAFbwFob6+XSg0NHp99hHz4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH v5 16/22] tracing/boot: Add per-event settings
Date:   Thu, 26 Dec 2019 23:07:02 +0900
Message-Id: <157736922261.11126.12531577742051849539.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add per-event settings for boottime tracing. User can set filter,
actions and enable on each event on boot. The event entries are
under ftrace.event.GROUP.EVENT node (note that the option key
includes event's group name and event name.) This supports below
configs.

 - ftrace.event.GROUP.EVENT.enable
   Enables GROUP:EVENT tracing.

 - ftrace.event.GROUP.EVENT.filter = FILTER
   Set FILTER rule to the GROUP:EVENT.

 - ftrace.event.GROUP.EVENT.actions = ACTION[, ACTION2...]
   Set ACTIONs to the GROUP:EVENT.

For example,

  ftrace.event.sched.sched_process_exec {
                filter = "pid < 128"
		enable
  }

this will enable tracing "sched:sched_process_exec" event
with "pid < 128" filter.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 4b41310184df..37524031533e 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -56,6 +56,7 @@ trace_boot_set_ftrace_options(struct trace_array *tr, struct xbc_node *node)
 
 #ifdef CONFIG_EVENT_TRACING
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 
 static void __init
 trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
@@ -74,8 +75,66 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 			pr_err("Failed to enable event: %s\n", p);
 	}
 }
+
+static void __init
+trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
+			  struct xbc_node *enode)
+{
+	struct trace_event_file *file;
+	struct xbc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *p, *group, *event;
+
+	group = xbc_node_get_data(gnode);
+	event = xbc_node_get_data(enode);
+
+	mutex_lock(&event_mutex);
+	file = find_event_file(tr, group, event);
+	if (!file) {
+		pr_err("Failed to find event: %s:%s\n", group, event);
+		goto out;
+	}
+
+	p = xbc_node_find_value(enode, "filter", NULL);
+	if (p && *p != '\0') {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("filter string is too long: %s\n", p);
+		else if (apply_event_filter(file, buf) < 0)
+			pr_err("Failed to apply filter: %s\n", buf);
+	}
+
+	xbc_node_for_each_array_value(enode, "actions", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("action string is too long: %s\n", p);
+		else if (trigger_process_regex(file, buf) < 0)
+			pr_err("Failed to apply an action: %s\n", buf);
+	}
+
+	if (xbc_node_find_value(enode, "enable", NULL)) {
+		if (trace_event_enable_disable(file, 1, 0) < 0)
+			pr_err("Failed to enable event node: %s:%s\n",
+				group, event);
+	}
+out:
+	mutex_unlock(&event_mutex);
+}
+
+static void __init
+trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *gnode, *enode;
+
+	node = xbc_node_find_child(node, "event");
+	if (!node)
+		return;
+	/* per-event key starts with "event.GROUP.EVENT" */
+	xbc_node_for_each_child(node, gnode)
+		xbc_node_for_each_child(gnode, enode)
+			trace_boot_init_one_event(tr, gnode, enode);
+}
 #else
 #define trace_boot_enable_events(tr, node) do {} while (0)
+#define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
 static void __init
@@ -104,6 +163,7 @@ static int __init trace_boot_init(void)
 		return 0;
 
 	trace_boot_set_ftrace_options(tr, trace_node);
+	trace_boot_init_events(tr, trace_node);
 	trace_boot_enable_events(tr, trace_node);
 	trace_boot_enable_tracer(tr, trace_node);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2cd53ca21b51..d8ada4c6f3f7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -213,7 +213,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int trigger_process_regex(struct trace_event_file *file, char *buff)
+int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
 	char *command, *next = buff;
 	struct event_command *p;

