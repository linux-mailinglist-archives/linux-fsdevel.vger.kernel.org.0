Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C4E0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfD2Ky0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 06:54:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53336 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbfD2Ky0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E52680D;
        Mon, 29 Apr 2019 03:54:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023AB3F5AF;
        Mon, 29 Apr 2019 03:54:23 -0700 (PDT)
Date:   Mon, 29 Apr 2019 11:54:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+cd714a07c6de2bc34293@syzkaller.appspotmail.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in io_uring_setup
Message-ID: <20190429105418.GA2182@lakrids.cambridge.arm.com>
References: <000000000000dfd87b0586652bf3@google.com>
 <778cd3c3-5b2c-4a87-64dc-5b8f5b0edc7a@kernel.dk>
 <CAKb3OG_adYHath5LfT66RDy9gsrxvPT7Q10ns6308F9MyEzp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb3OG_adYHath5LfT66RDy9gsrxvPT7Q10ns6308F9MyEzp6A@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

On Sun, Apr 14, 2019 at 09:45:00AM -0600, Jens Axboe wrote:
> On 4/13/19 9:25 AM, Jens Axboe wrote:
> > On 4/13/19 2:26 AM, syzbot wrote:
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpu_max_bits_warn
> >> include/linux/cpumask.h:121 [inline]
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpumask_check
> >> include/linux/cpumask.h:128 [inline]
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 cpumask_test_cpu
> >> include/linux/cpumask.h:344 [inline]
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121
> >> io_sq_offload_start fs/io_uring.c:2244 [inline]
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121 io_uring_create
> >> fs/io_uring.c:2851 [inline]
> >> WARNING: CPU: 1 PID: 7600 at include/linux/cpumask.h:121
> >> io_uring_setup+0x13b2/0x1990 fs/io_uring.c:2903

As a heads-up, I'm seeing this on arm64 in v5.1-rc7; example splat below. I
believe that commit:

  917257daa0fea7a0 ("io_uring: only test SQPOLL cpu after we've verified it")

... was intended to fix this?

IIUC, the problem is that cpu_possible(cpu) can't accept a cpu index above
nr_cpu_ids, since it is defined as:

  cpumask_test_cpu((cpu), cpu_possible_mask)

... and so we should first check whether cpu >= nr_cpu_ids.

Arguably that could/should live directly in cpu_possible(), but I see that's
open-coded in a few places:

[mark@lakrids:~/src/linux]% git grep -w cpu_possible | grep nr_cpu_ids
arch/x86/mm/numa.c:     if (cpu >= nr_cpu_ids || !cpu_possible(cpu)) {
arch/x86/xen/smp_pv.c:          for (cpu = nr_cpu_ids - 1; !cpu_possible(cpu); cpu--)
drivers/base/cpu.c:     if (cpu < nr_cpu_ids && cpu_possible(cpu))
drivers/scsi/libfc/fc_exch.c:   if (cpu >= nr_cpu_ids || !cpu_possible(cpu)) {
drivers/xen/cpu_hotplug.c:      if (cpu >= nr_cpu_ids || !cpu_possible(cpu))

Thanks,
Mark.

WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_check include/linux/cpumask.h:128 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_sq_offload_start fs/io_uring.c:2244 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_create fs/io_uring.c:2864 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 27601 Comm: syz-executor.0 Not tainted 5.1.0-rc7 #3
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x2f0 include/linux/compiler.h:193
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x110/0x190 lib/dump_stack.c:113
 panic+0x384/0x68c kernel/panic.c:214
 __warn+0x2bc/0x2c0 kernel/panic.c:571
 report_bug+0x228/0x2d8 lib/bug.c:186
 bug_handler+0xa0/0x1a0 arch/arm64/kernel/traps.c:956
 call_break_hook arch/arm64/kernel/debug-monitors.c:301 [inline]
 brk_handler+0x1d4/0x388 arch/arm64/kernel/debug-monitors.c:316
 do_debug_exception+0x1a0/0x468 arch/arm64/mm/fault.c:831
 el1_dbg+0x18/0x8c
 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
 cpumask_check include/linux/cpumask.h:128 [inline]
 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
 io_sq_offload_start fs/io_uring.c:2244 [inline]
 io_uring_create fs/io_uring.c:2864 [inline]
 io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
 __do_sys_io_uring_setup fs/io_uring.c:2929 [inline]
 __se_sys_io_uring_setup fs/io_uring.c:2926 [inline]
 __arm64_sys_io_uring_setup+0x50/0x70 fs/io_uring.c:2926
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:47 [inline]
 el0_svc_common.constprop.0+0x148/0x2e0 arch/arm64/kernel/syscall.c:83
 el0_svc_handler+0xdc/0x100 arch/arm64/kernel/syscall.c:129
 el0_svc+0x8/0xc arch/arm64/kernel/entry.S:948
SMP: stopping secondary CPUs
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
CPU features: 0x002,23000438
Memory Limit: none
Rebooting in 1 seconds..
