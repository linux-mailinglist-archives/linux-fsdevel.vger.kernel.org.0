Return-Path: <linux-fsdevel+bounces-8074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FB82F249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA481C2353A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31A1C6B4;
	Tue, 16 Jan 2024 16:19:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4751C6A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-360a416bb22so61100625ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 08:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421958; x=1706026758;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx2NiXfEC2f9ShTuPE2ICSF2WxhDPgmMA0aZZzN7CeY=;
        b=Y1VitscZHI0dLEDag/KLcXfD4AHnXdTSktlS2rwHy0cRzU/xr9Vx1YUCKesSucXfD7
         FinZhkY97zFo7CFvRpt+f23letcuiceI8fwlGIvLYTNK5YMpfo74so1/J/tVWG9kCLMy
         ODaM5Hs/782fsQNFWvqkaxWfdAhLkb7CvhYfTmN2iK+oAlRMbKOrGIBEXvf8fDAGm098
         hJWr8JNrsXEqpdUhKJsgo60gTGemHLgh9ffqS99MJDr953qknOTUB6yrth/xi9Og18F4
         GHOTpgHY0rGfSfTUFeWWxoxWDEIbV01p+BPcUfhXFm0V8rIKGVm2RbAS5mJpyZby//Dv
         1UAg==
X-Gm-Message-State: AOJu0YwRkP+PAz72n5AlhJAAqFubywyE5oo44S+LW5RzuPYLhmW+5cX1
	BwzejKQatPQI3T5Capzq3LUl68MNKR3o+ZDU56cRbiycNtW9
X-Google-Smtp-Source: AGHT+IGPXIwfcx+ZEzWEl/c87WEvLS1rOC2xBs8/tlG/IpXlFdlUU8PqTyvIuo3HXMRs9HjU3v5toRNTOexomQETgrSp6qHTErtk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:361:9322:6ae0 with SMTP id
 l10-20020a056e0212ea00b0036193226ae0mr27848iln.6.1705421958506; Tue, 16 Jan
 2024 08:19:18 -0800 (PST)
Date: Tue, 16 Jan 2024 08:19:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007728e060f127eaf@google.com>
Subject: [syzbot] [exfat?] kernel BUG in iov_iter_revert
From: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=108ca8b3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558210be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d39debe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1b0ffd73481/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c25614b900ba/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dd1842e2ad4/bzImage-052d5343.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/291ad1624ec1/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/iov_iter.c:582!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5043 Comm: syz-executor166 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:iov_iter_revert lib/iov_iter.c:582 [inline]
RIP: 0010:iov_iter_revert+0x328/0x360 lib/iov_iter.c:567
Code: 8e 94 78 fd e9 8f fd ff ff e8 e4 94 78 fd e9 de fe ff ff e8 ba 94 78 fd eb a2 e8 d3 94 78 fd e9 12 fe ff ff e8 b9 8c 21 fd 90 <0f> 0b e8 c1 94 78 fd e9 23 fe ff ff e8 b7 94 78 fd e9 64 fe ff ff
RSP: 0018:ffffc9000337f9e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000001bca00 RCX: ffffffff84656a77
RDX: ffff888019313b80 RSI: ffffffff84656c97 RDI: 0000000000000001
RBP: ffffc9000337fb30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: fffffffffffffdef R14: 0000000000000000 R15: ffff888047da8740
FS:  0000555555c9a380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056518e8170a8 CR3: 0000000048309000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exfat_direct_IO+0x320/0x510 fs/exfat/inode.c:538
 generic_file_read_iter+0x1dd/0x450 mm/filemap.c:2759
 call_read_iter include/linux/fs.h:2079 [inline]
 aio_read+0x318/0x4d0 fs/aio.c:1597
 __io_submit_one fs/aio.c:1998 [inline]
 io_submit_one+0x1480/0x1de0 fs/aio.c:2047
 __do_sys_io_submit fs/aio.c:2106 [inline]
 __se_sys_io_submit fs/aio.c:2076 [inline]
 __x64_sys_io_submit+0x1c3/0x350 fs/aio.c:2076
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6eb9491c79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb9c8bf78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007ffdb9c8bf80 RCX: 00007f6eb9491c79
RDX: 0000000020000540 RSI: 0000000000003f0a RDI: 00007f6eb944a000
RBP: 00007f6eb9506610 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdb9c8c1b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iov_iter_revert lib/iov_iter.c:582 [inline]
RIP: 0010:iov_iter_revert+0x328/0x360 lib/iov_iter.c:567
Code: 8e 94 78 fd e9 8f fd ff ff e8 e4 94 78 fd e9 de fe ff ff e8 ba 94 78 fd eb a2 e8 d3 94 78 fd e9 12 fe ff ff e8 b9 8c 21 fd 90 <0f> 0b e8 c1 94 78 fd e9 23 fe ff ff e8 b7 94 78 fd e9 64 fe ff ff
RSP: 0018:ffffc9000337f9e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000001bca00 RCX: ffffffff84656a77
RDX: ffff888019313b80 RSI: ffffffff84656c97 RDI: 0000000000000001
RBP: ffffc9000337fb30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: fffffffffffffdef R14: 0000000000000000 R15: ffff888047da8740
FS:  0000555555c9a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6eb944a000 CR3: 0000000048309000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

