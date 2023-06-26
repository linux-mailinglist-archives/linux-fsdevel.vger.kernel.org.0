Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94473D836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFZHHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFZHHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:07:12 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E0135
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 00:06:55 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3457935f6easo16345115ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 00:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687763215; x=1690355215;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7+/YozsNpY44NNHnDxuZa5iAazpTZjily6SH1uHkgM=;
        b=Z4Xy+byL9GEgsmJPcNS8mN/HHzuMgfQfLb7kSWiiCZFtm1A1+HfeF8s3FAPEwvSXvB
         itmGyi3ShqlLGBvWyBe6YtUXH24VbXZZfS4x0IWrxSL/EBEdYCa/ju20VtUCeI4l6Orq
         XsTuytPk1ijnGwvwSOfyQxZFUZdiqJ4uZ7nb/Jevx2fdeZN4hg+I5L1uuI8KeVbEkdtU
         /PNTiIMUWSUM2lgtO1BYeQJlRig3usQkVlocpzwclGwYtz1GzoHIetHXnMJ+63pB/4sS
         iVeJMm0fSbe0hoBY1Eb9Z9PqbOgiNJ1HbFJjLXCK5FAa9r//Ah2cLJT0cl2CWko5dOwY
         3obg==
X-Gm-Message-State: AC+VfDw5bOUPIHnZ+pIEEF4w1+m6cW9h/tzaCOb/raHqltxGUuvo/e20
        oWaXGzHjjCh9gynlETCd4+0YMXJfiJK25T9p6ZCkk+GDT4xMtWDr9w==
X-Google-Smtp-Source: ACHHUZ4YrD1bnJDhdrkDIkBdSn5q6ZZaGblGtau4bsywV21K0C5X4XZwZemP0/DoGKaO0FyihBbk0IfOQHf9thpMPx2hb4zIh4ue
MIME-Version: 1.0
X-Received: by 2002:a92:dc47:0:b0:345:aba5:3775 with SMTP id
 x7-20020a92dc47000000b00345aba53775mr710495ilq.4.1687763214843; Mon, 26 Jun
 2023 00:06:54 -0700 (PDT)
Date:   Mon, 26 Jun 2023 00:06:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2c68a05ff02fe43@google.com>
Subject: [syzbot] [reiserfs?] kernel panic: corrupted stack end in do_sys_ftruncate
From:   syzbot <syzbot+3e32db5854a2dc0011ff@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17455d57280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=3e32db5854a2dc0011ff
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d50a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bee4cb280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53d1be238f30/disk-a92b7d26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04748ac79920/vmlinux-a92b7d26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78634d05a96b/bzImage-a92b7d26.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1afab00be7e0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e32db5854a2dc0011ff@syzkaller.appspotmail.com

REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 PID: 4994 Comm: syz-executor351 Not tainted 6.4.0-rc7-syzkaller-00226-ga92b7d26c743 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 panic+0x686/0x730 kernel/panic.c:340
 schedule_debug kernel/sched/core.c:5905 [inline]
 __schedule+0x5055/0x5880 kernel/sched/core.c:6563
 preempt_schedule_irq+0x52/0x90 kernel/sched/core.c:6981
 irqentry_exit+0x35/0x80 kernel/entry/common.c:433
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x4b/0x1b0 arch/x86/lib/memmove_64.S:68
Code: 01 01 00 00 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 <4c> 8b 46 18 48 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47
RSP: 0018:ffffc9000390ef90 EFLAGS: 00000282
RAX: ffff8880734b1030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: fffffffff67b3789 RSI: ffff88807ccfe700 RDI: ffff88807ccfd730
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000fd0 R14: ffff8880734b10d8 R15: 0000000000000008
 leaf_paste_in_buffer+0x270/0xc30 fs/reiserfs/lbalance.c:1017
 balance_leaf_new_nodes_paste_whole fs/reiserfs/do_balan.c:1171 [inline]
 balance_leaf_new_nodes_paste fs/reiserfs/do_balan.c:1215 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1246 [inline]
 balance_leaf+0x29c5/0xddc0 fs/reiserfs/do_balan.c:1450
 do_balance+0x319/0x810 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x74b/0x8d0 fs/reiserfs/stree.c:2157
 reiserfs_get_block+0x165c/0x4100 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:2064
 reiserfs_write_begin+0x36e/0xa60 fs/reiserfs/inode.c:2773
 generic_cont_expand_simple+0x117/0x1f0 fs/buffer.c:2425
 reiserfs_setattr+0x395/0x1370 fs/reiserfs/inode.c:3303
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 do_sys_ftruncate+0x53a/0x770 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa89d7102b9
Code: eb ff ff 44 89 25 77 1e 07 00 48 8b 45 90 48 89 05 2c 43 07 00 48 8b 45 c8 64 48 2b 04 25 28 00 00 00 0f 85 1f 01 00 00 48 8d <65> d8 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 1f 80 00 00 00
RSP: 002b:00007ffc8f2c2e78 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa89d7102b9
RDX: 00007fa89d7102b9 RSI: 0000000002007fff RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffc8f2c2ea0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
----------------
Code disassembly (best guess):
   0:	01 01                	add    %eax,(%rcx)
   2:	00 00                	add    %al,(%rax)
   4:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   9:	48 81 fa a8 02 00 00 	cmp    $0x2a8,%rdx
  10:	72 05                	jb     0x17
  12:	40 38 fe             	cmp    %dil,%sil
  15:	74 48                	je     0x5f
  17:	48 83 ea 20          	sub    $0x20,%rdx
  1b:	48 83 ea 20          	sub    $0x20,%rdx
  1f:	4c 8b 1e             	mov    (%rsi),%r11
  22:	4c 8b 56 08          	mov    0x8(%rsi),%r10
  26:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
* 2a:	4c 8b 46 18          	mov    0x18(%rsi),%r8 <-- trapping instruction
  2e:	48 8d 76 20          	lea    0x20(%rsi),%rsi
  32:	4c 89 1f             	mov    %r11,(%rdi)
  35:	4c 89 57 08          	mov    %r10,0x8(%rdi)
  39:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
  3d:	4c                   	rex.WR
  3e:	89                   	.byte 0x89
  3f:	47                   	rex.RXB


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
