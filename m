Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013D7730AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHGUv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 16:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHGUvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:51:55 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73137E72
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:51:52 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6b9d34de264so8903444a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 13:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691441511; x=1692046311;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh1FMFT+xwdpzqPLYhlJOnPoEabJHwYdIfiobgwEUnQ=;
        b=I3a4Hqa8KUKh1uQGwC0wyMM0uvvZFa3kWY95QBwh3wfPeVZowiPf2i+rWSSjws5+OP
         cmDHdOxX+Eqn8pn6A0WtUT0jk1OlatNpk75RWNlSr13Hpcqs/DsVhUNb/QS9MVNrGHGI
         D4ksDodPoeaxCRxYkujGtlfkwl2BlzinXxQrinlJBiOlgAU+PInbtQtm4tJmJzi9TwHq
         O7ACIVhb1OQ89ixJENRG69c6Q4WDdc+xOvq/Jq3/WvfKXv2XNW+VCqYKFycxDnxoVjW2
         2iHvjboqsUuAL03TiO6ntni887f2ecjKSXkWUGPqU1kfhCmEQGE1rvXt9BcDBYKbNI3T
         bpsw==
X-Gm-Message-State: AOJu0YzqR3Ec6Dr6k1CoVGl43OdTBPG9g0v7zaGEOMMo5tGFzdTTeGe+
        7m+3zcIp02zqRLCFHzd6s3gR4VdopeBTX8FrGR8CEUAeqWQp
X-Google-Smtp-Source: AGHT+IGN+moUvMByXJ97OXKSF+t6QS/yf6GfoQu8VlkC01QCk/z5XcirJVZ6FSmownmJ7dGxGawhHzKSLfSiGtmw4/IqqBCW8EcO
MIME-Version: 1.0
X-Received: by 2002:a05:6830:145:b0:6b9:8ea6:fb02 with SMTP id
 j5-20020a056830014500b006b98ea6fb02mr12821328otp.2.1691441511864; Mon, 07 Aug
 2023 13:51:51 -0700 (PDT)
Date:   Mon, 07 Aug 2023 13:51:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007921d606025b6ad6@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f7dc24b34138 Add linux-next specific files for 20230807
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a0862ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179704c9a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17868ba9a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24eb0299fcf6/disk-f7dc24b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1dc5212ed72/vmlinux-f7dc24b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/062c8c075e0c/bzImage-f7dc24b3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8e4e0cc06a40/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in btrfs_open_devices+0xb8/0xc0 fs/btrfs/volumes.c:1281
Read of size 4 at addr ffff8880293c8d30 by task syz-executor243/5048

CPU: 0 PID: 5048 Comm: syz-executor243 Not tainted 6.5.0-rc5-next-20230807-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 btrfs_open_devices+0xb8/0xc0 fs/btrfs/volumes.c:1281
 btrfs_mount_root+0x681/0xda0 fs/btrfs/super.c:1505
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1578
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc50e075e9a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2e2532d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd2e2532f0 RCX: 00007fc50e075e9a
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007ffd2e2532f0
RBP: 0000000000000004 R08: 00007ffd2e253330 R09: 00000000000051a5
R10: 0000000001000008 R11: 0000000000000282 R12: 0000000001000008
R13: 00007ffd2e253330 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

Allocated by task 5043:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_fs_devices+0x54/0x2b0 fs/btrfs/volumes.c:375
 device_list_add.constprop.0+0x3eb/0x1db0 fs/btrfs/volumes.c:807
 btrfs_scan_one_device+0x1b7/0x2a0 fs/btrfs/volumes.c:1405
 btrfs_mount_root+0x4a8/0xda0 fs/btrfs/super.c:1482
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1578
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5043:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 btrfs_close_devices+0x4cd/0x610 fs/btrfs/volumes.c:1207
 open_ctree+0x1c1/0x5710 fs/btrfs/disk-io.c:3612
 btrfs_fill_super fs/btrfs/super.c:1158 [inline]
 btrfs_mount_root+0x976/0xda0 fs/btrfs/super.c:1520
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1578
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880293c8c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 304 bytes inside of
 freed 512-byte region [ffff8880293c8c00, ffff8880293c8e00)

The buggy address belongs to the physical page:
page:ffffea0000a4f200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x293c8
head:ffffea0000a4f200 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012841c80 ffffea00008f2d00 dead000000000002
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4147, tgid 4147 (kworker/u4:3), ts 10970429937, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1567
 prep_new_page mm/page_alloc.c:1574 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3253
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4509
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_bprm+0x51/0xaf0 fs/exec.c:1514
 kernel_execve+0xaf/0x4e0 fs/exec.c:1989
 call_usermodehelper_exec_async+0x256/0x4c0 kernel/umh.c:110
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880293c8c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880293c8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880293c8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880293c8d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880293c8e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
