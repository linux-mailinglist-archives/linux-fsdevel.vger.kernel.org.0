Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0940810C531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfK1IfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 03:35:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54275 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfK1IfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:35:08 -0500
Received: by mail-il1-f197.google.com with SMTP id t4so2972720ili.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 00:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QmXjKv7M6nqqNmvXkPQVCxOuNV7WKnfrtoxgOJfZtEg=;
        b=bKznaa+41vwJArUMKnchVUIYK9fTgwf78rHokdRsGLa4v4THIub08HREIYmsFF8zrO
         2ljqSmqO3o39BoC1c0MB9K6v4H5MeC4FNrIFc4Nar2Zl1sJzNE78Qg/z7m824xuxKrkW
         FfQKC86Lmr5wVqsfYCiDqlQjx6D6ScZgZEQIBGRHbDQmABslnf13sdZDC40Ipq+rug3S
         6foFScUwKhv+OXWkUGVEsgpjPoWd8kcXvNPWG4LxJlYmLrz4iH0qWihrmvbCi4A5j524
         mpoVFApT6PWYUZZmxfsQQZk/m9kfBh0bYICkRHc1HuRkNVHm6jYv5M9e9TKFAIxhIJ4Y
         PISQ==
X-Gm-Message-State: APjAAAWtupyz+jJNL7FLlkBhs3UOWO7yO2OGlF29KVv4BTLSkrMzKGFI
        ZR1N/VUDYXhsTSinOODMN8Ufvf17zuVDUHaaaQSK/PE/zzzO
X-Google-Smtp-Source: APXvYqyIdgOCA0tuO0n5sRaQO4ovvnXCrdNxvvCn5ZCYA3AFUqqTSZv0ESezVrAUMbRRI59XhfsRRJcVIR56gUdy044LYXfMmHgp
MIME-Version: 1.0
X-Received: by 2002:a6b:ea05:: with SMTP id m5mr26928063ioc.109.1574930107809;
 Thu, 28 Nov 2019 00:35:07 -0800 (PST)
Date:   Thu, 28 Nov 2019 00:35:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f46d4059863fdea@google.com>
Subject: INFO: trying to register non-static key in io_cqring_overflow_flush
From:   syzbot <syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com>
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

HEAD commit:    d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145e5fcee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f2051e3d8cdb3f
dashboard link: https://syzkaller.appspot.com/bug?extid=be9e13497969768c0e6e
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146c517ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16550b12e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be9e13497969768c0e6e@syzkaller.appspotmail.com

RSP: 002b:00007ffc426dee68 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441259
RDX: 0000000000000002 RSI: 00000000200005c0 RDI: 0000000000000df3
RBP: 00007ffc426dee80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 7968 Comm: syz-executor745 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
  register_lock_class+0x6ec/0xea0 kernel/locking/lockdep.c:443
  __lock_acquire+0x116/0x1be0 kernel/locking/lockdep.c:3837
  lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4485
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xa1/0xc0 kernel/locking/spinlock.c:159
  __wake_up_common_lock kernel/sched/wait.c:122 [inline]
  __wake_up+0xb8/0x150 kernel/sched/wait.c:142
  io_cqring_ev_posted fs/io_uring.c:637 [inline]
  io_cqring_overflow_flush+0x7bc/0xa80 fs/io_uring.c:684
  io_ring_ctx_wait_and_kill+0x4c6/0xb10 fs/io_uring.c:4344
  io_uring_create fs/io_uring.c:4681 [inline]
  io_uring_setup fs/io_uring.c:4707 [inline]
  __do_sys_io_uring_setup fs/io_uring.c:4720 [inline]
  __se_sys_io_uring_setup+0x1ccb/0x2490 fs/io_uring.c:4717
  __x64_sys_io_uring_setup+0x5b/0x70 fs/io_uring.c:4717
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441259
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc426dee68 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441259
RDX: 0000000000000002 RSI: 00000000200005c0 RDI: 0000000000000df3
RBP: 00007ffc426dee80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7968 Comm: syz-executor745 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0x2bf/0x4d0 kernel/sched/wait.c:87
Code: e8 d6 91 57 00 48 ba 00 00 00 00 00 fc ff df eb 43 66 2e 0f 1f 84 00  
00 00 00 00 4c 89 e3 4d 8d 74 24 e8 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 74  
12 48 89 df e8 c3 91 57 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffff8880915afb78 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000003 RDI: ffff888093164120
RBP: ffff8880915afbd0 R08: 0000000000000000 R09: ffff8880915afbe8
R10: ffffed10122b5f6f R11: 0000000000000000 R12: 0000000000000000
R13: ffff888093164158 R14: ffffffffffffffe8 R15: ffff8880915afbe8
FS:  0000000001aed880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200005c0 CR3: 000000009328e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_common_lock kernel/sched/wait.c:123 [inline]
  __wake_up+0xd3/0x150 kernel/sched/wait.c:142
  io_cqring_ev_posted fs/io_uring.c:637 [inline]
  io_cqring_overflow_flush+0x7bc/0xa80 fs/io_uring.c:684
  io_ring_ctx_wait_and_kill+0x4c6/0xb10 fs/io_uring.c:4344
  io_uring_create fs/io_uring.c:4681 [inline]
  io_uring_setup fs/io_uring.c:4707 [inline]
  __do_sys_io_uring_setup fs/io_uring.c:4720 [inline]
  __se_sys_io_uring_setup+0x1ccb/0x2490 fs/io_uring.c:4717
  __x64_sys_io_uring_setup+0x5b/0x70 fs/io_uring.c:4717
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441259
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc426dee68 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441259
RDX: 0000000000000002 RSI: 00000000200005c0 RDI: 0000000000000df3
RBP: 00007ffc426dee80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d0de30dce4e623c2 ]---
RIP: 0010:__wake_up_common+0x2bf/0x4d0 kernel/sched/wait.c:87
Code: e8 d6 91 57 00 48 ba 00 00 00 00 00 fc ff df eb 43 66 2e 0f 1f 84 00  
00 00 00 00 4c 89 e3 4d 8d 74 24 e8 4c 89 e0 48 c1 e8 03 <80> 3c 10 00 74  
12 48 89 df e8 c3 91 57 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffff8880915afb78 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000003 RDI: ffff888093164120
RBP: ffff8880915afbd0 R08: 0000000000000000 R09: ffff8880915afbe8
R10: ffffed10122b5f6f R11: 0000000000000000 R12: 0000000000000000
R13: ffff888093164158 R14: ffffffffffffffe8 R15: ffff8880915afbe8
FS:  0000000001aed880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200005c0 CR3: 000000009328e000 CR4: 00000000001406f0
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
