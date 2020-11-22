Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC72BC983
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 22:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgKVVPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 16:15:17 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44506 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgKVVPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:15:16 -0500
Received: by mail-il1-f200.google.com with SMTP id j8so11595403ilr.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2020 13:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yJWwjk1Piypmqo9o82HYljTzCBhZ9P+450z1i8RHVz8=;
        b=PXzIje3iq7IwnKCUKFsgZZRjkI3TZYcp7qE0h9Qvx5z6MTQXYxyq5jgrT3W87vjSFu
         DIpLZ+ea5YG8uqbTqzo6YvVh+8Wz2nKCThJb5XAr0yVO7x6bqnIP8+6Xm41+wwY4j4z1
         +WJLBbernf1zIpfG5poeYoPlNln2bg1eCHdIE7d0SsyAGvrdxnipc1K51iP0XGEcbjfq
         N/qUdsvOyB7YcG4xW8JS4icTqRDo2LjS+l0IDQc7FFPTcwytiUz7Rnkk8pcR7jaysqrV
         uog3p474ItSB3y+0HIoNPRZvxaz1ypqDjsxMe2/qGK82zVnDcX8WGzP8wnlR/DsMbxiu
         zEkg==
X-Gm-Message-State: AOAM530YkbtUbrHZ2/IzCwheQmZbiF6oQUWxE1utj7vDCiODSr2HTQOo
        T/8Stg95wYDMtO7hInQq2VShDlDo90KblBbcdlX7Z2eTV/vs
X-Google-Smtp-Source: ABdhPJzT8U2Hlry26PAIypjMJMx1UPsnm4dzvbXNesERc/Q2SRumBOSG00i0rbbQ3tcmrFPYBQOEAmt4ysx8AH5wbfX8WgNPXW3u
MIME-Version: 1.0
X-Received: by 2002:a02:9589:: with SMTP id b9mr26872534jai.39.1606079715472;
 Sun, 22 Nov 2020 13:15:15 -0800 (PST)
Date:   Sun, 22 Nov 2020 13:15:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebfc4605b4b892b2@google.com>
Subject: possible deadlock in freeze_super
From:   syzbot <syzbot+f60646ed0fee22ac695d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a349e4c6 Merge tag 'xfs-5.10-fixes-7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16158d71500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6867674f76eceeb6
dashboard link: https://syzkaller.appspot.com/bug?extid=f60646ed0fee22ac695d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f60646ed0fee22ac695d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:1H/2986 is trying to acquire lock:
ffff88801cdca0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: freeze_super+0x41/0x330 fs/super.c:1716

but task is already holding lock:
ffffc90001b2fda8 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}:
       process_one_work+0x8a2/0x15a0 kernel/workqueue.c:2248
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
       kthread+0x3af/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

-> #1 ((wq_completion)glock_workqueue){+.+.}-{0:0}:
       flush_workqueue+0x110/0x13e0 kernel/workqueue.c:2783
       gfs2_gl_hash_clear+0xad/0x270 fs/gfs2/glock.c:1987
       gfs2_put_super+0x44b/0x680 fs/gfs2/super.c:740
       generic_shutdown_super+0x144/0x370 fs/super.c:464
       kill_block_super+0x97/0xf0 fs/super.c:1446
       gfs2_kill_sb+0x104/0x160 fs/gfs2/ops_fstype.c:1662
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
       task_work_run+0xdd/0x190 kernel/task_work.c:151
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
       exit_to_user_mode_prepare+0x17e/0x1a0 kernel/entry/common.c:191
       syscall_exit_to_user_mode+0x38/0x260 kernel/entry/common.c:266
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&type->s_umount_key#83){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2866 [inline]
       check_prevs_add kernel/locking/lockdep.c:2991 [inline]
       validate_chain kernel/locking/lockdep.c:3606 [inline]
       __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
       lock_acquire kernel/locking/lockdep.c:5435 [inline]
       lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
       down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
       freeze_super+0x41/0x330 fs/super.c:1716
       freeze_go_sync+0x193/0x2c0 fs/gfs2/glops.c:587
       do_xmote+0x2ff/0xbc0 fs/gfs2/glock.c:616
       run_queue+0x323/0x680 fs/gfs2/glock.c:753
       glock_work_func+0xff/0x3f0 fs/gfs2/glock.c:926
       process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
       kthread+0x3af/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#83 --> (wq_completion)glock_workqueue --> (work_completion)(&(&gl->gl_work)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&gl->gl_work)->work));
                               lock((wq_completion)glock_workqueue);
                               lock((work_completion)(&(&gl->gl_work)->work));
  lock(&type->s_umount_key#83);

 *** DEADLOCK ***

2 locks held by kworker/0:1H/2986:
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888016d03938 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc90001b2fda8 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247

stack backtrace:
CPU: 0 PID: 2986 Comm: kworker/0:1H Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: glock_workqueue glock_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2115
 check_prev_add kernel/locking/lockdep.c:2866 [inline]
 check_prevs_add kernel/locking/lockdep.c:2991 [inline]
 validate_chain kernel/locking/lockdep.c:3606 [inline]
 __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
 lock_acquire kernel/locking/lockdep.c:5435 [inline]
 lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
 down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
 freeze_super+0x41/0x330 fs/super.c:1716
 freeze_go_sync+0x193/0x2c0 fs/gfs2/glops.c:587
 do_xmote+0x2ff/0xbc0 fs/gfs2/glock.c:616
 run_queue+0x323/0x680 fs/gfs2/glock.c:753
 glock_work_func+0xff/0x3f0 fs/gfs2/glock.c:926
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
