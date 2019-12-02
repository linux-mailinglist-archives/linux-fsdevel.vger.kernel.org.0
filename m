Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940AC10E899
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLBKRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLBKRI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:17:08 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542A7217D9;
        Mon,  2 Dec 2019 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281828;
        bh=O8juxFZmkz2rKieVA1WbLZwujWvQ9y+R8bFc8iQKL1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6Q+BDCOL/hAeDve39PK72ewbIpveCOD0vPpS5YO7RvRr14NpIkIGeSu3a43UsAAL
         KcicIntD1Y0/kHL3JNpQuJGDiPFMZK53JnzXZUa9HnCg7pxhUco8/jU7V9Q6Z4nfYC
         Nd33Bot+iiuRc4b7XizHQ/ryOripVY/vp7qIPk7c=
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
Subject: [RFC PATCH v4 20/22] tracing/boot: Add cpu_mask option support
Date:   Mon,  2 Dec 2019 19:17:02 +0900
Message-Id: <157528182188.22451.10963189319801346266.stgit@devnote2>
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

Add ftrace.cpumask option support to boot-time tracing.
This sets cpumask for each instance.

 - ftrace.[instance.INSTANCE.]cpumask = CPUMASK;
   Set the trace cpumask. Note that the CPUMASK should be a string
   which <tracefs>/tracing_cpumask can accepts.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c      |   42 +++++++++++++++++++++++++++++-------------
 kernel/trace/trace_boot.c |   14 ++++++++++++++
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c19dce22f5bd..008d3788331a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4555,20 +4555,13 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 	return count;
 }
 
-static ssize_t
-tracing_cpumask_write(struct file *filp, const char __user *ubuf,
-		      size_t count, loff_t *ppos)
+int tracing_set_cpumask(struct trace_array *tr,
+			cpumask_var_t tracing_cpumask_new)
 {
-	struct trace_array *tr = file_inode(filp)->i_private;
-	cpumask_var_t tracing_cpumask_new;
-	int err, cpu;
-
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
-		return -ENOMEM;
+	int cpu;
 
-	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
-	if (err)
-		goto err_unlock;
+	if (!tr)
+		return -EINVAL;
 
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
@@ -4592,11 +4585,34 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	local_irq_enable();
 
 	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
+
+	return 0;
+}
+
+static ssize_t
+tracing_cpumask_write(struct file *filp, const char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct trace_array *tr = file_inode(filp)->i_private;
+	cpumask_var_t tracing_cpumask_new;
+	int err;
+
+	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
+	err = tracing_set_cpumask(tr, tracing_cpumask_new);
+	if (err)
+		goto err_free;
+
 	free_cpumask_var(tracing_cpumask_new);
 
 	return count;
 
-err_unlock:
+err_free:
 	free_cpumask_var(tracing_cpumask_new);
 
 	return err;
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index f5db30d25b0b..81d923c16a4d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -18,6 +18,8 @@ extern int trace_set_options(struct trace_array *tr, char *option);
 extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
+extern int tracing_set_cpumask(struct trace_array *tr,
+				cpumask_var_t tracing_cpumask_new);
 
 static void __init
 trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
@@ -52,6 +54,18 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
 			pr_err("Failed to resize trace buffer to %s\n", p);
 	}
+
+	p = xbc_node_find_value(node, "cpumask", NULL);
+	if (p && *p != '\0') {
+		cpumask_var_t new_mask;
+
+		if (alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+			if (cpumask_parse(p, new_mask) < 0 ||
+			    tracing_set_cpumask(tr, new_mask) < 0)
+				pr_err("Failed to set new CPU mask %s\n", p);
+			free_cpumask_var(new_mask);
+		}
+	}
 }
 
 #ifdef CONFIG_EVENT_TRACING

