Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA612ACE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLZOHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfLZOHq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:07:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8588D2075E;
        Thu, 26 Dec 2019 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369265;
        bh=wk+GDZaYnjYkVgvDEgV6cBMhq1/IlF7YFn9oGi3wmfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPhhwAsFejfhQHSWVNq++Mhw3qaerJhl4lYGnsvyRTF3tUBQu99r9+D24ifWcUuwr
         Y3imgsinfJpIhSzMebPAOSsC68ZP8kDjqPBFpp/l9rQ/djqdiJoEY9Bh3xNtibVGP2
         9iqT0J0uUolE1uPawKVT/0k60EI0xxWg6ewWavZU=
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
Subject: [PATCH v5 19/22] tracing/boot: Add instance node support
Date:   Thu, 26 Dec 2019 23:07:39 +0900
Message-Id: <157736925917.11126.17834194462403458721.stgit@devnote2>
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
 0 files changed

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

