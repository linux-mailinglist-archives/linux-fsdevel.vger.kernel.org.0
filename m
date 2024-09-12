Return-Path: <linux-fsdevel+bounces-29180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1A976C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF40285C2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D41B9852;
	Thu, 12 Sep 2024 14:43:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C51B12FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152203; cv=none; b=QD+PLuZ+hTALtBzFWOd5xSVW2MI2WsfQprECEsWa5L8iqswznlQb0llb0oJsihjW8Vll3lsK9WU8aytFJOb8m3xoaCEI/cbuJ5O85EvDC0nlHUMaS/BGEvfHSf7qgue7iNREwCUXJtDQ4Lt4pZi2zw4v+wvrN+yBPC2nJJ+8fU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152203; c=relaxed/simple;
	bh=44HZROY6hkUjMrwzO00wKvZQN6SjPK5W+mybUxobiB0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o109EVrNQfZ+pdpTSYw4tQsIcIJeXDhr7qaSDE7/sL469w+Dc9M2jD96uAEf68Ze+ENJcK4YlNS/VqXlHP05UUq2N00YjDQt8KZj3GpA8oIM6g2yHMzzlTrpS29iS42n1SRtocUJs3NogoeACd04TYYdvGLQJtY+JSJutKQwyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ce11bc50eso132864239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 07:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152201; x=1726757001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+GkpxlEVk7Mj41pa+W5MVk69nYLgtiVnFQHtDPlt0=;
        b=D6nlcS26queYI1yQBL7wzXCmFV8vYQK6mKp+AFQl0GoJGr0a8BMrCmOtfTgy93GhiB
         ipX0n2tT8IPuagTmLy3DNgY7iFyZT+FK5eRgT+DlYqSfJY6n4Jds4kEKyCFHxhILab+j
         ZGb6Y8NHOPMTI1FtFYr5bjxhs9E7E/OWI+yKOm+zLsuVqhUstaazdifoq0P1AfC2kN8l
         gjArh1tDfbe+hCpUcd1OrUl2+oKsz8PIKJd7eSgUsHXHSpCiSJtQy5skvv5SY6jPBMXF
         Z9I45O+F6z3m1KMM2IT196QOS4VWGx/6+CJ0nUruHjrBxfuRzS1HHnXKyco/uRCzHrPS
         DayQ==
X-Gm-Message-State: AOJu0Yz75JqUOZ0oT/sxSRAYePAJMx4xihm1mvUt1wG6caFfiQluBBfy
	wn5x7m4tNlxgp3SnOrQr4GjlBxmSgVC72tvu5MMgTEgzJqnJOUeqVtKWGKCHHAVuwpmCuly4Q1L
	L7xbMp15FWejoqUNbJIzMguRT+JfK/qVtmMz3bKyCXx0QQR39G3kF41M=
X-Google-Smtp-Source: AGHT+IH97IoXQLzlQcGm+nbcLb02E7mifpDJBoHBIkOLOsVm3EGLbq3ZGrIMm0VJb40L/AexNZevqcls3ExKpuwpBjpRGBigDijL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cb:b0:82c:d744:2936 with SMTP id
 ca18e2360f4ac-82d1f80b5demr410511239f.0.1726152201338; Thu, 12 Sep 2024
 07:43:21 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca18210621ed20e6@google.com>
Subject: [syzbot] [fuse?] linux-next test error: general protection fault in fuse_get_req
From: syzbot <syzbot+20c7e20cc8f5296dca12@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, miklos@szeredi.hu, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    57f962b956f1 Add linux-next specific files for 20240912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1575b100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe5de8661687e85
dashboard link: https://syzkaller.appspot.com/bug?extid=20c7e20cc8f5296dca12
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/545b0277a56b/disk-57f962b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a78e0824c78/vmlinux-57f962b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ea0ed7e55f3/bzImage-57f962b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20c7e20cc8f5296dca12@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 5438 Comm: syz.1.200 Not tainted 6.11.0-rc7-next-20240912-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:fuse_get_req+0x699/0xd40 fs/fuse/dev.c:151
Code: 24 50 48 83 c3 08 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 f5 d0 e9 fe 48 8b 1b 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 d8 d0 e9 fe 48 8b 1b 81 e3 00 20
RSP: 0018:ffffc90003fef4c0 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffffffff83149a52
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888027181030
RBP: ffffc90003fef5e8 R08: ffff888027181037 R09: 1ffff11004e30206
R10: dffffc0000000000 R11: ffffed1004e30207 R12: ffff888027181000
R13: dffffc0000000000 R14: ffff88807b835840 R15: ffff888027181000
FS:  000055556da20500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff9fa307040 CR3: 0000000079296000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_simple_background+0x9d/0xb10 fs/fuse/dev.c:622
 cuse_send_init fs/fuse/cuse.c:469 [inline]
 cuse_channel_open+0x447/0x670 fs/fuse/cuse.c:526
 misc_open+0x2cc/0x340 drivers/char/misc.c:165
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2cb5/0x3b40 fs/namei.c:3942
 do_filp_open+0x235/0x490 fs/namei.c:3969
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9fa37def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbadbdaa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ff9fa535f80 RCX: 00007ff9fa37def9
RDX: 0000000000000002 RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007ff9fa3f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff9fa535f80 R14: 00007ff9fa535f80 R15: 0000000000000b44
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fuse_get_req+0x699/0xd40 fs/fuse/dev.c:151
Code: 24 50 48 83 c3 08 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 f5 d0 e9 fe 48 8b 1b 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 d8 d0 e9 fe 48 8b 1b 81 e3 00 20
RSP: 0018:ffffc90003fef4c0 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffffffff83149a52
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888027181030
RBP: ffffc90003fef5e8 R08: ffff888027181037 R09: 1ffff11004e30206
R10: dffffc0000000000 R11: ffffed1004e30207 R12: ffff888027181000
R13: dffffc0000000000 R14: ffff88807b835840 R15: ffff888027181000
FS:  000055556da20500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e8d04790b8 CR3: 0000000079296000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 50                	and    $0x50,%al
   2:	48 83 c3 08          	add    $0x8,%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 f5 d0 e9 fe       	call   0xfee9d111
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 58          	add    $0x58,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 d8 d0 e9 fe       	call   0xfee9d111
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	81                   	.byte 0x81
  3d:	e3 00                	jrcxz  0x3f
  3f:	20                   	.byte 0x20


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

