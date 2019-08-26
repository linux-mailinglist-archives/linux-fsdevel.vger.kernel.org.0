Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA89C7C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfHZDSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfHZDSn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEEB42173E;
        Mon, 26 Aug 2019 03:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789521;
        bh=4fPsr18xxsuPXL9Lp95SiJ4t2t8JicrM5cKgfBo8bzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEB3nHWwf/t9MBjXiLCsEp6Oma7ti9w0hA6d1bWHYcUicvSfyl4HI+PknJbkMczOs
         Z2agX/TnNrmW4g1BzAfKPUVdedqPspbdIR02ez1lrDXiwnNx5DC3UmLsWnZRaWh1sL
         Do1KKclTJO2U2ZvWyI65VTCYCs7Vj+tCaYAqsjmc=
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
Subject: [RFC PATCH v3 15/19] tracing/boot: Add instance node support
Date:   Mon, 26 Aug 2019 12:18:35 +0900
Message-Id: <156678951557.21459.13013581523042678676.stgit@devnote2>
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

Add instance node support to boottime tracing. User can set
some options and event nodes under instance node.

 - ftrace.instance.INSTANCE[...];
   Add new INSTANCE instance. Some options and event nodes
   are acceptable for instance node.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   72 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 2e9fddff660f..74cffecd12a4 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -21,15 +21,15 @@ extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
 extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
+extern struct trace_array *trace_array_create(const char *name);
 
 static void __init
-trace_boot_set_ftrace_options(struct trace_array *tr, struct skc_node *node)
+trace_boot_set_instance_options(struct trace_array *tr, struct skc_node *node)
 {
 	struct skc_node *anode;
 	const char *p;
 	char buf[MAX_BUF_LEN];
 	unsigned long v = 0;
-	int err;
 
 	/* Common ftrace options */
 	skc_node_for_each_array_value(node, "options", anode, p) {
@@ -48,6 +48,23 @@ trace_boot_set_ftrace_options(struct trace_array *tr, struct skc_node *node)
 			pr_err("Failed to set trace clock: %s\n", p);
 	}
 
+	p = skc_node_find_value(node, "buffer_size", NULL);
+	if (p && *p != '\0') {
+		v = memparse(p, NULL);
+		if (v < PAGE_SIZE)
+			pr_err("Buffer size is too small: %s\n", p);
+		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
+			pr_err("Failed to resize trace buffer to %s\n", p);
+	}
+}
+
+static void __init
+trace_boot_set_global_options(struct trace_array *tr, struct skc_node *node)
+{
+	unsigned long v = 0;
+	const char *p;
+	int err;
+
 	/* Command line boot options */
 	p = skc_node_find_value(node, "dump_on_oops", NULL);
 	if (p) {
@@ -64,15 +81,6 @@ trace_boot_set_ftrace_options(struct trace_array *tr, struct skc_node *node)
 	if (skc_node_find_value(node, "tp_printk", NULL))
 		trace_init_tracepoint_printk();
 
-	p = skc_node_find_value(node, "buffer_size", NULL);
-	if (p && *p != '\0') {
-		v = memparse(p, NULL);
-		if (v < PAGE_SIZE)
-			pr_err("Buffer size is too small: %s\n", p);
-		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
-			pr_err("Failed to resize trace buffer to %s\n", p);
-	}
-
 	if (skc_node_find_value(node, "alloc_snapshot", NULL))
 		if (tracing_alloc_snapshot() < 0)
 			pr_err("Failed to allocate snapshot buffer\n");
@@ -266,6 +274,40 @@ trace_boot_enable_tracer(struct trace_array *tr, struct skc_node *node)
 	}
 }
 
+static void __init
+trace_boot_init_one_instance(struct trace_array *tr, struct skc_node *node)
+{
+	trace_boot_set_instance_options(tr, node);
+	trace_boot_init_events(tr, node);
+	trace_boot_enable_events(tr, node);
+	trace_boot_enable_tracer(tr, node);
+}
+
+static void __init
+trace_boot_init_instances(struct skc_node *node)
+{
+	struct skc_node *inode;
+	struct trace_array *tr;
+	const char *p;
+
+	node = skc_node_find_child(node, "instance");
+	if (!node)
+		return;
+
+	skc_node_for_each_child(node, inode) {
+		p = skc_node_get_data(inode);
+		if (!p || *p == '\0')
+			continue;
+
+		tr = trace_array_create(p);
+		if (IS_ERR(tr)) {
+			pr_err("Failed to create instance %s\n", p);
+			continue;
+		}
+		trace_boot_init_one_instance(tr, inode);
+	}
+}
+
 static int __init trace_boot_init(void)
 {
 	struct skc_node *trace_node;
@@ -279,10 +321,10 @@ static int __init trace_boot_init(void)
 	if (!tr)
 		return 0;
 
-	trace_boot_set_ftrace_options(tr, trace_node);
-	trace_boot_init_events(tr, trace_node);
-	trace_boot_enable_events(tr, trace_node);
-	trace_boot_enable_tracer(tr, trace_node);
+	trace_boot_set_global_options(tr, trace_node);
+	/* Global trace array is also one instance */
+	trace_boot_init_one_instance(tr, trace_node);
+	trace_boot_init_instances(trace_node);
 
 	return 0;
 }

