Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5B76497C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjG0H4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjG0H4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:56:07 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624DE49E4
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 00:52:49 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6bb0ba5fbcaso1253888a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 00:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444368; x=1691049168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVqo6YT5N3pCkLArgKJXvbOm2TEfjbnjh+8WdUdlNx8=;
        b=YxQcihdYxm+eKINlDEpvPIC9OX3M1u9BOK5WzzOpBg2OJX2mc2zjHxHKxJYJjjduJG
         EySJtJagRly7vvq++EaTR+1fQCE/3tKu8/RlD6vpwmY9QxSCXoe6xisItsgF5mqWzve8
         Gir8nOScUUvMcUpJgYgMqXORvuQs+fYW+GDnNlZ+2rLaRI13g8R93pKFy9+0eLFbHMqJ
         rpnqOJVTmKefTecVwYKCv0OnvrcrtMR2TzYx4Pl3oj/pZ3CbvljXimjNmdU35Pl90zlZ
         Cgm6edxxxn75AshNpr1OsRXJN5gexVASfQdr2rzrQjm0sB1Jpq5aDSj7YWXcIgw+Qzcu
         ByLA==
X-Gm-Message-State: ABy/qLbr7nG9mho8P47vKkzaW8knebvfshF3tE8hY9lFLOi2TC7UgLNP
        Pj0Lsim/mW8BO57gmeOV1yCEGE2jz/PO08wEClGmPjOez1Dr
X-Google-Smtp-Source: APBJJlHik+wG9JRMoxUWT5a2eLj4YrqdE0MjwSapTtdrTyySpVgYejbvm7h5XG7H449zRr+e48OXZ/pIWs9VnaKkW02NPr8nbtEI
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1650:b0:6af:9f8b:c606 with SMTP id
 h16-20020a056830165000b006af9f8bc606mr6614137otr.0.1690444368773; Thu, 27 Jul
 2023 00:52:48 -0700 (PDT)
Date:   Thu, 27 Jul 2023 00:52:48 -0700
In-Reply-To: <000000000000b4e906060113fd63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d07560601734039@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in
 nilfs_load_inode_block (2)
From:   syzbot <syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f0bc0b042fc mm: suppress mm fault logging if fatal signal..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1382e2f9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=74db8b3087f293d3a13a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15176d81a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132d93d9a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b15763fff0b8/disk-5f0bc0b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0b1ccb084b3/vmlinux-5f0bc0b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5a2e6f8db73/bzImage-5f0bc0b0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0fd90c1b386c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com

NILFS (loop4): discard dirty block: blocknr=25, size=4096
NILFS (loop4): disposed unprocessed dirty file(s) when detaching log writer
==================================================================
BUG: KASAN: slab-use-after-free in nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1030
Read of size 8 at addr ffff88802ba11030 by task syz-executor459/5018

CPU: 0 PID: 5018 Comm: syz-executor459 Not tainted 6.5.0-rc3-syzkaller-00025-g5f0bc0b042fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1030
 __nilfs_mark_inode_dirty+0xa5/0x280 fs/nilfs2/inode.c:1107
 nilfs_dirty_inode+0x164/0x200 fs/nilfs2/inode.c:1148
 __mark_inode_dirty+0x305/0xd90 fs/fs-writeback.c:2430
 mark_inode_dirty_sync include/linux/fs.h:2153 [inline]
 iput+0x1f2/0x8f0 fs/inode.c:1814
 nilfs_dispose_list+0x51d/0x5c0 fs/nilfs2/segment.c:816
 nilfs_detach_log_writer+0xaf1/0xbb0 fs/nilfs2/segment.c:2859
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:498
 generic_shutdown_super+0x134/0x340 fs/super.c:499
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2376
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa78ff75ee7
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe7acb7da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fa78ff75ee7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe7acb7e60
RBP: 00007ffe7acb7e60 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffe7acb8f20
R13: 00005555556ce700 R14: 431bde82d7b634db R15: 00007ffe7acb8ec4
 </TASK>

Allocated by task 7068:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 nilfs_find_or_create_root+0x137/0x4e0 fs/nilfs2/the_nilfs.c:851
 nilfs_attach_checkpoint+0x123/0x4d0 fs/nilfs2/super.c:550
 nilfs_fill_super+0x321/0x600 fs/nilfs2/super.c:1095
 nilfs_mount+0x637/0x950 fs/nilfs2/super.c:1343
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5018:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 nilfs_segctor_destroy fs/nilfs2/segment.c:2782 [inline]
 nilfs_detach_log_writer+0x8c1/0xbb0 fs/nilfs2/segment.c:2845
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:498
 generic_shutdown_super+0x134/0x340 fs/super.c:499
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2376
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802ba11000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff88802ba11000, ffff88802ba11100)

The buggy address belongs to the physical page:
page:ffffea0000ae8400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ba10
head:ffffea0000ae8400 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012841b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (init), ts 16455889560, free_ts 12781023907
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
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1076
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 smk_fetch+0x92/0x140 security/smack/smack_lsm.c:291
 smack_d_instantiate+0x8d7/0xb40 security/smack/smack_lsm.c:3547
 security_d_instantiate+0x9b/0xf0 security/security.c:3760
 d_splice_alias+0x6f/0x330 fs/dcache.c:3146
 ext4_lookup+0x284/0x750 fs/ext4/namei.c:1879
 __lookup_slow+0x282/0x3e0 fs/namei.c:1690
 lookup_slow+0x53/0x70 fs/namei.c:1707
 walk_component fs/namei.c:1998 [inline]
 link_path_walk+0x9c8/0xe70 fs/namei.c:2325
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
 vfree+0x186/0x2e0 mm/vmalloc.c:2842
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:2763
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296

Memory state around the buggy address:
 ffff88802ba10f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ba10f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802ba11000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802ba11080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ba11100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
