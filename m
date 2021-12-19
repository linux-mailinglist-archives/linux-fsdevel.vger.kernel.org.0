Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6B479F21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 05:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhLSEVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Dec 2021 23:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLSEVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Dec 2021 23:21:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193EC061574;
        Sat, 18 Dec 2021 20:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aVA7OXzlzgIKIWeaJtocR/+QqAcPpG0lDIX/ygbzpEc=; b=aWGqjhqPrpyhBL8Gyc53h8gNaR
        tb2/cgt62GJ0EeFUltzNoxkm0P0G4c5KpoTmUUeU9/0zsXoDha5yQIdmmjKM4jXR3tFr93ZPlk6Qb
        aF5nd0TDJkPucmDH04H9Dq044EFO6UT7qVHxJsePuJ0dALlXx3OMe3pdYWQyqEHpdGmAQfsIP5BcI
        BfSim2xFldJHjzToMc0lWTQ1+OGqrRGBtp+FiFRC/taSf+VDjuRFe+T8d2hFD3+7hwgqdPhnPHE0R
        Zfi93gH1DIDoN7/w5DxjOfffRai7F9x6SyjU+snSLUXfNfySNDsqO1ir+yM/2yMCT7cpLCWh9GrMq
        dTCbd81Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myngv-000Ugm-Ak; Sun, 19 Dec 2021 04:20:57 +0000
Date:   Sun, 19 Dec 2021 04:20:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
Message-ID: <Yb6zKVoxuD3lQMA/@casper.infradead.org>
References: <00000000000032992d05d370f75f@google.com>
 <20211219023540.1638-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219023540.1638-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 19, 2021 at 10:35:40AM +0800, Hillf Danton wrote:
> On Sat, 18 Dec 2021 21:22:57 +0000 Matthew Wilcox wrote:
> >On Sat, Dec 18, 2021 at 11:50:20AM -0800, syzbot wrote:
> >> INFO: task jbd2/sda1-8:2937 blocked for more than 143 seconds.
> >>       Not tainted 5.16.0-rc5-syzkaller #0
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 
> Hey Willy
> >
> >sched_setattr(0x0, &(0x7f0000000080)={0x38, 0x1, 0x0, 0x0, 0x1}, 0x0)
> >
> >so you've set a SCHED_FIFO priority and then are surprised that some
> >tasks are getting starved?
> 
> Can you speficy a bit more on how fifo could block journald waiting for
> IO completion more than 120 seconds?

Sure!  You can see from the trace below that jbd2/sda1-8 is in D state,
so we know nobody's called unlock_buffer() yet, which would have woken
it.  That would happen in journal_end_buffer_io_sync(), which is
the b_end_io for the buffer.

Learning more detail than that would require knowing the I/O path
for this particular test system.  I suspect that the I/O was submitted
and has even completed, but there's a kernel thread waiting to run which
will call the ->b_end_io that hasn't been scheduled yet, because it's
at a lower priority than all the threads which are running at
SCHED_FIFO.

I'm disinclined to look at this report much further because syzbot is
stumbling around trying things which are definitely in the category of
"if you do this and things break, you get to keep both pieces".  You
can learn some interesting things by playing with the various RT
scheduling classes, but mostly what you can learn is that you need to
choose your priorities carefully to have a functioning system.

> Hillf
> >
> >> task:jbd2/sda1-8     state:D stack:27112 pid: 2937 ppid:     2 flags:0x00004000
> >> Call Trace:
> >>  <TASK>
> >>  context_switch kernel/sched/core.c:4972 [inline]
> >>  __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
> >>  schedule+0xd2/0x260 kernel/sched/core.c:6326
> >>  io_schedule+0xee/0x170 kernel/sched/core.c:8371
> >>  bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
> >>  __wait_on_bit+0x60/0x190 kernel/sched/wait_bit.c:49
> >>  out_of_line_wait_on_bit+0xd5/0x110 kernel/sched/wait_bit.c:64
> >>  wait_on_bit_io include/linux/wait_bit.h:101 [inline]
> >>  __wait_on_buffer+0x7a/0x90 fs/buffer.c:122
> >>  wait_on_buffer include/linux/buffer_head.h:356 [inline]
> >>  journal_wait_on_commit_record fs/jbd2/commit.c:175 [inline]
> >>  jbd2_journal_commit_transaction+0x4e3c/0x6be0 fs/jbd2/commit.c:931
> >>  kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
> >>  kthread+0x405/0x4f0 kernel/kthread.c:327
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>  </TASK>
> >> 
> >> Showing all locks held in the system:
> >> 1 lock held by khungtaskd/27:
> >>  #0: ffffffff8bb812e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
> >> 1 lock held by udevd/2974:
> >> 2 locks held by getty/3287:
> >>  #0: ffff88807ec56098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
> >>  #1: ffffc90002b8e2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
> >> 2 locks held by kworker/1:0/3663:
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
> >>  #0: ffff888010c76538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
> >>  #1: ffffc90001b27db0 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
> >> 2 locks held by syz-executor.2/13278:
> >>  #0: ffffffff8bc4c6c8 (perf_sched_mutex){+.+.}-{3:3}, at: account_event kernel/events/core.c:11445 [inline]
> >>  #0: ffffffff8bc4c6c8 (perf_sched_mutex){+.+.}-{3:3}, at: perf_event_alloc.part.0+0x31f9/0x3b10 kernel/events/core.c:11678
> >>  #1: ffffffff8bb8a668 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
> >>  #1: ffffffff8bb8a668 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4fa/0x620 kernel/rcu/tree_exp.h:836
> >> 
> >> =============================================
> >> 
> >> NMI backtrace for cpu 0
> >> CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc5-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> Call Trace:
> >>  <TASK>
> >>  __dump_stack lib/dump_stack.c:88 [inline]
> >>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >>  nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
> >>  nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
> >>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
> >>  check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
> >>  watchdog+0xc1d/0xf50 kernel/hung_task.c:295
> >>  kthread+0x405/0x4f0 kernel/kthread.c:327
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>  </TASK>
> >> Sending NMI from CPU 0 to CPUs 1:
> >> NMI backtrace for cpu 1
> >> CPU: 1 PID: 10 Comm: kworker/u4:1 Not tainted 5.16.0-rc5-syzkaller #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >> Workqueue: events_unbound toggle_allocation_gate
> >> RIP: 0010:__kasan_check_read+0x4/0x10 mm/kasan/shadow.c:31
> >> Code: 44 07 48 85 db 0f 85 d0 9f 45 07 48 83 c4 60 5b 5d 41 5c 41 5d c3 c3 e9 d0 a0 45 07 cc cc cc cc cc cc cc cc cc cc 48 8b 0c 24 <89> f6 31 d2 e9 f3 f9 ff ff 0f 1f 00 48 8b 0c 24 89 f6 ba 01 00 00
> >> RSP: 0018:ffffc90000f0f630 EFLAGS: 00000002
> >> RAX: 0000000000000002 RBX: 1ffff920001e1ece RCX: ffffffff815b774f
> >> RDX: 0000000000000092 RSI: 0000000000000008 RDI: ffffffff8ff77a10
> >> RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8ff77a17
> >> R10: 0000000000000001 R11: 000000000000003f R12: 0000000000000008
> >> R13: ffff888011c7eda8 R14: 0000000000000092 R15: ffff888011c7edc8
> >> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00005555557b2708 CR3: 000000000b88e000 CR4: 00000000003506e0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <TASK>
> >>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
> >>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> >>  hlock_class kernel/locking/lockdep.c:199 [inline]
> >>  mark_lock+0xef/0x17b0 kernel/locking/lockdep.c:4583
> >>  mark_usage kernel/locking/lockdep.c:4526 [inline]
> >>  __lock_acquire+0x8a7/0x54a0 kernel/locking/lockdep.c:4981
> >>  lock_acquire kernel/locking/lockdep.c:5637 [inline]
> >>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
> >>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >>  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> >>  spin_lock include/linux/spinlock.h:349 [inline]
> >>  __get_locked_pte+0x2b6/0x4d0 mm/memory.c:1722
> >>  get_locked_pte include/linux/mm.h:2160 [inline]
> >>  __text_poke+0x1ae/0x8c0 arch/x86/kernel/alternative.c:1000
> >>  text_poke_bp_batch+0x3d7/0x560 arch/x86/kernel/alternative.c:1361
> >>  text_poke_flush arch/x86/kernel/alternative.c:1451 [inline]
> >>  text_poke_flush arch/x86/kernel/alternative.c:1448 [inline]
> >>  text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1458
> >>  arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
> >>  jump_label_update+0x1d5/0x430 kernel/jump_label.c:830
> >>  static_key_enable_cpuslocked+0x1b1/0x260 kernel/jump_label.c:177
> >>  static_key_enable+0x16/0x20 kernel/jump_label.c:190
> >>  toggle_allocation_gate mm/kfence/core.c:732 [inline]
> >>  toggle_allocation_gate+0x100/0x390 mm/kfence/core.c:724
> >>  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
> >>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
> >>  kthread+0x405/0x4f0 kernel/kthread.c:327
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >>  </TASK>
> >> sd 0:0:1:0: tag#6693 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
> >> sd 0:0:1:0: tag#6693 CDB: opcode=0xe5 (vendor)
> >> sd 0:0:1:0: tag#6693 CDB[00]: e5 f4 32 73 2f 4e 09 6d 26 e2 c7 35 d1 35 12 1c
> >> sd 0:0:1:0: tag#6693 CDB[10]: 92 1b da 40 b8 58 5b a8 d4 7d 34 f3 90 4c f1 2d
> >> sd 0:0:1:0: tag#6693 CDB[20]: ba
> >> ----------------
> >> Code disassembly (best guess):
> >>    0:	44 07                	rex.R (bad)
> >>    2:	48 85 db             	test   %rbx,%rbx
> >>    5:	0f 85 d0 9f 45 07    	jne    0x7459fdb
> >>    b:	48 83 c4 60          	add    $0x60,%rsp
> >>    f:	5b                   	pop    %rbx
> >>   10:	5d                   	pop    %rbp
> >>   11:	41 5c                	pop    %r12
> >>   13:	41 5d                	pop    %r13
> >>   15:	c3                   	retq
> >>   16:	c3                   	retq
> >>   17:	e9 d0 a0 45 07       	jmpq   0x745a0ec
> >>   1c:	cc                   	int3
> >>   1d:	cc                   	int3
> >>   1e:	cc                   	int3
> >>   1f:	cc                   	int3
> >>   20:	cc                   	int3
> >>   21:	cc                   	int3
> >>   22:	cc                   	int3
> >>   23:	cc                   	int3
> >>   24:	cc                   	int3
> >>   25:	cc                   	int3
> >>   26:	48 8b 0c 24          	mov    (%rsp),%rcx
> >> * 2a:	89 f6                	mov    %esi,%esi <-- trapping instruction
> >>   2c:	31 d2                	xor    %edx,%edx
> >>   2e:	e9 f3 f9 ff ff       	jmpq   0xfffffa26
> >>   33:	0f 1f 00             	nopl   (%rax)
> >>   36:	48 8b 0c 24          	mov    (%rsp),%rcx
> >>   3a:	89 f6                	mov    %esi,%esi
> >>   3c:	ba                   	.byte 0xba
> >>   3d:	01 00                	add    %eax,(%rax)
> >> 
> >> 
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >> 
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >> syzbot can test patches for this issue, for details see:
> >> https://goo.gl/tpsmEJ#testing-patches
> >
