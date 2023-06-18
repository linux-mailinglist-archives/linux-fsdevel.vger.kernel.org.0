Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81F73448A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 02:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjFRAYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFRAYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:24:01 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4F1733
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 17:23:59 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77ac4ec0bb7so163697239f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 17:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687047839; x=1689639839;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzhFHvEiw2Iy18UyD0iJdSi5zJ0xOqiPpgBwI0LaJoM=;
        b=bFOUUXjs5NEskRLaT3mT0C6EpMg4pYDAodSfK5luYyxosvSZufd261++2EAGXkxcSh
         3UmfTW619LHT4UpA+xqixcBvAxpYin9tjlTk5G2A+Tixt0uBgunz+sWYSOGgDSIKugrK
         edptx33OqIV6VgWCDmDxXMW5rBtlhV0Nf64gS0LdpXZGrl01+7uZ2KOlUO6xEgmuT1FM
         fwresVST2RN5Y2TuvbCLM2ccvLfzVz9lTWEN6prj/hfP0GrnCZ5bYVomyGzgOrhbX3Qn
         3hczaIQwIRQDHKiWh4IJm3ho6jxpgGyliKPI7x7B+X6Q0NHuhBXpJSMfXs9Yd2/Orfp+
         gXTw==
X-Gm-Message-State: AC+VfDwCvx35LGazExiamT+yOB0cI7Tr7DHtSGnq5UMSA9vCSEQhjTtM
        D1unHSeVLJR75+Hfupv4yAzMaInGMU/fNo3PF0riYA9QNQy8
X-Google-Smtp-Source: ACHHUZ5BvB8OzrHboiOZaYtsxTJlm4QBE71x/rB/xcVYzaUkN0O20hU7Ha3UyzUpHj8lsDF5vdUgONn9Vpy7XNFt4qwuYnl7sogm
MIME-Version: 1.0
X-Received: by 2002:a6b:3b8b:0:b0:777:b0ee:a512 with SMTP id
 i133-20020a6b3b8b000000b00777b0eea512mr1802544ioa.2.1687047838984; Sat, 17
 Jun 2023 17:23:58 -0700 (PDT)
Date:   Sat, 17 Jun 2023 17:23:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029729c05fe5c6f5c@google.com>
Subject: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_pack_data
From:   syzbot <syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    15adb51c04cc Merge tag 'devicetree-fixes-for-6.4-3' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17554263280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3731e922b1097b2e
dashboard link: https://syzkaller.appspot.com/bug?extid=b7854dc75e15ffc8c2ae
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1323469d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12975795280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/733f46de69b0/disk-15adb51c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9a6a2c566b8/vmlinux-15adb51c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55e80680ef0e/bzImage-15adb51c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/99d5407c555b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com

xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
XFS (loop0): Unmounting Filesystem acfebfcd-0806-4e27-9777-0ac4ff5ddf54
==================================================================
BUG: KASAN: slab-out-of-bounds in xlog_pack_data+0x370/0x540 fs/xfs/xfs_log.c:1822
Read of size 4 at addr ffff888075c64e00 by task syz-executor205/4996

CPU: 0 PID: 4996 Comm: syz-executor205 Not tainted 6.4.0-rc6-syzkaller-00035-g15adb51c04cc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 xlog_pack_data+0x370/0x540 fs/xfs/xfs_log.c:1822
 xlog_sync+0x366/0xd50 fs/xfs/xfs_log.c:2093
 xlog_state_release_iclog+0x46d/0x7f0 fs/xfs/xfs_log.c:619
 xlog_force_iclog fs/xfs/xfs_log.c:888 [inline]
 xlog_force_and_check_iclog fs/xfs/xfs_log.c:3172 [inline]
 xlog_force_lsn+0x5e5/0x770 fs/xfs/xfs_log.c:3344
 xfs_log_force_seq+0x1da/0x450 fs/xfs/xfs_log.c:3409
 __xfs_trans_commit+0xb38/0x11d0 fs/xfs/xfs_trans.c:1021
 xfs_sync_sb+0x140/0x190 fs/xfs/libxfs/xfs_sb.c:1015
 xfs_log_cover fs/xfs/xfs_log.c:1300 [inline]
 xfs_log_quiesce+0x38f/0x680 fs/xfs/xfs_log.c:1109
 xfs_log_clean+0xa4/0xc10 fs/xfs/xfs_log.c:1116
 xfs_log_unmount+0x2c/0x1c0 fs/xfs/xfs_log.c:1131
 xfs_unmountfs+0x1d6/0x280 fs/xfs/xfs_mount.c:1096
 xfs_fs_put_super+0x74/0x2d0 fs/xfs/xfs_super.c:1130
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7ff46d4999
Code: Unable to access opcode bytes at 0x7f7ff46d496f.
RSP: 002b:00007ffde997c8a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7ff4756330 RCX: 00007f7ff46d4999
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 000000000000c157
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7ff4756330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001d71000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75c40
head:ffffea0001d71000 order:6 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010000(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 6, migratetype Unmovable, gfp_mask 0x46dc0(GFP_KERNEL|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_ZERO), pid 4996, tgid 4996 (syz-executor205), ts 65296013335, free_ts 18373394447
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x91/0x1d0 mm/slab_common.c:1107
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node+0x116/0x230 mm/slab_common.c:973
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:604
 kvmalloc include/linux/slab.h:697 [inline]
 kvzalloc include/linux/slab.h:705 [inline]
 xlog_alloc_log+0x638/0x13a0 fs/xfs/xfs_log.c:1649
 xfs_log_mount+0xe7/0x770 fs/xfs/xfs_log.c:658
 xfs_mountfs+0xcbf/0x1f10 fs/xfs/xfs_mount.c:819
 xfs_fs_fill_super+0xfd7/0x1230 fs/xfs/xfs_super.c:1694
 get_tree_bdev+0x405/0x620 fs/super.c:1303
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6994
 destroy_args+0x102/0x9a0 mm/debug_vm_pgtable.c:1023
 debug_vm_pgtable+0x405/0x490 mm/debug_vm_pgtable.c:1403
 do_one_initcall+0x23d/0x7d0 init/main.c:1246
 do_initcall_level+0x157/0x210 init/main.c:1319
 do_initcalls+0x3f/0x80 init/main.c:1335
 kernel_init_freeable+0x43b/0x5d0 init/main.c:1571
 kernel_init+0x1d/0x2a0 init/main.c:1462
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888075c64d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888075c64d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888075c64e00: 01 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff888075c64e80: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888075c64f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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
