Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E562755F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGQJlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGQJlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:41:31 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBD2120
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 02:40:57 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9c82f64b7so1717868a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 02:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586857; x=1692178857;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kttQmn0dCMzZYamjOcfSUDdkP6auWy1EciSKLJvr7c0=;
        b=Kum0Io4bSMDaj25WMiBgOWqdSZtdlYtW3jbQHgEka19lshaSYVWAnzZ5r0+50Jawgg
         LLf7UAcVj1i6FioXcSZ+tIs/3jmnnr3t3VunvGNpBxXQrRiqBFmJRDvJHkO0MilvtJaw
         IppaCVdOkLlYf545HlpwLvj3h/sev318n85HCr+L2s77D3QahyeKZ383BaS+i6ZnX0lI
         h58dyiv3E4RjCFkQDMchUcRTjKZeutkp/mFdcvzKjuyJoEivrOvCPgkIVFkXgy4BAda7
         MLfsjbFrxCt/bow/d/tTBNDj/Y80kvQoeVjumcjd8z8qOowwHKDdwBUBy1NNJ+6dQ+wO
         B+bw==
X-Gm-Message-State: ABy/qLa5oLmE30ADgzy9ndNelq6XVXzuQka3iTefiM/yCs82eqi875g1
        td3CyNO7/ux4HrMS74jiQCD2geAj9VHsUSEdvkIaq+r8U0jV
X-Google-Smtp-Source: APBJJlGfknKsGBEab8tJk51M6WW018qwq7nlE3o6sm9CnyNVkuA8WdBm6l3xv9melqtC+eiuw+PMeAF/+LsxTg0qfD3cvXkhHlA4
MIME-Version: 1.0
X-Received: by 2002:a05:6870:772f:b0:1b0:60ff:b750 with SMTP id
 dw47-20020a056870772f00b001b060ffb750mr10350933oab.3.1689586856738; Mon, 17
 Jul 2023 02:40:56 -0700 (PDT)
Date:   Mon, 17 Jul 2023 02:40:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c5b30600ab98f3@google.com>
Subject: [syzbot] [ntfs3?] kernel BUG in __blockdev_direct_IO
From:   syzbot <syzbot+c73388acf8b6a00343a4@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    eb26cbb1a754 Merge tag 'platform-drivers-x86-v6.5-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b3886ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87ef4ae61b35aae1
dashboard link: https://syzkaller.appspot.com/bug?extid=c73388acf8b6a00343a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-eb26cbb1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64d2eea7ee5e/vmlinux-eb26cbb1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2dbe6b1755b5/bzImage-eb26cbb1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c73388acf8b6a00343a4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/direct-io.c:1025!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 18918 Comm: syz-executor.2 Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:do_direct_IO fs/direct-io.c:1025 [inline]
RIP: 0010:__blockdev_direct_IO+0x2dc3/0x3cf0 fs/direct-io.c:1248
Code: f3 ed 8a ff 41 83 ff 1f 0f 87 2b bb 21 08 e8 74 f2 8a ff b8 01 00 00 00 44 89 f9 d3 e0 8d 68 ff e9 26 d7 ff ff e8 5d f2 8a ff <0f> 0b e8 56 f2 8a ff 8b 9c 24 a8 01 00 00 31 ff 89 de e8 b6 ed 8a
RSP: 0018:ffffc900291cf1c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000656a000
RDX: 0000000000040000 RSI: ffffffff81fac443 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000009401a R12: 0000000000000000
R13: ffffea0001705040 R14: 0000000000000009 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7f8fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000056d1e04c CR3: 000000004efc7000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blockdev_direct_IO include/linux/fs.h:2830 [inline]
 ntfs_direct_IO+0x271/0x470 fs/ntfs3/inode.c:788
 generic_file_direct_write+0x132/0x360 mm/filemap.c:3848
 __generic_file_write_iter+0x11d/0x240 mm/filemap.c:4004
 ntfs_file_write_iter+0xd20/0x1bf0 fs/ntfs3/file.c:1081
 call_write_iter include/linux/fs.h:1871 [inline]
 do_iter_readv_writev+0x208/0x3b0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x666/0xba0 fs/splice.c:739
 do_splice_from fs/splice.c:934 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1143
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1089
 do_splice_direct+0x1af/0x280 fs/splice.c:1195
 do_sendfile+0xb70/0x1370 fs/read_write.c:1254
 __do_compat_sys_sendfile fs/read_write.c:1343 [inline]
 __se_compat_sys_sendfile fs/read_write.c:1326 [inline]
 __ia32_compat_sys_sendfile+0x1da/0x220 fs/read_write.c:1326
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f94579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f8f5ac EFLAGS: 00000292 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_direct_IO fs/direct-io.c:1025 [inline]
RIP: 0010:__blockdev_direct_IO+0x2dc3/0x3cf0 fs/direct-io.c:1248
Code: f3 ed 8a ff 41 83 ff 1f 0f 87 2b bb 21 08 e8 74 f2 8a ff b8 01 00 00 00 44 89 f9 d3 e0 8d 68 ff e9 26 d7 ff ff e8 5d f2 8a ff <0f> 0b e8 56 f2 8a ff 8b 9c 24 a8 01 00 00 31 ff 89 de e8 b6 ed 8a
RSP: 0018:ffffc900291cf1c0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc9000656a000
RDX: 0000000000040000 RSI: ffffffff81fac443 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000009401a R12: 0000000000000000
R13: ffffea0001705040 R14: 0000000000000009 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7f8fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000056d1e04c CR3: 000000004efc7000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
