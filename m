Return-Path: <linux-fsdevel+bounces-38926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB443A0A0BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 04:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9B916B61F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9614F9D9;
	Sat, 11 Jan 2025 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rvfqF4WB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765F12E1CD;
	Sat, 11 Jan 2025 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736567687; cv=none; b=OQ5iiJw/m4Dv0biarItgaUQdY/mvAWaEhfp3Ls76mesA5BmD/0zBTgFwu57DvPmVZOY4xN0g5y0GQRwM3BCMA4uN69fzJNrwP7ma/WgbBvB1OYD1Jsmj6XMYx2ITQPiJUHx+RVR7iyasmWrAjtjwywUWorop2NgprDhoArNp2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736567687; c=relaxed/simple;
	bh=fpB1BSbbt1m6Q3tuCsnay/0mxUX9Q/NzZkBP8oe8ZLo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mZ3Zg1jzaHh7v0OoWoxAxupXYL+qzGXLOIIexIjrn666CWCnBaPFong7Y9XqB9v9Ygs/h+euE/NeDGQHweXoCPE2L26pKmUcOP5k65EnpOmLRbJsJUqbXLOxjjALH42d1FBy9eut1tHFn5Dja8gc+JQJRGLtRwOyA1ZebcwHT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rvfqF4WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F576C4CED2;
	Sat, 11 Jan 2025 03:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736567687;
	bh=fpB1BSbbt1m6Q3tuCsnay/0mxUX9Q/NzZkBP8oe8ZLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvfqF4WB3gZ+H1W043gjvB9XnqGB8NJg4cybusZ68fXqTD++POBJFIGc5P6BqAGI1
	 jZ+GuYKtp11Sc0p+d1TNHSIW7Dmep/Oq/LICF16NfU5ueG3nMwYIbSnAOc1/2wIMst
	 zvFCM4fBONunVjbBGOKn4qfdzS1AZukMYhisbzp8=
Date: Fri, 10 Jan 2025 19:54:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oxana Kharitonova <oxana@cloudflare.com>
Cc: brauner@kernel.org, bsegall@google.com, dietmar.eggemann@arm.com,
 jack@suse.cz, juri.lelli@redhat.com, mgorman@suse.de, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
 viro@zeniv.linux.org.uk, vschneid@redhat.com, kernel-team@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] hung_task: add task->flags, blocked by coredump
 to log
Message-Id: <20250110195445.586a1682302e66788e83e83e@linux-foundation.org>
In-Reply-To: <20250110160328.64947-1-oxana@cloudflare.com>
References: <20250110160328.64947-1-oxana@cloudflare.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 16:03:28 +0000 Oxana Kharitonova <oxana@cloudflare.com> wrote:

> Resending this patch as I haven't received feedback on my initial 
> submission https://lore.kernel.org/all/20241204182953.10854-1-oxana@cloudflare.com/
> 
> For the processes which are terminated abnormally the kernel can provide 
> a coredump if enabled. When the coredump is performed, the process and 
> all its threads are put into the D state 
> (TASK_UNINTERRUPTIBLE | TASK_FREEZABLE). 
> 
> On the other hand, we have kernel thread khungtaskd which monitors the 
> processes in the D state. If the task stuck in the D state more than 
> kernel.hung_task_timeout_secs, the hung_task alert appears in the kernel 
> log.
> 
> The higher memory usage of a process, the longer it takes to create 
> coredump, the longer tasks are in the D state. We have hung_task alerts 
> for the processes with memory usage above 10Gb. Although, our 
> kernel.hung_task_timeout_secs is 10 sec when the default is 120 sec.
> 
> Adding additional information to the log that the task is blocked by 
> coredump will help with monitoring. Another approach might be to 
> completely filter out alerts for such tasks, but in that case we would 
> lose transparency about what is putting pressure on some system 
> resources, e.g. we saw an increase in I/O when coredump occurs due its 
> writing to disk.
> 
> Additionally, it would be helpful to have task_struct->flags in the log 
> from the function sched_show_task(). Currently it prints 
> task_struct->thread_info->flags, this seems misleading as the line 
> starts with "task:xxxx".
> 

I added the below fix.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: hung_task-add-task-flags-blocked-by-coredump-to-log-fix
Date: Fri Jan 10 07:51:53 PM PST 2025

fix printk control string

In file included from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:99,
                 from ./include/linux/bug.h:5,
                 from ./arch/x86/include/asm/paravirt.h:19,
                 from ./arch/x86/include/asm/irqflags.h:80,
                 from ./include/linux/irqflags.h:18,
                 from ./include/linux/spinlock.h:59,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/linux/highmem.h:5,
                 from kernel/sched/core.c:10:
kernel/sched/core.c: In function 'sched_show_task':
./include/linux/kern_levels.h:5:25: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=format=]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
./include/linux/printk.h:473:25: note: in definition of macro 'printk_index_wrap'
  473 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                         ^~~~
./include/linux/printk.h:586:9: note: in expansion of macro 'printk'
  586 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
      |         ^~~~~~
./include/linux/kern_levels.h:24:25: note: in expansion of macro 'KERN_SOH'
   24 | #define KERN_CONT       KERN_SOH "c"
      |                         ^~~~~~~~
./include/linux/printk.h:586:16: note: in expansion of macro 'KERN_CONT'
  586 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
      |                ^~~~~~~~~
kernel/sched/core.c:7704:9: note: in expansion of macro 'pr_cont'
 7704 |         pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%08lx flags:0x%08lx\n",
      |         ^~~~~~~
cc1: all warnings being treated as errors

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ben Segall <bsegall@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Oxana Kharitonova <oxana@cloudflare.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c~hung_task-add-task-flags-blocked-by-coredump-to-log-fix
+++ a/kernel/sched/core.c
@@ -7701,7 +7701,7 @@ void sched_show_task(struct task_struct
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%08lx flags:0x%08lx\n",
+	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%04x flags:0x%08lx\n",
 		free, task_pid_nr(p), task_tgid_nr(p),
 		ppid, p->flags, read_task_thread_flags(p));
 
_


