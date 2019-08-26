Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C059C7CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfHZDS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbfHZDSz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EED2070B;
        Mon, 26 Aug 2019 03:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789534;
        bh=KZucuPNaFyRUaxEnWFtoud2RPq4vc5t+1we+rVn+daI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Czv3i715OAeOfl43xR9vjk4FosmSDAjZRHMhZqMgz/8T9OGLV2/UaD2diJd5E6RxH
         MIqCAbAiKyuBk8zAZiAEBkoabWCaEElJfN2lhT8s4te/TuviURsdnXs/kn2l+U7fDs
         fbJoW3/GdxbVmwQDb4LfPVb0gEb3ocJDJ8IPOQMo=
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
Subject: [RFC PATCH v3 16/19] tracing/boot: Add cpu_mask option support
Date:   Mon, 26 Aug 2019 12:18:47 +0900
Message-Id: <156678952725.21459.13151153295760559536.stgit@devnote2>
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

Add ftrace.cpumask option support for setting trace
cpumask.

 - ftrace.[instance.INSTANCE.]cpumask = CPUMASK;
   Set the trace cpumask. Note that the CPUMASK should be a string
   which <tracefs>/tracing_cpumask can accepts.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c      |   41 ++++++++++++++++++++++++++++-------------
 kernel/trace/trace_boot.c |   14 ++++++++++++++
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 69400a87e48f..bfe513e472d2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4437,20 +4437,12 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 	return count;
 }
 
-static ssize_t
-tracing_cpumask_write(struct file *filp, const char __user *ubuf,
-		      size_t count, loff_t *ppos)
+int tracing_set_cpumask(struct trace_array *tr, cpumask_var_t tracing_cpumask_new)
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
@@ -4474,11 +4466,34 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
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
index 74cffecd12a4..755a2040aebf 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -22,6 +22,8 @@ extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 extern struct trace_array *trace_array_create(const char *name);
+extern int tracing_set_cpumask(struct trace_array *tr,
+				cpumask_var_t tracing_cpumask_new);
 
 static void __init
 trace_boot_set_instance_options(struct trace_array *tr, struct skc_node *node)
@@ -56,6 +58,18 @@ trace_boot_set_instance_options(struct trace_array *tr, struct skc_node *node)
 		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
 			pr_err("Failed to resize trace buffer to %s\n", p);
 	}
+
+	p = skc_node_find_value(node, "cpumask", NULL);
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
 
 static void __init

