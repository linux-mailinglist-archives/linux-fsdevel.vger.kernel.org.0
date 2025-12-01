Return-Path: <linux-fsdevel+bounces-70307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C79C96531
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6DD54E11C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B12FBE01;
	Mon,  1 Dec 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sLzpefUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FE214A64;
	Mon,  1 Dec 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580005; cv=none; b=I0qX3/k68ry7P3tjCQ8eXmgp6uSLOgmi0TewTdi4cCZmKqqJJjm/ARTrYzrFPV7j4kIIeXUqvkmF09gcUQP+pmw8QSLQFITbV72MfLOM3qK8IY6xi38ZiTurE7qUgm6ijOm21Uss51Cq6Hhgn7i6ziiHTTQev8p8EYFujdPSRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580005; c=relaxed/simple;
	bh=uLJ3oMBjhylvzv+ROpN7Mlm4sI2Amfa+CcnUPo5nsc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NERuuk5o77RjZgWaHJFZPRs8azAVM8K1c3yC/rdG3mefLN24z3eMp9nUcxlSIBF54JhJxyTUPxyLpaTUQa4IqXhl5+Bo6VGKWyzWu5kR7zcwunKy5f/HYo9IvAM75iQ0ZQvo2qpKQNz6F7OMy2P37IoeQ59RTwYQHeGDo+eRtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sLzpefUq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=GUi4ZoLLQhj3s2oTDUGadDjUKvBV8KY1N267muv7w+4=; b=sLzpefUqeyUyjLI2rovUx05R+L
	1O/I5jze82qO9XWPvrSbMyemb/9V94QCdTe1cf9S+s4no7U/VeOg0zKBmrUEZZPwz9D7fbdENEZDq
	r8f5BotG8Cd5cAe2d6+WcZpGRRlTLWXzQYmX5nuVz7QaGv3WdDhPm72Nu/YYJ+mKPDdeJDashlhIC
	9MjVpakXnpuvXC76Sr7M9WHcZUWB8Cbzc7aHrolM7WyLgP3uFwhumloYP4ew7fCo2TAVF25L1o2bg
	SnyGUIrGAwB77UfWNSSNimfgZyXXAa2N73mCfrCI5xxGGXJc2sbVG+7bQtkT3FN9KFUBLN3PXWMpS
	nWUQuh4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPzrw-0000000CNKU-1vvS;
	Mon, 01 Dec 2025 09:06:52 +0000
Date: Mon, 1 Dec 2025 09:06:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com>,
	NeilBrown <neil@brown.name>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] WARNING in fast_dput
Message-ID: <20251201090652.GE3538@ZenIV>
References: <692aef93.a70a0220.d98e3.015b.GAE@google.com>
 <CAOQ4uxhPEt76ij9zBtdKf0qYwSjeXquGGkLHeArO5t1LhdTHOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhPEt76ij9zBtdKf0qYwSjeXquGGkLHeArO5t1LhdTHOg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 09:58:00AM +0100, Amir Goldstein wrote:
> On Sat, Nov 29, 2025 at 2:05 PM syzbot
> <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14db5f42580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b74150fd2ef40e716ca2
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1780a112580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f6be92580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: fs/dcache.c:829 at fast_dput+0x334/0x430 fs/dcache.c:829, CPU#1: syz.0.17/6053
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 6053 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > RIP: 0010:fast_dput+0x334/0x430 fs/dcache.c:829
> > Code: e3 81 ff 48 b8 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84 c0 0f 85 e2 00 00 00 41 80 0e 40 e9 fd fe ff ff e8 4d e3 81 ff 90 <0f> 0b 90 e9 ef fe ff ff 44 89 e6 81 e6 00 00 04 00 31 ff e8 74 e7
> > RSP: 0018:ffffc90003407cd8 EFLAGS: 00010293
> > RAX: ffffffff823fcfe3 RBX: ffff88806c44ac78 RCX: ffff88802e41bd00
> > RDX: 0000000000000000 RSI: 00000000ffffff80 RDI: 0000000000000001
> > RBP: 00000000ffffff80 R08: 0000000000000003 R09: 0000000000000004
> > R10: dffffc0000000000 R11: fffff52000680f8c R12: dffffc0000000000
> > R13: 1ffff1100d889597 R14: ffff88806c44abc0 R15: ffff88806c44acb8
> > FS:  00005555820e4500(0000) GS:ffff888125f4f000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b31b63fff CR3: 0000000072c78000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  dput+0xe8/0x1a0 fs/dcache.c:924
> >  __fput+0x68e/0xa70 fs/file_table.c:476
> >  task_work_run+0x1d4/0x260 kernel/task_work.c:233
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
> >  exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
> >  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
> >  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
> >  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
> >  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
> >  do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f4966f8f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc01c51258 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> > RAX: 0000000000000000 RBX: 000000000001a7a1 RCX: 00007f4966f8f749
> > RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000201c5154f
> > R10: 0000001b30f20000 R11: 0000000000000246 R12: 00007f49671e5fac
> > R13: 00007f49671e5fa0 R14: ffffffffffffffff R15: 0000000000000004
> >  </TASK>
> >
> 
> Any idea why this was tagged as overlayfs?
> I do not see overlayfs anywhere in the repro, logs, or stack trace.
> 
> Neil thinks this might be already fixed upstream, but
> given the recency of this report, I doubt it.

Sigh...  It's not in mainline at all.  It's in vfs/vfs.git #vfs.all,
and yes, it had been fixed there as of
commit d6ea5537c1a66a54d34f50d51ad201b1a2319ccf
Merge: 80019251fa80 65c2c221846e
Author: Christian Brauner <brauner@kernel.org>
Date:   Fri Nov 28 17:32:43 2025 +0100
 
     Merge tag 'vfs-6.19-rc1.fd_prepare' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs into vfs.all

Wait for Monday, hopefully -next will pick it...

