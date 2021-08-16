Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A63ED031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhHPI14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 04:27:56 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36817 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhHPI1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:27:55 -0400
Received: by mail-io1-f72.google.com with SMTP id e187-20020a6bb5c4000000b005b5fe391cf9so1773457iof.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 01:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B4Azw9DgxcWUuTI+WSKquMKy4XJwMHAahNNLqORL3uo=;
        b=q1o5rZ1EwXpj69Qx1ECMvV9XMQbvKOLCmX/Y6NvXGqq8k6Lpv/0Yfi1tSrant5563a
         1Tw+wOQmtL8d+suRCX0+QFVk4NWEN1MWOLrg59Qk1fQXFAvgjMSxAt1aBAC9Nd9T1cxu
         x8MFfJZtAUzTqRFqil25uryqRUleLUS4ILY48MijmTC8/kmkp4+oPrW6ukeoKVzU5a2Y
         kaCqiKV5MONJPVQ2YH1weT9RYzhdj9yzYyqCyhOuYkC3I5lozAFfBdMsKCt50op/VxxX
         Sys5mAnddJb9LMdSr3RCozuScsxYV8Yb01NOLmP4GHcmu22RWCgsGy+DFvH96bdHCWCO
         wZcQ==
X-Gm-Message-State: AOAM532EujPvGq5fUAHTKngi3gRmCOdpiXQvT6/RmPWkf7Wf3mt+TtM3
        tqFkNHsRYzieb/7fqi1ZoB5yG4a7QEeTd2eWM6ijgf470O/s
X-Google-Smtp-Source: ABdhPJxGArL9ny9FErxZolVHUW80t7uaMT472hVX/C0JkR8sxyEqOEdag6DTAxu4FTOiZ3/HwAplNkEeILqTny9xpIn3VsPLUWXn
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148f:: with SMTP id j15mr14559668jak.61.1629102444397;
 Mon, 16 Aug 2021 01:27:24 -0700 (PDT)
Date:   Mon, 16 Aug 2021 01:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080486305c9a8f818@google.com>
Subject: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15221f4e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6a/0x1058

Use-after-free read at 0xffff88823bd2c020 (in kfence-#149):
 kvm_fastop_exception+0xf6a/0x1058
 d_lookup+0xd8/0x170 fs/dcache.c:2370
 lookup_dcache+0x1e/0x130 fs/namei.c:1520
 __lookup_hash+0x29/0x180 fs/namei.c:1543
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

kfence-#149: 0xffff88823bd2c000-0xffff88823bd2cfff, size=4096, cache=names_cache

allocated by task 22 on cpu 1 at 161.928971s:
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

freed by task 22 on cpu 1 at 161.929182s:
 putname.part.0+0xe1/0x120 fs/namei.c:270
 putname include/linux/err.h:41 [inline]
 filename_parentat fs/namei.c:2547 [inline]
 kern_path_locked+0xc2/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-rc5-next-20210816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
Code: d3 ed e9 f7 ae 6c f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 4d bc 6c f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 3d c6 6c f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 34317974746d7367 RBX: ffff88806efb4330 RCX: ffff88823bd2c020
RDX: ffffed100ddf686d RSI: 0000000000000008 RDI: 0000000000000007
RBP: 0000000000000008 R08: 0000000000000000 R09: ffff88806efb4360
R10: ffffed100ddf686c R11: 0000000000000000 R12: ffff88823bd2c020
R13: ffff88823bd2c020 R14: ffff88806efb4360 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bd2c020 CR3: 000000004683b000 CR4: 00000000001506e0
Call Trace:
 d_lookup+0xd8/0x170 fs/dcache.c:2370
 lookup_dcache+0x1e/0x130 fs/namei.c:1520
 __lookup_hash+0x29/0x180 fs/namei.c:1543
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
==================================================================
----------------
Code disassembly (best guess):
   0:	d3 ed                	shr    %cl,%ebp
   2:	e9 f7 ae 6c f8       	jmpq   0xf86caefe
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 4d bc 6c f8       	jmpq   0xf86cbc6f
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
  2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 3d c6 6c f8       	jmpq   0xf86cc67c
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
