Return-Path: <linux-fsdevel+bounces-62995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF098BA8751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D097B2A91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862F27FB2B;
	Mon, 29 Sep 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBLqI/CP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38224220F2A;
	Mon, 29 Sep 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135895; cv=none; b=jziqjSXcdbu8oXSJ5EQ+Vxd2nIaUPGW2FU1tQnyhzWODBUSix1pw0xY1S624uGZ8DyiiYrtPQhB8TBpUeUKdIAqSF8m/3VaFgem2c2cDdeKxU2mO5yGU9wkKcLE1B+D7goWKUb2BQp2xffH/81VLWe/1RJ3d5XCyTG8UqqK2M8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135895; c=relaxed/simple;
	bh=4K4TmkR8D0817PhG03WQ6OaDXMyi5PCzE11ACzW4pio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4LVSU9RhtIkefgFf5rF/BDXvTbyEjwKUQ0hy/lyM/HjiAGKu4HV1BH7aGQmz4XVThwuA8hpeh9pcB4/igH1oWZBbju1C6Bt05t0zAFr5SkOtQMioXXxHssQtSJRjnF0aEpc/awwclti3j6hfGLIZeZrs1Pb6MVKentgQLtKrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBLqI/CP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C5DC4CEF5;
	Mon, 29 Sep 2025 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759135894;
	bh=4K4TmkR8D0817PhG03WQ6OaDXMyi5PCzE11ACzW4pio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBLqI/CPSfSqS29qRkjUYcnJIv3W4d9odwCIt69+0FO3W+PHN6Gy2/zxyPN4trPZj
	 8lPHtKyW4loQbaW47AIfmi0ZOK1YgcpeXShufOTgwfxZ7uzmkoAhjITye/bLnCoFYV
	 k+X0UQjGV6hWHEs9VbScD/PndmNnSBwAHl+4UrHmvCnkN4/5u0+NcgCsc3xvLMBblh
	 ZLU7NBTT1JxnE1nzKBzXdjdfNEaN3XvBiwuUbLzmkNqTQz3RBSc/nQL4ojEqBkxiLl
	 m0jMtVBRlkxvJQJsmXlw8xpUdR9iaHR7DLMJNStIgMtwQsiAiH6LZWIJrwga09oTTg
	 wt8SdD+GTRFDg==
Date: Mon, 29 Sep 2025 10:51:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid
 context in hook_sb_delete
Message-ID: <20250929-besuchen-ursachen-50b3f25ca435@brauner>
References: <68d32659.a70a0220.4f78.0012.GAE@google.com>
 <fnxbqe3nlcptxqcs7tkt6qnacupkxu2xn4duwc6g6n2bk4tstb@hi2gl5cwishr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fnxbqe3nlcptxqcs7tkt6qnacupkxu2xn4duwc6g6n2bk4tstb@hi2gl5cwishr>

On Wed, Sep 24, 2025 at 01:05:03PM +0200, Jan Kara wrote:
> Hello!
> 
> Added Landlock guys to CC since this is a bug in Landlock.
> 
> On Tue 23-09-25 15:59:37, syzbot wrote:
> > syzbot found the following issue on:
> > 
> > HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=118724e2580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1376e27c580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e78e2580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c30be6f36c31/disk-ce7f1a98.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ae9ea347d4d8/vmlinux-ce7f1a98.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d59682a4f33c/bzImage-ce7f1a98.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
> > 
> > BUG: sleeping function called from invalid context at fs/inode.c:1928
> 
> The first catch from the new might_sleep() annotations in iput().
> 
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6028, name: syz.0.17
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 2 locks held by syz.0.17/6028:
> >  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
> >  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
> >  #0: ffff8880326bc0e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
> >  #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
> >  #1: ffff8880326bc998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: hook_sb_delete+0xae/0xbd0 security/landlock/fs.c:1405
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 0 UID: 0 PID: 6028 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  __might_resched+0x495/0x610 kernel/sched/core.c:8960
> >  iput+0x2b/0xc50 fs/inode.c:1928
> >  hook_sb_delete+0x6b5/0xbd0 security/landlock/fs.c:1468
> 
> Indeed looks like a bug because we can call iput() while holding
> sb->s_inode_list_lock in one case in hook_sb_delete().

Very nice that the annotations help finding this!

