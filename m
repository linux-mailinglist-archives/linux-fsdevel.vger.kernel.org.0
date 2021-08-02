Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4843DD242
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhHBIt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 04:49:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35550 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhHBIt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:49:26 -0400
Received: by mail-io1-f72.google.com with SMTP id i10-20020a5e850a0000b029053ee90daa50so11362805ioj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Aug 2021 01:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uGlsj0ogzdpez7GTi2V6rbBaqbf5h6EztSeqlZmXDHE=;
        b=SWZsTk6DfNi2IWnR/ArhwHS9Z8upxURjtBXem7HHUhjlUDuyCP6Jw4NCtgKhkZnC4W
         tQEaknXxFio3Wa3nFHsy3e0qDIEegZp2MdU6wRUEDI5P2KpimyWzrS+EYacKhUgw0FOd
         7XEiIGhReTpvc0FlUyG1I0yW3bB3tFoUU0Ge6DF6bOw6XDiQ0lm5MsDLQFVP5fDdqeaB
         CLTheQ0LzcD1T9ijxrm8bAHe3h3yptZ1FTi/ufxWceBJENXEbb5HqSpPsXapp4e5VtHf
         FVpVZpCiLWye85fjcgABkONqsadJbQSFRUNzkczzl/RudFeA+ys8t9WrPaE7lgS/OwiC
         vuMA==
X-Gm-Message-State: AOAM530SllzAyri2bxpVVsUA37P/bHpe/d+1/WSoHLcfyoDc4LkjE1PU
        991tTDzyvHAqXbyQ7Gouywx9yKc6quwgll1exY0XDFt9DcKi
X-Google-Smtp-Source: ABdhPJw5ddln3fm0mBkI2dNnB4THfQUbKlCfgmRJP5QlEIqzLhUA5MF1w1tZsQNBpnwydTJq9/xaIpe9yA9WdtTsmhRg8SpAkgRH
MIME-Version: 1.0
X-Received: by 2002:a5e:c311:: with SMTP id a17mr259472iok.22.1627894157537;
 Mon, 02 Aug 2021 01:49:17 -0700 (PDT)
Date:   Mon, 02 Aug 2021 01:49:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdf3e205c88fa4cf@google.com>
Subject: [syzbot] KASAN: use-after-free Read in timerfd_clock_was_set
From:   syzbot <syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4010a528219e Merge tag 'fixes_for_v5.14-rc4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13611f5c300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
dashboard link: https://syzkaller.appspot.com/bug?extid=66e110c312ed4ae684a8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66e110c312ed4ae684a8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in timerfd_clock_was_set+0x2b8/0x2e0 fs/timerfd.c:104
Read of size 8 at addr ffff8880140a6cf8 by task syz-executor.2/11068

CPU: 0 PID: 11068 Comm: syz-executor.2 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x2d6 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 timerfd_clock_was_set+0x2b8/0x2e0 fs/timerfd.c:104
 timekeeping_inject_offset+0x4af/0x620 kernel/time/timekeeping.c:1375
 do_adjtimex+0x28f/0xa30 kernel/time/timekeeping.c:2406
 do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
 __do_sys_clock_adjtime+0x163/0x270 kernel/time/posix-timers.c:1121
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2013300188 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 000000000056c038 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c038
R13: 00007ffef0a53bbf R14: 00007f2013300300 R15: 0000000000022000

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x98/0xc0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_trace+0x1e4/0x480 mm/slab.c:3575
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 __do_sys_timerfd_create+0x265/0x370 fs/timerfd.c:412
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 3306:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xcd/0x100 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 __cache_free mm/slab.c:3445 [inline]
 kfree+0x106/0x2c0 mm/slab.c:3803
 kvfree+0x42/0x50 mm/util.c:616
 kfree_rcu_work+0x5b7/0x870 kernel/rcu/tree.c:3359
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3594
 timerfd_release+0x105/0x290 fs/timerfd.c:229
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3029 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3109
 inetdev_destroy net/ipv4/devinet.c:328 [inline]
 inetdev_event+0xd4c/0x15d0 net/ipv4/devinet.c:1598
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2123
 call_netdevice_notifiers_extack net/core/dev.c:2135 [inline]
 call_netdevice_notifiers net/core/dev.c:2149 [inline]
 unregister_netdevice_many+0x951/0x1790 net/core/dev.c:11093
 ip_tunnel_delete_nets+0x39f/0x5b0 net/ipv4/ip_tunnel.c:1122
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:178
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff8880140a6c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 248 bytes inside of
 512-byte region [ffff8880140a6c00, ffff8880140a6e00)
The buggy address belongs to the page:
page:ffffea0000502980 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880140a6800 pfn:0x140a6
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000093cf48 ffffea0000746b08 ffff888010840600
raw: ffff8880140a6800 ffff8880140a6000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2c2220(__GFP_HIGH|__GFP_ATOMIC|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE), pid 8700, ts 180152857573, free_ts 176284490391
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4169
 __alloc_pages_slowpath.constprop.0+0x2e6/0x21b0 mm/page_alloc.c:4940
 __alloc_pages+0x412/0x500 mm/page_alloc.c:5404
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 kmem_getpages mm/slab.c:1377 [inline]
 cache_grow_begin+0x75/0x460 mm/slab.c:2593
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2965
 ____cache_alloc mm/slab.c:3048 [inline]
 ____cache_alloc mm/slab.c:3031 [inline]
 slab_alloc_node mm/slab.c:3249 [inline]
 kmem_cache_alloc_node_trace+0x4ca/0x5d0 mm/slab.c:3617
 __do_kmalloc_node mm/slab.c:3639 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3654
 kmalloc_reserve net/core/skbuff.c:355 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1112 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 inet6_ifa_notify+0x118/0x220 net/ipv6/addrconf.c:5436
 __ipv6_ifa_notify net/ipv6/addrconf.c:6070 [inline]
 ipv6_ifa_notify net/ipv6/addrconf.c:6122 [inline]
 inet6_addr_add+0x681/0xae0 net/ipv6/addrconf.c:2957
 inet6_rtm_newaddr+0xf00/0x1970 net/ipv6/addrconf.c:4871
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5574
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:723
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3411
 slab_destroy mm/slab.c:1627 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1647
 cache_flusharray mm/slab.c:3418 [inline]
 ___cache_free+0x4ba/0x600 mm/slab.c:3480
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x4e/0x110 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8b/0xa0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc mm/slab.c:3323 [inline]
 kmem_cache_alloc+0x25f/0x540 mm/slab.c:3507
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:583
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:645
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:985
 sysfs_add_file_mode_ns+0x226/0x540 fs/sysfs/file.c:317
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x328/0xb20 fs/sysfs/group.c:149
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2435 [inline]
 device_add_attrs drivers/base/core.c:2583 [inline]
 device_add+0x824/0x2180 drivers/base/core.c:3305

Memory state around the buggy address:
 ffff8880140a6b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880140a6c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880140a6c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff8880140a6d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880140a6d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
