Return-Path: <linux-fsdevel+bounces-23193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CF9286D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1051B2879B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B9148312;
	Fri,  5 Jul 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiyLFGln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21022313;
	Fri,  5 Jul 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175673; cv=none; b=BGDPKKqi9JlPufjQcHttAiR3Tn+z+YRfEPWkDHbHdG83piVtK69Vtbtbein3CL0+ODzJqY4ESbEBL84/KMu8yGRst0SiDHVz9457qb2fD1nu4Mq9x1HwKuql6Jmqt4emuKnJwhGZvJ+akbs1QFFG3mJApgzCCt6Wkoc0+5Ahelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175673; c=relaxed/simple;
	bh=827NIGqjInlrNmGkkDX+qJ3x6YUzBmilo3yLszCV9qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzPckcxFqhryyecACVQa4XO5SzYNGJ1L4NK3jNUloeXi6RWrtjhkX8zQDFyf4P/9i6EHQnFuhlzOAtT3PYD7mNHPlgmpH/nvavoXa3WFC6g9uLloXlAm45RHRW1lh3Q8skDTZVg4PeSNQKhNrpjiYYYkPJiMIYIHdm1oBhr7sHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiyLFGln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E31C116B1;
	Fri,  5 Jul 2024 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720175672;
	bh=827NIGqjInlrNmGkkDX+qJ3x6YUzBmilo3yLszCV9qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiyLFGlnhMiDxNWsoyJE7LBSxSGeMvijWc5csASMOk2v5pw3v1T17xpWStrYpjs3b
	 R9ZNhaOH5X+vjo1Au5y97YSB1I9Q1Kr8XnJp7ffCUDXm6wVHZi2/bg3BJtXyWJttUj
	 wzh3q0UUk5DUFBvBXImzw98MGja6B5toPysDxnU9YkCNPEVpngdh13NRH2WKvlf480
	 rKFWNjEccQjniLw4oeMRMrRvRPIYEvz5lYjQSG4jlcKOcf1jqeQBK9+6NTjcbxcxda
	 2PVDFl2bTKDaTI+M16qgPa39awA5LNoVtVshk6ecOWaCGKnZJzSv1lJGfKDYWbzY1L
	 H13yw7urrZCZg==
Date: Fri, 5 Jul 2024 12:34:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __ep_remove / __fput (4)
Message-ID: <20240705-krumm-glatt-a6fb08b0b089@brauner>
References: <000000000000fbb100061c6ce567@google.com>
 <CACT4Y+Z34Mc_Vv8-dDvD+HE57tMez0Rd17zr_s-3Gn23tOVG3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z34Mc_Vv8-dDvD+HE57tMez0Rd17zr_s-3Gn23tOVG3A@mail.gmail.com>

On Thu, Jul 04, 2024 at 04:40:40PM GMT, Dmitry Vyukov wrote:
> On Thu, 4 Jul 2024 at 16:38, syzbot
> <syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    22a40d14b572 Linux 6.10-rc6
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10f94dae980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3195ed1f3a2ab8bea49a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ebe2f3933faf/disk-22a40d14.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7227032da0fe/vmlinux-22a40d14.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a330dc1e107b/bzImage-22a40d14.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3195ed1f3a2ab8bea49a@syzkaller.appspotmail.com
> 
> 
> Double-checked locking in eventpoll_release_file() should prevent NULL
> derefs in eventpoll_release_file(), right? If so, it's probably
> benign-ish.

Yes, see the comment to eventpoll_release(). I assume a READ_ONCE()
would be ok to add there so that race is annotated.

> 
> 
> > ==================================================================
> > BUG: KCSAN: data-race in __ep_remove / __fput
> >
> > write to 0xffff88810f2358d0 of 8 bytes by task 6036 on cpu 1:
> >  __ep_remove+0x3c9/0x450 fs/eventpoll.c:826
> >  ep_remove_safe fs/eventpoll.c:864 [inline]
> >  ep_clear_and_put+0x158/0x260 fs/eventpoll.c:900
> >  ep_eventpoll_release+0x32/0x50 fs/eventpoll.c:937
> >  __fput+0x2c2/0x660 fs/file_table.c:422
> >  ____fput+0x15/0x20 fs/file_table.c:450
> >  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff88810f2358d0 of 8 bytes by task 6037 on cpu 0:
> >  eventpoll_release include/linux/eventpoll.h:45 [inline]
> >  __fput+0x234/0x660 fs/file_table.c:413
> >  ____fput+0x15/0x20 fs/file_table.c:450
> >  task_work_run+0x13a/0x1a0 kernel/task_work.c:180
> >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
> >  do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0xffff888102f1e010 -> 0x0000000000000000
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 6037 Comm: syz.0.1032 Not tainted 6.10.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fbb100061c6ce567%40google.com.

