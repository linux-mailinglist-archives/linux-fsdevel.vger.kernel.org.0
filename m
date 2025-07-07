Return-Path: <linux-fsdevel+bounces-54091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32297AFB2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9884A2057
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4829A333;
	Mon,  7 Jul 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="oGh9mnv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76CFBF0
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889247; cv=none; b=QbzvKay0VpJSRTyQaIY3XyOsmaDKsWBOYG0WGT+6NLCVY62VekMDeWcuc6caJnTa+yJS3aqGyfQGOWOOycZs4U4XtfCh3EXuSA7OgJahkFEpnf/d/piz8a1YXgoU8JIq2EFP1DB1hAzOCrSS3G+0qv1d9TPdiLq5aBWPcRTIXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889247; c=relaxed/simple;
	bh=/+o64qtRr/puKxhLukrHwjbyUKS6IS+j190RFYFv8qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnXL25p/Wj9qwA2M/FKOMkifcjNPzDJS7Zm+Qr463jfsOduDtTBaYmk2WGF7wld9iDsMxFlvil4XQt4uitsXAZ7/G0+fVjYep5Hz64QmgXNhbwYcly6JWQAtcusbQ/5QTbxt7l2WVwkI6yb6QSZBnh1eYk3nsNExy6+pbU1b3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=oGh9mnv6; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751889238;
	bh=o1dq5Hb9Cv60vUUsdSQmeRd7DsdHTcthm1XraCMT9gY=;
	h=From:Subject:Date:Message-ID;
	b=oGh9mnv6+YRfVosWGEUMTgKzKY76OhEocXXp2uabz3OwYHBLI8AyTcd4ugWfD8vqD
	 D3eX44E7uyFIz8JfDn4gFEZVv1t0HoBPzzZgHKDXUzuzEqzHY3d746DG3dcwealWfZ
	 WMoiFqVOcamkDQc5Ze8vCwhPd/4Qxecpr4R4mdgQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 686BB55000000582; Mon, 7 Jul 2025 19:53:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5300836685137
X-SMAIL-UIID: 110272A30E804528B59A9E6791B2C466-20250707-195354-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>
Cc: brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [mm?] [fs?] WARNING in path_noexec
Date: Mon,  7 Jul 2025 19:53:41 +0800
Message-ID: <20250707115343.2750-1-hdanton@sina.com>
In-Reply-To: <686ba948.a00a0220.c7b3.0080.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 07 Jul 2025 04:02:32 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d6c58332c7a Add linux-next specific files for 20250703
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15788582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d7dc16394230c170
> dashboard link: https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ecb3d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153af770580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ff731adf5dfa/disk-8d6c5833.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c7a3c57e0a1/vmlinux-8d6c5833.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2f90e7c18574/bzImage-8d6c5833.xz
> 
> The issue was bisected to:
> 
> commit df43ee1b368c791b7042504d2aa90893569b9034
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Jul 2 09:23:55 2025 +0000
> 
>     anon_inode: rework assertions
> 
Given EPERM [1], this rework looks like a case of overdose.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/mmap.c?id=df43ee1b368c#n474

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b373d4580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b373d4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b373d4580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com
> Fixes: df43ee1b368c ("anon_inode: rework assertions")
> 
> ------------[ cut here ]------------
> WARNING: fs/exec.c:119 at path_noexec+0x1af/0x200 fs/exec.c:118, CPU#1: syz-executor260/5835
> Modules linked in:
> CPU: 1 UID: 0 PID: 5835 Comm: syz-executor260 Not tainted 6.16.0-rc4-next-20250703-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118
> Code: 02 31 ff 48 89 de e8 f0 b1 89 ff d1 eb eb 07 e8 07 ad 89 ff b3 01 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f2 ac 89 ff 90 <0f> 0b 90 e9 48 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a6
> RSP: 0018:ffffc90003eefbd8 EFLAGS: 00010293
> RAX: ffffffff8235f22e RBX: ffff888072be0940 RCX: ffff88807763bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000080000 R08: ffff88807763bc00 R09: 0000000000000003
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000011
> R13: 1ffff920007ddf90 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055556832d380(0000) GS:ffff888125d1e000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f21e34810d0 CR3: 00000000718a8000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  do_mmap+0xa43/0x10d0 mm/mmap.c:472
>  vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
>  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f21e340a9f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd23ca3468 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f21e340a9f9
> RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000200000ff9000
> RBP: 00007f21e347d5f0 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
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
> 

