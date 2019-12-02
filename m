Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB310E89C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfLBKRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfLBKRU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:17:20 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF267215E5;
        Mon,  2 Dec 2019 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281839;
        bh=N2bOqK08ug6H1YZmw+OlkHkSLCiZT7nKPHpqdeNdqwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hd9SRW4J1o0g9w8lnNHTWVXj76+Yg/alCed/P6WMhgP61/7O8xAv7yn1cRRjCj6kM
         aW3XH/wqm7wKg3F80blnLmUjWJS4WsQ7XvTrKrbaD2dzQDHzm7FWVFk6PQ5HV7jG7e
         0l4G2JOYkJnnHpQOyJ9QLMZh7p59ofP71MGF+Saw=
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
Subject: [RFC PATCH v4 21/22] tracing/boot: Add function tracer filter options
Date:   Mon,  2 Dec 2019 19:17:13 +0900
Message-Id: <157528183338.22451.2725921016653118215.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157528159833.22451.14878731055438721716.stgit@devnote2>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add below function-tracer filter options to boot-time tracing.

 - ftrace.[instance.INSTANCE.]ftrace.filters
   This will take an array of tracing function filter rules

 - ftrace.[instance.INSTANCE.]ftrace.notraces
   This will take an array of NON-tracing function filter rules

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 81d923c16a4d..57274b9b3718 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -244,11 +244,51 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 #define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
+#ifdef CONFIG_FUNCTION_TRACER
+extern bool ftrace_filter_param __initdata;
+extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
+			      int len, int reset);
+static void __init
+trace_boot_set_ftrace_filter(struct trace_array *tr, struct xbc_node *node)
+{
+	struct xbc_node *anode;
+	const char *p;
+	char *q;
+
+	xbc_node_for_each_array_value(node, "ftrace.filters", anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			return;
+		if (ftrace_set_filter(tr->ops, q, strlen(q), 0) < 0)
+			pr_err("Failed to add %s to ftrace filter\n", p);
+		else
+			ftrace_filter_param = true;
+		kfree(q);
+	}
+	xbc_node_for_each_array_value(node, "ftrace.notraces", anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			return;
+		if (ftrace_set_notrace(tr->ops, q, strlen(q), 0) < 0)
+			pr_err("Failed to add %s to ftrace filter\n", p);
+		else
+			ftrace_filter_param = true;
+		kfree(q);
+	}
+}
+#else
+#define trace_boot_set_ftrace_filter(tr, node) do {} while (0)
+#endif
+
 static void __init
 trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 {
 	const char *p;
 
+	trace_boot_set_ftrace_filter(tr, node);
+
 	p = xbc_node_find_value(node, "tracer", NULL);
 	if (p && *p != '\0') {
 		if (tracing_set_tracer(tr, p) < 0)

