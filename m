Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39159BC50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 11:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiHVJJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 05:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiHVJJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:09:34 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD22ED70
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 02:09:32 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l15-20020a0566022dcf00b00688e70a26deso5224016iow.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 02:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=wCyteA31pcIv0iGUHos9xPXPZCHgVFcCP8pPu4IGEA4=;
        b=mP7D2aNfl/F6zHXOklwDIFGWWYrrU6F40tHvVcniWgpeK726cXm+MZEAlYPg9oXXRI
         i3wx+QheutOWsPEwQwAnk8DOGBqIg34W/EEJHoHdRVkRDYgbXvrPs7rtEHFYnk7NEfye
         d5gCRUeuvGxvgBxEnGfCkBxsnmLH0oAaR9rVN3JIqB1PCewT/lllJL25RTO2Wi0BIAPc
         cryu2qwVjVUn5dSq0YSjM4WTRVdWbXfNYRa2dMVfjMD4FkqE15FpSwdQ7ONwZ+pslxwY
         mygGCYOASKXnPWXWgnqvfqWsNoR7MnF/zvE5eGdU3COIIaj0Fj4Iw/Ku9pSKrOwTlExO
         aHsw==
X-Gm-Message-State: ACgBeo3n9/+itQDtrahlVdCcLIOvp6y+8HHT1tSkZLrAjRCNDc+4HIfg
        G/fziamLElyc8n6YXnSqLCW5q3k/+Xdc8nsGGFPnldhYmCN5
X-Google-Smtp-Source: AA6agR4Ius5JHGW5FJ0WdN47Xv8Px6QRuk163WOqdVF3QpnnaxjYaqRV/pGMNrpfoa3LRwQhLv3gIMzT7d5jq7unsDdPZs72A1rK
MIME-Version: 1.0
X-Received: by 2002:a6b:c582:0:b0:688:3b57:c64c with SMTP id
 v124-20020a6bc582000000b006883b57c64cmr8628671iof.105.1661159371334; Mon, 22
 Aug 2022 02:09:31 -0700 (PDT)
Date:   Mon, 22 Aug 2022 02:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e678705e6d0ce67@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __access_remote_vm
From:   syzbot <syzbot+5fb61eb0bea5eab81137@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, brauner@kernel.org,
        chengzhihao1@huawei.com, deller@gmx.de, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xu.xin16@zte.com.cn
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c3b6eb080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=5fb61eb0bea5eab81137
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166bdb3d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16298e5b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fb61eb0bea5eab81137@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 1
CPU: 0 PID: 3608 Comm: syz-executor343 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1521
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 3608, name: syz-executor343
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
no locks held by syz-executor343/3608.
irq event stamp: 4344
hardirqs last  enabled at (4343): [<ffffffff816199ce>] __up_console_sem+0xae/0xc0 kernel/printk/printk.c:264
hardirqs last disabled at (4344): [<ffffffff894c1738>] dump_stack_lvl+0x2e/0x134 lib/dump_stack.c:139
softirqs last  enabled at (4338): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (4338): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (4313): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (4313): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
CPU: 0 PID: 3608 Comm: syz-executor343 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor343[3608] cmdline: ./syz-executor3436215905
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
 fail_dump lib/fault-inject.c:55 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:155
 copyin+0x19/0x120 lib/iov_iter.c:177
 _copy_from_iter+0x36e/0x11c0 lib/iov_iter.c:628
 copy_from_iter include/linux/uio.h:184 [inline]
 copy_from_iter_full include/linux/uio.h:191 [inline]
 memcpy_from_msg include/linux/skbuff.h:3938 [inline]
 netlink_sendmsg+0x875/0xe10 net/netlink/af_netlink.c:1906
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4f5b3848f9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfef8b808 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4f5b3848f9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00007ffdfef8b810 R08: 0000000000000001 R09: 00007f4f5b340035
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
syz-executor343[3608] cmdline: ./syz-executor3436215905
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 fail_dump lib/fault-inject.c:55 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:155
 copyin+0x19/0x120 lib/iov_iter.c:177
 _copy_from_iter+0x36e/0x11c0 lib/iov_iter.c:628
 copy_from_iter include/linux/uio.h:184 [inline]
 copy_from_iter_full include/linux/uio.h:191 [inline]
 memcpy_from_msg include/linux/skbuff.h:3938 [inline]
 netlink_sendmsg+0x875/0xe10 net/netlink/af_netlink.c:1906
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4f5b3848f9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfef8b808 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000001 RCX:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
