Return-Path: <linux-fsdevel+bounces-24033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA04937E72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 02:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77752281914
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170FE257B;
	Sat, 20 Jul 2024 00:16:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA10E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434584; cv=none; b=XrFmXH6C5Br9NzAqJmOsRC7dYDlRbxQxa5SN1A5GrmsSX1KTfwxodlbplk6YTe5uYv+OeAINYJ49+Ai0tCGH1BOyLFMDD5YS49sisnIrGB3DxT39inm3BNSg2ugG4qlVAO2c2YBHQ2DKjN4icCK7GD8AKu35wb4HBchWx3Gj0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434584; c=relaxed/simple;
	bh=yFfE89JWHCRn5Pg/GYd/oTSbs92w+tBYWZ59G+0LYEA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R3qVAdDcedliRvWjkfTJqH9QQaxerZTeJng4V346MNyqDMwaXt9xEo4c1PSB/P5LwwB5b8Lne0ZsRRu8p0u/Dhqdfx1VPRHkHUSK3v7KRGVtWK+ZrFQUqjcMnu+txx4oobmxO17AfyGTbFvQx3eebG3cb7hWNpdmxP+AVK3HwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8036e96f0caso350119739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 17:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721434582; x=1722039382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3f8fiUb/1e0isq2qYD5vOSUdPdevzcO7aUauU++Wsg=;
        b=gL7IwofYD1hv+JCQrSRjYKT395U4p5nO3CjkQtFvvSO1xQqYtgTnjbDSfIVk4uwOGt
         0c69KtFwGlBDC08So7ozUf1MiEd7/7sPU4xi6khL492gRUgiMH9TscYVb+sgSfGDDg54
         A/J3b2YU3nWnJxI+Oq58isY0r55Uvsuxjm8PB2I2yKGiW5keRmdlnJZjVS6zP5woKToD
         8gr/84whE14/S77MC6VFUrYcutvo0Cd4MmYn2fXy8y+u4vmi6xpzNwIlbXzckQTM38wM
         GE/T5bqeXlOwlGbULGxiWSbVfkYk8F6RDywtqQ/R5doNuxVGgEuvEhzVEoHiejGM5q6P
         JOYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Y/mB6TVmt5dgM9m7N8y+I08qHMoXeMVW/XTJ5k48eO/XglzeT+AOF6TQ1XDjCoH55D+6v31bqmguVHhNThjuVpp3eWib+XGBxLa5Ww==
X-Gm-Message-State: AOJu0YxTF+Y/amcEn+IEAEpo42X1DJzF+qkglavqKNCbDc3yvVNzei3Q
	rb7TPxPYPKOibpklEuNMlwV5XRJJE+VcMYVaeXmg8GLUGW5UO+AdooVyVGihwRxnoktKofiOtn5
	PBhntesUVtYn+oYDyLjcJFHL47AzTWJi+sUpb9uCBjB+7k3K9TFUlERg=
X-Google-Smtp-Source: AGHT+IEhVky9gVVBl4vehk6StGC4USpYibqa4QqoBDdnT0yWEFWMLvfyvxi1KujjOZzF/iezaHnx1iyL5dw7o2ZUHLeKPBk/63Sh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8522:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4c23fc73789mr67570173.1.1721434582238; Fri, 19 Jul 2024
 17:16:22 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:16:22 -0700
In-Reply-To: <000000000000a8bd7b060f8ce57d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c758e1061da2b880@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in diRead (2)
From: syzbot <syzbot+8f731999dc47797f064f@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samsun1006219@gmail.com, shaggy@kernel.org, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4305ca0087dd Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=119980b1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfaf0ab1b18403fe
dashboard link: https://syzkaller.appspot.com/bug?extid=8f731999dc47797f064f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d09349980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1748fa5e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd4bd188fcdc/disk-4305ca00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d60a35331483/vmlinux-4305ca00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a5740b15da1/bzImage-4305ca00.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fb21716fe5a7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f731999dc47797f064f@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff9841c06c
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fff9841c0b0
 </TASK>
read_mapping_page failed!
jfs_mount_rw: diMount failed!
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000104: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000820-0x0000000000000827]
CPU: 0 PID: 5094 Comm: syz-executor169 Not tainted 6.10.0-syzkaller-09061-g4305ca0087dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:diIAGRead fs/jfs/jfs_imap.c:2662 [inline]
RIP: 0010:diRead+0x158/0xae0 fs/jfs/jfs_imap.c:316
Code: 8d 5d 80 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 a9 e5 d7 fe 4c 8b 2b 49 8d 9d 20 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 89 e5 d7 fe 4c 8b 3b 49 8d 5f 28
RSP: 0018:ffffc900020bf738 EFLAGS: 00010202
RAX: 0000000000000104 RBX: 0000000000000820 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffff88805a2bcdf0 R08: ffff88805a2bca97 R09: 1ffff1100b457952
R10: dffffc0000000000 R11: ffffed100b457953 R12: 0000000000000004
R13: 0000000000000000 R14: ffff88805a2bca88 R15: dffffc0000000000
FS:  00005555843c1380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13f837b0f8 CR3: 000000005a8e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_iget+0x8c/0x3b0 fs/jfs/inode.c:35
 jfs_lookup+0x226/0x410 fs/jfs/namei.c:1469
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1718
 lookup_slow+0x53/0x70 fs/namei.c:1735
 walk_component+0x2e1/0x410 fs/namei.c:2039
 lookup_last fs/namei.c:2542 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2566
 filename_lookup+0x256/0x610 fs/namei.c:2595
 user_path_at+0x3a/0x60 fs/namei.c:3002
 do_mount fs/namespace.c:3809 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x297/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13f8304bd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9841c048 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff9841c070 RCX: 00007f13f8304bd9
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff9841c090
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff9841c06c
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fff9841c0b0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:diIAGRead fs/jfs/jfs_imap.c:2662 [inline]
RIP: 0010:diRead+0x158/0xae0 fs/jfs/jfs_imap.c:316
Code: 8d 5d 80 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 a9 e5 d7 fe 4c 8b 2b 49 8d 9d 20 08 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 89 e5 d7 fe 4c 8b 3b 49 8d 5f 28
RSP: 0018:ffffc900020bf738 EFLAGS: 00010202
RAX: 0000000000000104 RBX: 0000000000000820 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffff88805a2bcdf0 R08: ffff88805a2bca97 R09: 1ffff1100b457952
R10: dffffc0000000000 R11: ffffed100b457953 R12: 0000000000000004
R13: 0000000000000000 R14: ffff88805a2bca88 R15: dffffc0000000000
FS:  00005555843c1380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13f837b0f8 CR3: 000000005a8e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 5d 80             	lea    -0x80(%rbp),%ebx
   3:	48 89 d8             	mov    %rbx,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 a9 e5 d7 fe       	call   0xfed7e5c2
  19:	4c 8b 2b             	mov    (%rbx),%r13
  1c:	49 8d 9d 20 08 00 00 	lea    0x820(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 89 e5 d7 fe       	call   0xfed7e5c2
  39:	4c 8b 3b             	mov    (%rbx),%r15
  3c:	49 8d 5f 28          	lea    0x28(%r15),%rbx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

