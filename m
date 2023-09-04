Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582079121E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352411AbjIDH25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352402AbjIDH25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:57 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0810129
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 00:28:49 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5700e513e01so667387a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 00:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812529; x=1694417329;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyV0kvyh71m+vpajhSXcdd50x/LNT9I94jfNTNHz0Pk=;
        b=SG/j33ZJJUZ7vQAYfJ8MquZB/kZrh3xuaxxUSm8/Djpgdr6b8mD4Q9UD/rQuxgXDPV
         6sEByW7SIuVV0JollJFh8NoUza45MZsmHnIjPEuZcmSULZY9qHG2rtZPz0lIHorQQkHN
         l+tHo8zmjertr2GCf9mPEyktRThmV9zwO64m7MjiDk34WHV+/Lq78RGd/d/GTmnI4wg0
         H+a5C2W5YmElTVvffRFWr2rmSMARLemUToF77pXnlvbanAKD0tcj944uTCIXyDXF3m64
         XWhIOULvjrzCSc/AsRmEAHo22s722TICShLWE9cA4KzFPAnksFvD19TwyNJ5+K8l7D9I
         EQgQ==
X-Gm-Message-State: AOJu0YzJlprnikvMxxE9yaytCCM5aVEVJ+hVqdBW80Gwv5l8KRl7Af22
        ojfuwhCOdrjIaN07K2Vz2RiJfoCrrdvUcDqFycMbsthcNJHX
X-Google-Smtp-Source: AGHT+IH35Jg8iAlH5uvm1QcAa9pVAGe8DU9jmWlA9XDlTHg27qqGmI1uNr5gb7FzUoGmnw7e7GtQJpVZyeWMGHpQ+q217flDR4qi
MIME-Version: 1.0
X-Received: by 2002:a63:3eca:0:b0:56f:9c2d:b6b3 with SMTP id
 l193-20020a633eca000000b0056f9c2db6b3mr2148910pga.1.1693812529267; Mon, 04
 Sep 2023 00:28:49 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:28:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f905c0604837659@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in write_cache_pages (3)
From:   syzbot <syzbot+4fcffdd85e518af6f129@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, akpm@linux-foundation.org, anprice@redhat.com,
        cluster-devel@redhat.com, dvyukov@google.com, elver@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16880848680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
dashboard link: https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17933a00680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef7104680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f58f2fdc5a9e/disk-92901222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16dba3905664/vmlinux-92901222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a5b1d5efdbd/bzImage-92901222.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/821293a2c99e/mount_0.gz

The issue was bisected to:

commit 47b7ec1daa511cd82cb9c31e88bfdb664b031d2a
Author: Andrew Price <anprice@redhat.com>
Date:   Fri Feb 5 17:10:17 2021 +0000

    gfs2: Enable rgrplvb for sb_fs_format 1802

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c9842ba80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c9842ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c9842ba80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fcffdd85e518af6f129@syzkaller.appspotmail.com
Fixes: 47b7ec1daa51 ("gfs2: Enable rgrplvb for sb_fs_format 1802")

INFO: task kworker/u4:5:138 blocked for more than 143 seconds.
      Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:21344 pid:138   ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 io_schedule+0x8c/0x100 kernel/sched/core.c:9026
 folio_wait_bit_common+0x871/0x12a0 mm/filemap.c:1304
 folio_lock include/linux/pagemap.h:1042 [inline]
 write_cache_pages+0x517/0x13f0 mm/page-writeback.c:2441
 iomap_writepages+0x68/0x240 fs/iomap/buffered-io.c:1979
 gfs2_writepages+0x169/0x1f0 fs/gfs2/aops.c:191
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 __writeback_single_inode+0x155/0xfa0 fs/fs-writeback.c:1603
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:1965
 wb_writeback+0x461/0xc60 fs/fs-writeback.c:2072
 wb_check_background_flush fs/fs-writeback.c:2142 [inline]
 wb_do_writeback fs/fs-writeback.c:2230 [inline]
 wb_workfn+0xc6f/0xff0 fs/fs-writeback.c:2257
 process_one_work+0x781/0x1130 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0xabf/0x1060 kernel/workqueue.c:2784
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task syz-executor336:5029 blocked for more than 143 seconds.
      Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor336 state:D stack:23408 pid:5029  ppid:5028   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 io_schedule+0x8c/0x100 kernel/sched/core.c:9026
 folio_wait_bit_common+0x871/0x12a0 mm/filemap.c:1304
 folio_lock include/linux/pagemap.h:1042 [inline]
 write_cache_pages+0x517/0x13f0 mm/page-writeback.c:2441
 iomap_writepages+0x68/0x240 fs/iomap/buffered-io.c:1979
 gfs2_writepages+0x169/0x1f0 fs/gfs2/aops.c:191
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:393
 __filemap_fdatawrite_range mm/filemap.c:426 [inline]
 __filemap_fdatawrite mm/filemap.c:432 [inline]
 filemap_fdatawrite+0x143/0x1b0 mm/filemap.c:437
 gfs2_ordered_write fs/gfs2/log.c:740 [inline]
 gfs2_log_flush+0xa42/0x25f0 fs/gfs2/log.c:1098
 gfs2_trans_end+0x39f/0x560 fs/gfs2/trans.c:158
 gfs2_page_mkwrite+0x1262/0x14f0 fs/gfs2/file.c:533
 do_page_mkwrite+0x197/0x470 mm/memory.c:2931
 do_shared_fault mm/memory.c:4647 [inline]
 do_fault mm/memory.c:4709 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x22b2/0x6200 mm/memory.c:5284
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2ac/0x860 arch/x86/mm/fault.c:1561
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f088fba48e7
RSP: 002b:00007fff09b9e550 EFLAGS: 00010286
RAX: 0030656c69662f2e RBX: 0000000000000000 RCX: 0000000020000180
RDX: 00000000c018937d RSI: 00000000ffffffff RDI: 0000000000000010
RBP: 00007f088fc5f5f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fff09b9e580
R13: 00007fff09b9e7a8 R14: 431bde82d7b634db R15: 00007f088fc2203b
 </TASK>
INFO: task gfs2_logd:5032 blocked for more than 144 seconds.
      Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:gfs2_logd       state:D stack:28672 pid:5032  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_write_slowpath+0xedd/0x13a0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 gfs2_log_flush+0x105/0x25f0 fs/gfs2/log.c:1042
 gfs2_logd+0x488/0xec0 fs/gfs2/log.c:1325
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task gfs2_quotad:5033 blocked for more than 144 seconds.
      Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:gfs2_quotad     state:D stack:27216 pid:5033  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 __gfs2_trans_begin+0x55c/0x940 fs/gfs2/trans.c:87
 gfs2_trans_begin+0x71/0xe0 fs/gfs2/trans.c:118
 gfs2_statfs_sync+0x41e/0x870 fs/gfs2/super.c:298
 quotad_check_timeo fs/gfs2/quota.c:1510 [inline]
 gfs2_quotad+0x37f/0x680 fs/gfs2/quota.c:1552
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xdf5/0xe40 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 68 Comm: kworker/u4:4 Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__insn_get_emulate_prefix arch/x86/lib/insn.c:91 [inline]
RIP: 0010:insn_get_emulate_prefix arch/x86/lib/insn.c:106 [inline]
RIP: 0010:insn_get_prefixes+0x113/0x18a0 arch/x86/lib/insn.c:134
Code: 0f b6 04 03 84 c0 0f 85 fd 10 00 00 41 0f b6 6d 00 bf 0f 00 00 00 89 ee e8 5a 5e c8 f6 4d 8d 65 02 83 fd 0f 0f 85 15 01 00 00 <4d> 39 f4 0f 87 0c 01 00 00 48 8b 44 24 08 48 c1 e8 03 48 b9 00 00
RSP: 0018:ffffc90001597660 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffffffff160ae95 RCX: ffffffff8b0574ab
RDX: ffff888018ab8000 RSI: 000000000000000f RDI: 000000000000000f
RBP: 000000000000000f R08: ffffffff8ac531f6 R09: 0000000000000000
R10: ffffc900015979c0 R11: fffff520002b2f43 R12: ffffffff8b0574ac
R13: ffffffff8b0574aa R14: ffffffff8b0574b9 R15: ffffc900015979c0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555efaf520e8 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 insn_get_opcode+0x1b2/0xa50 arch/x86/lib/insn.c:272
 insn_get_modrm+0x22e/0x7a0 arch/x86/lib/insn.c:343
 insn_get_sib arch/x86/lib/insn.c:421 [inline]
 insn_get_displacement+0x13e/0x980 arch/x86/lib/insn.c:464
 insn_get_immediate+0x382/0x13d0 arch/x86/lib/insn.c:632
 insn_get_length arch/x86/lib/insn.c:707 [inline]
 insn_decode+0x370/0x500 arch/x86/lib/insn.c:747
 text_poke_loc_init+0xed/0x860 arch/x86/kernel/alternative.c:2312
 arch_jump_label_transform_queue+0x8b/0xf0 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:475
 static_key_disable_cpuslocked+0xce/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:834
 process_one_work+0x781/0x1130 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0xabf/0x1060 kernel/workqueue.c:2784
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.251 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
