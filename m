Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F050255D5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgH1PIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 11:08:31 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43251 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgH1PIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:08:21 -0400
Received: by mail-io1-f71.google.com with SMTP id f19so1137192iol.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 08:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FeR7Y7CzIOJ+gzJ/nk4sBL3fbvpwci6f5vTL0BhOUIc=;
        b=NQlFuyVGvT+Udv2qL7/qbjKBRGdtv5J+rFi/YAHi+Wi+iKBlZXlTh35Uf56j4QPCzK
         eXVJmybMHs4APOQKDuiyHN4H5b2r5anv1jPJXdwHvKd2WznT9yONIzw4kzKtKugYwCRK
         vd3bV1prSdewuDqvjySJ/j6xf95tlpUwD5KPkxC4kBmIpc0JbzYromqPyy3ZYn2sxI3Y
         3d/BLquNuuXupF71Ie0j0YsFxnN5lHXCFQ6btAopw/O+TqG3y4dsbA29Gacpn82RUg6y
         anClo3If3bW9r09y8Ht7IX2mW8FqozPYTaLL7fIM9LnCeJs3trrdqJujdGc1T3/K1GOL
         SkMQ==
X-Gm-Message-State: AOAM533DFS7SKxI9bHAmFiZXcJxYSDI1AnTajjixvDW11soDptfTXmNM
        eMUfVBy6Flx/Khh2TPtLvGey5s4+JjMe7uSNZIkSwodzSr7V
X-Google-Smtp-Source: ABdhPJwKSSPFqBe4UsWBm9JmlfA/3IITwJROcKJBQ+d0UQoxT5osrPB2U9o+DCX5L6gqxeHfto3K2+jN2sEzv27InceNBzHthENE
MIME-Version: 1.0
X-Received: by 2002:a92:4995:: with SMTP id k21mr1730823ilg.30.1598627300646;
 Fri, 28 Aug 2020 08:08:20 -0700 (PDT)
Date:   Fri, 28 Aug 2020 08:08:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006226c805adf16cb8@google.com>
Subject: WARNING: ODEBUG bug in exit_to_user_mode_prepare
From:   syzbot <syzbot+fbd7ba7207767ed15165@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d012a719 Linux 5.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e9e90e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=fbd7ba7207767ed15165
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f81666900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15abb10e900000

The issue was bisected to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130823a9900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108823a9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=170823a9900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbd7ba7207767ed15165@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

------------[ cut here ]------------
ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 10170 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 10170 Comm: syz-executor403 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd e0 26 94 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd e0 26 94 88 48 c7 c7 40 1c 94 88 e8 82 3b a6 fd <0f> 0b 83 05 83 54 13 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc9000dabfdd0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888093ada540 RSI: ffffffff815dafc7 RDI: fffff52001b57fac
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae720f8b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89bd6780
R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x301/0x41c lib/debugobjects.c:998
 kmem_cache_free.part.0+0x16d/0x1f0 mm/slab.c:3692
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447849
Code: e8 9c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 04 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f37799a7db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: 0000000000000000 RBX: 00000000006ddc68 RCX: 0000000000447849
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 00000000006ddc60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00000000006ddc6c
R13: 00007ffcdbf7f6bf R14: 00007f37799a89c0 R15: 0000000000000000
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
