Return-Path: <linux-fsdevel+bounces-45444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29BEA77B50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF03AEE58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C0A2036F5;
	Tue,  1 Apr 2025 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAyO0gDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950A1EC01F;
	Tue,  1 Apr 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511806; cv=none; b=sl8sdu39nENdaYdhVKQiDGFgn7toxSCuOZVIGmOpuDbWo0J/9wgAl1P8ctDRkty1HjLp72sGxFYG70fAVIVE2BFSW3c4B3lkTwVvgQNUyZscSb+Nr9ORjObyCfGXw6xIJGhvmIU971a0oY5iHCKZe0UmNs5lNKuDzXfoIkSUjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511806; c=relaxed/simple;
	bh=l8DS0pBZzqAHtujG932plENYbefs0MpGtb/A8hNqdIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUoLQT9WXj5lrO8BwdqfpfhG74cvX8zIhR89g/upomBJACfFcmxe4I0LipLSXGR9ouyuAj8EmxtsZGe2FMnL7HaTIV5zefTS3e7R5G9GZ0EX4ntdecsEycBTnc5EvpeZOwc2Ktg6kGHwBt1Ld+lmymIJQIhsfslCwM8r9bIedXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAyO0gDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D2AC4CEE4;
	Tue,  1 Apr 2025 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743511806;
	bh=l8DS0pBZzqAHtujG932plENYbefs0MpGtb/A8hNqdIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAyO0gDuVdOe0WRth80ZyFeJdlL2egix6OCNyQmWnotsN5AWmg0KlzH6YC33B0KPW
	 0O4gFhFZjRTWNDDe4aSUh9zVR4hHmSoT6i5p2TpGS/ssl8FTaerXDnDbmfYrjItTRE
	 g9q5vHkT1ljJZ7dJh5d3NlSgzau65ME4gs4Uq6GALpJ82L4IcAo41treGJpO+warca
	 bgnvzTJRHi9l4REPeRaJUPb6kADqWR5s5Rf7p4ol8Zp0TiXAifq+IGacSnjF+THkt0
	 1iDLczWeIo9X3z5dBeETFn3BLhANOK5fjp88x+hlfbVfWLxb9lCWIAO5rMHgxifvRY
	 N6nU6mRzoWZ+Q==
Date: Tue, 1 Apr 2025 14:50:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [RFC PATCH 1/4] locking/percpu-rwsem: add freezable alternative
 to down_read
Message-ID: <20250401-entkernen-revitalisieren-fac4b67109e5@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-2-James.Bottomley@HansenPartnership.com>
 <77774eb380e343976de3de681204e2c7f3ab1926.camel@HansenPartnership.com>
 <20250401-anwalt-dazugeben-18d8c3efd1fd@brauner>
 <f6bdfa23b9f54055f8a539ce396f1134b0921417.camel@HansenPartnership.com>
 <3bfnds6nsvxy5jfbcoy62uva6kebhacjuavqxvelbfs6ut6rqf@m4pzsudbqg6l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bfnds6nsvxy5jfbcoy62uva6kebhacjuavqxvelbfs6ut6rqf@m4pzsudbqg6l>

On Tue, Apr 01, 2025 at 01:20:37PM +0200, Jan Kara wrote:
> On Mon 31-03-25 21:13:20, James Bottomley wrote:
> > On Tue, 2025-04-01 at 01:32 +0200, Christian Brauner wrote:
> > > On Mon, Mar 31, 2025 at 03:51:43PM -0400, James Bottomley wrote:
> > > > On Thu, 2025-03-27 at 10:06 -0400, James Bottomley wrote:
> > > > [...]
> > > > > -static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem,
> > > > > bool
> > > > > reader)
> > > > > +static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem,
> > > > > bool
> > > > > reader,
> > > > > +			      bool freeze)
> > > > >  {
> > > > >  	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
> > > > >  	bool wait;
> > > > > @@ -156,7 +157,8 @@ static void percpu_rwsem_wait(struct
> > > > > percpu_rw_semaphore *sem, bool reader)
> > > > >  	spin_unlock_irq(&sem->waiters.lock);
> > > > >  
> > > > >  	while (wait) {
> > > > > -		set_current_state(TASK_UNINTERRUPTIBLE);
> > > > > +		set_current_state(TASK_UNINTERRUPTIBLE |
> > > > > +				  freeze ? TASK_FREEZABLE : 0);
> > > > 
> > > > This is a bit embarrassing, the bug I've been chasing is here: the
> > > > ?
> > > > operator is lower in precedence than | meaning this expression
> > > > always
> > > > evaluates to TASK_FREEZABLE and nothing else (which is why the
> > > > process
> > > > goes into R state and never wakes up).
> > > > 
> > > > Let me fix that and redo all the testing.
> > > 
> > > I don't think that's it. I think you're missing making pagefault
> > > writers such
> > > as systemd-journald freezable:
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index b379a46b5576..528e73f192ac 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct
> > > super_block *sb, int level)
> > >  static inline void __sb_start_write(struct super_block *sb, int
> > > level)
> > >  {
> > >         percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
> > > -                                  level == SB_FREEZE_WRITE);
> > > +                                  (level == SB_FREEZE_WRITE ||
> > > +                                   level == SB_FREEZE_PAGEFAULT));
> > >  }
> > 
> > Yes, I was about to tell Jan that the condition here simply needs to be
> > true.  All our rwsem levels need to be freezable to avoid a hibernation
> > failure.
> 
> So there is one snag with this. SB_FREEZE_PAGEFAULT level is acquired under
> mmap_sem, SB_FREEZE_INTERNAL level is possibly acquired under some other
> filesystem locks. So if you freeze the filesystem, a task can block on
> frozen filesystem with e.g. mmap_sem held and if some other task then

Yeah, I wondered about that yesterday.

> blocks on grabbing that mmap_sem, hibernation fails because we'll be unable
> to hibernate the task waiting for mmap_sem. So if you'd like to completely
> avoid these hibernation failures, you'd have to make a slew of filesystem
> related locks use freezable sleeping. I don't think that's feasible.
> 
> I was hoping that failures due to SB_FREEZE_PAGEFAULT level not being
> freezable would be rare enough but you've proven they are quite frequent.
> We can try making SB_FREEZE_PAGEFAULT level (or even SB_FREEZE_INTERNAL)
> freezable and see whether that works good enough...

I think that's fine and we'll see whether this causes a lot of issues.
I've got the patchset written in a way now that userspace can just
enable or disable freeze during migration.

