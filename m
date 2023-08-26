Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA92E789619
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjHZKuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHZKuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:50:01 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80B2110
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 03:49:56 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68bf47ff13cso1659386b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693046996; x=1693651796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSS8DfyHn/D3xhSuBxsI/bNXPLL5olC9WVQbMdKPZAU=;
        b=caqXYJdbQLRCXu1KIvoPa5vGSUAT5oG5PEml0yGoO3Am4VBDLOT2Vglm1JIDK7gQu/
         M+8WOBpGgfJJcXk6z+TymC+qzV3EYaHJcox+PSsxt9IC8CTrdgZDkeDh5V17uf3pFiBB
         7m5wtRUKx/tsy0OyZXsd27C19019r3Svdajhw8G/BwxN87M2G+kmbHJxppXSmV6M6BJF
         Ge3Dl2yMId8RXo9TPOtFwAQUDlvNgaUeCSdUCMIPHTkyKik7Ts5UPw6ILWAPQfvdaXYn
         nxblrgwW7FcO+gMhI9+Ne+gfVBB+FfQfkgjd4DJSecF6fhKSvc5yb8n2ShJWVswjKawK
         hTOg==
X-Gm-Message-State: AOJu0YwNq8HlB4Z7eeq778rAcbUNDsJNymSVZU5ADd4XFctpN+aIWI6R
        1XrreQt7pinbR4VGxlTo7CSP1TQRC0ZoAVamFrZ3yRSqA823
X-Google-Smtp-Source: AGHT+IHsIT2BvJOWozqV3GMB8RD0Q6jFalQxepoN8gW8OafhtCjll2I0RCNAWduy/asG/eHohsl70MboFK8DaSAzgxfjGjasncVS
MIME-Version: 1.0
X-Received: by 2002:a63:3d07:0:b0:565:e2cd:c9e1 with SMTP id
 k7-20020a633d07000000b00565e2cdc9e1mr3293642pga.11.1693046996145; Sat, 26 Aug
 2023 03:49:56 -0700 (PDT)
Date:   Sat, 26 Aug 2023 03:49:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb1dec0603d13898@google.com>
Subject: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in ceph_compare_super
From:   syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
To:     brauner@kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com,
        jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    28c736b0e92e Add linux-next specific files for 20230822
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11400507a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=2b8cbfa6e34e51b6aa50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1298bdd3a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11adcca7a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37bc881cd0b2/disk-28c736b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4512f7892b3d/vmlinux-28c736b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/052fe1287e05/bzImage-28c736b0.xz

The issue was bisected to:

commit 2c18a63b760a0f68f14cb8bb4c3840bb0b63b73e
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Aug 18 14:00:51 2023 +0000

    super: wait until we passed kill super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1593bd97a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1793bd97a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1393bd97a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com
Fixes: 2c18a63b760a ("super: wait until we passed kill super")

==================================================================
BUG: KASAN: slab-use-after-free in memcmp+0x1b5/0x1c0 lib/string.c:681
Read of size 8 at addr ffff8880772b2780 by task syz-executor410/5427

CPU: 0 PID: 5427 Comm: syz-executor410 Not tainted 6.5.0-rc7-next-20230822-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 memcmp+0x1b5/0x1c0 lib/string.c:681
 memcmp include/linux/fortify-string.h:728 [inline]
 compare_mount_options fs/ceph/super.c:622 [inline]
 ceph_compare_super+0x11a/0x8d0 fs/ceph/super.c:1147
 sget_fc+0x582/0x9b0 fs/super.c:778
 ceph_get_tree+0x6ea/0x1910 fs/ceph/super.c:1232
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 vfs_cmd_create+0x11f/0x2f0 fs/fsopen.c:230
 vfs_fsconfig_locked fs/fsopen.c:294 [inline]
 __do_sys_fsconfig+0x832/0xb90 fs/fsopen.c:475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc6399b13d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc639972238 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007fc639a3b328 RCX: 00007fc6399b13d9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007fc639a3b320 R08: 0000000000000000 R09: 00007fc6399726c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc639a08064
R13: 0000000000000000 R14: 00007fffb7a44050 R15: 00007fffb7a44138
 </TASK>

Allocated by task 5415:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ceph_init_fs_context+0xc8/0x530 fs/ceph/super.c:1333
 alloc_fs_context+0x56c/0x9f0 fs/fs_context.c:294
 __do_sys_fsopen fs/fsopen.c:137 [inline]
 __se_sys_fsopen fs/fsopen.c:115 [inline]
 __x64_sys_fsopen+0xeb/0x230 fs/fsopen.c:115
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5415:
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
 destroy_mount_options fs/ceph/super.c:599 [inline]
 destroy_mount_options+0xe9/0x140 fs/ceph/super.c:588
 destroy_fs_client+0x1b6/0x2b0 fs/ceph/super.c:860
 deactivate_locked_super+0xa0/0x2d0 fs/super.c:454
 ceph_get_tree+0x1270/0x1910 fs/ceph/super.c:1267
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 vfs_cmd_create+0x11f/0x2f0 fs/fsopen.c:230
 vfs_fsconfig_locked fs/fsopen.c:294 [inline]
 __do_sys_fsconfig+0x832/0xb90 fs/fsopen.c:475
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880772b2780
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff8880772b2780, ffff8880772b27e0)

The buggy address belongs to the physical page:
page:ffffea0001dcac80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x772b2
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5404, tgid 5400 (syz-executor410), ts 75501157693, free_ts 75473204266
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
 kmalloc_array include/linux/slab.h:636 [inline]
 ceph_msg_new2+0x34e/0x4f0 net/ceph/messenger.c:1916
 msgpool_alloc+0xa8/0x1c0 net/ceph/msgpool.c:17
 mempool_init_node+0x2ec/0x5a0 mm/mempool.c:207
 mempool_create_node mm/mempool.c:276 [inline]
 mempool_create+0x7f/0xd0 mm/mempool.c:261
 ceph_msgpool_init+0xd0/0x190 net/ceph/msgpool.c:46
 ceph_osdc_init+0x6f9/0xc60 net/ceph/osd_client.c:5193
 ceph_create_client net/ceph/ceph_common.c:745 [inline]
 ceph_create_client+0x27e/0x360 net/ceph/ceph_common.c:707
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page_list+0xe6/0xb30 mm/page_alloc.c:2481
 release_pages+0x32a/0x14e0 mm/swap.c:1042
 tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:98
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu mm/mmu_gather.c:300 [inline]
 tlb_finish_mmu+0x14b/0x6f0 mm/mmu_gather.c:392
 exit_mmap+0x38b/0xa60 mm/mmap.c:3223
 __mmput+0x12a/0x4d0 kernel/fork.c:1356
 mmput+0x62/0x70 kernel/fork.c:1378
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b4/0x2a20 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23d1/0x27b0 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880772b2680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880772b2700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880772b2780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff8880772b2800: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff8880772b2880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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
