Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16BD9C7D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfHZDTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfHZDTG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:19:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC48C2168B;
        Mon, 26 Aug 2019 03:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789546;
        bh=w3J2cJs2crg8gGwITUaTLh45R8avn+V3leFR9667rmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNnd1gLuTIZqShGN9uAV4YnJ3H+rZCzocE2nuMiFOKrJwxxQ6+v2qHmYsFOIaIsww
         fRmxeKW8QimVp1MS8N/nLqSCiS8J3kjlcA4Q85UJK1MDH28zkCdveUv19BZdS6VHqi
         Ao9hsnDFsd1dyEiRMZ48inf+a8z2tGiL0iVXBOBw=
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
Subject: [RFC PATCH v3 17/19] tracing/boot: Add function tracer filter options
Date:   Mon, 26 Aug 2019 12:18:59 +0900
Message-Id: <156678953942.21459.2531310402301118028.stgit@devnote2>
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

Add below function-tracer filter options to boottime tracer.

 - ftrace.[instance.INSTANCE.]ftrace.filters
   This will take an array of tracing function filter rules

 - ftrace.[instance.INSTANCE.]ftrace.notraces
   This will take an array of NON-tracing function filter rules

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 755a2040aebf..942ca8d3fcc8 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -276,11 +276,51 @@ trace_boot_init_events(struct trace_array *tr, struct skc_node *node)
 #define trace_boot_init_events(tr, node) do {} while (0)
 #endif
 
+#ifdef CONFIG_FUNCTION_TRACER
+extern bool ftrace_filter_param __initdata;
+extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
+			      int len, int reset);
+static void __init
+trace_boot_set_ftrace_filter(struct trace_array *tr, struct skc_node *node)
+{
+	struct skc_node *anode;
+	const char *p;
+	char *q;
+
+	skc_node_for_each_array_value(node, "ftrace.filters", anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			return;
+		if (ftrace_set_filter(tr->ops, q, strlen(q), 0) < 0)
+			pr_err("Failed to add %s to ftrace filter\n", p);
+		else
+			ftrace_filter_param = true;
+		kfree(q);
+	}
+	skc_node_for_each_array_value(node, "ftrace.notraces", anode, p) {
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
 trace_boot_enable_tracer(struct trace_array *tr, struct skc_node *node)
 {
 	const char *p;
 
+	trace_boot_set_ftrace_filter(tr, node);
+
 	p = skc_node_find_value(node, "tracer", NULL);
 	if (p && *p != '\0') {
 		if (tracing_set_tracer(tr, p) < 0)

