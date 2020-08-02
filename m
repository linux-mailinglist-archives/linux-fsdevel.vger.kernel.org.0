Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46C82359C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgHBS0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 14:26:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54168 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBS0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:26:20 -0400
Received: by mail-io1-f69.google.com with SMTP id f22so17005316iof.20
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2020 11:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wAkG0FHJ8ZDz983xILH6vmf8fGDdyhMkdSmDPazC4xw=;
        b=rLxBFlmj2gF/Nsap4Cc/Q7shrc0GLO9hIejnUXaVB5lLbK4JcL/uTr0c+leViJUlJ8
         KByJpeTUEy210MspnRIqYabjo8Fc7HnC3aMTniV7WPIz5c65I6aS8+IfbApNW+Xgbt60
         KU89gzj1mWckgXNezMTN08PoQGg6QU/8M7Z9/XrdH6DQsPabeaP/n+1+cQgLzUTDumh8
         k7RTuEio94hR7zdGTBmpZyGzXL20Ygn9ccqAZYBhgb7sU9ejRfvbcwDWo4eX75+/d1uV
         J3FkF0bFigP/DamDEOzNAMPN40nhiXEqMHBVJB1Cw36OCxIlPUty1NC/QMLYXuAQlRJy
         bSIw==
X-Gm-Message-State: AOAM531e1u3dV71dnxmoqbzK2S/bIDMglW+NhXWYRwRI3m8wLVis+lK6
        SbT68kseYIrei84CrSpJ94o3Hi7Q6ebFugNQOfQylsGvjBfP
X-Google-Smtp-Source: ABdhPJwO6lidzMdjy2wDwPs72RNvZ6WdfXmtYZWKKdMansNpcLocxcs2/BSgCwfvY1soaNW+QtyLx8y6Ag41Fm6V95cvg2yjEB4u
MIME-Version: 1.0
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr14277146ilm.25.1596392779066;
 Sun, 02 Aug 2020 11:26:19 -0700 (PDT)
Date:   Sun, 02 Aug 2020 11:26:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084b59f05abe928ee@google.com>
Subject: INFO: task hung in pipe_release (2)
From:   syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6ba1b005 Merge tag 'asm-generic-fixes-5.8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a5a3b0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
dashboard link: https://syzkaller.appspot.com/bug?extid=61acc40a49a3e46e25ea
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142ae224900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com

INFO: task syz-executor.0:7075 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D28288  7075   6828 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3458 [inline]
 __schedule+0x8ea/0x2210 kernel/sched/core.c:4219
 schedule+0xd0/0x2a0 kernel/sched/core.c:4294
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4353
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_release+0x49/0x320 fs/pipe.c:722
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x415ee1
Code: Bad RIP value.
RSP: 002b:00007ffd249bc0c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000415ee1
RDX: 0000000000000000 RSI: 00000000007904d0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd249bc1b0 R11: 0000000000000293 R12: 00000000007905a8
R13: 00000000000ffc79 R14: ffffffffffffffff R15: 000000000078bfac

Showing all locks held in the system:
1 lock held by khungtaskd/1153:
 #0: ffffffff89bc11c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5779
1 lock held by in:imklog/6695:
 #0: ffff8880979b6670 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
1 lock held by syz-executor.0/7075:
 #0: ffff8880a8e02068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880a8e02068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_release+0x49/0x320 fs/pipe.c:722
2 locks held by syz-executor.0/7077:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1153 Comm: khungtaskd Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 7077 Comm: syz-executor.0 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:iov_iter_alignment+0x39e/0x850 lib/iov_iter.c:1236
Code: 48 8b 44 24 18 80 38 00 0f 85 f4 03 00 00 4d 8b 7d 18 44 89 e3 48 89 d8 48 c1 e0 04 4c 01 f8 48 8d 78 0c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 32 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
RSP: 0018:ffffc9000206f868 EFLAGS: 00000a07
RAX: ffff8880a8124c00 RBX: 0000000000000000 RCX: ffffffff8395bf6f
RDX: 1ffff11015024981 RSI: ffffffff8395be14 RDI: ffff8880a8124c0c
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8880994e63c7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000206fc68 R14: dffffc0000000000 R15: ffff8880a8124c00
FS:  00007fba306d0700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9573761000 CR3: 0000000091a0d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_unaligned_io fs/ext4/file.c:175 [inline]
 ext4_dio_write_iter fs/ext4/file.c:465 [inline]
 ext4_file_write_iter+0x345/0x13d0 fs/ext4/file.c:653
 call_write_iter include/linux/fs.h:1908 [inline]
 do_iter_readv_writev+0x567/0x780 fs/read_write.c:713
 do_iter_write+0x188/0x5f0 fs/read_write.c:1018
 vfs_iter_write+0x70/0xa0 fs/read_write.c:1059
 iter_file_splice_write+0x721/0xbe0 fs/splice.c:750
 do_splice_from fs/splice.c:846 [inline]
 do_splice+0xbcd/0x1820 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1419 [inline]
 __se_sys_splice fs/splice.c:1401 [inline]
 __x64_sys_splice+0x198/0x250 fs/splice.c:1401
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: 8d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fba306cfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000032240 RCX: 000000000045c369
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000078bff8 R08: 000000000000ffe0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bfac
R13: 00007ffd249bc04f R14: 00007fba306d09c0 R15: 000000000078bfac


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
