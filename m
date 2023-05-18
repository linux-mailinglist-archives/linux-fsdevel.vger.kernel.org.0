Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EF7081BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjERMt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjERMtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 08:49:52 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1101B5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 05:49:50 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76c63aadc10so113710839f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 05:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684414190; x=1687006190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EL47r0F0+OEq9WYeDd2ivQLtcg9WFKpt2Zp7P+I2EZ4=;
        b=lrZ6JBubIAyxebHXaRZ3cdyVaFiNTIahaszsns2EFu0c7fkCEOMRBINI78wz+Xj2wy
         icIVTKox81c/wnLOxg8ElGp+PPeGDKrUs8a83t8+UdYO7YI6JhlJN6kOEtDmCpFqQtx7
         efGd970xYgTGXEVGOJWfRqOnXh+A2Apmbhff9ZutCWPrA0eTiN13k2a6StlaE+kxSj7t
         pkcTHCieX8gsVExdzq7IyAI67lPH9v+ObnoXHGTxrMwo9bIJ3mp8xK5pDy3Joj7YFi4A
         mpxuoC5CzEWKLyXlxDSqOkw+qsrzbPdP74UJ5iAqhB1DRWVHfNz39tZXa2SMkmyh5MV4
         Hibw==
X-Gm-Message-State: AC+VfDx/ZFcB4BLeqklviIajeH4tEtdAnftWh00JED2ebWO9X4XsitaJ
        1fmVgoIGuOd/KKP8E6a9tws1d6Q5VUGUg9iHTXIaCy2CBxkIJRluGw==
X-Google-Smtp-Source: ACHHUZ6J949dumGBQtf6sjzvRdLuwX2MafPZRdnKIyLJZILQUKuz/Rif+CJnNEEAhvTf0CTJDNffRlU/vtUZI3vYAQmFSrwlXDx7
MIME-Version: 1.0
X-Received: by 2002:a6b:b284:0:b0:76f:e71e:5f9d with SMTP id
 b126-20020a6bb284000000b0076fe71e5f9dmr3511726iof.1.1684414190127; Thu, 18
 May 2023 05:49:50 -0700 (PDT)
Date:   Thu, 18 May 2023 05:49:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075136e05fbf73d67@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfsplus_read_wrapper
From:   syzbot <syzbot+4b52080e97cde107939d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e922ba281a8d Add linux-next specific files for 20230512
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15aef2ea280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17a4c2d44484b62f
dashboard link: https://syzkaller.appspot.com/bug?extid=4b52080e97cde107939d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10190f7a280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e7c33a280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2026345928c3/disk-e922ba28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4fd686a0e4f4/vmlinux-e922ba28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd44b724fbdf/bzImage-e922ba28.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ee7fe34360d1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b52080e97cde107939d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hfsplus_read_wrapper+0xf62/0x1020 fs/hfsplus/wrapper.c:225
Read of size 2 at addr ffff88801566f800 by task syz-executor154/5030

CPU: 0 PID: 5030 Comm: syz-executor154 Not tainted 6.4.0-rc1-next-20230512-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 hfsplus_read_wrapper+0xf62/0x1020 fs/hfsplus/wrapper.c:225
 hfsplus_fill_super+0x312/0x1c40 fs/hfsplus/super.c:413
 mount_bdev+0x357/0x420 fs/super.c:1380
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f816d82df0a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9592d6f8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f816d82df0a
RDX: 0000000020000500 RSI: 0000000020000080 RDI: 00007ffd9592d710
RBP: 00007ffd9592d710 R08: 00007ffd9592d750 R09: 0000000000000614
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555556eac2c0 R14: 0000000000000000 R15: 00007ffd9592d750
 </TASK>

The buggy address belongs to the object at ffff88801566f800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 freed 512-byte region [ffff88801566f800, ffff88801566fa00)

The buggy address belongs to the physical page:
page:ffffea0000559b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1566c
head:ffffea0000559b00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52000(__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 0, tgid 0 (swapper/0), ts 1778430890, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf7c/0x2aa0 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2112
 alloc_pages+0x233/0x270 mm/mempolicy.c:2274
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x28e/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 devcgroup_css_alloc+0x41/0x120 security/device_cgroup.c:226
 cgroup_init_subsys+0x1bd/0x900 kernel/cgroup/cgroup.c:5988
 cgroup_init+0xb83/0x1090 kernel/cgroup/cgroup.c:6107
 start_kernel+0x398/0x490 init/main.c:1077
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801566f700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801566f780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801566f800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801566f880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801566f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
