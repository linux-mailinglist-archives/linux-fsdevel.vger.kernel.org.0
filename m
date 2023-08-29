Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B578BD39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 05:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjH2D2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjH2D16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:27:58 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E848123
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 20:27:53 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bf703dd21fso38235685ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 20:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693279672; x=1693884472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDPKTIwDlYvm7zzsU2/yOXQF9Xuxc0XNFTO/v4Pa4UQ=;
        b=BZF4zYtmi6enyeSCeeEIOTfDtXNzkJWyrhGp7OS6undliGRrAH+dJSCCGKciN0Z0et
         hYKbfzXkru50LOmsQU9ZIO9jp4GXSyQtYXTlzzExenjFmHdUwggIsZRO3OFeOjAHXmh/
         pfwvh632Os4TGMc4Eb4CCAukp/I1AqWP9srQALYbXE2RvLGQ1TWnrmlIyVw8m9gRhuKV
         PiLwkgj1tl0mSeWUHjmwaB/orX/ULytv22uBHzXn9viAiTqeYMjyiyxXCAb/QBZQ2Gfq
         JNXsBdJSzn/crHJeNjpRhUvOo4B9iTzaJO2Xe96fsjtB5ZMOQvr6lN5AjlGF/uyu4Jo4
         eU3Q==
X-Gm-Message-State: AOJu0Yy2wwRB36B8fKbRSRNYvC4rrBI3E88EHzSAyCo1PGFM4/0MYpAx
        RyvTR5Po4Z+z6Zy6rpgedzIbnPaZQObB5es5TqwPq4PF2sTb
X-Google-Smtp-Source: AGHT+IGC/m3WZEZ4OM2rzqnGDS95J76gOa62+/mXiGZXFnedYUGD+7bFYEkt2PBg3CRxoh9WCL9aDIsSo6PbcSyZBgtgLJ8usXGi
MIME-Version: 1.0
X-Received: by 2002:a17:903:1d2:b0:1bd:e2ba:83d9 with SMTP id
 e18-20020a17090301d200b001bde2ba83d9mr9993560plh.7.1693279672666; Mon, 28 Aug
 2023 20:27:52 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:27:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006512230604076562@google.com>
Subject: [syzbot] [btrfs?] KASAN: use-after-free Read in btrfs_test_super
From:   syzbot <syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
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

HEAD commit:    626932085009 Add linux-next specific files for 20230825
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b1c0c0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8c992a790e5073
dashboard link: https://syzkaller.appspot.com/bug?extid=65bb53688b6052f09c28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ab89fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c9371fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46ec18b3c2fb/disk-62693208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4ea0cb78498/vmlinux-62693208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fb3938c7272/bzImage-62693208.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/29599ed4793a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65bb53688b6052f09c28@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid d552757d-9c39-40e3-95f0-16d819589928 devid 1 transid 8 /dev/loop0 scanned by syz-executor324 (6049)
==================================================================
BUG: KASAN: use-after-free in btrfs_test_super+0x9b/0xa0 fs/btrfs/super.c:1348
Read of size 8 at addr ffff88807812d110 by task syz-executor324/6049

CPU: 0 PID: 6049 Comm: syz-executor324 Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 btrfs_test_super+0x9b/0xa0 fs/btrfs/super.c:1348
 sget+0x3de/0x610 fs/super.c:861
 btrfs_mount_root+0x692/0xdd0 fs/btrfs/super.c:1508
 legacy_get_tree+0x109/0x220 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1585
 legacy_get_tree+0x109/0x220 fs/fs_context.c:638
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
RIP: 0033:0x7f4920f7088a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 06 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4920f29088 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4920f7088a
RDX: 00000000200055c0 RSI: 0000000020005600 RDI: 00007f4920f290a0
RBP: 00007f4920f290a0 R08: 00007f4920f290e0 R09: 00000000000055a2
R10: 0000000000000000 R11: 0000000000000282 R12: 00007f4920f290e0
R13: 0000000000000000 R14: 0000000000000003 R15: 0000000001000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001e04b40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x400000000 pfn:0x7812d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000400000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x152dc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 6045, tgid 6043 (syz-executor324), ts 596852111149, free_ts 598062789716
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0xf17/0x2e50 mm/page_alloc.c:3200
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4456
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1164
 __do_kmalloc_node mm/slab_common.c:1011 [inline]
 __kmalloc_node.cold+0x5/0xdd mm/slab_common.c:1030
 kmalloc_node include/linux/slab.h:619 [inline]
 kvmalloc_node+0x6f/0x1a0 mm/util.c:607
 kvmalloc include/linux/slab.h:737 [inline]
 kvzalloc include/linux/slab.h:745 [inline]
 btrfs_mount_root+0x130/0xdd0 fs/btrfs/super.c:1466
 legacy_get_tree+0x109/0x220 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1585
 legacy_get_tree+0x109/0x220 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x370 fs/super.c:1713
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
 kvfree+0x47/0x50 mm/util.c:653
 deactivate_locked_super+0xa0/0x2d0 fs/super.c:454
 deactivate_super+0xde/0x100 fs/super.c:504
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807812d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807812d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807812d100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff88807812d180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807812d200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
