Return-Path: <linux-fsdevel+bounces-8348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D025C8331B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 01:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419141F2315A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D01624;
	Sat, 20 Jan 2024 00:10:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB7381
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jan 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709430; cv=none; b=Nui5piSkdJvX/NBHy/wiEzFB3BzDW0Mt0w6kCoYD+8XkozBMyMULhNentzJgP3SLcijM+zyhKSfi5hFgagd5mfWZbY6gazTOkKPwfACAXcArZjWb4Jb94DEd268D+Ekkt7TzDuQTh/iq+Q0m+NFi8x4lY2Dh26Se9ch8DgIosxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709430; c=relaxed/simple;
	bh=TpjuO+9hturNxfceTgvrYXC0vPl+mUZKkcYoB4KY7qE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NI2Z9JwAl+in3LwgSUh+ACtHDMxWFS+FZrViMHn5aMOKVnyg/i8bXGfqL/a8TLI0dZtDb4+XYnqBs5qgiutWlU4VIyz5IhKzTSB23eAXYp9K8WS44glbD0moUhxtGQZXZMmcTgVWj2nm8vBO2HmdKQB3ddpN8jyflQbH6P8WZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf8868dfc7so6294739f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 16:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705709427; x=1706314227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhkNMjQVOB5HvLrNxJgMnjKkdtuka8k8P2aFjXPVvzg=;
        b=wkqkOkMSzZIU2l5fUaagY/CHiKEbRa/rPc7IZguMSMuv02Hdkdmp3g7jhG1LFJPkgE
         cDPQ5M8HKGoBP5R4hb4ZNHblOb6gx1+X5iWyk+CvgZuY7ktyaP2KgZ8M2DEAbQJWkobo
         hGJIFV1L8dGsc+7A6aApjEEdmjEq0QoOCHcESUtT8/BopQEggkNHTbH67TqIxYNvU08V
         Gy1TXb71SrtaJOm8mIG5vc61RuUY9/9fAlF/I/EezT0haYEksp4PTrc24ocwuWmWK3on
         UtcWdNvNhwbHndzrGhLzXVkoYKHQHzJzhWmGoPbvxxXL4v4KVZD29OzQ06tF3NRlpsSk
         GJjw==
X-Gm-Message-State: AOJu0YxxJf1x3rzFUrpvS6cQtci+PySnaQNEBg7FZmYnwyxm1flOV2+X
	r5FrKvRuQsN2SrBXS6M5xXbp2+T1tRJcoVetgXYUSbLsplPtbJ/UrbxvSXMoY06pSglRtm5T6jP
	74fxv/60JcobwE3mV5N3FIAib9o1jJ7R0BkKilDzwO7KtmXkewNBSQS4=
X-Google-Smtp-Source: AGHT+IENlsaqQKmpztFNm40psPASW8ds8BZji2cekHi1ejZbY6Utl5GS1rYK1eLJPnwVvvZEsLuQGlmA+UtjdZMb0e2EtvWmmk+R
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:360:17a7:d897 with SMTP id
 f10-20020a056e020b4a00b0036017a7d897mr63312ilu.4.1705709427780; Fri, 19 Jan
 2024 16:10:27 -0800 (PST)
Date: Fri, 19 Jan 2024 16:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000887374060f556c07@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in qd_put (2)
From: syzbot <syzbot+43ad5525e32c939e3f22@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1262e4b5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=878a2a4af11180a7
dashboard link: https://syzkaller.appspot.com/bug?extid=43ad5525e32c939e3f22
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35f5d1189e2a/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0405012bdefc/bzImage-052d5343.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43ad5525e32c939e3f22@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:336!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 5207 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:qd_put+0x133/0x190 fs/gfs2/quota.c:336
Code: 43 70 00 00 00 00 48 8d 73 78 e8 38 46 19 fe 4c 89 e7 e8 f0 44 e1 06 5b 5d 41 5c 41 5d 41 5e e9 93 ab da fd e8 8e ab da fd 90 <0f> 0b e8 86 ab da fd 4c 89 e7 e8 6e 98 b7 00 4c 89 e7 e8 c6 44 e1
RSP: 0000:ffffc90003b87c38 EFLAGS: 00010293

RAX: 0000000000000000 RBX: ffff88804a1bc000 RCX: ffffffff83ad6445
RDX: ffff888023370000 RSI: ffffffff83ad6512 RDI: 0000000000000005
RBP: 00000000ffffff80 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff80 R11: 0000000000000000 R12: ffff88804a1bc030
R13: ffff88804a1bc070 R14: ffff888050da8a68 R15: ffff88801801e808
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:000000005748a400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007fd6a0c6a42d CR3: 0000000078e90000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_quota_sync+0x44b/0x630 fs/gfs2/quota.c:1373
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x109/0x280 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:625
 kill_block_super+0x3b/0x90 fs/super.c:1680
 gfs2_kill_sb+0x361/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 __do_fast_syscall_32+0x86/0x110 arch/x86/entry/common.c:324
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a
RIP: 0023:0xf7fbc579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffbf1df8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffbf1ea0 RCX: 000000000000000a
RDX: 00000000f7354ff4 RSI: 00000000f72a53bd RDI: 00000000ffbf2f44
RBP: 00000000ffbf1ea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qd_put+0x133/0x190 fs/gfs2/quota.c:336
Code: 43 70 00 00 00 00 48 8d 73 78 e8 38 46 19 fe 4c 89 e7 e8 f0 44 e1 06 5b 5d 41 5c 41 5d 41 5e e9 93 ab da fd e8 8e ab da fd 90 <0f> 0b e8 86 ab da fd 4c 89 e7 e8 6e 98 b7 00 4c 89 e7 e8 c6 44 e1
RSP: 0000:ffffc90003b87c38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88804a1bc000 RCX: ffffffff83ad6445
RDX: ffff888023370000 RSI: ffffffff83ad6512 RDI: 0000000000000005
RBP: 00000000ffffff80 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff80 R11: 0000000000000000 R12: ffff88804a1bc030
R13: ffff88804a1bc070 R14: ffff888050da8a68 R15: ffff88801801e808
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:000000005748a400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007fd6a0c6a42d CR3: 0000000078e90000 CR4: 0000000000350ef0
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

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

