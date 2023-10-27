Return-Path: <linux-fsdevel+bounces-1290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602F7D8E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C501C20FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5553B3;
	Fri, 27 Oct 2023 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E05241
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 05:15:27 +0000 (UTC)
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967F1A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 22:15:23 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-581e2609a5dso2655852eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 22:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383722; x=1698988522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYuaQeh4AHt7QHt0Hf/U/lpMA7HyYZ4xFVYU/dCE9jU=;
        b=RGNgIlPQAerOKDU+mnb7tG2tqq8oUUGz3viX/S/+WWubK/eDoPNNvUFOGgDKMw7OwS
         2qQXdbfW3KWtFOkS9NTfEG3GRFAE44JaNddrAIRCa3ShQCLIC36Bnj3aYYpv++rakNW5
         Z8jWPQa9vbwXYyIZY3ykdDNh5F8GShJUBbIXJZzFgpUko6oGPxUm3FpHbYvCE2zTUj6s
         xXHGc4buonpwiySmsiPl2Y6uhM7UD7a0zTktHYNXcpXBO5yuAABW2e975sr/HPua8fhh
         jeLQTX3Bw8cvp2yHyQvTUQni9z2isPYErD/EVrD07CBho2+9UnCX70e20x+pb9iYiwY0
         hugg==
X-Gm-Message-State: AOJu0YyUuYekt6R34BS2I6Cjc+uOHQrlxjmwHo9cx2bYuJEAAX1Iz6Nw
	njBUISR9XTArM3u1kGyJIAhCrwoqiRyWOKII8+Sg7dc9DNTZ
X-Google-Smtp-Source: AGHT+IF6/PYuwM40e0EMUlrJjyUNGD0wsScDmucmdaNUA8NN73jCMvPN48OuwVeqjAcn2OIcSU2cYozdArSz1K6sAKoeiLPKqgc+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e658:0:b0:581:dbb1:219b with SMTP id
 q24-20020a4ae658000000b00581dbb1219bmr618103oot.0.1698383722677; Thu, 26 Oct
 2023 22:15:22 -0700 (PDT)
Date: Thu, 26 Oct 2023 22:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b8bed0608abc6c2@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_evict_inode
From: syzbot <syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe3cfe869d5e Merge tag 'phy-fixes-6.6' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15db4635680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b400c09b1315b112
dashboard link: https://syzkaller.appspot.com/bug?extid=01cf2dbcbe2022454388
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170eb95d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57e585f5caff/disk-fe3cfe86.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2904450b051/vmlinux-fe3cfe86.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8fb732d9bee9/bzImage-fe3cfe86.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/be380785486a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com

jfs_mount: diMount failed w/rc = -5
==================================================================
BUG: KASAN: slab-use-after-free in jfs_evict_inode+0x4aa/0x4b0 fs/jfs/inode.c:155
Read of size 8 at addr ffff88806356f970 by task syz-executor.5/6182

CPU: 0 PID: 6182 Comm: syz-executor.5 Not tainted 6.6.0-rc6-syzkaller-00355-gfe3cfe869d5e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 jfs_evict_inode+0x4aa/0x4b0 fs/jfs/inode.c:155
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 diFreeSpecial+0x7a/0x110 fs/jfs/jfs_imap.c:549
 jfs_mount+0x471/0x890 fs/jfs/jfs_mount.c:203
 jfs_fill_super+0x5a3/0xd20 fs/jfs/super.c:556
 mount_bdev+0x1f3/0x2e0 fs/super.c:1629
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fac16a7e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fac178baee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fac178baf80 RCX: 00007fac16a7e1ea
RDX: 0000000020002400 RSI: 0000000020000040 RDI: 00007fac178baf40
RBP: 0000000020002400 R08: 00007fac178baf80 R09: 0000000000000080
R10: 0000000000000080 R11: 0000000000000246 R12: 0000000020000040
R13: 00007fac178baf40 R14: 0000000000002332 R15: 0000000020002500
 </TASK>

Allocated by task 6182:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc_lru+0x202/0x6d0 mm/slab.c:3439
 alloc_inode_sb include/linux/fs.h:2868 [inline]
 jfs_alloc_inode+0x25/0x60 fs/jfs/super.c:105
 alloc_inode+0x5d/0x220 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1004 [inline]
 new_inode+0x22/0x260 fs/inode.c:1030
 diReadSpecial+0x51/0x6e0 fs/jfs/jfs_imap.c:423
 jfs_mount+0x31e/0x890 fs/jfs/jfs_mount.c:166
 jfs_fill_super+0x5a3/0xd20 fs/jfs/super.c:556
 mount_bdev+0x1f3/0x2e0 fs/super.c:1629
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5231:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 kmem_cache_free+0x104/0x380 mm/slab.c:3582
 i_callback+0x43/0x70 fs/inode.c:248
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x805/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 destroy_inode+0x129/0x1b0 fs/inode.c:314
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 diFreeSpecial+0x7a/0x110 fs/jfs/jfs_imap.c:549
 jfs_mount+0x424/0x890 fs/jfs/jfs_mount.c:191
 jfs_fill_super+0x5a3/0xd20 fs/jfs/super.c:556
 mount_bdev+0x1f3/0x2e0 fs/super.c:1629
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 destroy_inode+0x129/0x1b0 fs/inode.c:314
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 jfs_fill_super+0x95c/0xd20 fs/jfs/super.c:607
 mount_bdev+0x1f3/0x2e0 fs/super.c:1629
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806356f5c0
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 944 bytes inside of
 freed 2240-byte region [ffff88806356f5c0, ffff88806356fe80)

The buggy address belongs to the physical page:
page:ffffea00018d5bc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88806356ffff pfn:0x6356f
memcg:ffff888028945f41
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x1()
raw: 00fff00000000800 ffff8881422a8700 ffffea00018d5c90 ffffea00018d6350
raw: ffff88806356ffff ffff88806356f5c0 0000000100000001 ffff888028945f41
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x342050(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE|__GFP_RECLAIMABLE), pid 5219, tgid 5216 (syz-executor.1), ts 145722879804, free_ts 145541609248
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc_lru+0x566/0x6d0 mm/slab.c:3439
 alloc_inode_sb include/linux/fs.h:2868 [inline]
 jfs_alloc_inode+0x25/0x60 fs/jfs/super.c:105
 alloc_inode+0x5d/0x220 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1004 [inline]
 new_inode+0x22/0x260 fs/inode.c:1030
 diReadSpecial+0x51/0x6e0 fs/jfs/jfs_imap.c:423
 jfs_mount+0xe0/0x890 fs/jfs/jfs_mount.c:87
 jfs_fill_super+0x5a3/0xd20 fs/jfs/super.c:556
 mount_bdev+0x1f3/0x2e0 fs/super.c:1629
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2b7/0x420 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 __kmem_cache_alloc_node+0x163/0x470 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1039
 kmalloc_array include/linux/slab.h:636 [inline]
 kcalloc include/linux/slab.h:667 [inline]
 ext4_find_extent+0x958/0xce0 fs/ext4/extents.c:914
 ext4_ext_map_blocks+0x26b/0x5b10 fs/ext4/extents.c:4101
 ext4_map_blocks+0x844/0x1770 fs/ext4/inode.c:548
 ext4_append+0x1fb/0x560 fs/ext4/namei.c:75
 ext4_init_new_dir+0x220/0x4c0 fs/ext4/namei.c:2981
 ext4_mkdir+0x316/0xb70 fs/ext4/namei.c:3027
 vfs_mkdir+0x532/0x7e0 fs/namei.c:4121

Memory state around the buggy address:
 ffff88806356f800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806356f880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806356f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88806356f980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806356fa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

