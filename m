Return-Path: <linux-fsdevel+bounces-46228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B524A84DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 22:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1756A1BA2A32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8DE290098;
	Thu, 10 Apr 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNKYRqlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276128F959;
	Thu, 10 Apr 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315563; cv=none; b=pA0/DJR5MQFURFs3j7ZTt9BOTC7zGymoS8ue/NHR4VPONO/AgLricp5PRMk/b25PbFkn+FO2unimf7B5epfn9g0sSWIP3HeDD5Biel4aJEUphHzhK1LeRp/45uR+qQK4/xW0oNH0KBoKE9Tl0R5JacmwgTnGtR3jCATNXe7VpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315563; c=relaxed/simple;
	bh=GhVrty9HJfGQuDS5fHu0ISRwINFnzYA1bc6t08RhMyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6ZHox5JjDuS/a4nvSsKu9dUSEhSW1L93hh398w/wWXl+wbHDDDHoCuoNlHuDo7ANd6mmIEAzbiAXMVE+vEXCTWyq9IQi5tjTWnjX2BQnHEvnCLeWKbMjxpu9CJi5it1HbtXW/nTY14TW0uW55sdynormLihASNh2yBkXsSL8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNKYRqlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFFFC4CEDD;
	Thu, 10 Apr 2025 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744315563;
	bh=GhVrty9HJfGQuDS5fHu0ISRwINFnzYA1bc6t08RhMyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNKYRqlDTAWKEHKtdq0pEqu38no2VewQOXZRNnql3Ss6qYIFdB6rOEXxGwUV8BpoA
	 suTTXnChGt+8Or3OfDPjF3seQx2q/epTffhLeBH8JhwEdPOoh2j0rJbhT4ESytVaO9
	 QrXHeBnHU71AvBmzR93JXveEqWAbrzkwNHnE02cX0od4Wyq9n9MFwoAGj3vZHJ0D6X
	 DxJD9ErvumYOdiwsH+iKnRP37cUlAdx1o9ObYYEhT9NswR3DTz+2yrvuYlZtX0hV75
	 V6+zOAiIGOMD8duJGjNmSwcaFWSpUek8Weobr6zAkhFiLhAY5+Q9cbLSPVLx9QJiko
	 d07v03gCtDGwQ==
Date: Thu, 10 Apr 2025 22:05:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250410-inklusive-kehren-e817ba060a34@brauner>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
 <20250409184040.GF32748@redhat.com>
 <20250410101801.GA15280@redhat.com>
 <20250410-barhocker-weinhandel-8ed2f619899b@brauner>
 <20250410131008.GB15280@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410131008.GB15280@redhat.com>

On Thu, Apr 10, 2025 at 03:10:09PM +0200, Oleg Nesterov wrote:
> On 04/10, Christian Brauner wrote:
> >
> > On Thu, Apr 10, 2025 at 12:18:01PM +0200, Oleg Nesterov wrote:
> > > On 04/09, Oleg Nesterov wrote:
> > > >
> > > > On 04/09, Christian Brauner wrote:
> > > > >
> > > > > The seqcounter might be
> > > > > useful independent of pidfs.
> > > >
> > > > Are you sure? ;) to me the new pid->pid_seq needs more justification...
> >
> > Yeah, pretty much. I'd make use of this in other cases where we need to
> > detect concurrent changes to struct pid without having to take any
> > locks. Multi-threaded exec in de_exec() comes to mind as well.
> 
> Perhaps you are right, but so far I am still not sure it makes sense.
> And we can always add it later if we have another (more convincing)
> use-case.
> 
> > > To remind, detach_pid(pid, PIDTYPE_PID) does wake_up_all(&pid->wait_pidfd) and
> > > takes pid->wait_pidfd->lock.
> > >
> > > So if pid_has_task(PIDTYPE_PID) succeeds, __unhash_process() -> detach_pid(TGID)
> > > is not possible until we drop pid->wait_pidfd->lock.
> > >
> > > If detach_pid(PIDTYPE_PID) was already called and have passed wake_up_all(),
> > > pid_has_task(PIDTYPE_PID) can't succeed.
> >
> > I know. I was trying to avoid having to take the lock and just make this
> > lockless. But if you think we should use this lock here instead I'm
> > willing to do this. I just find the sequence counter more elegant than
> > the spin_lock_irq().
> 
> This is subjective, and quite possibly I am wrong. But yes, I'd prefer
> to (ab)use pid->wait_pidfd->lock in pidfd_prepare() for now and not
> penalize __unhash_process(). Simply because this is simpler.
> 
> If you really dislike taking wait_pidfd->lock, we can add mb() into
> __unhash_process() or even smp_mb__after_spinlock() into __change_pid(),
> but this will need a lengthy comment...

No, I don't think we should do that.

> As for your patch... it doesn't apply on top of 3/4, but I guess it
> is clear what does it do, and (unfortunately ;) it looks correct, so
> I won't insist too much. See a couple of nits below.
> 
> > this imho and it would give pidfds a reliable way to detect relevant
> > concurrent changes locklessly without penalizing other critical paths
> > (e.g., under tasklist_lock) in the kernel.
> 
> Can't resist... Note that raw_seqcount_begin() in pidfd_prepare() will
> take/drop tasklist_lock if it races with __unhash_process() on PREEMPT_RT.

Eeeeew,

        if (!IS_ENABLED(CONFIG_PREEMPT_RT))                             \
                return seq;                                             \
                                                                        \
        if (preemptible && unlikely(seq & 1)) {                         \
                __SEQ_LOCK(lockbase##_lock(s->lock));                   \
                __SEQ_LOCK(lockbase##_unlock(s->lock));                 \

priority inversion fix, I take it. That's equally ugly as what we had to
do for mnt_get_write_access()...

I actually think what you just pointed out is rather problematic. It's
absolutely wild that raw_seqcount_begin() suddenly implies locking.

How isn't that a huge landmine? On non-rt I can happily do:

acquire_associated_lock()
raw_seqcount_begin()
drop_associated_lock()

But this will immediately turn into a deadlock on preempt-rt, no?

> Yes, this is unlikely case, but still...
> 
> Now. Unless I misread your patch, pidfd_prepare() does "err = 0" only
> once before the main loop. And this is correct. But this means that
> we do not need the do/while loop.

Yes, I know. I simply used the common idiom.

> 
> If read_seqcount_retry() returns true, we can safely return -ESRCH. So
> we can do
> 
> 	seq = raw_seqcount_begin(&pid->pid_seq);
> 
> 	if (!PIDFD_THREAD && !pid_has_task(PIDTYPE_TGID))
> 		err = -ENOENT;
> 
> 	if (!pid_has_task(PIDTYPE_PID))
> 		err = -ESRCH;
> 
> 	if (read_seqcount_retry(pid->pid_seq, seq))
> 		err = -ESRCH;
> 
> In fact we don't even need raw_seqcount_begin(), we could use
> raw_seqcount_try_begin().
> 
> And why seqcount_rwlock_t? A plain seqcount_t can equally work.

Yes, but this way its dependence on tasklist_lock is natively integrated
with lockdep afaict:

 * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
 * @seqcount:   The real sequence counter
 * @lock:       Pointer to the associated lock
 *
 * A plain sequence counter with external writer synchronization by
 * LOCKNAME @lock. The lock is associated to the sequence counter in the
 * static initializer or init function. This enables lockdep to validate
 * that the write side critical section is properly serialized.
 *
 * LOCKNAME:    raw_spinlock, spinlock, rwlock or mutex
 */

/*
 * seqcount_LOCKNAME_init() - runtime initializer for seqcount_LOCKNAME_t
 * @s:          Pointer to the seqcount_LOCKNAME_t instance
 * @lock:       Pointer to the associated lock
 */

#define seqcount_LOCKNAME_init(s, _lock, lockname)                      \
        do {                                                            \
                seqcount_##lockname##_t *____s = (s);                   \
                seqcount_init(&____s->seqcount);                        \
                __SEQ_LOCK(____s->lock = (_lock));                      \
        } while (0)

#define seqcount_raw_spinlock_init(s, lock)     seqcount_LOCKNAME_init(s, lock, raw_spinlock)
#define seqcount_spinlock_init(s, lock)         seqcount_LOCKNAME_init(s, lock, spinlock)
#define seqcount_rwlock_init(s, lock)           seqcount_LOCKNAME_init(s, lock, rwlock)
#define seqcount_mutex_init(s, lock)            seqcount_LOCKNAME_init(s, lock, mutex)

> And, if we use seqcount_rwlock_t,
> 
> 	lockdep_assert_held_write(&tasklist_lock);
> 	...
> 	raw_write_seqcount_begin(pid->pid_seq);
> 
> in __unhash_process() looks a bit strange. I'd suggest to use
> write_seqcount_begin() which does seqprop_assert() and kill
> lockdep_assert_held_write().
> 
> Oleg.
> 

