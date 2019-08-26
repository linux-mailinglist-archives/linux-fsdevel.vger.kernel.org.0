Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE489C7D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfHZDTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfHZDTT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:19:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93F62070B;
        Mon, 26 Aug 2019 03:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789558;
        bh=2hqvqjb4JRbv59jAzcU+dKYGR+NXhgzGBeJ3dWiVhdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sv3Fvm/tvtHGU71iCv0m7liX43HCg8VeHCygpsU35XNGDMcGKWwzDKrdw0yE++5e9
         4zMTqUPTQEVCGxT8rerpMrq4uDWrQflAwvew7Hfec2BvYNDOU8449nhhOMEIJMLIof
         lpS7xvOCoO9y4pwtelBgIa7XhQD2W53kVMkXZ8jE=
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
Subject: [RFC PATCH v3 18/19] tracing/boot: Add function-graph tracer options
Date:   Mon, 26 Aug 2019 12:19:11 +0900
Message-Id: <156678955140.21459.9556721429972023089.stgit@devnote2>
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

Add following function-graph tracer related options

 - ftrace.fgraph.filters = FILTER[, FILTER2...];
   Add fgraph tracing function filters.

 - ftrace.fgraph.notraces = FILTER[, FILTER2...];
   Add fgraph non tracing function filters.

 - ftrace.fgraph.max_depth = MAX_DEPTH;
   Set MAX_DEPTH to maximum depth of fgraph tracer.

Note that these properties are available on ftrace global node
only, because these filters are globally applied.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c     |   85 +++++++++++++++++++++++++++++----------------
 kernel/trace/trace_boot.c |   71 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca34503f178..e016ce12e60a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1241,7 +1241,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	mutex_unlock(&ftrace_lock);
 }
 
-static void free_ftrace_hash(struct ftrace_hash *hash)
+void free_ftrace_hash(struct ftrace_hash *hash)
 {
 	if (!hash || hash == EMPTY_HASH)
 		return;
@@ -4897,7 +4897,7 @@ __setup("ftrace_filter=", set_ftrace_filter);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static char ftrace_graph_buf[FTRACE_FILTER_SIZE] __initdata;
 static char ftrace_graph_notrace_buf[FTRACE_FILTER_SIZE] __initdata;
-static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
+int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
 
 static int __init set_graph_function(char *str)
 {
@@ -5226,6 +5226,26 @@ __ftrace_graph_open(struct inode *inode, struct file *file,
 	return ret;
 }
 
+struct ftrace_hash *ftrace_graph_copy_hash(bool enable)
+{
+	struct ftrace_hash *hash;
+
+	mutex_lock(&graph_lock);
+
+	if (enable)
+		hash = rcu_dereference_protected(ftrace_graph_hash,
+					lockdep_is_held(&graph_lock));
+	else
+		hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
+					lockdep_is_held(&graph_lock));
+
+	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS, hash);
+
+	mutex_unlock(&graph_lock);
+
+	return hash;
+}
+
 static int
 ftrace_graph_open(struct inode *inode, struct file *file)
 {
@@ -5282,11 +5302,40 @@ ftrace_graph_notrace_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int ftrace_graph_apply_hash(struct ftrace_hash *hash, bool enable)
+{
+	struct ftrace_hash *old_hash, *new_hash;
+
+	new_hash = __ftrace_hash_move(hash);
+	if (!new_hash)
+		return -ENOMEM;
+
+	mutex_lock(&graph_lock);
+
+	if (enable) {
+		old_hash = rcu_dereference_protected(ftrace_graph_hash,
+				lockdep_is_held(&graph_lock));
+		rcu_assign_pointer(ftrace_graph_hash, new_hash);
+	} else {
+		old_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
+				lockdep_is_held(&graph_lock));
+		rcu_assign_pointer(ftrace_graph_notrace_hash, new_hash);
+	}
+
+	mutex_unlock(&graph_lock);
+
+	/* Wait till all users are no longer using the old hash */
+	synchronize_rcu();
+
+	free_ftrace_hash(old_hash);
+
+	return 0;
+}
+
 static int
 ftrace_graph_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_graph_data *fgd;
-	struct ftrace_hash *old_hash, *new_hash;
 	struct trace_parser *parser;
 	int ret = 0;
 
@@ -5311,41 +5360,17 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		trace_parser_put(parser);
 
-		new_hash = __ftrace_hash_move(fgd->new_hash);
-		if (!new_hash) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		mutex_lock(&graph_lock);
-
-		if (fgd->type == GRAPH_FILTER_FUNCTION) {
-			old_hash = rcu_dereference_protected(ftrace_graph_hash,
-					lockdep_is_held(&graph_lock));
-			rcu_assign_pointer(ftrace_graph_hash, new_hash);
-		} else {
-			old_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
-					lockdep_is_held(&graph_lock));
-			rcu_assign_pointer(ftrace_graph_notrace_hash, new_hash);
-		}
-
-		mutex_unlock(&graph_lock);
-
-		/* Wait till all users are no longer using the old hash */
-		synchronize_rcu();
-
-		free_ftrace_hash(old_hash);
+		ret = ftrace_graph_apply_hash(fgd->new_hash,
+					fgd->type == GRAPH_FILTER_FUNCTION);
 	}
 
- out:
 	free_ftrace_hash(fgd->new_hash);
 	kfree(fgd);
 
 	return ret;
 }
 
-static int
-ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
+int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 {
 	struct ftrace_glob func_g;
 	struct dyn_ftrace *rec;
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 942ca8d3fcc8..b32688032d36 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -72,6 +72,75 @@ trace_boot_set_instance_options(struct trace_array *tr, struct skc_node *node)
 	}
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+extern unsigned int fgraph_max_depth;
+extern struct ftrace_hash *ftrace_graph_copy_hash(bool enable);
+extern int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
+extern int ftrace_graph_apply_hash(struct ftrace_hash *hash, bool enable);
+extern void free_ftrace_hash(struct ftrace_hash *hash);
+
+static void __init
+trace_boot_set_fgraph_filter(struct skc_node *node, const char *option,
+			     bool enable)
+{
+	struct ftrace_hash *hash;
+	struct skc_node *anode;
+	const char *p;
+	char *q;
+	int err;
+	bool updated = false;
+
+	hash = ftrace_graph_copy_hash(enable);
+	if (!hash) {
+		pr_err("Failed to copy fgraph hash\n");
+		return;
+	}
+	skc_node_for_each_array_value(node, option, anode, p) {
+		q = kstrdup(p, GFP_KERNEL);
+		if (!q)
+			goto free_hash;
+		err = ftrace_graph_set_hash(hash, q);
+		kfree(q);
+		if (err)
+			pr_err("Failed to add %s: %s\n", option, p);
+		else
+			updated = true;
+	}
+	if (!updated)
+		goto free_hash;
+
+	if (ftrace_graph_apply_hash(hash, enable) < 0)
+		pr_err("Failed to apply new fgraph hash\n");
+	else {
+		/* If succeeded to apply new hash, old hash is released */
+		return;
+	}
+
+free_hash:
+	free_ftrace_hash(hash);
+}
+
+static void __init
+trace_boot_set_fgraph_options(struct skc_node *node)
+{
+	const char *p;
+	unsigned long v;
+
+	node = skc_node_find_child(node, "fgraph");
+	if (!node)
+		return;
+
+	trace_boot_set_fgraph_filter(node, "filters", true);
+	trace_boot_set_fgraph_filter(node, "notraces", false);
+
+	p = skc_node_find_value(node, "max_depth", NULL);
+	if (p && *p != '\0' && !kstrtoul(p, 0, &v))
+		fgraph_max_depth = (unsigned int)v;
+}
+#else
+#define trace_boot_set_fgraph_options(node)	do {} while (0)
+#endif
+
 static void __init
 trace_boot_set_global_options(struct trace_array *tr, struct skc_node *node)
 {
@@ -98,6 +167,8 @@ trace_boot_set_global_options(struct trace_array *tr, struct skc_node *node)
 	if (skc_node_find_value(node, "alloc_snapshot", NULL))
 		if (tracing_alloc_snapshot() < 0)
 			pr_err("Failed to allocate snapshot buffer\n");
+
+	trace_boot_set_fgraph_options(node);
 }
 
 #ifdef CONFIG_EVENT_TRACING

