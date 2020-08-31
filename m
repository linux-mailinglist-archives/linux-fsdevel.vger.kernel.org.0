Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66E25844D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 01:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgHaXIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 19:08:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:49904 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgHaXIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:08:17 -0400
Received: by mail-il1-f199.google.com with SMTP id b18so6321848ilh.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 16:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VznC8MyQYOV7sK4ysThHXxJPTpVh7KNJwv4KURO37GY=;
        b=QwgKKWiazwdpcNYP+Bdns8xz6k98qFkBNZMutfulSQegZhkw71LkaR3bcMMgBldYD8
         6/zxHu9QKJ+fRo6qDkzkuXyVJZR8uWVo9C5A2dzz1SRjgtL+HJbOFRWqcio8XzU3/gvo
         4Kf1jJSxWcvlkppxxqLTfQrCb/p692chrwjTIJuB0bVmmonQJHw/6L/EKcnQSvKhmVHm
         Rc/5pj83boQIILVNslq05/lvI7V1xghUZcA/Xv0MTtqgP7oTgQ0Jv+H2DSl8wyqnqraf
         ZxTW2FwswYzbJ5UGThoHa+kJUYbpeAhbLdoWsZFCscjhGfhf0pChfUwfW4XQcRzDiHjw
         dsrg==
X-Gm-Message-State: AOAM530Sxn4b9ByW+eRRaRUM9u3k1KJ4L7wWcVD98P1uE8OXC3gwC1c0
        ViP39zBID9CfL7jyqYGCMEIfy44PB0IzOKCLbkV/kytSVTN1
X-Google-Smtp-Source: ABdhPJyS0xQLu2WkBe1RFTdpEJI15WPbVkevBff7OUnFXtFWo+aPHmXbWRwd22EsZ/ecKnLV+kuwSubkH8cUqa9MXEYlbIttUkMx
MIME-Version: 1.0
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr3294483iom.27.1598915296330;
 Mon, 31 Aug 2020 16:08:16 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:08:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000438ab305ae347ac4@google.com>
Subject: KASAN: use-after-free Read in __fput (3)
From:   syzbot <syzbot+c282923e5da93549fa27@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b440d1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=c282923e5da93549fa27
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a5452e900000

The issue was bisected to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147a02f2900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167a02f2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=127a02f2900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c282923e5da93549fa27@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

==================================================================
BUG: KASAN: use-after-free in d_inode include/linux/dcache.h:522 [inline]
BUG: KASAN: use-after-free in fsnotify_parent include/linux/fsnotify.h:54 [inline]
BUG: KASAN: use-after-free in fsnotify_file include/linux/fsnotify.h:90 [inline]
BUG: KASAN: use-after-free in fsnotify_close include/linux/fsnotify.h:279 [inline]
BUG: KASAN: use-after-free in __fput+0x8ac/0x920 fs/file_table.c:267
Read of size 8 at addr ffff888087a020a8 by task syz-executor.2/11261

CPU: 0 PID: 11261 Comm: syz-executor.2 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 d_inode include/linux/dcache.h:522 [inline]
 fsnotify_parent include/linux/fsnotify.h:54 [inline]
 fsnotify_file include/linux/fsnotify.h:90 [inline]
 fsnotify_close include/linux/fsnotify.h:279 [inline]
 __fput+0x8ac/0x920 fs/file_table.c:267
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416f01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff215c6f90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000416f01
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000001190358 R09: 0000000000000000
R10: 00007fff215c7070 R11: 0000000000000293 R12: 0000000001190360
R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000118cf4c

Allocated by task 11262:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
 __d_alloc+0x2a/0x950 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 sock_alloc_file+0x4f/0x190 net/socket.c:411
 sock_map_fd net/socket.c:435 [inline]
 __sys_socket+0x13d/0x200 net/socket.c:1524
 __do_sys_socket net/socket.c:1529 [inline]
 __se_sys_socket net/socket.c:1527 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1527
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 11262:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 __d_free fs/dcache.c:271 [inline]
 dentry_free+0xde/0x160 fs/dcache.c:348
 __dentry_kill+0x4c6/0x640 fs/dcache.c:593
 dentry_kill fs/dcache.c:705 [inline]
 dput+0x725/0xbc0 fs/dcache.c:878
 __fput+0x3ab/0x920 fs/file_table.c:294
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 dentry_free+0xc3/0x160 fs/dcache.c:350
 __dentry_kill+0x4c6/0x640 fs/dcache.c:593
 shrink_dentry_list+0x144/0x480 fs/dcache.c:1141
 shrink_dcache_parent+0x219/0x3c0 fs/dcache.c:1568
 d_invalidate fs/dcache.c:1677 [inline]
 d_invalidate+0x13f/0x280 fs/dcache.c:1662
 proc_invalidate_siblings_dcache+0x43b/0x600 fs/proc/inode.c:150
 release_task+0xc63/0x14d0 kernel/exit.c:221
 wait_task_zombie kernel/exit.c:1088 [inline]
 wait_consider_task+0x2fb3/0x3b20 kernel/exit.c:1315
 do_wait_thread kernel/exit.c:1378 [inline]
 do_wait+0x36a/0x9e0 kernel/exit.c:1449
 kernel_wait4+0x14c/0x260 kernel/exit.c:1621
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1649
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 dentry_free+0xc3/0x160 fs/dcache.c:350
 __dentry_kill+0x4c6/0x640 fs/dcache.c:593
 dentry_kill fs/dcache.c:717 [inline]
 dput+0x635/0xbc0 fs/dcache.c:878
 handle_mounts fs/namei.c:1389 [inline]
 step_into+0xc43/0x1990 fs/namei.c:1690
 walk_component+0x171/0x6a0 fs/namei.c:1866
 link_path_walk.part.0+0x6b8/0xc20 fs/namei.c:2183
 link_path_walk fs/namei.c:2111 [inline]
 path_lookupat+0xb7/0x830 fs/namei.c:2332
 filename_lookup+0x19f/0x560 fs/namei.c:2366
 user_path_at include/linux/namei.h:59 [inline]
 do_faccessat+0x129/0x820 fs/open.c:423
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888087a02040
 which belongs to the cache dentry of size 312
The buggy address is located 104 bytes inside of
 312-byte region [ffff888087a02040, ffff888087a02178)
The buggy address belongs to the page:
page:00000000b4e25e7c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x87a02
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000212a688 ffffea00021e6a48 ffff88821bc47f00
raw: 0000000000000000 ffff888087a02040 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888087a01f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888087a02000: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888087a02080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888087a02100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff888087a02180: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
