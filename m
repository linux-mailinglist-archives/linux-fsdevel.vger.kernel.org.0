Return-Path: <linux-fsdevel+bounces-77170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAOtMJp2j2lERAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:08:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441E13919D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 20:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C60306028C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF49274B4D;
	Fri, 13 Feb 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC8uvM0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F9261393;
	Fri, 13 Feb 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009678; cv=none; b=mNuPHCF3PlauUeQyeiF6sf2NnzFTlMp6glSEjWHF7YIH/KCNPR9/AmUkaF44uSIYZjz1dmSP8fT8C1rTUkrF8vZm/i9qRAdgYd7m4HnEkTdS0RGBhsqyu+C4XzFOkXircDrUpHvRXCpFj2TB8vvsYP7t1c/TMdKzz3KRVA2voYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009678; c=relaxed/simple;
	bh=gL0jlOkR5XShu7QlIaRfvZvyzQCvZJ0ZxvXNGAs15EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5n6rKP1FEzyOKnco5HrOIwfuk6EbZCGoffKf9GXE2AnWwU4qeLrT4ck1JmgqQr+CTxYk1hIKmev8wgGJ3E9XConps8/9tJdVI+s+/yFr35yVyt846ROs3SGw0l4ESmDPvkvLrPIoyzaeysTFGKt/fZp6KXfBY+hRmjdsCzY61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC8uvM0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B1C116C6;
	Fri, 13 Feb 2026 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771009678;
	bh=gL0jlOkR5XShu7QlIaRfvZvyzQCvZJ0ZxvXNGAs15EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bC8uvM0KztFNefOPSM+a4Q2NFvrYRUOJZ7DiJW+WoV7pHRQLvz1VjhLfnslgmVHKE
	 dn/F7A21A6ybM7b0MY3e7xH4E74bIIYmM1snGq5kHe1HurfFZM0KN7rs6I2XfPO/AP
	 iqlQp8NROA5Cvs+ERXCcZF5qlsiWQH3LRzEqljwNw6FY2YeW+IZ4l+FycAwKb7u4xT
	 hxgDzN+klUDBcp88I60cXaNJzlcaOX0w4kcXgb/7VbJsFf/o8jFXUin399CkHgjCpO
	 JhGKDdDiTsJomWeVSuiKd+C+nwMVW1Pr9TBUHAhMnLDL6SnhdEiGGTdajTRrRWMd45
	 fzYREHZiucbpA==
Date: Fri, 13 Feb 2026 11:07:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <20260213190757.GJ7693@frogsfrogsfrogs>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213160041.GT1535390@frogsfrogsfrogs>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77170-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2441E13919D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:00:41AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 12, 2026 at 10:15:57PM -0800, Christoph Hellwig wrote:
> > xfstests generic/108 makes lockdep unhappy with the new fserror code
> > in Linus' tree, see the trace below.  The problem seems to be that
> > igrab takes i_lock to protect against a inode that is beeing freed.
> > Error reporting doesn't care about that, but we don't really have
> > a good interface to just grab a reference.
> > 
> > [  149.494670] ================================
> > [  149.494871] WARNING: inconsistent lock state
> > [  149.495073] 6.19.0+ #4827 Tainted: G                 N 
> > [  149.495336] --------------------------------
> > [  149.495560] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > [  149.495857] swapper/1/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > [  149.496111] ffff88811ed1b140 (&sb->s_type->i_lock_key#33){?.+.}-{3:3}, at: igrab+0x1a/0xb0
> > [  149.496543] {HARDIRQ-ON-W} state was registered at:
> > [  149.496853]   lock_acquire+0xca/0x2c0
> > [  149.497057]   _raw_spin_lock+0x2e/0x40
> > [  149.497257]   unlock_new_inode+0x2c/0xc0
> > [  149.497460]   xfs_iget+0xcf4/0x1080
> > [  149.497643]   xfs_trans_metafile_iget+0x3d/0x100
> > [  149.497882]   xfs_metafile_iget+0x2b/0x50
> > [  149.498144]   xfs_mount_setup_metadir+0x20/0x60
> > [  149.498163]   xfs_mountfs+0x457/0xa60
> > [  149.498163]   xfs_fs_fill_super+0x6b3/0xa90
> > [  149.498163]   get_tree_bdev_flags+0x13c/0x1e0
> > [  149.498163]   vfs_get_tree+0x27/0xe0
> > [  149.498163]   vfs_cmd_create+0x54/0xe0
> > [  149.498163]   __do_sys_fsconfig+0x309/0x620
> > [  149.498163]   do_syscall_64+0x8b/0xf80
> > [  149.498163]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  149.498163] irq event stamp: 139080
> > [  149.498163] hardirqs last  enabled at (139079): [<ffffffff813a923c>] do_idle+0x1ec/0x270
> > [  149.498163] hardirqs last disabled at (139080): [<ffffffff828a8d09>] common_interrupt+0x19/0xe0
> > [  149.498163] softirqs last  enabled at (139032): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> > [  149.498163] softirqs last disabled at (139025): [<ffffffff8134a853>] __irq_exit_rcu+0xc3/0x120
> > [  149.498163] 
> > [  149.498163] other info that might help us debug this:
> > [  149.498163]  Possible unsafe locking scenario:
> > [  149.498163] 
> > [  149.498163]        CPU0
> > [  149.498163]        ----
> > [  149.498163]   lock(&sb->s_type->i_lock_key#33);
> > [  149.498163]   <Interrupt>
> > [  149.498163]     lock(&sb->s_type->i_lock_key#33);
> 
> Er... is lockdep telling us here that we could take i_lock in
> unlock_new_inode, get interrupted, and then take another i_lock?
> 
> > [  149.498163] 
> > [  149.498163]  *** DEADLOCK ***
> > [  149.498163] 
> > [  149.498163] 1 lock held by swapper/1/0:
> > [  149.498163]  #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
> > [  149.498163] 
> > [  149.498163] stack backtrace:
> > [  149.498163] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full) 
> > [  149.498163] Tainted: [N]=TEST
> > [  149.498163] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > [  149.498163] Call Trace:
> > [  149.498163]  <IRQ>
> > [  149.498163]  dump_stack_lvl+0x5b/0x80
> > [  149.498163]  print_usage_bug.part.0+0x22c/0x2c0
> > [  149.498163]  mark_lock+0xa6f/0xe90
> > [  149.498163]  ? mempool_alloc_noprof+0x91/0x130
> > [  149.498163]  ? set_track_prepare+0x39/0x60
> > [  149.498163]  ? mempool_alloc_noprof+0x91/0x130
> > [  149.498163]  ? fserror_report+0x8a/0x260
> > [  149.498163]  ? iomap_finish_ioend_buffered+0x170/0x210
> > [  149.498163]  ? clone_endio+0x8f/0x1c0
> > [  149.498163]  ? blk_update_request+0x1e4/0x4d0
> > [  149.498163]  ? blk_mq_end_request+0x1b/0x100
> > [  149.498163]  ? virtblk_done+0x6f/0x110
> > [  149.498163]  ? vring_interrupt+0x59/0x80
> > [  149.498163]  ? __handle_irq_event_percpu+0x8a/0x2e0
> > [  149.498163]  ? handle_irq_event+0x33/0x70
> > [  149.498163]  ? handle_edge_irq+0xdd/0x1e0
> > [  149.498163]  __lock_acquire+0x10b6/0x25e0
> > [  149.498163]  ? __pcs_replace_empty_main+0x369/0x510
> > [  149.498163]  ? __pcs_replace_empty_main+0x369/0x510
> > [  149.498163]  lock_acquire+0xca/0x2c0
> > [  149.498163]  ? igrab+0x1a/0xb0
> > [  149.498163]  ? rcu_is_watching+0x11/0x50
> > [  149.498163]  ? __kmalloc_noprof+0x3ab/0x5a0
> > [  149.498163]  _raw_spin_lock+0x2e/0x40
> > [  149.498163]  ? igrab+0x1a/0xb0
> > [  149.498163]  igrab+0x1a/0xb0
> > [  149.498163]  fserror_report+0x135/0x260
> > [  149.498163]  iomap_finish_ioend_buffered+0x170/0x210
> > [  149.498163]  ? __pfx_stripe_end_io+0x10/0x10
> > [  149.498163]  clone_endio+0x8f/0x1c0
> > [  149.498163]  blk_update_request+0x1e4/0x4d0
> > [  149.498163]  ? __pfx_sg_pool_free+0x10/0x10
> > [  149.498163]  ? mempool_free+0x3d/0x50
> > [  149.498163]  blk_mq_end_request+0x1b/0x100
> > [  149.498163]  virtblk_done+0x6f/0x110
> > [  149.498163]  vring_interrupt+0x59/0x80
> > [  149.498163]  __handle_irq_event_percpu+0x8a/0x2e0
> > [  149.498163]  handle_irq_event+0x33/0x70
> > [  149.498163]  handle_edge_irq+0xdd/0x1e0
> > [  149.498163]  __common_interrupt+0x6f/0x180
> > [  149.498163]  common_interrupt+0xb7/0xe0
> 
> Hrmm, so we're calling fserror_report/igrab from an interrupt handler.
> The bio endio function is for writeback ioend completion.
> 
> igrab takes i_lock to check if the inode is in FREEING or WILL_FREE
> state.  However, the fact that it's in writeback presumably means that
> the vfs still holds an i_count on this inode, so the inode cannot be
> freed until iomap_finish_ioend_buffered completes.  So perhaps instead
> of calling igrab directly, could we perhaps get away with:
> 
> 	/*
> 	 * Only referenced inodes may be passed into this function!
> 	 * This means they cannot be INEW, FREEING, or WILL_FREE.
> 	 *
> 	 * Can't iput from non-sleeping context, so grabbing another
> 	 * reference must be the last thing before submitting the event
> 	 */
> 	if (inode && !atomic_inc_not_zero(&inode->i_count)) {
> 		/* warn about precondition violation and lost error */
> 		goto lost_event;
> 	}
> 
> 	schedule_work(&event->work);
> 
> Hm?

/me hands himself another cup of coffee, changes that to:

	/*
	 * Can't iput from non-sleeping context, so grabbing another
	 * reference to the inode must be the last thing before
	 * submitting the event.  Open-code the igrab here to avoid
	 * taking i_lock in interrupt context.
	 */
	if (inode) {
		WARN_ON_ONCE(inode_unhashed(inode));
		WARN_ON_ONCE(inode_state_read_once(inode) &
					(I_NEW | I_FREEING | I_WILL_FREE));

		if (!atomic_inc_not_zero(&inode->i_count))
			goto lost_event;
		event->inode = inode;
	}

This seems to fix the lockdep report, will send that out for full
testing this evening.

--D

> It also occurred to me that we shouldn't be calling fserror_report on
> any of the metadata inodes, which means another fixpatch is needed for
> the callsites in xfs_health.c.
> 
> --D
> 
> > [  149.498163]  </IRQ>
> > [  149.498163]  <TASK>
> > [  149.498163]  asm_common_interrupt+0x26/0x40
> > [  149.498163] RIP: 0010:default_idle+0xf/0x20
> > [  149.498163] Code: 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d a9 88 15 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> > [  149.498163] RSP: 0018:ffffc9000009fed8 EFLAGS: 00000206
> > [  149.498163] RAX: 0000000000021f47 RBX: ffff888100ad53c0 RCX: 0000000000000000
> > [  149.498163] RDX: 0000000000000000 RSI: ffffffff83278fb9 RDI: ffffffff8329090b
> > [  149.498163] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> > [  149.498163] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> > [  149.498163] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [  149.498163]  default_idle_call+0x7e/0x1a0
> > [  149.498163]  do_idle+0x1ec/0x270
> > [  149.498163]  cpu_startup_entry+0x24/0x30
> > [  149.498163]  start_secondary+0xf7/0x100
> > [  149.498163]  common_startup_64+0x13e/0x148
> > [  149.498163]  </TASK>
> 

