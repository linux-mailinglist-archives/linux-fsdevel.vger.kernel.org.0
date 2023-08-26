Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D05789849
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjHZQxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHZQxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:53:05 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC5B8
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 09:53:02 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bb29dc715bso19645195ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693068782; x=1693673582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkxneabA/AWiRAlBOZN2TxoXnh4qqaFE23sZdfO2JvE=;
        b=E0t4H/ZKiYKTT6kHgxaQoWJMp+Bw7ZavsXRedMn0mK2e1kWdKTN+DSrdF5/Jm1Sdds
         jxXGTKbyP8D6y35DZ8Jg7Yfx4qoeVVPAq8tdHhLgPqwPqIQwUv4H75p9HW2L2EeMAwGB
         w1gUsz/liPME6dY+i9AxdGmLf57MoULa9B1V9bhtICQC0aqspS2yZf3CR13GnNZ4+fWm
         oVey4xTgeZTujfo6h08DRdEZXn9B/xvwtnJOHDXRVdBD6dFflgqYvjZalJvehUKymCjz
         XO1Y3vrQwlGbO0WNxSdf9jDuh2jdhMzPUoyQ48NJOahk5smaS+UQ0Qew/ZTWt/b0ZcZu
         JPgQ==
X-Gm-Message-State: AOJu0YxiFIFy4NbTtwu/92HoCP2dLcOybbvOuq/Rucohnbth3MziJ1Sg
        ZIy00W8+uQUdTHyENnb7OijxnGYducHGhZ8VuLqROOzK/TGU
X-Google-Smtp-Source: AGHT+IH5XmHi0cH2a8rc1cmYNsECIqlVmykMMlC8tRGaVJlHOlq+MbmjleDE/y+5MJgrfstWOfy+bRW1zZSV7KgOxWo4NDs8ulWl
MIME-Version: 1.0
X-Received: by 2002:a17:902:fb05:b0:1bd:e698:74e with SMTP id
 le5-20020a170902fb0500b001bde698074emr3149311plb.6.1693068781824; Sat, 26 Aug
 2023 09:53:01 -0700 (PDT)
Date:   Sat, 26 Aug 2023 09:53:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005231870603d64bac@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
To:     brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    28c736b0e92e Add linux-next specific files for 20230822
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15515d53a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=f25c61df1ec3d235d52f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15783640680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164da860680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37bc881cd0b2/disk-28c736b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4512f7892b3d/vmlinux-28c736b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/052fe1287e05/bzImage-28c736b0.xz

The issue was bisected to:

commit 2c18a63b760a0f68f14cb8bb4c3840bb0b63b73e
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Aug 18 14:00:51 2023 +0000

    super: wait until we passed kill super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e6a360680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e6a360680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e6a360680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com
Fixes: 2c18a63b760a ("super: wait until we passed kill super")

==================================================================
BUG: KASAN: slab-use-after-free in kernfs_test_super+0x122/0x150 fs/kernfs/mount.c:295
Read of size 8 at addr ffff88807249d808 by task syz-executor493/5717

CPU: 1 PID: 5717 Comm: syz-executor493 Not tainted 6.5.0-rc7-next-20230822-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 kernfs_test_super+0x122/0x150 fs/kernfs/mount.c:295
 sget_fc+0x582/0x9b0 fs/super.c:778
 kernfs_get_tree+0x198/0x9a0 fs/kernfs/mount.c:346
 sysfs_get_tree+0x41/0x140 fs/sysfs/mount.c:31
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f126c3d79c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff40e973e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f126c3d79c9
RDX: 0000000020000300 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fff40e9741c
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff40e9741c
R13: 0000000000000069 R14: 431bde82d7b634db R15: 00007fff40e97450
 </TASK>

Allocated by task 5716:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kernfs_get_tree+0x78/0x9a0 fs/kernfs/mount.c:337
 sysfs_get_tree+0x41/0x140 fs/sysfs/mount.c:31
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5053:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 sysfs_kill_sb+0x21/0x30 fs/sysfs/mount.c:86
 deactivate_locked_super+0xa0/0x2d0 fs/super.c:454
 deactivate_super+0xde/0x100 fs/super.c:504
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 ptrace_notify+0x10c/0x130 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare+0x120/0x220 kernel/entry/common.c:279
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0xd/0x60 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807249d800
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes inside of
 freed 64-byte region [ffff88807249d800, ffff88807249d840)

The buggy address belongs to the physical page:
page:ffffea0001c92740 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7249d
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41640 ffffea0000a28500 dead000000000005
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4493, tgid 4493 (udevd), ts 94419071514, free_ts 94405327131
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3213
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4469
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2+0x100/0x3d0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x196/0x710 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x271/0x450 security/tomoyo/file.c:822
 security_inode_getattr+0xf1/0x150 security/security.c:2153
 vfs_getattr fs/stat.c:206 [inline]
 vfs_statx+0x180/0x430 fs/stat.c:281
 vfs_fstatat+0x90/0xb0 fs/stat.c:315
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xd7/0x490 kernel/fork.c:921
 mmdrop include/linux/sched/mm.h:54 [inline]
 __mmput+0x409/0x4d0 kernel/fork.c:1367
 mmput+0x62/0x70 kernel/fork.c:1378
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b4/0x2a20 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807249d700: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88807249d780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88807249d800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff88807249d880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88807249d900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
