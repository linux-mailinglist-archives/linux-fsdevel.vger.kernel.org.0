Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AE430C53
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Oct 2021 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhJQVcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Oct 2021 17:32:32 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51784 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhJQVcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Oct 2021 17:32:32 -0400
Received: by mail-io1-f71.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso9163092iov.18
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Oct 2021 14:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3H9FzlmbDVDpsM1j3kVL20tLVe48utjgIWT80u1mu7s=;
        b=stBOjlo39MOGIpzuFOfKyBYN2//b1mL9/GgG+u/ZgjElCzqM02t36zrg9dq4rU4Mb8
         cUv/ZB5c9sUZI9ZRmY5HdIEgXd+LEXkzvSxIT86BK/DavQsmpJAachvPijrfE/PvIzWW
         lKcD8gN+BqbT3tKhZ6PMv3gBRj0steglT1LjHnSYj7kSNYnaZZag3fsXnl4s3CYWHmV8
         5FtmP5PG18tgu3FQWbhmmfOhh1KyZ7oBf4k07pO2ix2mMpKqKsNcIUvLF2Mm+NM1b5dM
         cQREBIGl6pFtLIwdtFHovYNjM70v7S2jdDbUQH4uiNtvo9q7MSv4YgeBOnRoEr7jy9Lh
         05Uw==
X-Gm-Message-State: AOAM530nufRhWbVTXv8nFC/1SW2Hwhx2HYlBWbeyct+ddeispfAdsqBa
        h6s9Iltmzizp67YVdZvukrTGCn46NPZJduipg3NqU2iCKsD2
X-Google-Smtp-Source: ABdhPJwo6Tb1HwOSjoLSaBm9xgWZQ/508DhlbWe378C9CssspaCql6f6jxsYlDfC4egIhTRVkK953+2u+TTsB0FtIcP1EdL4F+/p
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2650:: with SMTP id n16mr5747471jat.72.1634506222156;
 Sun, 17 Oct 2021 14:30:22 -0700 (PDT)
Date:   Sun, 17 Oct 2021 14:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c13da605ce9322f7@google.com>
Subject: [syzbot] WARNING in fuse_evict_inode
From:   syzbot <syzbot+1a738a54963025fd8ff8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe5658b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=1a738a54963025fd8ff8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12115e78b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ca77f4b00000

The issue was bisected to:

commit 6e6b45a963c4a962c61ca59982982ddcdc82e651
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed Oct 13 12:33:40 2021 +0000

    fuse: write inode in fuse_vma_close() instead of fuse_release()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17aff458b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146ff458b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=106ff458b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a738a54963025fd8ff8@syzkaller.appspotmail.com
Fixes: 6e6b45a963c4 ("fuse: write inode in fuse_vma_close() instead of fuse_release()")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6556 at fs/fuse/inode.c:122 fuse_evict_inode+0x365/0x430 fs/fuse/inode.c:122
Modules linked in:
CPU: 0 PID: 6556 Comm: syz-executor054 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fuse_evict_inode+0x365/0x430 fs/fuse/inode.c:122
Code: 00 00 00 48 c7 83 a0 04 00 00 00 00 00 00 e9 58 fe ff ff e8 dd 7d c8 fe 48 89 df e8 f5 95 01 00 e9 05 fe ff ff e8 cb 7d c8 fe <0f> 0b e9 e8 fc ff ff 48 89 df e8 4c 10 0f ff e9 53 fe ff ff 48 89
RSP: 0018:ffffc9000282f8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88806be58000 RCX: 0000000000000000
RDX: ffff888017e53a00 RSI: ffffffff82aee6c5 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88806be5808b
R10: ffffffff82aee3ab R11: 0000000000000000 R12: ffff88806be580d8
R13: ffff88806be58028 R14: ffffffff89e3a8e0 R15: ffff88807806a980
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4a17dcf568 CR3: 000000000b88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:592
 iput_final fs/inode.c:1672 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1698
 iput+0x58/0x70 fs/inode.c:1688
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:376
 __dentry_kill+0x3c0/0x640 fs/dcache.c:582
 dentry_kill fs/dcache.c:708 [inline]
 dput+0x738/0xbc0 fs/dcache.c:888
 do_one_tree fs/dcache.c:1660 [inline]
 shrink_dcache_for_umount+0x11f/0x330 fs/dcache.c:1674
 generic_shutdown_super+0x68/0x370 fs/super.c:447
 kill_anon_super+0x36/0x60 fs/super.c:1057
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1137
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xc16/0x2b40 kernel/exit.c:832
 do_group_exit+0x125/0x310 kernel/exit.c:929
 get_signal+0x47d/0x2160 kernel/signal.c:2833
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:863
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4a17d79ef9
Code: Unable to access opcode bytes at RIP 0x7f4a17d79ecf.
RSP: 002b:00007f4a17d2b2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000139000 RBX: 00007f4a17e074e0 RCX: 00007f4a17d79ef9
RDX: 00000000fffffde4 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 00007f4a17dd40d4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007f4a17dd00c8 R14: 00007f4a17dd20d0 R15: 00007f4a17e074e8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
