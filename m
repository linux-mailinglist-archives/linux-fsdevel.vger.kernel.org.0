Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703052A7053
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgKDWVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 17:21:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35479 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgKDWUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:20:17 -0500
Received: by mail-il1-f199.google.com with SMTP id k15so16678844ilh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 14:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rc46J+LdfOQ971VpgAGBFMDqvkS69w+5fLDQxrrBNZI=;
        b=pACoKcWdECcBW79pkla4AM6NL03TLernD1OpXtXfCScHPydjtLzC3Tqb5Bd/6Jnk0P
         DodjqVHgTXe6JyiigzetI4m5XfSjIPg4FRsiihSc9gyWpTUNr+HTjO0m7tMkCEYsz1mS
         pjyG/MNZKPJa0Rk80OKUTM+8Obp+HcDTq4fHpJSnZRWb6n4Djj5h7hcSDLc6V4RLb0zO
         OaTwAqAuec2nBZAJ651Mcyrm+z5eGBV0EuY+btif6N+ulybDCcMxetX5mNGTwNI1Njze
         abE06FthYASLYla2eIEQmnpc5gb26hc7xv0fETVG3ZgjByiP/UyMjQwZXplZOyK1icgq
         z9kg==
X-Gm-Message-State: AOAM532WrywwdeWxG5j4O0+swkI5eGmB0Eb2mbHgLrdsJQCXUDYs1VIU
        19geCKhodTzsGSX+zdtTJqNX+k50tZE3QBWLsg75pX3XM3UH
X-Google-Smtp-Source: ABdhPJysSLx4JiHvgheatnMzaJc5jZWPdLcY1C6ZB1HtMGEuhRV8eKCS8O4iBP1vbBx1SD+sXxJZnYMhdFXPZWsl6G2wg85Idl2Q
MIME-Version: 1.0
X-Received: by 2002:a02:6342:: with SMTP id j63mr218086jac.41.1604528416474;
 Wed, 04 Nov 2020 14:20:16 -0800 (PST)
Date:   Wed, 04 Nov 2020 14:20:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bcbf205b34f6294@google.com>
Subject: KASAN: use-after-free Read in path_init (3)
From:   syzbot <syzbot+3e565bbd2673747f90c2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110d0c92500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=3e565bbd2673747f90c2
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e565bbd2673747f90c2@syzkaller.appspotmail.com

MINIX-fs: mounting unchecked file system, running fsck is recommended
MINIX-fs: deleted inode referenced: 6
==================================================================
BUG: KASAN: use-after-free in path_init+0x14ba/0x17d0 fs/namei.c:2208
Read of size 8 at addr ffff8880633cc400 by task syz-executor.3/14486

CPU: 1 PID: 14486 Comm: syz-executor.3 Not tainted 5.10.0-rc1-next-20201030-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 path_init+0x14ba/0x17d0 fs/namei.c:2208
 path_parentat+0x22/0x1b0 fs/namei.c:2385
 filename_parentat+0x188/0x560 fs/namei.c:2408
 do_renameat2+0x16e/0xc00 fs/namei.c:4375
 __do_sys_renameat fs/namei.c:4501 [inline]
 __se_sys_renameat fs/namei.c:4498 [inline]
 __x64_sys_renameat+0xbf/0xf0 fs/namei.c:4498
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbef8029c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
RAX: ffffffffffffffda RBX: 0000000000027340 RCX: 000000000045deb9
RDX: 0000000000000006 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 000000000118bf68 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200017c0 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffe203745cf R14: 00007fbef802a9c0 R15: 000000000118bf2c

Allocated by task 14486:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:506 [inline]
 slab_alloc_node mm/slub.c:2889 [inline]
 slab_alloc mm/slub.c:2897 [inline]
 kmem_cache_alloc+0x122/0x460 mm/slub.c:2902
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags+0x9a/0xe0 include/linux/audit.h:319
 getname fs/namei.c:209 [inline]
 __do_sys_renameat fs/namei.c:4501 [inline]
 __se_sys_renameat fs/namei.c:4498 [inline]
 __x64_sys_renameat+0xad/0xf0 fs/namei.c:4498
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 14486:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0x102/0x140 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1544 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1577
 slab_free mm/slub.c:3140 [inline]
 kmem_cache_free+0x82/0x350 mm/slub.c:3156
 putname+0xe1/0x120 fs/namei.c:259
 do_renameat2+0x3e6/0xc00 fs/namei.c:4481
 __do_sys_renameat fs/namei.c:4501 [inline]
 __se_sys_renameat fs/namei.c:4498 [inline]
 __x64_sys_renameat+0xbf/0xf0 fs/namei.c:4498
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880633cc400
 which belongs to the cache names_cache of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff8880633cc400, ffff8880633cd400)
The buggy address belongs to the page:
page:00000000f2c066e0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x633c8
head:00000000f2c066e0 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff8880101c1280
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880633cc300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880633cc380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880633cc400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880633cc480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880633cc500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
