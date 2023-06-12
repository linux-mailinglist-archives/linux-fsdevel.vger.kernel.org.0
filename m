Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B787172CE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjFLSjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFLSjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:39:22 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44994E6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:39:20 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-33d63df7cd7so55019135ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595159; x=1689187159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eON7cc11u21omHxGw6Vg5HORe0VkQcRAxXCDWieUCs4=;
        b=UpHjypKbV81+MrW7F3NEiEtg/5Q5rQINoQDJcJAu4S+6Wz4YScqRWlJxJk+wd0Rh8w
         0wpM1v03bbkoqSJtdghA+losi8qci1k3wXSZ0Dpnbzu2/rYrL1pI8aiE5LzD3gNnE4S0
         aMoWKd3tVqh0Er4GsU0Y61fyYf83xThYTf0WNTsncoo046Bg/gqim31g/qv2ZwyE/n3S
         ln3XMEua7sbrCodZuk0ucom50bfItCsHxQ+5auq2hsEyLu4eG4Gp0VERLl7TvEdzSjVz
         7LSts6KNkmxZhqXEehdEkTsz0072NohLs1wPyfPYwAfOwIrrCVkZLJ1LGyFJZT0XW8ub
         NgbQ==
X-Gm-Message-State: AC+VfDzab+qO5GG+kGkwIn4h5fgCP4G7mq1tUWHXF84MAJ3t1gqiK1L9
        ErjPUmMIVwgT5IOxbPii0Men4ah/JaWXYcrmXg2RvQvi4K5fVVkxkw==
X-Google-Smtp-Source: ACHHUZ7MqGYu/KAO2iw42HoWO85NlY5h+v56KszQcoRuI+0tMdJ6dpgyVd+hwNEY/zP8lm/3K5eUa4Q7vWN6jNNtf1n8P+5mn+/U
MIME-Version: 1.0
X-Received: by 2002:a02:330c:0:b0:41a:902f:70d0 with SMTP id
 c12-20020a02330c000000b0041a902f70d0mr4580796jae.6.1686595159654; Mon, 12 Jun
 2023 11:39:19 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f0b2f05fdf309b3@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in flush_journal_list
From:   syzbot <syzbot+7cc52cbcdeb02a4b0828@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    64569520920a Merge tag 'block-6.4-2023-06-09' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a5713b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=7cc52cbcdeb02a4b0828
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cc4ab280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d27f95280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3239cb3f0553/disk-64569520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d90e42dca619/vmlinux-64569520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0f88764a9f6/bzImage-64569520.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c9148e64e137/mount_0.gz

The issue was bisected to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f94263280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10054263280000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f94263280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cc52cbcdeb02a4b0828@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:1452!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4991 Comm: syz-executor756 Not tainted 6.4.0-rc5-syzkaller-00245-g64569520920a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:flush_journal_list+0x1c33/0x1c70 fs/reiserfs/journal.c:1452
Code: dc 38 85 8c 48 c7 c1 c0 07 fc 8a e8 07 58 fb ff e8 d2 13 59 ff 0f 0b e8 cb 13 59 ff 0f 0b e8 c4 13 59 ff 0f 0b e8 bd 13 59 ff <0f> 0b e8 b6 13 59 ff 0f 0b e8 af 13 59 ff 0f 0b e8 a8 13 59 ff 0f
RSP: 0018:ffffc900039ff5f0 EFLAGS: 00010293
RAX: ffffffff82326be3 RBX: 0000000000000001 RCX: ffff888021d43b80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82325675 R09: ffffed100e89fd06
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880744fe828
R13: ffffc90003a930d8 R14: 1ffff1100e89fd05 R15: 1ffff9200075261d
FS:  0000555555bbb300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555bc4628 CR3: 0000000019345000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_older_journal_lists fs/reiserfs/journal.c:1318 [inline]
 flush_journal_list+0xea7/0x1c70 fs/reiserfs/journal.c:1575
 do_journal_end+0x3170/0x4770 fs/reiserfs/journal.c:4301
 do_journal_release+0x47c/0x4d0 fs/reiserfs/journal.c:1940
 journal_release+0x1f/0x30 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0x23b/0x4c0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2371
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d17bbaf57
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff15fe9e38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7d17bbaf57
RDX: 00007fff15fe9ef9 RSI: 000000000000000a RDI: 00007fff15fe9ef0
RBP: 00007fff15fe9ef0 R08: 00000000ffffffff R09: 00007fff15fe9cd0
R10: 0000555555bbc653 R11: 0000000000000202 R12: 00007fff15feaf60
R13: 0000555555bbc5f0 R14: 00007fff15fe9e60 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_journal_list+0x1c33/0x1c70 fs/reiserfs/journal.c:1452
Code: dc 38 85 8c 48 c7 c1 c0 07 fc 8a e8 07 58 fb ff e8 d2 13 59 ff 0f 0b e8 cb 13 59 ff 0f 0b e8 c4 13 59 ff 0f 0b e8 bd 13 59 ff <0f> 0b e8 b6 13 59 ff 0f 0b e8 af 13 59 ff 0f 0b e8 a8 13 59 ff 0f
RSP: 0018:ffffc900039ff5f0 EFLAGS: 00010293
RAX: ffffffff82326be3 RBX: 0000000000000001 RCX: ffff888021d43b80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82325675 R09: ffffed100e89fd06
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880744fe828
R13: ffffc90003a930d8 R14: 1ffff1100e89fd05 R15: 1ffff9200075261d
FS:  0000555555bbb300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045bd60 CR3: 0000000019345000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
