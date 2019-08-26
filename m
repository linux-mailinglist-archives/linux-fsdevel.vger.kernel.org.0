Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8D9C7BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfHZDST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C504B20578;
        Mon, 26 Aug 2019 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789498;
        bh=dx782LyP2EgLfV+vRh1Ur2mO8lwlNqwkIa/BZqJBJxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXcpyIqNs+T7m7w0pBY+ECIHhxlP6ylvuzP4iG4jpOUQVJyIvN3uQpkz3gl7+3ibD
         3W/EoJYHOpKcpMcL8fryRKU8Wbg18qgGsXzJyJOQXevZdI0nMgaqrAke8zRe8xkanA
         e0MSCBLjfx77GdTD0i2oM2whk3FjlZpoFW1U5Kas=
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
Subject: [RFC PATCH v3 13/19] tracing/boot Add kprobe event support
Date:   Mon, 26 Aug 2019 12:18:12 +0900
Message-Id: <156678949243.21459.7280617203512175739.stgit@devnote2>
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

Add kprobe event support on event node. If the group name of event
is "kprobes", boottime trace defines new probe event according
to "probes" values.

 - ftrace.event.kprobes.EVENT.probes = PROBE[, PROBE2...];
   Defines new kprobe event based on PROBEs. It is able to define
   multiple probes on one event, but those must have same type of
   arguments.

For example,

 ftrace.events.kprobes.myevent {
	probes = "vfs_read $arg1 $arg2";
	enable;
 }

This will add kprobes:myevent on vfs_read with the 1st and the 2nd
arguments.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c   |   46 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_kprobe.c |    5 +++++
 2 files changed, 51 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index cfd628c16761..40c89c7ceee0 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -100,6 +100,48 @@ trace_boot_enable_events(struct trace_array *tr, struct skc_node *node)
 	}
 }
 
+#ifdef CONFIG_KPROBE_EVENTS
+extern int trace_kprobe_run_command(const char *command);
+
+static int __init
+trace_boot_add_kprobe_event(struct skc_node *node, const char *event)
+{
+	struct skc_node *anode;
+	char buf[MAX_BUF_LEN];
+	const char *val;
+	char *p;
+	int len;
+
+	len = snprintf(buf, ARRAY_SIZE(buf) - 1, "p:kprobes/%s ", event);
+	if (len >= ARRAY_SIZE(buf)) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	p = buf + len;
+	len = ARRAY_SIZE(buf) - len;
+
+	skc_node_for_each_array_value(node, "probes", anode, val) {
+		if (strlcpy(p, val, len) >= len) {
+			pr_err("Probe definition is too long: %s\n", val);
+			return -E2BIG;
+		}
+		if (trace_kprobe_run_command(buf) < 0) {
+			pr_err("Failed to add probe: %s\n", buf);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+#else
+static inline int __init
+trace_boot_add_kprobe_event(struct skc_node *node, const char *event)
+{
+	pr_err("Kprobe event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct skc_node *gnode,
 			  struct skc_node *enode)
@@ -112,6 +154,10 @@ trace_boot_init_one_event(struct trace_array *tr, struct skc_node *gnode,
 	group = skc_node_get_data(gnode);
 	event = skc_node_get_data(enode);
 
+	if (!strcmp(group, "kprobes"))
+		if (trace_boot_add_kprobe_event(enode, event) < 0)
+			return;
+
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
 	if (!file) {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5135c07b6557..03ce60928c18 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -728,6 +728,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int trace_kprobe_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_trace_kprobe);
+}
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);

