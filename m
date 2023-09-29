Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32877B339A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjI2Nak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjI2Naj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:30:39 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE41A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 06:30:36 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c4f91d2f55so12809774a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 06:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994236; x=1696599036;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRNOjazCgZxRInrAu/EG3EloEQT1wA7khytYTiOstBY=;
        b=pEpJkzxDGQTyanFp7mm576/1jtNWNtLQ4FNBuGA08N5VdpztuQADJigJ4C59x7u/++
         fhlci7Y1nYXW/0QJKa9BgngH397HPKK6CxKugU8sDANsKG1Q3Q1Wxjkly/w29uwaDNok
         BR50sayUOXEtGLrZ8cZoSAg/7pHDK237oO8cOTRjM6BvyycVPJW91SavKvr340FM/kBP
         dr3sdbOhtvCgaolH9u0oMMGfa3+98qhUzBvhWoP/ivXGTAuUdW6Jrqtez1Ye+Jedpye/
         XxGVmMUcG6icrfcfBedgh/kkhNGTr2A1QxS1tsVjwQfLvNT+Rryr4KDvvyAFfXIag5mr
         YMaQ==
X-Gm-Message-State: AOJu0YwN2TyT3SlGv3qDrlpmq5FnNTbLY8b72hkhJCQw5VFSn/8z6AsY
        q45orIjjm4IvVWi5Tlmf0CwPGxV5LCFVPvTDOgupNkN6YJPV
X-Google-Smtp-Source: AGHT+IG2/uzRI5DpgoLeaVr/6ysi1sM8QGfvUuzPkV+ulJ5WJiaPIm9YoW1VJ6QZ0eSPBJuxzMHqpqa0HeQJY4df4VyKzYl2lKRX
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3d0c:b0:6b2:a87b:e441 with SMTP id
 eu12-20020a0568303d0c00b006b2a87be441mr1320911otb.3.1695994236261; Fri, 29
 Sep 2023 06:30:36 -0700 (PDT)
Date:   Fri, 29 Sep 2023 06:30:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe5ae806067f6d39@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in gfs2_qd_dealloc
From:   syzbot <syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6465e260f487 Linux 6.6-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ee3056680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11db4412680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483ceea680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2efb305347e3/disk-6465e260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9d60ae17a65/vmlinux-6465e260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f071608b2aba/bzImage-6465e260.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/87420f0aa338/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ba0642680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ba0642680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in gfs2_qd_dealloc+0x83/0xf0 fs/gfs2/quota.c:115
Write of size 4 at addr ffff888025754a78 by task ksoftirqd/0/16

CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 kasan_check_range+0x27e/0x290 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 gfs2_qd_dealloc+0x83/0xf0 fs/gfs2/quota.c:115
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0xacf/0x1790 kernel/rcu/tree.c:2403
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553
 run_ksoftirqd+0xc5/0x120 kernel/softirq.c:921
 smpboot_thread_fn+0x530/0x9f0 kernel/smpboot.c:164
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5055:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 init_sbd fs/gfs2/ops_fstype.c:77 [inline]
 gfs2_fill_super+0x136/0x26c0 fs/gfs2/ops_fstype.c:1164
 get_tree_bdev+0x416/0x5b0 fs/super.c:1577
 gfs2_get_tree+0x54/0x210 fs/gfs2/ops_fstype.c:1348
 vfs_get_tree+0x8c/0x280 fs/super.c:1750
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5030:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:693
 kill_block_super+0x41/0x70 fs/super.c:1646
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888025754000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2680 bytes inside of
 freed 8192-byte region [ffff888025754000, ffff888025756000)

The buggy address belongs to the physical page:
page:ffffea000095d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25750
head:ffffea000095d400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012842280 ffffea0000952e00 0000000000000002
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4714, tgid 4714 (dhcpcd-run-hook), ts 36549622906, free_ts 36548101490
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x11cd/0x2040 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x386/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x1383/0x1cf0 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security+0x114/0x170 security/tomoyo/tomoyo.c:101
 security_bprm_check+0x63/0xa0 security/security.c:1103
 search_binary_handler fs/exec.c:1727 [inline]
 exec_binprm fs/exec.c:1781 [inline]
 bprm_execve+0x8c7/0x17c0 fs/exec.c:1856
 do_execveat_common+0x580/0x720 fs/exec.c:1964
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
 put_cpu_partial+0x17b/0x250 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
 tomoyo_supervisor+0xe06/0x11f0 security/tomoyo/common.c:2095
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x1383/0x1cf0 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security+0x114/0x170 security/tomoyo/tomoyo.c:101
 security_bprm_check+0x63/0xa0 security/security.c:1103

Memory state around the buggy address:
 ffff888025754900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025754980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888025754a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888025754a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025754b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
