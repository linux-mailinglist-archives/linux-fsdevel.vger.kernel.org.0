Return-Path: <linux-fsdevel+bounces-73275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD6D13EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66EC3075F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D399364EB1;
	Mon, 12 Jan 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="msspRuaG";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="pUulcpeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A53644CE;
	Mon, 12 Jan 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234563; cv=none; b=Oso6n+FupO+b9cQYV5AnQD5aUPAt86/v5RcGcRKZlNRt3eOoHKQC/JC2YPdhv4UfkMwypWY3zW+71bBPCdkSNsXbCwn5sWELN3nXJj0WgMj8d31QaRtVwuHhKpWe6qDgfb8nJTRI8qMUc/QxZeXyKpOO9308ll2WqPy1nPtJsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234563; c=relaxed/simple;
	bh=UUwbcd9pljhWagccODtrUPf4G8FrxcxWNQ5hb0Sxic8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RG1c77smRH/vUCqGiemKoGVrJ7MG7UBxiYJU7w3xLwZLKVrsHcHNA8ENy3pX/EMtStmbkY3LdsnwqhVukDDn+jDKY+EGj5XUT6jwCok1ClIWrt6kgak5ECdtaDgx835XgI3gFVULJ4AXHKStdf2rvQusD/iZYNp7CwJJCdQab8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=msspRuaG; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=pUulcpeT; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C836526F765C;
	Tue, 13 Jan 2026 01:15:52 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1768234553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwndc9EujYh/WaXIE4enjSxk6eMHUT68pNC0cC/u3Rg=;
	b=msspRuaGWlLFpOXTcrvkqdBKVbB1E3neamSpFkdAHCpyLPOtuF8EyjIzELmxj2/sVhERd6
	CuPKVEyH3Y59qrfw90bnoOGcpVSypUcZoNV1f4OHUGZ1W4AslNJ5YWx9ol90FIryXAQYZG
	ygOAGTUJzlXwnWQ3iRTDPFUUYdrMTAlA7vLvxvgmU96s3nNc76UwDp4z2ZklK9UTGYX7P8
	VB+VCbzBS6qKUplrQa1oEzoG2m5i6u5uIc1PqoA9Ruk27lb3vJbWGLwgJaG8Jkn/hvlnRZ
	4EHL0HTGPNw9qiT98t/sqgK6c1x9RKdRzbzQArvKoiei+50dFQ5a59KrQ8Pgug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1768234553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwndc9EujYh/WaXIE4enjSxk6eMHUT68pNC0cC/u3Rg=;
	b=pUulcpeTMhWImaMnK+WxkeYO+BNnPnXU5+H3Zaxhnnd2fXUjNwhJwpLC89KD0h/FejhbVX
	8vWhTKLHePCwPEDg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CGFpZI010756
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:15:52 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60CGFp6n019077
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 01:15:51 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 60CGFpe5019076;
	Tue, 13 Jan 2026 01:15:51 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: syzbot <syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] WARNING in msdos_rmdir
In-Reply-To: <69651808.050a0220.eaf7.00b3.GAE@google.com>
References: <69651808.050a0220.eaf7.00b3.GAE@google.com>
Date: Tue, 13 Jan 2026 01:15:51 +0900
Message-ID: <87tswqdcy0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9c7ef209cd0f Merge tag 'char-misc-6.19-rc5' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cfec3a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=66d24939ab3817bd81d0
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d50052580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16efd9fc580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4fb19edb55d0/disk-9c7ef209.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9b4c89c27788/vmlinux-9c7ef209.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a728d410d528/bzImage-9c7ef209.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/83e4f46f8575/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17550052580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com

This should be fixed by following patch.

https://lore.kernel.org/all/20260101111148.1437-1-zhiyuzhang999@gmail.com/

> ------------[ cut here ]------------
> WARNING: fs/inode.c:417 at drop_nlink+0xc5/0x110 fs/inode.c:417, CPU#1: syz-executor/5973
> Modules linked in:
> CPU: 1 UID: 0 PID: 5973 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
> Code: c0 08 00 00 be 08 00 00 00 e8 67 f9 eb ff f0 48 ff 83 c0 08 00 00 5b 41 5c 41 5e 41 5f 5d e9 42 90 9f 08 cc e8 1c bd 89 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
> RSP: 0018:ffffc90004877bf0 EFLAGS: 00010293
> RAX: ffffffff8235efa4 RBX: ffff8880589f9d30 RCX: ffff8880274f3c80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1db66cf R12: 1ffff1100b13f3af
> R13: ffff8880589f9d30 R14: ffff8880589f9d78 R15: dffffc0000000000
> FS:  000055559129d500(0000) GS:ffff888126dee000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555912d86c8 CR3: 0000000038956000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  msdos_rmdir+0x3ca/0x4e0 fs/fat/namei_msdos.c:328
>  vfs_rmdir+0x51b/0x670 fs/namei.c:5245
>  do_rmdir+0x27f/0x4a0 fs/namei.c:5300
>  __do_sys_unlinkat fs/namei.c:5477 [inline]
>  __se_sys_unlinkat fs/namei.c:5471 [inline]
>  __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:5471
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0f8e67ed27
> Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff98601628 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
> RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f0f8e67ed27
> RDX: 0000000000000200 RSI: 00007fff986027d0 RDI: 00000000ffffff9c
> RBP: 00007f0f8e703d7d R08: 00005555912c86ab R09: 0000000000000000
> R10: 0000000000001000 R11: 0000000000000207 R12: 00007fff986027d0
> R13: 00007f0f8e703d7d R14: 000000000001a887 R15: 00007fff98605a80
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

