Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927177A66DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjISOiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjISOiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:38:46 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A5BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:38:40 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6be515ec5d2so7634217a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134319; x=1695739119;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oENaF1k1+/wy1CC0DcW3gvtMEb3Q0XdQUTvB9dWOpLA=;
        b=I+AwlkcjOPCDmnGMtGrTXVO+x4qxDaiawu0Ybu6k/d3slsYYx14kWHSNGQDv7/ZW6d
         lXhDfa79PC9tflFU4ZQ4COTfNLDVRtJns1al9KDxJvkc+s+nwYmnvbTq1144K6N6yjJM
         dSyB/SjQzgGTXCPOno+Ukgywbf75MsPya0aPkeVHd3rmf/ZhQ8KPXkR1k8rlZyTcjUIx
         JWrpX+75QOSB7UlLq4tLq6IFEY34fed1tzJ2vor8W+yw+S07uOSnsLl8/icAEc495YwY
         AzotKukBwXOcxLN3FlAjX13kdCFtyan/S8f8da7hV+E11xRA3b9G2qgDi+7Q3n5EgvM+
         AoJA==
X-Gm-Message-State: AOJu0YxprDv5Uhh/RxeH0/Lcfq1783mJ/k8BsCwZfBhZbM6vcn3OTtQZ
        txDZ1XyCAlDvGY/RzLsjCtGrmckVYZqSNfcfDV39D7FG9sRC
X-Google-Smtp-Source: AGHT+IFtN/eoWtcJrdM+FoYq8WJSaHU8yfgTf8HJzJhwkzLru/v93LHPxhfqVkxuyjORT18XPzV0AZDnbW9kv65yvdTC1OVbF5Ps
MIME-Version: 1.0
X-Received: by 2002:a05:6830:113:b0:6bd:c80d:2b65 with SMTP id
 i19-20020a056830011300b006bdc80d2b65mr3778357otp.6.1695134319513; Tue, 19 Sep
 2023 07:38:39 -0700 (PDT)
Date:   Tue, 19 Sep 2023 07:38:39 -0700
In-Reply-To: <rxoippwvqkrtspegmgujhceebhatfowhoce2oqaagdlen2opv2@g7gl5mypcsea>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f61afe0605b7367a@google.com>
Subject: Re: [syzbot] [block] INFO: task hung in clean_bdev_aliases
From:   syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nogikh@google.com, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in clean_bdev_aliases

INFO: task syz-executor.0:6797 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc2-next-20230919-syzkaller-06333-g29e400e3ea48 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26448 pid:6797  ppid:5409   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5365 [inline]
 __schedule+0xee1/0x5a00 kernel/sched/core.c:6677
 schedule+0xe7/0x1b0 kernel/sched/core.c:6753
 io_schedule+0xbe/0x130 kernel/sched/core.c:8953
 folio_wait_bit_common+0x3dc/0x9c0 mm/filemap.c:1301
 folio_lock include/linux/pagemap.h:1042 [inline]
 clean_bdev_aliases+0x56b/0x610 fs/buffer.c:1732
 clean_bdev_bh_alias include/linux/buffer_head.h:222 [inline]
 __block_write_begin_int+0x8d6/0x14d0 fs/buffer.c:2125
 iomap_write_begin+0x5be/0x17b0 fs/iomap/buffered-io.c:772
 iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
 iomap_file_buffered_write+0x3d6/0x9a0 fs/iomap/buffered-io.c:968
 blkdev_buffered_write block/fops.c:634 [inline]
 blkdev_write_iter+0x4f5/0xc90 block/fops.c:684
 call_write_iter include/linux/fs.h:1986 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd63bc7cae9
RSP: 002b:00007fd63ca7f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd63bd9c050 RCX: 00007fd63bc7cae9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007fd63bcc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0100000000000042 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fd63bd9c050 R15: 00007ffca44145a8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8cba7260 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #0: ffffffff8cba7260 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:749 [inline]
 #0: ffffffff8cba7260 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
5 locks held by kworker/u4:6/958:
 #0: ffff8880b993c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffff8880b9928888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:999
 #2: ffff8880b99297d8 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5d/0x200 kernel/time/timer.c:999
 #3: ffffffff924c2a00 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x1a0/0x490 lib/debugobjects.c:717
 #4: ffffffff9244f788 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x1a0/0x490 lib/debugobjects.c:717
2 locks held by kworker/u4:12/1100:
 #0: ffff8880b993c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #1: ffff8880b9928888 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:999
2 locks held by getty/4786:
 #0: ffff88814bf030a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900020482f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc5/0x1480 drivers/tty/n_tty.c:2206
1 lock held by syz-executor.1/5410:
1 lock held by syz-executor.5/5418:
2 locks held by syz-executor.2/15785:
3 locks held by syz-executor.1/15788:
2 locks held by syz-executor.4/15793:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.6.0-rc2-next-20230919-syzkaller-06333-g29e400e3ea48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5049 Comm: kworker/0:4 Not tainted 6.6.0-rc2-next-20230919-syzkaller-06333-g29e400e3ea48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: events free_obj_work
RIP: 0010:unwind_next_frame+0x121c/0x2390 arch/x86/kernel/unwind_orc.c:665
Code: 79 11 00 00 4c 8b 6b 10 4c 39 ed 73 36 e8 3c c2 4c 00 4c 8d 75 08 4d 39 f4 73 28 e8 2e c2 4c 00 4d 39 f5 72 1e e8 24 c2 4c 00 <4c> 8b 7c 24 18 48 89 ee 4c 89 ff e8 24 bd 4c 00 49 39 ef 0f 83 50
RSP: 0018:ffffc9000374f778 EFLAGS: 00000093
RAX: 0000000000000000 RBX: ffffc9000374f850 RCX: 0000000000000000
RDX: ffff88807d000100 RSI: ffffffff813a678c RDI: ffffc9000374f860
RBP: ffffc9000374f848 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003748000
R13: ffffc90003750000 R14: ffffc9000374f850 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2af98ffbc1 CR3: 000000002acf4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __unwind_start+0x5a4/0x880 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xaf/0x170 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 kmem_cache_free+0x104/0x380 mm/slab.c:3582
 free_obj_work+0x33d/0x630 lib/debugobjects.c:331
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


Tested on:

commit:         29e400e3 Add linux-next specific files for 20230919
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20230919
console output: https://syzkaller.appspot.com/x/log.txt?x=10014938680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7a727b2649d5c9c
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
