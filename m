Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583147899DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHZXk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 19:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHZXkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 19:40:09 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC881B4
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 16:40:05 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-26f49625bffso1763023a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 16:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693093205; x=1693698005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hd0VIQbu2+WDcMObhboi/8UEQX+wtKY36yiRWodujtE=;
        b=mIZURTjGb4Clzz0hrpCjwNORwRwC3i2jd9MJzfz8nN+ExzVr3In5QI2ISvb7DgEVSy
         qwlan0pEFalzZilQeLGfFTg+zZUyhDfD6DS+4Usz2Vr2QEIhgo8hJ+1TdHzdUMQmfXZ8
         D9RuLJ6XcFoT4l6mipSQ7R2yJSFrbh87Bg+aJ4R1MG/rLTsHvPsdSPRKzIg66kN8bzzj
         rRhKXVvPDf63l9hHAn823UTTR14KYguu8NkZwIArugn/E4yLhcxARkl//MUyEzzX+yi8
         RMdu9min3oX4lDMHuGZIuoW111VKl8pQ/tSFxcUZV9/u1bAY8Y8i8sFS1z+OCGkIAbkX
         nkXw==
X-Gm-Message-State: AOJu0Yy63WAIyGEUWqRzZvADjthVlxeFq7dBZSxhZyR8DCaaal7ZmeXj
        tjRv1ESLIV+YQQINp4OMwLLq093AxrCpe41TwngRH1lYpqQt
X-Google-Smtp-Source: AGHT+IGV4eYMMZTg/IasW3DrFHzHCWe7M3RfOfxzCLmeaYGD8fQti+BTxts++lLbxNNTJIdz/Gxj0MIUJ/BlvCWs5fVaOI7tEino
MIME-Version: 1.0
X-Received: by 2002:a17:902:ea04:b0:1bb:a78c:7a3e with SMTP id
 s4-20020a170902ea0400b001bba78c7a3emr7750122plg.3.1693093205449; Sat, 26 Aug
 2023 16:40:05 -0700 (PDT)
Date:   Sat, 26 Aug 2023 16:40:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001524880603dbfbf8@google.com>
Subject: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super
From:   syzbot <syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com>
To:     brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11bfe65ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=5b64180f8d9e39d3f061
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c50b07a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156fc5cfa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37bc881cd0b2/disk-28c736b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4512f7892b3d/vmlinux-28c736b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/052fe1287e05/bzImage-28c736b0.xz

The issue was bisected to:

commit 2c18a63b760a0f68f14cb8bb4c3840bb0b63b73e
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Aug 18 14:00:51 2023 +0000

    super: wait until we passed kill super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154bc0d3a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174bc0d3a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=134bc0d3a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Fixes: 2c18a63b760a ("super: wait until we passed kill super")

==================================================================
BUG: KASAN: slab-use-after-free in get_fuse_conn_super fs/fuse/fuse_i.h:885 [inline]
BUG: KASAN: slab-use-after-free in fuse_test_super+0x8c/0xa0 fs/fuse/inode.c:1689
Read of size 8 at addr ffff88814b51bc40 by task syz-executor382/5079

CPU: 0 PID: 5079 Comm: syz-executor382 Not tainted 6.5.0-rc7-next-20230822-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 get_fuse_conn_super fs/fuse/fuse_i.h:885 [inline]
 fuse_test_super+0x8c/0xa0 fs/fuse/inode.c:1689
 sget_fc+0x582/0x9b0 fs/super.c:778
 fuse_get_tree+0x39a/0x640 fs/fuse/inode.c:1738
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
RIP: 0033:0x7f65faa253ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5d8df618 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff5d8df640 RCX: 00007f65faa253ea
RDX: 0000000020000280 RSI: 0000000020000300 RDI: 0000000000000000
RBP: 0000000020000280 R08: 00007fff5d8df640 R09: 00007fff5d8df507
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000300
R13: 0000000000000000 R14: 00000000200028c0 R15: 00007f65faa6d06a
 </TASK>

Allocated by task 5081:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 fuse_get_tree+0xbe/0x640 fs/fuse/inode.c:1705
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

Freed by task 5081:
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

The buggy address belongs to the object at ffff88814b51bc40
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88814b51bc40, ffff88814b51bc60)

The buggy address belongs to the physical page:
page:ffffea00052d46c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14b51b
ksm flags: 0x57ff00000000800(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000800 ffff888012c41500 ffffea000501e700 dead000000000003
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 23776999617, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3213
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4469
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2131
 alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
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
 kobject_get_path+0xce/0x2b0 lib/kobject.c:161
 kobject_uevent_env+0x26b/0x1800 lib/kobject_uevent.c:529
 kernel_add_sysfs_param kernel/params.c:817 [inline]
 param_sysfs_builtin kernel/params.c:852 [inline]
 param_sysfs_builtin_init+0x327/0x450 kernel/params.c:986
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814b51bb00: 00 00 05 fc fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88814b51bb80: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88814b51bc00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff88814b51bc80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88814b51bd00: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
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
