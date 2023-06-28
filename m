Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FD741C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 01:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjF1XGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 19:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjF1XGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:06:02 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E610FE
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 16:06:00 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39ec7630322so126812b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 16:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687993559; x=1690585559;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+HZZJTaP1niJAASeD1Z5YiUeNBbVaSIkYrwhZkkWGE=;
        b=ZAAHhjSOauUl+KnMd5Pts9G8wdtN/Vn91L1IJSC3P8Nvx4wjt6DoL3vOc5nXNzFmo2
         fYh6S0OaI+KlZqNTgPt+ngfgm8TH/YZnuREsCNoySN7jlquKkj5+Gv9Q//IcTokIkb9d
         IOX9zMHXa5guZEO0vp5FqpwC9rhIOIzR9m0VNIVSM6WFLqHC/4MAGXy7Cauyk3LVlg6N
         O5r9DUZETLzguaFe7/k6h+O/6XgraVxRyegNGD/xj0DPVgQnei1KWimOYn/xPs4NUI7+
         YJsJN/YhtKRsMVpZWsVOW5A1lFbThmgqepsGb9jBPa2YpXv1MozM6tirjj4cJdQwfPXP
         LBTg==
X-Gm-Message-State: AC+VfDxLZr5wp6Pz68vgfMCD9ukLbMAtOnAKk2iYdmsQXRdCTxKJWGAI
        m1wmGS6XYNMGYQZXviU0NHsgAoObN6DiPbfJMexy+Qyax3kRcEj9cA==
X-Google-Smtp-Source: ACHHUZ45uBzCfUUWpNuv+u0VAEYoN5K9kHXgLHorzGiwGb8GomNpLnMqlak7GVneuBrWBaRN+kdVdwjaMcPrpOvOZcySWavRKOcz
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1987:b0:3a0:6079:3201 with SMTP id
 bj7-20020a056808198700b003a060793201mr5356926oib.8.1687993559555; Wed, 28 Jun
 2023 16:05:59 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:05:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008023b805ff38a0af@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in __hrtimer_run_queues (3)
From:   syzbot <syzbot+f13a9546e229c1a6e378@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e8f75c0270d9 Merge tag 'x86_sgx_for_v6.5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13710670a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98ec7f738e43bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=f13a9546e229c1a6e378
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227af7b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13803daf280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f27c1d41217a/disk-e8f75c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/843ae5d5c810/vmlinux-e8f75c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da48bc4c0ec1/bzImage-e8f75c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/667a76526623/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f13a9546e229c1a6e378@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in lookup_object lib/debugobjects.c:195 [inline]
BUG: KASAN: global-out-of-bounds in debug_object_deactivate lib/debugobjects.c:785 [inline]
BUG: KASAN: global-out-of-bounds in debug_object_deactivate+0x27b/0x300 lib/debugobjects.c:771
Read of size 8 at addr ffffffff8a49cd78 by task kauditd/27

CPU: 1 PID: 27 Comm: kauditd Not tainted 6.4.0-syzkaller-01406-ge8f75c0270d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 lookup_object lib/debugobjects.c:195 [inline]
 debug_object_deactivate lib/debugobjects.c:785 [inline]
 debug_object_deactivate+0x27b/0x300 lib/debugobjects.c:771
 debug_hrtimer_deactivate kernel/time/hrtimer.c:427 [inline]
 debug_deactivate kernel/time/hrtimer.c:483 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1656 [inline]
 __hrtimer_run_queues+0x3f3/0xbe0 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1098 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 66 d4 8f 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 8b 05 3d 3a 7f 7e 89 c1 48 8b 34 24 81 e1 00 01 00
RSP: 0018:ffffc90000a3faa8 EFLAGS: 00000293

RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff88801724bb80 RSI: ffffffff81686965 RDI: 0000000000000007
RBP: ffffffff8d26a498 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 205d373254202020 R12: 0000000000000000
R13: ffffffff8d26a440 R14: dffffc0000000000 R15: 0000000000000001
 console_emit_next_record arch/x86/include/asm/irqflags.h:42 [inline]
 console_flush_all+0x61b/0xcc0 kernel/printk/printk.c:2933
 console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2307
 vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xbf/0xf0 kernel/printk/printk.c:2328
 kauditd_printk_skb kernel/audit.c:536 [inline]
 kauditd_hold_skb+0x1fb/0x240 kernel/audit.c:571
 kauditd_send_queue+0x220/0x280 kernel/audit.c:756
 kauditd_thread+0x617/0xaa0 kernel/audit.c:880
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

The buggy address belongs to the variable:
 ds.0+0x218/0x580

The buggy address belongs to the physical page:
page:ffffea0000292700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa49c
flags: 0xfff00000001000(reserved|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000001000 ffffea0000292708 ffffea0000292708 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8a49cc00: f9 f9 f9 f9 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9
 ffffffff8a49cc80: 07 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 05 f9 f9
>ffffffff8a49cd00: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 01 f9
                                                                ^
 ffffffff8a49cd80: f9 f9 f9 f9 00 00 00 00 00 00 00 00 06 f9 f9 f9
 ffffffff8a49ce00: f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	66 d4                	data16 (bad)
   2:	8f 02                	popq   (%rdx)
   4:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   a:	f3 0f 1e fa          	endbr64
   e:	48 8b be b0 01 00 00 	mov    0x1b0(%rsi),%rdi
  15:	e8 b0 ff ff ff       	callq  0xffffffca
  1a:	31 c0                	xor    %eax,%eax
  1c:	c3                   	retq
  1d:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  24:	00 00 00 00
  28:	66 90                	xchg   %ax,%ax
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	65 8b 05 3d 3a 7f 7e 	mov    %gs:0x7e7f3a3d(%rip),%eax        # 0x7e7f3a72
  35:	89 c1                	mov    %eax,%ecx
  37:	48 8b 34 24          	mov    (%rsp),%rsi
  3b:	81                   	.byte 0x81
  3c:	e1 00                	loope  0x3e
  3e:	01 00                	add    %eax,(%rax)


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
