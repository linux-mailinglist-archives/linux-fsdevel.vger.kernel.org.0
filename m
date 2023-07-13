Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EC752938
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjGMQ46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjGMQ45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:56:57 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321526B3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:56:55 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a044f9104dso1636790b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 09:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267415; x=1691859415;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gM8/dymwrjkejibQZsllXqV7rMzyZcfmfqxEEXBQVA=;
        b=RFvOzZzqiMrgD15ISL3lAVWB7B1VDme+htOPFox/Zxb+VCiVcEN4a4YbZ/dC4oYMVe
         zjtAxJMqC0gsECMIDa/dH3DepsxV+IRuuIWWDRfOjwKtT5aFcO6Oh8JxAQKxuG88CluT
         Qy7pbhTcREBBwzZqh2Yi/Iaa1JHjdKL/oGhpkfjHgiM1mNrEtYeZ2cR/hsFxy7svnSRe
         bZsI8jV0B+mQyLwYMmxIb1vxy9Z5OCXuYSpj/Y5tE6U21G22E7Jn/4KhMZgdf7seIIVo
         7I/gP/rKdixA4NHgCDZsAjSkW1ZfwtbTYJ0mOj4uzuhwUG/nTiIcqzzbc/KiyuPom5nS
         C3Ow==
X-Gm-Message-State: ABy/qLbCXwECZvTe2WCwLa9A7P3gtKHDJfBvNh8t0aZv2JmU0Mm0Ic5C
        2wC12wo3qv4FVE3dvL8Gl6iOHCcjWzfgoEX6ttTwJMDSC61t
X-Google-Smtp-Source: APBJJlHwoOLkoDREBTBNKxyrmeTDPARGeRx4zmIy+dvtXjIwG3c9mV6txR8KtAk0tEYeGyLtPco2sAY7qj26h2IUEtk/8/RgUgXS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8b:b0:3a1:edf0:c79f with SMTP id
 o11-20020a0568080f8b00b003a1edf0c79fmr2656471oiw.3.1689267415232; Thu, 13 Jul
 2023 09:56:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:56:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003735c9060061384a@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_finish_ordered_extent
From:   syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=117b9b6ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=5b82f0e951f8c2bcdb8f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f5014ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f5adb0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8b0db7be621/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e54c8d8a4367/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a266546d6979/bzImage-3f01e9fe.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/954ae8a07707/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com

RBP: 00007ffef40699e0 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffef4069a20 R14: 00007ffef4069a00 R15: 0000000000000004
 </TASK>
BTRFS warning (device loop0): direct IO failed ino 263 op 0x8801 offset 0x4000 len 4096 err no 9
general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 PID: 5096 Comm: syz-executor315 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:btrfs_finish_ordered_extent+0x43/0x3c0 fs/btrfs/ordered-data.c:375
Code: 4c 24 10 48 89 54 24 08 48 89 74 24 18 49 89 fe 48 bb 00 00 00 00 00 fc ff df e8 b8 4e f9 fd 49 8d 6e 60 49 89 ec 49 c1 ec 03 <41> 80 3c 1c 00 74 08 48 89 ef e8 7e 04 52 fe 4c 8b 7d 00 49 8d 9f
RSP: 0018:ffffc90003dcf438 EFLAGS: 00010206
RAX: ffffffff8392b4f8 RBX: dffffc0000000000 RCX: ffff888020f01dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000060 R08: 0000000000000000 R09: ffffffff838ef2c7
R10: 0000000000000003 R11: ffff888020f01dc0 R12: 000000000000000c
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88814c43c300
FS:  0000555555a85300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8a9d884140 CR3: 0000000079cdb000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_dio_end_io+0x171/0x470 fs/btrfs/inode.c:7810
 iomap_dio_submit_bio fs/iomap/direct-io.c:75 [inline]
 iomap_dio_bio_iter+0xe15/0x1430 fs/iomap/direct-io.c:347
 __iomap_dio_rw+0x11fa/0x2250 fs/iomap/direct-io.c:575
 btrfs_dio_write+0xb6/0x100 fs/btrfs/inode.c:7884
 btrfs_direct_write fs/btrfs/file.c:1526 [inline]
 btrfs_do_write_iter+0x61c/0x1020 fs/btrfs/file.c:1667
 do_iter_write+0x84f/0xde0 fs/read_write.c:860
 vfs_writev fs/read_write.c:933 [inline]
 do_pwritev+0x21a/0x360 fs/read_write.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8a9d80cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef40699a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f8a9d80cb29
RDX: 0000000000000002 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007ffef40699e0 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffef4069a20 R14: 00007ffef4069a00 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_finish_ordered_extent+0x43/0x3c0 fs/btrfs/ordered-data.c:375
Code: 4c 24 10 48 89 54 24 08 48 89 74 24 18 49 89 fe 48 bb 00 00 00 00 00 fc ff df e8 b8 4e f9 fd 49 8d 6e 60 49 89 ec 49 c1 ec 03 <41> 80 3c 1c 00 74 08 48 89 ef e8 7e 04 52 fe 4c 8b 7d 00 49 8d 9f
RSP: 0018:ffffc90003dcf438 EFLAGS: 00010206
RAX: ffffffff8392b4f8 RBX: dffffc0000000000 RCX: ffff888020f01dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000060 R08: 0000000000000000 R09: ffffffff838ef2c7
R10: 0000000000000003 R11: ffff888020f01dc0 R12: 000000000000000c
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88814c43c300
FS:  0000555555a85300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005609e4054978 CR3: 0000000079cdb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 24 10             	rex.WR and $0x10,%al
   3:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
   8:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
   d:	49 89 fe             	mov    %rdi,%r14
  10:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  17:	fc ff df
  1a:	e8 b8 4e f9 fd       	callq  0xfdf94ed7
  1f:	49 8d 6e 60          	lea    0x60(%r14),%rbp
  23:	49 89 ec             	mov    %rbp,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	41 80 3c 1c 00       	cmpb   $0x0,(%r12,%rbx,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 7e 04 52 fe       	callq  0xfe5204b7
  39:	4c 8b 7d 00          	mov    0x0(%rbp),%r15
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	9f                   	lahf


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
