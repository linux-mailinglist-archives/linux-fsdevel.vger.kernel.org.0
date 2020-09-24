Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0482276D68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIXJ17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 05:27:59 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:55803 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIXJ01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:26:27 -0400
Received: by mail-io1-f77.google.com with SMTP id t187so1904979iof.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 02:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wQ51f9WTAZ5e5qtWDKE3zolADPaVRzEKSYmLIUlQCxM=;
        b=EQ02BJ2DwWHJlvjktjJbG3Boscqt4xpCrHCzI+nRxUQSQ8oTQtwntFTKCgHh4e3fed
         jcIZkzOzTs+FgCWqQ6nWbKUKE4xzhxNUnwzEnTwdI/fRFEjjzaEbtiqoBeAjNufGbDZ3
         pnOsu5nfRY88bX7eI0Pxd5fQPag0iQgxX91e8hEnvW9ar00hMLp+0KtwxlHNXz3rBPMY
         hRrEskcMwwgws4b3Ukt0KpgzrdoVWsT+IAIcs0/+c2+8PuV+1vd1r2nK6/ju55IgvAmj
         2U7PXWNwT09KZ+WqlBGprP81zWT6uUqfL95MSia0QwGy+NWkQbPGbXh/ayrr+pma2A95
         U9YA==
X-Gm-Message-State: AOAM533Wf+gNtme4E9qVrb6bH2AA1f3ROlxGpaK5cBMLqpjFX8ngs8SR
        kB9/IA0XKxGlWQgInAVfnqJ4178hdZ1V7aW8WXyNH88ZwHF7
X-Google-Smtp-Source: ABdhPJwmsNm47rwzH7GpbfqeU15rs/Sv4XFx3pugpzM0RTOhBVAIlBylP3aBEGqVLJQk2YQasb0ysawOr7kN2bwA0xCSTMmW+kzX
MIME-Version: 1.0
X-Received: by 2002:a6b:d603:: with SMTP id w3mr2601767ioa.29.1600939586515;
 Thu, 24 Sep 2020 02:26:26 -0700 (PDT)
Date:   Thu, 24 Sep 2020 02:26:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c793005b00bcb89@google.com>
Subject: general protection fault in cdev_del (2)
From:   syzbot <syzbot+c49fe6089f295a05e6f8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    98477740 Merge branch 'rcu/urgent' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12641dab900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=c49fe6089f295a05e6f8
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eadc8d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1517d075900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c49fe6089f295a05e6f8@syzkaller.appspotmail.com

RBP: 00007ffee0265520 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 PID: 7451 Comm: syz-executor249 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:596
Code: b5 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 d3 41 b3 ff 48 8d 7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
RSP: 0018:ffffc90007f07b10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff8880a16f3500 RCX: ffffffff841165ff
RDX: 000000000000000c RSI: ffffffff81c2fc6d RDI: 0000000000000064
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8d0b7a67
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a16f3508
R13: ffff8880a17cd008 R14: ffff8880a6236420 R15: ffff8880a6236278
FS:  0000000000000000(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0288f8a710 CR3: 0000000094f1e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tty_unregister_device drivers/tty/tty_io.c:3193 [inline]
 tty_unregister_device+0x112/0x1b0 drivers/tty/tty_io.c:3188
 gsmld_detach_gsm drivers/tty/n_gsm.c:2411 [inline]
 gsmld_close+0xaa/0x260 drivers/tty/n_gsm.c:2480
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:489
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:637
 tty_ldisc_hangup+0x30b/0x680 drivers/tty/tty_ldisc.c:756
 __tty_hangup.part.0+0x403/0x870 drivers/tty/tty_io.c:625
 __tty_hangup drivers/tty/tty_io.c:575 [inline]
 tty_vhangup+0x1d/0x30 drivers/tty/tty_io.c:698
 pty_close+0x3f5/0x550 drivers/tty/pty.c:79
 tty_release+0x455/0xf60 drivers/tty/tty_io.c:1679
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440018
Code: Bad RIP value.
RSP: 002b:00007ffee02654c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440018
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bfd90 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 98d732d1ef99b6c5 ]---
RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:596
Code: b5 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 d3 41 b3 ff 48 8d 7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
RSP: 0018:ffffc90007f07b10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff8880a16f3500 RCX: ffffffff841165ff
RDX: 000000000000000c RSI: ffffffff81c2fc6d RDI: 0000000000000064
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8d0b7a67
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a16f3508
R13: ffff8880a17cd008 R14: ffff8880a6236420 R15: ffff8880a6236278
FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd722a6000 CR3: 0000000094644000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
