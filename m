Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D872BC98E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKVVXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 16:23:20 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43603 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKVVXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:23:18 -0500
Received: by mail-io1-f70.google.com with SMTP id q8so5061678ioh.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fuxx1BRV4w6aSmAuplPtVDYPROrtgOQfcWtaEDtKlLY=;
        b=h20fZcELfQ1cJmjuryPOQN8KCOxwVi8g8fH3UgLxVvo+g5W/iZ4u6bIa/BLuCDfv9v
         CzefPLGFEy3yremskt/xMRPLXX2++BV8feVmVnus9SoCaBBTLS+2L/EsWakL0buodUhL
         7srCC5iz23hGPj2c7FztIA90oCM8NZ8u0eH2mhRPYdkd+QWcDfBEem8Hah/RLgQl4IMS
         IvtIXWv6PL3CDFLUvhURzofC9NCOr8xh6QcznA62baZ61BriW32dBF5I39Vk1Df+BwqA
         wXlfwa09j+VdZIuUa0cFsd1FYl9/XlZzMelcCg1CZ+SyNnHbbeJFvFv6TP1ENGh1YF6t
         jwZw==
X-Gm-Message-State: AOAM532tx7Zm/K+SEwkktdq9v12cbrLJ/bVATA50feY1mqFj7ZYUGdhW
        9itrEKiJCIVFFIx7JuznvvIWRU3xDTLTctLBwxUHsFbcRSmS
X-Google-Smtp-Source: ABdhPJy+/gqgUU1Xt4FOjBvmZjkUQVkJkwZ9tn7zdZyBQySpIQnKOC9PzGfTl5DpzENsfVEQrlP5s03sQDEhPb7pCSHg9ps3+BFB
MIME-Version: 1.0
X-Received: by 2002:a92:9903:: with SMTP id p3mr36058602ili.138.1606080195658;
 Sun, 22 Nov 2020 13:23:15 -0800 (PST)
Date:   Sun, 22 Nov 2020 13:23:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b07d705b4b8afa6@google.com>
Subject: KASAN: use-after-free Read in iput (2)
From:   syzbot <syzbot+2cc8170bf3401fadbbfd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    20529233 Add linux-next specific files for 20201118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112a581c500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
dashboard link: https://syzkaller.appspot.com/bug?extid=2cc8170bf3401fadbbfd
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cc8170bf3401fadbbfd@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020000040
gfs2: fsid=syz:syz.0: can't lock local "sc" file: -5
==================================================================
BUG: KASAN: use-after-free in iput+0x6b/0x70 fs/inode.c:1670
Read of size 8 at addr ffff8880848047a8 by task syz-executor.3/27017

CPU: 1 PID: 27017 Comm: syz-executor.3 Not tainted 5.10.0-rc4-next-20201118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 iput+0x6b/0x70 fs/inode.c:1670
 init_statfs fs/gfs2/ops_fstype.c:684 [inline]
 init_journal fs/gfs2/ops_fstype.c:788 [inline]
 init_inodes+0x2103/0x2650 fs/gfs2/ops_fstype.c:857
 gfs2_fill_super+0x199c/0x23f0 fs/gfs2/ops_fstype.c:1184
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1260
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46090a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8a 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f5a79d67a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5a79d67b20 RCX: 000000000046090a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5a79d67ae0
RBP: 00007f5a79d67ae0 R08: 00007f5a79d67b20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020000040

Allocated by task 27017:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:480
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2900 [inline]
 slab_alloc mm/slub.c:2908 [inline]
 kmem_cache_alloc+0x12a/0x470 mm/slub.c:2913
 gfs2_alloc_inode+0x38/0x1a0 fs/gfs2/super.c:1548
 alloc_inode+0x61/0x230 fs/inode.c:234
 iget5_locked fs/inode.c:1150 [inline]
 iget5_locked+0x134/0x220 fs/inode.c:1143
 gfs2_iget fs/gfs2/inode.c:60 [inline]
 gfs2_inode_lookup+0x104/0xb30 fs/gfs2/inode.c:136
 gfs2_dir_search+0x20f/0x2c0 fs/gfs2/dir.c:1662
 gfs2_lookupi+0x46e/0x630 fs/gfs2/inode.c:329
 gfs2_lookup_simple+0x99/0xe0 fs/gfs2/inode.c:269
 init_statfs fs/gfs2/ops_fstype.c:641 [inline]
 init_journal fs/gfs2/ops_fstype.c:788 [inline]
 init_inodes+0x169d/0x2650 fs/gfs2/ops_fstype.c:857
 gfs2_fill_super+0x199c/0x23f0 fs/gfs2/ops_fstype.c:1184
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1260
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 10:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:57
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:356
 __kasan_slab_free+0x102/0x140 mm/kasan/common.c:438
 slab_free_hook mm/slub.c:1545 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1583
 slab_free mm/slub.c:3154 [inline]
 kmem_cache_free+0x82/0x350 mm/slub.c:3170
 i_callback+0x3f/0x70 fs/inode.c:223
 rcu_do_batch kernel/rcu/tree.c:2499 [inline]
 rcu_core+0x5e4/0xef0 kernel/rcu/tree.c:2730
 __do_softirq+0x2a0/0x9f6 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_record_aux_stack+0xc0/0xf0 mm/kasan/generic.c:347
 __call_rcu kernel/rcu/tree.c:2972 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3047
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x3fe/0x820 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 init_statfs fs/gfs2/ops_fstype.c:672 [inline]
 init_journal fs/gfs2/ops_fstype.c:788 [inline]
 init_inodes+0x19a7/0x2650 fs/gfs2/ops_fstype.c:857
 gfs2_fill_super+0x199c/0x23f0 fs/gfs2/ops_fstype.c:1184
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1260
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:49
 kasan_record_aux_stack+0xc0/0xf0 mm/kasan/generic.c:347
 __call_rcu kernel/rcu/tree.c:2972 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3047
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x3fe/0x820 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 free_local_statfs_inodes+0xef/0x370 fs/gfs2/super.c:1574
 uninit_statfs fs/gfs2/ops_fstype.c:696 [inline]
 init_journal fs/gfs2/ops_fstype.c:828 [inline]
 init_inodes+0x1e12/0x2650 fs/gfs2/ops_fstype.c:897
 gfs2_fill_super+0x199c/0x23f0 fs/gfs2/ops_fstype.c:1184
 get_tree_bdev+0x421/0x740 fs/super.c:1344
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1260
 vfs_get_tree+0x89/0x2f0 fs/super.c:1549
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880848046d0
 which belongs to the cache gfs2_inode of size 1520
The buggy address is located 216 bytes inside of
 1520-byte region [ffff8880848046d0, ffff888084804cc0)
The buggy address belongs to the page:
page:0000000034b508a6 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x84800
head:0000000034b508a6 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88814380b3c0
raw: 0000000000000000 0000000080130013 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888084804680: fc fc fc fc fc fc fc fc fc fc fa fb fb fb fb fb
 ffff888084804700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888084804780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888084804800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888084804880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
