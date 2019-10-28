Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0690EE6D24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 08:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfJ1HWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 03:22:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45698 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfJ1HWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:22:09 -0400
Received: by mail-io1-f69.google.com with SMTP id q6so7456391ios.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 00:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UTMie8PkzK5wS7wiHXSMYFWr16Um/IYsiISWD8xfTF8=;
        b=ht8ve5z71O4ArqAGTM+NeW+7PN7YXp73CLElD0yI2OSTwutwUVVsBTg1hK07eUUS0o
         OnHVBAKAFtghTLbLKOED61GNLPQHGw9ohXsSAYKfK2ulGPkHW9rlKUFEaGGzlewZ38LT
         5AWYlUGkjLClCRthkwaVQg6YMtvNXHLsizvZTK00ZKLYiTtkRmvg+4aziES1mx1TaPkC
         BUkvlSliMnFIV/sbPMzvHzhfBwT6pJrYKYQfC7Nhro8nu6aBC95rP39+8xbYTYZ3wFb5
         o9JrcHnbAjEDr70Z3w/fiwfBO0LwZ4PyND1MZ4H0at/j8qOqXo26GZXZBim51/OGjRIl
         ezzw==
X-Gm-Message-State: APjAAAWMdNuZK1/NXwdVqnZtJoHkYjccsLkHMs9LBcNCc6j+yngoCMg8
        zigDNsNmqPXv/58mCbuAGEeU0yHe5e/rYixLka3IXyOo9ioS
X-Google-Smtp-Source: APXvYqyjnPdfn3CdjHyInJVCwZZ8j26hi12GlxQnoYj74BdqdbCdpi7IjZ0jDDmXtV+Sf0ZDU8zXLudLzwnJ4P1QPrQ9A1VWDGeF
MIME-Version: 1.0
X-Received: by 2002:a5d:8d8f:: with SMTP id b15mr16379107ioj.296.1572247328016;
 Mon, 28 Oct 2019 00:22:08 -0700 (PDT)
Date:   Mon, 28 Oct 2019 00:22:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c4f500595f35bf4@google.com>
Subject: KASAN: use-after-free Read in io_uring_setup
From:   syzbot <syzbot+6f03d895a6cd0d06187f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a1e843c Merge tag 'mips_fixes_5.4_3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e2001f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=420126a10fdda0f1
dashboard link: https://syzkaller.appspot.com/bug?extid=6f03d895a6cd0d06187f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d4fa97600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f03d895a6cd0d06187f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in io_uring_create fs/io_uring.c:3842 [inline]
BUG: KASAN: use-after-free in io_uring_setup+0x1877/0x18c0  
fs/io_uring.c:3881
Read of size 8 at addr ffff888082284048 by task syz-executor.5/11342

CPU: 1 PID: 11342 Comm: syz-executor.5 Not tainted 5.4.0-rc4+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  io_uring_create fs/io_uring.c:3842 [inline]
  io_uring_setup+0x1877/0x18c0 fs/io_uring.c:3881
  __do_sys_io_uring_setup fs/io_uring.c:3894 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:3891 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:3891
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459f39
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f313e126c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000459f39
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 000000040000000e
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f313e1276d4
R13: 00000000004c1512 R14: 00000000004d4da8 R15: 00000000ffffffff

Allocated by task 11342:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3550
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  io_ring_ctx_alloc fs/io_uring.c:393 [inline]
  io_uring_create fs/io_uring.c:3811 [inline]
  io_uring_setup+0xec6/0x18c0 fs/io_uring.c:3881
  __do_sys_io_uring_setup fs/io_uring.c:3894 [inline]
  __se_sys_io_uring_setup fs/io_uring.c:3891 [inline]
  __x64_sys_io_uring_setup+0x54/0x80 fs/io_uring.c:3891
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11335:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  io_ring_ctx_free fs/io_uring.c:3552 [inline]
  io_ring_ctx_wait_and_kill+0x4d7/0x6c0 fs/io_uring.c:3592
  io_uring_release+0x42/0x50 fs/io_uring.c:3600
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888082284000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 72 bytes inside of
  2048-byte region [ffff888082284000, ffff888082284800)
The buggy address belongs to the page:
page:ffffea000208a100 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002a1bc88 ffffea00023fa248 ffff8880aa400e00
raw: 0000000000000000 ffff888082284000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888082283f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888082283f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888082284000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff888082284080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888082284100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
