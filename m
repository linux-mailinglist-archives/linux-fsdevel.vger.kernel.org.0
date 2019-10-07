Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA3CEF63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 01:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfJGXJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 19:09:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41155 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGXJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:09:08 -0400
Received: by mail-io1-f69.google.com with SMTP id q18so29178850ios.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 16:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qjh+eETl+41tYCUSOHGIN6nPQ7ssIlB3+VOdf56APo0=;
        b=eP4bflyPxP8DI8z9Aw09Jj7KqvVnCVY7khzu4GLeKA9yUsVOry1oSmQKNPd4qsjFgV
         veJAHPcSFUbgnN2ql8gWKj9/AUGiu/q7LAu3EX3tUXwjEHn/6tuW/O0ApGMZSSbsVotu
         xHXzHBxXEUpgtLAyy+DITMRAmo1WO5MfLi92Fc5ig+sArnPAZ1x2FZpbbgRBlRA7ayjV
         pj4998HviqDceWsd2yj7UMa6FnlY7/yRGZx9KQctBdpCSZy9iFXnfHCL+e/4Wv17B2UQ
         9X8Nyw+lUFuLUkKSE85EAZpitkzxFJ4u2GIMPCRSnyQtQ0p9Fp68gMV7BzZii7DpzXcv
         V+8g==
X-Gm-Message-State: APjAAAU74lmcvr8qRIel0YtdC/4VKUPGaVL8lmTy/Thd+hRV81nG/NaH
        Sp1t+BhXoEGyq4O+2smdC+LGrmMQ9m9Q14LfWzWaz8LvrtHO
X-Google-Smtp-Source: APXvYqy6UTt8scmptDTzOkN27+m9jET8mALR6/WfwFz+6ytuzfs/V5bLBfZq9KDTUMnvR9UBg4pZV+T3mRexb5GbF0vllogyS73l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e8:: with SMTP id s8mr28019921jaq.68.1570489747133;
 Mon, 07 Oct 2019 16:09:07 -0700 (PDT)
Date:   Mon, 07 Oct 2019 16:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000805e5505945a234b@google.com>
Subject: KASAN: use-after-free Read in do_mount
From:   syzbot <syzbot+da4f525235510683d855@syzkaller.appspotmail.com>
To:     anton@enomsg.org, arnd@arndb.de, ccross@android.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tony.luck@intel.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    311ef88a Add linux-next specific files for 20191004
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce4899600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db2e4361e48662f4
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f525235510683d855
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b672b9600000

The bug was bisected to:

commit 9d14545b05f9eed69fbd4af14b927a462324ea19
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Aug 30 16:12:15 2019 +0000

     Merge branch 'limits' of https://github.com/deepa-hub/vfs into y2038

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16eeee2b600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15eeee2b600000
console output: https://syzkaller.appspot.com/x/log.txt?x=11eeee2b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+da4f525235510683d855@syzkaller.appspotmail.com
Fixes: 9d14545b05f9 ("Merge branch 'limits' of  
https://github.com/deepa-hub/vfs into y2038")

==================================================================
BUG: KASAN: use-after-free in do_new_mount_fc fs/namespace.c:2773 [inline]
BUG: KASAN: use-after-free in do_new_mount fs/namespace.c:2825 [inline]
BUG: KASAN: use-after-free in do_mount+0x1b5f/0x1d10 fs/namespace.c:3143
Read of size 8 at addr ffff88809a505b28 by task syz-executor.4/13945

CPU: 1 PID: 13945 Comm: syz-executor.4 Not tainted 5.4.0-rc1-next-20191004  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  do_new_mount_fc fs/namespace.c:2773 [inline]
  do_new_mount fs/namespace.c:2825 [inline]
  do_mount+0x1b5f/0x1d10 fs/namespace.c:3143
  ksys_mount+0xdb/0x150 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1c10834c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000459a59
RDX: 0000000020000a40 RSI: 00000000200005c0 RDI: 0000000000000000
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1c108356d4
R13: 00000000004c6291 R14: 00000000004db2f8 R15: 00000000ffffffff

Allocated by task 13945:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
  slab_post_alloc_hook mm/slab.h:584 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 mm/slab.c:3483
  kmem_cache_zalloc include/linux/slab.h:680 [inline]
  alloc_vfsmnt+0x28/0x680 fs/namespace.c:177
  vfs_create_mount+0x96/0x500 fs/namespace.c:940
  do_new_mount_fc fs/namespace.c:2763 [inline]
  do_new_mount fs/namespace.c:2825 [inline]
  do_mount+0x17ae/0x1d10 fs/namespace.c:3143
  ksys_mount+0xdb/0x150 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 16:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 mm/slab.c:3693
  free_vfsmnt+0x6f/0x90 fs/namespace.c:554
  delayed_free_vfsmnt+0x16/0x20 fs/namespace.c:559
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x581/0x1560 kernel/rcu/tree.c:2377
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff88809a505b00
  which belongs to the cache mnt_cache of size 312
The buggy address is located 40 bytes inside of
  312-byte region [ffff88809a505b00, ffff88809a505c38)
The buggy address belongs to the page:
page:ffffea0002694140 refcount:1 mapcount:0 mapping:ffff8880aa5a88c0  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000274afc8 ffffea0002982688 ffff8880aa5a88c0
raw: 0000000000000000 ffff88809a505080 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809a505a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88809a505a80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> ffff88809a505b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff88809a505b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809a505c00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
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
