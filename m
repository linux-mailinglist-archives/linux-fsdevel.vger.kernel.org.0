Return-Path: <linux-fsdevel+bounces-2602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E67E7000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4129FB20C67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D4225CA;
	Thu,  9 Nov 2023 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4482232D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:16:29 +0000 (UTC)
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07230D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 09:16:29 -0800 (PST)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-5b806e55dd2so1130708a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 09:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550188; x=1700154988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ik92Kb8UgHu1nXrWB5uLRqqbBTtMjzV+DKu4EtXnCA=;
        b=Wa6Ses6J8PGxdwGGshkkQQm7RSQNiWlEK8WkOkf7b7MQuzdkr8Lz68uoXcPP37lx/q
         Dc3eb1EDep57UfRXyCKBDjOEE71LEn1SX3aXKpin0/f3bNNMQSWicvnyn94Pc/xigIih
         VJ3WoxJeE4MCiMZg8cnpz9v5juNg1Q7fLhbNdNrkfprPuxFUEAn3M/26bsnqXF2xYMNR
         3N0X/myTv84Jz4OPhm+PQbA7VTWY0d2o38Ia0iRn1KJIurntxW+F/6GSFP8fw8lSRMJB
         rKds/65/Clgq2LCQdxd0QRjJdDOEYpcX/OjDTGAIxPuOlWrYd/8K11L0YTkTXEva0HYJ
         JW8w==
X-Gm-Message-State: AOJu0Yw5tNd7gzJNWcH1f5Vez89VQmLgE2Cx9e1kN/MmxkQzjXC3HpxG
	tTHngFlnjaC2qJ2dsB2pDe2JmqgGzqTWnEnnipm3SM6ZbMFxk3Lwbw==
X-Google-Smtp-Source: AGHT+IF0TbJvKilgxVAad9fEdPkvKA7Dq7Gw6FY3fKi2d3XYn/e7BqKBg0qu10ZUudgFCGOs9nvR0e2P0sVRNHkWQl4Av7IZ2uo9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d70a:b0:280:941b:9471 with SMTP id
 y10-20020a17090ad70a00b00280941b9471mr550463pju.7.1699550186216; Thu, 09 Nov
 2023 09:16:26 -0800 (PST)
Date: Thu, 09 Nov 2023 09:16:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020a5790609bb5db8@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in direntry_check_right
From: syzbot <syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106da588e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=e57bfc56c27a9285a838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0588e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce91ef680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aab25a831ba/disk-30523014.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d1b7b8fdf8a/vmlinux-30523014.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9b6822fcd5f/bzImage-30523014.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d31901503cbc/mount_0.gz

The issue was bisected to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ffa1f680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dffa1f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dffa1f680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

REISERFS (device loop0): using 3.5.x disk format
REISERFS warning (device loop0): vs-13060 reiserfs_update_sd_size: stat data of object [1 2 0x0 SD] (nlink == 4) not found (pos 2)
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
kernel BUG at fs/reiserfs/item_ops.c:569!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5062 Comm: syz-executor395 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:direntry_check_right+0x26b/0x280 fs/reiserfs/item_ops.c:569
Code: df e9 38 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 3e ff ff ff be 04 00 00 00 48 89 df e8 7f 36 af ff e9 2c ff ff ff e8 d5 13 53 ff <0f> 0b e8 ce 13 53 ff 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
RSP: 0018:ffffc90003afeed0 EFLAGS: 00010293
RAX: ffffffff823ba82b RBX: 0000000000000020 RCX: ffff888079929dc0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000041
RBP: 0000000000000021 R08: ffffffff823ba69e R09: ffffffff8235650d
R10: 0000000000000004 R11: ffff888079929dc0 R12: 00000000fffffffe
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880549c4120
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e01595ed8 CR3: 0000000028720000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_right+0x4d1/0x770 fs/reiserfs/fix_node.c:355
 dc_check_balance_leaf fs/reiserfs/fix_node.c:1983 [inline]
 dc_check_balance fs/reiserfs/fix_node.c:2039 [inline]
 check_balance fs/reiserfs/fix_node.c:2086 [inline]
 fix_nodes+0x3ff3/0x8ce0 fs/reiserfs/fix_node.c:2636
 reiserfs_cut_from_item+0x466/0x2580 fs/reiserfs/stree.c:1740
 reiserfs_do_truncate+0x9b9/0x14c0 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x4da/0x820 fs/reiserfs/inode.c:2302
 reiserfs_file_release+0x8ca/0xaa0 fs/reiserfs/file.c:109
 __fput+0x3cc/0xa10 fs/file_table.c:394
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa34/0x2750 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe19c8650b9
Code: Unable to access opcode bytes at 0x7fe19c86508f.
RSP: 002b:00007ffdbbdc7968 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe19c8650b9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe19c8e0370 R08: ffffffffffffffb8 R09: 00007ffdbbdc7b88
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe19c8e0370
R13: 0000000000000000 R14: 00007fe19c8e10e0 R15: 00007fe19c833980
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:direntry_check_right+0x26b/0x280 fs/reiserfs/item_ops.c:569
Code: df e9 38 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 3e ff ff ff be 04 00 00 00 48 89 df e8 7f 36 af ff e9 2c ff ff ff e8 d5 13 53 ff <0f> 0b e8 ce 13 53 ff 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
RSP: 0018:ffffc90003afeed0 EFLAGS: 00010293
RAX: ffffffff823ba82b RBX: 0000000000000020 RCX: ffff888079929dc0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000041
RBP: 0000000000000021 R08: ffffffff823ba69e R09: ffffffff8235650d
R10: 0000000000000004 R11: ffff888079929dc0 R12: 00000000fffffffe
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880549c4120
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e01595ed8 CR3: 0000000028720000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

