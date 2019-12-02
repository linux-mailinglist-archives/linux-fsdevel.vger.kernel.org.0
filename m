Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8793910E89F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLBKRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfLBKRc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:17:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B12F217D9;
        Mon,  2 Dec 2019 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281850;
        bh=CQwLaPfjyq5qvrJ95mM35q4XZZrZIKEuQkYcOzmmww4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofKz3D+UYOSrcblzVDZ44gBbY0L3/A79zqd3D02vsq1wQHg4F91Mv2avrpk2hbH1s
         ocfS8pfqx2g6I359u4PcAzv0breZDSdn0WfYTJe8FY3X6Rsw7wIt6ZlZx0FPgU0eKX
         zByI/xtCEyIsfeahVWhemL8DuCvA12MlXW0/HH0Y=
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
Subject: [RFC PATCH v4 22/22] Documentation: tracing: Add boot-time tracing document
Date:   Mon,  2 Dec 2019 19:17:25 +0900
Message-Id: <157528184501.22451.12534762470752205454.stgit@devnote2>
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

Add a documentation about boot-time tracing options in
boot config.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |    2 
 Documentation/trace/boottime-trace.rst   |  184 ++++++++++++++++++++++++++++++
 Documentation/trace/index.rst            |    1 
 3 files changed, 187 insertions(+)
 create mode 100644 Documentation/trace/boottime-trace.rst

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index db35cee8a00a..ab015e512614 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _bootconfig:
+
 ==================
 Boot Configuration
 ==================
diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
new file mode 100644
index 000000000000..1d10fdebf1b2
--- /dev/null
+++ b/Documentation/trace/boottime-trace.rst
@@ -0,0 +1,184 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Boot-time tracing
+=================
+
+:Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+========
+
+Boot-time tracing allows users to trace boot-time process including
+device initialization with full features of ftrace including per-event
+filter and actions, histograms, kprobe-events and synthetic-events,
+and trace instances.
+Since kernel cmdline is not enough to control these complex features,
+this uses bootconfig file to describe tracing feature programming.
+
+Options in the Boot Config
+==========================
+
+Here is the list of available options list for boot time tracing in
+boot config file [1]_. All options are under "ftrace." or "kernel."
+refix. See kernel parameters for the options which starts
+with "kernel." prefix [2]_.
+
+.. [1] See :ref:`Documentation/admin-guide/bootconfig.rst <bootconfig>`
+.. [2] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+
+Ftrace Global Options
+---------------------
+
+Ftrace global options have "kernel." prefix in boot config, which means
+these options are passed as a part of kernel legacy command line.
+
+kernel.tp_printk
+   Output trace-event data on printk buffer too.
+
+kernel.dump_on_oops [= MODE]
+   Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
+   on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.
+
+kernel.traceoff_on_warning
+   Stop tracing if WARN_ON() occurs.
+
+kernel.fgraph_max_depth = MAX_DEPTH
+   Set MAX_DEPTH to maximum depth of fgraph tracer.
+
+kernel.fgraph_filters = FILTER[, FILTER2...]
+   Add fgraph tracing function filters.
+
+kernel.fgraph_notraces = FILTER[, FILTER2...]
+   Add fgraph non tracing function filters.
+
+
+Ftrace Per-instance Options
+---------------------------
+
+These options can be used for each instance including global ftrace node.
+
+ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
+   Enable given ftrace options.
+
+ftrace.[instance.INSTANCE.]trace_clock = CLOCK
+   Set given CLOCK to ftrace's trace_clock.
+
+ftrace.[instance.INSTANCE.]buffer_size = SIZE
+   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
+   for that SIZE.
+
+ftrace.[instance.INSTANCE.]alloc_snapshot
+   Allocate snapshot buffer.
+
+ftrace.[instance.INSTANCE.]cpumask = CPUMASK
+   Set CPUMASK as trace cpu-mask.
+
+ftrace.[instance.INSTANCE.]events = EVENT[, EVENT2[...]]
+   Enable given events on boot. You can use a wild card in EVENT.
+
+ftrace.[instance.INSTANCE.]tracer = TRACER
+   Set TRACER to current tracer on boot. (e.g. function)
+
+ftrace.[instance.INSTANCE.]ftrace.filters
+   This will take an array of tracing function filter rules
+
+ftrace.[instance.INSTANCE.]ftrace.notraces
+   This will take an array of NON-tracing function filter rules
+
+
+Ftrace Per-Event Options
+------------------------
+
+These options are setting per-event options.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
+   Enables GROUP:EVENT tracing.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
+   Set FILTER rule to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.actions = ACTION[, ACTION2[...]]
+   Set ACTIONs to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.kprobes.EVENT.probes = PROBE[, PROBE2[...]]
+   Defines new kprobe event based on PROBEs. It is able to define
+   multiple probes on one event, but those must have same type of
+   arguments. This option is available only for the event which
+   group name is "kprobes".
+
+ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2[...]]
+   Defines new synthetic event with FIELDs. Each field should be
+   "type varname".
+
+Note that kprobe and synthetic event definitions can be written under
+instance node, but those are also visible from other instances. So please
+take care for event name conflict.
+
+
+Examples
+========
+
+For example, to add filter and actions for each event, define kprobe
+events, and synthetic events with histogram, write a boot config like
+below::
+
+  ftrace.event {
+        task.task_newtask {
+                filter = "pid < 128"
+                enable
+        }
+        kprobes.vfs_read {
+                probes = "vfs_read $arg1 $arg2"
+                filter = "common_pid < 200"
+                enable
+        }
+        synthetic.initcall_latency {
+                fields = "unsigned long func", "u64 lat"
+                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
+        }
+        initcall.initcall_start {
+                actions = "hist:keys=func:ts0=common_timestamp.usecs"
+        }
+        initcall.initcall_finish {
+                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
+        }
+  }
+
+Also, boottime tracing supports "instance" node, which allows us to run
+several tracers for different purpose at once. For example, one tracer
+is for tracing functions start with "user\_", and others tracing "kernel\_"
+functions, you can write boot config as below::
+
+  ftrace.instance {
+        foo {
+                tracer = "function"
+                ftrace.filters = "user_*"
+        }
+        bar {
+                tracer = "function"
+                ftrace.filters = "kernel_*"
+        }
+  }
+
+The instance node also accepts event nodes so that each instance
+can customize its event tracing.
+
+This boot-time tracing also supports ftrace kernel parameters via boot
+config.
+For example, following kernel parameters::
+
+ trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
+
+This can be written in boot config like below::
+
+  kernel {
+        trace_options = sym-addr
+        trace_event = "initcall:*"
+        tp_printk
+        trace_buf_size = 1M
+        ftrace = function
+        ftrace_filter = "vfs*"
+  }
+
+Note that parameters start with "kernel" prefix instead of "ftrace".
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b7891cb1ab4d..47d6b466e308 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -19,6 +19,7 @@ Linux Tracing Technologies
    events-msr
    mmiotrace
    histogram
+   boottime-trace
    hwlat_detector
    intel_th
    stm

