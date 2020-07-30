Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B6232B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 07:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgG3FE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 01:04:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56789 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgG3FE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:04:27 -0400
Received: by mail-io1-f72.google.com with SMTP id f21so17655041ioo.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 22:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ndI1GJWk1ohpkP39+WaYL0ydyTzI+fvmVQ6aH/95t0A=;
        b=pAvyNeSySJQ1y46Jf5zR6mik1FdnKiz3LhYsSGsV0GiSRsge3G0KnUnZeNoXyZex7G
         BbTgV794KTsKPgbIpwmCuOodcLCp5V21bNd7hKbHWrP7y/zgK+9c+ylpdGesTK6saefe
         YSvLlVT6RdeuDovO8lxxPdDyzY35G2wsYX3XpGM1QdYg6ehgABxQEnW+x1pWbRgKdFAm
         F965YaGcqkm8xYZOGcnHUYKYaqh6MjfOpvr6aoSFaSzJ8gz6Byt1k1D8upuQrobqh1SD
         YYMwnA/BkRwcFiBp5ehO12k971dYQGBkNYjUiBDf130uzuPogRwZXTJFDhLUsoPzvPlK
         Znvw==
X-Gm-Message-State: AOAM532T9ewLIhR8hNSs4gSJPbWEzRaic+cdkITMaHs3dVjqcF4L5Sy5
        dB8xJ1Fj9Uq696D9Phx1WahhGVfM15HbMupE6Usk73aF+KNN
X-Google-Smtp-Source: ABdhPJyOAp1ed7yqWDad3uR1dc28MjVvzeXigofArAwXZ7JAeR10AJ8PVsivmH5C5xSDjub9ULoYaF8SJdXn9nQfQWqnTbPXCkv+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr2525599ilr.97.1596085463409;
 Wed, 29 Jul 2020 22:04:23 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:04:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013eb8005aba19be3@google.com>
Subject: INFO: task hung in pipe_write (4)
From:   syzbot <syzbot+2bb1411e81c5c86571b6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    26027945 Add linux-next specific files for 20200724
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d5c5d8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=785eb1cc9c75f625
dashboard link: https://syzkaller.appspot.com/bug?extid=2bb1411e81c5c86571b6
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16be8964900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2bb1411e81c5c86571b6@syzkaller.appspotmail.com

INFO: task syz-executor.0:16173 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16173  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16251 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16251  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16285 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16285  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16290 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D30096 16290  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16297 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16297  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16309 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16309  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16355 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16355  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16360 blocked for more than 145 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16360  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16365 blocked for more than 145 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16365  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c
INFO: task syz-executor.0:16396 blocked for more than 145 seconds.
      Not tainted 5.8.0-rc6-next-20200724-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 16396  15761 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3533 [inline]
 __schedule+0x908/0x21e0 kernel/sched/core.c:4289
 schedule+0xd0/0x2a0 kernel/sched/core.c:4364
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4423
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10d0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1883 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5c6/0x6f0 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fffaa3d45a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037380 RCX: 000000000045c369
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000007903f0
R13: 0000000000000000 R14: 0000000000000dce R15: 000000000078bf0c

Showing all locks held in the system:
1 lock held by khungtaskd/1164:
 #0: ffffffff89c52bc0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5817
1 lock held by in:imklog/6538:
 #0: ffff8880952f03b0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor.0/16083:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x5bd/0x16c0 fs/pipe.c:580
1 lock held by syz-executor.0/16173:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16251:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16285:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16290:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16297:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16309:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16355:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16360:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16365:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16396:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16430:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16447:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16517:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16522:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16527:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16532:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16591:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16606:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16614:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16627:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16637:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16687:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16783:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16834:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16846:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16933:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/16951:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17003:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17008:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17028:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17051:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17064:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17074:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17092:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17097:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17150:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17201:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17209:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17216:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17248:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17253:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17278:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17283:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17319:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17347:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17357:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17364:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17397:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17430:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17435:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17440:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17455:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17467:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17491:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17510:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17543:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17550:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17584:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17594:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17626:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17650:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17672:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17677:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17805:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17894:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17896:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17908:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17913:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17945:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18062:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18072:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18099:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18109:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18138:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18213:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18245:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18268:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18276:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18290:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18322:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18327:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18347:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18352:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18449:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18459:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18521:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18619:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18663:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18678:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18704:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18731:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18749:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18780:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18802:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18835:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18880:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18948:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18957:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18997:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19027:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19032:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19047:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19079:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19118:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19163:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19180:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19190:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19210:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19281:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19286:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19308:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19349:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19393:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19395:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19442:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19465:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19486:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19526:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19541:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19609:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19634:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19760:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19836:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19843:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19875:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19885:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19890:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19915:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19920:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19936:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19938:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19957:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19996:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20013:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20023:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20041:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20113:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20172:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20256:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20288:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20300:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20340:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20395:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20411:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20471:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20562:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20622:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20625:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20670:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20720:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20781:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20786:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20803:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20813:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20833:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20857:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20916:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20944:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20964:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20967:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20972:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21005:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21026:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21028:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21041:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21062:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21072:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21117:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21210:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21215:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21341:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21343:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21382:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21414:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21424:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21439:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21449:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21465:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21470:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21493:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21537:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21542:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21563:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21607:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21617:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21627:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21630:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21645:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21658:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21692:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21697:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21707:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21792:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21797:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21802:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21817:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21827:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21830:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21835:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21840:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21876:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21899:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21939:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21970:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22074:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22111:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22135:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22148:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22177:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22207:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22215:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22246:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22256:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22332:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22342:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22368:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22426:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22431:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22547:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22571:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22588:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22742:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22747:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22858:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22867:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22882:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22899:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22907:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22915:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22933:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22948:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22970:
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff8880922c6068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
