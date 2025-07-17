Return-Path: <linux-fsdevel+bounces-55204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3627B083BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 06:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C345681EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 04:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060451DF75B;
	Thu, 17 Jul 2025 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kctkEfMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46610E3;
	Thu, 17 Jul 2025 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726273; cv=none; b=YAO0EgA8+TKcTMZWmFwguUa3IbHL890OLStDmIDf4863Qoi3iOKmusiwqpJbgY/h8p941a3N0Ts33tZXW/gqoHDAbLQxaOrmU8KtGgHTkwabC6r89b179s2+Up3u2pUch2qpK7K4DPJPG4eUZhB61qCcZcavricR3uVdjj6ziog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726273; c=relaxed/simple;
	bh=8Nqdw3/HfcKmjZDTj/XnWKM593nFS8OTlMs5uI6WZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqbPSjTvovqoV26eVXcLQ52iCriWZuoB9q3UETwcvvpIZAoVuk62hgUQqz7T+z0w8EZpdIy4Yj0uPBy+bTHRJ+Io3ZNEvQFkqthwHJ5ujbvCFk93KHdBfrH4i5Nx1TouFpGWJI4S0tkABq+x7P8L2P89Ij4pJwDmzAaVD98BeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kctkEfMH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752726271; x=1784262271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Nqdw3/HfcKmjZDTj/XnWKM593nFS8OTlMs5uI6WZnY=;
  b=kctkEfMHQ1IiP5WRH9tWaj/xg/0soUGkXLW9/aTfSw1XaAx28u5KWK/4
   3Lo0ksZLyUxDSNPuY+n+pwi8myvH3xZnZ+bjWBmXNL48P/WnGbM41bYJW
   XJoCe2keC+xzA80FtEz+S1r9qdm4gI2NTNKkhtTMcjJ68Z/6RmGuEwD2j
   4auV0aUitilgo0+poGq6wHH4+CG68ln8cv85deYkKvTjhYoens6J5gmmR
   za7Dvijz1SRpZrWToc8tw6uNEAt1b9WhPvYjn+4Y5vGd/n5vB8BdKHILH
   hphGJ0vmAGCiCuGa3gX0Vjc2vtah5SQKhea1mJpLVZsiG/qHu5nDZDUz1
   A==;
X-CSE-ConnectionGUID: +MZDe4CcSgOPU+pHwalSew==
X-CSE-MsgGUID: QWRmo13qT1WU5EbKFosGKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54863626"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54863626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 21:24:30 -0700
X-CSE-ConnectionGUID: RYtL8Cy9TVyTfOo/Ai4CiA==
X-CSE-MsgGUID: uXWpqbBJRFGlBIQw6kQJrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="194814598"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jul 2025 21:24:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucGAN-000D8t-2e;
	Thu, 17 Jul 2025 04:24:19 +0000
Date: Thu, 17 Jul 2025 12:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
Message-ID: <202507171254.FobDRyqP-lkp@intel.com>
References: <20250716123916.511889-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716123916.511889-4-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250715]
[cannot apply to akpm-mm/mm-everything brauner-vfs/vfs.all tip/sched/core trace/for-next linus/master v6.16-rc6 v6.16-rc5 v6.16-rc4 v6.16-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250716-204047
base:   next-20250715
patch link:    https://lore.kernel.org/r/20250716123916.511889-4-bhupesh%40igalia.com
patch subject: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str which is 64 bytes long
config: i386-buildonly-randconfig-001-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171254.FobDRyqP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171254.FobDRyqP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171254.FobDRyqP-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:28,
                    from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/linux/debug_locks.h:5,
                    from kernel/panic.c:12:
   kernel/panic.c: In function '__warn':
>> kernel/panic.c:818:58: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
     818 |                         raw_smp_processor_id(), current->comm, current->pid);
         |                                                          ^~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/panic.c:816:17: note: in expansion of macro 'pr_warn'
     816 |                 pr_warn("WARNING: %s:%d at %pS, CPU#%d: %s/%d\n",
         |                 ^~~~~~~
   kernel/panic.c:822:58: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
     822 |                         raw_smp_processor_id(), current->comm, current->pid);
         |                                                          ^~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/panic.c:820:17: note: in expansion of macro 'pr_warn'
     820 |                 pr_warn("WARNING: at %pS, CPU#%d: %s/%d\n",
         |                 ^~~~~~~
--
   In file included from include/asm-generic/bug.h:28,
                    from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from kernel/watchdog.c:15:
   kernel/watchdog.c: In function 'watchdog_timer_fn':
>> kernel/watchdog.c:814:34: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
     814 |                         current->comm, task_pid_nr(current));
         |                                  ^~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:527:9: note: in expansion of macro 'printk'
     527 |         printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/watchdog.c:812:17: note: in expansion of macro 'pr_emerg'
     812 |                 pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
         |                 ^~~~~~~~
--
   In file included from include/asm-generic/bug.h:28,
                    from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from kernel/rseq.c:11:
   kernel/rseq.c: In function 'rseq_validate_ro_fields':
>> kernel/rseq.c:65:36: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      65 |                         t->pid, t->comm,
         |                                    ^~~~
   include/linux/printk.h:486:33: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:567:9: note: in expansion of macro 'printk'
     567 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/rseq.c:60:17: note: in expansion of macro 'pr_warn'
      60 |                 pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
         |                 ^~~~~~~
--
   In file included from include/trace/define_trace.h:132,
                    from include/trace/events/task.h:98,
                    from kernel/fork.c:121:
   include/trace/events/task.h: In function 'do_trace_event_raw_event_task_newtask':
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:691:35: note: in expansion of macro '__struct_size'
     691 |                 __struct_size(p), __struct_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:692:35: note: in expansion of macro '__member_size'
     692 |                 __member_size(p), __member_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h: In function 'do_trace_event_raw_event_task_rename':
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:35:1: note: in expansion of macro 'TRACE_EVENT'
      35 | TRACE_EVENT(task_rename,
         | ^~~~~~~~~~~
   include/trace/events/task.h:47:9: note: in expansion of macro 'TP_fast_assign'
      47 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:691:35: note: in expansion of macro '__struct_size'
     691 |                 __struct_size(p), __struct_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:48:17: note: in expansion of macro 'memcpy'
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:35:1: note: in expansion of macro 'TRACE_EVENT'
      35 | TRACE_EVENT(task_rename,
         | ^~~~~~~~~~~
   include/trace/events/task.h:47:9: note: in expansion of macro 'TP_fast_assign'
      47 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:692:35: note: in expansion of macro '__member_size'
     692 |                 __member_size(p), __member_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:48:17: note: in expansion of macro 'memcpy'
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:35:1: note: in expansion of macro 'TRACE_EVENT'
      35 | TRACE_EVENT(task_rename,
         | ^~~~~~~~~~~
   include/trace/events/task.h:47:9: note: in expansion of macro 'TP_fast_assign'
      47 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/trace/events/task.h:48:17: note: in expansion of macro 'memcpy'
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   In file included from include/trace/define_trace.h:133:
   include/trace/events/task.h: In function 'do_perf_trace_task_newtask':
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:691:35: note: in expansion of macro '__struct_size'
     691 |                 __struct_size(p), __struct_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:692:35: note: in expansion of macro '__member_size'
     692 |                 __member_size(p), __member_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
>> include/trace/events/task.h:24:45: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                                             ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:9:1: note: in expansion of macro 'TRACE_EVENT'
       9 | TRACE_EVENT(task_newtask,
         | ^~~~~~~~~~~
   include/trace/events/task.h:22:9: note: in expansion of macro 'TP_fast_assign'
      22 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/trace/events/task.h:24:17: note: in expansion of macro 'memcpy'
      24 |                 memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h: In function 'do_perf_trace_task_rename':
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:35:1: note: in expansion of macro 'TRACE_EVENT'
      35 | TRACE_EVENT(task_rename,
         | ^~~~~~~~~~~
   include/trace/events/task.h:47:9: note: in expansion of macro 'TP_fast_assign'
      47 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:691:35: note: in expansion of macro '__struct_size'
     691 |                 __struct_size(p), __struct_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:48:17: note: in expansion of macro 'memcpy'
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/task.h:35:1: note: in expansion of macro 'TRACE_EVENT'
      35 | TRACE_EVENT(task_rename,
         | ^~~~~~~~~~~
   include/trace/events/task.h:47:9: note: in expansion of macro 'TP_fast_assign'
      47 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/fortify-string.h:690:26: note: in expansion of macro '__fortify_memcpy_chk'
     690 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:692:35: note: in expansion of macro '__member_size'
     692 |                 __member_size(p), __member_size(q),                     \
         |                                   ^~~~~~~~~~~~~
   include/trace/events/task.h:48:17: note: in expansion of macro 'memcpy'
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                 ^~~~~~
   include/trace/events/task.h:48:46: error: 'struct task_struct' has no member named 'comm'; did you mean 'mm'?
      48 |                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
         |                                              ^~~~
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
..


vim +818 kernel/panic.c

bd89bb29a01503 Arjan van de Ven         2008-11-28  807  
2553b67a1fbe7b Josh Poimboeuf           2016-03-17  808  void __warn(const char *file, int line, void *caller, unsigned taint,
2553b67a1fbe7b Josh Poimboeuf           2016-03-17  809  	    struct pt_regs *regs, struct warn_args *args)
0f6f49a8cd0163 Linus Torvalds           2009-05-16  810  {
4833794db61c8c Thomas Gleixner          2024-08-20  811  	nbcon_cpu_emergency_enter();
4833794db61c8c Thomas Gleixner          2024-08-20  812  
de7edd31457b62 Steven Rostedt (Red Hat  2013-06-14  813) 	disable_trace_on_warning();
de7edd31457b62 Steven Rostedt (Red Hat  2013-06-14  814) 
1d1c158ece6cb7 Ingo Molnar              2025-05-15  815  	if (file) {
1d1c158ece6cb7 Ingo Molnar              2025-05-15  816  		pr_warn("WARNING: %s:%d at %pS, CPU#%d: %s/%d\n",
1d1c158ece6cb7 Ingo Molnar              2025-05-15  817  			file, line, caller,
1d1c158ece6cb7 Ingo Molnar              2025-05-15 @818  			raw_smp_processor_id(), current->comm, current->pid);
1d1c158ece6cb7 Ingo Molnar              2025-05-15  819  	} else {
1d1c158ece6cb7 Ingo Molnar              2025-05-15  820  		pr_warn("WARNING: at %pS, CPU#%d: %s/%d\n",
1d1c158ece6cb7 Ingo Molnar              2025-05-15  821  			caller,
1d1c158ece6cb7 Ingo Molnar              2025-05-15  822  			raw_smp_processor_id(), current->comm, current->pid);
1d1c158ece6cb7 Ingo Molnar              2025-05-15  823  	}
74853dba2f7a1a Arjan van de Ven         2008-11-28  824  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

