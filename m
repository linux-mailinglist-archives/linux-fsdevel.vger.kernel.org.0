Return-Path: <linux-fsdevel+bounces-18652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677E8BAF10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D72B211D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04A04643A;
	Fri,  3 May 2024 14:35:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FC8C1A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746938; cv=none; b=XynJ9oNx66QM4SGhjuEkjbLhvRPgXWlztH6mliR9WvOYExKFwtkjIoarl3k52DoBUZ9AjO42KQVSu4Z1sdskvZt0u/Gz73n6Ks5j6avpHMJm8Pp66Yb17YKVIKKB/qdcmWvVt8bFB4e4eS3hnOrNWyDNxLPXTk4knwtj8oN0kWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746938; c=relaxed/simple;
	bh=yK+HmaarnvnvCHkS1/wSzitkQqFqROclDtGthsi5u64=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hNC3wMTOvfligDPvxcv1kXvFJTAuui2QXAPG/W4DkYS6FsH0dwNY2KHjjvlrXT7s68lMOawHK9O8OYBqaV2Erl5YfZP9ABGPue6PwbejL+jQ3913zM5ltxmFdsXMGT5pk3LSiQjezm5vtiletX/LAWaLaB447/uZHSQnY5dAZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dda529a35cso1026874439f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746935; x=1715351735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Shds5y9GN65EnNnI1KXw4yFHWwuEW0+FXwBNWOytN00=;
        b=Vro1AWaieSaUlz+mDiuD9NiL45BX/YE8teQJYGqXiGk4FtyV91PSIeXxeLx2GEc97p
         uAAMVCTvJaCz+ACAqLdpdpg+HYLMxm5tZwFrMiH/RsJNH/54Cs9eprKL2DZMIywl1tSi
         G/i2ehOQlHbT+czpjOeUB1tgzTRq6+B4RnvzkbKXyOx5zaUwDb/CY1ikQ+bhE7ycHCT7
         JG66f8KYJSlvt+MuxtNjVHnT0ioYXiddliRTzxjHUi1cLNKyfEAOZFWCVdy2zu0v9j5f
         89LrlZIG/AUyfE5u7zl1CZDG8vTIg3C5JLC90ccLOTYO6ECwa0aK0H1UzzMgI9Ra9UvZ
         PA+g==
X-Forwarded-Encrypted: i=1; AJvYcCUo5CB7fVJ8U1sHPQHvsQVoIaYWMoynR7c2ddBfU80RuOWnAKDr+nGyGRFUIkWHuKkLDGB7jBL5dfQatMXx1OFNYA3e/K0AsA8en4Bl1Q==
X-Gm-Message-State: AOJu0Yw5NocbeETArCYxRZMfcwF3A8bRCaVVJktZuRKvcUYap7Y8OhRV
	KGDMXVozX6g4DAOx1n44oppyi2rXX1n3qtoElaLw7ZLk+00+J8jCXwk/VqOdfxaDBFhIr3WMbl/
	FZOdiYRbGLt0XQM1nwC45c26Y/4gkv1c6JBHJ08U+AniPiifD8ghja8I=
X-Google-Smtp-Source: AGHT+IE3CXYHa1nNsyaOt+NVNE7Hzve+xg0r8cdEmnh0+OC87j8rNRSO8IqjLoRZuVErIo6E8xiFr1F54lEtzHNUkL3ke353gmkk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c9:b0:487:cc0:9c05 with SMTP id
 n9-20020a05663831c900b004870cc09c05mr100463jav.2.1714746935428; Fri, 03 May
 2024 07:35:35 -0700 (PDT)
Date: Fri, 03 May 2024 07:35:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f75b4906178da124@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_read_done
From: syzbot <syzbot+bf7215c0525098e7747a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1582ab54980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=bf7215c0525098e7747a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf7215c0525098e7747a@syzkaller.appspotmail.com

bcachefs (loop2): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=crc64,data_checksum=none,nojournal_transaction_names
bcachefs (loop2): recovering from clean shutdown, journal seq 10
------------[ cut here ]------------
kernel BUG at fs/bcachefs/backpointers.h:75!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 10734 Comm: syz-executor.2 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:bucket_pos_to_bp fs/bcachefs/backpointers.h:75 [inline]
RIP: 0010:bch2_backpointer_invalid+0x9cc/0x9d0 fs/bcachefs/backpointers.c:65
Code: fc ff ff e8 f6 19 8d fd 48 c7 c7 40 7f 91 8e 48 89 de e8 87 e9 e2 00 e9 fc f7 ff ff e8 dd 19 8d fd 90 0f 0b e8 d5 19 8d fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 53 e8
RSP: 0018:ffffc900040f6600 EFLAGS: 00010246
RAX: ffffffff8408fc0b RBX: 00000000002d3cb6 RCX: 0000000000040000
RDX: ffffc9000b24a000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000b4f2d90000 R08: ffffffff8408f5aa R09: 1ffffffff25f54b0
R10: dffffc0000000000 R11: fffffbfff25f54b1 R12: 1ffff9200081ed58
R13: ffffc900040f6aa0 R14: ffff8880533a00bb R15: 000000000000001b
FS:  00007fa2e10d16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001100 CR3: 0000000017ee0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_node_read_done+0x3e7d/0x5ed0 fs/bcachefs/btree_io.c:1234
 btree_node_read_work+0x665/0x1300 fs/bcachefs/btree_io.c:1345
 bch2_btree_node_read+0x2637/0x2c80 fs/bcachefs/btree_io.c:1730
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1793
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:472
 bch2_fs_recovery+0x2334/0x36e0 fs/bcachefs/recovery.c:800
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1030
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2105
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2e027f42a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2e10d0ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa2e10d0f80 RCX: 00007fa2e027f42a
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007fa2e10d0f40
RBP: 0000000020011a00 R08: 00007fa2e10d0f80 R09: 0000000002000000
R10: 0000000002000000 R11: 0000000000000202 R12: 0000000020011a40
R13: 00007fa2e10d0f40 R14: 00000000000119fd R15: 00000000200000c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bucket_pos_to_bp fs/bcachefs/backpointers.h:75 [inline]
RIP: 0010:bch2_backpointer_invalid+0x9cc/0x9d0 fs/bcachefs/backpointers.c:65
Code: fc ff ff e8 f6 19 8d fd 48 c7 c7 40 7f 91 8e 48 89 de e8 87 e9 e2 00 e9 fc f7 ff ff e8 dd 19 8d fd 90 0f 0b e8 d5 19 8d fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 53 e8
RSP: 0018:ffffc900040f6600 EFLAGS: 00010246
RAX: ffffffff8408fc0b RBX: 00000000002d3cb6 RCX: 0000000000040000
RDX: ffffc9000b24a000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000b4f2d90000 R08: ffffffff8408f5aa R09: 1ffffffff25f54b0
R10: dffffc0000000000 R11: fffffbfff25f54b1 R12: 1ffff9200081ed58
R13: ffffc900040f6aa0 R14: ffff8880533a00bb R15: 000000000000001b
FS:  00007fa2e10d16c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb51ae7fc00 CR3: 0000000017ee0000 CR4: 00000000003506f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

