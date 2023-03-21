Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C56C37A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCURFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCURFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:23 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C123C55
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 10:04:47 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i22-20020a056e021d1600b0031f64ecb112so8276446ila.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 10:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418286;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XayrB2Q10iQ9KDCn+y6kH0Sd/d+Kv23eHMmV78ksiXk=;
        b=fczblBQILTpwgOFHGwV1j7V3e3d0Bl5lGSNkOHo1vD+CcnI/MZxZSpWMX5q+0FFQhM
         O4lpym3lrqbJ/0Wg5Nsaz7SwSmFMJpymZEcL9DEn0g64b33kN8S95fsVdzWA2PtGQlhF
         rZ7M3j+UQu6xDB9Bxo2yKBmA2ErDdncoKxVEGkT6HMFNpnhq7QBuj0Rgd4s6nzJCXHW9
         bqrqYoH1iUTe2PbPJqPQDvEERgiqsrE98m2axhKPaOgKB9vj2HBi3wyD1B9Cw+y4K/dl
         084+OgXSpNY6VsAVQ6+pm1iNFAsqQdbyTQRZkyObWkx6Qtlsdu5+BdN006l3mCE0ODck
         cc8w==
X-Gm-Message-State: AO0yUKXumo2Df8IdC6uYBgZFiQ5P99KpX3e1gfdnS7sgUfPNMDgPBqNA
        NiRtQmW/jy4wBz5j05tBXsPk5ZDcTzohrWcsnHXxvPiBTUgt
X-Google-Smtp-Source: AK7set/+/Gu3yj2EBYhPBnXWIcPyOISVi04ppsDlO/lKz/yQrRwvJQDEoznbHkTqLClU+u6/WYNZsCtkY/EAjuze51tNhOCX+vDt
MIME-Version: 1.0
X-Received: by 2002:a92:7a09:0:b0:323:1fa:dee1 with SMTP id
 v9-20020a927a09000000b0032301fadee1mr1280182ilc.1.1679418286769; Tue, 21 Mar
 2023 10:04:46 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:04:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000698e5d05f76c0adf@google.com>
Subject: [syzbot] [jfs?] KASAN: invalid-free in sys_mount
From:   syzbot <syzbot+9f06ddd18bf059dff2ad@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a3671bd86a97 Merge tag 'fbdev-for-6.3-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107e1881c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e23c4bcf73cdc669
dashboard link: https://syzkaller.appspot.com/bug?extid=9f06ddd18bf059dff2ad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b20616c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db8fe1c9da8e/disk-a3671bd8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc4fa03b59c8/vmlinux-a3671bd8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0626413c51bd/bzImage-a3671bd8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/80fe3a2b2b37/mount_0.gz

The issue was bisected to:

commit a0b6e4048228829485a43247c12c7774531728c4
Author: Charles Keepax <ckeepax@opensource.cirrus.com>
Date:   Thu Jun 23 12:52:28 2022 +0000

    ASoC: cx20442: Remove now redundant non_legacy_dai_naming flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12756e1cc80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11756e1cc80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16756e1cc80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f06ddd18bf059dff2ad@syzkaller.appspotmail.com
Fixes: a0b6e4048228 ("ASoC: cx20442: Remove now redundant non_legacy_dai_naming flag")

loop5: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
Free of addr ffff88807d3f8000 by task syz-executor.5/5275

CPU: 0 PID: 5275 Comm: syz-executor.5 Not tainted 6.3.0-rc2-syzkaller-00405-ga3671bd86a97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report_invalid_free+0xe8/0x100 mm/kasan/report.c:501
 ____kasan_slab_free+0x185/0x1c0 mm/kasan/common.c:225
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 __do_sys_mount fs/namespace.c:3596 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x212/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8f2288d62a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8f236bdf88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000005e3e RCX: 00007f8f2288d62a
RDX: 0000000020005e00 RSI: 0000000020005e40 RDI: 00007f8f236bdfe0
RBP: 00007f8f236be020 R08: 00007f8f236be020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005e00
R13: 0000000020005e40 R14: 00007f8f236bdfe0 R15: 0000000020002680
 </TASK>

Allocated by task 5275:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:580 [inline]
 copy_mount_options+0x55/0x180 fs/namespace.c:3250
 __do_sys_mount fs/namespace.c:3589 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x1ad/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5096:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 diUnmount+0xf1/0x130 fs/jfs/jfs_imap.c:195
 jfs_umount+0x189/0x430 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x85/0x1d0 fs/jfs/super.c:194
 generic_shutdown_super+0x158/0x480 fs/super.c:491
 kill_block_super+0x9b/0xf0 fs/super.c:1398
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807d3f8000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff88807d3f8000, ffff88807d3f9000)

The buggy address belongs to the physical page:
page:ffffea0001f4fe00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d3f8
head:ffffea0001f4fe00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012442140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5275, tgid 5274 (syz-executor.5), ts 50645577439, free_ts 50622147528
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4325
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5591
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 copy_mount_options+0x55/0x180 fs/namespace.c:3250
 __do_sys_mount fs/namespace.c:3589 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x1ad/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 diMount+0x78c/0x830 fs/jfs/jfs_imap.c:115
 jfs_mount_rw+0x239/0x6d0 fs/jfs/jfs_mount.c:240
 jfs_remount+0x520/0x660 fs/jfs/super.c:454
 legacy_reconfigure+0x119/0x180 fs/fs_context.c:633
 reconfigure_super+0x40c/0xa30 fs/super.c:947
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807d3f7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d3f7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807d3f8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807d3f8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d3f8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
