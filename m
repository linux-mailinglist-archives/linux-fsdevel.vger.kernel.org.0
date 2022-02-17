Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211194B9E56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiBQLKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 06:10:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiBQLK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:10:28 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E53B295FFF
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 03:10:12 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 17 Feb 2022 20:10:11 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 17 Feb 2022 20:10:10 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Report 2 in ext4 and journal based on v5.17-rc1
Date:   Thu, 17 Feb 2022 20:10:04 +0900
Message-Id: <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[    9.008161] ===================================================
[    9.008163] DEPT: Circular dependency has been detected.
[    9.008164] 5.17.0-rc1-00015-gb94f67143867-dirty #2 Tainted: G        W
[    9.008166] ---------------------------------------------------
[    9.008167] summary
[    9.008167] ---------------------------------------------------
[    9.008168] *** DEADLOCK ***
[    9.008168]
[    9.008168] context A
[    9.008169]     [S] (unknown)(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008171]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    9.008172]     [E] event(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008173]
[    9.008173] context B
[    9.008174]     [S] down_write(mapping.invalidate_lock:0)
[    9.008175]     [W] wait(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008176]     [E] up_write(mapping.invalidate_lock:0)
[    9.008177]
[    9.008178] context C
[    9.008179]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    9.008180]     [W] down_write(mapping.invalidate_lock:0)
[    9.008181]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    9.008181]
[    9.008182] [S]: start of the event context
[    9.008183] [W]: the wait blocked
[    9.008183] [E]: the event not reachable
[    9.008184] ---------------------------------------------------
[    9.008184] context A's detail
[    9.008185] ---------------------------------------------------
[    9.008186] context A
[    9.008186]     [S] (unknown)(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008187]     [W] wait(&(&journal->j_wait_commit)->dmap:0)
[    9.008188]     [E] event(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008189]
[    9.008190] [S] (unknown)(&(&journal->j_wait_transaction_locked)->dmap:0):
[    9.008191] (N/A)
[    9.008191]
[    9.008192] [W] wait(&(&journal->j_wait_commit)->dmap:0):
[    9.008193] prepare_to_wait (kernel/sched/wait.c:275) 
[    9.008197] stacktrace:
[    9.008198] __schedule (kernel/sched/sched.h:1318 kernel/sched/sched.h:1616 kernel/sched/core.c:6213) 
[    9.008200] schedule (kernel/sched/core.c:6373 (discriminator 1)) 
[    9.008201] kjournald2 (fs/jbd2/journal.c:250) 
[    9.008203] kthread (kernel/kthread.c:377) 
[    9.008206] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[    9.008209]
[    9.008209] [E] event(&(&journal->j_wait_transaction_locked)->dmap:0):
[    9.008210] __wake_up_common (kernel/sched/wait.c:108) 
[    9.008212] stacktrace:
[    9.008213] dept_event (kernel/dependency/dept.c:2337) 
[    9.008215] __wake_up_common (kernel/sched/wait.c:109) 
[    9.008217] __wake_up_common_lock (./include/linux/spinlock.h:428 (discriminator 1) kernel/sched/wait.c:141 (discriminator 1)) 
[    9.008218] jbd2_journal_commit_transaction (fs/jbd2/commit.c:583) 
[    9.008221] kjournald2 (fs/jbd2/journal.c:214 (discriminator 3)) 
[    9.008223] kthread (kernel/kthread.c:377) 
[    9.008224] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[    9.008226] ---------------------------------------------------
[    9.008226] context B's detail
[    9.008227] ---------------------------------------------------
[    9.008228] context B
[    9.008228]     [S] down_write(mapping.invalidate_lock:0)
[    9.008229]     [W] wait(&(&journal->j_wait_transaction_locked)->dmap:0)
[    9.008230]     [E] up_write(mapping.invalidate_lock:0)
[    9.008231]
[    9.008232] [S] down_write(mapping.invalidate_lock:0):
[    9.008233] ext4_da_write_begin (fs/ext4/truncate.h:21 fs/ext4/inode.c:2963) 
[    9.008237] stacktrace:
[    9.008237] down_write (kernel/locking/rwsem.c:1514) 
[    9.008239] ext4_da_write_begin (fs/ext4/truncate.h:21 fs/ext4/inode.c:2963) 
[    9.008241] generic_perform_write (mm/filemap.c:3784) 
[    9.008243] ext4_buffered_write_iter (fs/ext4/file.c:269) 
[    9.008245] ext4_file_write_iter (fs/ext4/file.c:677) 
[    9.008247] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
[    9.008250] vfs_write (fs/read_write.c:590) 
[    9.008251] ksys_write (fs/read_write.c:644) 
[    9.008253] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    9.008255] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
[    9.008258]
[    9.008258] [W] wait(&(&journal->j_wait_transaction_locked)->dmap:0):
[    9.008259] prepare_to_wait (kernel/sched/wait.c:275) 
[    9.008261] stacktrace:
[    9.008261] __schedule (kernel/sched/sched.h:1318 kernel/sched/sched.h:1616 kernel/sched/core.c:6213) 
[    9.008263] schedule (kernel/sched/core.c:6373 (discriminator 1)) 
[    9.008264] wait_transaction_locked (fs/jbd2/transaction.c:184) 
[    9.008266] add_transaction_credits (fs/jbd2/transaction.c:248 (discriminator 3)) 
[    9.008267] start_this_handle (fs/jbd2/transaction.c:427) 
[    9.008269] jbd2__journal_start (fs/jbd2/transaction.c:526) 
[    9.008271] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:105) 
[    9.008273] ext4_truncate (fs/ext4/inode.c:4164) 
[    9.008274] ext4_da_write_begin (./include/linux/fs.h:827 fs/ext4/truncate.h:23 fs/ext4/inode.c:2963) 
[    9.008276] generic_perform_write (mm/filemap.c:3784) 
[    9.008277] ext4_buffered_write_iter (fs/ext4/file.c:269) 
[    9.008279] ext4_file_write_iter (fs/ext4/file.c:677) 
[    9.008281] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
[    9.008283] vfs_write (fs/read_write.c:590) 
[    9.008284] ksys_write (fs/read_write.c:644) 
[    9.008285] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    9.008287]
[    9.008288] [E] up_write(mapping.invalidate_lock:0):
[    9.008288] ext4_da_get_block_prep (fs/ext4/inode.c:1795 fs/ext4/inode.c:1829) 
[    9.008291] ---------------------------------------------------
[    9.008291] context C's detail
[    9.008292] ---------------------------------------------------
[    9.008292] context C
[    9.008293]     [S] (unknown)(&(&journal->j_wait_commit)->dmap:0)
[    9.008294]     [W] down_write(mapping.invalidate_lock:0)
[    9.008295]     [E] event(&(&journal->j_wait_commit)->dmap:0)
[    9.008296]
[    9.008297] [S] (unknown)(&(&journal->j_wait_commit)->dmap:0):
[    9.008298] (N/A)
[    9.008298]
[    9.008299] [W] down_write(mapping.invalidate_lock:0):
[    9.008299] ext4_da_write_begin (fs/ext4/truncate.h:21 fs/ext4/inode.c:2963) 
[    9.008302] stacktrace:
[    9.008302] down_write (kernel/locking/rwsem.c:1514) 
[    9.008304] ext4_da_write_begin (fs/ext4/truncate.h:21 fs/ext4/inode.c:2963) 
[    9.008305] generic_perform_write (mm/filemap.c:3784) 
[    9.008307] ext4_buffered_write_iter (fs/ext4/file.c:269) 
[    9.008309] ext4_file_write_iter (fs/ext4/file.c:677) 
[    9.008311] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
[    9.008312] vfs_write (fs/read_write.c:590) 
[    9.008314] ksys_write (fs/read_write.c:644) 
[    9.008315] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    9.008316] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
[    9.008318]
[    9.008319] [E] event(&(&journal->j_wait_commit)->dmap:0):
[    9.008320] __wake_up_common (kernel/sched/wait.c:108) 
[    9.008321] stacktrace:
[    9.008322] __wake_up_common (kernel/sched/wait.c:109) 
[    9.008323] __wake_up_common_lock (./include/linux/spinlock.h:428 (discriminator 1) kernel/sched/wait.c:141 (discriminator 1)) 
[    9.008324] __jbd2_log_start_commit (fs/jbd2/journal.c:508) 
[    9.008326] jbd2_log_start_commit (fs/jbd2/journal.c:527) 
[    9.008327] __jbd2_journal_force_commit (fs/jbd2/journal.c:560) 
[    9.008329] jbd2_journal_force_commit_nested (fs/jbd2/journal.c:583) 
[    9.008331] ext4_should_retry_alloc (fs/ext4/balloc.c:670 (discriminator 3)) 
[    9.008332] ext4_da_write_begin (fs/ext4/inode.c:2965 (discriminator 1)) 
[    9.008334] generic_perform_write (mm/filemap.c:3784) 
[    9.008335] ext4_buffered_write_iter (fs/ext4/file.c:269) 
[    9.008337] ext4_file_write_iter (fs/ext4/file.c:677) 
[    9.008339] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
[    9.008341] vfs_write (fs/read_write.c:590) 
[    9.008342] ksys_write (fs/read_write.c:644) 
[    9.008343] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    9.008345] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
[    9.008347] ---------------------------------------------------
[    9.008348] information that might be helpful
[    9.008348] ---------------------------------------------------
[    9.008349] CPU: 0 PID: 89 Comm: jbd2/sda1-8 Tainted: G        W         5.17.0-rc1-00015-gb94f67143867-dirty #2
[    9.008352] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
[    9.008353] Call Trace:
[    9.008354]  <TASK>
[    9.008355] dump_stack_lvl (lib/dump_stack.c:107) 
[    9.008358] print_circle (./arch/x86/include/asm/atomic.h:108 ./include/linux/atomic/atomic-instrumented.h:258 kernel/dependency/dept.c:157 kernel/dependency/dept.c:762) 
[    9.008360] ? print_circle (kernel/dependency/dept.c:1086) 
[    9.008362] cb_check_dl (kernel/dependency/dept.c:1104) 
[    9.008364] bfs (kernel/dependency/dept.c:860) 
[    9.008366] add_dep (kernel/dependency/dept.c:1423) 
[    9.008368] do_event.isra.25 (kernel/dependency/dept.c:1651) 
[    9.008370] ? __wake_up_common (kernel/sched/wait.c:108) 
[    9.008372] dept_event (kernel/dependency/dept.c:2337) 
[    9.008374] __wake_up_common (kernel/sched/wait.c:109) 
[    9.008376] __wake_up_common_lock (./include/linux/spinlock.h:428 (discriminator 1) kernel/sched/wait.c:141 (discriminator 1)) 
[    9.008379] jbd2_journal_commit_transaction (fs/jbd2/commit.c:583) 
[    9.008381] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[    9.008385] ? ret_from_fork (arch/x86/entry/entry_64.S:301) 
[    9.008387] ? dept_enable_hardirq (./arch/x86/include/asm/current.h:15 kernel/dependency/dept.c:241 kernel/dependency/dept.c:999 kernel/dependency/dept.c:1043 kernel/dependency/dept.c:1843) 
[    9.008389] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    9.008392] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[    9.008394] ? try_to_del_timer_sync (kernel/time/timer.c:1239) 
[    9.008396] kjournald2 (fs/jbd2/journal.c:214 (discriminator 3)) 
[    9.008398] ? prepare_to_wait_exclusive (kernel/sched/wait.c:431) 
[    9.008400] ? commit_timeout (fs/jbd2/journal.c:173) 
[    9.008402] kthread (kernel/kthread.c:377) 
[    9.008404] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[    9.008407] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[    9.008410]  </TASK>
