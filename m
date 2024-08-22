Return-Path: <linux-fsdevel+bounces-26685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF395B057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642F8B25228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0516EBE8;
	Thu, 22 Aug 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz+OASuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061916A955
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315242; cv=none; b=XGbtwzqea8QxW0fkarBT1R6mMDgJ27cJmkm+K3CoEzf33iF6XZr8h/Lm1Sgo/IwzjA22sDIblE4QBGXW5MCevf21BwnemiY+8rRorLZ/h/oJl6tGqpjfA8i1CayEYkgwIbJdfUMQwYSlFNRkg8ZV+n16YDQCunUf69/ZHR60LXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315242; c=relaxed/simple;
	bh=Dwnsf4UNWYevThDQcTTMYDhQgYmmLs3HUaaYf/F85sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjmQUMZhHV3d5ixbqADlZRr5eO688eOG0dRH2zewigA7u4sqsC/zTf0u9ZuHYBbU7k+eNfs+0YBBvEYZ/KFxyVO3GHslli+zA2212yvg9K/I+4u4gfm6g2KIOFM4SFM2CfEGS5xwjVifnNy2jAm8Wo+zbpvHG2VvYLHv9LSnfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz+OASuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF08C4AF0B;
	Thu, 22 Aug 2024 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724315241;
	bh=Dwnsf4UNWYevThDQcTTMYDhQgYmmLs3HUaaYf/F85sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iz+OASuyhRUzTBAhlWpHofJdyfHOf0/CE2fFgnBS/y73SMTZw8M5XkkPZkL98Tcpk
	 rzMRaI3+gcZNOMPweanDpY/GIgmDlxRS9jhgl2qIkDMdI9kCHDEeX21K8FWSpr5JYN
	 S6dhsVDHxDZYDs78amgxXL5NgQFPs8YDP8XcdpnkKMbMzYivBG55VsGMqWGlGIP+hy
	 yGaJfo43R2LVPcfasHL/Opo7nFHjf7dfLUPXSS1oPtcJcTPw/yNjRP0HYPWxUjH15S
	 76oKk+Q4ULA+ll/+j9DHNQgyzgt4WRAlM356R/BK3gNrn3M5r1Z8GPL4NMBxrzAct/
	 8/xkPRSeXy5Kw==
Date: Thu, 22 Aug 2024 10:27:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
Message-ID: <20240822-knipsen-bebildert-b6f94efcb429@brauner>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org>
 <172427833589.6062.8614016543522604940@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172427833589.6062.8614016543522604940@noble.neil.brown.name>

On Thu, Aug 22, 2024 at 08:12:15AM GMT, NeilBrown wrote:
> On Thu, 22 Aug 2024, Christian Brauner wrote:
> > The i_state member is an unsigned long so that it can be used with the
> > wait bit infrastructure which expects unsigned long. This wastes 4 bytes
> > which we're unlikely to ever use. Switch to using the var event wait
> > mechanism using the address of the bit. Thanks to Linus for the address
> > idea.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/inode.c         | 10 ++++++++++
> >  include/linux/fs.h | 16 ++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 154f8689457f..f2a2f6351ec3 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -472,6 +472,16 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
> >  		inode->i_state |= I_REFERENCED;
> >  }
> >  
> > +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> > +					    struct inode *inode, u32 bit)
> > +{
> > +        void *bit_address;
> > +
> > +        bit_address = inode_state_wait_address(inode, bit);
> > +        init_wait_var_entry(wqe, bit_address, 0);
> > +        return __var_waitqueue(bit_address);
> > +}
> > +
> >  /*
> >   * Add inode to LRU if needed (inode is unused and clean).
> >   *
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 23e7d46b818a..a5b036714d74 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -744,6 +744,22 @@ struct inode {
> >  	void			*i_private; /* fs or device private pointer */
> >  } __randomize_layout;
> >  
> > +/*
> > + * Get bit address from inode->i_state to use with wait_var_event()
> > + * infrastructre.
> > + */
> > +#define inode_state_wait_address(inode, bit) ((char *)&(inode)->i_state + (bit))
> > +
> > +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> > +					    struct inode *inode, u32 bit);
> > +
> > +static inline void inode_wake_up_bit(struct inode *inode, u32 bit)
> > +{
> > +	/* Ensure @bit will be seen cleared/set when caller is woken up. */
> 
> The above comment is wrong.  I think I once thought it was correct too
> but now I know better (I hope).
> A better comment might be
>        /* Insert memory barrier as recommended by wake_up_var() */
> but even that is unnecessary as we don't need the memory barrier.
> 
> A careful reading of memory-barriers.rst shows that *when the process is
> actually woken* there are sufficient barriers in wake_up_process() and
> prepare_wait_event() and the scheduler and (particularly)
> set_current_state() so that a value set before the wake_up is seen after
> the schedule().
> 
> So this barrier isn't about the bit.  This barrier is about the
> wait_queue.  In particular it is about waitqueue_active() call at the
> start of wake_up_var().  If that test wasn't there and if instead
> wake_up_var() conditionally called __wake_up(), then there would be no

Did you mean "unconditionally called"?

> need for any barrier.  A comment near wake_up_bit() makes it clear that
> the barrier is only needed when the spinlock is avoided.
> 
> On a weakly ordered arch, this test can be effected *before* the write
> of the bit.  If the waiter adds itself to the wait queue and then tests
> the bit before the bit is set, but after the waitqueue_active() test is
> put in effect, then the wake_up will never be sent.
> 
> But ....  this is all academic of this code because you don't need a
> barrier at all.  The wake_up happens in a spin_locked region, and the
> wait is entirely inside the same spin_lock, except for the schedule.  A
> later patch has:
>      spin_unlock(); schedule(); spin_lock();
> 
> So there is no room for a race.  If the bit is cleared before the
> wait_var_event() equivalent, then no wakeup is needed.  When the lock is
> dropped after the bit is cleared the unlock will have all the barriers
> needed for the bit to be visible.
> 
> The only other place that the bit can be cleared is concurrent with the
> above schedule() while the spinlock isn't held by the waiter.  In that
> case it is again clear that no barrier is needed - or that the
> spin_unlock/lock provide all the needed barriers.
> 
> So a better comment would be
> 
>    /* no barrier needs as both waker and waiter are in spin-locked regions */

Thanks for the analysis. I was under the impression that wait_on_inode()
was called in contexts where no barrier is guaranteed and the bit isn't
checked with spin_lock() held.

