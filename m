Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E176AF56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHAJqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjHAJo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:44:59 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854BE1996
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 02:42:50 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a483c86b74so10514645b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 02:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882970; x=1691487770;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLTIfytU76s703xolNPjIuDu40cWbZZ9zvr5kraQzUs=;
        b=ZSCJv6cLx1UlPkKVp3QITdWhxz6p6dTXzcww0M9FEZhyMdOL8JWF/tDNPRqJFAh8ut
         kLFkVWuBrqb/9iX0/OoBnDVZJbj3ls/dUyEP1s2ITcApgYwMFD78i/Npd3Aj+s2PlpfX
         EAsuxtgMIb8DiVYCjC30OOWunNRJ9Mek5+K2gUd47SfRHk/ZDLNGa80C8LWZ569ZvnLM
         7wOf6ERqj8vlg1ULAsOEgi7gtLsWUwyByiRgRuX+iY6FNHBF0VfMArt5wjLKGKBQVPpx
         xUjPXUgOU2oqn/9djuNUW3rvmv/hhqPVpsJyE4Rz2LeCdVNJK5DjQqZ8BMUM1EVRgtBA
         bs9Q==
X-Gm-Message-State: ABy/qLahNcLShElDWawf7buQKyRnrURrEEDWLQG9Eqe3xUVjynaNLsm8
        6jutSuAZ5za8+r3RNSQjGIffN4y0AOZ/KqWhRtYTO98IiyPT
X-Google-Smtp-Source: APBJJlGYT0h9T+q10+fnOhByXzJ9O6S3Ohw5fvt5aXO0Nz/7t6IFlWfdEt6n4quHliBYcQwiU+3Nvf/gDm0mxLJZ3rr9hHhGktpK
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1801:b0:3a7:2639:f835 with SMTP id
 bh1-20020a056808180100b003a72639f835mr9960943oib.6.1690882969888; Tue, 01 Aug
 2023 02:42:49 -0700 (PDT)
Date:   Tue, 01 Aug 2023 02:42:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6ec640601d95e6c@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in timerqueue_del (2)
From:   syzbot <syzbot+500a5eabc2495aaeb60e@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e0e2ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=500a5eabc2495aaeb60e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a8fe91a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120bf881a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cec811b5940/disk-5d0c230f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/192c2ba7a2c9/vmlinux-5d0c230f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9f2f32941c0/bzImage-5d0c230f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/355680836eb0/mount_0.gz

The issue was bisected to:

commit 2acf15b94d5b8ea8392c4b6753a6ffac3135cd78
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Fri Jul 2 04:07:43 2021 +0000

    reiserfs: add check for root_inode in reiserfs_fill_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1716f381a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1496f381a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1096f381a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+500a5eabc2495aaeb60e@syzkaller.appspotmail.com
Fixes: 2acf15b94d5b ("reiserfs: add check for root_inode in reiserfs_fill_super")

general protection fault, probably for non-canonical address 0xdffffc0000003202: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000019010-0x0000000000019017]
CPU: 1 PID: 5019 Comm: syz-executor249 Not tainted 6.5.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:rb_next+0x82/0x130 lib/rbtree.c:505
Code: 00 00 00 00 fc ff df 48 8b 43 08 48 85 c0 74 5e 48 bb 00 00 00 00 00 fc ff df eb 03 48 89 d0 48 8d 78 10 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 75 58 48 8b 50 10 48 85 d2 75 e3 48 83 c4 08 5b 5d 41
RSP: 0018:ffffc900001e0d80 EFLAGS: 00010012
RAX: 0000000000019000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 0000000000003202 RSI: ffffffff8a24416c RDI: 0000000000019010
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: ffff88807e0ff2e0 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff8880b992b880 R15: 0000000000000000
FS:  00007f54c11216c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdd9bb9080 CR3: 0000000026e38000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 rb_erase_cached include/linux/rbtree.h:124 [inline]
 timerqueue_del+0xd4/0x140 lib/timerqueue.c:57
 __remove_hrtimer+0x99/0x290 kernel/time/hrtimer.c:1119
 __run_hrtimer kernel/time/hrtimer.c:1668 [inline]
 __hrtimer_run_queues+0x55b/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1769
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x4c/0x1b0 arch/x86/lib/memmove_64.S:70
Code: 01 00 00 66 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 <4c> 8b 46 18 48 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47
RSP: 0018:ffffc90003c1ef88 EFLAGS: 00000286
RAX: ffff88806b69efb4 RBX: 0000000000000002 RCX: ffff88806b69e030
RDX: ffffffffed354f41 RSI: ffff88807e34a004 RDI: ffff88807e34a014
RBP: 0000000000000020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: ffff88806b69efa4 R15: 0000000000000010
 leaf_paste_entries+0x43c/0x920 fs/reiserfs/lbalance.c:1377
 balance_leaf_finish_node_paste_dirent fs/reiserfs/do_balan.c:1295 [inline]
 balance_leaf_finish_node_paste fs/reiserfs/do_balan.c:1321 [inline]
 balance_leaf_finish_node fs/reiserfs/do_balan.c:1364 [inline]
 balance_leaf+0x9476/0xcd90 fs/reiserfs/do_balan.c:1452
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x62a/0x7c0 fs/reiserfs/stree.c:2157
 reiserfs_add_entry+0x936/0xd60 fs/reiserfs/namei.c:565
 reiserfs_mkdir+0x68a/0x9a0 fs/reiserfs/namei.c:860
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:890 [inline]
 reiserfs_xattr_init+0x57f/0xbb0 fs/reiserfs/xattr.c:1006
 reiserfs_fill_super+0x2139/0x3150 fs/reiserfs/super.c:2175
 mount_bdev+0x30d/0x3d0 fs/super.c:1391
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54c1167bda
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 06 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54c1121088 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f54c1167bda
RDX: 0000000020001100 RSI: 0000000020000040 RDI: 00007f54c11210a0
RBP: 00007f54c11210a0 R08: 00007f54c11210e0 R09: 0000000000001109
R10: 0000000000008080 R11: 0000000000000286 R12: 00007f54c11210e0
R13: 0000000000008080 R14: 0000000000000003 R15: 0000000000400000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rb_next+0x82/0x130 lib/rbtree.c:505
Code: 00 00 00 00 fc ff df 48 8b 43 08 48 85 c0 74 5e 48 bb 00 00 00 00 00 fc ff df eb 03 48 89 d0 48 8d 78 10 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 75 58 48 8b 50 10 48 85 d2 75 e3 48 83 c4 08 5b 5d 41
RSP: 0018:ffffc900001e0d80 EFLAGS: 00010012

RAX: 0000000000019000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 0000000000003202 RSI: ffffffff8a24416c RDI: 0000000000019010
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
R10: ffff88807e0ff2e0 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff8880b992b880 R15: 0000000000000000
FS:  00007f54c11216c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdd9bb9080 CR3: 0000000026e38000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	48 8b 43 08          	mov    0x8(%rbx),%rax
   4:	48 85 c0             	test   %rax,%rax
   7:	74 5e                	je     0x67
   9:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  10:	fc ff df
  13:	eb 03                	jmp    0x18
  15:	48 89 d0             	mov    %rdx,%rax
  18:	48 8d 78 10          	lea    0x10(%rax),%rdi
  1c:	48 89 fa             	mov    %rdi,%rdx
  1f:	48 c1 ea 03          	shr    $0x3,%rdx
* 23:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1) <-- trapping instruction
  27:	75 58                	jne    0x81
  29:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2d:	48 85 d2             	test   %rdx,%rdx
  30:	75 e3                	jne    0x15
  32:	48 83 c4 08          	add    $0x8,%rsp
  36:	5b                   	pop    %rbx
  37:	5d                   	pop    %rbp
  38:	41                   	rex.B


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
