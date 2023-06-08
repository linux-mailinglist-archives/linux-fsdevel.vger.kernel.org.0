Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19A728632
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjFHRUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjFHRUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:20:03 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037330C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 10:19:49 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-769036b47a7so69892139f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 10:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244788; x=1688836788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UWOZ/aAH8nGV++7RZgvI2KPvZxYZPTcR78qFXSGSUE=;
        b=T4rFScG3y6rDccnd10CDIxb/VRBgBk2Awxpr3GXlTWqWrnkkKtNrJBQT30qtZcsBfd
         SjrCbpCh7Z4qKQi6yrtF4HX6MprRJL0LvSu0C9TGKsq+sWXM2llUfVQ2TAtoYKGm6QWC
         jeUdnIcds9cy3ME5VDxNaslmOgADApcpyNCD1nwkiC1KcH8BbjPkmfhlcHwr8GWKLPvk
         xoNve2b/xCHeVGZz5yCVhG9DKpg2LyA+S6ydx0GoUX1bXDOUUYuOcHqCaqGkU2GJ/e3N
         9dsCmT3LLAV2R1Ns+ezs1uPovZSqgPZ17dFPbAC53MPGasPzwTnxwJuoi1bsUlFvZ3Mj
         SDjQ==
X-Gm-Message-State: AC+VfDxxIv3bB0klbAh8jLnXm+fDeqU3shSw1Mynd22gnnUISfNXjgV9
        qqAWhOLLhzwCaZvvOZ/OK1pwvnUOBQD446x4KMUkSmsXF+PeCrKlaA==
X-Google-Smtp-Source: ACHHUZ6K7WuaDPSEWed7Zkwrw6uIxotMpt3r2ofdPNqxp69nHRy26OTokMCCDZ7atINBOeLzYpQiF6hgHS19IKh9vhpf8qQw6fQZ
MIME-Version: 1.0
X-Received: by 2002:a5e:c10b:0:b0:777:b315:f4fc with SMTP id
 v11-20020a5ec10b000000b00777b315f4fcmr4065083iol.2.1686244788713; Thu, 08 Jun
 2023 10:19:48 -0700 (PDT)
Date:   Thu, 08 Jun 2023 10:19:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2c13905fda1757e@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read_key
From:   syzbot <syzbot+4f7a1fc5ec86b956afb4@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e5282a7d8f6b Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a780b5280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4f7a1fc5ec86b956afb4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12feb345280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cb2a5280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/74387b33231f/disk-e5282a7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2da177a268c1/vmlinux-e5282a7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21aac70676e3/bzImage-e5282a7d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/934870c4002b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f7a1fc5ec86b956afb4@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=4991 'syz-executor175'
loop0: detected capacity change from 0 to 64
hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:417 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x440 fs/hfs/bnode.c:70
Write of size 256 at addr ffff88802a969a80 by task syz-executor175/4991

CPU: 1 PID: 4991 Comm: syz-executor175 Not tainted 6.4.0-rc4-syzkaller-00276-ge5282a7d8f6b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:417 [inline]
 hfs_bnode_read fs/hfs/bnode.c:35 [inline]
 hfs_bnode_read_key+0x314/0x440 fs/hfs/bnode.c:70
 hfs_brec_insert+0x6a1/0xbd0 fs/hfs/brec.c:141
 hfs_cat_create+0x5df/0xa70 fs/hfs/catalog.c:131
 hfs_create+0x66/0xd0 fs/hfs/dir.c:202
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ff084cb39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee0060a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2ff084cb39
RDX: 0000000000141842 RSI: 0000000020000380 RDI: 00000000ffffff9c
RBP: 00007f2ff080c140 R08: 0000000000000260 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2ff080c1d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 4991:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 hfs_find_init+0x90/0x1f0 fs/hfs/bfind.c:21
 hfs_cat_create+0x182/0xa70 fs/hfs/catalog.c:96
 hfs_create+0x66/0xd0 fs/hfs/dir.c:202
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802a969a80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 allocated 78-byte region [ffff88802a969a80, ffff88802a969ace)

The buggy address belongs to the physical page:
page:ffffea0000aa5a40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a969
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4454, tgid 4454 (udevd), ts 19438667625, free_ts 19434626307
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x530 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x598/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x28d/0x700 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x18f/0x480 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x14f/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x14c/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x530 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x598/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x28d/0x700 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x18f/0x480 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x14f/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802a969980: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff88802a969a00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88802a969a80: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff88802a969b00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802a969b80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
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
