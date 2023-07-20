Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1F75AD21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGTLiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGTLiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:38:06 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82F136
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 04:38:04 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-5559caee9d3so1009798eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 04:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853083; x=1690457883;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMsgEtuq6MCNWyvdDRbB5vs/kN/fpsQH8wUhu5hIBQM=;
        b=KHe265oYYFADYppCH4rL+vEdcafCZA/LK5N5uWedwMmVUk+kYw7qJ7MZySccyYm23/
         Lsgx/iWP/m6A59I8eZMfkopNbi1Rl1iVEU7v4rZUuuVHNil6SVZ2J+45Unfqcoj59Voj
         8p2sknmVSXMC0tu+kIOC1pd872eoWw8VXhPkb6Rxk/BL/pS90jIWgDtOwaSXH8/7XVY1
         TouJy/PcyNOSHb3bRkp+lez2Fg1JtXmVp9lDnt481sHODtIaJQKA8HsPY5+EHcBDGxEB
         i0vbMjpGZXA9/0PLQ3j7x6le/a9QFeMe+mXj2HCoffaFD20C1kXg6Rcd7OiKQud817Ev
         5O0g==
X-Gm-Message-State: ABy/qLb7oor8/0qthiJGKQ9QTEIUWN9hn/kLgurQjHM1Ei6QHA31i0MU
        3bRuxQwVheUWjsBY/ckb/dz4MAHmkGnb63gO7k3J9CJWswWR
X-Google-Smtp-Source: APBJJlGuy+DDzHOTkGshT3SEF6zfD2x25z2kzRXEtSXTbR5q31TYvjcmlw3Ge133ZHxmCErOwLtZHK3NxwX8UHWtkOnj3EkPZDvt
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1919:b0:3a4:14c1:20f5 with SMTP id
 bf25-20020a056808191900b003a414c120f5mr2613001oib.6.1689853083326; Thu, 20
 Jul 2023 04:38:03 -0700 (PDT)
Date:   Thu, 20 Jul 2023 04:38:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c11ed40600e994b1@google.com>
Subject: [syzbot] [ext4?] general protection fault in ep_poll_callback
From:   syzbot <syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1533fa14a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27e33fd2346a54b
dashboard link: https://syzkaller.appspot.com/bug?extid=c2b68bdf76e442836443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111c904ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b0faaa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2869ea56e997/disk-bfa3037d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06fd8fb45baf/vmlinux-bfa3037d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c5715f42344/bzImage-bfa3037d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/96d1ec5db296/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2b68bdf76e442836443@syzkaller.appspotmail.com

general protection fault, maybe for address 0xffffc90003e0fdc8: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4473 Comm: udevd Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:__wake_up_common+0x13c/0x5a0 kernel/sched/wait.c:107
Code: c6 04 75 6e 49 8d 78 10 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 1c 03 00 00 48 8b 4c 24 08 4c 89 c7 8b 54 24 10 8b 74 24 04 <41> ff 50 10 85 c0 78 2d 74 11 41 83 e6 01 74 0b 83 6c 24 14 01 0f
RSP: 0018:ffffc900031cf790 EFLAGS: 00010046
RAX: 1ffff920007c1fb9 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90003e0fdb8
RBP: ffff8880273470d0 R08: ffffc90003e0fdb8 R09: ffffc900031cf830
R10: 0000000000000003 R11: 0000000000094000 R12: ffffc900031cf830
R13: dffffc0000000000 R14: 00000000ffff8880 R15: 816f3352ffff8868
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000fffffffe CR3: 000000000c776000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
 ep_poll_callback+0x316/0xc10 fs/eventpoll.c:1242
 __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
 signalfd_notify include/linux/signalfd.h:22 [inline]
 __send_signal_locked+0x94b/0x11d0 kernel/signal.c:1173
 do_send_sig_info kernel/signal.c:1296 [inline]
 group_send_sig_info+0x2ad/0x310 kernel/signal.c:1446
 forget_original_parent kernel/exit.c:709 [inline]
 exit_notify kernel/exit.c:734 [inline]
 do_exit+0xd9d/0x2a20 kernel/exit.c:894
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23ea/0x2770 kernel/signal.c:2877
 arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8fae30e3cd
Code: Unable to access opcode bytes at 0x7f8fae30e3a3.
RSP: 002b:00007ffea9c17ff0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ea
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f8fae30e3cd
RDX: 0000000000000006 RSI: 0000000000001179 RDI: 0000000000001179
RBP: 0000000000001179 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffea9c18200 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__wake_up_common+0x13c/0x5a0 kernel/sched/wait.c:107
Code: c6 04 75 6e 49 8d 78 10 48 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 1c 03 00 00 48 8b 4c 24 08 4c 89 c7 8b 54 24 10 8b 74 24 04 <41> ff 50 10 85 c0 78 2d 74 11 41 83 e6 01 74 0b 83 6c 24 14 01 0f
RSP: 0018:ffffc900031cf790 EFLAGS: 00010046

RAX: 1ffff920007c1fb9 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90003e0fdb8
RBP: ffff8880273470d0 R08: ffffc90003e0fdb8 R09: ffffc900031cf830
R10: 0000000000000003 R11: 0000000000094000 R12: ffffc900031cf830
R13: dffffc0000000000 R14: 00000000ffff8880 R15: 816f3352ffff8868
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000fffffffe CR3: 000000000c776000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	c6 04 75 6e 49 8d 78 	movb   $0x10,0x788d496e(,%rsi,2)
   7:	10
   8:	48 89 f8             	mov    %rdi,%rax
   b:	48 c1 e8 03          	shr    $0x3,%rax
   f:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  14:	0f 85 1c 03 00 00    	jne    0x336
  1a:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  1f:	4c 89 c7             	mov    %r8,%rdi
  22:	8b 54 24 10          	mov    0x10(%rsp),%edx
  26:	8b 74 24 04          	mov    0x4(%rsp),%esi
* 2a:	41 ff 50 10          	call   *0x10(%r8) <-- trapping instruction
  2e:	85 c0                	test   %eax,%eax
  30:	78 2d                	js     0x5f
  32:	74 11                	je     0x45
  34:	41 83 e6 01          	and    $0x1,%r14d
  38:	74 0b                	je     0x45
  3a:	83 6c 24 14 01       	subl   $0x1,0x14(%rsp)
  3f:	0f                   	.byte 0xf


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
