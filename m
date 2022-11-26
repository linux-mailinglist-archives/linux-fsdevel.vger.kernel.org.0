Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7816163945F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKZIHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKZIHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:07:48 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C69EE22
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id n10-20020a056e02140a00b00302aa23f73fso4364133ilo.20
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukvzxqV49zDp3iRI1V/n+8JkDY4VqvXKp4UghgVzXZQ=;
        b=ZiNjuRernn1UpB6hp10/FH69L3SH0sUBYKCEUlXHqSFuQlT2k4+LPX6wAqyikHzFpP
         57hgduzzT0VSTPyzdYHJAThZdNKJp89BeIih3u0MFTG4ro81sqFPwJ0hgq+ZZB3vGLd9
         AMjAVKdFAHPt5W52WCwOD32ZIp2IL9jMSTjRFfWDoBo2Sc3xCKzmIa1LdqHL2J2N+yLZ
         jO67zVhQLY8Kj92SlcTvjjaaP7LkgGNKO0lcZKLCEB1UU0zfjPVC3Hm5QvKRgd9AI+U7
         ZNmK72abO46sQoABZEPV7HpQJakJsfjqMiGXMvdkjoDPyP8SOoKN43MEUJ6dNuduwOru
         WlyA==
X-Gm-Message-State: ANoB5pnhZHyIwjRH03UI7ZojzcF+B41oltd5kryEZt1Ec7A/dhLFv9eg
        8CgcOKwCJG+tFuejs6OMEGT2LfL1Tt+JhK3QGBWo5i1Sc+3E
X-Google-Smtp-Source: AA0mqf5ic91Yeb3eUdVaq0oN0tOBj3QoR+eKbjAjON40wO9FS8vXBlNbJ1QBLyiQtudbd3Zjec08d+RqL7M2DTrV93qs0NnUF/Om
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f52:b0:302:b44f:a09 with SMTP id
 y18-20020a056e020f5200b00302b44f0a09mr11915242ilj.227.1669450066177; Sat, 26
 Nov 2022 00:07:46 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:07:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a358205ee5b22d8@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in hfsplus_bnode_read
From:   syzbot <syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
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

HEAD commit:    08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17cff803880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cbcd9b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159f6203880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e40e255b7cf8/disk-08ad43d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfabe238c5ee/vmlinux-08ad43d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bcb24a7bbed/bzImage-08ad43d5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d00af50dfdf3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
hfsplus: request for non-existent node 184549376 in B*Tree
hfsplus: request for non-existent node 184549376 in B*Tree
==================================================================
BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0xc9/0x200 fs/hfsplus/bnode.c:32
Read of size 8 at addr ffff888012bf6bc0 by task syz-executor329/3631

CPU: 0 PID: 3631 Comm: syz-executor329 Not tainted 6.1.0-rc6-syzkaller-00176-g08ad43d554ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfsplus_bnode_read+0xc9/0x200 fs/hfsplus/bnode.c:32
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
 hfsplus_bnode_dump+0x29a/0x530 fs/hfsplus/bnode.c:321
 hfsplus_brec_remove+0x430/0x4f0 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x219/0x3d0 fs/hfsplus/attributes.c:299
 hfsplus_delete_all_attrs+0x292/0x430 fs/hfsplus/attributes.c:378
 hfsplus_delete_cat+0xa64/0xe90 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x342/0x7d0 fs/hfsplus/dir.c:385
 vfs_unlink+0x357/0x5f0 fs/namei.c:4251
 do_unlinkat+0x484/0x940 fs/namei.c:4319
 __do_sys_unlink fs/namei.c:4367 [inline]
 __se_sys_unlink fs/namei.c:4365 [inline]
 __x64_sys_unlink+0x45/0x50 fs/namei.c:4365
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa8ed312769
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffef8b858 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8ed312769
RDX: 00007fa8ed2d0de3 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007fa8ed2d2000 R08: 00000000000005f0 R09: 0000000000000000
R10: 00007ffffef8b720 R11: 0000000000000246 R12: 00007fa8ed2d2090
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3631:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 __hfs_bnode_create+0xec/0x7f0 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x23d/0xd80 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x145/0x520 fs/hfsplus/bfind.c:183
 hfsplus_find_attr fs/hfsplus/attributes.c:160 [inline]
 hfsplus_delete_all_attrs+0x269/0x430 fs/hfsplus/attributes.c:371
 hfsplus_delete_cat+0xa64/0xe90 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x342/0x7d0 fs/hfsplus/dir.c:385
 vfs_unlink+0x357/0x5f0 fs/namei.c:4251
 do_unlinkat+0x484/0x940 fs/namei.c:4319
 __do_sys_unlink fs/namei.c:4367 [inline]
 __se_sys_unlink fs/namei.c:4365 [inline]
 __x64_sys_unlink+0x45/0x50 fs/namei.c:4365
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 insert_work+0x54/0x3e0 kernel/workqueue.c:1358
 __queue_work+0xaaa/0xd60 kernel/workqueue.c:1517
 queue_work_on+0x11b/0x200 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x887/0x9c0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
 __dev_notify_flags+0x2ef/0x5d0
 dev_change_flags+0xe3/0x190 net/core/dev.c:8619
 devinet_ioctl+0x8cb/0x1a70 net/ipv4/devinet.c:1146
 inet_ioctl+0x314/0x3f0 net/ipv4/af_inet.c:979
 sock_do_ioctl net/socket.c:1169 [inline]
 sock_ioctl+0x53c/0x8d0 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888012bf6b00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes to the right of
 192-byte region [ffff888012bf6b00, ffff888012bf6bc0)

The buggy address belongs to the physical page:
page:ffffea00004afd80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12bf6
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00008eda00 dead000000000005 ffff888012841a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 1841523347, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5555
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2118
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 kset_create lib/kobject.c:937 [inline]
 kset_create_and_add+0x55/0x280 lib/kobject.c:980
 devices_init+0x1a/0xc6 drivers/base/core.c:3957
 driver_init+0x1b/0x4d drivers/base/init.c:26
 do_basic_setup+0x16/0x81 init/main.c:1408
 kernel_init_freeable+0x428/0x5d5 init/main.c:1631
 kernel_init+0x19/0x2b0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888012bf6a80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888012bf6b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888012bf6b80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff888012bf6c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888012bf6c80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
