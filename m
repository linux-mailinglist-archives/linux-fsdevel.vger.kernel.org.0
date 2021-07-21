Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352BD3D0DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGUKwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 06:52:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48734 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhGUJ6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:58:48 -0400
Received: by mail-io1-f72.google.com with SMTP id d17-20020a0566022291b029053e3f025a44so1322821iod.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 03:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SKzlYPydm1YCdzkKO68+vjdJk8hg8iRzzdfqvEt6N58=;
        b=lHou/n8KOi0yiKV9fCQKUBpOhiCaUxYVfcjLsQFjuHv88YufuNOSg57X8S6HOAzgMp
         6R8qh0B+nldE4u0zPm2bZznpgyu38XgtTFT+KLbN2QEnvkr33/JYTD4p4ZnZAnCHFNSu
         s8W5c/tm16MAo2A4bzUGqa7DV4XHUCvRvsOV1ZcGpU3RReWix8iv3ml4f9bMBqBEL7e8
         AjuKd0qShPln+5BBmKoLrtpP15nfYyKJcu7BH3hCtR4Rh5O+B+ffg6XzZR94PuDKRS9b
         nhnW6kewJX60tFL3r56GGhS4nRW/YJhuJ8XFABdPGQ8yp0yfVtNjddSqnL2VRB9tr6rq
         kunQ==
X-Gm-Message-State: AOAM532Jtm+NJUw30BuEJ0L8T5xpiitxYb95B19JQXOtz9WCCBEWduk2
        JT4Suq3rsZsPwdg/ykFGLCaOPRT9s6ugl0rzmOkj3awPvtOz
X-Google-Smtp-Source: ABdhPJyVeK4eXr/QyL1Oi4Opkg/P55foc2DUfgHeK/eKP2Pl7Ift7ZWG4eBfjluaH5Fhx0Vn5CnhXOMQZ8XD436Ffjwlnr2YrSQy
MIME-Version: 1.0
X-Received: by 2002:a02:c496:: with SMTP id t22mr30890193jam.80.1626863960958;
 Wed, 21 Jul 2021 03:39:20 -0700 (PDT)
Date:   Wed, 21 Jul 2021 03:39:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007db08f05c79fc81f@google.com>
Subject: [syzbot] INFO: task hung in sys_io_destroy
From:   syzbot <syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b40232300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
dashboard link: https://syzkaller.appspot.com/bug?extid=d40a01556c761b2cb385
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12453812300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11225922300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127cac6a300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117cac6a300000
console output: https://syzkaller.appspot.com/x/log.txt?x=167cac6a300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d40a01556c761b2cb385@syzkaller.appspotmail.com

INFO: task syz-executor299:8807 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29400 pid: 8807 ppid:  8806 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:8843 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29184 pid: 8843 ppid:  8842 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 0000000000000000 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9076 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29216 pid: 9076 ppid:  9075 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 0000000000000000 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9188 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29400 pid: 9188 ppid:  9187 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9440 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29184 pid: 9440 ppid:  9439 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 0000000000000000 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9476 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29752 pid: 9476 ppid:  9475 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9484 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29800 pid: 9484 ppid:  9483 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9536 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29800 pid: 9536 ppid:  9535 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9768 blocked for more than 144 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:29696 pid: 9768 ppid:  9767 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 00000000000f4240 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000
INFO: task syz-executor299:9772 blocked for more than 145 seconds.
      Not tainted 5.14.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor299 state:D stack:28832 pid: 9772 ppid:  9771 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1854
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x176/0x280 kernel/sched/completion.c:138
 __do_sys_io_destroy fs/aio.c:1402 [inline]
 __se_sys_io_destroy fs/aio.c:1380 [inline]
 __x64_sys_io_destroy+0x17e/0x1e0 fs/aio.c:1380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445899
RSP: 002b:00007f9b5a7e2318 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 00000000004ca428 RCX: 0000000000445899
RDX: 0000000000445899 RSI: 0000000000000000 RDI: 00007f9b5a7c1000
RBP: 00000000004ca420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 00007ffdd09518ef R14: 00007f9b5a7e2400 R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1656:
 #0: ffffffff8b97b9c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8155:
 #0: ffff888033cdb270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1656 Comm: khungtaskd Not tainted 5.14.0-rc1-syzkaller #0
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
NMI backtrace for cpu 0
CPU: 0 PID: 4866 Comm: systemd-journal Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:clear_page_erms+0x7/0x10 arch/x86/lib/clear_page_64.S:49
Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc cc cc 41 57 41 56 41 55 41 54 55 53 48 89 fb
RSP: 0018:ffffc900015ff850 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0000a365c0 RCX: 00000000000004c0
RDX: 1ffff11005878d15 RSI: 0000000000000008 RDI: ffff888028d97b40
RBP: ffff88802c3c54c0 R08: 0000000000000001 R09: ffffed10051b2000
R10: fffff94000146c86 R11: 0000000000000003 R12: ffffed1005878d69
R13: dffffc0000000000 R14: ffffea0000a36600 R15: ffff88802c3c6b48
FS:  00007fc8b802f8c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8b5421000 CR3: 0000000021001000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 clear_page arch/x86/include/asm/page_64.h:49 [inline]
 clear_highpage include/linux/highmem.h:184 [inline]
 kernel_init_free_pages.part.0+0x99/0x120 mm/page_alloc.c:1283
 kernel_init_free_pages mm/page_alloc.c:1272 [inline]
 post_alloc_hook+0x145/0x1e0 mm/page_alloc.c:2423
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4166
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5388
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 alloc_slab_page mm/slub.c:1688 [inline]
 allocate_slab+0x32e/0x4b0 mm/slub.c:1828
 new_slab mm/slub.c:1891 [inline]
 new_slab_objects mm/slub.c:2637 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2800
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2840
 slab_alloc_node mm/slub.c:2922 [inline]
 slab_alloc mm/slub.c:2964 [inline]
 kmem_cache_alloc+0x3e1/0x4a0 mm/slub.c:2969
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x8e/0xd0 fs/namei.c:209
 do_sys_openat2+0xf5/0x420 fs/open.c:1198
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_open fs/open.c:1228 [inline]
 __se_sys_open fs/open.c:1224 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1224
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc8b75be840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffee57eb7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffee57ebae0 RCX: 00007fc8b75be840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 0000564a6c2e8060
RBP: 000000000000000d R08: 000000000000c0c1 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000564a6c2da040 R14: 00007ffee57ebaa0 R15: 0000564a6c2e80b0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
