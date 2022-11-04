Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567F61910B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 07:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKDG1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKDG1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:27:05 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 23:27:03 PDT
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 170911A06F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 23:27:02 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 4 Nov 2022 14:57:00 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 4 Nov 2022 14:57:00 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: [QUESTION] {start,stop}_this_handle() and lockdep annotations
Date:   Fri,  4 Nov 2022 14:56:32 +0900
Message-Id: <1667541392-16270-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

With v6.1-rc3, a deadlock in the journal code was reported by DEPT. I'd
need to understand the journal code first before deep dive into it.

I found a few lockdep annotations was added into the journal code by
Peterz (commit 34a3d1e8370870 lockdep: annotate journal_start()) and
the commit message quoted what Andrew Morton said. It was like:

> Except lockdep doesn't know about journal_start(), which has ranking
> requirements similar to a semaphore.

Could anyone tell what the ranking requirements in the journal code
exactly means and what makes {start,stop}_this_handle() work for the
requirements?

Any comments would be appreciated. If needed, I'll explan the following
report and scenario in detail.

Just for your information, let me paste the DEPT report below.

	Byungchul

---
<4>[   43.124364 ] ===================================================
<4>[   43.124366 ] DEPT: Circular dependency has been detected.
<4>[   43.124367 ] 6.1.0-rc3-Trybot_110402v1-g601b2ef606e4+ #1 Not tainted
<4>[   43.124369 ] ---------------------------------------------------
<4>[   43.124369 ] summary
<4>[   43.124370 ] ---------------------------------------------------
<4>[   43.124370 ] *** DEADLOCK ***

<4>[   43.124371 ] context A
<4>[   43.124372 ]     [S] start_this_handle(jbd2_handle:0)
<4>[   43.124373 ]     [W] folio_wait_bit_common(pglocked:0)
<4>[   43.124374 ]     [E] up_read(jbd2_handle:0)

<4>[   43.124376 ] context B
<4>[   43.124377 ]     [S] (unknown)(pgwriteback:0)
<4>[   43.124378 ]     [W] start_this_handle(jbd2_handle:0)
<4>[   43.124379 ]     [E] folio_wake_bit(pgwriteback:0)

<4>[   43.124380 ] context C
<4>[   43.124381 ]     [S] (unknown)(pglocked:0)
<4>[   43.124382 ]     [W] folio_wait_bit_common(pgwriteback:0)
<4>[   43.124383 ]     [E] folio_wake_bit(pglocked:0)

<4>[   43.124384 ] [S]: start of the event context
<4>[   43.124384 ] [W]: the wait blocked
<4>[   43.124385 ] [E]: the event not reachable
<4>[   43.124385 ] ---------------------------------------------------
<4>[   43.124386 ] context A's detail
<4>[   43.124387 ] ---------------------------------------------------
<4>[   43.124387 ] context A
<4>[   43.124388 ]     [S] start_this_handle(jbd2_handle:0)
<4>[   43.124389 ]     [W] folio_wait_bit_common(pglocked:0)
<4>[   43.124389 ]     [E] up_read(jbd2_handle:0)

<4>[   43.124391 ] [S] start_this_handle(jbd2_handle:0):
<4>[   43.124392 ] [<ffffffff813e2fbc>] start_this_handle+0x4bc/0x620
<4>[   43.124398 ] stacktrace:
<4>[   43.124399 ]       start_this_handle+0x57c/0x620
<4>[   43.124401 ]       jbd2__journal_start+0xe8/0x270
<4>[   43.124404 ]       __ext4_journal_start_sb+0x147/0x190
<4>[   43.124407 ]       ext4_writepages+0x76f/0x1120
<4>[   43.124409 ]       do_writepages+0xc1/0x180
<4>[   43.124412 ]       file_write_and_wait_range+0xab/0xf0
<4>[   43.124414 ]       ext4_sync_file+0x122/0x480
<4>[   43.124416 ]       do_fsync+0x33/0x70
<4>[   43.124419 ]       __x64_sys_fdatasync+0xe/0x20
<4>[   43.124421 ]       do_syscall_64+0x44/0x90
<4>[   43.124424 ]       entry_SYSCALL_64_after_hwframe+0x63/0xcd

<4>[   43.124427 ] [W] folio_wait_bit_common(pglocked:0):
<4>[   43.124428 ] [<ffffffff81390bb6>] mpage_prepare_extent_to_map+0x446/0x7a0

<4>[   43.124431 ] [E] up_read(jbd2_handle:0):
<4>[   43.124431 ] (N/A)
<4>[   43.124432 ] ---------------------------------------------------
<4>[   43.124433 ] context B's detail
<4>[   43.124433 ] ---------------------------------------------------
<4>[   43.124434 ] context B
<4>[   43.124434 ]     [S] (unknown)(pgwriteback:0)
<4>[   43.124435 ]     [W] start_this_handle(jbd2_handle:0)
<4>[   43.124436 ]     [E] folio_wake_bit(pgwriteback:0)

<4>[   43.124437 ] [S] (unknown)(pgwriteback:0):
<4>[   43.124438 ] (N/A)

<4>[   43.124439 ] [W] start_this_handle(jbd2_handle:0):
<4>[   43.124440 ] [<ffffffff813e2fbc>] start_this_handle+0x4bc/0x620
<4>[   43.124442 ] stacktrace:
<4>[   43.124443 ]       start_this_handle+0x557/0x620
<4>[   43.124445 ]       jbd2_journal_start_reserved+0x4d/0x1b0
<4>[   43.124448 ]       __ext4_journal_start_reserved+0x6d/0x190
<4>[   43.124450 ]       ext4_convert_unwritten_io_end_vec+0x22/0xd0
<4>[   43.124453 ]       ext4_end_io_rsv_work+0xe4/0x190
<4>[   43.124455 ]       process_one_work+0x301/0x660
<4>[   43.124458 ]       worker_thread+0x3a/0x3c0
<4>[   43.124459 ]       kthread+0xef/0x120
<4>[   43.124462 ]       ret_from_fork+0x22/0x30

<4>[   43.124464 ] [E] folio_wake_bit(pgwriteback:0):
<4>[   43.124465 ] [<ffffffff811fb9c8>] folio_end_writeback+0x78/0xf0
<4>[   43.124467 ] stacktrace:
<4>[   43.124468 ]       folio_wake_bit+0x194/0x1a0
<4>[   43.124470 ]       folio_end_writeback+0x78/0xf0
<4>[   43.124471 ]       ext4_finish_bio+0x23f/0x340
<4>[   43.124473 ]       ext4_release_io_end+0x43/0xf0
<4>[   43.124474 ]       ext4_end_io_rsv_work+0x90/0x190
<4>[   43.124476 ]       process_one_work+0x301/0x660
<4>[   43.124478 ]       worker_thread+0x3a/0x3c0
<4>[   43.124480 ]       kthread+0xef/0x120
<4>[   43.124481 ]       ret_from_fork+0x22/0x30
<4>[   43.124482 ] ---------------------------------------------------
<4>[   43.124483 ] context C's detail
<4>[   43.124484 ] ---------------------------------------------------
<4>[   43.124484 ] context C
<4>[   43.124485 ]     [S] (unknown)(pglocked:0)
<4>[   43.124485 ]     [W] folio_wait_bit_common(pgwriteback:0)
<4>[   43.124486 ]     [E] folio_wake_bit(pglocked:0)

<4>[   43.124487 ] [S] (unknown)(pglocked:0):
<4>[   43.124488 ] (N/A)

<4>[   43.124489 ] [W] folio_wait_bit_common(pgwriteback:0):
<4>[   43.124490 ] [<ffffffff8120909d>] folio_wait_writeback+0x1d/0x110
<4>[   43.124492 ] stacktrace:
<4>[   43.124492 ]       folio_wait_bit_common+0x3e6/0x520
<4>[   43.124494 ]       folio_wait_writeback+0x1d/0x110
<4>[   43.124495 ]       mpage_prepare_extent_to_map+0x205/0x7a0
<4>[   43.124497 ]       ext4_writepages+0x4de/0x1120
<4>[   43.124499 ]       do_writepages+0xc1/0x180
<4>[   43.124501 ]       __writeback_single_inode+0x53/0x600
<4>[   43.124503 ]       writeback_sb_inodes+0x1ea/0x510
<4>[   43.124505 ]       wb_writeback+0xe7/0x450
<4>[   43.124506 ]       wb_workfn+0xe0/0x5e0
<4>[   43.124508 ]       process_one_work+0x301/0x660
<4>[   43.124510 ]       worker_thread+0x3a/0x3c0
<4>[   43.124512 ]       kthread+0xef/0x120
<4>[   43.124513 ]       ret_from_fork+0x22/0x30

<4>[   43.124515 ] [E] folio_wake_bit(pglocked:0):
<4>[   43.124516 ] [<ffffffff813b6f14>] ext4_bio_write_page+0x4d4/0x880
<4>[   43.124518 ] stacktrace:
<4>[   43.124518 ]       folio_wake_bit+0x152/0x1a0
<4>[   43.124520 ]       ext4_bio_write_page+0x4d4/0x880
<4>[   43.124521 ]       mpage_submit_page+0x49/0x70
<4>[   43.124523 ]       mpage_process_page_bufs+0xfb/0x110
<4>[   43.124525 ]       mpage_prepare_extent_to_map+0x2ab/0x7a0
<4>[   43.124527 ]       ext4_writepages+0x4de/0x1120
<4>[   43.124529 ]       do_writepages+0xc1/0x180
<4>[   43.124530 ]       __writeback_single_inode+0x53/0x600
<4>[   43.124532 ]       writeback_sb_inodes+0x1ea/0x510
<4>[   43.124534 ]       wb_writeback+0xe7/0x450
<4>[   43.124535 ]       wb_workfn+0xe0/0x5e0
<4>[   43.124537 ]       process_one_work+0x301/0x660
<4>[   43.124539 ]       worker_thread+0x3a/0x3c0
<4>[   43.124541 ]       kthread+0xef/0x120
<4>[   43.124542 ]       ret_from_fork+0x22/0x30
<4>[   43.124544 ] ---------------------------------------------------
<4>[   43.124544 ] information that might be helpful
<4>[   43.124545 ] ---------------------------------------------------
<4>[   43.124546 ] CPU: 0 PID: 1225 Comm: igt_runner Not tainted 6.1.0-rc3-Trybot_110402v1-g601b2ef606e4+ #1
<4>[   43.124548 ] Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
<4>[   43.124549 ] Call Trace:
<4>[   43.124550 ]  <TASK>
<4>[   43.124551 ]  dump_stack_lvl+0x60/0x8e
<4>[   43.124554 ]  print_circle.cold.39+0x44f/0x47e
<4>[   43.124558 ]  ? print_circle+0xc0/0xc0
<4>[   43.124561 ]  cb_check_dl+0x58/0x60
<4>[   43.124564 ]  bfs+0xd3/0x1b0
<4>[   43.124567 ]  add_dep+0xb6/0x1a0
<4>[   43.124570 ]  add_wait+0xf0/0x440
<4>[   43.124572 ]  ? mpage_prepare_extent_to_map+0x446/0x7a0
<4>[   43.124575 ]  dept_wait_split_map+0x142/0x1e0
<4>[   43.124578 ]  ? mpage_prepare_extent_to_map+0x446/0x7a0
<4>[   43.124580 ]  __folio_lock+0x86/0x300
<4>[   43.124582 ]  ? lock_is_held_type+0x112/0x150
<4>[   43.124586 ]  mpage_prepare_extent_to_map+0x446/0x7a0
<4>[   43.124588 ]  ? rcu_read_lock_sched_held+0x51/0x80
<4>[   43.124592 ]  ? jbd2__journal_start+0x151/0x270
<4>[   43.124595 ]  ? lock_is_held_type+0x112/0x150
<4>[   43.124597 ]  ? do_writepages+0xc1/0x180
<4>[   43.124599 ]  ext4_writepages+0x7b3/0x1120
<4>[   43.124602 ]  ? pop_ecxt+0xee/0x100
<4>[   43.124606 ]  do_writepages+0xc1/0x180
<4>[   43.124608 ]  ? lock_is_held_type+0x112/0x150
<4>[   43.124611 ]  file_write_and_wait_range+0xab/0xf0
<4>[   43.124622 ]  ext4_sync_file+0x122/0x480
<4>[   43.124624 ]  do_fsync+0x33/0x70
<4>[   43.124627 ]  __x64_sys_fdatasync+0xe/0x20
<4>[   43.124629 ]  do_syscall_64+0x44/0x90
<4>[   43.124631 ]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4>[   43.124633 ] RIP: 0033:0x7f6f2146d3c7
<4>[   43.124635 ] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4b 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 83 f3 f7 ff
<4>[   43.124637 ] RSP: 002b:00007ffc4e4b8918 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
<4>[   43.124639 ] RAX: ffffffffffffffda RBX: 0000000080045705 RCX: 00007f6f2146d3c7
<4>[   43.124640 ] RDX: 000000000000005f RSI: 00007ffc4e4b9020 RDI: 000000000000000a
<4>[   43.124641 ] RBP: 00007ffc4e4b8a40 R08: 0000000000000000 R09: 0000000000000000
<4>[   43.124642 ] R10: 00007ffc4e5251b0 R11: 0000000000000246 R12: 0000000000000012
<4>[   43.124643 ] R13: 00007ffc4e4b98a0 R14: 00007ffc4e4b9020 R15: 0000000000000000
<4>[   43.124656 ]  </TASK>
