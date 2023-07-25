Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD4760FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjGYJvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjGYJvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:51:43 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B9E61
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 02:51:40 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a5b891b4e8so3556513b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 02:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278700; x=1690883500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYKzWqzorSSaPoBJlxjvP7Imx/rNYqorp2HY+cczmnc=;
        b=KZgs4+r10Mn+pCqwkUt4pJm2pappqgELFuQ/qlMo7svW5MVS647IQY1uXUS5ujhQll
         lESLbQHEablsG+teS2w05V8kuzIfT3yyclrwyTzj3UMQXFGQBnlzDaDACsVZq+15ysWl
         3F3RD6W28kK9CD9s4nKBXX7C7bZxo6uc8kaNzd79HLApdS6z/5OB5iyBHcsyJ8tbw0pA
         cX0foV9tAifSJzbxutENj5+UyDku1XAkbtqDB9FjIi4mowGe2s2oPQVV2M1GVzOvpXep
         ryFW8a64GJlGP+3b5+0Z/RouthzHAl0ujjOopnwe7PhYQLfUv2Kix0ywhYz9cFGViVQc
         2LnA==
X-Gm-Message-State: ABy/qLbpl6ODWKW+o+OiPgSzY+jbFwLbwOlyQ+I2Hb4Unb4a4fSD4Wyo
        8WeeYIs9/e5ocRUoD0dwqAdXfCsYg5T1ZibYM6oW861IwbtI
X-Google-Smtp-Source: APBJJlExa2Ycnre8KmItjVu7UpOhXEGFa6QQ+5HnOjex5KdS7VFHmdcjZoGkTVKKRv/8cxQxvrVT8A6sgIFzL/RE7mBZJzbeibIg
MIME-Version: 1.0
X-Received: by 2002:a05:6808:10c3:b0:3a4:14c1:20f5 with SMTP id
 s3-20020a05680810c300b003a414c120f5mr24234779ois.6.1690278700033; Tue, 25 Jul
 2023 02:51:40 -0700 (PDT)
Date:   Tue, 25 Jul 2023 02:51:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007caa3f06014cad2e@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in gfs2_make_fs_ro
From:   syzbot <syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16bf15aea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d67e9ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3b4b06a5f02/disk-46670259.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4db334f36495/vmlinux-46670259.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5977e704aeb2/bzImage-46670259.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/053f03da9748/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: found 1 quota changes
syz-executor154: attempt to access beyond end of device
loop0: rw=1, sector=131324, nr_sectors = 4 limit=32768
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
gfs2: fsid=syz:syz.0: fatal: I/O error(s)
gfs2: fsid=syz:syz.0: about to withdraw this file system
BUG: sleeping function called from invalid context at kernel/sched/completion.c:101
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5019, name: syz-executor154
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
5 locks held by syz-executor154/5019:
 #0: ffff8880297960e0 (&type->s_umount_key#47){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:360
 #1: ffff88802854cb78 (&sdp->sd_quota_sync_mutex){+.+.}-{3:3}, at: gfs2_quota_sync+0xa1/0x700 fs/gfs2/quota.c:1304
 #2: ffff88802854d060 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: gfs2_log_flush+0x105/0x25f0 fs/gfs2/log.c:1042
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_flush_revokes+0x53/0x90 fs/gfs2/log.c:814
 #4: ffff88802854d248 (&sdp->sd_freeze_mutex){+.+.}-{3:3}, at: signal_our_withdraw fs/gfs2/util.c:151 [inline]
 #4: ffff88802854d248 (&sdp->sd_freeze_mutex){+.+.}-{3:3}, at: gfs2_withdraw+0x477/0x11e0 fs/gfs2/util.c:334
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5019 Comm: syz-executor154 Not tainted 6.5.0-rc2-syzkaller-00066-g46670259519f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10189
 __wait_for_common kernel/sched/completion.c:101 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x1b/0x60 kernel/sched/completion.c:138
 kthread_stop+0x18e/0x5a0 kernel/kthread.c:710
 gfs2_make_fs_ro+0x183/0x680 fs/gfs2/super.c:555
 signal_our_withdraw fs/gfs2/util.c:153 [inline]
 gfs2_withdraw+0x48a/0x11e0 fs/gfs2/util.c:334
 gfs2_ail1_empty+0x7d0/0x860 fs/gfs2/log.c:377
 gfs2_flush_revokes+0x5e/0x90 fs/gfs2/log.c:815
 revoke_lo_before_commit+0x2c/0x5f0 fs/gfs2/lops.c:868
 lops_before_commit fs/gfs2/lops.h:40 [inline]
 gfs2_log_flush+0xc93/0x25f0 fs/gfs2/log.c:1101
 do_sync+0xa35/0xc80 fs/gfs2/quota.c:977
 gfs2_quota_sync+0x30e/0x700 fs/gfs2/quota.c:1320
 gfs2_sync_fs+0x4d/0xb0 fs/gfs2/super.c:680
 sync_filesystem+0xec/0x220 fs/sync.c:56
 generic_shutdown_super+0x6f/0x340 fs/super.c:472
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fca0c3e4749
Code: Unable to access opcode bytes at 0x7fca0c3e471f.
RSP: 002b:00007ffdd6ff7a08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fca0c3e4749
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fca0c47f2b0 R08: ffffffffffffffb8 R09: 000000000001f6db
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fca0c47f2b0
R13: 0000000000000000 R14: 00007fca0c480020 R15: 00007fca0c3b2c90
 </TASK>
BUG: scheduling while atomic: syz-executor154/5019/0x00000002
5 locks held by syz-executor154/5019:
 #0: ffff8880297960e0 (&type->s_umount_key#47){+.+.}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:360
 #1: ffff88802854cb78 (&sdp->sd_quota_sync_mutex){+.+.}-{3:3}, at: gfs2_quota_sync+0xa1/0x700 fs/gfs2/quota.c:1304
 #2: ffff88802854d060 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: gfs2_log_flush+0x105/0x25f0 fs/gfs2/log.c:1042
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #3: ffff88802854ce88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_flush_revokes+0x53/0x90 fs/gfs2/log.c:814
 #4: ffff88802854d248 (&sdp->sd_freeze_mutex){+.+.}-{3:3}, at: signal_our_withdraw fs/gfs2/util.c:151 [inline]
 #4: ffff88802854d248 (&sdp->sd_freeze_mutex){+.+.}-{3:3}, at: gfs2_withdraw+0x477/0x11e0 fs/gfs2/util.c:334
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


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
