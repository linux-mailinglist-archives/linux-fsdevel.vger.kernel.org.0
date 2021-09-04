Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F945400CB6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 20:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhIDS7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 14:59:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43590 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhIDS7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:59:21 -0400
Received: by mail-il1-f197.google.com with SMTP id i5-20020a056e0212c500b0022b41c6554bso575605ilm.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Sep 2021 11:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CWgZv89raI6FjW1i2Zg7mi6RNJ73KbtI0Q8N7x6OQqI=;
        b=U5YAZsZoWcHUNBUf3YzC9+fFXDJlBvTRV457w/w6rZrGjeZ+5Tpmp/SL+wao2eJzfq
         vm3Up6VxrwAYrzciEV6OKaoF4knBFjmAE5G3BYlMXBbt+2uoj3ITxb26/ZlT3s5QYqqK
         FZyA9KjR7Jlm7zxQjWjwhBA4UKjsKDhmef4uYzWGIex1cLHzeHHRzyx1JS2wkGIfxe9j
         uRVg1cFh/GNphQ76k1veI8fXehhsRd0SINal+n9BQv2dX+Dy+PlbqBdC205izYNWQg6M
         HXoxbsN5AZsU3MwAjtKw2KdFHmQIaqllQZQfbruu8FrmgQFpgE34blwwlrErUwZjx9lp
         8gFA==
X-Gm-Message-State: AOAM533wVePGgTIi8uVsJf7IZdSHI7QU1RRVf0oyeCmexSBWd3416WJx
        I5oLLKxT4VMHoPPUVXubdb7CFHpWrWqw4kCgLUwRVXOakdUq
X-Google-Smtp-Source: ABdhPJytlHOirhofFAXXQvRYfU1sYZUwYhGV6rkm8N9DJ0T55F8O/Mntcq6fgj7zyV9k+LNWWaltRMrLgA3d00cCCMZvPbULXVbA
MIME-Version: 1.0
X-Received: by 2002:a6b:b586:: with SMTP id e128mr3810502iof.37.1630781899715;
 Sat, 04 Sep 2021 11:58:19 -0700 (PDT)
Date:   Sat, 04 Sep 2021 11:58:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6b66705cb2fffd4@google.com>
Subject: [syzbot] upstream test error: KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1189fe49300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a7a34dc082816f
dashboard link: https://syzkaller.appspot.com/bug?extid=d08efd12a2905a344291
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6d/0x105b

Use-after-free read at 0xffff88823bc0c020 (in kfence-#5):
 kvm_fastop_exception+0xf6d/0x105b
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

kfence-#5 [0xffff88823bc0c000-0xffff88823bc0cfff, size=4096, cache=names_cache] allocated by task 22:
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

freed by task 22:
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
RIP: 0010:kvm_fastop_exception+0xf6d/0x105b
Code: d3 ed e9 14 1b 6d f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 6a 28 6d f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 5a 32 6d f8 bd
RSP: 0018:ffffc90000fe7ae8 EFLAGS: 00010282
RAX: 0000000035736376 RBX: ffff88803b141cc0 RCX: ffff88823bc0c020
RDX: ffffed100762839f RSI: 0000000000000004 RDI: 0000000000000007
RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88803b141cf0
R10: ffffed100762839e R11: 0000000000000000 R12: ffff88823bc0c020
R13: ffff88823bc0c020 R14: ffff88803b141cf0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bc0c020 CR3: 0000000029892000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
   2:	e9 14 1b 6d f8       	jmpq   0xf86d1b1b
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 6a 28 6d f8       	jmpq   0xf86d288c
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
* 2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 5a 32 6d f8       	jmpq   0xf86d3299
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
