Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC674B8CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 23:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjGGVrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGGVrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:47:03 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A82102
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 14:47:02 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-262e9468034so3698462a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 14:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766421; x=1691358421;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5l8sD761owscSi/Bc1OJgHj5NLATqZufjKdLX7iyFw=;
        b=ZzvbNsvjUl2pszcSH2wJIURosIjnPWnHhcx9VHwq0hdsDM4gohRMVy4mbY4vtgiYjd
         AjYSMz+r1bpJd/0mkS64DhfWpEh+uo1gYdCdtzVHkTd+haOOTRNiuKT+F9OGUl/N1h3A
         36CPs+RXVhvxfFd5jS9YLqA9qLOWU//vc7EVfeyht4jcZkCFJ4WP9Ed2+AScdGbbPkmi
         lQ2gA9FD01F4OQWovY5bEgKjA8L6LY9xal+iOU/KT6RVhDc5cNFgjSKzd3MVae9r7yBO
         1AitCfkt+vjnbLW0UIzZuUAlS8SWxCFr13HNpQWbnlOqoF/QD1Gg+gqqFSQpc4R/NrBP
         kB8Q==
X-Gm-Message-State: ABy/qLY1We+TKSVnvpOfofkPjiNDFt3RMP07AdeJpJy4zH/5KmAPZthz
        kw77P9KUpTWdNRzI2pm+5A1gn2PDNbQpn7uz5Zb/k7o98XCJ
X-Google-Smtp-Source: APBJJlFHpMi5JJGTDn5KTaXhUUCHaWrHJzRRT4meeyTEiSNBofnC6BrKdR71zEvtrg60IVNSjQMoYBu/nLDWtS0fkyWFVK1Sq/1f
MIME-Version: 1.0
X-Received: by 2002:a17:902:da92:b0:1b8:184d:1379 with SMTP id
 j18-20020a170902da9200b001b8184d1379mr5930452plx.9.1688766421356; Fri, 07 Jul
 2023 14:47:01 -0700 (PDT)
Date:   Fri, 07 Jul 2023 14:47:01 -0700
In-Reply-To: <000000000000b5973405f9a22358@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a75ae805ffec923e@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Read in ntfs_set_inode
From:   syzbot <syzbot+cbdd49fbb39696c71041@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    5133c9e51de4 Merge tag 'drm-next-2023-07-07' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168c1ed2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9831e2c2660aae77
dashboard link: https://syzkaller.appspot.com/bug?extid=cbdd49fbb39696c71041
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729cb02a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-5133c9e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1be5268e0eae/vmlinux-5133c9e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd7819821e7b/bzImage-5133c9e5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e33ac0ed058/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbdd49fbb39696c71041@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
==================================================================
BUG: KASAN: stack-out-of-bounds in ino_get fs/ntfs3/ntfs.h:193 [inline]
BUG: KASAN: stack-out-of-bounds in ntfs_set_inode+0x65/0x70 fs/ntfs3/inode.c:514
Read of size 4 at addr ffffc9000bccfcc7 by task syz-executor.0/6246

CPU: 0 PID: 6246 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-12274-g5133c9e51de4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
 print_report mm/kasan/report.c:475 [inline]
 kasan_report+0x11d/0x130 mm/kasan/report.c:588
 ino_get fs/ntfs3/ntfs.h:193 [inline]
 ntfs_set_inode+0x65/0x70 fs/ntfs3/inode.c:514
 inode_insert5+0x125/0x660 fs/inode.c:1231
 iget5_locked fs/inode.c:1289 [inline]
 iget5_locked+0x225/0x2c0 fs/inode.c:1278
 ntfs_iget5+0xd2/0x3670 fs/ntfs3/inode.c:523
 ntfs_fill_super+0x3196/0x3c20 fs/ntfs3/super.c:1272
 get_tree_bdev+0x43e/0x7d0 fs/super.c:1318
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x136e/0x1e70 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f251e48d8ba
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f251f242f88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f73b RCX: 00007f251e48d8ba
RDX: 0000000020000000 RSI: 000000002001f740 RDI: 00007f251f242fe0
RBP: 00007f251f243020 R08: 00007f251f243020 R09: 0000000001000000
R10: 0000000001000000 R11: 0000000000000246 R12: 0000000020000000
R13: 000000002001f740 R14: 00007f251f242fe0 R15: 0000000020000040
 </TASK>

The buggy address belongs to stack of task syz-executor.0/6246
 and is located at offset 127 in frame:
 ntfs_fill_super+0x0/0x3c20 fs/ntfs3/super.c:474

This frame has 5 objects:
 [48, 52) 'vcn'
 [64, 68) 'lcn'
 [80, 84) 'len'
 [96, 104) 'tt'
 [128, 136) 'ref'

The buggy address belongs to the virtual mapping at
 [ffffc9000bcc8000, ffffc9000bcd1000) created by:
 kernel_clone+0xeb/0x890 kernel/fork.c:2911

The buggy address belongs to the physical page:
page:ffffea00009e2080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27882
memcg:ffff888020cd9a82
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888020cd9a82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 6245, tgid 6245 (syz-executor.0), ts 379453839813, free_ts 308972643812
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0xfed/0x2d30 mm/page_alloc.c:3221
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4477
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 vm_area_alloc_pages mm/vmalloc.c:3059 [inline]
 __vmalloc_area_node mm/vmalloc.c:3135 [inline]
 __vmalloc_node_range+0xb1c/0x14c0 mm/vmalloc.c:3316
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1112 [inline]
 copy_process+0x13bb/0x75c0 kernel/fork.c:2329
 kernel_clone+0xeb/0x890 kernel/fork.c:2911
 __do_sys_clone+0xba/0x100 kernel/fork.c:3054
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2348
 free_unref_page+0x33/0x370 mm/page_alloc.c:2443
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2c5/0x410 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x4f/0x1a0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 __kmem_cache_alloc_node+0x206/0x410 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 inotify_handle_inode_event+0x1c2/0x5f0 fs/notify/inotify/inotify_fsnotify.c:96
 inotify_ignored_and_remove_idr+0x28/0x70 fs/notify/inotify/inotify_user.c:527
 fsnotify_free_mark+0xe9/0x140 fs/notify/mark.c:490
 __do_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:817 [inline]
 __se_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:794 [inline]
 __x64_sys_inotify_rm_watch+0x11c/0x1a0 fs/notify/inotify/inotify_user.c:794
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc9000bccfb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000bccfc00: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 04
>ffffc9000bccfc80: f2 04 f2 04 f2 00 f2 f2 f2 00 f3 f3 f3 00 00 00
                                           ^
 ffffc9000bccfd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000bccfd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
