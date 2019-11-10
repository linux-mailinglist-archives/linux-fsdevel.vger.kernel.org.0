Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFFF680A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfKJJEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 04:04:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50050 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfKJJEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 04:04:09 -0500
Received: by mail-il1-f198.google.com with SMTP id c2so13317858ilj.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 01:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+8ZnohStVkL6tapO0JWTtDMt8kk/Lc635P0c1MxZABA=;
        b=qqGjYE3rYmmKPQnpwHWE21vESlkwWB3NO1tEgUoMsXySa4s1WQMryVARBVi+4xiI5y
         +qsaw2gN8Q/7JN4bo531icJNiTBE6oeIIab/5mz8sczCof8xm4KVWVNDzMq5b8CeTdWz
         zQSTdNuDZyJRayhuCIKr/wLwlfSGkMJ3LFKKuf72Rxte9sD+nEehJEkd9QjegyxE8OlG
         ooV9B75DNacx12CkKC9y/FBtQAWYsJnpaL8yOV34AaxUfNPCx4XGcCrWaxZMsODbigEo
         RdI73MqwjNsVwXUBJ0dNJNv8FNhuV8QzBFUxmx7E9x+ddAoVitpbFqCg2EVkSKQfdojB
         9weg==
X-Gm-Message-State: APjAAAUST8RbE1bplKwD2sfq025CESHtAMKwuVPs9K+XEQ3x/EQNL7Ho
        lBSfCLNpvPPa94h9dFRKqCptbtbfkORsKF6UG7XHQ/Zy5hLZ
X-Google-Smtp-Source: APXvYqy+AUqg0wSDZpVB9rBKoOGN6mwXueF3kL6EZqJOUJOzS2PLb8Q4d1jrez3tl2/CGtb1vjfX8OG4rblTD+NhDrEaGBDP2DsH
MIME-Version: 1.0
X-Received: by 2002:a6b:e403:: with SMTP id u3mr20170199iog.130.1573376648171;
 Sun, 10 Nov 2019 01:04:08 -0800 (PST)
Date:   Sun, 10 Nov 2019 01:04:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003659ef0596fa4cae@google.com>
Subject: KASAN: invalid-free in io_sqe_files_unregister
From:   syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>
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

HEAD commit:    5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=176bdbece00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com

RBP: 0000000000000005 R08: 0000000000000001 R09: 00007ffd5b970032
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000401ef0
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
==================================================================
BUG: KASAN: double-free or invalid-free in  
io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185

CPU: 1 PID: 8819 Comm: syz-executor452 Not tainted 5.4.0-rc6-next-20191108  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
  __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:450
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
  io_ring_ctx_free fs/io_uring.c:3998 [inline]
  io_ring_ctx_wait_and_kill+0x348/0x700 fs/io_uring.c:4060
  io_uring_release+0x42/0x50 fs/io_uring.c:4068
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  __do_sys_exit_group kernel/exit.c:932 [inline]
  __se_sys_exit_group kernel/exit.c:930 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43f2c8
Code: 31 b8 c5 f7 ff ff 48 8b 5c 24 28 48 8b 6c 24 30 4c 8b 64 24 38 4c 8b  
6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 48 83 c4 58 c3 66 <0f> 1f 84 00 00  
00 00 00 48 8d 35 59 ca 00 00 0f b6 d2 48 89 fb 48
RSP: 002b:00007ffd5b976008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f2c8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf0a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8819:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc_array include/linux/slab.h:598 [inline]
  kcalloc include/linux/slab.h:609 [inline]
  io_sqe_files_register fs/io_uring.c:3373 [inline]
  __io_uring_register+0x11d4/0x3120 fs/io_uring.c:4474
  __do_sys_io_uring_register fs/io_uring.c:4526 [inline]
  __se_sys_io_uring_register fs/io_uring.c:4508 [inline]
  __x64_sys_io_uring_register+0x1a1/0x570 fs/io_uring.c:4508
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8819:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  io_sqe_files_register fs/io_uring.c:3379 [inline]
  __io_uring_register+0x13a7/0x3120 fs/io_uring.c:4474
  __do_sys_io_uring_register fs/io_uring.c:4526 [inline]
  __se_sys_io_uring_register fs/io_uring.c:4508 [inline]
  __x64_sys_io_uring_register+0x1a1/0x570 fs/io_uring.c:4508
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a7619140
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8880a7619140, ffff8880a7619160)
The buggy address belongs to the page:
page:ffffea00029d8640 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a7619fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00025b2488 ffffea0002975c88 ffff8880aa4001c0
raw: ffff8880a7619fc1 ffff8880a7619000 0000000100000024 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a7619000: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8880a7619080: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8880a7619100: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                            ^
  ffff8880a7619180: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8880a7619200: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
