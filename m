Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEC3EB605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhHMNQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 09:16:52 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33752 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbhHMNQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:16:50 -0400
Received: by mail-il1-f199.google.com with SMTP id i15-20020a92540f0000b0290222feb23cf5so5079831ilb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 06:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nq6Ex5OAIWjHJxuz7eLghOWTV3ehaberZM7g/vAkzME=;
        b=ekWK7BzdUdR1Yp6dSZ4QCiy9+0/7JXPfvp+5xS1f60lH/liTLDDgsSV9oY8h0dHJZC
         anWe4R/V0zZ3tvsjlpwmhRRnKp3RCYD+vk5i4p7e4j+BYDC1LLXlcNWan1/Hu65eu3/t
         ur++Zk8BBi3ytu2cWeaZXSao2ha/Ozc42wlfm2e4uH/6ZV55vLNddhorsLP0+azAyCbN
         /BREReA3vVNkrAL+qdh9bdEsV1h6adjo55BRV962+9nDda+Olw6yv7ZBwZWxwqnJGVhN
         9GkIscJVh70BQsK3gQZBBUEV1Dr5H7B/zUm4muV3jyTEcArSKGPiayj6lzeFXpGU7/FM
         loUw==
X-Gm-Message-State: AOAM533ThhMJ5TdbkcEx0+mBVCMQZ2HyTuNA1UTHxS5FFrfTIaCTp3Vy
        RT7pmkNdKxGxFEY0NwpZ0UpuegcpulphbqYqCYr40VhRfDza
X-Google-Smtp-Source: ABdhPJwUIaxEY4I5UXDHoMGc20qCAwP2MXSM20Kb58mUwjTOdA69+Ys7/IVERJ9D1urqyRrgZWkjep200e7ED0tm8mdPUKmEdkSi
MIME-Version: 1.0
X-Received: by 2002:a92:c80e:: with SMTP id v14mr31752iln.57.1628860584020;
 Fri, 13 Aug 2021 06:16:24 -0700 (PDT)
Date:   Fri, 13 Aug 2021 06:16:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fcee205c970a843@google.com>
Subject: [syzbot] INFO: task hung in fuse_launder_page
From:   syzbot <syzbot+bea44a5189836d956894@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    36a21d51725a Linux 5.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104b8eaa300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=bea44a5189836d956894
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143c0ee9300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fc9aa300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bea44a5189836d956894@syzkaller.appspotmail.com

INFO: task syz-executor276:8433 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor276 state:D stack:27736 pid: 8433 ppid:  8430 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 fuse_wait_on_page_writeback fs/fuse/file.c:452 [inline]
 fuse_wait_on_page_writeback+0x120/0x170 fs/fuse/file.c:448
 fuse_launder_page fs/fuse/file.c:2316 [inline]
 fuse_launder_page+0xe9/0x130 fs/fuse/file.c:2306
 do_launder_page mm/truncate.c:595 [inline]
 invalidate_inode_pages2_range+0x994/0xf80 mm/truncate.c:661
 fuse_finish_open+0x2d9/0x560 fs/fuse/file.c:202
 fuse_open_common+0x2f9/0x4c0 fs/fuse/file.c:254
 do_dentry_open+0x4c8/0x11d0 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_creat fs/open.c:1294 [inline]
 __se_sys_creat fs/open.c:1288 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1288
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446409
RSP: 002b:00007f0e6a9f92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00000000004d34f0 RCX: 0000000000446409
RDX: 0000000000446409 RSI: 0000000000000000 RDI: 0000000020000280
RBP: 00000000004a3164 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 000000000049f158 R14: 00000000004a1160 R15: 00000000004d34f8

Showing all locks held in the system:
1 lock held by khungtaskd/1584:
 #0: ffffffff8b97c1c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
2 locks held by syz-executor276/8433:
 #0: ffff888015e38460 (sb_writers#11){.+.+}-{0:0}, at: do_open fs/namei.c:3367 [inline]
 #0: ffff888015e38460 (sb_writers#11){.+.+}-{0:0}, at: path_openat+0x1aee/0x27f0 fs/namei.c:3507
 #1: ffff8880397d0150 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
 #1: ffff8880397d0150 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: fuse_open_common+0x366/0x4c0 fs/fuse/file.c:241

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1584 Comm: khungtaskd Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd0a/0xfc0 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
