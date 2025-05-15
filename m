Return-Path: <linux-fsdevel+bounces-49088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0217AB7BED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 05:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C8C189D06C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BC428F505;
	Thu, 15 May 2025 03:01:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD6213E8E;
	Thu, 15 May 2025 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278111; cv=none; b=CWEVhyo4KmuZizP3K7SoIVmKesXCMj3uW2N/FXaJ8EhNvF7yaoweyFjwcVs5VzIyrJU4MljLllEhJ8me218OVc+OCRFqZPCffRK/GeS74f33a0H0PP0YatA6eX3ldBKVI+UTchIg2L1CN90nNKnnVyXCk/Nl6kW5EvpOXs1qvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278111; c=relaxed/simple;
	bh=GcpQ2jNFUqhflz9Rwqv6/ptdkNaddhKvEa7UU75IzyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoeZpMM8+oPRtVDY7da3IRWzeixymgx2NbJHtYe/4ZrhraOfeZwu6vPWXZP5AkU4hPIFkEDl2cbm13UZnXMwGPHnuD6vYolGCKecTna25eR617KApXFH2LgdakgEVwUKBfzIlEE3IKwxZyyV89ZAUGjADvg/nbUazALF23rLQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-4d-6825591704b9
Date: Thu, 15 May 2025 12:01:38 +0900
From: Byungchul Park <byungchul@sk.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yskelg@gmail.com, yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v15 02/43] dept: implement DEPT(DEPendency Tracker)
Message-ID: <20250515030138.GC1851@system.software.com>
References: <20250513100730.12664-1-byungchul@sk.com>
 <20250513100730.12664-3-byungchul@sk.com>
 <5737f735-55c2-4146-87eb-c59f25517c63@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5737f735-55c2-4146-87eb-c59f25517c63@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHc869PfdS7XKtTM9gS1wZMavRDafZs5ewJWR6XbLEzH1wb5mN
	3NluBV3RKsu2wCjKihCnAlI61gIrDMqLpTEwLak46jo2V0fFqsAmcW4NRSbQRoThuJJlfnny
	y//J//ecD4dn1MdICm/I3SuZcnVGDVGyyvGlzrUr30zXP/39sY0Qny5hwd7uJjDd30cg1NaC
	wO0txBDt2wyXEzEEsz//wkBVRQiB8/owA97ACAJf0+cEBm48BOH4BIFgRSmBovp2AhfH5jAM
	VR7F0OJ5DX5z3WSh/0gdhqoogZqqIrww/sIw42rmwFWQDqNNNg7mrmdAcGRQAb6ra6C6dojA
	GV+QhUDXKIaB7+wERtz3FNAf+IGFRHkqhL4sU0DrrToCYwkXA674BAe/+h0YAo4V0GFZEB6c
	mlfA+TI/hoMNJzGEr5xG0FPyOwaPe5DAuXgMQ6engoG7jX0IRsvHOSg+PMNBTWE5gtLiShYs
	Qxth9s7C5a+mM6Dw6w4WWv8ZRC9niu5aNxLPxSYY0dK5X7wbv0REX8LBij/WUbHbNsyJlp6r
	nOjw7BM7m7Ri/ZkoFp2TcYXoaf6CiJ7Jo5xoHQ9j8daFC9zWR99SvpgtGQ1myfRU5g6lvvWn
	i8ye2DA60FjvYgpQjRNZURJPhQ20uzdIrIi/z6UerRyzQjo95BzCMhNhNY1EZhiZkwUtLYnH
	7jMjNC+hkdlkubpc2EwH216QY5XwLO04fpKzIiWvFioQvfZNF7O4WEaD1TfYxa6WRuajWO4y
	QiptnOflOEnIpFe+DRGZHxbSqP/UeSx7qDCSRO9YzjKLT36Enm2KsEeQYHtAa3tAa/tf60BM
	M1Ibcs05OoNxwzp9fq7hwLqdu3M8aOGruj6de7sLTYa29SKBR5qlKn/xE3q1QmfOy8/pRZRn
	NMmqyx+k6dWqbF3+x5Jp93umfUYprxel8qxmpWp9Yn+2Wtil2yt9KEl7JNN/W8wnpRSgBpU9
	Ldyw9e/Akpca2nXbP3nHkTXlXXa70nrzkrJs7HnjYb+ZY7I+6nFtevKZHatq19id3eKWE5Nz
	KTsLV322rfp9K9my3BdN+WNAyDbFAn/a/a8WT0xVhXfdPm4oSX8upMh5fEX/G6/fyzp1qMi8
	/tq72301bd5qQ0v5ptUnTnvXvvKYhs3T6zK0jClP9y8mKicXpgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH9zz39t5Lty7XyuQGspiUEUxFHVHDWTTol4VnZrp9Wcz0gzR6
	tZUXtUUUsxcYxVVQogRkFNRStCBtBW59gU0M4aWsogwGQ9CCQswyYpUMuM2wlY3OLPPLyS//
	f37nfDkcpZYVsZwhO0c0ZusyNYySVu7YVLgm5ssE/Yeh07Egz1toqGlyMTDf18PAwDUnAtf1
	AgzTPWnwIBhAELr/CwWVFQMIaifHKbjunUDQ3vAdA0NP34VheYYBX0UJA4V1TQwMPgtj8J8v
	w+CUtsNjx+809J21Y6icZqC6shAvjT8wLDgaWXDkJ8BUg5WF8GQy+CZGFNB1waeA9oeroeqi
	n4Hb7T4avK1TGIZ+rGFgwvW3Avq8P9MQLI2DgXNnFOB+YWfgWdBBgUOeYeHXDhsGr20FNJuX
	tp6cW1RA75kODCcvt2AYHvsJwR3LEwySa4SBLjmAwSNVUPCyvgfBVOlzFopOL7BQXVCKoKTo
	PA1m/0YI/bV0+cJ8MhRcaqbB/WoEbd1CXBddiHQFZihi9hwjL+XfGNIetNHkrl0gbdZxlpjv
	PGSJTTpKPA1aUnd7GpPaWVlBpMZTDJFmy1hS/HwYkxf9/ezn7+9Sbt4nZhpyReO61HSl3n1v
	kDocGEfH6+scVD6qrkXFiOMEfoNQImmLURRH8wnC97V+HGGGTxRGRxeoCEfzWsEiB/5lim98
	WxgNRUfU5XyaMHJtUyRW8SlCc3kLW4yUnJqvQMKjK63U62KZ4Kt6Sr92tcLo4jSOuBQfJ9Qv
	cpE4ik8Vxq4OMBF+j48XOm724rNIZX3Dtr5hW/+3bYhqRNGG7NwsnSFz41pThj4v23B87d5D
	WRJaekbH1+FzrWh+KK0T8RzSvKPqKPpAr1bock15WZ1I4ChNtOrBwXi9WrVPl3dCNB7aYzya
	KZo6URxHa2JU23aK6Wr+gC5HzBDFw6LxvxZzUbH5COlOrTpit1b1fpXiLZfVn1x1p4Q+7WfT
	V3afSOmWrjhXdt369lKMbbtzri1xS83kUFKiIe3PbRbSsMwTTFqdm9pU+ZGw/uZd/8fO8KA7
	PIc/q+n+wfNW9eaFV1Mrksrt+78Yu2F5lLOm5caOMnFrPLQ9aTMfnN25a7e4oX7sm3vrMzS0
	Sa9L1lJGk+4fPSskuIgDAAA=
X-CFilter-Loop: Reflected

On Thu, May 15, 2025 at 02:17:27AM +0530, ALOK TIWARI wrote:
> 
> 
> > + * DEPT(DEPendency Tracker) - Runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *
> > + * DEPT provides a general way to detect deadlock possibility in runtime
> > + * and the interest is not limited to typical lock but to every
> > + * syncronization primitives.
> 
> detect deadlock possibility in runtime -> detect potential deadlocks at
> runtime
> syncronization -> synchronization

Hi,

Thank you.  I will apply all of them.

	Byungchul
> 
> > + *
> > + * The following ideas were borrowed from LOCKDEP:
> > + *
> > + *    1) Use a graph to track relationship between classes.
> > + *    2) Prevent performance regression using hash.
> > + *
> > + * The following items were enhanced from LOCKDEP:
> > + *
> > + *    1) Cover more deadlock cases.
> > + *    2) Allow muliple reports.
> 
> muliple
> 
> > + *
> > + * TODO: Both LOCKDEP and DEPT should co-exist until DEPT is considered
> > + * stable. Then the dependency check routine should be replaced with
> > + * DEPT after. It should finally look like:
> > + *
> > + *
> > + *
> > + * As is:
> > + *
> > + *    LOCKDEP
> > + *    +-----------------------------------------+
> > + *    | Lock usage correctness check            | <-> locks
> > + *    |                                         |
> > + *    |                                         |
> > + *    | +-------------------------------------+ |
> > + *    | | Dependency check                    | |
> > + *    | | (by tracking lock acquisition order)| |
> > + *    | +-------------------------------------+ |
> > + *    |                                         |
> > + *    +-----------------------------------------+
> > + *
> > + *    DEPT
> > + *    +-----------------------------------------+
> > + *    | Dependency check                        | <-> waits/events
> > + *    | (by tracking wait and event context)    |
> > + *    +-----------------------------------------+
> > + *
> > + *
> > + *
> > + * To be:
> > + *
> > + *    LOCKDEP
> > + *    +-----------------------------------------+
> > + *    | Lock usage correctness check            | <-> locks
> > + *    |                                         |
> > + *    |                                         |
> > + *    |       (Request dependency check)        |
> > + *    |                    T                    |
> > + *    +--------------------|--------------------+
> > + *                         |
> > + *    DEPT                 V
> > + *    +-----------------------------------------+
> > + *    | Dependency check                        | <-> waits/events
> > + *    | (by tracking wait and event context)    |
> > + *    +-----------------------------------------+
> > + */
> > +
> > +#include <linux/sched.h>
> > +#include <linux/stacktrace.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/kallsyms.h>
> > +#include <linux/hash.h>
> > +#include <linux/dept.h>
> > +#include <linux/utsname.h>
> > +#include <linux/kernel.h>
> > +
> > +static int dept_stop;
> > +static int dept_per_cpu_ready;
> > +
> > +static inline struct dept_task *dept_task(void)
> > +{
> > +	return &current->dept_task;
> > +}
> > +
> > +#define DEPT_READY_WARN (!oops_in_progress && !dept_task()->in_warning)
> > +
> > +/*
> > + * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
> > + * prevent warning message.
> > + */
> > +#define DEPT_WARN_ON_ONCE(c)						\
> > +	({								\
> > +		int __ret = !!(c);					\
> > +									\
> > +		if (likely(DEPT_READY_WARN)) {				\
> > +			++dept_task()->in_warning;			\
> > +			WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);		\
> > +			--dept_task()->in_warning;			\
> > +		}							\
> > +		__ret;							\
> > +	})
> > +
> > +#define DEPT_WARN_ONCE(s...)						\
> > +	({								\
> > +		if (likely(DEPT_READY_WARN)) {				\
> > +			++dept_task()->in_warning;			\
> > +			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
> > +			--dept_task()->in_warning;			\
> > +		}							\
> > +	})
> > +
> > +#define DEPT_WARN_ON(c)							\
> > +	({								\
> > +		int __ret = !!(c);					\
> > +									\
> > +		if (likely(DEPT_READY_WARN)) {				\
> > +			++dept_task()->in_warning;			\
> > +			WARN(c, "DEPT_WARN_ON: " #c);			\
> > +			--dept_task()->in_warning;			\
> > +		}							\
> > +		__ret;							\
> > +	})
> > +
> > +#define DEPT_WARN(s...)							\
> > +	({								\
> > +		if (likely(DEPT_READY_WARN)) {				\
> > +			++dept_task()->in_warning;			\
> > +			WARN(1, "DEPT_WARN: " s);			\
> > +			--dept_task()->in_warning;			\
> > +		}							\
> > +	})
> > +
> > +#define DEPT_STOP(s...)							\
> > +	({								\
> > +		WRITE_ONCE(dept_stop, 1);				\
> > +		if (likely(DEPT_READY_WARN)) {				\
> > +			++dept_task()->in_warning;			\
> > +			WARN(1, "DEPT_STOP: " s);			\
> > +			--dept_task()->in_warning;			\
> > +		}							\
> > +	})
> > +
> > +#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
> > +
> > +static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> > +
> > +/*
> > + * DEPT internal engine should be careful in using outside functions
> > + * e.g. printk at reporting since that kind of usage might cause
> > + * untrackable deadlock.
> > + */
> 
> "be careful" -> "be cautious"
> 
> > +static atomic_t dept_outworld = ATOMIC_INIT(0);
> > +
> > +static void dept_outworld_enter(void)
> > +{
> > +	atomic_inc(&dept_outworld);
> > +}
> > +
> > +static void dept_outworld_exit(void)
> > +{
> > +	atomic_dec(&dept_outworld);
> > +}
> > +
> > +static bool dept_outworld_entered(void)
> > +{
> > +	return atomic_read(&dept_outworld);
> > +}
> > +
> > +static bool dept_lock(void)
> > +{
> > +	while (!arch_spin_trylock(&dept_spin))
> > +		if (unlikely(dept_outworld_entered()))
> > +			return false;
> > +	return true;
> > +}
> > +
> > +static void dept_unlock(void)
> > +{
> > +	arch_spin_unlock(&dept_spin);
> > +}
> > +
> > +enum bfs_ret {
> > +	BFS_CONTINUE,
> > +	BFS_DONE,
> > +	BFS_SKIP,
> > +};
> > +
> > +static bool before(unsigned int a, unsigned int b)
> > +{
> > +	return (int)(a - b) < 0;
> > +}
> > +
> > +static bool valid_stack(struct dept_stack *s)
> > +{
> > +	return s && s->nr > 0;
> > +}
> > +
> > +static bool valid_class(struct dept_class *c)
> > +{
> > +	return c->key;
> > +}
> > +
> > +static void invalidate_class(struct dept_class *c)
> > +{
> > +	c->key = 0UL;
> > +}
> > +
> > +static struct dept_ecxt *dep_e(struct dept_dep *d)
> > +{
> > +	return d->ecxt;
> > +}
> > +
> > +static struct dept_wait *dep_w(struct dept_dep *d)
> > +{
> > +	return d->wait;
> > +}
> > +
> > +static struct dept_class *dep_fc(struct dept_dep *d)
> > +{
> > +	return dep_e(d)->class;
> > +}
> > +
> > +static struct dept_class *dep_tc(struct dept_dep *d)
> > +{
> > +	return dep_w(d)->class;
> > +}
> > +
> > +static const char *irq_str(int irq)
> > +{
> > +	if (irq == DEPT_SIRQ)
> > +		return "softirq";
> > +	if (irq == DEPT_HIRQ)
> > +		return "hardirq";
> > +	return "(unknown)";
> > +}
> > +
> > +/*
> > + * Dept doesn't work either when it's stopped by DEPT_STOP() or in a nmi
> > + * context.
> > + */
> > +static bool dept_working(void)
> > +{
> > +	return !READ_ONCE(dept_stop) && !in_nmi();
> > +}
> > +
> > +/*
> > + * Even k == NULL is considered as a valid key because it would use
> > + * &->map_key as the key in that case.
> > + */
> > +struct dept_key __dept_no_validate__;
> > +static bool valid_key(struct dept_key *k)
> > +{
> > +	return &__dept_no_validate__ != k;
> > +}
> > +
> > +/*
> > + * Pool
> > + * =====================================================================
> > + * DEPT maintains pools to provide objects in a safe way.
> > + *
> > + *    1) Static pool is used at the beginning of booting time.
> > + *    2) Local pool is tried first before the static pool. Objects that
> > + *       have been freed will be placed.
> > + */
> > +
> > +enum object_t {
> > +#define OBJECT(id, nr) OBJECT_##id,
> > +	#include "dept_object.h"
> > +#undef  OBJECT
> > +	OBJECT_NR,
> > +};
> > +
> > +#define OBJECT(id, nr)							\
> > +static struct dept_##id spool_##id[nr];					\
> > +static DEFINE_PER_CPU(struct llist_head, lpool_##id);
> > +	#include "dept_object.h"
> > +#undef  OBJECT
> 
> is this extra ' ' require after #undef? consistent all place
> 
> > +
> > +struct dept_pool {
> > +	const char			*name;
> > +
> > +	/*
> > +	 * object size
> > +	 */
> > +	size_t				obj_sz;
> > +
> > +	/*
> > +	 * the number of the static array
> > +	 */
> > +	atomic_t			obj_nr;
> > +
> > +	/*
> > +	 * offset of ->pool_node
> > +	 */
> > +	size_t				node_off;
> > +
> > +	/*
> > +	 * pointer to the pool
> > +	 */
> > +	void				*spool;
> > +	struct llist_head		boot_pool;
> > +	struct llist_head __percpu	*lpool;
> > +};
> > +
> > +static struct dept_pool pool[OBJECT_NR] = {
> > +#define OBJECT(id, nr) {						\
> > +	.name = #id,							\
> > +	.obj_sz = sizeof(struct dept_##id),				\
> > +	.obj_nr = ATOMIC_INIT(nr),					\
> > +	.node_off = offsetof(struct dept_##id, pool_node),		\
> > +	.spool = spool_##id,						\
> > +	.lpool = &lpool_##id, },
> > +	#include "dept_object.h"
> > +#undef  OBJECT
> > +};
> > +
> > +/*
> > + * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
> > + * enabled or not because NMI and other contexts in the same CPU never
> > + * run inside of DEPT concurrently by preventing reentrance.
> > + */
> > +static void *from_pool(enum object_t t)
> > +{
> > +	struct dept_pool *p;
> > +	struct llist_head *h;
> > +	struct llist_node *n;
> > +
> > +	/*
> > +	 * llist_del_first() doesn't allow concurrent access e.g.
> > +	 * between process and IRQ context.
> > +	 */
> > +	if (DEPT_WARN_ON(!irqs_disabled()))
> > +		return NULL;
> > +
> > +	p = &pool[t];
> > +
> > +	/*
> > +	 * Try local pool first.
> > +	 */
> > +	if (likely(dept_per_cpu_ready))
> > +		h = this_cpu_ptr(p->lpool);
> > +	else
> > +		h = &p->boot_pool;
> > +
> > +	n = llist_del_first(h);
> > +	if (n)
> > +		return (void *)n - p->node_off;
> > +
> > +	/*
> > +	 * Try static pool.
> > +	 */
> > +	if (atomic_read(&p->obj_nr) > 0) {
> > +		int idx = atomic_dec_return(&p->obj_nr);
> > +
> > +		if (idx >= 0)
> > +			return p->spool + (idx * p->obj_sz);
> > +	}
> > +
> > +	DEPT_INFO_ONCE("---------------------------------------------\n"
> > +		"  Some of Dept internal resources are run out.\n"
> > +		"  Dept might still work if the resources get freed.\n"
> > +		"  However, the chances are Dept will suffer from\n"
> > +		"  the lack from now. Needs to extend the internal\n"
> > +		"  resource pools. Ask max.byungchul.park@gmail.com\n");
> > +	return NULL;
> > +}
> > +
> [clip]
> > +	return hash_lookup_dep(&onetime_d);
> > +}
> > +
> > +static struct dept_class *lookup_class(unsigned long key)
> > +{
> > +	struct dept_class onetime_c = { .key = key };
> > +
> > +	return hash_lookup_class(&onetime_c);
> > +}
> > +
> > +/*
> > + * Report
> > + * =====================================================================
> > + * DEPT prints useful information to help debuging on detection of
> 
> debuging
> 
> > + * problematic dependency.
> > + */
> > +
> > +static void print_ip_stack(unsigned long ip, struct dept_stack *s)
> > +{
> > +	if (ip)
> > +		print_ip_sym(KERN_WARNING, ip);
> > +
> > +#ifdef CONFIG_DEPT_DEBUG
> > +	if (!s)
> > +		pr_warn("stack is NULL.\n");
> > +	else if (!s->nr)
> > +		pr_warn("stack->nr is 0.\n");
> > +	if (s)
> [clip]
> > +		eh = dt->ecxt_held + i;
> > +		e = eh->ecxt;
> > +		if (e)
> > +			add_iecxt(e->class, irq, e, true);
> > +	}
> > +}
> > +
> > +static void dept_enirq(unsigned long ip)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long irqf = cur_enirqf();
> > +	int irq;
> > +	unsigned long flags;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	/*
> > +	 * IRQ ON/OFF transition might happen while Dept is working.
> > +	 * We cannot handle recursive entrance. Just ingnore it.
> 
> typo ingnore
> 
> > +	 * Only transitions outside of Dept will be considered.
> > +	 */
> > +	if (dt->recursive)
> > +		return;
> > +
> > +	flags = dept_enter();
> > +
> > +	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
> > +		dt->enirq_ip[irq] = ip;
> > +		enirq_transition(irq);
> > +	}
> > +
> > +	dept_exit(flags);
> > +}
> > +
> > +void dept_softirqs_on_ip(unsigned long ip)
> > +{
> > +	/*
> > +	 * Assumes that it's called with IRQ disabled so that accessing
> > +	 * current's fields is not racy.
> > +	 */
> > +	dept_task()->softirqs_enabled = true;
> > +	dept_enirq(ip);
> > +}
> > +
> > +void dept_hardirqs_on(void)
> > +{
> > +	/*
> > +	 * Assumes that it's called with IRQ disabled so that accessing
> > +	 * current's fields is not racy.
> > +	 */
> > +	dept_task()->hardirqs_enabled = true;
> > +	dept_enirq(_RET_IP_);
> > +}
> > +
> > +void dept_softirqs_off(void)
> > +{
> > +	/*
> > +	 * Assumes that it's called with IRQ disabled so that accessing
> > +	 * current's fields is not racy.
> > +	 */
> > +	dept_task()->softirqs_enabled = false;
> > +}
> > +
> > +void dept_hardirqs_off(void)
> > +{
> > +	/*
> > +	 * Assumes that it's called with IRQ disabled so that accessing
> > +	 * current's fields is not racy.
> > +	 */
> > +	dept_task()->hardirqs_enabled = false;
> > +}
> > +
> > +/*
> > + * Ensure it's the outmost softirq context.
> > + */
> > +void dept_softirq_enter(void)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +
> > +	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
> > +}
> > +
> > +/*
> > + * Ensure it's the outmost hardirq context.
> > + */
> > +void dept_hardirq_enter(void)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +
> > +	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
> > +}
> > +
> > +void dept_sched_enter(void)
> > +{
> > +	dept_task()->in_sched = true;
> > +}
> > +
> > +void dept_sched_exit(void)
> > +{
> > +	dept_task()->in_sched = false;
> > +}
> > +
> > +/*
> > + * Exposed APIs
> > + * =====================================================================
> > + */
> > +
> [clip]
> > +void dept_map_copy(struct dept_map *to, struct dept_map *from)
> > +{
> > +	if (unlikely(!dept_working())) {
> > +		to->nocheck = true;
> > +		return;
> > +	}
> > +
> > +	*to = *from;
> > +
> > +	/*
> > +	 * XXX: 'to' might be in a stack or something. Using the address
> > +	 * in a stack segment as a key is meaningless. Just ignore the
> > +	 * case for now.
> > +	 */
> > +	if (!to->keys) {
> > +		to->nocheck = true;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Since the class cache can be modified concurrently we could
> > +	 * observe half pointers (64bit arch using 32bit copy insns).
> 
> insns, Instructions?
> 
> > +	 * Therefore clear the caches and take the performance hit.
> > +	 *
> > +	 * XXX: Doesn't work well with lockdep_set_class_and_subclass()
> > +	 *      since that relies on cache abuse.
> > +	 */
> > +	clean_classes_cache(&to->map_key);
> > +}
> > +
> > +static LIST_HEAD(classes);
> > +
> > +static bool within(const void *addr, void *start, unsigned long size)
> > +{
> > +	return addr >= start && addr < start + size;
> > +}
> > +
> > +void dept_free_range(void *start, unsigned int sz)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	struct dept_class *c, *n;
> > +	unsigned long flags;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	if (dt->recursive) {
> > +		DEPT_STOP("Failed to successfully free Dept objects.\n");
> > +		return;
> > +	}
> > +
> > +	flags = dept_enter();
> > +
> > +	/*
> > +	 * dept_free_range() should not fail.
> > +	 *
> > +	 * FIXME: Should be fixed if dept_free_range() causes deadlock
> > +	 * with dept_lock().
> > +	 */
> > +	while (unlikely(!dept_lock()))
> > +		cpu_relax();
> > +
> > +	list_for_each_entry_safe(c, n, &classes, all_node) {
> > +		if (!within((void *)c->key, start, sz) &&
> > +		    !within(c->name, start, sz))
> > +			continue;
> > +
> > +		hash_del_class(c);
> > +		disconnect_class(c);
> > +		list_del(&c->all_node);
> > +		invalidate_class(c);
> > +
> > +		/*
> > +		 * Actual deletion will happen on the rcu callback
> > +		 * that has been added in disconnect_class().
> > +		 */
> > +		del_class(c);
> > +	}
> > +	dept_unlock();
> > +	dept_exit(flags);
> > +
> > +	/*
> > +	 * Wait until even lockless hash_lookup_class() for the class
> > +	 * returns NULL.
> > +	 */
> > +	might_sleep();
> > +	synchronize_rcu();
> > +}
> > +
> > +static int sub_id(struct dept_map *m, int e)
> > +{
> > +	return (m ? m->sub_u : 0) + e * DEPT_MAX_SUBCLASSES_USR;
> > +}
> > +
> > +static struct dept_class *check_new_class(struct dept_key *local,
> > +					  struct dept_key *k, int sub_id,
> > +					  const char *n, bool sched_map)
> > +{
> > +	struct dept_class *c = NULL;
> > +
> > +	if (DEPT_WARN_ON(sub_id >= DEPT_MAX_SUBCLASSES))
> > +		return NULL;
> > +
> > +	if (DEPT_WARN_ON(!k))
> > +		return NULL;
> > +
> > +	/*
> > +	 * XXX: Assume that users prevent the map from using if any of
> > +	 * the cached keys has been invalidated. If not, the cache,
> > +	 * local->classes should not be used because it would be racy
> > +	 * with class deletion.
> > +	 */
> > +	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
> > +		c = READ_ONCE(local->classes[sub_id]);
> > +
> > +	if (c)
> > +		return c;
> > +
> > +	c = lookup_class((unsigned long)k->base + sub_id);
> > +	if (c)
> > +		goto caching;
> > +
> > +	if (unlikely(!dept_lock()))
> > +		return NULL;
> > +
> > +	c = lookup_class((unsigned long)k->base + sub_id);
> > +	if (unlikely(c))
> > +		goto unlock;
> > +
> > +	c = new_class();
> > +	if (unlikely(!c))
> > +		goto unlock;
> > +
> > +	c->name = n;
> > +	c->sched_map = sched_map;
> > +	c->sub_id = sub_id;
> > +	c->key = (unsigned long)(k->base + sub_id);
> > +	hash_add_class(c);
> > +	list_add(&c->all_node, &classes);
> > +unlock:
> > +	dept_unlock();
> > +caching:
> > +	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
> > +		WRITE_ONCE(local->classes[sub_id], c);
> > +
> > +	return c;
> > +}
> > +
> > +/*
> > + * Called between dept_enter() and dept_exit().
> > + */
> > +static void __dept_wait(struct dept_map *m, unsigned long w_f,
> > +			unsigned long ip, const char *w_fn, int sub_l,
> > +			bool sched_sleep, bool sched_map)
> > +{
> > +	int e;
> > +
> > +	/*
> > +	 * Be as conservative as possible. In case of mulitple waits for
> > +	 * a single dept_map, we are going to keep only the last wait's
> > +	 * wgen for simplicity - keeping all wgens seems overengineering.
> 
> mulitple
> 
> > +	 *
> > +	 * Of course, it might cause missing some dependencies that
> > +	 * would rarely, probabily never, happen but it helps avoid
> > +	 * false positive report.
> 
> probabily ->probably
> "false positive report" -> "false positive reports"
> 
> > +	 */
> > +	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
> > +		struct dept_class *c;
> > +		struct dept_key *k;
> > +
> > +		k = m->keys ?: &m->map_key;
> > +		c = check_new_class(&m->map_key, k,
> > +				    sub_id(m, e), m->name, sched_map);
> > +		if (!c)
> > +			continue;
> > +
> > +		add_wait(c, ip, w_fn, sub_l, sched_sleep);
> > +	}
> > +}
> > +
> > +/*
> > + * Called between dept_enter() and dept_exit().
> > + */
> > +static void __dept_event(struct dept_map *m, struct dept_map *real_m,
> > +		unsigned long e_f, unsigned long ip, const char *e_fn,
> > +		bool sched_map)
> > +{
> > +	struct dept_class *c;
> > +	struct dept_key *k;
> > +	int e;
> > +
> > +	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
> > +
> > +	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
> > +		return;
> > +
> > +	/*
> > +	 * An event is an event. If the caller passed more than single
> > +	 * event, then warn it and handle the event corresponding to
> > +	 * the first bit anyway.
> > +	 */
> > +	DEPT_WARN_ON(1UL << e != e_f);
> > +
> > +	k = m->keys ?: &m->map_key;
> > +	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
> > +
> > +	if (c)
> > +		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
> > +}
> > +
> > +void dept_wait(struct dept_map *m, unsigned long w_f,
> > +	       unsigned long ip, const char *w_fn, int sub_l)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long flags;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	if (dt->recursive)
> > +		return;
> > +
> > +	if (m->nocheck)
> > +		return;
> > +
> > +	flags = dept_enter();
> > +
> > +	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
> > +
> > +	dept_exit(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dept_wait);
> > +
> > +void dept_stage_wait(struct dept_map *m, struct dept_key *k,
> > +		     unsigned long ip, const char *w_fn)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long flags;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	if (m && m->nocheck)
> > +		return;
> > +
> > +	/*
> > +	 * Either m or k should be passed. Which means Dept relies on
> > +	 * either its own map or the caller's position in the code when
> > +	 * determining its class.
> > +	 */
> > +	if (DEPT_WARN_ON(!m && !k))
> > +		return;
> > +
> > +	/*
> > +	 * Allow recursive entrance.
> > +	 */
> > +	flags = dept_enter_recursive();
> > +
> > +	/*
> > +	 * Ensure the outmost dept_stage_wait() works.
> > +	 */
> > +	if (dt->stage_m.keys)
> > +		goto exit;
> > +
> > +	arch_spin_lock(&dt->stage_lock);
> > +	if (m) {
> > +		dt->stage_m = *m;
> > +		dt->stage_real_m = m;
> > +
> > +		/*
> > +		 * Ensure dt->stage_m.keys != NULL and it works with the
> > +		 * map's map_key, not stage_m's one when ->keys == NULL.
> > +		 */
> > +		if (!m->keys)
> > +			dt->stage_m.keys = &m->map_key;
> > +	} else {
> > +		dt->stage_m.name = w_fn;
> > +		dt->stage_sched_map = true;
> > +		dt->stage_real_m = &dt->stage_m;
> > +	}
> > +
> > +	/*
> > +	 * dept_map_reinit() includes WRITE_ONCE(->wgen, 0U) that
> > +	 * effectively disables the map just in case real sleep won't
> > +	 * happen. dept_request_event_wait_commit() will enable it.
> > +	 */
> > +	dept_map_reinit(&dt->stage_m, k, -1, NULL);
> > +
> > +	dt->stage_w_fn = w_fn;
> > +	dt->stage_ip = ip;
> > +	arch_spin_unlock(&dt->stage_lock);
> > +exit:
> > +	dept_exit_recursive(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dept_stage_wait);
> > +
> > +static void __dept_clean_stage(struct dept_task *dt)
> > +{
> > +	memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
> > +	dt->stage_real_m = NULL;
> > +	dt->stage_sched_map = false;
> > +	dt->stage_w_fn = NULL;
> > +	dt->stage_ip = 0UL;
> > +}
> > +
> > +void dept_clean_stage(void)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long flags;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	/*
> > +	 * Allow recursive entrance.
> > +	 */
> > +	flags = dept_enter_recursive();
> > +	arch_spin_lock(&dt->stage_lock);
> > +	__dept_clean_stage(dt);
> > +	arch_spin_unlock(&dt->stage_lock);
> > +	dept_exit_recursive(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dept_clean_stage);
> > +
> > +/*
> > + * Always called from __schedule().
> > + */
> > +void dept_request_event_wait_commit(void)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	unsigned long flags;
> > +	unsigned int wg;
> > +	unsigned long ip;
> > +	const char *w_fn;
> > +	bool sched_map;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	/*
> > +	 * It's impossible that __schedule() is called while Dept is
> > +	 * working that already disabled IRQ at the entrance.
> > +	 */
> > +	if (DEPT_WARN_ON(dt->recursive))
> > +		return;
> > +
> > +	flags = dept_enter();
> > +
> > +	arch_spin_lock(&dt->stage_lock);
> > +
> > +	/*
> > +	 * Checks if current has staged a wait.
> > +	 */
> > +	if (!dt->stage_m.keys) {
> > +		arch_spin_unlock(&dt->stage_lock);
> > +		goto exit;
> > +	}
> > +
> > +	w_fn = dt->stage_w_fn;
> > +	ip = dt->stage_ip;
> > +	sched_map = dt->stage_sched_map;
> > +
> > +	wg = next_wgen();
> > +	WRITE_ONCE(dt->stage_m.wgen, wg);
> > +	arch_spin_unlock(&dt->stage_lock);
> > +
> > +	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
> > +exit:
> > +	dept_exit(flags);
> > +}
> > +
> > +/*
> > + * Always called from try_to_wake_up().
> > + */
> > +void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	struct dept_task *dt_req = &requestor->dept_task;
> > +	unsigned long flags;
> > +	struct dept_map m;
> > +	struct dept_map *real_m;
> > +	bool sched_map;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	if (dt->recursive)
> > +		return;
> > +
> > +	flags = dept_enter();
> > +
> > +	arch_spin_lock(&dt_req->stage_lock);
> > +
> > +	/*
> > +	 * Serializing is unnecessary as long as it always comes from
> > +	 * try_to_wake_up().
> > +	 */
> > +	m = dt_req->stage_m;
> > +	sched_map = dt_req->stage_sched_map;
> > +	real_m = dt_req->stage_real_m;
> > +	__dept_clean_stage(dt_req);
> > +	arch_spin_unlock(&dt_req->stage_lock);
> > +
> > +	/*
> > +	 * ->stage_m.keys should not be NULL if it's in use. Should
> > +	 * make sure that it's not NULL when staging a valid map.
> > +	 */
> > +	if (!m.keys)
> > +		goto exit;
> > +
> > +	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
> > +exit:
> > +	dept_exit(flags);
> > +}
> > +
> > +/*
> > + * Modifies the latest ecxt corresponding to m and e_f.
> > + */
> > +void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
> > +			  struct dept_key *new_k, unsigned long new_e_f,
> > +			  unsigned long new_ip, const char *new_c_fn,
> > +			  const char *new_e_fn, int new_sub_l)
> > +{
> > +	struct dept_task *dt = dept_task();
> > +	struct dept_ecxt_held *eh;
> > +	struct dept_class *c;
> > +	struct dept_key *k;
> > +	unsigned long flags;
> > +	int pos = -1;
> > +	int new_e;
> > +	int e;
> > +
> > +	if (unlikely(!dept_working()))
> > +		return;
> > +
> > +	/*
> > +	 * XXX: Couldn't handle re-enterance cases. Ingore it for now.
> > +	 */
> 
> typo Ingore
> 
> > +	if (dt->recursive)
> > +		return;
> > +
> > +	/*
> > +	 * Should go ahead no matter whether ->nocheck == true or not
> > +	 * because ->nocheck value can be changed within the ecxt area
> > +	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
> > +	 */
> > +
> > +	flags = dept_enter();
> > +
> > +	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
> [clip]
> > +	might_sleep();
> > +	synchronize_rcu();
> > +}
> > +EXPORT_SYMBOL_GPL(dept_key_destroy);
> > +
> > +static void move_llist(struct llist_head *to, struct llist_head *from)
> > +{
> > +	struct llist_node *first = llist_del_all(from);
> > +	struct llist_node *last;
> > +
> > +	if (!first)
> > +		return;
> > +
> > +	for (last = first; last->next; last = last->next);
> > +	llist_add_batch(first, last, to);
> > +}
> > +
> > +static void migrate_per_cpu_pool(void)
> > +{
> > +	const int boot_cpu = 0;
> > +	int i;
> > +
> > +	/*
> > +	 * The boot CPU has been using the temperal local pool so far.
> 
> typo temperal -> temporary/temporal
> 
> > +	 * From now on that per_cpu areas have been ready, use the
> > +	 * per_cpu local pool instead.
> > +	 */
> > +	DEPT_WARN_ON(smp_processor_id() != boot_cpu);
> > +	for (i = 0; i < OBJECT_NR; i++) {
> > +		struct llist_head *from;
> > +		struct llist_head *to;
> > +
> > +		from = &pool[i].boot_pool;
> > +		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
> > +		move_llist(to, from);
> > +	}
> > +}
> > +
> 
> Thanks,
> Alok

