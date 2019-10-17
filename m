Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8403ADA34F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 03:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395224AbfJQBmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 21:42:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38044 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394864AbfJQBmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:13 -0400
Received: by mail-io1-f70.google.com with SMTP id q11so1028815ioj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GJOFlavh9vKUu9k8A7kEzaRjGKmEaWDqUYR3H4euc74=;
        b=lRSSofzF8qeX3Wba+bAC7WUVt/HL7G4SUdC/AN9b+BRTKIkSr2tGgypJppBDgP6eND
         beRl194ygy4KFz/qJQd2ExU9oF4Fv7ehfX2oszcoT8bwYFjXiXxUEzMUq9lii9h9WQOI
         OMmbcjVpi6MeVQNwPdYSsza8GCx+ckqgRW81HrE2FZ6450bBlyKoflcTb4SL/6e8vg4X
         9KDWQjmnlqxWN6qGrg/mbZzdu7a2bwQIK5r4f11jOgssyeC8f5aVrqR2NgSqrauifiK4
         cPE0iudJGZTgtFXAbBa6nl8xnsLgR12PP/fEAfSXkWNm98j4yNvD25ThALfo1b2FUO7G
         1VvA==
X-Gm-Message-State: APjAAAXcquw3qBb3iqJ2Jtrbtps36p77u9F7kWDoHHK0AgbdvBFLWHY9
        OdKBderh1rIwAMeWni5auKwEGFtt4r2JcKCKzDu8tPXgHE9x
X-Google-Smtp-Source: APXvYqwhOclXRHdlhHgIWR6pZ8bWUQJRQ9cE6BdlxC6r8iRkAd54IF4794FivkVDglXgNJMjwJOjzYhDajTY5Z5wUnmpdUgbesWY
MIME-Version: 1.0
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr712794iol.266.1571276531384;
 Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:42:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f489b0595115374@google.com>
Subject: KASAN: use-after-free Read in mnt_warn_timestamp_expiry
From:   syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>
To:     akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b1f00ac Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137ae2bb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a8b0a0736a2ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=76a43f2b4d34cfc53548
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dde730e00000

The bug was bisected to:

commit 452c2779410a03ac0c6be0a8a91c83aa80bdd7e5
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri Mar 8 20:40:03 2019 +0000

     fs: sysv: Initialize filesystem timestamp ranges

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c6e2bb600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1026e2bb600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c6e2bb600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com
Fixes: 452c2779410a ("fs: sysv: Initialize filesystem timestamp ranges")

==================================================================
BUG: KASAN: use-after-free in mnt_warn_timestamp_expiry+0x4a/0x250  
fs/namespace.c:2471
Read of size 8 at addr ffff888099937328 by task syz-executor.1/18510

CPU: 0 PID: 18510 Comm: syz-executor.1 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_address_description+0x75/0x5c0 mm/kasan/report.c:374
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
  kasan_report+0x26/0x50 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  mnt_warn_timestamp_expiry+0x4a/0x250 fs/namespace.c:2471
  do_new_mount_fc fs/namespace.c:2773 [inline]
  do_new_mount fs/namespace.c:2825 [inline]
  do_mount+0x2160/0x2510 fs/namespace.c:3143
  ksys_mount+0xcc/0x100 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3363
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1f46735c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000459a59
RDX: 0000000020000a40 RSI: 00000000200005c0 RDI: 0000000000000000
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1f467366d4
R13: 00000000004c62a4 R14: 00000000004db438 R15: 00000000ffffffff

Allocated by task 18510:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:518
  slab_post_alloc_hook mm/slab.h:584 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x1f5/0x2e0 mm/slab.c:3483
  kmem_cache_zalloc include/linux/slab.h:680 [inline]
  alloc_vfsmnt+0x27/0x470 fs/namespace.c:177
  vfs_create_mount+0x87/0x440 fs/namespace.c:940
  do_new_mount_fc fs/namespace.c:2763 [inline]
  do_new_mount fs/namespace.c:2825 [inline]
  do_mount+0x1ee0/0x2510 fs/namespace.c:3143
  ksys_mount+0xcc/0x100 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3363
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 16:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x81/0xf0 mm/slab.c:3693
  free_vfsmnt fs/namespace.c:554 [inline]
  delayed_free_vfsmnt+0x74/0x80 fs/namespace.c:559
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x843/0x1050 kernel/rcu/tree.c:2377
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:766

The buggy address belongs to the object at ffff888099937300
  which belongs to the cache mnt_cache of size 312
The buggy address is located 40 bytes inside of
  312-byte region [ffff888099937300, ffff888099937438)
The buggy address belongs to the page:
page:ffffea0002664dc0 refcount:1 mapcount:0 mapping:ffff8880aa5a9a80  
index:0xffff888099937180
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000285d4c8 ffffea00026ab308 ffff8880aa5a9a80
raw: ffff888099937180 ffff888099937000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888099937200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888099937280: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
> ffff888099937300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff888099937380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888099937400: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
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
