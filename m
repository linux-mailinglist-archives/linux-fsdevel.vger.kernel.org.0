Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2A76884A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 23:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjG3Vay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjG3Vax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 17:30:53 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59291702
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 14:30:51 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1b44332e279so7628600fac.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 14:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690752651; x=1691357451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dzkWPTHgrzXDv6An/kvkTC93fsahnOUWFYybiAjBrg=;
        b=lF7epj+IgQfvp3UarNRyGCDR2m1jP1kOeAkwXR3EFIyb4x4R0K8DmoO2IWObggmHeO
         8oTo/TWa2z6yT7Wxibsaer6j2vmOzPX0PSn7qA06Cl5uRyORj04bpl4Ow+kd+W5HE3Hp
         LCqS1zvPXA0wFjWqrlNpfw7mTDTTUqSi+biPnU/xv30or7Gy/snWyuP8+4+kMbzQdooP
         mTA3gwUfYwBLbI6nHROIDY7cXchis3ia9nzKyjDXcsEeHdjXxNaxnGRjDKZ7XEkj4mYG
         m2zUk5E1eDPW2rfu3ijUt/C/KpL4v6XXSXWJ4dx643xNtKnEZSb6FQF6turOchNNqjC+
         MQ7w==
X-Gm-Message-State: ABy/qLZpwEF6dpFm+eZxsmMMGhGCc8m1TRHKLV14PJQpNsjwLKQyzFIf
        913noYBjC6V1ab8q2HNC0bcwTKllvKhT4zUVkb97c6fDk/HXblPRfw==
X-Google-Smtp-Source: APBJJlFcr8ZsqZWPjbq9Goa2+VmUhYYQwF4OFS0ChFXiWEV1jSbtytY3KpISncBrep6UHJYEF+uRO6RRMHE7eKjXi+bMf62f+dzH
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a89b:b0:1bb:6519:d254 with SMTP id
 eb27-20020a056870a89b00b001bb6519d254mr10003470oab.3.1690752651256; Sun, 30
 Jul 2023 14:30:51 -0700 (PDT)
Date:   Sun, 30 Jul 2023 14:30:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e675c0601bb077c@google.com>
Subject: [syzbot] [reiserfs?] KMSAN: uninit-value in __run_timers (3)
From:   syzbot <syzbot+a476a62530a631834eb0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0ba5d0720577 Add linux-next specific files for 20230726
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131d6165a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33fb77ef67a25e1
dashboard link: https://syzkaller.appspot.com/bug?extid=a476a62530a631834eb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110a13e9a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d06ef6a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fa09c6312ae/disk-0ba5d072.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7361000a4380/vmlinux-0ba5d072.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48a015458a58/bzImage-0ba5d072.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fe2a8163e2fa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a476a62530a631834eb0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc002000800c: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000100040060-0x0000000100040067]
CPU: 0 PID: 5042 Comm: syz-executor269 Not tainted 6.5.0-rc3-next-20230726-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
RIP: 0010:debug_object_deactivate lib/debugobjects.c:785 [inline]
RIP: 0010:debug_object_deactivate+0x175/0x320 lib/debugobjects.c:771
Code: da 48 c1 ea 03 80 3c 02 00 0f 85 54 01 00 00 48 8b 1b 48 85 db 0f 84 82 00 00 00 48 8d 7b 18 41 83 c4 01 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 11 01 00 00 4c 3b 7b 18 75 c4 48 8d 7b 10 48 b8
RSP: 0018:ffffc90000007c90 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000100040048 RCX: ffffffff816850de
RDX: 000000002000800c RSI: 0000000000000002 RDI: 0000000100040060
RBP: ffffc90000007d78 R08: 0000000000000001 R09: fffff52000000f80
R10: 0000000000000003 R11: 0000000000000800 R12: 0000000000000004
R13: 1ffff92000000f96 R14: ffffffff8a6eef00 R15: ffff888027a74448
FS:  0000555557506380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005571928dd028 CR3: 0000000072de4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 debug_timer_deactivate kernel/time/timer.c:787 [inline]
 debug_deactivate kernel/time/timer.c:831 [inline]
 detach_timer kernel/time/timer.c:878 [inline]
 expire_timers kernel/time/timer.c:1734 [inline]
 __run_timers+0x5f9/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x28/0x1b0 arch/x86/lib/memmove_64.S:44
Code: c3 90 f3 0f 1e fa 48 89 f8 48 39 fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 83 fa 20 0f 82 01 01 00 00 48 89 d1 <f3> a4 c3 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48
RSP: 0018:ffffc900039def88 EFLAGS: 00010286
RAX: ffff888069fa5fb4 RBX: 0000000000000002 RCX: fffffffffdbd2eff
RDX: ffffffffffffffe0 RSI: ffff88806c3d3085 RDI: ffff88806c3d3095
RBP: 0000000000000020 R08: ffff888069fa5f84 R09: 0000766972705f73
R10: 667265736965722e R11: 0000766972705f73 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888069fa5fa4 R15: 0000000000000010
 leaf_paste_entries+0x43c/0x920 fs/reiserfs/lbalance.c:1377
 balance_leaf_finish_node_paste_dirent fs/reiserfs/do_balan.c:1295 [inline]
 balance_leaf_finish_node_paste fs/reiserfs/do_balan.c:1321 [inline]
 balance_leaf_finish_node fs/reiserfs/do_balan.c:1364 [inline]
 balance_leaf+0x9476/0xcd90 fs/reiserfs/do_balan.c:1452
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x62a/0x7c0 fs/reiserfs/stree.c:2157
 reiserfs_add_entry+0x936/0xd20 fs/reiserfs/namei.c:565
 reiserfs_mkdir+0x68a/0x9a0 fs/reiserfs/namei.c:860
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:891 [inline]
 reiserfs_xattr_init+0x57f/0xbb0 fs/reiserfs/xattr.c:1007
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
RIP: 0033:0x7fefa74039aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 06 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc4c45728 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcc4c45740 RCX: 00007fefa74039aa
RDX: 00000000200011c0 RSI: 0000000020001100 RDI: 00007ffcc4c45740
RBP: 0000000000000004 R08: 00007ffcc4c45780 R09: 00000000000010ed
R10: 000000000000c0cc R11: 0000000000000286 R12: 000000000000c0cc
R13: 00007ffcc4c45780 R14: 0000000000000003 R15: 0000000000400000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
RIP: 0010:debug_object_deactivate lib/debugobjects.c:785 [inline]
RIP: 0010:debug_object_deactivate+0x175/0x320 lib/debugobjects.c:771
Code: da 48 c1 ea 03 80 3c 02 00 0f 85 54 01 00 00 48 8b 1b 48 85 db 0f 84 82 00 00 00 48 8d 7b 18 41 83 c4 01 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 11 01 00 00 4c 3b 7b 18 75 c4 48 8d 7b 10 48 b8
RSP: 0018:ffffc90000007c90 EFLAGS: 00010006

RAX: dffffc0000000000 RBX: 0000000100040048 RCX: ffffffff816850de
RDX: 000000002000800c RSI: 0000000000000002 RDI: 0000000100040060
RBP: ffffc90000007d78 R08: 0000000000000001 R09: fffff52000000f80
R10: 0000000000000003 R11: 0000000000000800 R12: 0000000000000004
R13: 1ffff92000000f96 R14: ffffffff8a6eef00 R15: ffff888027a74448
FS:  0000555557506380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005571928dd028 CR3: 0000000072de4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 54 01 00 00    	jne    0x162
   e:	48 8b 1b             	mov    (%rbx),%rbx
  11:	48 85 db             	test   %rbx,%rbx
  14:	0f 84 82 00 00 00    	je     0x9c
  1a:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  1e:	41 83 c4 01          	add    $0x1,%r12d
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 11 01 00 00    	jne    0x144
  33:	4c 3b 7b 18          	cmp    0x18(%rbx),%r15
  37:	75 c4                	jne    0xfffffffd
  39:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
