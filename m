Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC359D1A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiHWG7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 02:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbiHWG73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:59:29 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F61F15A1B
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 23:59:28 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id a21-20020a5d9815000000b006882e9be20aso6881052iol.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=29V1kxVUW3EwQRaqzTQ6JyEXfaDjKQkAV8eYjg4pbH0=;
        b=CjboL6VRjzHCRlwLEAtx1HydqObc9vKi9vfRFSWd9WtTfqtLo9Y8Pi9GeDYcmiDqAX
         sTVI8g8KZLCVAKD3V+8GSaLZruQtDCCoWNQzybAXmpUas4ceJufA7cjbiFTocnkp1vOi
         y5+PQ2AyCsMA/gd+cHs0jrY6ftAwq6ZcJwDnHYw4rvsZFeMAjbaTN0BO3xq2gzyADbFJ
         sPYCg0SDu6XdAdqC7XWPJVwehRD3GJyXtFT+9g1Ho52ZHP/WocVgng36I6HWzG7qhw6x
         svOk2LL57eHGtr785WLUzgq8znKJUDbtUbu3d2I7w2uVher68vvTQAup6be6Ta0wBabS
         6ufw==
X-Gm-Message-State: ACgBeo2ZU69pXvj2xcR43fD8stV/XZi8p1uvqXMo+6/Ya8DsEQOTXy0l
        xwSmL5d5kzHfEmqNYIoTAObISGP2jIcBOmGqozIS5PwD/2eT
X-Google-Smtp-Source: AA6agR6SSfDZQSDLeDvPmJDFgTvyl5pTtyWjSq9EkDJMEiQjLoF1JUUQ7BRr0sEjXBEZnsBE+e3LHxxY9lSBYaVLmvsD10vvIdsF
MIME-Version: 1.0
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id
 9-20020a021d09000000b0033ba8cc17d3mr10741726jaj.25.1661237967928; Mon, 22 Aug
 2022 23:59:27 -0700 (PDT)
Date:   Mon, 22 Aug 2022 23:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f745de05e6e31a3f@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in __access_remote_vm
From:   syzbot <syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144f3023080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=35b87c668935bb55e666
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a5c1f3080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e9ce85080000

The issue was bisected to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112f1867080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=132f1867080000
console output: https://syzkaller.appspot.com/x/log.txt?x=152f1867080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

loop0: detected capacity change from 0 to 64
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:675:13
shift exponent -247 is negative
CPU: 0 PID: 3617 Comm: syz-executor807 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1521
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 3617, name: syz-executor807
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz-executor807/3617:
 #0: ffff888022d380e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
irq event stamp: 4810
hardirqs last  enabled at (4809): [<ffffffff816199ce>] __up_console_sem+0xae/0xc0 kernel/printk/printk.c:264
hardirqs last disabled at (4810): [<ffffffff894c1738>] dump_stack_lvl+0x2e/0x134 lib/dump_stack.c:139
softirqs last  enabled at (4804): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (4804): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (4789): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (4789): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
CPU: 0 PID: 3617 Comm: syz-executor807 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor807[3617] cmdline: ./syz-executor807082514
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 parse_ntfs_boot_sector fs/ntfs/super.c:915 [inline]
 ntfs_fill_super.cold+0x147/0x56c fs/ntfs/super.c:2792
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcec358610a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5a5afbf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd5a5afc50 RCX: 00007fcec358610a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd5a5afc10
RBP: 00007ffd5a5afc10 R08: 00007ffd5a5afc50 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000230
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000002
 </TASK>
syz-executor807[3617] cmdline: ./syz-executor807082514
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 parse_ntfs_boot_sector fs/ntfs/super.c:915 [inline]
 ntfs_fill_super.cold+0x147/0x56c fs/ntfs/super.c:2792
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcec358610a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5a5afbf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd5a5afc50 RCX: 00007fcec358610a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd5a5afc10
RBP: 00007ffd5a5afc10 R08: 00007ffd5a5afc50 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000230
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000002
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
