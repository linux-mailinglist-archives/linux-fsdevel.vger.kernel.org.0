Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7D3E29F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbhHFLpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 07:45:40 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:57325 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245672AbhHFLpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:45:36 -0400
Received: by mail-io1-f70.google.com with SMTP id k24-20020a6bef180000b02904a03acf5d82so5563096ioh.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 04:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lrc6qWgXYunik/TwaWIoQx2OmfSbqXAPxMjan+uV4Iw=;
        b=hDJkoVLi/+5l85pg10SZ2dZmxWWxViyjJGxwlwYUNDEsaX4AyRtk7RDoNKMWg1ZS3T
         NVqNlqbtwrlqQNKIAn1LDUKPN6hfY/Cx/D9LcR9E7AgKQocruh3GBMR4BeSTzDProL0c
         QSYaxkxagLrcUF5Zga582wOzRuchh//HpPxmJCJ9Or0i+BDwqRqHekX9T6kFS0951Smu
         cu/upiFuiF1niGbMS3Zq77SZVSiYWVrOGKkX33ubRyeEdbddoCp1LdpLV6KfUpG4lVJA
         +8GmivpdZikzZ6miukgDoML/D8CINVCvWzYqxL+KJWewJBDmk0esWAr5iORqoe/Kq4J8
         EIEA==
X-Gm-Message-State: AOAM532y5znE0SrTJnlcntk0R5llcZwtq7qGnKWVEOUngCyyFIxd4scj
        i71zbFUYQrk85ZQ34ifx+nZqeQbelG8pOLIB1ZCmgA6s+b+C
X-Google-Smtp-Source: ABdhPJyuOe0RgoxnNedM+pKHLphrhtZ16KovLW8KEYPAKJLopDoWWFaOL5hNA2UoA3r6uMgwvpDAOL1F7K/6mTuAHV2jjwN0ovmF
MIME-Version: 1.0
X-Received: by 2002:a5e:c006:: with SMTP id u6mr185293iol.66.1628250321206;
 Fri, 06 Aug 2021 04:45:21 -0700 (PDT)
Date:   Fri, 06 Aug 2021 04:45:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000410c05c8e29289@google.com>
Subject: [syzbot] KASAN: invalid-free in bdev_free_inode (2)
From:   syzbot <syzbot+5fa698422954b6b9307b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c500bee1c5b2 Linux 5.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1415477a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=343fd21f6f4da2d6
dashboard link: https://syzkaller.appspot.com/bug?extid=5fa698422954b6b9307b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fa698422954b6b9307b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3210 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xe4/0x530 mm/slub.c:4264

CPU: 1 PID: 813 Comm: syz-executor.2 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:358
 ____kasan_slab_free mm/kasan/common.c:346 [inline]
 __kasan_slab_free+0x120/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1625 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1650
 slab_free mm/slub.c:3210 [inline]
 kfree+0xe4/0x530 mm/slub.c:4264
 bdev_free_inode+0xe0/0x110 fs/block_dev.c:816
 i_callback+0x3f/0x70 fs/inode.c:222
 rcu_do_batch kernel/rcu/tree.c:2550 [inline]
 rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2785
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:check_kcov_mode+0x2c/0x40 kernel/kcov.c:174
Code: 05 a9 5c 8c 7e 89 c2 81 e2 00 01 00 00 a9 00 01 ff 00 74 10 31 c0 85 d2 74 15 8b 96 34 15 00 00 85 d2 74 0b 8b 86 10 15 00 00 <39> f8 0f 94 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 31 c0
RSP: 0018:ffffc9000941f590 EFLAGS: 00000246
RAX: 0000000000000002 RBX: 0000000000000009 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88801b691c40 RDI: 0000000000000003
RBP: ffff888036020580 R08: 0000000000000000 R09: 0000000000000009
R10: ffffffff839f2957 R11: 0000000000000010 R12: 0000000000000010
R13: 00000000000003af R14: dffffc0000000000 R15: 0000000000000000
 write_comp_data kernel/kcov.c:218 [inline]
 __sanitizer_cov_trace_const_cmp4+0x1c/0x70 kernel/kcov.c:284
 tomoyo_domain_quota_is_ok+0x307/0x550 security/tomoyo/util.c:1093
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x33e/0x380 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:311 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:306
 security_file_open+0x52/0x4f0 security/security.c:1633
 do_dentry_open+0x353/0x11d0 fs/open.c:813
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_openat fs/open.c:1236 [inline]
 __se_sys_openat fs/open.c:1231 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1231
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4196d4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 96 f9 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 f9 ff ff 8b 44
RSP: 002b:00007f69595e9060 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004196d4
RDX: 0000000000000002 RSI: 00007f69595e90f0 RDI: 00000000ffffff9c
RBP: 00007f69595e90f0 R08: 0000000000000000 R09: 00007f69595e8f70
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 0000000000a9fb1f R14: 00007f69595e9300 R15: 0000000000022000

Allocated by task 802:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc_node include/linux/slab.h:609 [inline]
 kzalloc_node include/linux/slab.h:732 [inline]
 __alloc_disk_node+0x4e/0x380 block/genhd.c:1246
 __blk_mq_alloc_disk+0xec/0x190 block/blk-mq.c:3145
 loop_add+0x324/0x8c0 drivers/block/loop.c:2345
 loop_control_ioctl+0x130/0x450 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 802:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1625 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1650
 slab_free mm/slub.c:3210 [inline]
 kfree+0xe4/0x530 mm/slub.c:4264
 __alloc_disk_node+0x2e8/0x380 block/genhd.c:1271
 __blk_mq_alloc_disk+0xec/0x190 block/blk-mq.c:3145
 loop_add+0x324/0x8c0 drivers/block/loop.c:2345
 loop_control_ioctl+0x130/0x450 drivers/block/loop.c:2492
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3029 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3109
 put_ctx kernel/events/core.c:1273 [inline]
 put_ctx+0x116/0x1e0 kernel/events/core.c:1266
 perf_event_exit_task_context kernel/events/core.c:12664 [inline]
 perf_event_exit_task+0x528/0x740 kernel/events/core.c:12693
 do_exit+0xbe4/0x2a60 kernel/exit.c:834
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x47f/0x2160 kernel/signal.c:2808
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1419
 expire_timers kernel/time/timer.c:1459 [inline]
 __run_timers.part.0+0x49f/0xa50 kernel/time/timer.c:1732
 __run_timers kernel/time/timer.c:1713 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1745
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

The buggy address belongs to the object at ffff88802ac59400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 512-byte region [ffff88802ac59400, ffff88802ac59600)
The buggy address belongs to the page:
page:ffffea0000ab1600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ac58
head:ffffea0000ab1600 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010841c80
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, ts 18483051698, free_ts 0
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4169
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5391
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 alloc_slab_page mm/slub.c:1688 [inline]
 allocate_slab+0x32e/0x4b0 mm/slub.c:1828
 new_slab mm/slub.c:1891 [inline]
 new_slab_objects mm/slub.c:2637 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2800
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2840
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2964 [inline]
 kmem_cache_alloc_trace+0x30f/0x3c0 mm/slub.c:2981
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 devcgroup_css_alloc+0x3d/0x120 security/device_cgroup.c:214
 css_create kernel/cgroup/cgroup.c:5229 [inline]
 cgroup_apply_control_enable+0x4b8/0xc00 kernel/cgroup/cgroup.c:3085
 cgroup_mkdir+0x5ac/0x10f0 kernel/cgroup/cgroup.c:5447
 kernfs_iop_mkdir+0x146/0x1d0 fs/kernfs/dir.c:1127
 vfs_mkdir+0x52e/0x760 fs/namei.c:3823
 do_mkdirat+0x284/0x310 fs/namei.c:3848
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802ac59300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ac59380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802ac59400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802ac59480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ac59500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
