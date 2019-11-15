Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDBFE002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKOOZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 09:25:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40410 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:25:10 -0500
Received: by mail-io1-f72.google.com with SMTP id 125so7143446iou.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2019 06:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lxkXlVLoGVYo2mh4UfRD7P/UmW4civy6UhUV9/JR4H8=;
        b=ulRKr5XIhTaTEqrufkli9q5lmnU3qe/VbDe/LehisVopJKbGmSn3+dFZAsifa5R5m1
         AJoOyfaKbJCHb6VGQd19gYrKP9DM+aI0ujAATbzgc52Gds2F0tfqNRvr5EYlxc1HEzZT
         P8eiVQFdBHNbydrZCPL0nl6MRYf6QzN+WH78PH2q3EufNoLl9SHB+WtjunGW7+gKq+4q
         tNFRdXtQsLDRxhFmHT+3tWcFAUMffvH9X48vOvhQvanDYQssNFMA2kL8qQcBhuAvl4gV
         L0ZC0X0OJgTM/kH5F1wQi+qz6badgHYqHHuJeTVWbKr6NiUQjkG+4PnMPu2poBQfOkUm
         U8rg==
X-Gm-Message-State: APjAAAVVPOb6LFUfacSHFOLojZ2S2iukZbURA7B+L6X2U5DOOxzJQJXa
        5vpsDK0Jh26bCLXDXDJvdMXLukk+1OKxmE2a/f/RHeTFgUAQ
X-Google-Smtp-Source: APXvYqwOJZGWBJ+V5csDW8r1NvZnPZP66gDi94EjxkwAQJHxz/SZTVmjmcOvZo+k9P1loi6HdYThj+89+MYOiYBcJioPBdt7X/gC
MIME-Version: 1.0
X-Received: by 2002:a02:370e:: with SMTP id r14mr876881jar.87.1573827908910;
 Fri, 15 Nov 2019 06:25:08 -0800 (PST)
Date:   Fri, 15 Nov 2019 06:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072cb6c0597635d04@google.com>
Subject: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a6fcbea Add linux-next specific files for 20191115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a3053ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eac90e6ae4ab399
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157e60cee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com

RSP: 002b:00007ffc38b497f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00007ffc38b49810 RCX: 000000000045a659
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000fcc
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001ffc914
R13: 00000000004c1d50 R14: 00000000004d5a58 R15: 0000000000000003
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 8724 Comm: syz-executor.0 Not tainted 5.4.0-rc7-next-20191115 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  __wake_up_common_lock+0xc8/0x150 kernel/sched/wait.c:122
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  io_cqring_ev_posted+0xaa/0x120 fs/io_uring.c:629
  io_cqring_overflow_flush+0x6d4/0xa90 fs/io_uring.c:676
  io_ring_ctx_wait_and_kill+0x27a/0x810 fs/io_uring.c:4291
  io_uring_create fs/io_uring.c:4628 [inline]
  io_uring_setup+0x1264/0x1cd0 fs/io_uring.c:4654
  __do_sys_io_uring_setup fs/io_uring.c:4667 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:4664 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4664
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a659
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc38b497f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00007ffc38b49810 RCX: 000000000045a659
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000fcc
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001ffc914
R13: 00000000004c1d50 R14: 00000000004d5a58 R15: 0000000000000003
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8724 Comm: syz-executor.0 Not tainted 5.4.0-rc7-next-20191115 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff8880a607fb00 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880896b2920 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff1391616 RDI: 0000000000000000
RBP: ffff8880a607fb58 R08: ffffffffffffffe8 R09: ffff8880a607fba8
R10: ffffed1014c0ff59 R11: 0000000000000003 R12: 0000000000000001
R13: 0000000000000282 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000001ffc940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000480 CR3: 000000009ab99000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_common_lock+0xea/0x150 kernel/sched/wait.c:123
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  io_cqring_ev_posted+0xaa/0x120 fs/io_uring.c:629
  io_cqring_overflow_flush+0x6d4/0xa90 fs/io_uring.c:676
  io_ring_ctx_wait_and_kill+0x27a/0x810 fs/io_uring.c:4291
  io_uring_create fs/io_uring.c:4628 [inline]
  io_uring_setup+0x1264/0x1cd0 fs/io_uring.c:4654
  __do_sys_io_uring_setup fs/io_uring.c:4667 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:4664 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:4664
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a659
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc38b497f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 00007ffc38b49810 RCX: 000000000045a659
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000fcc
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001ffc914
R13: 00000000004c1d50 R14: 00000000004d5a58 R15: 0000000000000003
Modules linked in:
---[ end trace f5866fc8a39bc759 ]---
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff8880a607fb00 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880896b2920 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff1391616 RDI: 0000000000000000
RBP: ffff8880a607fb58 R08: ffffffffffffffe8 R09: ffff8880a607fba8
R10: ffffed1014c0ff59 R11: 0000000000000003 R12: 0000000000000001
R13: 0000000000000282 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000001ffc940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000480 CR3: 000000009ab99000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
