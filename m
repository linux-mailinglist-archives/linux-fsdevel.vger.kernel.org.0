Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E4790820
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Sep 2023 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjIBNoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Sep 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjIBNoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:44:22 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1551E5B
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Sep 2023 06:44:18 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1c08a6763b3so36115905ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Sep 2023 06:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693662257; x=1694267057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTB86TxGmPTeEkOZYc6t4ICU4OtsSRCkAk9evBME2Wc=;
        b=ADJh06Uu4Z8mA3jFlZ5xqKuwV4qlBO1yqITgJK+ljQx4QSRMhDZYv/ky9gGHhIGKBY
         gSmAVZqhyAys0xAJ/tFmoXQa5oK8zq3zXxM9UH6VvTF88bcMVNuXo27DuDEB6PaAhsZG
         2VxYfDrSj9oXFx8Ywdk7WvOiPh+/7qRfnUeeYlP2xR2Tqizv3NLMjVn6LGrN6F/g+H6e
         9leh0V46oMERVMcdx9zGagAgY7QTgFHUJL3S4pot1PA6dS1rnvVQZaWHWNIkYuWBosrt
         mVynypmqmVQM6j5x2eSw+ewBQMoBFeIRKLBa5Fze7ZliimNZlINDipsCiMDxpaS/HTfK
         ETcg==
X-Gm-Message-State: AOJu0YxVINaexohS/6CssKY2oYBDpEaMzHDWyczafw0Dw6tM0cdnQYL1
        T6J1ix3v3by2UGjx5gJmpyMArmsd+jO/ve0oz0RVR9sW6Ds5
X-Google-Smtp-Source: AGHT+IExpOnFtDdT/k5bgP7VXfHJYstcNLL/u65c29vEr+V19UpxParnkBdVEwUxDa2v8EXUiSc2z53VuIo8wIJqTH37REjQmoZ4
MIME-Version: 1.0
X-Received: by 2002:a17:903:5c5:b0:1ba:a36d:f82c with SMTP id
 kf5-20020a17090305c500b001baa36df82cmr1429128plb.7.1693662257366; Sat, 02 Sep
 2023 06:44:17 -0700 (PDT)
Date:   Sat, 02 Sep 2023 06:44:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003849fc0604607941@google.com>
Subject: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_test_super
From:   syzbot <syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com>
To:     brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    1c59d383390f Merge tag 'linux-kselftest-nolibc-6.6-rc1' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f80797a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4940ad7c14cda5c7
dashboard link: https://syzkaller.appspot.com/bug?extid=629c4f1a4cefe03f8985
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115b0c70680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170267b7a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6c588f544ac/disk-1c59d383.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bab40745ca7b/vmlinux-1c59d383.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8f42a5537c/bzImage-1c59d383.xz

The issue was bisected to:

commit 2c18a63b760a0f68f14cb8bb4c3840bb0b63b73e
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Aug 18 14:00:51 2023 +0000

    super: wait until we passed kill super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121f9267a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111f9267a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=161f9267a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+629c4f1a4cefe03f8985@syzkaller.appspotmail.com
Fixes: 2c18a63b760a ("super: wait until we passed kill super")

==================================================================
BUG: KASAN: slab-use-after-free in afs_dynroot_test_super+0x56/0xc0 fs/afs/super.c:434
Read of size 8 at addr ffff8880281e8880 by task syz-executor420/5500

CPU: 1 PID: 5500 Comm: syz-executor420 Not tainted 6.5.0-syzkaller-01207-g1c59d383390f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 afs_dynroot_test_super+0x56/0xc0 fs/afs/super.c:434
 sget_fc+0x145/0x750 fs/super.c:778
 afs_get_tree+0x39c/0x1120 fs/afs/super.c:577
 vfs_get_tree+0x8c/0x280 fs/super.c:1711
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1cfedceba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9054a668 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f1cfedceba9
RDX: 0000000020000440 RSI: 0000000020000400 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000020000480 R09: 00000000000000a0
R10: 0000000002010800 R11: 0000000000000246 R12: 000000000000e5e3
R13: 00007fff9054a67c R14: 00007fff9054a690 R15: 00007fff9054a680
 </TASK>

Allocated by task 5498:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 afs_alloc_sbi fs/afs/super.c:509 [inline]
 afs_get_tree+0xbb/0x1120 fs/afs/super.c:571
 vfs_get_tree+0x8c/0x280 fs/super.c:1711
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5498:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 deactivate_locked_super+0xa5/0x200 fs/super.c:454
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2376
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880281e8880
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff8880281e8880, ffff8880281e88a0)

The buggy address belongs to the physical page:
page:ffffea0000a07a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x281e8
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012841500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 29, tgid 29 (kworker/u4:2), ts 9917762773, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 alloc_slab_page+0x6a/0x160 mm/slub.c:1862
 allocate_slab mm/slub.c:2009 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2062
 ___slab_alloc+0xade/0x1100 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314 [inline]
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 lsm_task_alloc security/security.c:653 [inline]
 security_task_alloc+0x43/0x130 security/security.c:2844
 copy_process+0x1832/0x4290 kernel/fork.c:2494
 kernel_clone+0x22d/0x7b0 kernel/fork.c:2920
 user_mode_thread+0x132/0x190 kernel/fork.c:2998
 call_usermodehelper_exec_work+0x5c/0x220 kernel/umh.c:172
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880281e8780: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880281e8800: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880281e8880: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff8880281e8900: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880281e8980: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
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
