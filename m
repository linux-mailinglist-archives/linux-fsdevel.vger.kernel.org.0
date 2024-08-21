Return-Path: <linux-fsdevel+bounces-26575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2F95A856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDAC1C22097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5E17B516;
	Wed, 21 Aug 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nd6Uiale"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B126ACB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283303; cv=none; b=c44iS3nE90U983m1GY6SPuKipWe383subsE4u4hGxOxmqi3o1OsI3ughkTQVowEvFQKbA5BYB3dsuY1JtHVVzpWR5TrOk4u+QHyHS1nbv4iqE0j3qUQR0isvtSnt/PcyPtd444EVsdmOCVq+aiCCYI8T9bOQbH76QmGzPT8dIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283303; c=relaxed/simple;
	bh=BbpM3vyeDRC61PN04zwGvITm/BFiV4uz0JChRO/hmcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYwZCnYcYMj18jDWnoJ7Stt/PsV3UnQyc13nNgPqi7A/kuB++WN/3pBtp4CBifBCmD3bAeXMhhmYGMC1LqTIK+ptdI768usOruC2msO6XpfYVG8jblCw8J9aLOQ6/Rj7nrGqDC+574TW1FiuVTEbE4fd8vE2BfmzPlXilcNkgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nd6Uiale; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso172920a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724283301; x=1724888101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cX6ByT7lL0e/y2jzN84NNLpv4N2ySSzxMUXamIxoejI=;
        b=nd6UialeJ3EquyYMhqg0NXT2Wi/coJW9ct6tsVRJfRdPubA6+iFMUbYqA3Y+LuT4hS
         ScICJAwamil2bI0DFY28j6LS/78o9FJsTHARwq5ocy5RC3WShoaCs5nLAsCKR6W1lNLy
         4qj5GH5cFAXDOsbU3HYK72FSLxeJwiC6q4K2ZqpnNL3jql2ICnObxkvJ+INnggw7Xtof
         ga+eyhT9BPNQYy2dn+no6SZdlnnjtkCbWCvMpz3wcP9JbckEhU9Jxs2GraJfQ3rzLCix
         mCjt0L6/RlrLzFVHfbnIi5GkWJh9GQRNIvnF3hA8nieToeu6XonEO3WGvb9wH7Z0r9mq
         yXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724283301; x=1724888101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX6ByT7lL0e/y2jzN84NNLpv4N2ySSzxMUXamIxoejI=;
        b=BIWTs/dih21iToqkIE49FeadLYlDS+XMnluPn2NUAfIviAwkX7XZEsDMGyZ55HSOGK
         ETzbskPmptsI/tpjxMD+8ikUXOT46FvH3INvcUb0vmuK8N3wOQKpUzRMeUjMV1B4beAf
         ljabk5bhcymOm5foOq5rKmJ8Lw8u3pIk0i/E0KWjMt8JNwqv3mFvqQ8pIquTZZ/APF4v
         h+HitSqQXGSL5R5K1Mpp3V4b2mQjARDAZYMaKt71SWqPVwXX1aDFfP0UmH0pzigWN5Xu
         I+T13e1z+WD+I0dNz9/2v+gJ11o9GgmGkCp8NlSeiKZdNBslgQFF23fMlO2wwslw1hHT
         oWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUc1VLCYUuD/nFPoUA56MM/iSy+GW+QnACbpH6joWfk662vMNHFlLe46mFSWHy59mh+8rVKBVtNz/SFkNE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tieabl3TPFczw124RN0/2qyxzOVG9T/zzfcumjW3BLtiY8zE
	E0InnDLlPxb43DrCDMDS9atAninqjAewXuAyyv43lUs6NhVwKs/aLq6x9+ZOSeI=
X-Google-Smtp-Source: AGHT+IFWOiRHEDSMGrKypvaQvDHj+y8vihR9BsQh8t5Ps1YROyNgT+b+BY/duLFWkX9NSuR5PEiitg==
X-Received: by 2002:a05:6a21:3103:b0:1c4:230b:5ec7 with SMTP id adf61e73a8af0-1cad7f94c8dmr5395807637.15.1724283301244;
        Wed, 21 Aug 2024 16:35:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343060fcsm192818b3a.151.2024.08.21.16.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:35:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sguqw-007zp3-1L;
	Thu, 22 Aug 2024 09:34:58 +1000
Date: Thu, 22 Aug 2024 09:34:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
Message-ID: <ZsZ5otBAqL5Wir1j@dread.disaster.area>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-1-67244769f102@kernel.org>
 <172427833589.6062.8614016543522604940@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172427833589.6062.8614016543522604940@noble.neil.brown.name>

On Thu, Aug 22, 2024 at 08:12:15AM +1000, NeilBrown wrote:
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
> need for any barrier.  A comment near wake_up_bit() makes it clear that
> the barrier is only needed when the spinlock is avoided.

Oh, I missed that *landmine*.

So almost none of the current uses of wake_up_var() have an explicit
memory barrier before them, and a lot of them are not done under
spin locks. I suspect that the implicit store ordering of the wake
queue check is mostly only handled by chance - an
atomic_dec_and_test() or smp_store_release() call is made before
wake_up_var() or the wait/wakeup is synchronised by an external
lock.

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

Right, that's exactly the problem with infrastructure that
externalises memory ordering dependencies. Most of the time they
just work because of external factors, but sometimes they don't and
we get random memory barriers being cargo culted around the place
because that seems to fix weird problems....

> The only other place that the bit can be cleared is concurrent with the
> above schedule() while the spinlock isn't held by the waiter.  In that
> case it is again clear that no barrier is needed - or that the
> spin_unlock/lock provide all the needed barriers.
> 
> So a better comment would be
> 
>    /* no barrier needs as both waker and waiter are in spin-locked regions */
           ^^^^^^^
	   ordering

Even better would be to fix wake_up_var() to not have an implicit
ordering requirement. Add __wake_up_var() as the "I know what I'm
doing" API, and have wake_up_var() always issue the memory barrier
like so:

__wake_up_var(var)
{
	__wake_up_bit(....);
}

wake_up_var(var)
{
	smp_mb();
	__wake_up_var(var);
}

Then people who don't intimately understand ordering (i.e. just want
to use a conditional wait variable) or just don't want to
think about complex memory ordering issues for otherwise obvious and
simple code can simply use the safe variant.

Those that need to optimise for speed or know they have solid
ordering or external serialisation can use __wake_up_var() and leave
a comment as to why that is safe. i.e.:

	/*
	 * No wait/wakeup ordering required as both waker and waiters
	 * are serialised by the inode->i_lock.
	 */
	__wake_up_var(....);

-Dave.
-- 
Dave Chinner
david@fromorbit.com

