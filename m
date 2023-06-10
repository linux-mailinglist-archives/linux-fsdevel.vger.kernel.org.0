Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDFE72A946
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjFJGL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFJGL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 02:11:58 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7573AAA
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 23:11:57 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-766655c2cc7so287359539f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 23:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686377516; x=1688969516;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9damaCTSY0eGRn9AB6gzKMssFPdnn9DZ5EWuaw87/s=;
        b=Wf+vSyqhE53K6pfF1vDbivHhhsrdkl05YSAk72SlD8Eh3zGkycZIBKwUkctS6pc4n5
         yzbD6DtZjOHZl/VWwh7ad+EyYUh9aGiRRrE1bJm8dxJpt0owgVJXHEv4yWJ+ktj1Bs0Y
         1UZ8bWxzemC23NH0yTNthFcVRaRkGxMSQlx9rV2RWcj66LTzoyjVk5m0ygoCCAYCNsjs
         MClX2ZThhVwxqboDKsMwNuzyiJsDcAkV6YvDdKnTB658BD3MQwm3jXprCpFUZI3OZYa7
         kyMJyG/aH76VLvdP4V30SK+ga3tkQq511GeY3yCuAKRNbltCCPLkWTG4W65XIhgiJJZQ
         a0vQ==
X-Gm-Message-State: AC+VfDx6z1+GhWg+sB2/OJadn5raOIgvRBG0q+XIfCEdupOYLYkTDn0i
        B5wdr08H8JOqm2ok5EkbOC9/+9xEtQwAgBudwWnqAoD33WvK
X-Google-Smtp-Source: ACHHUZ4ia+xsA/gyHLe5TgS1nPtCSBEufhKM2yM63/ChkCZYF1XjEpQxWdfB2AdGFPmX94ZpdAphhfAHlLj5ldEvM+4FyHRPYGy+
MIME-Version: 1.0
X-Received: by 2002:a92:cc44:0:b0:33d:5314:d75d with SMTP id
 t4-20020a92cc44000000b0033d5314d75dmr1677654ilq.3.1686377516499; Fri, 09 Jun
 2023 23:11:56 -0700 (PDT)
Date:   Fri, 09 Jun 2023 23:11:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d40c3c05fdc05cd1@google.com>
Subject: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From:   syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e8f4b3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bcb6b5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbcfd1280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aac0833aa9d/disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06f1060b83c8/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8450975febdf/bzImage-f8dba31b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5473bd744cf1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in udf_free_blocks+0x11f3/0x1330 fs/udf/balloc.c:681
Read of size 2 at addr ffff888079663b2a by task syz-executor147/5322

CPU: 0 PID: 5322 Comm: syz-executor147 Not tainted 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 udf_free_blocks+0x11f3/0x1330 fs/udf/balloc.c:681
 udf_discard_prealloc+0x47b/0x4e0 fs/udf/truncate.c:151
 udf_map_block+0x408/0x560 fs/udf/inode.c:448
 __udf_get_block+0x9c/0x330 fs/udf/inode.c:464
 __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:2064
 __block_write_begin fs/buffer.c:2114 [inline]
 block_write_begin+0xb9/0x4d0 fs/buffer.c:2175
 udf_write_begin+0x285/0x370 fs/udf/inode.c:265
 generic_perform_write+0x256/0x570 mm/filemap.c:3923
 __generic_file_write_iter+0x2ae/0x500 mm/filemap.c:4051
 udf_file_write_iter+0x233/0x740 fs/udf/file.c:115
 call_write_iter include/linux/fs.h:1868 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x185/0x7e0 fs/read_write.c:860
 vfs_iter_write+0x74/0xa0 fs/read_write.c:901
 iter_file_splice_write+0x743/0xc80 fs/splice.c:795
 do_splice_from fs/splice.c:873 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:1039
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:994
 do_splice_direct+0x1ab/0x280 fs/splice.c:1082
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9f5e6044c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9f5628a2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9f5e691590 RCX: 00007f9f5e6044c9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007f9f5e657328 R08: 00007f9f5628a700 R09: 0000000000000000
R10: 0000000100000001 R11: 0000000000000246 R12: 6573726168636f69
R13: 0030656c69662f2e R14: 0031656c69662f2e R15: 00007f9f5e691598
 </TASK>

Allocated by task 4993:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x17c/0x3b0 mm/slub.c:3475
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname+0x92/0xd0 fs/namei.c:219
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1350
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4993:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0xe9/0x480 mm/slub.c:3808
 putname fs/namei.c:273 [inline]
 putname+0x102/0x140 fs/namei.c:259
 do_sys_openat2+0x153/0x4c0 fs/open.c:1365
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888079663300
 which belongs to the cache names_cache of size 4096
The buggy address is located 2090 bytes inside of
 freed 4096-byte region [ffff888079663300, ffff888079664300)

The buggy address belongs to the physical page:
page:ffffea0001e59800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79660
head:ffffea0001e59800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888140006780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4466, tgid 4466 (udevd), ts 11901820024, free_ts 9305063821
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname+0x92/0xd0 fs/namei.c:219
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1350
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 free_contig_range+0xb5/0x180 mm/page_alloc.c:6994
 destroy_args+0x6c4/0x920 mm/debug_vm_pgtable.c:1023
 debug_vm_pgtable+0x2412/0x4210 mm/debug_vm_pgtable.c:1403
 do_one_initcall+0x102/0x540 init/main.c:1246
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x64e/0xba0 init/main.c:1571
 kernel_init+0x1e/0x2c0 init/main.c:1462
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888079663a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079663a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888079663b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888079663b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079663c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
