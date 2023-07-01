Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC718744B14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGAUqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 16:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAUqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 16:46:06 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05891710
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jul 2023 13:46:04 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1b7ffab949fso39541425ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jul 2023 13:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688244364; x=1690836364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lko05gm0yFKNW9JXkfXptRbd6tL+MYTjGoefCIzDYMQ=;
        b=KMnLlWb4abRzGjJnWeZYEr0Wyg3uKnqp88wOlAfuxmow5adyFXEDkDZjR6TIqm3F36
         jdMhDze5KV7AJJe7IMzFZvXK8TAstFNZwhUwU/8rLYkgE8Ui6ZT73mhP3u7DgLdtdoLt
         am1O0gWqGmB/jjdzVfUW+2E4RUhr2H9nbl/8nkh4H0qXT4sL3AEu75RCxp3VdSowYTwd
         8/3FtP6BUOE36dBTZgYLtZomPqIPd5lCoitr8KjlFAWeWeMDSv0qGXXmxxPBRk7OG/a1
         P7uHFLk8mEVD+ehtgWfZ5eMZt00XfUYXUk99tKUwbR1FVBk5ZaQAQZuHM1RT61xES2S0
         RTwA==
X-Gm-Message-State: ABy/qLZJsw8y3zeXyeH8viVIm/wiB8T2HDBAaYOwFV6fmc8aG4r1owvD
        bcSuulwKWAIau5juP17I3rJkfuB4T1p1mRygYInTZWpThaHG
X-Google-Smtp-Source: APBJJlH7zxzA59X8j9PRykLb2xb2VqDMe0KmjnFu4zDG9iBqM+kmzZPirJLVpLOfNx/7AwccigYd0ttfR6EHkRm/gd25C3emBs/v
MIME-Version: 1.0
X-Received: by 2002:a17:902:ea0a:b0:1ad:fa23:dd87 with SMTP id
 s10-20020a170902ea0a00b001adfa23dd87mr5011889plg.5.1688244364496; Sat, 01 Jul
 2023 13:46:04 -0700 (PDT)
Date:   Sat, 01 Jul 2023 13:46:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3d67705ff730522@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    533925cb7604 Merge tag 'riscv-for-linus-6.5-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d8b610a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12464973c17d2b37
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b23da6a6f6c/disk-533925cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f163e9ea9946/vmlinux-533925cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b943aa5a1e1/bzImage-533925cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com

assertion failed: root->reloc_root == reloc_root, in fs/btrfs/relocation.c:1919
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:1919!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9904 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-08881-g533925cb7604 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
Code: fe e9 f5 f7 ff ff e8 6d 62 ec fd 48 c7 c7 20 5e 4b 8b 48 c7 c6 c0 6d 4b 8b 48 c7 c2 a0 5e 4b 8b b9 7f 07 00 00 e8 8e d8 15 07 <0f> 0b e8 d7 17 18 07 f3 0f 1e fa e8 3e 62 ec fd 43 80 3c 2f 00 74
RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056080679c000 CR3: 00000000193ad000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xa5d/0xcd0 fs/btrfs/relocation.c:3749
 btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
 btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
 btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4e2f88c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e305fd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4e2f9abf80 RCX: 00007f4e2f88c389
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007f4e2f8d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdbefc213f R14: 00007f4e305fd300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
Code: fe e9 f5 f7 ff ff e8 6d 62 ec fd 48 c7 c7 20 5e 4b 8b 48 c7 c6 c0 6d 4b 8b 48 c7 c2 a0 5e 4b 8b b9 7f 07 00 00 e8 8e d8 15 07 <0f> 0b e8 d7 17 18 07 f3 0f 1e fa e8 3e 62 ec fd 43 80 3c 2f 00 74
RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555657e888 CR3: 00000000193ad000 CR4: 00000000003506f0
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
