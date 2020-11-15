Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF72B38B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgKOTaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 14:30:22 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:56425 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgKOTaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:30:20 -0500
Received: by mail-il1-f199.google.com with SMTP id g2so10390769ilb.23
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 11:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=reAnx4O5xXKHBeW4ynKl5kqLTK0jD87c4+XTK2E/3PY=;
        b=ML7abgCIRZimuI6W5pjP8p5dA+3R/c+IeXgyIokGAqJ2j7px/GwkjYIRAHXh7o2lf+
         AOSkGKx1yIiW9JJXTzY9ysEwxiuKZ4BSJFoqnp0UDWdIcUzO2OmSyoVIZtno0wPwqbfc
         NjVh6zjCbUsEfl2SK0lRO9HuIsslnXNFswgQNY99/4yFGnQ6kWOQapBipgPwX6lajDFu
         khFcas5fkwHFccSMtgmSHNhmL1u7izWCFPZD41oI42jwmMkLYAS70kOvzyMQSJfL0UN3
         uRJc/KeiyhqX54OEU4Po6XMRv9tGHh3U2QxXIlTs9Kkt+Gym4nJF0X2l+MPhGl6TsuEU
         6bTQ==
X-Gm-Message-State: AOAM531YakeIuZ8nGgbCTk0eZeMBN/DfSCQ3vAoIhMsRWIQG98XRZgw1
        fFIG0U3VRJrrzpeUFHHJN17WZZr/fAQMsRiBGn8oxo9lENjy
X-Google-Smtp-Source: ABdhPJzqD4vyX/EdogezQiQ5Xvd4V9S+DHxX9WUcRpflKMxt0ReqC5doZIALYMLab0OUqwzcl+hNaR0GnaVogNEHgIQOmMixWcHV
MIME-Version: 1.0
X-Received: by 2002:a02:a15b:: with SMTP id m27mr8620665jah.116.1605468619654;
 Sun, 15 Nov 2020 11:30:19 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:30:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5d1f605b42a4a6e@google.com>
Subject: WARNING: suspicious RCU usage in unmap_page_range
From:   syzbot <syzbot+4ca458af025542e76123@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eccc8767 Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115b9a26500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ae89f992df998f
dashboard link: https://syzkaller.appspot.com/bug?extid=4ca458af025542e76123
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ca458af025542e76123@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.10.0-rc3-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:7264 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
2 locks held by udevd/9816:
 #0: ffff8880124f5b40 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: prepare_bprm_creds fs/exec.c:1449 [inline]
 #0: ffff8880124f5b40 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x1c6/0x1b70 fs/exec.c:1791
 #1: ffff8880124f5bd0 (&sig->exec_update_mutex){+.+.}-{3:3}, at: exec_mmap fs/exec.c:984 [inline]
 #1: ffff8880124f5bd0 (&sig->exec_update_mutex){+.+.}-{3:3}, at: begin_new_exec+0xa89/0x2ac0 fs/exec.c:1276

stack backtrace:
CPU: 1 PID: 9816 Comm: udevd Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ___might_sleep+0x25d/0x2b0 kernel/sched/core.c:7264
 zap_pte_range mm/memory.c:1323 [inline]
 zap_pmd_range mm/memory.c:1357 [inline]
 zap_pud_range mm/memory.c:1386 [inline]
 zap_p4d_range mm/memory.c:1407 [inline]
 unmap_page_range+0xfd2/0x2640 mm/memory.c:1428
 unmap_single_vma+0x198/0x300 mm/memory.c:1473
 unmap_vmas+0x168/0x2e0 mm/memory.c:1505
 exit_mmap+0x2b1/0x530 mm/mmap.c:3222
 __mmput+0x122/0x470 kernel/fork.c:1079
 mmput+0x53/0x60 kernel/fork.c:1100
 exec_mmap fs/exec.c:1030 [inline]
 begin_new_exec+0xdc3/0x2ac0 fs/exec.c:1276
 load_elf_binary+0x159d/0x4a60 fs/binfmt_elf.c:998
 search_binary_handler fs/exec.c:1703 [inline]
 exec_binprm fs/exec.c:1744 [inline]
 bprm_execve+0x9d7/0x1b70 fs/exec.c:1820
 do_execveat_common+0x626/0x7c0 fs/exec.c:1915
 do_execve fs/exec.c:1983 [inline]
 __do_sys_execve fs/exec.c:2059 [inline]
 __se_sys_execve fs/exec.c:2054 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2054
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f13375e8207
Code: Unable to access opcode bytes at RIP 0x7f13375e81dd.
RSP: 002b:00007ffc9f06eb68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f13375e8207
RDX: 0000000001df1ee0 RSI: 00007ffc9f06ec60 RDI: 00007ffc9f06fc70
RBP: 0000000000625500 R08: 00000000000025c3 R09: 00000000000025c3
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001df1ee0
R13: 0000000000000007 R14: 0000000001c60030 R15: 0000000000000005


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
