Return-Path: <linux-fsdevel+bounces-77197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPqKCWUOkGkPVwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 06:55:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3913B2BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 06:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB06302E43F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9D2DEA8C;
	Sat, 14 Feb 2026 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwwaQhzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFCF513;
	Sat, 14 Feb 2026 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048537; cv=none; b=khceuhHDjPulewV9NdRzFnUDMCEixWzgRiEB+6ma8arxjZJMBJCFAQfubJpEM+Yoa0RXENuZvnuqbOR3I9xsNgSAGAPjvC2CsbVk0ODJKcxu7lFSdslW8p3Jgx5bDXZ8ZNKmRNlLNedgRZaKjIrtJGnl1LFxiEDso/37SgfmYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048537; c=relaxed/simple;
	bh=blRqj19K7y2CHRmqGJrwLRU9MgNEaUSBD6Ezz1anZrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjQJxCHufEPIn2WoTd9KKQpB3XyzdjNwswkjxUzICH0TMkcbPSdaT7+7VRXdgjFNCYBDMd+Vkh6MPaW1aKO1Cucs3/OADeQESf0pT/m28Ox5WLAixBzHBPFNfEeV9P/AvtV4kiqO7S0ntdm2Kk1DVcPZWhD++8H6StOoCneX9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwwaQhzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E2C19421;
	Sat, 14 Feb 2026 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771048537;
	bh=blRqj19K7y2CHRmqGJrwLRU9MgNEaUSBD6Ezz1anZrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwwaQhzR4IL90e6SDZ30WsEtFB8njlCpy3Zfq+S1uPf51SDLUkCu1Lz0GNsNSrQ2v
	 rCxlY9fBj5bCg+BhwRnTrMOdM0f0awNIqoqvIZkvRj/IbbmBc004YDbybr7J9t/qv1
	 6J2WPglfUOBwPx7h0li8u0zhUqsbOtSXhrdXwSfchew7PJT0ne8HecWj8TxpOxzxug
	 9TRTyLloW6ztpca84o+ew5SVnSmO9MYKlZyWPEESV6w7fieUKYJnVfs2BnVTijimJD
	 2bqirQnXRP9Q4mg/JyxHoWhwZfAMAjBgb79vK01IS9Wx3xSy8z+rfdLe2tMSd7wWuP
	 tUvg3tQbWytFw==
Date: Fri, 13 Feb 2026 21:55:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <dgc@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <20260214055536.GW1535390@frogsfrogsfrogs>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
 <aY-n4leNi4NCzri1@dread>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY-n4leNi4NCzri1@dread>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77197-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF3913B2BB
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 09:38:26AM +1100, Dave Chinner wrote:
> On Fri, Feb 13, 2026 at 11:07:57AM -0800, Darrick J. Wong wrote:
> > On Fri, Feb 13, 2026 at 08:00:41AM -0800, Darrick J. Wong wrote:
> > > On Thu, Feb 12, 2026 at 10:15:57PM -0800, Christoph Hellwig wrote:
> > > > [  149.498163] other info that might help us debug this:
> > > > [  149.498163]  Possible unsafe locking scenario:
> > > > [  149.498163] 
> > > > [  149.498163]        CPU0
> > > > [  149.498163]        ----
> > > > [  149.498163]   lock(&sb->s_type->i_lock_key#33);
> > > > [  149.498163]   <Interrupt>
> > > > [  149.498163]     lock(&sb->s_type->i_lock_key#33);
> > > 
> > > Er... is lockdep telling us here that we could take i_lock in
> > > unlock_new_inode, get interrupted, and then take another i_lock?
> 
> Yes.
> 
> > > > [  149.498163] 
> > > > [  149.498163]  *** DEADLOCK ***
> > > > [  149.498163] 
> > > > [  149.498163] 1 lock held by swapper/1/0:
> > > > [  149.498163]  #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
> > > > [  149.498163] 
> > > > [  149.498163] stack backtrace:
> > > > [  149.498163] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full) 
> > > > [  149.498163] Tainted: [N]=TEST
> > > > [  149.498163] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > > > [  149.498163] Call Trace:
> > > > [  149.498163]  <IRQ>
> > > > [  149.498163]  dump_stack_lvl+0x5b/0x80
> > > > [  149.498163]  print_usage_bug.part.0+0x22c/0x2c0
> > > > [  149.498163]  mark_lock+0xa6f/0xe90
> > > > [  149.498163]  __lock_acquire+0x10b6/0x25e0
> > > > [  149.498163]  lock_acquire+0xca/0x2c0
> > > > [  149.498163]  _raw_spin_lock+0x2e/0x40
> > > > [  149.498163]  igrab+0x1a/0xb0
> > > > [  149.498163]  fserror_report+0x135/0x260
> > > > [  149.498163]  iomap_finish_ioend_buffered+0x170/0x210
> > > > [  149.498163]  clone_endio+0x8f/0x1c0
> > > > [  149.498163]  blk_update_request+0x1e4/0x4d0
> > > > [  149.498163]  blk_mq_end_request+0x1b/0x100
> > > > [  149.498163]  virtblk_done+0x6f/0x110
> > > > [  149.498163]  vring_interrupt+0x59/0x80
> 
> Ok, so why are we calling iomap_finish_ioend_buffered() from IRQ
> context? That looks like a bug because the only IO completion call
> chain that can get into iomap_finish_ioend_buffered() is supposedly:
> 
> iomap_finish_ioends
>   iomap_finish_ioend
>     iomap_finish_ioend_buffered
> 
> And the comment above iomap_finish_ioends() says:
> 
> /*
>  * Ioend completion routine for merged bios. This can only be called from task
>  * contexts as merged ioends can be of unbound length. Hence we have to break up
>  * the writeback completions into manageable chunks to avoid long scheduler
>  * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
>  * good batch processing throughput without creating adverse scheduler latency
>  * conditions.
>  */
> 
> Ah, there's the problem - pure buffered overwrites from XFS use
> ioend_writeback_end_bio(), not xfs_end_bio(). Hence the buffered
> write completion is not punted to a workqueue, and it calls
> iomap_finish_ioend_buffered() direct from the bio completion
> context.
> 
> Yeah, that seems like a bug that needs fixing in the
> ioend_writeback_end_bio() function - if there's an IO error, it
> needs to punt the processing of the ioend to a workqueue...

<nod> That's a much simpler approach, particularly if we're only bumping
to a workqueue to handle IO errors (which means there's no need for
merging).

> > > > [  149.498163]  __handle_irq_event_percpu+0x8a/0x2e0
> > > > [  149.498163]  handle_irq_event+0x33/0x70
> > > > [  149.498163]  handle_edge_irq+0xdd/0x1e0
> > > > [  149.498163]  __common_interrupt+0x6f/0x180
> > > > [  149.498163]  common_interrupt+0xb7/0xe0
> > > 
> > > Hrmm, so we're calling fserror_report/igrab from an interrupt handler.
> > > The bio endio function is for writeback ioend completion.
> 
> Yup, this is one of the reasons writeback doesn't hold an inode
> reference over IO - we can't call iput() from an interrupt context.
> 
> > > igrab takes i_lock to check if the inode is in FREEING or WILL_FREE
> > > state.  However, the fact that it's in writeback presumably means that
> > > the vfs still holds an i_count on this inode,
> 
> Writeback holds an inode reference over submission only.
> 
> > > so the inode cannot be
> > > freed until iomap_finish_ioend_buffered completes.
> 
> iput()->iput_final()->evict will block in inode_wait_for_writeback()
> waiting for outstanding writeback to complete before it starts
> tearing down the inode. This isn't controlled by reference counts.
> 
> > /me hands himself another cup of coffee, changes that to:
> > 
> > 	/*
> > 	 * Can't iput from non-sleeping context, so grabbing another
> > 	 * reference to the inode must be the last thing before
> > 	 * submitting the event.  Open-code the igrab here to avoid
> > 	 * taking i_lock in interrupt context.
> > 	 */
> > 	if (inode) {
> > 		WARN_ON_ONCE(inode_unhashed(inode));
> > 		WARN_ON_ONCE(inode_state_read_once(inode) &
> > 					(I_NEW | I_FREEING | I_WILL_FREE));
> 
> It is valid for the inode have a zero reference count and have either
> I_FREEING or I_WILL_FREE set here if another task has dropped the
> final inode reference while writeback IO is still in flight.
> 
> > 		if (!atomic_inc_not_zero(&inode->i_count))
> > 			goto lost_event;
> 
> Overall, I'm not sure using atomic_inc_not_zero() is safe here. It
> may be, but I don't think this is how the problem should be solved.

I /think/ it works because evict waits for writeback to end (so the
inode can't go away) and we never attach the inode to the error event if
the i_count already hit zero buuut this is a code smell anyway so I've
little interest in pursuing this part further.

> Punt ioend w/ IO errors to a work queue, and then nothing needs to
> change w.r.t. the fserror handling of the inodes. i.e. it will be
> save to use inode->i_lock and hence igrab()...

<nod> Will test that out.  Thanks for the suggestion.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> dgc@kernel.org

