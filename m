Return-Path: <linux-fsdevel+bounces-9047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3826183D6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A451F2B12E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D3604B9;
	Fri, 26 Jan 2024 09:05:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C760264
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259931; cv=none; b=HfdwZzSwad1m2jtOR2x96q6tfp4n4+ZxOnrEtzPMDexI75fg/djK4XEU9VvCI3h7l0l0aAlpFTuUKYSyIlN/2omVX6QHPtk4EC2bWO0jwJ3ANViEJlI4Scc6iREROi2q+88ij/c+a2M4M3s2NF8qSVFLByeOt/MZOm0bWAnLiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259931; c=relaxed/simple;
	bh=T9wpoH0F1cIP8eVCnBQyB/bvSH/l99a66hT/RBmiLG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O389zo94uKQgn60b5okwu9hvloZormcmA2/vYcpXHXfL6qB5lNeC22EM1g9+g/lGmWV+xW4wduHzE0TP6GlM8FJprQ1NDfx5xtPyc3Z3Ji6bGH9FUVD8KF5gWge313m88L76k0dLiBVmWom4RrbGiQsqjZj/IsRfgRJ4kt1w/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf4698825eso28701939f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259928; x=1706864728;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spc1ShxOmdgB1pC4pVuSbJpCr0hgxztE/zkQiLNA1BA=;
        b=bCIphzsSQTZZXrnZYCkDaOdXUjDejYIqug8TQfErTnGiLlICjAqn40LU5j2WjmaMhb
         MWIKsA1i3Mh8u22sKAsICTrDnSTdSeyYOgOz/ct0NBvmbN6lDbeAq6LDwAVPKOd3HkHP
         3JpGeJPd61zr4CDxVNQI7PnIfRAhIkicAVz1nQxSi54IwlmrVy1V966EgM9+wS+WPwm7
         +9aLBK0w43UC02XEnVMJ1i/sSJJ1w5JGHzw8h9J2mADumNChxLgJHu18MUZS9Wyv0QlF
         PH7jAzsLjBa7LCocqoBoaZd65RPDZylYFKYtszD6+7MmUhnX4xlILIhwFjEpHBrC/CXy
         +puw==
X-Gm-Message-State: AOJu0Yw4F5mZ1ZrpbakAfix164wmvAMHMoTAQO6YaYRgl098z6TS9PjW
	nDFXEJEVBOotMTs0Txw7nmkjoBnUjhWRj9foUdkOX55RVqNRnkbVay6n3xKoZB5SNXy5Ujd3B2W
	K0iGZHNu08a3Es/ckEKI/sfui8ma2PMshBwYrdO7Lt4ysSbyjvKoa+aM=
X-Google-Smtp-Source: AGHT+IHkbZUO6XeiPdqbgZ81JcfuzhhS+rfbSkGWl/OfSYFJsF50hYFc2QlOeN4HJWElFBahgMEfpsWHgH1d9zPXSqNXmaddU+mo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cacd:0:b0:46e:668b:58d7 with SMTP id
 f13-20020a02cacd000000b0046e668b58d7mr7716jap.0.1706259928470; Fri, 26 Jan
 2024 01:05:28 -0800 (PST)
Date: Fri, 26 Jan 2024 01:05:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee5c6c060fd59890@google.com>
Subject: [syzbot] [net?] [v9fs?] WARNING: refcount bug in p9_req_put (3)
From: syzbot <syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    4fbbed787267 Merge tag 'timers-core-2024-01-21' of git://g.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11bfbdc7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4059ab9bf06b6ce=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd99d2414db66171fc=
cbb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc=
7510fe41f/non_bootable_disk-4fbbed78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13a98041382d/vmlinux-=
4fbbed78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a02086862ee/bzI=
mage-4fbbed78.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+d99d2414db66171fccbb@syzkaller.appspotmail.com

9p: Unknown Cache mode or invalid value fsca=EF=BF=BDhe
9pnet: Tag 65535 still in use
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 30609 at lib/refcount.c:28 refcount_warn_saturate+0x14=
a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 PID: 30609 Comm: syz-executor.1 Not tainted 6.7.0-syzkaller-13004-g4=
fbbed787267 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16=
.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 e8 af 1e fd 84 db 0f 85 66 ff ff ff e8 ab b4 1e fd c6 05 =
1b 87 bb 0a 01 90 48 c7 c7 c0 70 2f 8b e8 97 a9 e4 fc 90 <0f> 0b 90 90 e9 4=
3 ff ff ff e8 88 b4 1e fd 0f b6 1d f6 86 bb 0a 31
RSP: 0018:ffffc9000345f9b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90006349000
RDX: 0000000000040000 RSI: ffffffff814e1906 RDI: 0000000000000001
RBP: ffff8880687d59a0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc9000345fa48
R13: ffff8880687d59a0 R14: ffff888026a9d800 R15: 1ffff9200068bf41
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7ff1b4=
0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020003000 CR3: 000000006eb7c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:304 [inline]
 refcount_dec_and_test include/linux/refcount.h:322 [inline]
 p9_req_put+0x1f0/0x250 net/9p/client.c:401
 p9_tag_cleanup net/9p/client.c:428 [inline]
 p9_client_destroy+0x226/0x480 net/9p/client.c:1073
 v9fs_session_init+0xba5/0x1a80 fs/9p/v9fs.c:490
 v9fs_mount+0xc6/0xcd0 fs/9p/vfs_super.c:123
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x370 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x291/0x310 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a
RIP: 0023:0xf7ff6579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 =
00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 9=
0 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7ff15ac EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000200001c0 RCX: 0000000020000480
RDX: 00000000200004c0 RSI: 0000000000000404 RDI: 0000000020001080
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
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

