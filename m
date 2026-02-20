Return-Path: <linux-fsdevel+bounces-77759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DNQKRexl2nt6AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:55:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF98164073
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15589300F9FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D620D4FC;
	Fri, 20 Feb 2026 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbCD6rpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CC2AD3D;
	Fri, 20 Feb 2026 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548943; cv=none; b=HQnBYNQp3n4DRY3611wnuREUplQx7R3+LL08O3fQ2qEluK9ZPsfoR36rz2rv47GGaLsZsJ54KWdLKHI3e39Npqzv06uF508QKE9kFBY+H2dcrYl0/WGczf4uXbpn9dQdCsszWFJj55LAWcORJck4lcx0Fn+2ww2xoEcCePoYtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548943; c=relaxed/simple;
	bh=QLs1m1e5rJqSfGDa0i9ViJWwh9zj3eVZW1t/FDvc8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJgp5I2ljLaYlv+7CVNjepXi9RuemX6IZDgxZ1m9WZBCrD48HPKYi4OE4xEgvnHnTnynbS5e3ollg61lpCB34rPdYgkaFvugDHnzjGCQ3GO55x2guOK0LY+KD9LZKcJ8k0/1geXMdySJmNBPpCf01NwKgmniPD81cJPDoJJCYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbCD6rpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D0DC19421;
	Fri, 20 Feb 2026 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771548943;
	bh=QLs1m1e5rJqSfGDa0i9ViJWwh9zj3eVZW1t/FDvc8Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbCD6rpvi6NoeIoGEBBGOWxL1VaMvqZuKKP8hWf7s4MCZ44DFdVVZwwS/SEVLexSC
	 mQ/SJT3KMJu+cZ/jl5/SoaPmVtp1k8I/vNr2m5CgdIDdckqi58GpJeGgYucRxr+CAc
	 KewEnQwoUVBa5BXDQ0gMR3a0PSOYqE3xT75mWdV9E8KI8WWPZEZ27VUBuG1jq2QeU7
	 WLlH+1jvo7iyZzmyqOcelxHk8+X2LGxyo6ExmqPdndchQG/kwkrRQw+Jrtkj8lgbIa
	 mOA/C/ca+URwq+kMfrcaerce3/fCzpUN/52m2QfrfM2eQmlmxs7hnTUKheGnQ6rVyk
	 QLRnlFBHnpVLA==
Date: Thu, 19 Feb 2026 16:55:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: cem@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fserror: fix lockdep complaint when igrabbing inode
Message-ID: <20260220005542.GU6490@frogsfrogsfrogs>
References: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
 <177148129564.716249.3069780698231701540.stgit@frogsfrogsfrogs>
 <20260219061546.GP6467@frogsfrogsfrogs>
 <20260219-variabel-nackt-a9ce89e670d5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-variabel-nackt-a9ce89e670d5@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77759-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CF98164073
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 09:11:28AM +0100, Christian Brauner wrote:
> On Wed, Feb 18, 2026 at 10:15:46PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 18, 2026 at 10:09:37PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Christoph Hellwig reported a lockdep splat in generic/108:
> > > 
> > >  ================================
> > >  WARNING: inconsistent lock state
> > >  6.19.0+ #4827 Tainted: G                 N
> > >  --------------------------------
> > >  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > >  swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > >  ffff88811ed1b140 (&sb->s_type->i_lock_key#33){?.+.}-{3:3}, at: igrab+0x1a/0xb0
> > >  {HARDIRQ-ON-W} state was registered at:
> > >    lock_acquire+0xca/0x2c0
> > >    _raw_spin_lock+0x2e/0x40
> > >    unlock_new_inode+0x2c/0xc0
> > >    xfs_iget+0xcf4/0x1080
> > >    xfs_trans_metafile_iget+0x3d/0x100
> > >    xfs_metafile_iget+0x2b/0x50
> > >    xfs_mount_setup_metadir+0x20/0x60
> > >    xfs_mountfs+0x457/0xa60
> > >    xfs_fs_fill_super+0x6b3/0xa90
> > >    get_tree_bdev_flags+0x13c/0x1e0
> > >    vfs_get_tree+0x27/0xe0
> > >    vfs_cmd_create+0x54/0xe0
> > >    __do_sys_fsconfig+0x309/0x620
> > >    do_syscall_64+0x8b/0xf80
> > >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >  irq event stamp: 139080
> > >  hardirqs last  enabled at (139079): [<ffffffff813a923c>] do_idle+0x1ec/0x270
> > >  hardirqs last disabled at (139080): [<ffffffff828a8d09>] common_interrupt+0x19/0xe0
> > >  softirqs last  enabled at (139032): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> > >  softirqs last disabled at (139025): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> > > 
> > >  other info that might help us debug this:
> > >   Possible unsafe locking scenario:
> > > 
> > >         CPU0
> > >         ----
> > >    lock(&sb->s_type->i_lock_key#33);
> > >    <Interrupt>
> > >      lock(&sb->s_type->i_lock_key#33);
> > > 
> > >   *** DEADLOCK ***
> > > 
> > >  1 lock held by swapper/1/0:
> > >   #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
> > > 
> > >  stack backtrace:
> > >  CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full)
> > >  Tainted: [N]=TEST
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > >  Call Trace:
> > >   <IRQ>
> > >   dump_stack_lvl+0x5b/0x80
> > >   print_usage_bug.part.0+0x22c/0x2c0
> > >   mark_lock+0xa6f/0xe90
> > >   __lock_acquire+0x10b6/0x25e0
> > >   lock_acquire+0xca/0x2c0
> > >   _raw_spin_lock+0x2e/0x40
> > >   igrab+0x1a/0xb0
> > >   fserror_report+0x135/0x260
> > >   iomap_finish_ioend_buffered+0x170/0x210
> > >   clone_endio+0x8f/0x1c0
> > >   blk_update_request+0x1e4/0x4d0
> > >   blk_mq_end_request+0x1b/0x100
> > >   virtblk_done+0x6f/0x110
> > >   vring_interrupt+0x59/0x80
> > >   __handle_irq_event_percpu+0x8a/0x2e0
> > >   handle_irq_event+0x33/0x70
> > >   handle_edge_irq+0xdd/0x1e0
> > >   __common_interrupt+0x6f/0x180
> > >   common_interrupt+0xb7/0xe0
> > >   </IRQ>
> > > 
> > > It looks like the concern here is that inode::i_lock is sometimes taken
> > > in IRQ context, and sometimes it is held when going to IRQ context,
> > > though it's a little difficult to tell since I think this is a kernel
> > > from after the actual 6.19 release but before 7.0-rc1.
> > > 
> > > Either way, we don't need to take i_lock, because filesystems should
> > > not report files to fserror if they're about to be freed or have not
> > > yet been exposed to other threads, because the resulting fsnotify report
> > > will be meaningless.
> > > 
> > > Therefore, bump inode::i_count directly and clarify the preconditions on
> > > the inode being passed in.
> > 
> > ...and now I realize that I got so hung up on email cc list composition
> 
> I honestly just use b4 prep --auto-to-cc

So do I, but I ^R'd and got one with linux-xfs by mistake.  Unless
there's some magic "read MAINTAINERS functionality" that I haven't
discovered yet?  I haven't updated in quite a while.

> > that I neglected to notice that I forgot to update the commit message
> > to say:
> > 
> > "Therefore, add the ioend to a queue and get an async worker to chug
> > through the error events from process context with no filesystem locks
> > already held."
> > 
> > Let's hope I got the paperwork right this time, all this friction to
> > amend minor mistakes are why I don't want to be here anymore. <grumble>
> 
> You know, I can just add that for you when applying. :)

I prefer to resend the whole series with /all/ the correct tags and
messages so it actually gets recorded here accurately.

Also, would you mind picking up the first patch for 7.0-rc2 so that the
old fsnotify helper is gone for good?

--D

