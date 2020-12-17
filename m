Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B72DCDEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgLQIyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 03:54:50 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:43878 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgLQIyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:54:50 -0500
Received: by mail-il1-f200.google.com with SMTP id p6so30912368ils.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 00:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nCH69Iiq/5tL6U4w/81mN4dx5ih8L+p+4L6TwG86GBU=;
        b=Jm2iR0T8xUn/0YmpHWUnC6cEQAF9Vnl6I6moHth6HJiYNN1/szdMVkqWWfOWUTPSwI
         ERiptr8/oWrbPSLCBxb3FrY9rTHT5bAL5oSNFO34c7cbq+1aFXNpzHz/ubhMntNbXHlJ
         D704AojrdoTyMJKi3RaorlwsfVYv7EPcVQikBXfZ5FQkZbSpSG9o9RkCk/AX6jXoi4Lw
         Ctmdo7KkgY8pN4cL5mRNpmlVK0W6/joQ92m3xjaWPbsUO13qHYj6lLWM1o+4/5P2ru9u
         87RzfepoNaXCXbKzagUJAYZ1o8G5Y/hcxsR3S5oyqoN6SP+jeYFz+Rv77KQ4uqCQY/vX
         j09Q==
X-Gm-Message-State: AOAM531QX0RzYn9LEn9ljqX3RnWjDTCpxoDfwCL/N/PwLPGujZt0SrF+
        dGiAxA4SyDuI8tbsxtqaLzaGaEsjvIu2QueQA7nTF19hO+mi
X-Google-Smtp-Source: ABdhPJxRyIXUnOdsWJ8VWpR6Ndi7OXPtQ7R/A+YGtB4hgIC46tcLTW+RanzmVsQBZbbuA+J0ZlffAU0S0CfmgFgb4UbWz6OeiLIr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:19c:: with SMTP id a28mr4451610jaq.76.1608195248447;
 Thu, 17 Dec 2020 00:54:08 -0800 (PST)
Date:   Thu, 17 Dec 2020 00:54:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083865205b6a5223c@google.com>
Subject: KASAN: invalid-free in bdev_free_inode
From:   syzbot <syzbot+48313eb09ec08f5ea43a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    26aed0ea Add linux-next specific files for 20201216
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c492cb500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
dashboard link: https://syzkaller.appspot.com/bug?extid=48313eb09ec08f5ea43a
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48313eb09ec08f5ea43a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3157 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xdb/0x3c0 mm/slub.c:4156

CPU: 0 PID: 4913 Comm: systemd-udevd Not tainted 5.10.0-next-20201216-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:355
 ____kasan_slab_free.part.0+0xfd/0x110 mm/kasan/common.c:345
 kasan_slab_free include/linux/kasan.h:188 [inline]
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1586
 slab_free mm/slub.c:3157 [inline]
 kfree+0xdb/0x3c0 mm/slub.c:4156
 bdev_free_inode+0x57/0x80 fs/block_dev.c:788
 i_callback+0x3f/0x70 fs/inode.c:222
 rcu_do_batch kernel/rcu/tree.c:2489 [inline]
 rcu_core+0x75d/0xf80 kernel/rcu/tree.c:2723
 __do_softirq+0x2bc/0xa77 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu+0x17f/0x200 kernel/softirq.c:420
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5440 [inline]
RIP: 0010:lock_acquire+0x2c7/0x750 kernel/locking/lockdep.c:5402
Code: 48 c7 c7 c0 9f 6b 89 48 83 c4 20 e8 63 ac c1 07 b8 ff ff ff ff 65 0f c1 05 66 e3 a9 7e 83 f8 01 0f 85 40 03 00 00 ff 34 24 9d <e9> 3a fe ff ff 65 ff 05 cd d1 a9 7e 48 8b 05 c6 32 12 0c e8 81 a1
RSP: 0018:ffffc900015af8c0 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 1ffff920002b5f1a RCX: 0000000000000001
RDX: 1ffff1100322c491 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8f5157b7
R10: fffffbfff1ea2af6 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff8b8e89c0 R14: 0000000000000000 R15: 0000000000000000
 fs_reclaim_acquire mm/page_alloc.c:4338 [inline]
 fs_reclaim_acquire+0xd2/0x150 mm/page_alloc.c:4329
 might_alloc include/linux/sched/mm.h:193 [inline]
 slab_pre_alloc_hook mm/slab.h:499 [inline]
 slab_alloc_node mm/slub.c:2822 [inline]
 slab_alloc mm/slub.c:2911 [inline]
 kmem_cache_alloc+0x3e/0x380 mm/slub.c:2916
 anon_vma_chain_alloc mm/rmap.c:136 [inline]
 anon_vma_fork+0x1df/0x630 mm/rmap.c:357
 dup_mmap kernel/fork.c:551 [inline]
 dup_mm+0x9a6/0x1380 kernel/fork.c:1362
 copy_mm kernel/fork.c:1418 [inline]
 copy_process+0x2a3e/0x6fe0 kernel/fork.c:2100
 kernel_clone+0xe7/0xad0 kernel/fork.c:2465
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2582
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f645bff638b
Code: db 45 85 f6 0f 85 95 01 00 00 64 4c 8b 04 25 10 00 00 00 31 d2 4d 8d 90 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 de 00 00 00 85 c0 41 89 c5 0f 85 e5 00 00
RSP: 002b:00007ffe156cbc30 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe156cbc30 RCX: 00007f645bff638b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffe156cbc80 R08: 00007f645d1a68c0 R09: 0000000000000210
R10: 00007f645d1a6b90 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 760:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:47 [inline]
 set_alloc_info mm/kasan/common.c:405 [inline]
 ____kasan_kmalloc mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:408
 kasan_slab_alloc include/linux/kasan.h:205 [inline]
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc_node mm/slub.c:2903 [inline]
 slab_alloc mm/slub.c:2911 [inline]
 __kmalloc_track_caller+0x163/0x2e0 mm/slub.c:4496
 kmemdup+0x23/0x50 mm/util.c:128
 kmemdup include/linux/string.h:520 [inline]
 mpls_dev_sysctl_register+0xaa/0x2d0 net/mpls/af_mpls.c:1407
 mpls_add_dev net/mpls/af_mpls.c:1473 [inline]
 mpls_dev_notify+0x281/0x970 net/mpls/af_mpls.c:1589
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x150 net/core/dev.c:2022
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0x1085/0x16a0 net/core/dev.c:10059
 register_netdev+0x2d/0x50 net/core/dev.c:10159
 loopback_net_init+0x73/0x160 drivers/net/loopback.c:216
 ops_init+0xaf/0x490 net/core/net_namespace.c:152
 setup_net+0x2de/0x850 net/core/net_namespace.c:342
 copy_net_ns+0x376/0x7b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 copy_namespaces+0x3e5/0x4a0 kernel/nsproxy.c:178
 copy_process+0x2aa7/0x6fe0 kernel/fork.c:2103
 kernel_clone+0xe7/0xad0 kernel/fork.c:2465
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2582
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 9:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:47
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:355
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:188 [inline]
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1586
 slab_free mm/slub.c:3157 [inline]
 kfree+0xdb/0x3c0 mm/slub.c:4156
 mpls_dev_sysctl_unregister net/mpls/af_mpls.c:1443 [inline]
 mpls_dev_notify+0x684/0x970 net/mpls/af_mpls.c:1622
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x150 net/core/dev.c:2022
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 rollback_registered_many+0x92e/0x1530 net/core/dev.c:9477
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10701
 unregister_netdevice_many net/core/dev.c:10700 [inline]
 default_device_exit_batch+0x30c/0x3d0 net/core/dev.c:11184
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:190
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:604
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_record_aux_stack+0xdc/0x100 mm/kasan/generic.c:343
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x710 kernel/rcu/tree.c:3038
 nf_hook_entries_free net/netfilter/core.c:88 [inline]
 nf_hook_entries_free net/netfilter/core.c:75 [inline]
 __nf_register_net_hook+0x2c7/0x630 net/netfilter/core.c:424
 nf_register_net_hook+0x114/0x170 net/netfilter/core.c:541
 nf_register_net_hooks+0x59/0xc0 net/netfilter/core.c:557
 nf_nat_register_fn+0x38d/0x5a0 net/netfilter/nf_nat_core.c:1063
 ipt_nat_register_lookups net/ipv4/netfilter/iptable_nat.c:68 [inline]
 iptable_nat_table_init.part.0+0x84/0x1e0 net/ipv4/netfilter/iptable_nat.c:106
 iptable_nat_table_init+0x4f/0x70 net/ipv4/netfilter/iptable_nat.c:114
 xt_find_table_lock+0x2d9/0x540 net/netfilter/x_tables.c:1223
 xt_request_find_table_lock+0x27/0xf0 net/netfilter/x_tables.c:1253
 get_info+0x16a/0x710 net/ipv6/netfilter/ip6_tables.c:980
 do_ipt_get_ctl+0x152/0x9d0 net/ipv4/netfilter/ip_tables.c:1651
 nf_getsockopt+0x72/0xd0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt net/ipv4/ip_sockglue.c:1777 [inline]
 ip_getsockopt+0x164/0x1c0 net/ipv4/ip_sockglue.c:1756
 tcp_getsockopt+0x86/0xd0 net/ipv4/tcp.c:4141
 __sys_getsockopt+0x219/0x4c0 net/socket.c:2156
 __do_sys_getsockopt net/socket.c:2171 [inline]
 __se_sys_getsockopt net/socket.c:2168 [inline]
 __x64_sys_getsockopt+0xba/0x150 net/socket.c:2168
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:39
 kasan_record_aux_stack+0xdc/0x100 mm/kasan/generic.c:343
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x710 kernel/rcu/tree.c:3038
 inet_free_ifa net/ipv4/devinet.c:231 [inline]
 inetdev_destroy net/ipv4/devinet.c:319 [inline]
 inetdev_event+0x6f9/0x16c0 net/ipv4/devinet.c:1598
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x150 net/core/dev.c:2022
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 rollback_registered_many+0x92e/0x1530 net/core/dev.c:9477
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10701
 unregister_netdevice_many net/core/dev.c:10700 [inline]
 default_device_exit_batch+0x30c/0x3d0 net/core/dev.c:11184
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:190
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:604
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff888018fa2000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff888018fa2000, ffff888018fa2080)
The buggy address belongs to the page:
page:0000000085654d51 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18fa2
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010841640
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888018fa1f00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff888018fa1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888018fa2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888018fa2080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888018fa2100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
