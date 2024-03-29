Return-Path: <linux-fsdevel+bounces-15665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306938914A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 08:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536A81C23097
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75FF446A5;
	Fri, 29 Mar 2024 07:57:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCE43172
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699040; cv=none; b=jvvf6ex0xRcD5iioXOHdZxCw2JWtJhTW7vRwsVSAno/x0uCPvUshNe0AOODkxjsfx6SaYn5gz52zrYptnL+HctmLLmkyutEjPo7qVpWzZJMM4aDekWcbWlLd5H//rdQC5+yQhFfFaBkBITfe2SZW5mbGlRTEmd2EbNVbtPQ+0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699040; c=relaxed/simple;
	bh=yJ9Q36JEeTiONFx+V5+CpW2y6vrWk0suk3Y3qj5fCGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NpMJ4PF3U5bfdA39mmxREWKzkD5LA4tND02H87jJcY3urcCl/ZGe/uIVhLrzQClOEr5S7IGhd3bSJ2Bv2U6pWzw9ricvFwaRRWHgY/Es/9FRM/ZRg8nUYs5l6XTepmylUma8xE4AF1Vl9232IGzVuq8yhgc6qmwf21R1aRs7t6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso183160839f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 00:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711699038; x=1712303838;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcc+dTHZlCpOWcs3ADhgDTmpiFe6wMX6YbcA68N9nxQ=;
        b=lI+abzUiWpXVvgQTKlDrlp51s+/OZLo8SQg2SfyPvy0osSFFMyRS7jowwSt1I70f9t
         M2ez/1cIBy8zlCfNySeWrQQmA2Qa2gQ+7BILIlgDTYj+zx70qBr6ncN0B4LGS9lYCVjA
         GwjhG4ALnKkcSkosGKzvckJS7YcsgSijsNxSEaCcKI7tbbJdP1VBe1bnseByuk32AJ/1
         8fXzwjYVwbIlH1r7646VwDQa8vaeAcIUR3E6CddneenA+b1a35hDBYiZv3amnbkMT8Wz
         No6m8dbAOVD9pBJx74+l4Ho3yAdBYKHzoW1vQ4sRVhXIfl6R41rg0Icb6mTNwKd2CvIm
         IGVA==
X-Forwarded-Encrypted: i=1; AJvYcCVjiPX8mTzQOhURXefWaeZY+S3dapN7ZTxBMPnOH4pFlBVmnlMRXw7Txr6fm+hEKoOjnPUM8U1uWax/0PqETM2iwKI0E6jJU+Oq7XkmSQ==
X-Gm-Message-State: AOJu0Yxwwx2OY5pAw/lshKiOmGYm/Pvk9KoYcHOenB4ycNVKEKlJKtiT
	Y7j98jabv5u405QuTPwnSlmhRL98fXrKNJ7eVifYwSr/scqRgdMh6l0NKCjilP7T/gYnzkTvDrN
	IvWqhOz+QNlextVkjV7NXAH8VLBkV7WU+BFLPb2hoNsKNQg9jM/cd5BM=
X-Google-Smtp-Source: AGHT+IGw385SZZ3tCXwYKqG3ZigUT2bvZPDG2amKZHP7NO3/5xIdJFORFxby6Nz6CBwma0Oha7OnvhJsZlT5o064D5VK4o8reozj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c90:b0:7cc:8980:5ae4 with SMTP id
 i16-20020a0566022c9000b007cc89805ae4mr53406iow.2.1711699038231; Fri, 29 Mar
 2024 00:57:18 -0700 (PDT)
Date: Fri, 29 Mar 2024 00:57:18 -0700
In-Reply-To: <000000000000a12738061144f9d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022ef250614c7fd94@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in txEnd (2)
From: syzbot <syzbot+776b5fc6c99745aa7860@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157a3321180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=776b5fc6c99745aa7860
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623f5b1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d1129180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8dce556379ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+776b5fc6c99745aa7860@syzkaller.appspotmail.com

jfs_dirty_inode called on read-only volume
Is remount racy?
BUG at fs/jfs/jfs_txnmgr.c:528 assert(tblk->next == 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:528!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5253 Comm: syz-executor989 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:txEnd+0x583/0x5a0 fs/jfs/jfs_txnmgr.c:528
Code: e9 59 fb ff ff e8 bd 24 84 fe 48 c7 c1 40 a4 4a 8b ba 10 02 00 00 48 c7 c6 c0 9e 4a 8b 48 c7 c7 00 9f 4a 8b e8 5e f5 64 fe 90 <0f> 0b 48 89 ef e8 03 07 df fe e9 40 fd ff ff e8 c9 06 df fe e9 2e
RSP: 0018:ffffc90008cc7ab8 EFLAGS: 00010282
RAX: 0000000000000036 RBX: ffffc900025d1110 RCX: ffffffff816f2339
RDX: 0000000000000000 RSI: ffffffff816fab26 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffffff8dd43da0 R15: ffffc900025d1112
FS:  00007fc48c2826c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc484d0b000 CR3: 000000001511e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 add_missing_indices fs/jfs/jfs_dtree.c:2663 [inline]
 jfs_readdir+0x2952/0x4310 fs/jfs/jfs_dtree.c:3009
 wrap_directory_iterator+0xa8/0xe0 fs/readdir.c:67
 iterate_dir+0x295/0x9e0 fs/readdir.c:110
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents fs/readdir.c:311 [inline]
 __x64_sys_getdents+0x14f/0x2d0 fs/readdir.c:311
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc48c2f6c39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc48c282168 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fc48c37e6d8 RCX: 00007fc48c2f6c39
RDX: 0000000000001000 RSI: 0000000020006600 RDI: 0000000000000005
RBP: 00007fc48c37e6d0 R08: 00007fc48c2826c0 R09: 0000000000000000
R10: 00007fc48c2826c0 R11: 0000000000000246 R12: 00007fc48c37e6dc
R13: 000000000000006e R14: 00007ffdf1f02700 R15: 00007ffdf1f027e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txEnd+0x583/0x5a0 fs/jfs/jfs_txnmgr.c:528
Code: e9 59 fb ff ff e8 bd 24 84 fe 48 c7 c1 40 a4 4a 8b ba 10 02 00 00 48 c7 c6 c0 9e 4a 8b 48 c7 c7 00 9f 4a 8b e8 5e f5 64 fe 90 <0f> 0b 48 89 ef e8 03 07 df fe e9 40 fd ff ff e8 c9 06 df fe e9 2e
RSP: 0018:ffffc90008cc7ab8 EFLAGS: 00010282
RAX: 0000000000000036 RBX: ffffc900025d1110 RCX: ffffffff816f2339
RDX: 0000000000000000 RSI: ffffffff816fab26 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffffff8dd43da0 R15: ffffc900025d1112
FS:  00007fc48c2826c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc484d0b000 CR3: 000000001511e000 CR4: 0000000000350ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

