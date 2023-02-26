Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC286A2DF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBZDyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 22:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBZDyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:54:13 -0500
Received: from mail-io1-xd47.google.com (mail-io1-xd47.google.com [IPv6:2607:f8b0:4864:20::d47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23F17CE0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 19:53:42 -0800 (PST)
Received: by mail-io1-xd47.google.com with SMTP id 207-20020a6b14d8000000b0074ca9a558feso1735601iou.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Feb 2023 19:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd31VU10PJZuIxtn4bPfkjZ2X0Vloo3og5W58I5g+Pc=;
        b=eC/srseScvZUdWnb8D1FRQ4z9oWaVAGyWMEvp16kfTjO/L513xT1B8XbVp+Fv4LM0x
         eb8MIMwQRSj5CP+fyTCwKHawoT1r5sWUNRThwZSwZ94f/d+H6oNiBE8/rLG8tjibOPY1
         tA83FyXbgGvaxaT77VRNYT/pPAJy3XhSxaZn1QdhioXoZp274BTmDlg1CWsoqQnYmBqr
         qu+de+G7Bh1vSTBTKuZS6g+HDItP3C/6AmOvx9pYiInK+iKayPLvYu646j6e1VxqkkzA
         YmENTDy5bDTq9EzBjisOGrFSSVML9B8X91Yu4aviEF9/h3OqIPPv7bKAF5/hZwBA/YYA
         sVKA==
X-Gm-Message-State: AO0yUKUzzv+HdZj0B+5/GQ/HUUqcKaEVUFjxZeX3SyDWtq+1zuS9ORwF
        bikh9t9A+7CWqiG3uhQopXNvLFZrgIKxQyE/Jg4JEiYIoyLGPXk=
X-Google-Smtp-Source: AK7set9v5MKlOPXoI0zkAmoPq4P8x+H+7gnV15auRynzkYRxq7WzLRcqgNF+bpNd+NSYmqI0y1EvxMnLfy3Dbkiljc4/52V/v/cQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1066:b0:310:9fc1:a92b with SMTP id
 q6-20020a056e02106600b003109fc1a92bmr6813796ilj.0.1677383502889; Sat, 25 Feb
 2023 19:51:42 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:51:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7894b05f5924787@google.com>
Subject: [syzbot] [reiserfs?] [fat?] [fuse?] general protection fault in
 timerqueue_add (4)
From:   syzbot <syzbot+21f2b8753d8bfc6bb816@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a7d37e824f5 Merge tag 'hardening-v6.3-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbf928c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b969c5af147d31c
dashboard link: https://syzkaller.appspot.com/bug?extid=21f2b8753d8bfc6bb816
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c64f20c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13734ba0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c3d867561ee/disk-4a7d37e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/422516721d17/vmlinux-4a7d37e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/164340e12ac4/bzImage-4a7d37e8.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/71954e6c3886/mount_1.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/89d5f0b5f58a/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21f2b8753d8bfc6bb816@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xe3fffb24000f33f5: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x1ffff92000799fa8-0x1ffff92000799faf]
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.2.0-syzkaller-02299-g4a7d37e824f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:__timerqueue_less lib/timerqueue.c:22 [inline]
RIP: 0010:rb_add_cached include/linux/rbtree.h:174 [inline]
RIP: 0010:timerqueue_add+0xf7/0x330 lib/timerqueue.c:40
Code: 48 c1 ea 03 42 80 3c 22 00 0f 85 c4 01 00 00 49 8b 17 48 85 d2 74 40 48 89 d3 e8 44 f1 c3 f7 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 ab 01 00 00 4c 8b 7b 18 4c 89 ef 4c 89 fe e8
RSP: 0018:ffffc900001e0da8 EFLAGS: 00010017
RAX: 03ffff24000f33f5 RBX: 1ffff92000799f95 RCX: 0000000000000000
RDX: ffff88813feb1d40 RSI: ffffffff89bdeb3c RDI: 1ffff92000799fad
RBP: ffff8880b992c0e0 R08: 0000000000000006 R09: 00000009dd72e480
R10: ffffc90003c9f5f8 R11: 0000000000000000 R12: dffffc0000000000
R13: 00000009dd72e480 R14: 0000000000000000 R15: ffffc90003ccfc58
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16907af000 CR3: 000000001de6d000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 enqueue_hrtimer+0x1aa/0x490 kernel/time/hrtimer.c:1091
 __run_hrtimer kernel/time/hrtimer.c:1702 [inline]
 __hrtimer_run_queues+0xc71/0x1010 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x320/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1096 [inline]
 __sysvec_apic_timer_interrupt+0x180/0x660 arch/x86/kernel/apic/apic.c:1113
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x40/0x50 drivers/acpi/processor_idle.c:113
Code: eb 03 83 e3 01 89 de 0f 1f 44 00 00 84 db 75 1b 0f 1f 44 00 00 eb 0c 0f 1f 44 00 00 0f 00 2d e7 5a a8 00 0f 1f 44 00 00 fb f4 <fa> 5b c3 cc 0f 1f 00 66 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 0f
RSP: 0018:ffffc90000177d10 EFLAGS: 00000246
RAX: ffff88813feb1d40 RBX: 0000000000000000 RCX: ffffffff8a096b45
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880179b1864 R08: 0000000000000001 R09: ffff8880b993606b
R10: ffffed1017326c0d R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880179b1800 R14: ffff8880179b1864 R15: 0000000000000000
 acpi_idle_do_entry+0x53/0x70 drivers/acpi/processor_idle.c:573
 acpi_idle_enter+0x173/0x290 drivers/acpi/processor_idle.c:711
 cpuidle_enter_state+0xd3/0x6f0 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x348/0x440 kernel/sched/idle.c:282
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 start_secondary+0x256/0x300 arch/x86/kernel/smpboot.c:264
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__timerqueue_less lib/timerqueue.c:22 [inline]
RIP: 0010:rb_add_cached include/linux/rbtree.h:174 [inline]
RIP: 0010:timerqueue_add+0xf7/0x330 lib/timerqueue.c:40
Code: 48 c1 ea 03 42 80 3c 22 00 0f 85 c4 01 00 00 49 8b 17 48 85 d2 74 40 48 89 d3 e8 44 f1 c3 f7 48 8d 7b 18 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 ab 01 00 00 4c 8b 7b 18 4c 89 ef 4c 89 fe e8
RSP: 0018:ffffc900001e0da8 EFLAGS: 00010017

RAX: 03ffff24000f33f5 RBX: 1ffff92000799f95 RCX: 0000000000000000
RDX: ffff88813feb1d40 RSI: ffffffff89bdeb3c RDI: 1ffff92000799fad
RBP: ffff8880b992c0e0 R08: 0000000000000006 R09: 00000009dd72e480
R10: ffffc90003c9f5f8 R11: 0000000000000000 R12: dffffc0000000000
R13: 00000009dd72e480 R14: 0000000000000000 R15: ffffc90003ccfc58
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16907af000 CR3: 000000001de6d000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	42 80 3c 22 00       	cmpb   $0x0,(%rdx,%r12,1)
   9:	0f 85 c4 01 00 00    	jne    0x1d3
   f:	49 8b 17             	mov    (%r15),%rdx
  12:	48 85 d2             	test   %rdx,%rdx
  15:	74 40                	je     0x57
  17:	48 89 d3             	mov    %rdx,%rbx
  1a:	e8 44 f1 c3 f7       	callq  0xf7c3f163
  1f:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 ab 01 00 00    	jne    0x1e0
  35:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
  39:	4c 89 ef             	mov    %r13,%rdi
  3c:	4c 89 fe             	mov    %r15,%rsi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
