Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBA3C6918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 06:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGMEPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 00:15:11 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33382 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhGMEPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 00:15:10 -0400
Received: by mail-il1-f199.google.com with SMTP id b8-20020a92c8480000b0290208fe58bd16so5984940ilq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 21:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ccpUymmYMJnlE4BtUzanLseXkHW29GGGmHbpFP8ZztM=;
        b=DcioRJhFNjG2vP16z9suvsQGN0/jWfrnkIt0d8iXxYMlZt1pSj0yCksU8rgnCCEfic
         9brCnLCHbPXsNcDDbI+cHvy67WTToW0UGesgLCT8Xm5eg0Pr8kEkr1V/drnID/M8ufh2
         iVq+fbfEHKxzplroFTn2iUX2qLj8TizPtUCV2VU3ETBRgD8xXfYOH/XK0/4HDvdqV27i
         dRyvhiKO6fI5nqJrfi05f8H6mENmpoaFOjzl7j8oNCHGOQSzDLCNrmCSVxYV1lSgJV1t
         lRebHG+SdjjJQ/CWLbISBAEcJogdyyBU6atOfUjzZJEOse/1dtTQ0f/2nxd6dgCjIAAI
         RB3w==
X-Gm-Message-State: AOAM530b8qX/i4pekSBlIciBh7PDfI3VqjAvwxWeTIgXMGdQbddtODMS
        0CahWnRM714f5nL7T0Obtn4OotzRE9q0iHC5w1qVmwyAfk15
X-Google-Smtp-Source: ABdhPJyqv6fEm3KCkuMLgXE0cTLtuqsqJcimr+C6aG/c2PHeFwoVQdUBgejJq1zdGv8qJY6Jfm6iI23TaweAYv4EhkWCev7oZfDE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3155:: with SMTP id m21mr1705310ioy.145.1626149540071;
 Mon, 12 Jul 2021 21:12:20 -0700 (PDT)
Date:   Mon, 12 Jul 2021 21:12:20 -0700
In-Reply-To: <00000000000069c40405be6bdad4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b00c1105c6f971b2@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     brauner@kernel.org, christian.brauner@ubuntu.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gscrivan@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7fef2edf sd: don't mess with SD_MINORS for CONFIG_DEBUG_BL..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178919b0300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20276914ec6ad813
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120220f2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115f37b4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic64_read include/asm-generic/atomic-instrumented.h:605 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: use-after-free in filp_close+0x22/0x170 fs/open.c:1306
Read of size 8 at addr ffff888025a40a78 by task syz-executor493/8445

CPU: 1 PID: 8445 Comm: syz-executor493 Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:605 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 filp_close+0x22/0x170 fs/open.c:1306
 close_fd+0x5c/0x80 fs/file.c:628
 __do_sys_close fs/open.c:1331 [inline]
 __se_sys_close fs/open.c:1329 [inline]
 __x64_sys_close+0x2f/0xa0 fs/open.c:1329
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4021b3
Code: c7 c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffe62cc73e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004021b3
RDX: 0000000020000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007ffe62cc73f8 R08: 0000000000000004 R09: 00000000004aa000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe62cc7400
R13: 0000000000000000 R14: 00000000004ad018 R15: 0000000000400488

Allocated by task 8445:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2981 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 kmem_cache_alloc+0x216/0x3a0 mm/slub.c:2994
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __alloc_file+0x21/0x280 fs/file_table.c:101
 alloc_empty_file+0x6d/0x170 fs/file_table.c:150
 path_openat+0xde/0x27f0 fs/namei.c:3493
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_creat fs/open.c:1294 [inline]
 __se_sys_creat fs/open.c:1288 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1288
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8445:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1650 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1675
 slab_free mm/slub.c:3235 [inline]
 kfree+0xeb/0x650 mm/slub.c:4295
 put_fs_context+0x3fb/0x650 fs/fs_context.c:454
 fscontext_release+0x4c/0x60 fs/fsopen.c:73
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3029 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3109
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
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 task_work_add+0x3a/0x190 kernel/task_work.c:38
 fput_many.part.0+0xbb/0x170 fs/file_table.c:341
 fput_many fs/file_table.c:336 [inline]
 fput+0x3b/0x50 fs/file_table.c:357
 path_openat+0x19bd/0x27f0 fs/namei.c:3516
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_open fs/open.c:1228 [inline]
 __se_sys_open fs/open.c:1224 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1224
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888025a40a00
 which belongs to the cache filp of size 464
The buggy address is located 120 bytes inside of
 464-byte region [ffff888025a40a00, ffff888025a40bd0)
The buggy address belongs to the page:
page:ffffea0000969000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25a40
head:ffffea0000969000 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 0000000b00000001 ffff8880109c4780
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4875, ts 15466439710, free_ts 15379402342
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4166
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5374
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 alloc_slab_page mm/slub.c:1713 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1853
 new_slab mm/slub.c:1916 [inline]
 new_slab_objects mm/slub.c:2662 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2825
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2865
 slab_alloc_node mm/slub.c:2947 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 kmem_cache_alloc+0x372/0x3a0 mm/slub.c:2994
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __alloc_file+0x21/0x280 fs/file_table.c:101
 alloc_empty_file+0x6d/0x170 fs/file_table.c:150
 path_openat+0xde/0x27f0 fs/namei.c:3493
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_open fs/open.c:1228 [inline]
 __se_sys_open fs/open.c:1224 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1224
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1343 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1394
 free_unref_page_prepare mm/page_alloc.c:3329 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3408
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2981 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 __kmalloc+0x1f4/0x330 mm/slub.c:4133
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2031 [inline]
 tomoyo_supervisor+0xce8/0xf00 security/tomoyo/common.c:2103
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1332
 vfs_getattr fs/stat.c:139 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 vfs_lstat include/linux/fs.h:3386 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888025a40900: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ffff888025a40980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025a40a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888025a40a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025a40b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

