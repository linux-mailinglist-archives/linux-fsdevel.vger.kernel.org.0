Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30D2A225B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 00:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgKAXYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 18:24:23 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:33379 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKAXYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:24:23 -0500
Received: by mail-il1-f199.google.com with SMTP id p17so9041499ilj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2020 15:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xdG1g/vxW4V06+0hNW4+RSygWk2/psbPdoeLoxet6OM=;
        b=B036FZWMzrfEhHzSNwRJwxkisxnJ1B25ziZQVsntx8FGKCLtfFbcC4dWRY19J6jjjz
         MQzH5+Ab1v2hu50E/7CiITpqxHqbjiBGmsEkKniH3olpCkrigQMIHWTpZQ9YE8evLhiV
         s5x8RqO9yBstHpuhsuW2Yaxw1lbQCxAsxpTaeb5P+4tQDVet+7PrkJhnRi6dovCONIFn
         f2iu7Qlaw2VjycnQWK++s6sfdCoZpxlOicdwc/JOOBczq76VLwK/AnbrvMSBRZoNyEuv
         XkHeIvHVnGgWUv47aYSS58ubTRAjbVu5kDqZYoo+T4yaztlsT5VAr4Ws9uj+yRAHHHAH
         Kyjg==
X-Gm-Message-State: AOAM530SH0TmK08b1HEnhFns89wdGKbkMjPv7/y7VAyZfbTjjxUbZVeL
        GuDudnqQO2ugqY0ap8m42M+FSHFoZAXPLhB/9Z4MxeVxl4RC
X-Google-Smtp-Source: ABdhPJxXm8rs/hHFjFSZbDY9/bR54376T57CPlNY/4/9Md2q3wYdUAh3koHdpniksWm88aEHDDrGIGh5TTZdUXpfY43QRrft3YSW
MIME-Version: 1.0
X-Received: by 2002:a6b:3e83:: with SMTP id l125mr8800963ioa.151.1604273061562;
 Sun, 01 Nov 2020 15:24:21 -0800 (PST)
Date:   Sun, 01 Nov 2020 15:24:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f50cb705b313ed70@google.com>
Subject: BUG: sleeping function called from invalid context in ext4_superblock_csum_set
From:   syzbot <syzbot+7a4ba6a239b91a126c28@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ed8780e3 Merge tag 'x86-urgent-2020-10-27' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174e7b74500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be40dc0ffa0bea0
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4ba6a239b91a126c28
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a4ba6a239b91a126c28@syzkaller.appspotmail.com

EXT4-fs error (device sda1): mb_free_blocks:1506: group 7, inode 16554: block 229408:freeing already freed block (bit 32); block bitmap corrupt.
BUG: sleeping function called from invalid context at include/linux/buffer_head.h:364
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9864, name: syz-executor.0
5 locks held by syz-executor.0/9864:
 #0: ffff888015554460 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1648 [inline]
 #0: ffff888015554460 (sb_writers#6){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff88801f81d4c8 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
 #1: ffff88801f81d4c8 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at: do_truncate+0x125/0x1f0 fs/open.c:62
 #2: ffff88801f81d350 (&ei->i_mmap_sem){++++}-{3:3}, at: ext4_setattr+0xdde/0x1ff0 fs/ext4/inode.c:5415
 #3: ffff88801f81d2b8 (&ei->i_data_sem){++++}-{3:3}, at: ext4_truncate+0x787/0x1420 fs/ext4/inode.c:4246
 #4: ffff88801d7ae1d8 (&bgl->locks[i].lock){+.+.}-{2:2}, at: spin_trylock include/linux/spinlock.h:364 [inline]
 #4: ffff88801d7ae1d8 (&bgl->locks[i].lock){+.+.}-{2:2}, at: ext4_lock_group+0x71/0x240 fs/ext4/ext4.h:3326
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 2 PID: 9864 Comm: syz-executor.0 Not tainted 5.10.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7298
 lock_buffer include/linux/buffer_head.h:364 [inline]
 ext4_superblock_csum_set+0x164/0x3c0 fs/ext4/super.c:301
 ext4_commit_super+0x611/0xc50 fs/ext4/super.c:5536
 __ext4_grp_locked_error+0x4c9/0x570 fs/ext4/super.c:1017
 mb_free_blocks+0xb59/0x15f0 fs/ext4/mballoc.c:1506
 ext4_mb_release_inode_pa.isra.0+0x310/0xca0 fs/ext4/mballoc.c:4177
 ext4_discard_preallocations+0x6c5/0xe90 fs/ext4/mballoc.c:4441
 ext4_truncate+0x791/0x1420 fs/ext4/inode.c:4248
 ext4_setattr+0x133c/0x1ff0 fs/ext4/inode.c:5490
 notify_change+0xb60/0x10a0 fs/attr.c:336
 do_truncate+0x134/0x1f0 fs/open.c:64
 handle_truncate fs/namei.c:2910 [inline]
 do_open fs/namei.c:3256 [inline]
 path_openat+0x2054/0x2730 fs/namei.c:3369
 do_filp_open+0x17e/0x3c0 fs/namei.c:3396
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_creat fs/open.c:1258 [inline]
 __se_sys_creat fs/open.c:1252 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1252
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45da59
Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb835092c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00000000006f4da0 RCX: 000000000045da59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 00000000004aab8b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075bf00
R13: 00007fff472d64af R14: 00007fb835073000 R15: 0000000000000003
EXT4-fs error (device sda1): ext4_mb_generate_buddy:802: group 7, block bitmap and bg descriptor inconsistent: 32734 vs 32735 free clusters
EXT4-fs (sda1): pa 00000000af22a596: logic 0, phys. 229408, len 32
EXT4-fs error (device sda1): ext4_mb_release_inode_pa:4186: group 7, free 16, pa_free 15


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
