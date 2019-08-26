Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D519C7C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfHZDSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDSb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C25A2070B;
        Mon, 26 Aug 2019 03:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789510;
        bh=P7oPsfV6A0jtk+MZWB9QHUi0b3uNU8xu4OT8knJjVa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1K7Herj2qVxuRZLdPAV/Cv9TvLbxJbtCpuG0CWOHV0lL3dB+sSx4aZJtbypAx7O9g
         VOTCVwzOmNcB1vLQP/IvyW1uOZIMqZCre7rRHOzGNMa0xcWmf0fOY/VBUAk4BbAqX1
         4NZcjANnRUM+4zIKKwzJbDo6p9wpVEISMhcFmhqM=
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
Subject: [RFC PATCH v3 14/19] tracing/boot: Add synthetic event support
Date:   Mon, 26 Aug 2019 12:18:24 +0900
Message-Id: <156678950390.21459.4719180337950500537.stgit@devnote2>
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

Add synthetic event node support. The synthetic event is a kind of
event node, but the group name is "synthetic".

 - ftrace.event.synthetic.EVENT.fields = FIELD[, FIELD2...];
   Defines new synthetic event with FIELDs. Each field should be
   "type varname".

The synthetic node requires "fields" string arraies, which defines
the fields as same as tracing/synth_events interface.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c        |   47 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_events_hist.c |    5 ++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 40c89c7ceee0..2e9fddff660f 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -142,6 +142,50 @@ trace_boot_add_kprobe_event(struct skc_node *node, const char *event)
 }
 #endif
 
+#ifdef CONFIG_HIST_TRIGGERS
+extern int synth_event_run_command(const char *command);
+
+static int __init
+trace_boot_add_synth_event(struct skc_node *node, const char *event)
+{
+	struct skc_node *anode;
+	char buf[MAX_BUF_LEN], *q;
+	const char *p;
+	int len, delta, ret;
+
+	len = ARRAY_SIZE(buf);
+	delta = snprintf(buf, len, "%s", event);
+	if (delta >= len) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	len -= delta; q = buf + delta;
+
+	skc_node_for_each_array_value(node, "fields", anode, p) {
+		delta = snprintf(q, len, " %s;", p);
+		if (delta >= len) {
+			pr_err("fields string is too long: %s\n", p);
+			return -E2BIG;
+		}
+		len -= delta; q += delta;
+	}
+
+	ret = synth_event_run_command(buf);
+	if (ret < 0)
+		pr_err("Failed to add synthetic event: %s\n", buf);
+
+
+	return ret;
+}
+#else
+static inline int __init
+trace_boot_add_synth_event(struct skc_node *node, const char *event)
+{
+	pr_err("Synthetic event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
+
 static void __init
 trace_boot_init_one_event(struct trace_array *tr, struct skc_node *gnode,
 			  struct skc_node *enode)
@@ -157,6 +201,9 @@ trace_boot_init_one_event(struct trace_array *tr, struct skc_node *gnode,
 	if (!strcmp(group, "kprobes"))
 		if (trace_boot_add_kprobe_event(enode, event) < 0)
 			return;
+	if (!strcmp(group, "synthetic"))
+		if (trace_boot_add_synth_event(enode, event) < 0)
+			return;
 
 	mutex_lock(&event_mutex);
 	file = find_event_file(tr, group, event);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index db973928e580..e7f5d0a353e2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1343,6 +1343,11 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int synth_event_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_synth_event);
+}
+
 static int synth_event_create(int argc, const char **argv)
 {
 	const char *name = argv[0];

