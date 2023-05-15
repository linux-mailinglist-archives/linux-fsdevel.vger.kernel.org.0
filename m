Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263067021C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 04:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjEOCkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjEOCkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 22:40:05 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDD1B3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 19:40:02 -0700 (PDT)
Date:   Sun, 14 May 2023 22:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684118400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DPNlYH/Ag04fAJWQKxyPS/zKJ4ThOhz+SulcaNR56kU=;
        b=Ys6qfIh46G4aW4m+wazaEfJcIGaJQatvXpMSp/tEtasGQ7Hgbeleaf1NaGDQDCXSjZAGVv
        mdE6d7XMnfgxf5R5D1l+dIO68mzIGqhkPsftNsj8XZvZs9Qg4ypuZ7jZtXZOiddYIJzLdd
        fr6ySb8W7EFqnmGMzxcjFQGsRIaww9I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZGGbfFFkZZruo8J/@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-5-kent.overstreet@linux.dev>
 <e87c74c05e79a01b160ce0ae81a9ef4229670930.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87c74c05e79a01b160ce0ae81a9ef4229670930.camel@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 08:15:20AM -0400, Jeff Layton wrote:
> So the idea is to create a fundamentally unfair rwsem? One that always
> prefers readers over writers?

No, not sure where you're getting that from. It's unfair, but writes are
preferred over readers :)

> 
> > + * Other operations:
> > + *
> > + *   six_trylock_read()
> > + *   six_trylock_intent()
> > + *   six_trylock_write()
> > + *
> > + *   six_lock_downgrade():	convert from intent to read
> > + *   six_lock_tryupgrade():	attempt to convert from read to intent
> > + *
> > + * Locks also embed a sequence number, which is incremented when the lock is
> > + * locked or unlocked for write. The current sequence number can be grabbed
> > + * while a lock is held from lock->state.seq; then, if you drop the lock you can
> > + * use six_relock_(read|intent_write)(lock, seq) to attempt to retake the lock
> > + * iff it hasn't been locked for write in the meantime.
> > + *
> 
> ^^^
> This is a cool idea.

It's used heavily in bcachefs so we can drop locks if we might be
blocking - and then relock and continue, at the cost of a transaction
restart if the relock fails. It's a huge win for tail latency.

> > + * type is one of SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write:
> > + *
> > + *   six_lock_type(lock, type)
> > + *   six_unlock_type(lock, type)
> > + *   six_relock(lock, type, seq)
> > + *   six_trylock_type(lock, type)
> > + *   six_trylock_convert(lock, from, to)
> > + *
> > + * A lock may be held multiple types by the same thread (for read or intent,
> > + * not write). However, the six locks code does _not_ implement the actual
> > + * recursive checks itself though - rather, if your code (e.g. btree iterator
> > + * code) knows that the current thread already has a lock held, and for the
> > + * correct type, six_lock_increment() may be used to bump up the counter for
> > + * that type - the only effect is that one more call to unlock will be required
> > + * before the lock is unlocked.
> 
> Thse semantics are a bit confusing. Once you hold a read or intent lock,
> you can take it as many times as you like. What happens if I take it in
> one context and release it in another? Say, across a workqueue job for
> instance?

Not allowed because of lockdep, same as with other locks.

> Are intent locks "converted" to write locks, or do they stack? For
> instance, suppose I take the intent lock 3 times and then take a write
> lock. How many times do I have to call unlock to fully release it (3 or
> 4)? If I release it just once, do I still hold the write lock or am I
> back to "intent" state?

They stack. You'd call unlock_write() once ad unlock_intent() three
times.

> Some basic info about the underlying design would be nice here. What
> info is tracked in the union below? When are different members being
> used? How does the code decide which way to cast this thing? etc.

The field names seem pretty descriptive to me.

counter, v are just for READ_ONCE/atomic64 cmpxchg ops.

> Ewww...bitfields. That seems a bit scary in a union. There is no
> guarantee that the underlying arch will even pack that into a single
> word, AIUI. It may be safer to do this with masking and shifting
> instead.

It wouldn't hurt to add a BUILD_BUG_ON() for the size, but I don't find
anything "scary" about unions and bitfields :)

And it makes the code more descriptive and readable than masking and
shifting.

> > +static __always_inline bool do_six_trylock_type(struct six_lock *lock,
> > +						enum six_lock_type type,
> > +						bool try)
> > +{
> > +	const struct six_lock_vals l[] = LOCK_VALS;
> > +	union six_lock_state old, new;
> > +	bool ret;
> > +	u64 v;
> > +
> > +	EBUG_ON(type == SIX_LOCK_write && lock->owner != current);
> > +	EBUG_ON(type == SIX_LOCK_write && (lock->state.seq & 1));
> > +
> > +	EBUG_ON(type == SIX_LOCK_write && (try != !(lock->state.write_locking)));
> > +
> > +	/*
> > +	 * Percpu reader mode:
> > +	 *
> > +	 * The basic idea behind this algorithm is that you can implement a lock
> > +	 * between two threads without any atomics, just memory barriers:
> > +	 *
> > +	 * For two threads you'll need two variables, one variable for "thread a
> > +	 * has the lock" and another for "thread b has the lock".
> > +	 *
> > +	 * To take the lock, a thread sets its variable indicating that it holds
> > +	 * the lock, then issues a full memory barrier, then reads from the
> > +	 * other thread's variable to check if the other thread thinks it has
> > +	 * the lock. If we raced, we backoff and retry/sleep.
> > +	 */
> > +
> > +	if (type == SIX_LOCK_read && lock->readers) {
> > +retry:
> > +		preempt_disable();
> > +		this_cpu_inc(*lock->readers); /* signal that we own lock */
> > +
> > +		smp_mb();
> > +
> > +		old.v = READ_ONCE(lock->state.v);
> > +		ret = !(old.v & l[type].lock_fail);
> > +
> > +		this_cpu_sub(*lock->readers, !ret);
> > +		preempt_enable();
> > +
> > +		/*
> > +		 * If we failed because a writer was trying to take the
> > +		 * lock, issue a wakeup because we might have caused a
> > +		 * spurious trylock failure:
> > +		 */
> > +		if (old.write_locking) {
> > +			struct task_struct *p = READ_ONCE(lock->owner);
> > +
> > +			if (p)
> > +				wake_up_process(p);
> > +		}
> > +
> > +		/*
> > +		 * If we failed from the lock path and the waiting bit wasn't
> > +		 * set, set it:
> > +		 */
> > +		if (!try && !ret) {
> > +			v = old.v;
> > +
> > +			do {
> > +				new.v = old.v = v;
> > +
> > +				if (!(old.v & l[type].lock_fail))
> > +					goto retry;
> > +
> > +				if (new.waiters & (1 << type))
> > +					break;
> > +
> > +				new.waiters |= 1 << type;
> > +			} while ((v = atomic64_cmpxchg(&lock->state.counter,
> > +						       old.v, new.v)) != old.v);
> > +		}
> > +	} else if (type == SIX_LOCK_write && lock->readers) {
> > +		if (try) {
> > +			atomic64_add(__SIX_VAL(write_locking, 1),
> > +				     &lock->state.counter);
> > +			smp_mb__after_atomic();
> > +		}
> > +
> > +		ret = !pcpu_read_count(lock);
> > +
> > +		/*
> > +		 * On success, we increment lock->seq; also we clear
> > +		 * write_locking unless we failed from the lock path:
> > +		 */
> > +		v = 0;
> > +		if (ret)
> > +			v += __SIX_VAL(seq, 1);
> > +		if (ret || try)
> > +			v -= __SIX_VAL(write_locking, 1);
> > +
> > +		if (try && !ret) {
> > +			old.v = atomic64_add_return(v, &lock->state.counter);
> > +			six_lock_wakeup(lock, old, SIX_LOCK_read);
> > +		} else {
> > +			atomic64_add(v, &lock->state.counter);
> > +		}
> > +	} else {
> > +		v = READ_ONCE(lock->state.v);
> > +		do {
> > +			new.v = old.v = v;
> > +
> > +			if (!(old.v & l[type].lock_fail)) {
> > +				new.v += l[type].lock_val;
> > +
> > +				if (type == SIX_LOCK_write)
> > +					new.write_locking = 0;
> > +			} else if (!try && type != SIX_LOCK_write &&
> > +				   !(new.waiters & (1 << type)))
> > +				new.waiters |= 1 << type;
> > +			else
> > +				break; /* waiting bit already set */
> > +		} while ((v = atomic64_cmpxchg_acquire(&lock->state.counter,
> > +					old.v, new.v)) != old.v);
> > +
> > +		ret = !(old.v & l[type].lock_fail);
> > +
> > +		EBUG_ON(ret && !(lock->state.v & l[type].held_mask));
> > +	}
> > +
> > +	if (ret)
> > +		six_set_owner(lock, type, old);
> > +
> > +	EBUG_ON(type == SIX_LOCK_write && (try || ret) && (lock->state.write_locking));
> > +
> > +	return ret;
> > +}
> > +
> 
> ^^^
> I'd really like to see some more comments in the code above. It's pretty
> complex.

It's already got more comments than is typical for kernel locking code :)

But if there's specific things you'd like to see clarified, please do
point them out.
