Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3284B12ACF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLZOIK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZOIK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:08:10 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A77C20828;
        Thu, 26 Dec 2019 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369289;
        bh=1xpoICdE9MijyMNp/E/gGzsf+xSXLvJ4gF+ZA1Sb0Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmlC5nxPJuluBpyBqP4llQIFMZeHxfr2idKr5TA4g/UA3ZfTM9RP4D1v3b4CYXQH3
         t3SkwJdHMZt+gF5ZzkAWGwdPN/n3yZUbm465pw9hefzDoT+sphY9H+2qDTHHxj8O5X
         s6OS25CzTnAnhDIOWo94bySG54SbhtXgZzxNCfjY=
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
Subject: [PATCH v5 21/22] tracing/boot: Add function tracer filter options
Date:   Thu, 26 Dec 2019 23:08:03 +0900
Message-Id: <157736928302.11126.8760178688093051786.stgit@devnote2>
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

Add below function-tracer filter options to boot-time tracing.

 - ftrace.[instance.INSTANCE.]ftrace.filters
   This will take an array of tracing function filter rules

 - ftrace.[instance.INSTANCE.]ftrace.notraces
   This will take an array of NON-tracing function filter rules

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

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

