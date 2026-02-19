Return-Path: <linux-fsdevel+bounces-77691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKjaHHXGlmkGmwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:14:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98C15CF53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5AB3046009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B5334C28;
	Thu, 19 Feb 2026 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayZU+im4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5722E542A;
	Thu, 19 Feb 2026 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488693; cv=none; b=G0Oul8/Kv90nqC7xCWHXUsSR2YQs8Y5akenYgk6Z4VOszrZX5Jlnqz1MlaEuf76yLZNlCQUh/d2z3/DofgfkKAmrCZTpNw4uu1e8R6ce97Q61QQhLwhpahGzJ+2+Y61qcfPGAfpnlZdpLOvyHpXpn8iYYV90gUxUlz0loiwRj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488693; c=relaxed/simple;
	bh=7icexeky2KEJ6ti91A5R1aDETfDVVhmL2w16BTjdRo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpYose6XxNsadJG9+be3zZnAlWfgXSgG/lx4k0jWomvC3FS9qhleC7mUlW2Lx2YYFyA+KBeQ3TBryDQQIMV91jvOBesP2twy5TGTxQxzeczjp5E3MS1MtUnOcLzcPPcknP9cp6YR0tBPgeR3hqlEFBfvzZGqa1ZZh2RyfuXn8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayZU+im4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A61C4CEF7;
	Thu, 19 Feb 2026 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771488692;
	bh=7icexeky2KEJ6ti91A5R1aDETfDVVhmL2w16BTjdRo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayZU+im4kHHFZYydsrcgoVE6r3kb6NIeJ0Rq2vu7/Rbcp6QAf0Vt/8g4fq15gepGc
	 T/4aAuqgw99g03yDGMRLxW0veG9AZp6c7APMHBEOf2caBUksrgPTtd0a237/dlf6v8
	 d3bElQeytlXUR6O0qP2MbL7drh0YJ+MhrXO+5swq7IoSWZqrw7ZfQrw0MV2uYaOp90
	 BRuOYLWFY4e8Wt27Wiwyoh4SCDmyKDP1quUprbI+m9MWFNoNPlLgSuOGOxwTHalT+9
	 KNgVffXnR9FU+hcozKdvlramwh+59FJnJmG7yQesOrhET1NJ+Mfuf3+W6utJfDuaqS
	 r7FZPgA2y+qJg==
Date: Thu, 19 Feb 2026 09:11:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fserror: fix lockdep complaint when igrabbing inode
Message-ID: <20260219-variabel-nackt-a9ce89e670d5@brauner>
References: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
 <177148129564.716249.3069780698231701540.stgit@frogsfrogsfrogs>
 <20260219061546.GP6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219061546.GP6467@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77691-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF98C15CF53
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:15:46PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 18, 2026 at 10:09:37PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Christoph Hellwig reported a lockdep splat in generic/108:
> > 
> >  ================================
> >  WARNING: inconsistent lock state
> >  6.19.0+ #4827 Tainted: G                 N
> >  --------------------------------
> >  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> >  swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> >  ffff88811ed1b140 (&sb->s_type->i_lock_key#33){?.+.}-{3:3}, at: igrab+0x1a/0xb0
> >  {HARDIRQ-ON-W} state was registered at:
> >    lock_acquire+0xca/0x2c0
> >    _raw_spin_lock+0x2e/0x40
> >    unlock_new_inode+0x2c/0xc0
> >    xfs_iget+0xcf4/0x1080
> >    xfs_trans_metafile_iget+0x3d/0x100
> >    xfs_metafile_iget+0x2b/0x50
> >    xfs_mount_setup_metadir+0x20/0x60
> >    xfs_mountfs+0x457/0xa60
> >    xfs_fs_fill_super+0x6b3/0xa90
> >    get_tree_bdev_flags+0x13c/0x1e0
> >    vfs_get_tree+0x27/0xe0
> >    vfs_cmd_create+0x54/0xe0
> >    __do_sys_fsconfig+0x309/0x620
> >    do_syscall_64+0x8b/0xf80
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >  irq event stamp: 139080
> >  hardirqs last  enabled at (139079): [<ffffffff813a923c>] do_idle+0x1ec/0x270
> >  hardirqs last disabled at (139080): [<ffffffff828a8d09>] common_interrupt+0x19/0xe0
> >  softirqs last  enabled at (139032): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> >  softirqs last disabled at (139025): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> > 
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0
> >         ----
> >    lock(&sb->s_type->i_lock_key#33);
> >    <Interrupt>
> >      lock(&sb->s_type->i_lock_key#33);
> > 
> >   *** DEADLOCK ***
> > 
> >  1 lock held by swapper/1/0:
> >   #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
> > 
> >  stack backtrace:
> >  CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full)
> >  Tainted: [N]=TEST
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> >  Call Trace:
> >   <IRQ>
> >   dump_stack_lvl+0x5b/0x80
> >   print_usage_bug.part.0+0x22c/0x2c0
> >   mark_lock+0xa6f/0xe90
> >   __lock_acquire+0x10b6/0x25e0
> >   lock_acquire+0xca/0x2c0
> >   _raw_spin_lock+0x2e/0x40
> >   igrab+0x1a/0xb0
> >   fserror_report+0x135/0x260
> >   iomap_finish_ioend_buffered+0x170/0x210
> >   clone_endio+0x8f/0x1c0
> >   blk_update_request+0x1e4/0x4d0
> >   blk_mq_end_request+0x1b/0x100
> >   virtblk_done+0x6f/0x110
> >   vring_interrupt+0x59/0x80
> >   __handle_irq_event_percpu+0x8a/0x2e0
> >   handle_irq_event+0x33/0x70
> >   handle_edge_irq+0xdd/0x1e0
> >   __common_interrupt+0x6f/0x180
> >   common_interrupt+0xb7/0xe0
> >   </IRQ>
> > 
> > It looks like the concern here is that inode::i_lock is sometimes taken
> > in IRQ context, and sometimes it is held when going to IRQ context,
> > though it's a little difficult to tell since I think this is a kernel
> > from after the actual 6.19 release but before 7.0-rc1.
> > 
> > Either way, we don't need to take i_lock, because filesystems should
> > not report files to fserror if they're about to be freed or have not
> > yet been exposed to other threads, because the resulting fsnotify report
> > will be meaningless.
> > 
> > Therefore, bump inode::i_count directly and clarify the preconditions on
> > the inode being passed in.
> 
> ...and now I realize that I got so hung up on email cc list composition

I honestly just use b4 prep --auto-to-cc

> that I neglected to notice that I forgot to update the commit message
> to say:
> 
> "Therefore, add the ioend to a queue and get an async worker to chug
> through the error events from process context with no filesystem locks
> already held."
> 
> Let's hope I got the paperwork right this time, all this friction to
> amend minor mistakes are why I don't want to be here anymore. <grumble>

You know, I can just add that for you when applying. :)

