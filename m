Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0963E13724F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAJQFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgAJQFs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:05:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E18C20838;
        Fri, 10 Jan 2020 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672348;
        bh=VFEjD3rWysPcuxgSvHRR7T5OPSD7O8/ZP7SYzqnrnX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf6jI6ay+SNjggK9lhe7t5Pi7N7yDzoIbnOWLwZ6IB+T2jGoZFQRysqWN3SRIKBjG
         BZywpv9Zz3t9OhotjlsrRuG6Lfggv1DayhaeHA9S3zFqYsTGrsbgDwbXdiF0t/MJ/L
         qLC8Cg73UUIA7DOU2oz8gVjR5zuL+03BnUG5S/Ho=
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
Subject: [PATCH v6 12/22] tracing: kprobes: Register to dynevent earlier stage
Date:   Sat, 11 Jan 2020 01:05:42 +0900
Message-Id: <157867234213.17873.18039000024374948737.stgit@devnote2>
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

Register kprobe event to dynevent in subsys_initcall level.
This will allow kernel to register new kprobe events in
fs_initcall level via trace_run_command.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5899911a5720..5584405b899d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1685,11 +1685,12 @@ static __init void setup_boot_kprobe_events(void)
 	enable_boot_kprobe_events();
 }
 
-/* Make a tracefs interface for controlling probe points */
-static __init int init_kprobe_trace(void)
+/*
+ * Register dynevent at subsys_initcall. This allows kernel to setup kprobe
+ * events in fs_initcall without tracefs.
+ */
+static __init int init_kprobe_trace_early(void)
 {
-	struct dentry *d_tracer;
-	struct dentry *entry;
 	int ret;
 
 	ret = dyn_event_register(&trace_kprobe_ops);
@@ -1699,6 +1700,16 @@ static __init int init_kprobe_trace(void)
 	if (register_module_notifier(&trace_kprobe_module_nb))
 		return -EINVAL;
 
+	return 0;
+}
+subsys_initcall(init_kprobe_trace_early);
+
+/* Make a tracefs interface for controlling probe points */
+static __init int init_kprobe_trace(void)
+{
+	struct dentry *d_tracer;
+	struct dentry *entry;
+
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer))
 		return 0;

