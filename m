Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF712ACE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLZOHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZOHW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:07:22 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750A7206CB;
        Thu, 26 Dec 2019 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369241;
        bh=xsmf4WvSqJzcgTm0bmGmTXyRwyCOH5Qwny1WYE94p7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CBrAGq+AA6cEyXqhKxrS9GLwyduRnJ0flsCjNZaWa8yWFaAG1a6W1BEzJ6NVBhRY
         4ggwCw2vdNTqJqszq7Ap9wR2WvbsqNTc2p6pNBTzMwVsI52mcRArD2L0M3TSrpC/K9
         hLhMdnz60kD/fA7NTuSSnhWkCLQa58ALBR+Q6o9A=
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
Subject: [PATCH v5 17/22] tracing/boot Add kprobe event support
Date:   Thu, 26 Dec 2019 23:07:15 +0900
Message-Id: <157736923490.11126.3548816332349251267.stgit@devnote2>
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

Add kprobe event support on event node to boot-time tracing.
If the group name of event is "kprobes", the boot-time tracing
defines new probe event according to "probes" values.

 - ftrace.event.kprobes.EVENT.probes = PROBE[, PROBE2...]
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
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 37524031533e..a11dc60299fb 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -76,6 +76,48 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	}
 }
 
+#ifdef CONFIG_KPROBE_EVENTS
+extern int trace_kprobe_run_command(const char *command);
+
+static int __init
+trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
+{
+	struct xbc_node *anode;
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
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
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
+trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
+{
+	pr_err("Kprobe event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			  struct xbc_node *enode)
@@ -88,6 +130,10 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 	group = xbc_node_get_data(gnode);
 	event = xbc_node_get_data(enode);
 
+	if (!strcmp(group, "kprobes"))
+		if (trace_boot_add_kprobe_event(enode, event) < 0)
+			return;
+
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
 	if (!file) {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5584405b899d..318a3579a928 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -902,6 +902,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
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

