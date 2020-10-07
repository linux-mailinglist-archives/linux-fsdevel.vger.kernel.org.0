Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32614285A9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgJGIiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 04:38:20 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:46851 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgJGIiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:38:19 -0400
Received: by mail-io1-f77.google.com with SMTP id a2so865762iod.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2020 01:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M6BHPYhbsPHx1AjqSslcLpAMn5bGu2l+JZyDDFtYaN4=;
        b=Gr/uB/fYMhmxuqJjqvOoGichsW1dU79I1YNO5wAQ2q5r4r+uLH+LiUL+cqNtFDiIfj
         ktDP6T0ApPy9Wb+2A3wG4k4qs0S4fWn5ueoCtCwrTo1UVLSULeI3Pa4FQTkb8CNT3azs
         2VteCG3bP0M+9tc3hNRq6Elldf600CDHlsF7eVR0FxC9udwe+sQc0gSoudS+BDC9BlZP
         E8aAQI/jGAZW5hF6aMJxs0ErOHEjqUldX1bSooujuArsqXXSGyUqaLwwQJlJLDZvUCCP
         kkCTKV+vsuXL3MXNHOjDSq14Tk9QEeUqnRyzQde28/0WeXJNsjERtGejbVq0T6nCCP66
         p3XA==
X-Gm-Message-State: AOAM533foG7sMyTkE3iIAugkWSXj7i6ecYJyZe8u6Vqodj+vPy9rQu89
        JfawTb52WbpY2JawkzlYFEhF1S7Ou/vCdbQU8AIUSUw9x591
X-Google-Smtp-Source: ABdhPJwGm2gvcfpSx8FTCHjnyjjxWgGkV5nfZ11pgQ4g5+63EiIh8vK9tYUKHoZD/u3tglGhEzmpIEQqyD7DHrDOWQtj1M0iwEsT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1250:: with SMTP id j16mr1945662ilq.224.1602059896564;
 Wed, 07 Oct 2020 01:38:16 -0700 (PDT)
Date:   Wed, 07 Oct 2020 01:38:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b31e205b110a3e8@google.com>
Subject: WARNING: locking bug in clear_inode
From:   syzbot <syzbot+4c85be59d8cc26bd485e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    472e5b05 pipe: remove pipe_wait() and fix wakeup race with..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12432b33900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=4c85be59d8cc26bd485e
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c85be59d8cc26bd485e@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 7050 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:183 [inline]
WARNING: CPU: 0 PID: 7050 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:172 [inline]
WARNING: CPU: 0 PID: 7050 at kernel/locking/lockdep.c:183 check_wait_context kernel/locking/lockdep.c:4115 [inline]
WARNING: CPU: 0 PID: 7050 at kernel/locking/lockdep.c:183 __lock_acquire+0x15f1/0x5780 kernel/locking/lockdep.c:4391
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7050 Comm: syz-executor.2 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:hlock_class kernel/locking/lockdep.c:183 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:172 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4115 [inline]
RIP: 0010:__lock_acquire+0x15f1/0x5780 kernel/locking/lockdep.c:4391
Code: 08 84 d2 0f 85 c5 39 00 00 8b 0d c2 e6 fd 09 85 c9 0f 85 7f fa ff ff 48 c7 c6 c0 da 8b 88 48 c7 c7 80 d5 8b 88 e8 41 cb ea ff <0f> 0b e9 65 fa ff ff c7 44 24 48 fe ff ff ff 41 bf 01 00 00 00 c7
RSP: 0018:ffffc90005517818 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888095f94440 RSI: ffffffff815f59d5 RDI: fffff52000aa2ef5
RBP: ffff888095f94440 R08: 0000000000000000 R09: ffffffff8a05ae03
R10: 0000000000000e34 R11: 0000000000000001 R12: ffff888095f94d28
R13: 0000000000001902 R14: ffff8880004057d8 R15: 0000000000040000
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 clear_inode+0x1b/0x1e0 fs/inode.c:529
 proc_evict_inode+0x25/0x160 fs/proc/inode.c:40
 evict+0x2ed/0x750 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 proc_invalidate_siblings_dcache+0x28d/0x600 fs/proc/inode.c:160
 release_task+0xc63/0x14d0 kernel/exit.c:221
 wait_task_zombie kernel/exit.c:1088 [inline]
 wait_consider_task+0x2fd2/0x3b70 kernel/exit.c:1315
 do_wait_thread kernel/exit.c:1378 [inline]
 do_wait+0x376/0xa00 kernel/exit.c:1449
 kernel_wait4+0x14c/0x260 kernel/exit.c:1621
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fc3549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000090bfda4 EFLAGS: 00000216 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00000000090bfe0c
RDX: 0000000040000001 RSI: 0000000000103d9b RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
