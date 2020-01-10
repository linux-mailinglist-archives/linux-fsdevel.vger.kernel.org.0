Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAE13726A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgAJQHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgAJQHM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:07:12 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9163206ED;
        Fri, 10 Jan 2020 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672430;
        bh=qv6KJiPLfpAE7GH8cSS0edxuald5O/rXHA6Jkgf1bpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+3qSqu4fztjGm1evsJu4Kk8q0yMzTw86fNuo82ycxBawcolZZlccHp0vnQ1p7K6g
         U5U0hRVI3egRl4jCFNUmx18ba2DxXBpG37TybLKb/P2FSXMMkvOqBscArcE6d2sXgl
         VHd7rKLS8bnEw55x1xQPeUxTgA37QeJdXQQYPk/U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Subject: [PATCH v6 19/22] tracing/boot: Add instance node support
Date:   Sat, 11 Jan 2020 01:07:04 +0900
Message-Id: <157867242413.17873.9814204526141500278.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add instance node support to boot-time tracing. User can set
some options and event nodes under instance node.

 - ftrace.instance.INSTANCE[...]
   Add new INSTANCE instance. Some options and event nodes
   are acceptable for instance node.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v4:
   - Use trace_array_get_by_name() instead of trace_array_create().
   - Remove global boot option setting.
---
 kernel/trace/trace_boot.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 3054921b0877..f5db30d25b0b 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -20,7 +20,7 @@ extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 
 static void __init
-trace_boot_set_ftrace_options(struct trace_array *tr, struct xbc_node *node)
+trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 {
 	struct xbc_node *anode;
 	const char *p;
@@ -242,6 +242,40 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 	}
 }
 
+static void __init
+trace_boot_init_one_instance(struct trace_array *tr, struct xbc_node *node)
+{
+	trace_boot_set_instance_options(tr, node);
+	trace_boot_init_events(tr, node);
+	trace_boot_enable_events(tr, node);
+	trace_boot_enable_tracer(tr, node);
+}
+
+static void __init
+trace_boot_init_instances(struct xbc_node *node)
+{
+	struct xbc_node *inode;
+	struct trace_array *tr;
+	const char *p;
+
+	node = xbc_node_find_child(node, "instance");
+	if (!node)
+		return;
+
+	xbc_node_for_each_child(node, inode) {
+		p = xbc_node_get_data(inode);
+		if (!p || *p == '\0')
+			continue;
+
+		tr = trace_array_get_by_name(p);
+		if (IS_ERR(tr)) {
+			pr_err("Failed to get trace instance %s\n", p);
+			continue;
+		}
+		trace_boot_init_one_instance(tr, inode);
+	}
+}
+
 static int __init trace_boot_init(void)
 {
 	struct xbc_node *trace_node;
@@ -255,10 +289,9 @@ static int __init trace_boot_init(void)
 	if (!tr)
 		return 0;
 
-	trace_boot_set_ftrace_options(tr, trace_node);
-	trace_boot_init_events(tr, trace_node);
-	trace_boot_enable_events(tr, trace_node);
-	trace_boot_enable_tracer(tr, trace_node);
+	/* Global trace array is also one instance */
+	trace_boot_init_one_instance(tr, trace_node);
+	trace_boot_init_instances(trace_node);
 
 	return 0;
 }

