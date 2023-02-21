Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1469DE0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 11:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjBUKl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 05:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjBUKly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:41:54 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1726583
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 02:41:42 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id q14-20020a056e02106e00b003127853ef5dso1571830ilj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sn2unYt5CKveFXWOVwNZqrxEe4qbtbBOwiAxnhiiOy4=;
        b=qpgpuZ/Xy4D4ByYvRKG8eA4ccaHXk2XmQntIVqqQdCsoKCo2O29Eq9eYulMSP/FI1h
         IMMvWGBPoxzVBNrszdVNYGI5DubMQUWFg71g1JPgqhkwTP1GamWH9O6zyvaj9agfefVU
         OgukDFbSloN7knqplZqZronFIJ59Stb16MftB/XSehcMPN5GLBa2A7rHsRNKIDplH/xN
         xMHoQJqpCXshjOro36BQ/TTXgRTVdhncGQdPE5ymY+11xSOPRlQBs8yHQbj6QwKham1i
         KmEJ+YvSpazYUnW0HFtaE4N3oGjACzBIEtre6QHTiU5FS1buf26yJUS2mot2yNWJYeAl
         GVvw==
X-Gm-Message-State: AO0yUKVpbpkRYkcvPhmzk3rLdP/kgxtH5X+OwhzkqldYMuRw/d3WJ+Mr
        eJKWKIwhHdYdJybDbt7tjE2Dk6qFwZGzQSOqrRmpo4x9mFI5
X-Google-Smtp-Source: AK7set8HcaxJUn6GjJoZxX0+6z7MKGUtaS+s8FiZA6EDZZLBwtpYSe+zEa91D+My8NlrnRWs2UeeWRfMuHAWyhhlZMFEeIcVMXB4
MIME-Version: 1.0
X-Received: by 2002:a02:2289:0:b0:3c5:15ee:9eca with SMTP id
 o131-20020a022289000000b003c515ee9ecamr1004699jao.4.1676976102130; Tue, 21
 Feb 2023 02:41:42 -0800 (PST)
Date:   Tue, 21 Feb 2023 02:41:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd4a6405f5336cbc@google.com>
Subject: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Write in ktime_get_coarse_real_ts64
From:   syzbot <syzbot+91eeffac5287c260f2d0@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, jstultz@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    3ac88fa4605e Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d52e80c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bfeb3e8d4df76ca
dashboard link: https://syzkaller.appspot.com/bug?extid=91eeffac5287c260f2d0
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a7a4ab480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151aeaf0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e5a5021bb76/disk-3ac88fa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd0ed3340dc5/vmlinux-3ac88fa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e8af7580e527/bzImage-3ac88fa4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0f8c7430924f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91eeffac5287c260f2d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in native_save_fl arch/x86/include/asm/irqflags.h:22 [inline]
BUG: KASAN: stack-out-of-bounds in arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
BUG: KASAN: stack-out-of-bounds in arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in seqcount_lockdep_reader_access+0x177/0x220 include/linux/seqlock.h:104
Write of size 8 at addr ffffc90003daf2df by task syz-executor283/5128

CPU: 1 PID: 5128 Comm: syz-executor283 Not tainted 6.2.0-rc8-syzkaller-00083-g3ac88fa4605e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x163/0x4f0 mm/kasan/report.c:417
 kasan_report+0x13a/0x170 mm/kasan/report.c:517
 native_save_fl arch/x86/include/asm/irqflags.h:22 [inline]
 arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
 arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
 seqcount_lockdep_reader_access+0x177/0x220 include/linux/seqlock.h:104
 ktime_get_coarse_real_ts64+0x3a/0x120 kernel/time/timekeeping.c:2261
 current_time+0x8b/0x300 fs/inode.c:2448
 atime_needs_update+0x3ec/0x7a0 fs/inode.c:1909
 touch_atime+0xe8/0x650 fs/inode.c:1926
 file_accessed include/linux/fs.h:2519 [inline]
 filemap_read+0x2f3d/0x3220 mm/filemap.c:2762
 call_read_iter include/linux/fs.h:2183 [inline]
 generic_file_splice_read+0x240/0x640 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x40c/0xbd0 fs/splice.c:865
 do_splice_direct+0x283/0x3d0 fs/splice.c:974
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffa6835f409
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc847f4c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000000474f2 RCX: 00007ffa6835f409
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffc847f4d00 R09: 00007ffc847f4d00
R10: 0000000000010000 R11: 0000000000000246 R12: 00007ffc847f4ccc
R13: 00007ffc847f4d00 R14: 00007ffc847f4ce0 R15: 0000000000000006
 </TASK>

The buggy address belongs to stack of task syz-executor283/5128
 and is located at offset 31 in frame:
 seqcount_lockdep_reader_access+0x0/0x220

This frame has 2 objects:
 [32, 40) 'flags.i.i.i1'
 [64, 72) 'flags.i.i.i'

The buggy address belongs to the virtual mapping at
 [ffffc90003da8000, ffffc90003db1000) created by:
 copy_process+0x5c9/0x3f50 kernel/fork.c:2097

The buggy address belongs to the physical page:
page:ffffea0000844bc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2112f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5083, tgid 5083 (syz-executor283), ts 288268792766, free_ts 60390908841
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x3449/0x35c0 mm/page_alloc.c:4283
 __alloc_pages+0x291/0x7e0 mm/page_alloc.c:5549
 vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
 __vmalloc_area_node mm/vmalloc.c:3057 [inline]
 __vmalloc_node_range+0x966/0x1370 mm/vmalloc.c:3227
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct+0x3e5/0x6d0 kernel/fork.c:987
 copy_process+0x5c9/0x3f50 kernel/fork.c:2097
 kernel_clone+0x22d/0x990 kernel/fork.c:2681
 __do_sys_clone kernel/fork.c:2822 [inline]
 __se_sys_clone kernel/fork.c:2806 [inline]
 __x64_sys_clone+0x235/0x280 kernel/fork.c:2806
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare mm/page_alloc.c:1496 [inline]
 free_unref_page_prepare+0xf3a/0x1040 mm/page_alloc.c:3369
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3464
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x6e5/0x12b0 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2183 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7e2/0xbe0 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc90003daf180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003daf200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003daf280: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
                                                    ^
 ffffc90003daf300: 00 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003daf380: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
