Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AE701D3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjENMP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjENMP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 08:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08692691;
        Sun, 14 May 2023 05:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336EB60C07;
        Sun, 14 May 2023 12:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59C3C433EF;
        Sun, 14 May 2023 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684066522;
        bh=Yw2taMtqqQk0CF+hZUHV0QOpU3cc8pORliPFvgC75K8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QB9Euy8eFyXNFy7b66xSTVHVJth5nALwJdaYDpMcwdmSvHyEnJd+tD2qe8NEAx34B
         tc5Bx4+/N3/zKHTCNkmOfa2y4CyzORHfbqGCXKZOcqHXniQgxbNRnlIZte4abHS+tO
         7IhmJrw5C1PjAtJU+loi0t0cpHK6k0TNObOtkMD/Wd7US4Ed460zc/dczaftXJT8xU
         IALSt8mlYy1aRZIwn9fjG6J68nYDDGMsow3UT96NWTpWJ0rDKJECBTVf3KnEFucetM
         RWqeOZGoonn/+2nhlvbz0I2xtqnIJcwmy3Sdv7WtzSS8p2No2v6mkcAPIPGc3hoB3P
         TOafAV8Z/XppQ==
Message-ID: <e87c74c05e79a01b160ce0ae81a9ef4229670930.camel@kernel.org>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
From:   Jeff Layton <jlayton@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Date:   Sun, 14 May 2023 08:15:20 -0400
In-Reply-To: <20230509165657.1735798-5-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
         <20230509165657.1735798-5-kent.overstreet@linux.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-09 at 12:56 -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
>=20
> New lock for bcachefs, like read/write locks but with a third state,
> intent.
>=20
> Intent locks conflict with each other, but not with read locks; taking a
> write lock requires first holding an intent lock.
>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>  include/linux/six.h     | 210 +++++++++++
>  kernel/Kconfig.locks    |   3 +
>  kernel/locking/Makefile |   1 +
>  kernel/locking/six.c    | 779 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 993 insertions(+)
>  create mode 100644 include/linux/six.h
>  create mode 100644 kernel/locking/six.c
>=20
> diff --git a/include/linux/six.h b/include/linux/six.h
> new file mode 100644
> index 0000000000..41ddf63b74
> --- /dev/null
> +++ b/include/linux/six.h
> @@ -0,0 +1,210 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_SIX_H
> +#define _LINUX_SIX_H
> +
> +/*
> + * Shared/intent/exclusive locks: sleepable read/write locks, much like =
rw
> + * semaphores, except with a third intermediate state, intent. Basic ope=
rations
> + * are:
> + *
> + * six_lock_read(&foo->lock);
> + * six_unlock_read(&foo->lock);
> + *
> + * six_lock_intent(&foo->lock);
> + * six_unlock_intent(&foo->lock);
> + *
> + * six_lock_write(&foo->lock);
> + * six_unlock_write(&foo->lock);
> + *
> + * Intent locks block other intent locks, but do not block read locks, a=
nd you
> + * must have an intent lock held before taking a write lock, like so:
> + *
> + * six_lock_intent(&foo->lock);
> + * six_lock_write(&foo->lock);
> + * six_unlock_write(&foo->lock);
> + * six_unlock_intent(&foo->lock);
> + *

So the idea is to create a fundamentally unfair rwsem? One that always
prefers readers over writers?

> + * Other operations:
> + *
> + *   six_trylock_read()
> + *   six_trylock_intent()
> + *   six_trylock_write()
> + *
> + *   six_lock_downgrade():	convert from intent to read
> + *   six_lock_tryupgrade():	attempt to convert from read to intent
> + *
> + * Locks also embed a sequence number, which is incremented when the loc=
k is
> + * locked or unlocked for write. The current sequence number can be grab=
bed
> + * while a lock is held from lock->state.seq; then, if you drop the lock=
 you can
> + * use six_relock_(read|intent_write)(lock, seq) to attempt to retake th=
e lock
> + * iff it hasn't been locked for write in the meantime.
> + *

^^^
This is a cool idea.

> + * There are also operations that take the lock type as a parameter, whe=
re the
> + * type is one of SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write:
> + *
> + *   six_lock_type(lock, type)
> + *   six_unlock_type(lock, type)
> + *   six_relock(lock, type, seq)
> + *   six_trylock_type(lock, type)
> + *   six_trylock_convert(lock, from, to)
> + *
> + * A lock may be held multiple types by the same thread (for read or int=
ent,
> + * not write). However, the six locks code does _not_ implement the actu=
al
> + * recursive checks itself though - rather, if your code (e.g. btree ite=
rator
> + * code) knows that the current thread already has a lock held, and for =
the
> + * correct type, six_lock_increment() may be used to bump up the counter=
 for
> + * that type - the only effect is that one more call to unlock will be r=
equired
> + * before the lock is unlocked.

Thse semantics are a bit confusing. Once you hold a read or intent lock,
you can take it as many times as you like. What happens if I take it in
one context and release it in another? Say, across a workqueue job for
instance?

Are intent locks "converted" to write locks, or do they stack? For
instance, suppose I take the intent lock 3 times and then take a write
lock. How many times do I have to call unlock to fully release it (3 or
4)? If I release it just once, do I still hold the write lock or am I
back to "intent" state?


> + */
> +
> +#include <linux/lockdep.h>
> +#include <linux/osq_lock.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +
> +#define SIX_LOCK_SEPARATE_LOCKFNS
>=20
>=20

Some basic info about the underlying design would be nice here. What
info is tracked in the union below? When are different members being
used? How does the code decide which way to cast this thing? etc.


> +
> +union six_lock_state {
> +	struct {
> +		atomic64_t	counter;
> +	};
> +
> +	struct {
> +		u64		v;
> +	};
> +
> +	struct {
> +		/* for waitlist_bitnr() */
> +		unsigned long	l;
> +	};
> +
> +	struct {
> +		unsigned	read_lock:27;
> +		unsigned	write_locking:1;
> +		unsigned	intent_lock:1;
> +		unsigned	waiters:3;


Ewww...bitfields. That seems a bit scary in a union. There is no
guarantee that the underlying arch will even pack that into a single
word, AIUI. It may be safer to do this with masking and shifting
instead.

> +		/*
> +		 * seq works much like in seqlocks: it's incremented every time
> +		 * we lock and unlock for write.
> +		 *
> +		 * If it's odd write lock is held, even unlocked.
> +		 *
> +		 * Thus readers can unlock, and then lock again later iff it
> +		 * hasn't been modified in the meantime.
> +		 */
> +		u32		seq;
> +	};
> +};
> +
> +enum six_lock_type {
> +	SIX_LOCK_read,
> +	SIX_LOCK_intent,
> +	SIX_LOCK_write,
> +};
> +
> +struct six_lock {
> +	union six_lock_state	state;
> +	unsigned		intent_lock_recurse;
> +	struct task_struct	*owner;
> +	struct optimistic_spin_queue osq;
> +	unsigned __percpu	*readers;
> +
> +	raw_spinlock_t		wait_lock;
> +	struct list_head	wait_list[2];
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map	dep_map;
> +#endif
> +};
> +
> +typedef int (*six_lock_should_sleep_fn)(struct six_lock *lock, void *);
> +
> +static __always_inline void __six_lock_init(struct six_lock *lock,
> +					    const char *name,
> +					    struct lock_class_key *key)
> +{
> +	atomic64_set(&lock->state.counter, 0);
> +	raw_spin_lock_init(&lock->wait_lock);
> +	INIT_LIST_HEAD(&lock->wait_list[SIX_LOCK_read]);
> +	INIT_LIST_HEAD(&lock->wait_list[SIX_LOCK_intent]);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	debug_check_no_locks_freed((void *) lock, sizeof(*lock));
> +	lockdep_init_map(&lock->dep_map, name, key, 0);
> +#endif
> +}
> +
> +#define six_lock_init(lock)						\
> +do {									\
> +	static struct lock_class_key __key;				\
> +									\
> +	__six_lock_init((lock), #lock, &__key);				\
> +} while (0)
> +
> +#define __SIX_VAL(field, _v)	(((union six_lock_state) { .field =3D _v })=
.v)
> +
> +#define __SIX_LOCK(type)						\
> +bool six_trylock_##type(struct six_lock *);				\
> +bool six_relock_##type(struct six_lock *, u32);				\
> +int six_lock_##type(struct six_lock *, six_lock_should_sleep_fn, void *)=
;\
> +void six_unlock_##type(struct six_lock *);
> +
> +__SIX_LOCK(read)
> +__SIX_LOCK(intent)
> +__SIX_LOCK(write)
> +#undef __SIX_LOCK
> +
> +#define SIX_LOCK_DISPATCH(type, fn, ...)			\
> +	switch (type) {						\
> +	case SIX_LOCK_read:					\
> +		return fn##_read(__VA_ARGS__);			\
> +	case SIX_LOCK_intent:					\
> +		return fn##_intent(__VA_ARGS__);		\
> +	case SIX_LOCK_write:					\
> +		return fn##_write(__VA_ARGS__);			\
> +	default:						\
> +		BUG();						\
> +	}
> +
> +static inline bool six_trylock_type(struct six_lock *lock, enum six_lock=
_type type)
> +{
> +	SIX_LOCK_DISPATCH(type, six_trylock, lock);
> +}
> +
> +static inline bool six_relock_type(struct six_lock *lock, enum six_lock_=
type type,
> +				   unsigned seq)
> +{
> +	SIX_LOCK_DISPATCH(type, six_relock, lock, seq);
> +}
> +
> +static inline int six_lock_type(struct six_lock *lock, enum six_lock_typ=
e type,
> +				six_lock_should_sleep_fn should_sleep_fn, void *p)
> +{
> +	SIX_LOCK_DISPATCH(type, six_lock, lock, should_sleep_fn, p);
> +}
> +
> +static inline void six_unlock_type(struct six_lock *lock, enum six_lock_=
type type)
> +{
> +	SIX_LOCK_DISPATCH(type, six_unlock, lock);
> +}
> +
> +void six_lock_downgrade(struct six_lock *);
> +bool six_lock_tryupgrade(struct six_lock *);
> +bool six_trylock_convert(struct six_lock *, enum six_lock_type,
> +			 enum six_lock_type);
> +
> +void six_lock_increment(struct six_lock *, enum six_lock_type);
> +
> +void six_lock_wakeup_all(struct six_lock *);
> +
> +void six_lock_pcpu_free_rcu(struct six_lock *);
> +void six_lock_pcpu_free(struct six_lock *);
> +void six_lock_pcpu_alloc(struct six_lock *);
> +
> +struct six_lock_count {
> +	unsigned read;
> +	unsigned intent;
> +};
> +
> +struct six_lock_count six_lock_counts(struct six_lock *);
> +
> +#endif /* _LINUX_SIX_H */
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index 4198f0273e..b2abd9a5d9 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -259,3 +259,6 @@ config ARCH_HAS_MMIOWB
>  config MMIOWB
>  	def_bool y if ARCH_HAS_MMIOWB
>  	depends on SMP
> +
> +config SIXLOCKS
> +	bool
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 0db4093d17..a095dbbf01 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_QUEUED_RWLOCKS) +=3D qrwlock.o
>  obj-$(CONFIG_LOCK_TORTURE_TEST) +=3D locktorture.o
>  obj-$(CONFIG_WW_MUTEX_SELFTEST) +=3D test-ww_mutex.o
>  obj-$(CONFIG_LOCK_EVENT_COUNTS) +=3D lock_events.o
> +obj-$(CONFIG_SIXLOCKS) +=3D six.o
> diff --git a/kernel/locking/six.c b/kernel/locking/six.c
> new file mode 100644
> index 0000000000..5b2d92c6e9
> --- /dev/null
> +++ b/kernel/locking/six.c
> @@ -0,0 +1,779 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/log2.h>
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched.h>
> +#include <linux/sched/rt.h>
> +#include <linux/six.h>
> +#include <linux/slab.h>
> +
> +#ifdef DEBUG
> +#define EBUG_ON(cond)		BUG_ON(cond)
> +#else
> +#define EBUG_ON(cond)		do {} while (0)
> +#endif
> +
> +#define six_acquire(l, t)	lock_acquire(l, 0, t, 0, 0, NULL, _RET_IP_)
> +#define six_release(l)		lock_release(l, _RET_IP_)
> +
> +struct six_lock_vals {
> +	/* Value we add to the lock in order to take the lock: */
> +	u64			lock_val;
> +
> +	/* If the lock has this value (used as a mask), taking the lock fails: =
*/
> +	u64			lock_fail;
> +
> +	/* Value we add to the lock in order to release the lock: */
> +	u64			unlock_val;
> +
> +	/* Mask that indicates lock is held for this type: */
> +	u64			held_mask;
> +
> +	/* Waitlist we wakeup when releasing the lock: */
> +	enum six_lock_type	unlock_wakeup;
> +};
> +
> +#define __SIX_LOCK_HELD_read	__SIX_VAL(read_lock, ~0)
> +#define __SIX_LOCK_HELD_intent	__SIX_VAL(intent_lock, ~0)
> +#define __SIX_LOCK_HELD_write	__SIX_VAL(seq, 1)
> +
> +#define LOCK_VALS {							\
> +	[SIX_LOCK_read] =3D {						\
> +		.lock_val	=3D __SIX_VAL(read_lock, 1),		\
> +		.lock_fail	=3D __SIX_LOCK_HELD_write + __SIX_VAL(write_locking, 1),\
> +		.unlock_val	=3D -__SIX_VAL(read_lock, 1),		\
> +		.held_mask	=3D __SIX_LOCK_HELD_read,			\
> +		.unlock_wakeup	=3D SIX_LOCK_write,			\
> +	},								\
> +	[SIX_LOCK_intent] =3D {						\
> +		.lock_val	=3D __SIX_VAL(intent_lock, 1),		\
> +		.lock_fail	=3D __SIX_LOCK_HELD_intent,		\
> +		.unlock_val	=3D -__SIX_VAL(intent_lock, 1),		\
> +		.held_mask	=3D __SIX_LOCK_HELD_intent,		\
> +		.unlock_wakeup	=3D SIX_LOCK_intent,			\
> +	},								\
> +	[SIX_LOCK_write] =3D {						\
> +		.lock_val	=3D __SIX_VAL(seq, 1),			\
> +		.lock_fail	=3D __SIX_LOCK_HELD_read,			\
> +		.unlock_val	=3D __SIX_VAL(seq, 1),			\
> +		.held_mask	=3D __SIX_LOCK_HELD_write,		\
> +		.unlock_wakeup	=3D SIX_LOCK_read,			\
> +	},								\
> +}
> +
> +static inline void six_set_owner(struct six_lock *lock, enum six_lock_ty=
pe type,
> +				 union six_lock_state old)
> +{
> +	if (type !=3D SIX_LOCK_intent)
> +		return;
> +
> +	if (!old.intent_lock) {
> +		EBUG_ON(lock->owner);
> +		lock->owner =3D current;
> +	} else {
> +		EBUG_ON(lock->owner !=3D current);
> +	}
> +}
> +
> +static inline unsigned pcpu_read_count(struct six_lock *lock)
> +{
> +	unsigned read_count =3D 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		read_count +=3D *per_cpu_ptr(lock->readers, cpu);
> +	return read_count;
> +}
> +
> +struct six_lock_waiter {
> +	struct list_head	list;
> +	struct task_struct	*task;
> +};
> +
> +/* This is probably up there with the more evil things I've done */
> +#define waitlist_bitnr(id) ilog2((((union six_lock_state) { .waiters =3D=
 1 << (id) }).l))
> +
> +static inline void six_lock_wakeup(struct six_lock *lock,
> +				   union six_lock_state state,
> +				   unsigned waitlist_id)
> +{
> +	if (waitlist_id =3D=3D SIX_LOCK_write) {
> +		if (state.write_locking && !state.read_lock) {
> +			struct task_struct *p =3D READ_ONCE(lock->owner);
> +			if (p)
> +				wake_up_process(p);
> +		}
> +	} else {
> +		struct list_head *wait_list =3D &lock->wait_list[waitlist_id];
> +		struct six_lock_waiter *w, *next;
> +
> +		if (!(state.waiters & (1 << waitlist_id)))
> +			return;
> +
> +		clear_bit(waitlist_bitnr(waitlist_id),
> +			  (unsigned long *) &lock->state.v);
> +
> +		raw_spin_lock(&lock->wait_lock);
> +
> +		list_for_each_entry_safe(w, next, wait_list, list) {
> +			list_del_init(&w->list);
> +
> +			if (wake_up_process(w->task) &&
> +			    waitlist_id !=3D SIX_LOCK_read) {
> +				if (!list_empty(wait_list))
> +					set_bit(waitlist_bitnr(waitlist_id),
> +						(unsigned long *) &lock->state.v);
> +				break;
> +			}
> +		}
> +
> +		raw_spin_unlock(&lock->wait_lock);
> +	}
> +}
> +
> +static __always_inline bool do_six_trylock_type(struct six_lock *lock,
> +						enum six_lock_type type,
> +						bool try)
> +{
> +	const struct six_lock_vals l[] =3D LOCK_VALS;
> +	union six_lock_state old, new;
> +	bool ret;
> +	u64 v;
> +
> +	EBUG_ON(type =3D=3D SIX_LOCK_write && lock->owner !=3D current);
> +	EBUG_ON(type =3D=3D SIX_LOCK_write && (lock->state.seq & 1));
> +
> +	EBUG_ON(type =3D=3D SIX_LOCK_write && (try !=3D !(lock->state.write_loc=
king)));
> +
> +	/*
> +	 * Percpu reader mode:
> +	 *
> +	 * The basic idea behind this algorithm is that you can implement a loc=
k
> +	 * between two threads without any atomics, just memory barriers:
> +	 *
> +	 * For two threads you'll need two variables, one variable for "thread =
a
> +	 * has the lock" and another for "thread b has the lock".
> +	 *
> +	 * To take the lock, a thread sets its variable indicating that it hold=
s
> +	 * the lock, then issues a full memory barrier, then reads from the
> +	 * other thread's variable to check if the other thread thinks it has
> +	 * the lock. If we raced, we backoff and retry/sleep.
> +	 */
> +
> +	if (type =3D=3D SIX_LOCK_read && lock->readers) {
> +retry:
> +		preempt_disable();
> +		this_cpu_inc(*lock->readers); /* signal that we own lock */
> +
> +		smp_mb();
> +
> +		old.v =3D READ_ONCE(lock->state.v);
> +		ret =3D !(old.v & l[type].lock_fail);
> +
> +		this_cpu_sub(*lock->readers, !ret);
> +		preempt_enable();
> +
> +		/*
> +		 * If we failed because a writer was trying to take the
> +		 * lock, issue a wakeup because we might have caused a
> +		 * spurious trylock failure:
> +		 */
> +		if (old.write_locking) {
> +			struct task_struct *p =3D READ_ONCE(lock->owner);
> +
> +			if (p)
> +				wake_up_process(p);
> +		}
> +
> +		/*
> +		 * If we failed from the lock path and the waiting bit wasn't
> +		 * set, set it:
> +		 */
> +		if (!try && !ret) {
> +			v =3D old.v;
> +
> +			do {
> +				new.v =3D old.v =3D v;
> +
> +				if (!(old.v & l[type].lock_fail))
> +					goto retry;
> +
> +				if (new.waiters & (1 << type))
> +					break;
> +
> +				new.waiters |=3D 1 << type;
> +			} while ((v =3D atomic64_cmpxchg(&lock->state.counter,
> +						       old.v, new.v)) !=3D old.v);
> +		}
> +	} else if (type =3D=3D SIX_LOCK_write && lock->readers) {
> +		if (try) {
> +			atomic64_add(__SIX_VAL(write_locking, 1),
> +				     &lock->state.counter);
> +			smp_mb__after_atomic();
> +		}
> +
> +		ret =3D !pcpu_read_count(lock);
> +
> +		/*
> +		 * On success, we increment lock->seq; also we clear
> +		 * write_locking unless we failed from the lock path:
> +		 */
> +		v =3D 0;
> +		if (ret)
> +			v +=3D __SIX_VAL(seq, 1);
> +		if (ret || try)
> +			v -=3D __SIX_VAL(write_locking, 1);
> +
> +		if (try && !ret) {
> +			old.v =3D atomic64_add_return(v, &lock->state.counter);
> +			six_lock_wakeup(lock, old, SIX_LOCK_read);
> +		} else {
> +			atomic64_add(v, &lock->state.counter);
> +		}
> +	} else {
> +		v =3D READ_ONCE(lock->state.v);
> +		do {
> +			new.v =3D old.v =3D v;
> +
> +			if (!(old.v & l[type].lock_fail)) {
> +				new.v +=3D l[type].lock_val;
> +
> +				if (type =3D=3D SIX_LOCK_write)
> +					new.write_locking =3D 0;
> +			} else if (!try && type !=3D SIX_LOCK_write &&
> +				   !(new.waiters & (1 << type)))
> +				new.waiters |=3D 1 << type;
> +			else
> +				break; /* waiting bit already set */
> +		} while ((v =3D atomic64_cmpxchg_acquire(&lock->state.counter,
> +					old.v, new.v)) !=3D old.v);
> +
> +		ret =3D !(old.v & l[type].lock_fail);
> +
> +		EBUG_ON(ret && !(lock->state.v & l[type].held_mask));
> +	}
> +
> +	if (ret)
> +		six_set_owner(lock, type, old);
> +
> +	EBUG_ON(type =3D=3D SIX_LOCK_write && (try || ret) && (lock->state.writ=
e_locking));
> +
> +	return ret;
> +}
> +

^^^
I'd really like to see some more comments in the code above. It's pretty
complex.

> +__always_inline __flatten
> +static bool __six_trylock_type(struct six_lock *lock, enum six_lock_type=
 type)
> +{
> +	if (!do_six_trylock_type(lock, type, true))
> +		return false;
> +
> +	if (type !=3D SIX_LOCK_write)
> +		six_acquire(&lock->dep_map, 1);
> +	return true;
> +}
> +
> +__always_inline __flatten
> +static bool __six_relock_type(struct six_lock *lock, enum six_lock_type =
type,
> +			      unsigned seq)
> +{
> +	const struct six_lock_vals l[] =3D LOCK_VALS;
> +	union six_lock_state old;
> +	u64 v;
> +
> +	EBUG_ON(type =3D=3D SIX_LOCK_write);
> +
> +	if (type =3D=3D SIX_LOCK_read &&
> +	    lock->readers) {
> +		bool ret;
> +
> +		preempt_disable();
> +		this_cpu_inc(*lock->readers);
> +
> +		smp_mb();
> +
> +		old.v =3D READ_ONCE(lock->state.v);
> +		ret =3D !(old.v & l[type].lock_fail) && old.seq =3D=3D seq;
> +
> +		this_cpu_sub(*lock->readers, !ret);
> +		preempt_enable();
> +
> +		/*
> +		 * Similar to the lock path, we may have caused a spurious write
> +		 * lock fail and need to issue a wakeup:
> +		 */
> +		if (old.write_locking) {
> +			struct task_struct *p =3D READ_ONCE(lock->owner);
> +
> +			if (p)
> +				wake_up_process(p);
> +		}
> +
> +		if (ret)
> +			six_acquire(&lock->dep_map, 1);
> +
> +		return ret;
> +	}
> +
> +	v =3D READ_ONCE(lock->state.v);
> +	do {
> +		old.v =3D v;
> +
> +		if (old.seq !=3D seq || old.v & l[type].lock_fail)
> +			return false;
> +	} while ((v =3D atomic64_cmpxchg_acquire(&lock->state.counter,
> +				old.v,
> +				old.v + l[type].lock_val)) !=3D old.v);
> +
> +	six_set_owner(lock, type, old);
> +	if (type !=3D SIX_LOCK_write)
> +		six_acquire(&lock->dep_map, 1);
> +	return true;
> +}
> +
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER
> +
> +static inline int six_can_spin_on_owner(struct six_lock *lock)
> +{
> +	struct task_struct *owner;
> +	int retval =3D 1;
> +
> +	if (need_resched())
> +		return 0;
> +
> +	rcu_read_lock();
> +	owner =3D READ_ONCE(lock->owner);
> +	if (owner)
> +		retval =3D owner->on_cpu;
> +	rcu_read_unlock();
> +	/*
> +	 * if lock->owner is not set, the mutex owner may have just acquired
> +	 * it and not set the owner yet or the mutex has been released.
> +	 */
> +	return retval;
> +}
> +
> +static inline bool six_spin_on_owner(struct six_lock *lock,
> +				     struct task_struct *owner)
> +{
> +	bool ret =3D true;
> +
> +	rcu_read_lock();
> +	while (lock->owner =3D=3D owner) {
> +		/*
> +		 * Ensure we emit the owner->on_cpu, dereference _after_
> +		 * checking lock->owner still matches owner. If that fails,
> +		 * owner might point to freed memory. If it still matches,
> +		 * the rcu_read_lock() ensures the memory stays valid.
> +		 */
> +		barrier();
> +
> +		if (!owner->on_cpu || need_resched()) {
> +			ret =3D false;
> +			break;
> +		}
> +
> +		cpu_relax();
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static inline bool six_optimistic_spin(struct six_lock *lock, enum six_l=
ock_type type)
> +{
> +	struct task_struct *task =3D current;
> +
> +	if (type =3D=3D SIX_LOCK_write)
> +		return false;
> +
> +	preempt_disable();
> +	if (!six_can_spin_on_owner(lock))
> +		goto fail;
> +
> +	if (!osq_lock(&lock->osq))
> +		goto fail;
> +
> +	while (1) {
> +		struct task_struct *owner;
> +
> +		/*
> +		 * If there's an owner, wait for it to either
> +		 * release the lock or go to sleep.
> +		 */
> +		owner =3D READ_ONCE(lock->owner);
> +		if (owner && !six_spin_on_owner(lock, owner))
> +			break;
> +
> +		if (do_six_trylock_type(lock, type, false)) {
> +			osq_unlock(&lock->osq);
> +			preempt_enable();
> +			return true;
> +		}
> +
> +		/*
> +		 * When there's no owner, we might have preempted between the
> +		 * owner acquiring the lock and setting the owner field. If
> +		 * we're an RT task that will live-lock because we won't let
> +		 * the owner complete.
> +		 */
> +		if (!owner && (need_resched() || rt_task(task)))
> +			break;
> +
> +		/*
> +		 * The cpu_relax() call is a compiler barrier which forces
> +		 * everything in this loop to be re-loaded. We don't need
> +		 * memory barriers as we'll eventually observe the right
> +		 * values at the cost of a few extra spins.
> +		 */
> +		cpu_relax();
> +	}
> +
> +	osq_unlock(&lock->osq);
> +fail:
> +	preempt_enable();
> +
> +	/*
> +	 * If we fell out of the spin path because of need_resched(),
> +	 * reschedule now, before we try-lock again. This avoids getting
> +	 * scheduled out right after we obtained the lock.
> +	 */
> +	if (need_resched())
> +		schedule();
> +
> +	return false;
> +}
> +
> +#else /* CONFIG_LOCK_SPIN_ON_OWNER */
> +
> +static inline bool six_optimistic_spin(struct six_lock *lock, enum six_l=
ock_type type)
> +{
> +	return false;
> +}
> +
> +#endif
> +
> +noinline
> +static int __six_lock_type_slowpath(struct six_lock *lock, enum six_lock=
_type type,
> +				    six_lock_should_sleep_fn should_sleep_fn, void *p)
> +{
> +	union six_lock_state old;
> +	struct six_lock_waiter wait;
> +	int ret =3D 0;
> +
> +	if (type =3D=3D SIX_LOCK_write) {
> +		EBUG_ON(lock->state.write_locking);
> +		atomic64_add(__SIX_VAL(write_locking, 1), &lock->state.counter);
> +		smp_mb__after_atomic();
> +	}
> +
> +	ret =3D should_sleep_fn ? should_sleep_fn(lock, p) : 0;
> +	if (ret)
> +		goto out_before_sleep;
> +
> +	if (six_optimistic_spin(lock, type))
> +		goto out_before_sleep;
> +
> +	lock_contended(&lock->dep_map, _RET_IP_);
> +
> +	INIT_LIST_HEAD(&wait.list);
> +	wait.task =3D current;
> +
> +	while (1) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (type =3D=3D SIX_LOCK_write)
> +			EBUG_ON(lock->owner !=3D current);
> +		else if (list_empty_careful(&wait.list)) {
> +			raw_spin_lock(&lock->wait_lock);
> +			list_add_tail(&wait.list, &lock->wait_list[type]);
> +			raw_spin_unlock(&lock->wait_lock);
> +		}
> +
> +		if (do_six_trylock_type(lock, type, false))
> +			break;
> +
> +		ret =3D should_sleep_fn ? should_sleep_fn(lock, p) : 0;
> +		if (ret)
> +			break;
> +
> +		schedule();
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +
> +	if (!list_empty_careful(&wait.list)) {
> +		raw_spin_lock(&lock->wait_lock);
> +		list_del_init(&wait.list);
> +		raw_spin_unlock(&lock->wait_lock);
> +	}
> +out_before_sleep:
> +	if (ret && type =3D=3D SIX_LOCK_write) {
> +		old.v =3D atomic64_sub_return(__SIX_VAL(write_locking, 1),
> +					    &lock->state.counter);
> +		six_lock_wakeup(lock, old, SIX_LOCK_read);
> +	}
> +
> +	return ret;
> +}
> +
> +__always_inline
> +static int __six_lock_type(struct six_lock *lock, enum six_lock_type typ=
e,
> +			   six_lock_should_sleep_fn should_sleep_fn, void *p)
> +{
> +	int ret;
> +
> +	if (type !=3D SIX_LOCK_write)
> +		six_acquire(&lock->dep_map, 0);
> +
> +	ret =3D do_six_trylock_type(lock, type, true) ? 0
> +		: __six_lock_type_slowpath(lock, type, should_sleep_fn, p);
> +
> +	if (ret && type !=3D SIX_LOCK_write)
> +		six_release(&lock->dep_map);
> +	if (!ret)
> +		lock_acquired(&lock->dep_map, _RET_IP_);
> +
> +	return ret;
> +}
> +
> +__always_inline __flatten
> +static void __six_unlock_type(struct six_lock *lock, enum six_lock_type =
type)
> +{
> +	const struct six_lock_vals l[] =3D LOCK_VALS;
> +	union six_lock_state state;
> +
> +	EBUG_ON(type =3D=3D SIX_LOCK_write &&
> +		!(lock->state.v & __SIX_LOCK_HELD_intent));
> +
> +	if (type !=3D SIX_LOCK_write)
> +		six_release(&lock->dep_map);
> +
> +	if (type =3D=3D SIX_LOCK_intent) {
> +		EBUG_ON(lock->owner !=3D current);
> +
> +		if (lock->intent_lock_recurse) {
> +			--lock->intent_lock_recurse;
> +			return;
> +		}
> +
> +		lock->owner =3D NULL;
> +	}
> +
> +	if (type =3D=3D SIX_LOCK_read &&
> +	    lock->readers) {
> +		smp_mb(); /* unlock barrier */
> +		this_cpu_dec(*lock->readers);
> +		smp_mb(); /* between unlocking and checking for waiters */
> +		state.v =3D READ_ONCE(lock->state.v);
> +	} else {
> +		EBUG_ON(!(lock->state.v & l[type].held_mask));
> +		state.v =3D atomic64_add_return_release(l[type].unlock_val,
> +						      &lock->state.counter);
> +	}
> +
> +	six_lock_wakeup(lock, state, l[type].unlock_wakeup);
> +}
> +
> +#define __SIX_LOCK(type)						\
> +bool six_trylock_##type(struct six_lock *lock)				\
> +{									\
> +	return __six_trylock_type(lock, SIX_LOCK_##type);		\
> +}									\
> +EXPORT_SYMBOL_GPL(six_trylock_##type);					\
> +									\
> +bool six_relock_##type(struct six_lock *lock, u32 seq)			\
> +{									\
> +	return __six_relock_type(lock, SIX_LOCK_##type, seq);		\
> +}									\
> +EXPORT_SYMBOL_GPL(six_relock_##type);					\
> +									\
> +int six_lock_##type(struct six_lock *lock,				\
> +		    six_lock_should_sleep_fn should_sleep_fn, void *p)	\
> +{									\
> +	return __six_lock_type(lock, SIX_LOCK_##type, should_sleep_fn, p);\
> +}									\
> +EXPORT_SYMBOL_GPL(six_lock_##type);					\
> +									\
> +void six_unlock_##type(struct six_lock *lock)				\
> +{									\
> +	__six_unlock_type(lock, SIX_LOCK_##type);			\
> +}									\
> +EXPORT_SYMBOL_GPL(six_unlock_##type);
> +
> +__SIX_LOCK(read)
> +__SIX_LOCK(intent)
> +__SIX_LOCK(write)
> +
> +#undef __SIX_LOCK
> +
> +/* Convert from intent to read: */
> +void six_lock_downgrade(struct six_lock *lock)
> +{
> +	six_lock_increment(lock, SIX_LOCK_read);
> +	six_unlock_intent(lock);
> +}
> +EXPORT_SYMBOL_GPL(six_lock_downgrade);
> +
> +bool six_lock_tryupgrade(struct six_lock *lock)
> +{
> +	union six_lock_state old, new;
> +	u64 v =3D READ_ONCE(lock->state.v);
> +
> +	do {
> +		new.v =3D old.v =3D v;
> +
> +		if (new.intent_lock)
> +			return false;
> +
> +		if (!lock->readers) {
> +			EBUG_ON(!new.read_lock);
> +			new.read_lock--;
> +		}
> +
> +		new.intent_lock =3D 1;
> +	} while ((v =3D atomic64_cmpxchg_acquire(&lock->state.counter,
> +				old.v, new.v)) !=3D old.v);
> +
> +	if (lock->readers)
> +		this_cpu_dec(*lock->readers);
> +
> +	six_set_owner(lock, SIX_LOCK_intent, old);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(six_lock_tryupgrade);
> +
> +bool six_trylock_convert(struct six_lock *lock,
> +			 enum six_lock_type from,
> +			 enum six_lock_type to)
> +{
> +	EBUG_ON(to =3D=3D SIX_LOCK_write || from =3D=3D SIX_LOCK_write);
> +
> +	if (to =3D=3D from)
> +		return true;
> +
> +	if (to =3D=3D SIX_LOCK_read) {
> +		six_lock_downgrade(lock);
> +		return true;
> +	} else {
> +		return six_lock_tryupgrade(lock);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(six_trylock_convert);
> +
> +/*
> + * Increment read/intent lock count, assuming we already have it read or=
 intent
> + * locked:
> + */
> +void six_lock_increment(struct six_lock *lock, enum six_lock_type type)
> +{
> +	const struct six_lock_vals l[] =3D LOCK_VALS;
> +
> +	six_acquire(&lock->dep_map, 0);
> +
> +	/* XXX: assert already locked, and that we don't overflow: */
> +
> +	switch (type) {
> +	case SIX_LOCK_read:
> +		if (lock->readers) {
> +			this_cpu_inc(*lock->readers);
> +		} else {
> +			EBUG_ON(!lock->state.read_lock &&
> +				!lock->state.intent_lock);
> +			atomic64_add(l[type].lock_val, &lock->state.counter);
> +		}
> +		break;
> +	case SIX_LOCK_intent:
> +		EBUG_ON(!lock->state.intent_lock);
> +		lock->intent_lock_recurse++;
> +		break;
> +	case SIX_LOCK_write:
> +		BUG();
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(six_lock_increment);
> +
> +void six_lock_wakeup_all(struct six_lock *lock)
> +{
> +	struct six_lock_waiter *w;
> +
> +	raw_spin_lock(&lock->wait_lock);
> +
> +	list_for_each_entry(w, &lock->wait_list[0], list)
> +		wake_up_process(w->task);
> +	list_for_each_entry(w, &lock->wait_list[1], list)
> +		wake_up_process(w->task);
> +
> +	raw_spin_unlock(&lock->wait_lock);
> +}
> +EXPORT_SYMBOL_GPL(six_lock_wakeup_all);
> +
> +struct free_pcpu_rcu {
> +	struct rcu_head		rcu;
> +	void __percpu		*p;
> +};
> +
> +static void free_pcpu_rcu_fn(struct rcu_head *_rcu)
> +{
> +	struct free_pcpu_rcu *rcu =3D
> +		container_of(_rcu, struct free_pcpu_rcu, rcu);
> +
> +	free_percpu(rcu->p);
> +	kfree(rcu);
> +}
> +
> +void six_lock_pcpu_free_rcu(struct six_lock *lock)
> +{
> +	struct free_pcpu_rcu *rcu =3D kzalloc(sizeof(*rcu), GFP_KERNEL);
> +
> +	if (!rcu)
> +		return;
> +
> +	rcu->p =3D lock->readers;
> +	lock->readers =3D NULL;
> +
> +	call_rcu(&rcu->rcu, free_pcpu_rcu_fn);
> +}
> +EXPORT_SYMBOL_GPL(six_lock_pcpu_free_rcu);
> +
> +void six_lock_pcpu_free(struct six_lock *lock)
> +{
> +	BUG_ON(lock->readers && pcpu_read_count(lock));
> +	BUG_ON(lock->state.read_lock);
> +
> +	free_percpu(lock->readers);
> +	lock->readers =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(six_lock_pcpu_free);
> +
> +void six_lock_pcpu_alloc(struct six_lock *lock)
> +{
> +#ifdef __KERNEL__
> +	if (!lock->readers)
> +		lock->readers =3D alloc_percpu(unsigned);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(six_lock_pcpu_alloc);
> +
> +/*
> + * Returns lock held counts, for both read and intent
> + */
> +struct six_lock_count six_lock_counts(struct six_lock *lock)
> +{
> +	struct six_lock_count ret =3D { 0, lock->state.intent_lock };
> +
> +	if (!lock->readers)
> +		ret.read +=3D lock->state.read_lock;
> +	else {
> +		int cpu;
> +
> +		for_each_possible_cpu(cpu)
> +			ret.read +=3D *per_cpu_ptr(lock->readers, cpu);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(six_lock_counts);

--=20
Jeff Layton <jlayton@kernel.org>
