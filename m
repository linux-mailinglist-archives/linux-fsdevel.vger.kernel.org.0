Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD78DD6BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 07:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfJSFXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 01:23:10 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48371 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfJSFXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 01:23:09 -0400
Received: by mail-il1-f200.google.com with SMTP id d15so2856172iln.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2019 22:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0KNjLuEPgiDLg6oET9WRUGpjddnu/sNONOWUjhZ/J7E=;
        b=PoMsnqvJyXgqvWfHKSOyMG+mLtmDIspGeNNqXLOxhe54p/P6htb/UhlHhGCOqmgo5E
         1YxfOnJD0rqPuCOWq/HwGXv8zGeKPFj6n6EPFzThpSghfcTEhTwjfV4X0zTio7H8U9Vw
         gwAePUiVVOoxe0AIKdQkmZOxvPc8X+FZGFl5LgPqc/+TJGhPwi7uZMRbGTfwQuk4t6b2
         dpRDlYXpQt7Vv9Rp8b6Ot5HQLVUn2np1iztqfQaGRdsdJHiKEga8DHSH9QaxbaB/g+2p
         pwPja7UzsvsUw/oGt6cpw+yt5dhSxkW6FfoChwdWQ2bpeYdBu8iLLakrd6qBN2fWuU6h
         Pr2A==
X-Gm-Message-State: APjAAAViXooQwxmD4VCGo4JfXLpRItPgnd3AbGW2dZb78kYVp4nWy8wC
        s1x3ftqSkch3F//oJuE/D1vCCDl3LqXf0P7MAtvmaQw3JzcD
X-Google-Smtp-Source: APXvYqy9aGv6CB4zhJa7/C44XCiINnaznRSe2UdcpIcJFzhqLwvWmY8TeIzFTyYMYhiSHxSa8uC6kParUuf8rO0R/GPf887dgYNB
MIME-Version: 1.0
X-Received: by 2002:a5d:9856:: with SMTP id p22mr12053973ios.29.1571462588703;
 Fri, 18 Oct 2019 22:23:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:23:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060ad7d05953ca54f@google.com>
Subject: KASAN: use-after-free Read in fuse_request_end
From:   syzbot <syzbot+ae0bb7aae3de6b4594e2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    283ea345 coccinelle: api/devm_platform_ioremap_resource: r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13afce90e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extid=ae0bb7aae3de6b4594e2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14018fa0e00000

The bug was bisected to:

commit d49937749fef2597f6bcaf2a0ed67e88e347b7fb
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue Sep 10 13:04:11 2019 +0000

     fuse: stop copying args to fuse_req

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16110927600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15110927600000
console output: https://syzkaller.appspot.com/x/log.txt?x=11110927600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae0bb7aae3de6b4594e2@syzkaller.appspotmail.com
Fixes: d49937749fef ("fuse: stop copying args to fuse_req")

==================================================================
BUG: KASAN: use-after-free in fuse_request_end+0x825/0x990 fs/fuse/dev.c:279
Read of size 8 at addr ffff8880a15b8468 by task syz-executor.0/8726

CPU: 0 PID: 8726 Comm: syz-executor.0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  fuse_request_end+0x825/0x990 fs/fuse/dev.c:279
  fuse_dev_do_read.isra.0+0x115b/0x1df0 fs/fuse/dev.c:1295
  fuse_dev_read+0x165/0x200 fs/fuse/dev.c:1328
  call_read_iter include/linux/fs.h:1889 [inline]
  new_sync_read+0x4d7/0x800 fs/read_write.c:414
  __vfs_read+0xe1/0x110 fs/read_write.c:427
  vfs_read+0x1f0/0x440 fs/read_write.c:461
  ksys_read+0x14f/0x290 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read fs/read_write.c:595 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:595
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f764c086c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
RDX: 00000000fffffed0 RSI: 00000000200030c0 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f764c0876d4
R13: 00000000004c70e6 R14: 00000000004dca70 R15: 00000000ffffffff

Allocated by task 8726:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3550
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  fuse_send_init+0x48/0x440 fs/fuse/inode.c:974
  fuse_fill_super+0x2a6/0x3a0 fs/fuse/inode.c:1257
  vfs_get_super+0x13e/0x2e0 fs/super.c:1189
  get_tree_nodev+0x23/0x30 fs/super.c:1219
  fuse_get_tree+0x12e/0x190 fs/fuse/inode.c:1282
  vfs_get_tree+0x8e/0x300 fs/super.c:1545
  do_new_mount fs/namespace.c:2823 [inline]
  do_mount+0x143d/0x1d10 fs/namespace.c:3143
  ksys_mount+0xdb/0x150 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8724:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3756
  process_init_reply+0xfb/0x1620 fs/fuse/inode.c:964
  fuse_request_end+0x388/0x990 fs/fuse/dev.c:326
  end_requests+0x16c/0x240 fs/fuse/dev.c:2049
  fuse_abort_conn+0xa4d/0xdb0 fs/fuse/dev.c:2144
  fuse_sb_destroy+0xa3/0x120 fs/fuse/inode.c:1325
  fuse_kill_sb_anon+0x16/0x30 fs/fuse/inode.c:1336
  deactivate_locked_super+0x95/0x100 fs/super.c:335
  deactivate_super fs/super.c:366 [inline]
  deactivate_super+0x1b2/0x1d0 fs/super.c:362
  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a15b8400
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 104 bytes inside of
  192-byte region [ffff8880a15b8400, ffff8880a15b84c0)
The buggy address belongs to the page:
page:ffffea0002856e00 refcount:1 mapcount:0 mapping:ffff8880aa400000  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000286d508 ffffea000285ba48 ffff8880aa400000
raw: 0000000000000000 ffff8880a15b8000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a15b8300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a15b8380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8880a15b8400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff8880a15b8480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880a15b8500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
