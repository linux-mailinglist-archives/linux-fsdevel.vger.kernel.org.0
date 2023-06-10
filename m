Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85372AA75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjFJJHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFJJHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:07:54 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B835B8
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 02:07:46 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76998d984b0so308179939f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 02:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686388065; x=1688980065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0B2vhwcG3TjAarUne3TdG9PP1BraNq+rl4mOu6ZY2w=;
        b=BjRzdwlnb+6I1uwn9xul9r4bWbVPwYEl/+UuwblXKUade/hdhh9pzUu9tKIxw0xY+L
         UyPSt6IyePEiFcQCU7/3NzvIztzEIJaXF1rJi9RKfQXccs5TfO/yjOsqTbVyjh4WFfn4
         he2n5nU8tS6FIfZavtzFM5RYTOgeemWCrwbq3uS1u1mWdQ8eym/maGN01Y6fTU0D1lIL
         hBJ5H5J1WvPhiYHqvG9ia2jxlZnNqD+VMSB/WAOReSBRNKmTCM1WjS3leekvxZ++ZW4q
         PDWJdocmtgA2s3tb/pBsXOzJd6388Zd1KmfcZf0T2t5A28MpO7SbpzueuF0z/g8+YM42
         4VEQ==
X-Gm-Message-State: AC+VfDwNqVVtKccvfFpTm4j3ZIqgws86LUpx8Mogd6cfztWSiULQviMN
        /Kbrx6aYyesmIZfytXvwPT+pVcE/U7bfM3xvuR0DtWwXuejx
X-Google-Smtp-Source: ACHHUZ6yIsJmK16yg6BlhmEwJ+nn1ZfEEu8EY9smVvqCPkvSTVVvY4CRuArn6xaHBrJ7gI71nUt5fst2NCCODuFQZJZ4xay1SywU
MIME-Version: 1.0
X-Received: by 2002:a92:daca:0:b0:339:80e9:794 with SMTP id
 o10-20020a92daca000000b0033980e90794mr1941561ilq.3.1686388065388; Sat, 10 Jun
 2023 02:07:45 -0700 (PDT)
Date:   Sat, 10 Jun 2023 02:07:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009752a005fdc2d114@google.com>
Subject: [syzbot] [tomoyo?] [fs?] INFO: rcu detected stall in newfstatat (3)
From:   syzbot <syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        takedakn@nttdata.co.jp, tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d37537a1f7cf Merge 6.4-rc5 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15d9b771280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e12d6d7f5296037
dashboard link: https://syzkaller.appspot.com/bug?extid=96127c74434e19e4609d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d7959280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bcb6b5280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/752b1860c3b6/disk-d37537a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9c9f2751b2/vmlinux-d37537a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf7433b7dd12/bzImage-d37537a1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96127c74434e19e4609d@syzkaller.appspotmail.com

imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (6786 ticks this GP) idle=0174/1/0x4000000000000000 softirq=3297/3297 fqs=3
rcu: 	(t=10500 jiffies g=2493 q=87 ncpus=2)
CPU: 1 PID: 2476 Comm: udevd Not tainted 6.4.0-rc5-syzkaller-gd37537a1f7cf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 66 20 fe fa 48 89 ef e8 8e 8e fe fa 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 5f 4d f3 fa 65 8b 05 20 c9 d4 79 85 c0 74 0a 5b 5d c3 e8 2c d8
RSP: 0018:ffffc90000188b20 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff16a03a6
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
RBP: ffff888105ff4000 R08: 0000000000000001 R09: ffffffff8b4ca8d7
R10: 0000000000000001 R11: 0000000000056001 R12: ffff8881063fd440
R13: ffff8881231c7d00 R14: dffffc0000000000 R15: ffff888107e9f900
FS:  00007f51b4974c80(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f257a8dcfe4 CR3: 0000000121905000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 dummy_timer+0x1519/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:2001
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1c1/0x8e8 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu kernel/softirq.c:650 [inline]
 irq_exit_rcu+0x11b/0x190 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__slab_alloc_node mm/slub.c:3339 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3441 [inline]
RIP: 0010:__kmem_cache_alloc_node+0xdc/0x2d0 mm/slub.c:3490
Code: ff ff 31 c0 e9 03 01 00 00 45 31 ff 48 85 ed 74 f1 48 c7 44 24 10 00 00 00 00 48 8b 45 00 65 48 03 05 e0 b1 6d 7e 48 8b 50 08 <4c> 8b 00 48 8b 78 10 4d 85 c0 0f 84 88 01 00 00 48 85 ff 0f 84 7f
RSP: 0018:ffffc90001517918 EFLAGS: 00000282
RAX: ffff8881f673edb0 RBX: 0000000000000d40 RCX: 0000000000000001
RDX: 000000000001da29 RSI: 0000000000000d40 RDI: ffff888100041640
RBP: ffff888100041640 R08: 0000000000000001 R09: ffffffff8907fdd7
R10: 0000000000000000 R11: 0000000000056001 R12: 0000000000000d40
R13: 00000000ffffffff R14: 000000000000003c R15: 0000000000000000
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x2c/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x185/0x600 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x230/0x430 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x140 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x16e/0x430 fs/stat.c:242
 vfs_fstatat+0x90/0xb0 fs/stat.c:276
 __do_sys_newfstatat+0x8a/0x110 fs/stat.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51b4a9f5f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffcce828558 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000055c08bd08740 RCX: 00007f51b4a9f5f4
RDX: 00007ffcce828568 RSI: 00007ffcce8289f8 RDI: 00000000ffffff9c
RBP: 00007ffcce8285f8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcce8289f8
R13: 00007ffcce828568 R14: 000055c08bce9910 R15: 00007ffcce829709
 </TASK>
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored


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
