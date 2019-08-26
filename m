Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDE9C7BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfHZDSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDSI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:08 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD972070B;
        Mon, 26 Aug 2019 03:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789486;
        bh=ICuWmK4ZyGjBiw83BcImptVaBmrjkJy1XTmFQ1gPbnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9OBvZnNPTKKgua28v62Sv95I3gKvJxXx8bV9qybIst5UpQ3NvH/C+HUqg0yMP5sp
         6+bXKi9Irl/VL3WlIfdqj5CAMPnjE+sfwqVetOyBw9lga98pzmI4cZjx5rb2I/vqn5
         YQul7ggrPcCg4D7ICnfy/NYbz+E7y++duWZeTDWA=
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
Subject: [RFC PATCH v3 12/19] tracing/boot: Add per-event settings
Date:   Mon, 26 Aug 2019 12:18:00 +0900
Message-Id: <156678948034.21459.12734081118923661873.stgit@devnote2>
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

Add per-event settings for boottime tracing. User can set filter,
actions and enable on each event on boot. The event entries are
under ftrace.event.GROUP.EVENT node (note that the option key
includes event's group name and event name.) This supports below
commands.

 - ftrace.event.GROUP.EVENT.enable;
   Enables GROUP:EVENT tracing.

 - ftrace.event.GROUP.EVENT.filter = FILTER;
   Set FILTER rule to the GROUP:EVENT.

 - ftrace.event.GROUP.EVENT.actions = ACTION[, ACTION2...];
   Set ACTIONs to the GROUP:EVENT.

For example,

  ftrace.event.sched.sched_process_exec {
                filter = "pid < 128";
		enable;
  }

this will enable tracing "sched:sched_process_exec" event
with "pid < 128" filter.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c           |   60 +++++++++++++++++++++++++++++++++++
 kernel/trace/trace_events_trigger.c |    2 +
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index cc5e81368065..cfd628c16761 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -80,6 +80,7 @@ trace_boot_set_ftrace_options(struct trace_array *tr, struct skc_node *node)
 
 #ifdef CONFIG_EVENT_TRACING
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 
 static void __init
 trace_boot_enable_events(struct trace_array *tr, struct skc_node *node)
@@ -98,8 +99,66 @@ trace_boot_enable_events(struct trace_array *tr, struct skc_node *node)
 			pr_err("Failed to enable event: %s\n", p);
 	}
 }
+
+static void __init
+trace_boot_init_one_event(struct trace_array *tr, struct skc_node *gnode,
+			  struct skc_node *enode)
+{
+	struct trace_event_file *file;
+	struct skc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *p, *group, *event;
+
+	group = skc_node_get_data(gnode);
+	event = skc_node_get_data(enode);
+
+	mutex_lock(&event_mutex);
+	file = find_event_file(tr, group, event);
+	if (!file) {
+		pr_err("Failed to find event: %s:%s\n", group, event);
+		goto out;
+	}
+
+	p = skc_node_find_value(enode, "filter", NULL);
+	if (p && *p != '\0') {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("filter string is too long: %s\n", p);
+		else if (apply_event_filter(file, buf) < 0)
+			pr_err("Failed to apply filter: %s\n", buf);
+	}
+
+	skc_node_for_each_array_value(enode, "actions", anode, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			pr_err("action string is too long: %s\n", p);
+		else if (trigger_process_regex(file, buf) < 0)
+			pr_err("Failed to apply an action: %s\n", buf);
+	}
+
+	if (skc_node_find_value(enode, "enable", NULL)) {
+		if (trace_event_enable_disable(file, 1, 0) < 0)
+			pr_err("Failed to enable event node: %s:%s\n",
+				group, event);
+	}
+out:
+	mutex_unlock(&event_mutex);
+}
+
+static void __init
+trace_boot_init_events(struct trace_array *tr, struct skc_node *node)
+{
+	struct skc_node *gnode, *enode;
+
+	node = skc_node_find_child(node, "event");
+	if (!node)
+		return;
+	/* per-event key starts with "event.GROUP.EVENT" */
+	skc_node_for_each_child(node, gnode)
+		skc_node_for_each_child(gnode, enode)
+			trace_boot_init_one_event(tr, gnode, enode);
+}
 #else
 #define trace_boot_enable_events(tr, node) do {} while (0)
+#define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
 static void __init
@@ -128,6 +187,7 @@ static int __init trace_boot_init(void)
 		return 0;
 
 	trace_boot_set_ftrace_options(tr, trace_node);
+	trace_boot_init_events(tr, trace_node);
 	trace_boot_enable_events(tr, trace_node);
 	trace_boot_enable_tracer(tr, trace_node);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2a2912cb4533..74a19c18219f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -208,7 +208,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int trigger_process_regex(struct trace_event_file *file, char *buff)
+int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
 	char *command, *next = buff;
 	struct event_command *p;

