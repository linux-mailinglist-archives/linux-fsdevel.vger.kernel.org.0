Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688F48D001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHNJsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 05:48:07 -0400
Received: from mail-oi1-f200.google.com ([209.85.167.200]:39340 "EHLO
        mail-oi1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNJsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:48:06 -0400
Received: by mail-oi1-f200.google.com with SMTP id k22so1789098oic.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 02:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XV02cgM0DiaLJPBZT/dcL2UEgRbdd37HvTZKiTSvZao=;
        b=UQT7eCne7UIu7CUuvKc5uRqdFh5/aFyvkPv5QgsHZBc+7b8JkBNJnkI+cEPF4MLIT6
         ROcTs1C9l1Vb6zPRf0N7USWpOybscUXgo/WmCnFM/9+pUhsFp5/aKzlBK/pJCSqPu61a
         NP1ixG94vne/qrBLEzrpqqwELUUuxX9Ad4b8iqc/D1WoBfiDN8T7XzVqkxtmtP+E3OjF
         YmZZQJ3HrbhMhx+sRNGZ1No8BGAahjEstPP17AqUrtbWR4MCUQ8yRBeo1dxnm5Qpz8eT
         OWip+Vpf9SHTjp4+Ye1jvCRkl4WnOmYvD/PvG5sPA6xWYUNltp7eJipEZH1CLnz6phgY
         A/Qw==
X-Gm-Message-State: APjAAAVUgJZZJbNJwYjgOOejD3JHJDuAOFTmFDCoebTFYW5rgn2DSrwB
        2X7HUAegJm0hwno1YuAhH8OZNclDUe6MgGYbtPBRflC8fJ0h
X-Google-Smtp-Source: APXvYqwtNHvsouv3Ix3nM4wBkrtyFA3/tPsxw9Nhrd9lTSoNdWSy0FQVn0x4hxKROq5CgFY+BMIlNHAp4r7LuCJXb0+jMiaqNgNk
MIME-Version: 1.0
X-Received: by 2002:a02:b88b:: with SMTP id p11mr2437470jam.144.1565776085760;
 Wed, 14 Aug 2019 02:48:05 -0700 (PDT)
Date:   Wed, 14 Aug 2019 02:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063c050059010a7d4@google.com>
Subject: INFO: task hung in fuse_lookup (3)
From:   syzbot <syzbot+b64df836ad08c8e31a47@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ee1c7bd3 Merge tag 'tpmdd-next-20190813' of git://git.infr..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153f3422600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ff364e429585cf2
dashboard link: https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176c385a600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12482e86600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b64df836ad08c8e31a47@syzkaller.appspotmail.com

INFO: task init:1 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc4+ #101
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init            D23792     1      0 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:3254 [inline]
  __schedule+0x755/0x1580 kernel/sched/core.c:3880
  schedule+0xa8/0x270 kernel/sched/core.c:3944
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4003
  __mutex_lock_common kernel/locking/mutex.c:1007 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1077
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1092
  fuse_lock_inode+0xba/0xf0 fs/fuse/inode.c:362
  fuse_lookup+0x8e/0x360 fs/fuse/dir.c:335
  __lookup_slow+0x279/0x500 fs/namei.c:1669
  lookup_slow+0x58/0x80 fs/namei.c:1686
  walk_component+0x747/0x2000 fs/namei.c:1808
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2139
  link_path_walk fs/namei.c:2267 [inline]
  path_lookupat.isra.0+0xe3/0x8d0 fs/namei.c:2315
  filename_lookup+0x1b0/0x410 fs/namei.c:2346
  user_path_at_empty+0x43/0x50 fs/namei.c:2606
  user_path_at include/linux/namei.h:60 [inline]
  vfs_statx+0x129/0x200 fs/stat.c:187
  vfs_stat include/linux/fs.h:3188 [inline]
  __do_sys_newstat+0xa4/0x130 fs/stat.c:341
  __se_sys_newstat fs/stat.c:337 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:337
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7eff41718c65
Code: 00 00 00 e8 5d 01 00 00 48 83 c4 18 c3 90 90 90 90 90 90 90 90 83 ff  
01 48 89 f0 77 18 48 89 c7 48 89 d6 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 17 f3 c3 90 48 8b 05 a1 51 2b 00 64 c7 00 16
RSP: 002b:00007fff34a35eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00007fff34a360f0 RCX: 00007eff41718c65
RDX: 00007fff34a360f0 RSI: 00007fff34a360f0 RDI: 0000000000407545
RBP: 0000000000000000 R08: 000000000159cb60 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00007fff34a365f0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor205:11118 blocked for more than 143 seconds.
       Not tainted 5.3.0-rc4+ #101
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor205 D27656 11118  11116 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:3254 [inline]
  __schedule+0x755/0x1580 kernel/sched/core.c:3880
  schedule+0xa8/0x270 kernel/sched/core.c:3944
  d_wait_lookup fs/dcache.c:2506 [inline]
  d_alloc_parallel+0x12cd/0x1c30 fs/dcache.c:2588
  __lookup_slow+0x1ab/0x500 fs/namei.c:1652
  lookup_slow+0x58/0x80 fs/namei.c:1686
  walk_component+0x747/0x2000 fs/namei.c:1808
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2139
  link_path_walk fs/namei.c:2070 [inline]
  path_openat+0x202/0x4630 fs/namei.c:3532
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1102
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444ca0
Code: Bad RIP value.
RSP: 002b:00007ffec1436ed0 EFLAGS: 00000202 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444ca0
RDX: 0000000000000000 RSI: 0000000000090800 RDI: 00000000004ae91e
RBP: 0000000000002b72 R08: 0000000000002b6e R09: 0000555556c39880
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffec1437100
R13: 00000000004075d0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor205:11122 blocked for more than 144 seconds.
       Not tainted 5.3.0-rc4+ #101
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor205 D28336 11122  11118 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:3254 [inline]
  __schedule+0x755/0x1580 kernel/sched/core.c:3880
  schedule+0xa8/0x270 kernel/sched/core.c:3944
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4003
  __mutex_lock_common kernel/locking/mutex.c:1007 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1077
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1092
  fuse_lock_inode+0xba/0xf0 fs/fuse/inode.c:362
  fuse_lookup+0x8e/0x360 fs/fuse/dir.c:335
  __lookup_slow+0x279/0x500 fs/namei.c:1669
  lookup_slow+0x58/0x80 fs/namei.c:1686
  walk_component+0x747/0x2000 fs/namei.c:1808
  link_path_walk.part.0+0x9a4/0x1340 fs/namei.c:2139
  link_path_walk fs/namei.c:2070 [inline]
  path_openat+0x202/0x4630 fs/namei.c:3532
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1102
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405810
Code: 00 48 85 c0 75 e8 8b 15 2e 33 20 00 83 e2 fb 89 15 25 33 20 00 f7 c2  
00 00 00 10 74 4b 48 8b 05 c6 30 20 00 48 85 c0 75 15 eb <31> 0f 1f 80 00  
00 00 00 48 8b 80 c0 00 00 00 48 85 c0 74 18 83 78
RSP: 002b:00007ffec1436bd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffec1436c04 RCX: 0000000000405810
RDX: 00007ffec1436c0a RSI: 0000000000080001 RDI: 00000000004ae93c
RBP: 00007ffec1436c00 R08: 0000000000000000 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000407540
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 1057 Comm: khungtaskd Not tainted 5.3.0-rc4+ #101
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0x9d0/0xef0 kernel/hung_task.c:289
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
