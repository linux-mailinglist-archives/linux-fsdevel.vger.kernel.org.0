Return-Path: <linux-fsdevel+bounces-77187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LvtN/unj2lgSQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:38:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 857E8139D24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42546303DD18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A73304BA3;
	Fri, 13 Feb 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM97uQ/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0C2580D7;
	Fri, 13 Feb 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022320; cv=none; b=LortIQ9+OaQ0ZCxQqPhDmJvxGkFFu3WmacUw/1Reh0LbyxsC1NBJ9EcXoerKGnCKUMWAbjZS/v59Xx0tonbNyfSsqqGhQWODpBvi6M8OVPz1T8eZwqLPulFynDF5QtMHo+3keR8JPSuoS5m2cg5ryfxC+Igk21Zipfgm8i8UfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022320; c=relaxed/simple;
	bh=Ve8YwiigmrDNnLpgP+LGYVw5qMqRy8pGkihEnM4HGU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkhwRW2RcamSQnAfdKL70cax8x3kbnqfHL8O+jKwvkAfhg38cq5C8Np/pNv9xdp1K9sUKGLadQodRQ5SiYMHtBSlxpYT43leG3ybUKPdqSykuF8J70YVh5kKYjyJOKIYQ6hj0xyDth+tR42P4BhlSz38yntwgHmdhXWCxDt//cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM97uQ/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94EBC116C6;
	Fri, 13 Feb 2026 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771022320;
	bh=Ve8YwiigmrDNnLpgP+LGYVw5qMqRy8pGkihEnM4HGU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM97uQ/jZL8Byarre/CtJi3EvtDh+ZpxLTcE691Ixua0anP9MVXlaekK0VKZpHyo2
	 2i0J1Oc06ZX8eYourC9B2WAKmSvW/kZsjeY97pJv4h1XTXAyJ/UMt1wC9e/AMnrQ9R
	 jI+G4D2Uy4Cb+Y0qFDtuAH2RINx/oHogOaAe2RdMiYQ65ZtOWNpr+DMrb+ewHVlg+K
	 gukZdU9wsxMtGK8cBuKgIjvg1sdvGjR/dOso1rKhJIYqElj+YJrcsWuAvOOcyKmWT7
	 LvxUOqEt0r3E+C+1f5anbSbJhyK1HQHMZnxOHalgAO8mw43Dr2nzxOBWXg6kXPww+r
	 9tN8nmrvZPypQ==
Date: Sat, 14 Feb 2026 09:38:26 +1100
From: Dave Chinner <dgc@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: inconsistent lock state in the new fserror code
Message-ID: <aY-n4leNi4NCzri1@dread>
References: <aY7BndIgQg3ci_6s@infradead.org>
 <20260213160041.GT1535390@frogsfrogsfrogs>
 <20260213190757.GJ7693@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213190757.GJ7693@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77187-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url]
X-Rspamd-Queue-Id: 857E8139D24
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:07:57AM -0800, Darrick J. Wong wrote:
> On Fri, Feb 13, 2026 at 08:00:41AM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 12, 2026 at 10:15:57PM -0800, Christoph Hellwig wrote:
> > > [  149.498163] other info that might help us debug this:
> > > [  149.498163]  Possible unsafe locking scenario:
> > > [  149.498163] 
> > > [  149.498163]        CPU0
> > > [  149.498163]        ----
> > > [  149.498163]   lock(&sb->s_type->i_lock_key#33);
> > > [  149.498163]   <Interrupt>
> > > [  149.498163]     lock(&sb->s_type->i_lock_key#33);
> > 
> > Er... is lockdep telling us here that we could take i_lock in
> > unlock_new_inode, get interrupted, and then take another i_lock?

Yes.

> > > [  149.498163] 
> > > [  149.498163]  *** DEADLOCK ***
> > > [  149.498163] 
> > > [  149.498163] 1 lock held by swapper/1/0:
> > > [  149.498163]  #0: ffff8881052c81a0 (&vblk->vqs[i].lock){-.-.}-{3:3}, at: virtblk_done+0x4b/0x110
> > > [  149.498163] 
> > > [  149.498163] stack backtrace:
> > > [  149.498163] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G                 N  6.19.0+ #4827 PREEMPT(full) 
> > > [  149.498163] Tainted: [N]=TEST
> > > [  149.498163] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > > [  149.498163] Call Trace:
> > > [  149.498163]  <IRQ>
> > > [  149.498163]  dump_stack_lvl+0x5b/0x80
> > > [  149.498163]  print_usage_bug.part.0+0x22c/0x2c0
> > > [  149.498163]  mark_lock+0xa6f/0xe90
> > > [  149.498163]  __lock_acquire+0x10b6/0x25e0
> > > [  149.498163]  lock_acquire+0xca/0x2c0
> > > [  149.498163]  _raw_spin_lock+0x2e/0x40
> > > [  149.498163]  igrab+0x1a/0xb0
> > > [  149.498163]  fserror_report+0x135/0x260
> > > [  149.498163]  iomap_finish_ioend_buffered+0x170/0x210
> > > [  149.498163]  clone_endio+0x8f/0x1c0
> > > [  149.498163]  blk_update_request+0x1e4/0x4d0
> > > [  149.498163]  blk_mq_end_request+0x1b/0x100
> > > [  149.498163]  virtblk_done+0x6f/0x110
> > > [  149.498163]  vring_interrupt+0x59/0x80

Ok, so why are we calling iomap_finish_ioend_buffered() from IRQ
context? That looks like a bug because the only IO completion call
chain that can get into iomap_finish_ioend_buffered() is supposedly:

iomap_finish_ioends
  iomap_finish_ioend
    iomap_finish_ioend_buffered

And the comment above iomap_finish_ioends() says:

/*
 * Ioend completion routine for merged bios. This can only be called from task
 * contexts as merged ioends can be of unbound length. Hence we have to break up
 * the writeback completions into manageable chunks to avoid long scheduler
 * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
 * good batch processing throughput without creating adverse scheduler latency
 * conditions.
 */

Ah, there's the problem - pure buffered overwrites from XFS use
ioend_writeback_end_bio(), not xfs_end_bio(). Hence the buffered
write completion is not punted to a workqueue, and it calls
iomap_finish_ioend_buffered() direct from the bio completion
context.

Yeah, that seems like a bug that needs fixing in the
ioend_writeback_end_bio() function - if there's an IO error, it
needs to punt the processing of the ioend to a workqueue...

> > > [  149.498163]  __handle_irq_event_percpu+0x8a/0x2e0
> > > [  149.498163]  handle_irq_event+0x33/0x70
> > > [  149.498163]  handle_edge_irq+0xdd/0x1e0
> > > [  149.498163]  __common_interrupt+0x6f/0x180
> > > [  149.498163]  common_interrupt+0xb7/0xe0
> > 
> > Hrmm, so we're calling fserror_report/igrab from an interrupt handler.
> > The bio endio function is for writeback ioend completion.

Yup, this is one of the reasons writeback doesn't hold an inode
reference over IO - we can't call iput() from an interrupt context.

> > igrab takes i_lock to check if the inode is in FREEING or WILL_FREE
> > state.  However, the fact that it's in writeback presumably means that
> > the vfs still holds an i_count on this inode,

Writeback holds an inode reference over submission only.

> > so the inode cannot be
> > freed until iomap_finish_ioend_buffered completes.

iput()->iput_final()->evict will block in inode_wait_for_writeback()
waiting for outstanding writeback to complete before it starts
tearing down the inode. This isn't controlled by reference counts.

> /me hands himself another cup of coffee, changes that to:
> 
> 	/*
> 	 * Can't iput from non-sleeping context, so grabbing another
> 	 * reference to the inode must be the last thing before
> 	 * submitting the event.  Open-code the igrab here to avoid
> 	 * taking i_lock in interrupt context.
> 	 */
> 	if (inode) {
> 		WARN_ON_ONCE(inode_unhashed(inode));
> 		WARN_ON_ONCE(inode_state_read_once(inode) &
> 					(I_NEW | I_FREEING | I_WILL_FREE));

It is valid for the inode have a zero reference count and have either
I_FREEING or I_WILL_FREE set here if another task has dropped the
final inode reference while writeback IO is still in flight.

> 		if (!atomic_inc_not_zero(&inode->i_count))
> 			goto lost_event;

Overall, I'm not sure using atomic_inc_not_zero() is safe here. It
may be, but I don't think this is how the problem should be solved.
Punt ioend w/ IO errors to a work queue, and then nothing needs to
change w.r.t. the fserror handling of the inodes. i.e. it will be
save to use inode->i_lock and hence igrab()...

Cheers,

Dave.
-- 
Dave Chinner
dgc@kernel.org

