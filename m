Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CD9407CBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhILJvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 05:51:49 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45005 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhILJvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 05:51:39 -0400
Received: by mail-io1-f72.google.com with SMTP id d15-20020a0566022befb02905b2e9040807so12067442ioy.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Sep 2021 02:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2IHbQLMbrH/C4KpS2kFJjGjutAVirXBAfLA6HbR4HS8=;
        b=T1Pr07f+M0Lwm0ScUqTx/oteFSy4HboWbJK+HkLmMZEjdebO/mIiLeumsaddbWRKN2
         JqQ0I1PD/MqraPqS/gTI9NeBMTdpEEBje0mFrcKwgq5bbeDFQ0bHpHJOuKmiiRHspu0n
         C+oQnAn48Ju95Xf+bcVp+aMj5qwNq2lsuZmAZmkrqaupuk0QSuz5irPB7wyefYssCdTr
         LOqOoFYRFC2ihF879RtnfaVp16KHcDFqhPoodKLSl2sbtypgJ5oZe4t18JGqaQWqyL5k
         2RJj8itdbYC0CPUvYjWXAaZTZp+QTNJUwvwKZJGcpIJSJmh5OsPJyXIKKjZ7jdX4gfmK
         zqHg==
X-Gm-Message-State: AOAM530WLeXiNizpH4mXbmFpZCfS9/Ek9gQZdV2fJjTq5wpgRk7J3QqS
        4fJ7gw0iFPB/+HlaYE8pg5KPDsBlu+7UXGgAAQfvuLHzMnwV
X-Google-Smtp-Source: ABdhPJxXVuLyl9sF5oZmU6eBAkMuoqCIy4S0wuj7Z13sJFu7dBRKaz3ZTVXGJXqzisoRTNp8iew4Oc+lxao6hcH2zgAxO8P25WPm
MIME-Version: 1.0
X-Received: by 2002:a5d:9e0f:: with SMTP id h15mr4455362ioh.133.1631440225140;
 Sun, 12 Sep 2021 02:50:25 -0700 (PDT)
Date:   Sun, 12 Sep 2021 02:50:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000178a9305cbc947c4@google.com>
Subject: [syzbot] upstream boot error: KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+79e3be0f27748965946b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf9f243f23e6 Merge tag '5.15-rc-ksmbd-part2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1537eedd300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
dashboard link: https://syzkaller.appspot.com/bug?extid=79e3be0f27748965946b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79e3be0f27748965946b@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6a/0x1058

Use-after-free read at 0xffff88823bd9e020 (in kfence-#206):
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

kfence-#206: 0xffff88823bd9e000-0xffff88823bd9efff, size=4096, cache=names_cache

allocated by task 22 on cpu 1 at 51.213658s:
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

freed by task 22 on cpu 1 at 51.213995s:
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

CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_fastop_exception+0xf6a/0x1058
Code: d3 ed e9 bf d9 6e f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 15 e7 6e f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 05 f1 6e f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 0000000034736376 RBX: ffff88806f127938 RCX: ffff88823bd9e020
RDX: ffffed100de24f2e RSI: 0000000000000004 RDI: 0000000000000007
RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88806f127968
R10: ffffed100de24f2d R11: 0000000000000000 R12: ffff88823bd9e020
R13: ffff88823bd9e020 R14: ffff88806f127968 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bd9e020 CR3: 0000000026259000 CR4: 0000000000350ee0
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
   2:	e9 bf d9 6e f8       	jmpq   0xf86ed9c6
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 15 e7 6e f8       	jmpq   0xf86ee737
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
* 2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 05 f1 6e f8       	jmpq   0xf86ef144
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
