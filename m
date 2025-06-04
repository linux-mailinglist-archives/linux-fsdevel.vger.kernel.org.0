Return-Path: <linux-fsdevel+bounces-50600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1192AACD9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411A01893290
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942226A0F4;
	Wed,  4 Jun 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjfAbNjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0610E9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026000; cv=none; b=dFmqM4GRmUi4dKolv5zl225NqoxzyLj2zlscIK2YDUwK+udzXHpY/sI0qOtxobE/g9e53xdJuvmXmrRAP/ON2kWjBb+ukHVWBJsBHbBK0k9QqCKuFjMr0EXOZQqowD13Fx0JP+eibh/prvdlPAMKpQAJJ9/9oVcpl0RVUTZKRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026000; c=relaxed/simple;
	bh=0V5itgUzJgdvQO9g7TT9FEDORGHLixPfHHfaIHkzGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlMLTTWZ4WWqvZOoDS+YJ/7WYm0KKI6S4GFs69s0vNwUlWS7enIedO40t3dEVtPNu2Q7Zpx84b3ROXK/qTJJRHjxsoY9vULLRfotOhSgnkOvpzULBW31n7yNShi13Z42RY3IlpE3L3BW0e2wnZoyRh5K3hG5WVQmoIZBKgXQyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjfAbNjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A01C4CEE7;
	Wed,  4 Jun 2025 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749025997;
	bh=0V5itgUzJgdvQO9g7TT9FEDORGHLixPfHHfaIHkzGRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjfAbNjXp8F3xQyck63OQU/DjfmUDpsnx62P9Rj9r8u2xEktW2uDjN7UG0LQS/ERb
	 bdliHY9DIb+YuodilQxhmhp0xzYDNcKzM8dv0qS6W3130iknqMCVbPaNrljKani/Gw
	 hTC9t+GzixPYstvFha7W+z01SPyD/i6aXtLKGtMfvCr+hw8rsRs5u6EB0iiL3klbCs
	 3l3ZZyE2CrPHpb45un1OQQXNXpVVsHJZnrm1kG8u4h7TceyIuBRsNsW3blQu1106XY
	 l9kBmpH4dZ2+etrXyIJpfa5JkQMJ3++/5jp7kE/hSPSGoU+5RL273D1xBs74DZBUbD
	 B4r0nPEiIFRqw==
Date: Wed, 4 Jun 2025 10:33:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <20250604-kreieren-pfeffer-fe4ff785b4c8@brauner>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
 <87msaqcw4z.fsf@igalia.com>
 <87frgicf9l.fsf@igalia.com>
 <obfuqy5ed5vspgn3skli6aksymrkxdrn4dc2gtohhyql5bcqs2@f5xdzffhxghi>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <obfuqy5ed5vspgn3skli6aksymrkxdrn4dc2gtohhyql5bcqs2@f5xdzffhxghi>

On Tue, Jun 03, 2025 at 11:34:53AM +0200, Jan Kara wrote:
> On Mon 02-06-25 16:52:22, Luis Henriques wrote:
> > On Mon, Jun 02 2025, Luis Henriques wrote:
> > > Hi Christian,
> > >
> > > On Fri, Feb 07 2025, Christian Brauner wrote:
> > >
> > >> Before 2011 there was no meaningful synchronization between
> > >> read/readdir/write/seek. Only in commit
> > >> ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > >> synchronization was added for SEEK_CUR by taking f_lock around
> > >> vfs_setpos().
> > >>
> > >> Then in 2014 full synchronization between read/readdir/write/seek was
> > >> added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> > >> by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > >> for directories. At that point taking f_lock became unnecessary for such
> > >> files.
> > >>
> > >> So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> > >> acquired f_pos_lock if necessary.
> > >
> > > I'm seeing the splat below with current master.  It's unlikely to be
> > > related with this patch, but with recent overlayfs changes.  I'm just
> > > dropping it here before looking, as maybe it has already been reported.
> > 
> > OK, just to confirm that it looks like this is indeed due to this patch.
> > I can reproduce it easily, and I'm not sure why I haven't seen it before.
> 
> Thanks for report! Curious. This is:
> 
>         VFS_WARN_ON_ONCE((file_count(file) > 1) &&
>                          !mutex_is_locked(&file->f_pos_lock));
> 
> Based on the fact this is ld(1) I expect this is a regular file.
> Christian, cannot it happen that we race with dup2() so file_count is
> increased after we've checked it in fdget_pos() and before we get to this
> assert?

Yes I somehow thought the two of us had already discussed this and
either concluded to change it or drop the assert. Maybe I forgot that?
I'll remove the assert.

> 
> 								Honza
> > > [  133.133745] ------------[ cut here ]------------
> > > [  133.133855] WARNING: CPU: 6 PID: 246 at fs/file.c:1201 file_seek_cur_needs_f_lock+0x4a/0x60
> > > [  133.133940] Modules linked in: virtiofs fuse
> > > [  133.134009] CPU: 6 UID: 1000 PID: 246 Comm: ld Not tainted 6.15.0+ #124 PREEMPT(full) 
> > > [  133.134110] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > [  133.134235] RIP: 0010:file_seek_cur_needs_f_lock+0x4a/0x60
> > > [  133.134286] Code: 00 48 ba fe ff ff ff ff ff ff bf 48 83 e8 01 48 39 c2 73 06 b8 01 00 00 00 c3 48 81 c7 90 00 00 00 e8 da 0e db ff 84 c0 75 ea <0f> 0b b8 01 00 00 00 c3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00
> > > [  133.134471] RSP: 0018:ffffc90000e67ea0 EFLAGS: 00010246
> > > [  133.134526] RAX: 0000000000000000 RBX: fffffffffffffc01 RCX: 7fffffffffffffff
> > > [  133.134683] RDX: bffffffffffffffe RSI: fffffffffffffc01 RDI: ffff888101bd1e90
> > > [  133.135430] RBP: ffff888101bd1e00 R08: 00000000002a3988 R09: 0000000000000000
> > > [  133.136172] R10: ffffc90000e67ed0 R11: 0000000000000000 R12: 7fffffffffffffff
> > > [  133.136351] R13: ffff888101bd1e00 R14: ffff888105d823c0 R15: 0000000000000001
> > > [  133.136433] FS:  00007fd7880d2b28(0000) GS:ffff8884ad411000(0000) knlGS:0000000000000000
> > > [  133.136516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  133.136586] CR2: 0000559b3af3a520 CR3: 0000000103cb1000 CR4: 0000000000750eb0
> > > [  133.136667] PKRU: 55555554
> > > [  133.136694] Call Trace:
> > > [  133.136720]  <TASK>
> > > [  133.136747]  generic_file_llseek_size+0x93/0x120
> > > [  133.136802]  ovl_llseek+0x86/0xf0
> > > [  133.136844]  ksys_lseek+0x39/0x90
> > > [  133.136884]  do_syscall_64+0x73/0x2c0
> > > [  133.136932]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > [  133.136994] RIP: 0033:0x7fd788098262
> > > [  133.137034] Code: 48 63 d2 48 63 ff 4d 63 c0 b8 09 01 00 00 0f 05 48 89 c7 e8 8a 80 fd ff 48 83 c4 08 c3 48 63 ff 48 63 d2 b8 08 00 00 00 0f 05 <48> 89 c7 e9 70 80 fd ff 8d 47 27 53 89 fb 83 f8 4e 76 27 b8 ec ff
> > > [  133.137223] RSP: 002b:00007fffffaf82c8 EFLAGS: 00000283 ORIG_RAX: 0000000000000008
> > > [  133.137302] RAX: ffffffffffffffda RBX: 00007fd787ba1010 RCX: 00007fd788098262
> > > [  133.137385] RDX: 0000000000000001 RSI: fffffffffffffc01 RDI: 000000000000000f
> > > [  133.137465] RBP: 0000000000000000 R08: 0000000000000064 R09: 00007fd787c3c6a0
> > > [  133.137545] R10: 000000000000000e R11: 0000000000000283 R12: 00007fffffafa694
> > > [  133.137625] R13: 0000000000000039 R14: 0000000000000038 R15: 00007fffffafaa79
> > > [  133.137708]  </TASK>
> > > [  133.137736] irq event stamp: 1034649
> > > [  133.137776] hardirqs last  enabled at (1034657): [<ffffffff8133c642>] __up_console_sem+0x52/0x60
> > > [  133.137872] hardirqs last disabled at (1034664): [<ffffffff8133c627>] __up_console_sem+0x37/0x60
> > > [  133.137966] softirqs last  enabled at (1012640): [<ffffffff812c4884>] irq_exit_rcu+0x74/0x110
> > > [  133.138064] softirqs last disabled at (1012633): [<ffffffff812c4884>] irq_exit_rcu+0x74/0x110
> > > [  133.138161] ---[ end trace 0000000000000000 ]---
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

