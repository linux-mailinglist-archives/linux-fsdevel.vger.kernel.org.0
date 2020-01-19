Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38E141E7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgASOUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 09:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgASOUr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:20:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E554206D7;
        Sun, 19 Jan 2020 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579443644;
        bh=48TfqVaiOwnStV6bwPmw5htiGRDXz2KrwOwLbHcj6nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OpBRFNRut9os496G0NNmnz6f7ODsgVXZ2A6jCHeRNsdE7nl/EBIqfHRfuNb6p2bWV
         C28kNZu6UHp4FpWfZj+ldInGDZ4ESIi9xMfJfSFkbEMbkGCU5UEVwMrat3lTP6KmZK
         qItJZ/o8e5vc/GU6ZBAtLg26qvEUZmhpEp/qgBKA=
Date:   Sun, 19 Jan 2020 23:20:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
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
Subject: Re: [PATCH v6 00/22] tracing: bootconfig: Boot-time tracing and
 Extra boot config
Message-Id: <20200119232037.c46321eac70bf288b42f493f@kernel.org>
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

Thanks for pick this series on your tree. I would like to fix some patches
according to Randy's comments. Should I update this series or just incremental
updates on top of your tree?

Thank you,

On Sat, 11 Jan 2020 01:03:20 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This is the 6th version of the series for the boot-time tracing.
> 
> Previous version is here.
> 
> https://lkml.kernel.org/r/157736902773.11126.2531161235817081873.stgit@devnote2
> 
> Thanks Steve for reivew. I fixed issues in this version.
> 
>  - [1/22] Remove "!!" from xbc_node_is_value().
> 	  Redefine xbc_node_is_key() as "!xbc_node_is_value()".
> 	  Fix a memory leak and a bug in __xbc_parse_value().
> 	  Add xbc_destroy_all() to clean up the parsed data.
> 	  Fix to treat comment right after value as a newline.
> 
>  - [3/22] Fix memory leaks.
> 	  Fix to cleanup old bootconfig on memory before load new one.
> 	  Show applying message.
> 	  Suppress parse error with wrong data in initrd for delete_xbc().
> 
>  - [4/22] Add some testcases for value parser
>           Add a test case for checking delete old bootconfig
> 
>  - [9/22] Add a note about comment after value.
> 
>  - [21/22] Fix to depend on CONFIG_DYNAMIC_FTRACE instead
> 	  of CONFIG_FUNCTION_TRACER.
> 
> This series can be applied on v5.5-rc5 or directly available at;
> 
> https://github.com/mhiramat/linux.git ftrace-boottrace-v6
> 
> 
> Extra Boot Config
> =================
> 
> Extra boot config allows admin to pass a tree-structured key-value
> list when booting up the kernel. This expands the kernel command
> line in an efficient way.
> 
> Each key is described as a dot-jointed-words. And user can write
> the key-words in tree stlye. (In this version, the tailing ';'
> becomes optional. See Documentation/admin-guide/bootconfig.rst)
> 
> For example,
> 
>  feature.option.foo = 1
>  feature.option.bar = 2
> 
> can be also written in
> 
>  feature.option {
>     foo = 1
>     bar = 2
>  }
> 
> or more compact,
> 
>  feature.option{foo=1;bar=2}
> 
> (Note that in both style, the same words are merged automatically
>  and make a single tree)
> All values are treated as a string, or array of strings, e.g.
> 
>  feature.options = "foo", "bar"
> 
> User can see the loaded key-value list via /proc/bootconfig.
> The size is limited upto 32KB and 1024 key-words and values
> in total.
> 
> Boot with a Boot Config
> =======================
> 
> This version doesn't require to modify boot loaders anymore.
> The boot config is loaded with initrd, and there is new "bootconfig"
> command under tools/bootconfig.
> To add (append) a bootconfig file to an initrd, you can use the
> bootconfig command like:
> 
>  # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
> 
> This verifies the configuration file too. 
> 
> 
> Boot-time Tracing
> =================
> 
> Boot-time tracing supports following boot configs. Please read
> Documentation/trace/boottime-trace.rst for details.
> 
>      - kernel.dump_on_oops [= MODE]
>      - kernel.traceoff_on_warning
>      - kernel.tp_printk
>      - kernel.fgraph_filters = FILTER[, FILTER2...]
>      - kernel.fgraph_notraces = FILTER[, FILTER2...]
>      - kernel.fgraph_max_depth = MAX_DEPTH
>      - ftrace.[instance.INSTANCE.]options = OPT1[,OPT2...]
>      - ftrace.[instance.INSTANCE.]trace_clock = CLOCK
>      - ftrace.[instance.INSTANCE.]buffer_size = SIZE
>      - ftrace.[instance.INSTANCE.]alloc_snapshot
>      - ftrace.[instance.INSTANCE.]cpumask = CPUMASK
>      - ftrace.[instance.INSTANCE.]events = EVENT[, EVENT2...]
>      - ftrace.[instance.INSTANCE.]tracer = TRACER
>      - ftrace.[instance.INSTANCE.]ftrace.filters
>      - ftrace.[instance.INSTANCE.]ftrace.notraces
>      - ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
>      - ftrace.[instance.INSTANCE.]event.GROUP.EVENT.actions = ACTION[, ACTION2...]
>      - ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
>      - ftrace.[instance.INSTANCE.]event.kprobes.EVENT.probes = PROBE[, PROBE2...]
>      - ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2...]
> 
> Kernel and Init Command Line
> ============================
> 
> Boot config also supports kernel and init command line parameters
> except for early kernel parameters.
> 
> In boot config, all key-values start with "kernel." are automatically
> merged into user passed boot command line, and key-values which
> start with "init." are also passed to init. These options are visible
> on /proc/cmdline.
> 
> For example,
> 
> kernel {
>   audit = on
>   audit_backlog_limit = 256
> }
> init.systemd.unified_cgroup_hierarchy = 1
> 
> 
> Usage
> =====
> 
> With this series, we can setup new kprobe and synthetic events, more
> complicated event filters and trigger actions including histogram
> via supplemental kernel cmdline.
> 
> We can add filter and actions for each event, define kprobe events,
> and synthetic events with histogram like below.
> 
> ftrace.event {
> 	task.task_newtask {
> 		filter = "pid < 128"
> 		enable
> 	}
> 	kprobes.vfs_read {
> 		probes = "vfs_read $arg1 $arg2"
> 		filter = "common_pid < 200"
> 		enable
> 	}
> 	synthetic.initcall_latency {
> 		fields = "unsigned long func", "u64 lat"
> 		actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
> 	}
> 	initcall.initcall_start {
> 		actions = "hist:keys=func:ts0=common_timestamp.usecs"
> 	}
> 	initcall.initcall_finish {
> 		actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
> 	}
> }
> 
> Also, this supports "instance" node, which allows us to run several
> tracers for different purpose at once. For example, one tracer is for
> tracing functions start with "user_", and others tracing "kernel_",
> you can write boot config as:
> 
> ftrace.instance {
> 	foo {
> 		tracer = "function"
> 		ftrace-filters = "user_*"
> 	}
> 	bar {
> 		tracer = "function"
> 		ftrace-filters = "function_*"
> 	}
> }
> 
> The instance node also accepts event nodes so that each instance
> can customize its event tracing.
> 
> This boot-time trace also supports ftrace kernel parameters.
> For example, following kernel parameters
> 
> trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
> 
> it can be written in boot config like below.
> 
> ftrace {
> 	options = sym-addr
> 	events = "initcall:*"
> 	tp-printk
> 	buffer-size = 1MB
> 	ftrace-filters = "vfs*"
> }
> 
> However, since the initialization timing is different, if you need
> to trace very early boot, please use normal kernel parameters.
> 
> Some Notes
> ==========
> 
> - To align the legacy command line rule, I made the quotes (double
>   quotes or single quotes) not able to be escaped.
>   Also, this rejects non-printable chars (except for space). Actually
>   legacy cmdline accepts any of them, but it might confuse users if
>   they put a control code by mistake. Imagine that they put a "\b"
>   on it...
> 
> - Since it is not easy to write boot-time tracing without any bug
>   in bootconfig, a user-helper command will be needed.
>   That command will generate a boot config file from current ftrace
>   settings, or try to apply given boot config setting to the ftrace.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (22):
>       bootconfig: Add Extra Boot Config support
>       bootconfig: Load boot config from the tail of initrd
>       tools: bootconfig: Add bootconfig command
>       tools: bootconfig: Add bootconfig test script
>       proc: bootconfig: Add /proc/bootconfig to show boot config list
>       init/main.c: Alloc initcall_command_line in do_initcall() and free it
>       bootconfig: init: Allow admin to use bootconfig for kernel command line
>       bootconfig: init: Allow admin to use bootconfig for init command line
>       Documentation: bootconfig: Add a doc for extended boot config
>       tracing: Apply soft-disabled and filter to tracepoints printk
>       tracing: kprobes: Output kprobe event to printk buffer
>       tracing: kprobes: Register to dynevent earlier stage
>       tracing: Accept different type for synthetic event fields
>       tracing: Add NULL trace-array check in print_synth_event()
>       tracing/boot: Add boot-time tracing
>       tracing/boot: Add per-event settings
>       tracing/boot Add kprobe event support
>       tracing/boot: Add synthetic event support
>       tracing/boot: Add instance node support
>       tracing/boot: Add cpu_mask option support
>       tracing/boot: Add function tracer filter options
>       Documentation: tracing: Add boot-time tracing document
> 
> 
>  Documentation/admin-guide/bootconfig.rst           |  186 +++++
>  Documentation/admin-guide/index.rst                |    1 
>  Documentation/trace/boottime-trace.rst             |  184 +++++
>  Documentation/trace/index.rst                      |    1 
>  MAINTAINERS                                        |    9 
>  fs/proc/Makefile                                   |    1 
>  fs/proc/bootconfig.c                               |   89 ++
>  include/linux/bootconfig.h                         |  224 ++++++
>  include/linux/trace_events.h                       |    1 
>  init/Kconfig                                       |   12 
>  init/main.c                                        |  213 +++++
>  kernel/trace/Kconfig                               |    9 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/trace.c                               |   63 +-
>  kernel/trace/trace_boot.c                          |  353 +++++++++
>  kernel/trace/trace_events.c                        |    1 
>  kernel/trace/trace_events_hist.c                   |   14 
>  kernel/trace/trace_events_trigger.c                |    2 
>  kernel/trace/trace_kprobe.c                        |   81 +-
>  lib/Kconfig                                        |    3 
>  lib/Makefile                                       |    2 
>  lib/bootconfig.c                                   |  803 ++++++++++++++++++++
>  tools/Makefile                                     |   11 
>  tools/bootconfig/.gitignore                        |    1 
>  tools/bootconfig/Makefile                          |   23 +
>  tools/bootconfig/include/linux/bootconfig.h        |    7 
>  tools/bootconfig/include/linux/bug.h               |   12 
>  tools/bootconfig/include/linux/ctype.h             |    7 
>  tools/bootconfig/include/linux/errno.h             |    7 
>  tools/bootconfig/include/linux/kernel.h            |   18 
>  tools/bootconfig/include/linux/printk.h            |   17 
>  tools/bootconfig/include/linux/string.h            |   32 +
>  tools/bootconfig/main.c                            |  354 +++++++++
>  .../samples/bad-array-space-comment.bconf          |    5 
>  tools/bootconfig/samples/bad-array.bconf           |    2 
>  tools/bootconfig/samples/bad-dotword.bconf         |    4 
>  tools/bootconfig/samples/bad-empty.bconf           |    1 
>  tools/bootconfig/samples/bad-keyerror.bconf        |    2 
>  tools/bootconfig/samples/bad-longkey.bconf         |    1 
>  tools/bootconfig/samples/bad-manywords.bconf       |    1 
>  tools/bootconfig/samples/bad-no-keyword.bconf      |    2 
>  tools/bootconfig/samples/bad-nonprintable.bconf    |    2 
>  tools/bootconfig/samples/bad-spaceword.bconf       |    2 
>  tools/bootconfig/samples/bad-tree.bconf            |    5 
>  tools/bootconfig/samples/bad-value.bconf           |    3 
>  tools/bootconfig/samples/escaped.bconf             |    3 
>  .../samples/good-array-space-comment.bconf         |    4 
>  .../samples/good-comment-after-value.bconf         |    1 
>  tools/bootconfig/samples/good-printables.bconf     |    2 
>  tools/bootconfig/samples/good-simple.bconf         |   11 
>  tools/bootconfig/samples/good-single.bconf         |    4 
>  .../samples/good-space-after-value.bconf           |    1 
>  tools/bootconfig/samples/good-tree.bconf           |   12 
>  tools/bootconfig/test-bootconfig.sh                |  105 +++
>  54 files changed, 2836 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/admin-guide/bootconfig.rst
>  create mode 100644 Documentation/trace/boottime-trace.rst
>  create mode 100644 fs/proc/bootconfig.c
>  create mode 100644 include/linux/bootconfig.h
>  create mode 100644 kernel/trace/trace_boot.c
>  create mode 100644 lib/bootconfig.c
>  create mode 100644 tools/bootconfig/.gitignore
>  create mode 100644 tools/bootconfig/Makefile
>  create mode 100644 tools/bootconfig/include/linux/bootconfig.h
>  create mode 100644 tools/bootconfig/include/linux/bug.h
>  create mode 100644 tools/bootconfig/include/linux/ctype.h
>  create mode 100644 tools/bootconfig/include/linux/errno.h
>  create mode 100644 tools/bootconfig/include/linux/kernel.h
>  create mode 100644 tools/bootconfig/include/linux/printk.h
>  create mode 100644 tools/bootconfig/include/linux/string.h
>  create mode 100644 tools/bootconfig/main.c
>  create mode 100644 tools/bootconfig/samples/bad-array-space-comment.bconf
>  create mode 100644 tools/bootconfig/samples/bad-array.bconf
>  create mode 100644 tools/bootconfig/samples/bad-dotword.bconf
>  create mode 100644 tools/bootconfig/samples/bad-empty.bconf
>  create mode 100644 tools/bootconfig/samples/bad-keyerror.bconf
>  create mode 100644 tools/bootconfig/samples/bad-longkey.bconf
>  create mode 100644 tools/bootconfig/samples/bad-manywords.bconf
>  create mode 100644 tools/bootconfig/samples/bad-no-keyword.bconf
>  create mode 100644 tools/bootconfig/samples/bad-nonprintable.bconf
>  create mode 100644 tools/bootconfig/samples/bad-spaceword.bconf
>  create mode 100644 tools/bootconfig/samples/bad-tree.bconf
>  create mode 100644 tools/bootconfig/samples/bad-value.bconf
>  create mode 100644 tools/bootconfig/samples/escaped.bconf
>  create mode 100644 tools/bootconfig/samples/good-array-space-comment.bconf
>  create mode 100644 tools/bootconfig/samples/good-comment-after-value.bconf
>  create mode 100644 tools/bootconfig/samples/good-printables.bconf
>  create mode 100644 tools/bootconfig/samples/good-simple.bconf
>  create mode 100644 tools/bootconfig/samples/good-single.bconf
>  create mode 100644 tools/bootconfig/samples/good-space-after-value.bconf
>  create mode 100644 tools/bootconfig/samples/good-tree.bconf
>  create mode 100755 tools/bootconfig/test-bootconfig.sh
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
