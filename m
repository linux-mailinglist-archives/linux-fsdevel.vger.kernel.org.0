Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C1740AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjF1IJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:19 -0400
Received: from mail-qk1-f206.google.com ([209.85.222.206]:56508 "EHLO
        mail-qk1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjF1IEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:04:52 -0400
Received: by mail-qk1-f206.google.com with SMTP id af79cd13be357-766b225954aso297616385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939492; x=1690531492;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mE2dRHeC7sKEs35oOzi4J/TBQK9oz2ZLXDJxpRfnoM=;
        b=gd7o+BapbpIe+Rs7ac5z+Igr7TiuopMgweI6K0AfYT8UzQiafuozj00q6CConDmgxo
         XUwPqJsAFk8Qpcb5X8BexqQCYg9Gr9K3Hhhy3NXgP2SOra0/z2BcQddgFLurxkPP7gwl
         s1dUWbpx+X5MUBRwKnUYFw5S6LwxdafFN81JodLy/r42L3cHACX9bIDGjbEe1f2+7q6o
         Qm6S1hZkM47nZsSzP90dD+dreo+zSMRZYc4an8yvxERQOWVsI6KvqHnnfxIKf70Fi5W6
         axPFBcRSRdOOEAFhiX43sWuYPcG7LaI/2l2OOS4LvvHA/7ULo9VfLPY3GsGqYAGTX6XQ
         MmQQ==
X-Gm-Message-State: AC+VfDwEZwuiqcwZdiBwWOrsDUOE4XU+Oy7qXIK8iDY6RRErpZGKQs3S
        LchvXEnX1agEdknFyaagz//GwaDUxOcwZH6uCKPo52CUPdBlwenRwQ==
X-Google-Smtp-Source: ACHHUZ66QAk9hpbM8ZJwFPep4WtJ7K8AxcUoCJNcYRVBAf0aszBAaVK2g/ibqFpZt6is3gQrVOo8ILU0yCAYL9qne0GpJZriAHdK
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2184:b0:3a1:f5bf:67db with SMTP id
 be4-20020a056808218400b003a1f5bf67dbmr1868987oib.1.1687936064695; Wed, 28 Jun
 2023 00:07:44 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:07:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a36d105ff2b3d83@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in flush_commit_list
From:   syzbot <syzbot+702d8ffe347fa9623624@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    61dabacdad4e Merge tag 'sound-6.4' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d009af280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=702d8ffe347fa9623624
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eba067fe8c35/disk-61dabacd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6800499a8694/vmlinux-61dabacd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b4f8a7eda0e/bzImage-61dabacd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+702d8ffe347fa9623624@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:1108!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5035 Comm: syz-executor.0 Not tainted 6.4.0-rc7-syzkaller-00204-g61dabacdad4e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:flush_commit_list+0x1bc3/0x1bf0 fs/reiserfs/journal.c:1108
Code: ff ff e8 60 49 59 ff 0f 0b e8 59 49 59 ff 0f 0b e8 52 49 59 ff 0f 0b e8 4b 49 59 ff 0f 0b e8 44 49 59 ff 0f 0b e8 3d 49 59 ff <0f> 0b e8 36 49 59 ff 0f 0b 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000409f748 EFLAGS: 00010293
RAX: ffffffff82323bb3 RBX: ffff88807b35a0d0 RCX: ffff888028279dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff82323044 R09: ffffed1011ebcce9
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807b35a01c
R13: dffffc0000000000 R14: ffff88803c25c000 R15: 1ffff1100f66b41a
FS:  0000555555b4f400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f40f3952000 CR3: 0000000035d67000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_journal_end+0x3160/0x4770 fs/reiserfs/journal.c:4300
 do_journal_release+0x178/0x4d0 fs/reiserfs/journal.c:1917
 journal_release+0x1f/0x30 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0x23b/0x4c0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5255e8d7f7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc16d9fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5255e8d7f7
RDX: 00007fffc16da07b RSI: 000000000000000a RDI: 00007fffc16da070
RBP: 00007fffc16da070 R08: 00000000ffffffff R09: 00007fffc16d9e40
R10: 0000555555b50893 R11: 0000000000000246 R12: 00007f5255ed643b
R13: 00007fffc16db130 R14: 0000555555b50810 R15: 00007fffc16db170
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_commit_list+0x1bc3/0x1bf0 fs/reiserfs/journal.c:1108
Code: ff ff e8 60 49 59 ff 0f 0b e8 59 49 59 ff 0f 0b e8 52 49 59 ff 0f 0b e8 4b 49 59 ff 0f 0b e8 44 49 59 ff 0f 0b e8 3d 49 59 ff <0f> 0b e8 36 49 59 ff 0f 0b 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000409f748 EFLAGS: 00010293
RAX: ffffffff82323bb3 RBX: ffff88807b35a0d0 RCX: ffff888028279dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff82323044 R09: ffffed1011ebcce9
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807b35a01c
R13: dffffc0000000000 R14: ffff88803c25c000 R15: 1ffff1100f66b41a
FS:  0000555555b4f400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f40f3899000 CR3: 0000000035d67000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
