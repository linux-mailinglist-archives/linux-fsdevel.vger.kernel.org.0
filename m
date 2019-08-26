Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE7B9C7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfHZDRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDRT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:17:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36342173E;
        Mon, 26 Aug 2019 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789438;
        bh=pZzkhwcBJfs0QtEtXuJLrkB89zQzll96XuQ1G/Is+0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1q6ynV4eXb20bwoW+OZ+DkHDdintCvMuzhPd8biapLRfC/+ps+VIQwFXQK6TrjZD
         dKlWQppXhMlmJMSGpi7bgbKhwKC8sEVFdBJDBhk4ceZ7QchgXh3nEITBxhtqnONxm7
         vcOG40PwdgVdbpTMkyzhU5rGKEIKzbiw4BrhBFR4=
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
Subject: [RFC PATCH v3 08/19] tracing: kprobes: Register to dynevent earlier stage
Date:   Mon, 26 Aug 2019 12:17:12 +0900
Message-Id: <156678943243.21459.6275766489688267737.stgit@devnote2>
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

Register kprobe event to dynevent in subsys_initcall level.
This will allow kernel to register new kprobe events in
fs_initcall level via trace_run_command.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6c5145525f90..5135c07b6557 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1484,11 +1484,12 @@ static __init void setup_boot_kprobe_events(void)
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
@@ -1498,6 +1499,16 @@ static __init int init_kprobe_trace(void)
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

