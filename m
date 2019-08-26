Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDB9C791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfHZDPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDPp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:15:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006962070B;
        Mon, 26 Aug 2019 03:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789344;
        bh=6fXpGs1yWtwhl+U76LgWrl/oQBZaJ+qa5ptpUuzoPas=;
        h=From:To:Cc:Subject:Date:From;
        b=zayPXlYnXt+NVbzjNRiiOW3XoEjPo+W3Wm+uPQ/QqLSdyqH0Hj3HNmT6bGZJBrsL1
         fC/ziVB9o9hROYH/OAQIXv62QBcxNl/9PLUSmJGJPWOeB9YRDzsJWU9dXAkdKbyIfQ
         RF1H6XDXM/GN6DO6nVGktGeRJ1yqieLIy4Pi1ydQ=
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
Subject: [RFC PATCH v3 00/19] tracing: skc: Boot-time tracing and Supplemental Kernel Cmdline
Date:   Mon, 26 Aug 2019 12:15:38 +0900
Message-Id: <156678933823.21459.4100380582025186209.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This is the 3rd version of RFC series for the boot-time tracing.

Previous thread is here.

https://lkml.kernel.org/r/156316746861.23477.5815110570539190650.stgit@devnote2

On that thread and offline talk with Frank Rowand at OSS Japan2019
last month, we agreed that the devicetree is only for hardware
description and should not expand it for software settings.

Thus, in this version, I introduced a new extended command line
feature called Supplemental Kernel Cmdline (SKC) instead of
devicetree, and rewrote the boot-time tracing part based on that.

Supplemental Kernel Cmdline
===========================

Supplemental kernel command line (SKC) allows admin to pass a
tree-structured supplemental kernel commandline file (SKC file)
when boot up kernel. This expands the kernel command line in
efficient way.

Each key is described as a dot-jointed-words. And user can write
the key-words in tree stlye.
For example,

 feature.option.foo = 1;
 feature.option.bar = 2;

can be also written in

 feature.option {
    foo = 1;
    bar = 2;
 }

(Note that in both style, the same words are merged automatically
 and make a single tree)
All values are treated as a string, or array of strings, e.g.

 feature.options = "foo", "bar";

User can see the loaded SKC key-value list via /proc/skc.
The size of SKC is limited upto 32KB and 512 key-words and values
in total.

SKC and Bootloader
==================

To play with SKC, you need to use patched qemu or patched grub.
Please checkout below for x86 support. (for PoC, I implemented it
only for x86, but it is not so hard to do same on other archs)

https://github.com/mhiramat/qemu.git skc

https://github.com/mhiramat/grub.git grub-x86-skc

User can pass an skc file when boot the qemu machine with "-skc PATH"
option. Or specify the skc file on grub console by "skc PATH".

Boot-time Tracing
=================

Boot-time tracing side has been updated for SKC, but the difference
is small, because SKC has similar tree-based interfaces to OF APIs.
Currently, it supports following SKC options. Please read
Documentation/trace/boottime-trace.rst for details.

     - ftrace.options = OPT1[,OPT2...];
     - ftrace.trace_clock = CLOCK;
     - ftrace.dump_on_oops [= MODE];
     - ftrace.traceoff_on_warning;
     - ftrace.tp_printk;
     - ftrace.buffer_size = SIZE;
     - ftrace.alloc_snapshot;
     - ftrace.events = EVENT[, EVENT2...];
     - ftrace.tracer = TRACER;
     - ftrace.event.GROUP.EVENT.filter = FILTER;
     - ftrace.event.GROUP.EVENT.actions = ACTION[, ACTION2...];
     - ftrace.event.GROUP.EVENT.enable;
     - ftrace.event.kprobes.EVENT.probes = PROBE[, PROBE2...];
     - ftrace.event.synthetic.EVENT.fields = FIELD[, FIELD2...];
     - ftrace.[instance.INSTANCE.]cpumask = CPUMASK;
     - ftrace.[instance.INSTANCE.]ftrace.filters
     - ftrace.[instance.INSTANCE.]ftrace.notraces
     - ftrace.fgraph.filters = FILTER[, FILTER2...];
     - ftrace.fgraph.notraces = FILTER[, FILTER2...];
     - ftrace.fgraph.max_depth = MAX_DEPTH;

This series can be applied on Steve's tracing tree (ftrace/core) or
available on below

https://github.com/mhiramat/linux.git ftrace-boottrace-v3

Usage
=====

With this series, we can setup new kprobe and synthetic events, more
complicated event filters and trigger actions including histogram
via supplemental kernel cmdline.

We can add filter and actions for each event, define kprobe events,
and synthetic events with histogram like below.

ftrace.event {
	task.task_newtask {
		filter = "pid < 128";
		enable;
	}
	kprobes.vfs_read {
		probes = "vfs_read $arg1 $arg2";
		filter = "common_pid < 200";
		enable;
	}
	synthetic.initcall_latency {
		fields = "unsigned long func", "u64 lat";
		actions = "hist:keys=func.sym,lat:vals=lat:sort=lat";
	}
	initcall.initcall_start {
		actions = "hist:keys=func:ts0=common_timestamp.usecs";
	}
	initcall.initcall_finish {
		actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)";
	}
}

Also, this supports "instance" node, which allows us to run several
tracers for different purpose at once. For example, one tracer is for
tracing functions in module alpha, and others tracing module beta,
you can write followings.

ftrace.instance {
	foo {
		tracer = "function";
		ftrace-filters = "*:mod:alpha";
	}
	bar {
		tracer = "function";
		ftrace-filters = "*:mod:beta";
	}
}

The instance node also accepts event nodes so that each instance
can customize its event tracing.

This boot-time trace also supports ftrace kernel parameters.
For example, following kernel parameters

trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"

it can be written in SKC like below.

ftrace {
	options = sym-addr;
	events = "initcall:*";
	tp-printk;
	buffer-size = 1MB;
	ftrace-filters = "vfs*";
}

However, since the initialization timing is different, if you need
to trace very early boot, please use normal kernel parameters.

Some Notes
==========

- For specifying the skc data address, there are 2 ways to pass it
to kernel. One is expanding arch-specific entries (e.g. setup_data
on x86), another is passing it via kernel cmdline. The former may
need to expand devicetree anyway (we need /chosen/skc_addr property
for some arch.) The latter is more generic, but it may not work if
the space on cmdline shorts.
According to Frank's suggestion, I introduced "skc=PADDR,SIZE" option
to kernel cmdline, boot loaders must support it. This is generic, and
I still have some concerns, like memory reservation. In this version,
I used early_param() to reserve SKC memory. If it is too late, we'd
better considering to use arch specific data passing.

- Currently, supplemental kernel cmdline doesn't support __setup()
routine to avoid confusion, but I think it is possible to support it.

- For saving memory consuming after boot, all variables and APIs are
__init and __initdata. Thus runtime memory footprint becomes minimum.
But if some loadable modules wants to use it. We have to keep at least
query interface and tree nodes on memory.

- As you can see, the EVENT.actions value is a bit ugly. Maybe we can
introduce sub-nodes under action node, something like below.

ftrace.event.initcall.initcall_finish.action.hist {
	keys = "func";
	lat = "common_timestamp.usecs-$ts0";
	onmatch = "initcall.initcall_start";
        call = "initcall_latency(func,$lat)";
}

Any suggestions, thoughts?

Thank you,

---

Masami Hiramatsu (19):
      skc: Add supplemental kernel cmdline support
      skc: Add /proc/sup_cmdline to show SKC key-value list
      skc: Add a boot setup routine from cmdline
      Documentation: skc: Add a doc for supplemental kernel cmdline
      tracing: Apply soft-disabled and filter to tracepoints printk
      tracing: kprobes: Output kprobe event to printk buffer
      tracing: Expose EXPORT_SYMBOL_GPL symbol
      tracing: kprobes: Register to dynevent earlier stage
      tracing: Accept different type for synthetic event fields
      tracing: Add NULL trace-array check in print_synth_event()
      tracing/boot: Add boot-time tracing by supplemental kernel cmdline
      tracing/boot: Add per-event settings
      tracing/boot Add kprobe event support
      tracing/boot: Add synthetic event support
      tracing/boot: Add instance node support
      tracing/boot: Add cpu_mask option support
      tracing/boot: Add function tracer filter options
      tracing/boot: Add function-graph tracer options
      Documentation: tracing: Add boot-time tracing document


 Documentation/admin-guide/index.rst             |    1 
 Documentation/admin-guide/kernel-parameters.txt |    6 
 Documentation/admin-guide/skc.rst               |  123 ++++
 Documentation/trace/boottime-trace.rst          |  185 ++++++
 MAINTAINERS                                     |    8 
 arch/Kconfig                                    |    9 
 fs/proc/Makefile                                |    1 
 fs/proc/sup_cmdline.c                           |  106 ++++
 include/linux/skc.h                             |  205 +++++++
 include/linux/trace_events.h                    |    1 
 init/main.c                                     |   54 ++
 kernel/trace/Kconfig                            |    9 
 kernel/trace/Makefile                           |    1 
 kernel/trace/ftrace.c                           |   85 ++-
 kernel/trace/trace.c                            |   90 ++-
 kernel/trace/trace_boot.c                       |  457 +++++++++++++++
 kernel/trace/trace_events.c                     |    3 
 kernel/trace/trace_events_hist.c                |   14 
 kernel/trace/trace_events_trigger.c             |    2 
 kernel/trace/trace_kprobe.c                     |   81 ++-
 lib/Kconfig                                     |    3 
 lib/Makefile                                    |    2 
 lib/skc.c                                       |  694 +++++++++++++++++++++++
 23 files changed, 2044 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/admin-guide/skc.rst
 create mode 100644 Documentation/trace/boottime-trace.rst
 create mode 100644 fs/proc/sup_cmdline.c
 create mode 100644 include/linux/skc.h
 create mode 100644 kernel/trace/trace_boot.c
 create mode 100644 lib/skc.c

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
