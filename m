Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1628FFCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405047AbgJPIMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 04:12:46 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:42521 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405069AbgJPIMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:12:24 -0400
Received: by mail-il1-f197.google.com with SMTP id f12so1005665ilq.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 01:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bm5SWSSR+OsZVNyMrrEA80pp6Iujuo2nZZDiousUxIE=;
        b=Q5sf3iSnH/IYYqVbSqtog2AVI1pu3LHeaccArcV3lBJ/Ldj6GEKQAIAIW6PF4LSAmK
         WtHgIEzp1N6LbV3z7zvnj2gY2H4POpOLMj6QBN0m5nEDhSZo9HSw6MCUS/CO3JeFNaSU
         ZzbWOgvc7zqGBAFfReOiYq8qvXOr0DbBJqumpSxQBgGrEghKtITFhsPMo3SggdS7kUws
         /nWgUacTkpSt43xLQ6r3B7uUKiZm7cJ1yFVSTlPQnKF0jucUZP+JYVauiQw4oapPJyfE
         i5afvTA0nFuvtlXh0jigZBHL/HqrQr7EL4VhzL7rG9S10IKctImiD0vl0qCn4ZS285+W
         PTPQ==
X-Gm-Message-State: AOAM530x4C+rd7frJ72lnNL11jATwEGIoiQobITWvayM4c77nut4PGO9
        dB+flIpJ+UiAlTPjzI1w/dklVrlXP3cJ5oCJLwM/rVtp6trb
X-Google-Smtp-Source: ABdhPJy3LJBD6x/8VkyDz94aY18nGxniV6nVha/uNNH6Dza+BQ6D5uZ0J9EKSFEFuqaj/qAA0FDyTdaa7Rr/9N4BWuttro+XA9Ui
MIME-Version: 1.0
X-Received: by 2002:a6b:651a:: with SMTP id z26mr1572620iob.186.1602835943793;
 Fri, 16 Oct 2020 01:12:23 -0700 (PDT)
Date:   Fri, 16 Oct 2020 01:12:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010295205b1c553d5@google.com>
Subject: WARNING: suspicious RCU usage in io_init_identity
From:   syzbot <syzbot+4596e1fcf98efa7d1745@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b2926c10 Add linux-next specific files for 20201016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc877f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6160209582f55fb1
dashboard link: https://syzkaller.appspot.com/bug?extid=4596e1fcf98efa7d1745
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4596e1fcf98efa7d1745@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.9.0-next-20201016-syzkaller #0 Not tainted
-----------------------------
include/linux/cgroup.h:494 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor.0/8301.

stack backtrace:
CPU: 0 PID: 8301 Comm: syz-executor.0 Not tainted 5.9.0-next-20201016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 task_css include/linux/cgroup.h:494 [inline]
 blkcg_css include/linux/blk-cgroup.h:224 [inline]
 blkcg_css include/linux/blk-cgroup.h:217 [inline]
 io_init_identity+0x3a9/0x450 fs/io_uring.c:1052
 io_uring_alloc_task_context+0x176/0x250 fs/io_uring.c:7730
 io_uring_add_task_file+0x10d/0x180 fs/io_uring.c:8653
 io_uring_get_fd fs/io_uring.c:9144 [inline]
 io_uring_create fs/io_uring.c:9308 [inline]
 io_uring_setup+0x2727/0x3660 fs/io_uring.c:9342
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7e11fe1bf8 EFLAGS: 00000206 ORIG_RAX: 00000000000001a9
RAX: ffffffffffffffda RBX: 0000000020000080 RCX: 000000000045de59
RDX: 00000000206d4000 RSI: 0000000020000080 RDI: 0000000000000087
RBP: 000000000118c020 R08: 0000000020000040 R09: 0000000020000040
R10: 0000000020000000 R11: 0000000000000206 R12: 00000000206d4000
R13: 0000000020ee7000 R14: 0000000020000040 R15: 0000000020000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
