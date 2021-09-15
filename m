Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6640BF12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 06:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhIOE5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 00:57:47 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:36525 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOE5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:57:43 -0400
Received: by mail-il1-f199.google.com with SMTP id s15-20020a056e02216f00b002276040aa1dso1142119ilv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 21:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XpqGUfgj1UpzVzMCIPc1Y8Cu24aJjfL4Kx90Yo5iOMc=;
        b=UpyK7SSIJnqgcjm7GEvitw9SFx/fXHk6UKSbzb87YF0Bo3rrw23vAV4OCvXXuHrPYx
         GpdbXTA4yaJf8WD1Jg4vXOLp5WMV7bkxmQf3KcZG4C1AUEA/7Q3EPoln2GbBP6U3AGJ6
         tHu9bnYARpahSecGO7xX1jMTUvkSK4n28N8GaAYBXOzrKv4KYn6u4cO35fyYIPLv4XY4
         qMOS/qMiePI3lZ5mxISWxUbKNgkutDzWMHbyUqS0Xm5ZTWyCh73n/ScbxhlC0pgUcngh
         hdgZZHF3ek7HYIXYDcvF+iAajQhr4oRCDRSjSbiMFaZncoChEe9oTkjWq4AulVw0S6qM
         Lp6Q==
X-Gm-Message-State: AOAM533YdYxER7Nx/P6O9fuZdx5Q0aLAI20nQYsdjJsgCZqNSriojg6Z
        axVXDzahERtwprNzpY3ap3h5hzZq3JZRGXqTG7kPARc93QuL
X-Google-Smtp-Source: ABdhPJwYGIbJQGIUflIsi2fCvaDp4FNjJt2/WwU7oWZsjaSKtEWdO4iuUeS0p+tWGPpg+tPrhHIASGmGlq3m8/8kHT8C3MdQzpF+
MIME-Version: 1.0
X-Received: by 2002:a92:bf01:: with SMTP id z1mr14227049ilh.155.1631681785448;
 Tue, 14 Sep 2021 21:56:25 -0700 (PDT)
Date:   Tue, 14 Sep 2021 21:56:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000354def05cc0185ab@google.com>
Subject: [syzbot] general protection fault in fuse_test_super
From:   syzbot <syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aa14a3016182 Add linux-next specific files for 20210910
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148da295300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e400f2d70a0ed309
dashboard link: https://syzkaller.appspot.com/bug?extid=74a15f02ccb51f398601
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12da37b9300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb87ed300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 6638 Comm: syz-executor038 Not tainted 5.14.0-next-20210910-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:get_fuse_conn_super fs/fuse/fuse_i.h:844 [inline]
RIP: 0010:fuse_test_super+0x68/0xa0 fs/fuse/inode.c:1633
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 3a 48 8b 9b 78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 75 12 31 c0 48 39 2b 5b 5d 0f 94 c0 c3 e8 92 9f 0d ff
RSP: 0018:ffffc90002e1fcc8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82ae91fd RDI: ffff8880750a4678
RBP: ffff88801ca4d000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520005c3f8e R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff82ae91f0 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000fd5300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd112d1758 CR3: 0000000071247000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 sget_fc+0x1ff/0x7c0 fs/super.c:525
 fuse_get_tree+0x201/0x3f0 fs/fuse/inode.c:1664
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x440089
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd112d1778 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000483088 RCX: 0000000000440089
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 0030656c69662f2e R08: 00000000200004c0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000010bf1
R13: 00007ffd112d178c R14: 00007ffd112d17a0 R15: 00007ffd112d1790
Modules linked in:
---[ end trace 750f18e3bec431c4 ]---
RIP: 0010:get_fuse_conn_super fs/fuse/fuse_i.h:844 [inline]
RIP: 0010:fuse_test_super+0x68/0xa0 fs/fuse/inode.c:1633
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 3a 48 8b 9b 78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 75 12 31 c0 48 39 2b 5b 5d 0f 94 c0 c3 e8 92 9f 0d ff
RSP: 0018:ffffc90002e1fcc8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82ae91fd RDI: ffff8880750a4678
RBP: ffff88801ca4d000 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520005c3f8e R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff82ae91f0 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000fd5300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd112d1758 CR3: 0000000071247000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	75 3a                	jne    0x48
   e:	48 8b 9b 78 06 00 00 	mov    0x678(%rbx),%rbx
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 89 da             	mov    %rbx,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	75 12                	jne    0x3e
  2c:	31 c0                	xor    %eax,%eax
  2e:	48 39 2b             	cmp    %rbp,(%rbx)
  31:	5b                   	pop    %rbx
  32:	5d                   	pop    %rbp
  33:	0f 94 c0             	sete   %al
  36:	c3                   	retq
  37:	e8 92 9f 0d ff       	callq  0xff0d9fce


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
