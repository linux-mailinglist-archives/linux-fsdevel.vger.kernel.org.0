Return-Path: <linux-fsdevel+bounces-24408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5EA93F0AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B1A285D40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7E144D34;
	Mon, 29 Jul 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/pjLPvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD6144D23;
	Mon, 29 Jul 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244260; cv=none; b=PMce8e68kUpJDHeXnTa+i/LX0hhM6RTl5DMQUpTHUnr0QO3SkmKI8I2JMbtlvGkJstcpnw4MG1hRItCmNraYJE9StxoYJjpCmqFxPO4s755t/mU7Ug7YF5OIE0smmbJENBUbzwQjC5ZIuweOUq5+kkUjwc/jMCCTOIJqdi8vrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244260; c=relaxed/simple;
	bh=xVnMBh/aez2MOmOwqxtLn5QGRZA8Jl3rF19QRIJ2IQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okuz1mMqbK2VXAo+R5rwKnIphktOVqJa7JmHDA1xbhX1TgCWM6Gsnw06KrZ4rAlnS6GoYvOi63BzMoq3LAjW7hZ+ii1qP5c5jtO8SwZjT3HK0iaKF49McnmQAMGY34JxB1sYJWvVxEoVQQWOewSG6uYuhU7ABFdScpL+HogKWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/pjLPvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA12DC4AF0B;
	Mon, 29 Jul 2024 09:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722244260;
	bh=xVnMBh/aez2MOmOwqxtLn5QGRZA8Jl3rF19QRIJ2IQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/pjLPvITN4go8z7Ltk2CncC08ns95Rs4oL9LM14dVLHhP8oVdgmL9yC72O057BzU
	 tjsvRpYnd+5afErtDbXnj20utAF9T51uS0OxRjoTVfcvHrJHSW3IX1NqgsXoMFm7gN
	 GvnUsMp4kedFae2KFJ5Un9k2RnBhdngO+3dtVMXcLymXuPtLTkXVPDvR/M+CGwJmXg
	 x5h8/6c5JdgX35oRXqFyYkFDjfU0QoJx1kjJ/rBbKcDwIEnjsJzsf6QnAYA73xHR6R
	 5yWHWsWEWtaShsF3lwcZh0x4SWwmZVqVcqImXBQ4HRajTVJ2LFYst45BA9JR/wOoAM
	 DzzYnZcUPaaZA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	paulmck@kernel.org,
	Hillf Danton <hdanton@sina.com>,
	rcu@vger.kernel.org,
	frank.li@vivo.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Date: Mon, 29 Jul 2024 11:10:09 +0200
Message-ID: <20240729-himbeeren-funknetz-96e62f9c7aee@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004ff2dc061e281637@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=brauner@kernel.org; h=from:subject:message-id; bh=xVnMBh/aez2MOmOwqxtLn5QGRZA8Jl3rF19QRIJ2IQk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtj5mxPzxu6b6GjxN+hv+pOBF54kUQ/4X5TJLMLB5vv J+qpvG+7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhItSnDPxWpm1+2syT0aHtb GUn/0xfxe79hRsj3JSHdcp+mMLt+bWJk+FPF9ZZt+fH5tw5N0mPJe9a1xGaxk98DvfgLHwwylbo TmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 08:23:02AM GMT, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
> Author: Chao Yu <chao@kernel.org>
> Date:   Sun Apr 23 15:49:15 2023 +0000
> 
>     f2fs: support errors=remount-ro|continue|panic mountoption
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119745f1980000
> start commit:   1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=139745f1980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=159745f1980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
> dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000
> 
> Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
> Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks to Paul and Oleg for point me in the right direction and
explaining that rcu sync warning.

That patch here is remounting a superblock read-only directly by raising
SB_RDONLY without the involvement of the VFS at all. That's pretty
broken and is likely to cause trouble if done wrong. The rough order of
operations to transition rw->ro usualy include checking that the
filsystem is unfrozen, and marking all mounts read-only, then calling
into the filesystem so it can do whatever it wants to do.

In any case, all of this requires holding sb->s_umount. Not holding
sb->s_umount will end up confusing freeze_super() (Thanks to Oleg for
noticing!). When freeze_super() is called on a non-ro filesystem it will
acquire
percpu_down_write(SB_FREEZE_WRITE+SB_FREEZE_PAGEFAULT+SB_FREEZE_FS) and
thaw_super() needs to call
sb_freeze_unlock(SB_FREEZE_FS+SB_FREEZE_PAGEFAULT+SB_FREEZE_WRITE) but
because you just raise SB_RDONLY you end up causing thaw_super() to skip
that step causing the bug in rcu_sync_dtor() to be noticed.

Btw, ext4 has similar logic where it raises SB_RDONLY without checking
whether the filesystem is frozen.

So I guess, this is technically ok as long as that emergency SB_RDONLY raising
in sb->s_flags is not done while the fs is already frozen. I think ext4 can
probably never do that. Jan?

My guess is that something in f2fs can end up raising SB_RDONLY after
the filesystem is frozen and so it causes this bug. I suspect this is coming
from the gc_thread() which might issue a f2fs_stop_checkpoint() while the fs is
already about to be frozen but before the gc thread is stopped as part of the
freeze.

