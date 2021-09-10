Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6B406327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhIJAq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 20:46:57 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:57161 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbhIJAfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:35:43 -0400
Received: by mail-il1-f197.google.com with SMTP id d11-20020a92d78b000000b0022c670da306so159914iln.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 17:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1O5hU6TyMNcP/MwbrO6g7VP+Xas2iH+bxKbo7AXlS5I=;
        b=TglImdOhWbYXzSk/JRW7cvhgp9Xnby6HxrsIEQzabLfbS8cg0o3r/2a8BTjaljdgpJ
         yGR58/QvXP8wvcgtL9Ex4pZHPoqehQ+dW9oa2I6+gpjpewTNr/4vDDg4rTX8iZfdA6Kn
         HL5SVEEgcaVNOdHhIoqVwBOP0Wug+zdRWw7/5ZuPfIwDGyhOeZdh6lni+VK4IH/+bq3o
         R/sGQ6yX6bSeysawav1BoxQduqyNnYrzgCeQFd8VK8XkBj44pDDbjrHSqQ6DiqIxwtCU
         O07zymbDM4Az8v8bBPdf85Y6UtRQfBn1jZ3vRR7w+w0venOyDL+0v4SV6P7Inz4iatqD
         q32Q==
X-Gm-Message-State: AOAM530l2liGNP+GLlskC11F0XMXN8ECBa35bi9RenF/yGuW6mZt4OUJ
        aq8SC/9ESXtTOYGpmuhrzO4yD9G8K+l9WYU9pNGNmAKmdu09
X-Google-Smtp-Source: ABdhPJxPKmb9D6Akfc4/FgAiL4Nkl5zWGsSB03X8fpdIsfFJJcTIhrPBTV63/ZbdsU6x2wtVFlNWsUoN/ozp/G/oYWBR08rUTdqw
MIME-Version: 1.0
X-Received: by 2002:a6b:fb0b:: with SMTP id h11mr4930961iog.59.1631234072808;
 Thu, 09 Sep 2021 17:34:32 -0700 (PDT)
Date:   Thu, 09 Sep 2021 17:34:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074934705cb994769@google.com>
Subject: [syzbot] bpf-next test error: KFENCE: use-after-free in kvm_fastop_exception
From:   syzbot <syzbot+19d0d18201298c185c4f@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04' o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112e0b15300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac2f9cc43f6b17e4
dashboard link: https://syzkaller.appspot.com/bug?extid=19d0d18201298c185c4f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19d0d18201298c185c4f@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: use-after-free read in kvm_fastop_exception+0xf6d/0x105b

Use-after-free read at 0xffff88823bd7c020 (in kfence-#189):
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

kfence-#189 [0xffff88823bd7c000-0xffff88823bd7cfff, size=4096, cache=names_cache] allocated by task 22:
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
Code: d3 ed e9 54 03 6f f8 49 8d 0e 48 83 e1 f8 4c 8b 21 41 8d 0e 83 e1 07 c1 e1 03 49 d3 ec e9 aa 10 6f f8 49 8d 4d 00 48 83 e1 f8 <4c> 8b 21 41 8d 4d 00 83 e1 07 c1 e1 03 49 d3 ec e9 9a 1a 6f f8 bd
RSP: 0018:ffffc90000dcfae8 EFLAGS: 00010282
RAX: 0000003461736376 RBX: ffff88806f6feef0 RCX: ffff88823bd7c020
RDX: ffffed100dedfde5 RSI: 0000000000000005 RDI: 0000000000000007
RBP: 0000000000000005 R08: 0000000000000000 R09: ffff88806f6fef20
R10: ffffed100dedfde4 R11: 0000000000000000 R12: ffff88823bd7c020
R13: ffff88823bd7c020 R14: ffff88806f6fef20 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823bd7c020 CR3: 00000000723c1000 CR4: 00000000001506e0
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
   2:	e9 54 03 6f f8       	jmpq   0xf86f035b
   7:	49 8d 0e             	lea    (%r14),%rcx
   a:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
   e:	4c 8b 21             	mov    (%rcx),%r12
  11:	41 8d 0e             	lea    (%r14),%ecx
  14:	83 e1 07             	and    $0x7,%ecx
  17:	c1 e1 03             	shl    $0x3,%ecx
  1a:	49 d3 ec             	shr    %cl,%r12
  1d:	e9 aa 10 6f f8       	jmpq   0xf86f10cc
  22:	49 8d 4d 00          	lea    0x0(%r13),%rcx
  26:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
* 2a:	4c 8b 21             	mov    (%rcx),%r12 <-- trapping instruction
  2d:	41 8d 4d 00          	lea    0x0(%r13),%ecx
  31:	83 e1 07             	and    $0x7,%ecx
  34:	c1 e1 03             	shl    $0x3,%ecx
  37:	49 d3 ec             	shr    %cl,%r12
  3a:	e9 9a 1a 6f f8       	jmpq   0xf86f1ad9
  3f:	bd                   	.byte 0xbd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
