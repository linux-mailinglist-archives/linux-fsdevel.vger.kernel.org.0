Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8AD74E559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 05:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGKDct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 23:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGKDcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:32:47 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1AE8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 20:32:45 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-39a9590f9fdso3419313b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 20:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689046364; x=1691638364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lp5QHKesuU6o2/IddKgFYSCyE55ls1rE6PDQS4VuHTs=;
        b=lpGOQUdKJv9RtR9scYHpcegClXbWO24WGYD1j1MxuHCcRtpdCXv3zfqFyLKWCUmrtt
         tbwPxQ9EkujecrqJXp9e2ZtYZGfOKqPw64f9cHLf0/5/xYk9BKNfmkgtltuXYsjPWP9a
         fMLTXFcgF+PqlRBTmezFt2oWAaBwUuP4f60lU/iYzXnpM8loXrRor8/q4Aoi+PwDBpjs
         wiwou4FFm8o0WQ4zO6hKF4MTHOE4Exd8Ad8AU2Y1yVAejdpfAHUwzWZ+4XUE9VpopETt
         PAEFiP9BXWVMOtHFNKd3lH/u30t41cJpRRK2tLx0wdRHJ+7ByCdDkqe+1x1ha0vp+q+0
         W6TQ==
X-Gm-Message-State: ABy/qLZ0BCq6GnMe1zGcbuaPqqixChrudtWeRfE6blDhNwZhNr/IF9r5
        sQn6avmHzLW16w4GPoV4bX2pRfJhYgGKOWlrs/wAfRrdeRjz
X-Google-Smtp-Source: APBJJlHHsvW5+XYCof1/w8J9rGTZSzNhWmAZZUIYjeBakhIVKQcVvS7SG305Pcd+W6vuk+T/DFlt7jPu81k1dOHnkhoDnXV0FdEO
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180c:b0:3a4:1484:b3db with SMTP id
 bh12-20020a056808180c00b003a41484b3dbmr239520oib.5.1689046364538; Mon, 10 Jul
 2023 20:32:44 -0700 (PDT)
Date:   Mon, 10 Jul 2023 20:32:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000914c1206002dc099@google.com>
Subject: [syzbot] [overlayfs?] general protection fault in ovl_init_uuid_xattr
From:   syzbot <syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12353b44a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=b592c1f562f0da80ce2c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15741e22a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1105b4e2a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/disk-123212f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinux-123212f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/bzImage-123212f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b592c1f562f0da80ce2c@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
CPU: 1 PID: 5024 Comm: syz-executor280 Not tainted 6.4.0-next-20230707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:ovl_do_getxattr fs/overlayfs/overlayfs.h:263 [inline]
RIP: 0010:ovl_path_getxattr fs/overlayfs/overlayfs.h:292 [inline]
RIP: 0010:ovl_init_uuid_xattr+0x1f6/0xa90 fs/overlayfs/util.c:695
Code: c1 ea 03 80 3c 02 00 0f 85 54 08 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 74 24 08 48 8d be e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f2 07 00 00 4c 89 e1 48 8b 86 e0 00 00 00 48 ba
RSP: 0018:ffffc90003aafab8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888014e67c00 RCX: 0000000000000005
RDX: 000000000000001c RSI: 0000000000000000 RDI: 00000000000000e0
RBP: ffff888029c04678 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801927c480
R13: ffff888014e67c79 R14: ffff888014e67c60 R15: 0000000000000000
FS:  0000555556b13300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000022580000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ovl_fill_super+0x1f94/0x5d70 fs/overlayfs/super.c:1437
 vfs_get_super+0xea/0x280 fs/super.c:1152
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x136e/0x1e70 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f60c9bc0b09
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc22c0ccf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f60c9bc0b09
RDX: 00000000200000c0 RSI: 0000000020000200 RDI: 0000000000000000
RBP: 00007f60c9b84cb0 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f60c9b84d40
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ovl_do_getxattr fs/overlayfs/overlayfs.h:263 [inline]
RIP: 0010:ovl_path_getxattr fs/overlayfs/overlayfs.h:292 [inline]
RIP: 0010:ovl_init_uuid_xattr+0x1f6/0xa90 fs/overlayfs/util.c:695
Code: c1 ea 03 80 3c 02 00 0f 85 54 08 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 74 24 08 48 8d be e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f2 07 00 00 4c 89 e1 48 8b 86 e0 00 00 00 48 ba
RSP: 0018:ffffc90003aafab8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888014e67c00 RCX: 0000000000000005
RDX: 000000000000001c RSI: 0000000000000000 RDI: 00000000000000e0
RBP: ffff888029c04678 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801927c480
R13: ffff888014e67c79 R14: ffff888014e67c60 R15: 0000000000000000
FS:  0000555556b13300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000022580000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 54 08 00 00    	jne    0x861
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
  1c:	48 8d be e0 00 00 00 	lea    0xe0(%rsi),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 f2 07 00 00    	jne    0x826
  34:	4c 89 e1             	mov    %r12,%rcx
  37:	48 8b 86 e0 00 00 00 	mov    0xe0(%rsi),%rax
  3e:	48                   	rex.W
  3f:	ba                   	.byte 0xba


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
