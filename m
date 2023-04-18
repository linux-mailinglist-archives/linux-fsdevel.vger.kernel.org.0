Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA52A6E6D7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjDRU1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjDRU1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:27:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C871BE
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 13:27:43 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso241360339f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 13:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681849662; x=1684441662;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gxn0DnPfADuaP40AJhy/UnpcsyfQMhcLyuDsCayXAKg=;
        b=KRcwX/wX83RuPNt0KmyC9plowSl6dtWwGeV2MbgoiW5W/tsnoduCi9OJiSiOsVpBSU
         JLMLAWED/H8K3yC3BSEi4kWezjz862pqJ89fCYp0Hbg6J/SBX/LsHIirqVFC7BrgTCVc
         e9vdLUGlA3lNl2DC9bc6YAqlV6zKuvMt6EqDlDgZLWJHnh9wukNVgAMXGIY1S/NwucOb
         EWUrkKUIqVCEvMD2IrbOXlSmoP038dPzFiCZYwvKlc2Tm/2Mj8WZ7Z48rsrwJ0iY2pCY
         jna0lStrOKOhbzC6GtsRZrACka73uspFfyj/HwPCPlkyJriB5NNvIL8ZuJQPUeoxHKci
         U8hg==
X-Gm-Message-State: AAQBX9efMOOeDH+LbqJf89vXeqU06DdmfmT+qlDT8KRE+rZleqkoeoFX
        ik+VlrOkYlG8kImIibPnnTIu3jLYVIZiG6JxQYVTNqlHE13O
X-Google-Smtp-Source: AKy350aiI9jjpH7dR8M/oD5GiD956rOdBfdXRVDecdKwxd7Hr8DLFVejFlXqA/AW0Y1xM1w1QawQEaasmWiQuuVIXNhxdM0S/XBX
MIME-Version: 1.0
X-Received: by 2002:a6b:6519:0:b0:760:e308:1070 with SMTP id
 z25-20020a6b6519000000b00760e3081070mr2470616iob.0.1681849662669; Tue, 18 Apr
 2023 13:27:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 13:27:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5973405f9a22358@google.com>
Subject: [syzbot] [ntfs3?] KASAN: stack-out-of-bounds Read in ntfs_set_inode
From:   syzbot <syzbot+cbdd49fbb39696c71041@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de4664485abb Merge tag 'for-linus-2023041201' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a065e3c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90aa79dcf599c3f1
dashboard link: https://syzkaller.appspot.com/bug?extid=cbdd49fbb39696c71041
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbdd49fbb39696c71041@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in ino_get fs/ntfs3/ntfs.h:193 [inline]
BUG: KASAN: stack-out-of-bounds in ntfs_set_inode+0x65/0x70 fs/ntfs3/inode.c:502
Read of size 4 at addr ffffc9000ceafccf by task syz-executor.2/7192

CPU: 3 PID: 7192 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00046-gde4664485abb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 ino_get fs/ntfs3/ntfs.h:193 [inline]
 ntfs_set_inode+0x65/0x70 fs/ntfs3/inode.c:502
 inode_insert5+0x125/0x660 fs/inode.c:1188
 iget5_locked fs/inode.c:1246 [inline]
 iget5_locked+0x225/0x2c0 fs/inode.c:1235
 ntfs_iget5+0xd2/0x3310 fs/ntfs3/inode.c:511
 ntfs_fill_super+0x3138/0x3ab0 fs/ntfs3/super.c:1244
 get_tree_bdev+0x444/0x760 fs/super.c:1303
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3042 [inline]
 path_mount+0x1342/0x1e40 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0de348d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0de425af88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f6bf RCX: 00007f0de348d69a
RDX: 000000002001f6c0 RSI: 000000002001f700 RDI: 00007f0de425afe0
RBP: 00007f0de425b020 R08: 00007f0de425b020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000002001f6c0
R13: 000000002001f700 R14: 00007f0de425afe0 R15: 000000002001f740
 </TASK>

The buggy address belongs to stack of task syz-executor.2/7192
 and is located at offset 127 in frame:
 ntfs_fill_super+0x0/0x3ab0 fs/ntfs3/super.c:473

This frame has 5 objects:
 [48, 52) 'vcn'
 [64, 68) 'lcn'
 [80, 84) 'len'
 [96, 104) 'tt'
 [128, 136) 'ref'

The buggy address belongs to the virtual mapping at
 [ffffc9000cea8000, ffffc9000ceb1000) created by:
 kernel_clone+0xeb/0x890 kernel/fork.c:2682

The buggy address belongs to the physical page:
page:ffffea0001be4580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6f916
memcg:ffff888022837602
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888022837602
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 6955, tgid 6955 (syz-executor.3), ts 238333166289, free_ts 232134443559
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 vm_area_alloc_pages mm/vmalloc.c:2953 [inline]
 __vmalloc_area_node mm/vmalloc.c:3029 [inline]
 __vmalloc_node_range+0xb1c/0x14a0 mm/vmalloc.c:3201
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct kernel/fork.c:982 [inline]
 copy_process+0x1320/0x7590 kernel/fork.c:2098
 kernel_clone+0xeb/0x890 kernel/fork.c:2682
 __do_sys_clone+0xba/0x100 kernel/fork.c:2823
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1309 [inline]
 put_page include/linux/mm.h:1378 [inline]
 generic_pipe_buf_release+0x23d/0x2b0 fs/pipe.c:210
 pipe_buf_release include/linux/pipe_fs_i.h:203 [inline]
 iter_file_splice_write+0x8a3/0xc80 fs/splice.c:793
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:1022
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:977
 do_splice_direct+0x1ab/0x280 fs/splice.c:1065
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc9000ceafb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000ceafc00: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1
>ffffc9000ceafc80: 04 f2 04 f2 04 f2 00 f2 f2 f2 00 f3 f3 f3 00 00
                                              ^
 ffffc9000ceafd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000ceafd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
