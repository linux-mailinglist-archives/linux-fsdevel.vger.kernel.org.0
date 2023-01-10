Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE851664755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 18:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjAJRWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbjAJRVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:21:52 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104C5AC4B
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 09:21:43 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id t15-20020a5d81cf000000b006f95aa9ba6eso7312431iol.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 09:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fG5/9wCt2/DeBJtWFKEXgRT6q2M2jXQCQk4FnD0m+5U=;
        b=kdjlRP8u4OJqnKcZrmoL+o13B02joSIYioZ8nLL4z4fnETU5N50ITTrViZpv6a3/dL
         OzkjRBsy3HZ49ze63OwsWhrVq1HVDM7px4w3FnooNRbusPNfndxGnXbN5s8zvuFRTIcP
         J0/lfp24RH/o7xO2uP8Kvie8Tn5253qzlJY1j69gWElTzJJ8y/GUK2ovTQrs2SEK1D05
         Jcdm9Emc5MOV3lM/0TJlX0GOiBbG2bCEwG2bx2Xdv7NF6chzuc8YVpzlfmwr1mSwcyvZ
         6BkmOhBwVkqZrVkVEa5YFElssb3eKIoNQMZurKiC3lIYwL490PbAnHrfu8vGvoFZQF8c
         3ghQ==
X-Gm-Message-State: AFqh2kr5H0hgqcXVc19Z9QvGFKxJf00cFaTQWHKM1DXtySDl/n++9b90
        RUBnIdfsGkOZS5Zo/+nw8C2njpyGikys2W10q4RYSBhaq2u0
X-Google-Smtp-Source: AMrXdXt+h0mIA5LHlZbABShqmkRZCHNaaQ0M4dcSbBHLxGpYVTt/uQtiSU1R5WEhkX9lUFs0Fg12rSu5BdsG0HLobV/1KU1YKpfT
MIME-Version: 1.0
X-Received: by 2002:a92:1a41:0:b0:303:929:dc8d with SMTP id
 z1-20020a921a41000000b003030929dc8dmr8754578ill.118.1673371303140; Tue, 10
 Jan 2023 09:21:43 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:21:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019ea1505f1ec1e26@google.com>
Subject: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Read in filemap_get_read_batch
From:   syzbot <syzbot+9d9efb38bb1425ff6283@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1042b176480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=9d9efb38bb1425ff6283
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1187a762480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/041403c21ee3/disk-41c03ba9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/579dec11b65a/vmlinux-41c03ba9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcb6cfc03c78/bzImage-41c03ba9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8d89f17a9699/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d9efb38bb1425ff6283@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
BUG: KASAN: stack-out-of-bounds in arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
BUG: KASAN: stack-out-of-bounds in arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5671
Read of size 8 at addr ffffc9000473727f by task syz-executor.0/5208

CPU: 0 PID: 5208 Comm: syz-executor.0 Not tainted 6.2.0-rc2-syzkaller-00057-g41c03ba9beea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
 arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
 arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
 lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5671
 rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:325
 rcu_read_lock include/linux/rcupdate.h:764 [inline]
 filemap_get_read_batch+0x15a/0xe00 mm/filemap.c:2379
 filemap_get_pages+0x47c/0x10d0 mm/filemap.c:2602
 filemap_read+0x3cf/0xea0 mm/filemap.c:2694
 call_read_iter include/linux/fs.h:2180 [inline]
 generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa9e708c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa9e7dcd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa9e71abf80 RCX: 00007fa9e708c0c9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fa9e70e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffa R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3f108fdf R14: 00007fa9e7dcd300 R15: 0000000000022000
 </TASK>

The buggy address belongs to stack of task syz-executor.0/5208
 and is located at offset 31 in frame:
 lock_acquire+0x0/0x3c0 kernel/locking/lockdep.c:5623

This frame has 3 objects:
 [32, 40) 'flags.i.i.i87'
 [64, 72) 'flags.i.i.i'
 [96, 136) 'hlock'

The buggy address belongs to the virtual mapping at
 [ffffc90004730000, ffffc90004739000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:987

The buggy address belongs to the physical page:
page:ffffea0001dcdb40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7736d
memcg:ffff8880200d6682
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff8880200d6682
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5195, tgid 5195 (syz-executor.1), ts 61000027517, free_ts 60960682032
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x9b2/0x1400 mm/vmalloc.c:3227
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:311
 dup_task_struct+0x8b/0x490 kernel/fork.c:987
 copy_process+0x53c/0x3f00 kernel/fork.c:2097
 kernel_clone+0x21b/0x630 kernel/fork.c:2681
 __do_sys_clone kernel/fork.c:2822 [inline]
 __se_sys_clone kernel/fork.c:2806 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2806
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page_list+0xb2/0x830 mm/page_alloc.c:3510
 release_pages+0x233e/0x25e0 mm/swap.c:1076
 __pagevec_release+0x7d/0xf0 mm/swap.c:1096
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 truncate_inode_pages_range+0x452/0x1690 mm/truncate.c:372
 kill_bdev block/bdev.c:76 [inline]
 blkdev_flush_mapping+0x153/0x2c0 block/bdev.c:662
 blkdev_put_whole block/bdev.c:693 [inline]
 blkdev_put+0x4a5/0x730 block/bdev.c:953
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc90004737100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004737180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004737200: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
                                                                ^
 ffffc90004737280: 00 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 f3 f3 f3
 ffffc90004737300: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
