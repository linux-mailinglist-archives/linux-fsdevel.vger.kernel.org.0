Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7A77A565
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjHMHYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 03:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjHMHYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:24:13 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CBC1710
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 00:24:13 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-564fa3b49e1so3413861a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 00:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691911452; x=1692516252;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZDNLf1x53mQ0m7AfzRC5QKLe+W/WZUAtVRBH4vOaqU=;
        b=Vi7B2NDoyttraqP2zxncG45DI3dgq8a5jqXunWjQ7umwqo5i7A7LzOWNgYmPki2KAT
         S4GpKY6NcEmlzpyvV1zfSzrw8JxT+tzOBkELvEQFSkRepb80dACAd63+lHV144JcH0Id
         CBwVgOOogB8X48Bw5VxbiycV5yzcu92ztoi6EBXdWzsyfgTbrI+v9VXgrVbimhoH8IOi
         upp5DAsH/Q1M/lb+iYc1RST6svhMrCeuh2VPm5wy94xKqqaUEAGiyk2PmXs2Lbqw8C/t
         ZsfIV1qlTGQB8RxXS6Gc7ZEMu6FL94a8MCESZwbaIdpqAQGvi4xfUiVghhnDIwQsWwnP
         bwbQ==
X-Gm-Message-State: AOJu0YwuHJYTIc3fTSfuLIRTGkpR9pfpSUZKqZhVbjn/o7cbAqVWvD6h
        PlXpR+9UQytsz7ZMaF5dgkGwJ3naaMDoolKJKN2Ut/3PmC4W
X-Google-Smtp-Source: AGHT+IHisSxAI0yURuRrjduklifwHsqlp0NIqF/tB6lRL3gAU/UHYKwzfNV5o0bPVPVnfREXasqCxkniWNxjDk22g7fQheD2sDZQ
MIME-Version: 1.0
X-Received: by 2002:a63:3e48:0:b0:564:6e43:a00d with SMTP id
 l69-20020a633e48000000b005646e43a00dmr1088913pga.3.1691911452735; Sun, 13 Aug
 2023 00:24:12 -0700 (PDT)
Date:   Sun, 13 Aug 2023 00:24:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021c1240602c8d549@google.com>
Subject: [syzbot] [dri?] [reiserfs?] WARNING: bad unlock balance in vkms_vblank_simulate
From:   syzbot <syzbot+5671b8bcd5178fe56c23@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, melissa.srw@gmail.com,
        reiserfs-devel@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    71cd4fc492ec Add linux-next specific files for 20230808
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11faa1eda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e36b5ba725f7349d
dashboard link: https://syzkaller.appspot.com/bug?extid=5671b8bcd5178fe56c23
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a54d0ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e2281ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ea26a69f422/disk-71cd4fc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4a6b00863bf/vmlinux-71cd4fc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/888c2025ec30/bzImage-71cd4fc4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3620b064e309/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5671b8bcd5178fe56c23@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.5.0-rc5-next-20230808-syzkaller #0 Not tainted
-------------------------------------
swapper/0/0 is trying to release lock (&vkms_out->enabled_lock) at:
[<ffffffff852badf9>] vkms_vblank_simulate+0x159/0x3d0 drivers/gpu/drm/vkms/vkms_crtc.c:34
but there are no more locks to release!

other info that might help us debug this:
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc5-next-20230808-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5438 [inline]
 lock_release+0x4b5/0x680 kernel/locking/lockdep.c:5781
 __mutex_unlock_slowpath+0xa3/0x640 kernel/locking/mutex.c:907
 vkms_vblank_simulate+0x159/0x3d0 drivers/gpu/drm/vkms/vkms_crtc.c:34
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1098 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 bc 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 57 9d 99 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
RSP: 0000:ffffffff8c607d70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a3a232e
RDX: 0000000000000001 RSI: ffff888144e77800 RDI: ffff888144e77864
RBP: ffff888144e77864 R08: 0000000000000001 R09: ffffed1017306dbd
R10: ffff8880b9836deb R11: 0000000000000000 R12: ffff888141ed8000
R13: ffffffff8d45c680 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x315/0x3f0 kernel/sched/idle.c:282
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 rest_init+0x16f/0x2b0 init/main.c:726
 arch_call_rest_init+0x13/0x30 init/main.c:823
 start_kernel+0x39f/0x480 init/main.c:1068
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
 secondary_startup_64_no_verify+0x167/0x16b
 </TASK>
----------------
Code disassembly (best guess):
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 c0 bc 	mov    %gs:0x3bcc0,%rax
  16:	03 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d 57 9d 99 00 	verw   0x999d57(%rip)        # 0x999d7f
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffdf


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
