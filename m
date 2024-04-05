Return-Path: <linux-fsdevel+bounces-16144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B46B899343
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BE11C21C54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B417571;
	Fri,  5 Apr 2024 02:43:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBB168B7
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285015; cv=none; b=tlL2sQsP+3bkmP/4LOSku5g2IXf/5bKXXTB4tfRY3lmJKhoNW6QI0+zBIcwa5ph3pUTtD7xtlS8ggxnOr0mxABq00sJ4B2YvgXkYH4PF4QZyXAvtVZpV6rWbp2T29yGpOvGNDlaaFxo8Fn2fM6zJlcm+9xpeoAjmU68K+rXeHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285015; c=relaxed/simple;
	bh=eAPnINuulwva4/WG+mAw8dx+PfgjHUwBTcHaTHqnwlI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JWOgjl+6ri6/blSUF7+QWv73Ew14tYIK9jRBspUwE/ph9fxv2/bT58tEOGmMAbHvYW9r3cxVSR70oBPzfrVUPs/dhNw8M3BJDRnqx5jjmfejhlGuj7xpkJps9y/pT1WZ7+mSV7uR2rLz1WiCg7PtplicOGFNYXdZtHuKKVfBAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so187658739f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 19:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285013; x=1712889813;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWzCF7oLLz2o8r549zshwntVI6I7m8Wr8tld17xYk5c=;
        b=daW12VV8uV0EkD16J21Fub0Hgoo6N2P5luSQbRF2/uJ0SekaBe3KCKiJxG7JpMiaDA
         0W89kIxw3DXecDlrIoSp/rFnyFayT+8efp5z53zIt7kxFx50if5YKppiCsMUFQkR75cz
         TZ9ZZOYrukbooDFZb1AX0oNsMnQebtBYlpNE4hnuUHGmdp59ketFVt9CwVZUtnMM/7Ad
         IvBF4ADtgZKVVzEYyschtEW63RUj6JS6ZBcO/syiBtOfB7pEF+6qCjqDzQfxVMAejTyl
         RpR1TnfSNJUnn92IoSY/uSxT0YKjhDG8DNfGxchl6c4EyUMDID0J2kEvxQ5aIEETtiTb
         BuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEnIicDLv2AQ/rhy/ijyyVr7hHvpshm6zECDQwtIcqA/i0UMuxLDCq1aZF3V32YTag6f2jLkA6hMERINrp0YjbjvWDJAPwtL4MdbuRPw==
X-Gm-Message-State: AOJu0Yx7k1IzqT6u7gbLwNuYeHilcyNmJqga0/jk8SPxBRtFqgtxXzlp
	vliZXagMGTRstCGENDOkZoj1Zgo/bL42jA9y+8kXdqw3oaIF8Xs6/CK4PDhkvf+C2FZwI6d7Xou
	xtt8+86/EJiEvDVXuSY+j7tB9Y7QELAtYggdq5V3BkaSPkOQ+BgAr8cE=
X-Google-Smtp-Source: AGHT+IEmugyoL4Q2wlslLEKgKm8uc6/OAU+oX6OjsJ7Jf5wcT6vkI7I+jowp+riAj8MPNOYunbZ00Cfsl93cgkAZqrUTauqOhuC/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:489:b0:7d0:ad03:af10 with SMTP id
 y9-20020a056602048900b007d0ad03af10mr4579iov.1.1712285012980; Thu, 04 Apr
 2024 19:43:32 -0700 (PDT)
Date: Thu, 04 Apr 2024 19:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f40f0c0615506b93@google.com>
Subject: [syzbot] [netfs?] divide error in netfs_submit_writethrough
From: syzbot <syzbot+f3a09670f3d2a55b89b2@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133bffe6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c2c72b264636e25
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a09670f3d2a55b89b2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-39cd87c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e28c9b1ddc4/vmlinux-39cd87c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17cff5c46535/bzImage-39cd87c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3a09670f3d2a55b89b2@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 7215 Comm: syz-executor.1 Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:netfs_submit_writethrough+0x201/0x280 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 0f af e9 e9 1d ff ff ff e8 6b 1c b9 ff eb df
RSP: 0018:ffffc90001f1f740 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff88801fd08c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82317e29 RDI: ffff88801fd08d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880545c2920 R14: ffff88801fd08d20 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c400000(0063) knlGS:00000000f5ecab40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000053f7e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_advance_writethrough+0x13f/0x170 fs/netfs/output.c:449
 netfs_perform_write+0x1b9f/0x26b0 fs/netfs/buffered_write.c:385
 netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write.c:454
 netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:493
 v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
 call_write_iter include/linux/fs.h:2108 [inline]
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_pwritev+0x1b2/0x260 fs/read_write.c:1072
 __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
 __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
 __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7f/0x89
RIP: 0023:0xf72d0579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5eca5ac EFLAGS: 00000292 ORIG_RAX: 000000000000017b
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 0000000020000780
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000016 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_submit_writethrough+0x201/0x280 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 0f af e9 e9 1d ff ff ff e8 6b 1c b9 ff eb df
RSP: 0018:ffffc90001f1f740 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff88801fd08c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82317e29 RDI: ffff88801fd08d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880545c2920 R14: ffff88801fd08d20 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c400000(0063) knlGS:00000000f5ecab40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000053f7e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   c:	48 89 f8             	mov    %rdi,%rax
   f:	83 e0 07             	and    $0x7,%eax
  12:	83 c0 03             	add    $0x3,%eax
  15:	38 d0                	cmp    %dl,%al
  17:	7c 04                	jl     0x1d
  19:	84 d2                	test   %dl,%dl
  1b:	75 1a                	jne    0x37
  1d:	8b 8b 0c 01 00 00    	mov    0x10c(%rbx),%ecx
  23:	48 89 e8             	mov    %rbp,%rax
  26:	31 d2                	xor    %edx,%edx
* 28:	48 f7 f1             	div    %rcx <-- trapping instruction
  2b:	48 89 c5             	mov    %rax,%rbp
  2e:	48 0f af e9          	imul   %rcx,%rbp
  32:	e9 1d ff ff ff       	jmp    0xffffff54
  37:	e8 6b 1c b9 ff       	call   0xffb91ca7
  3c:	eb df                	jmp    0x1d


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

