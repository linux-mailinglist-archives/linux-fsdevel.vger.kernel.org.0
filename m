Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26C4BA746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbiBQRhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 12:37:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiBQRhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:37:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAF6565;
        Thu, 17 Feb 2022 09:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F3B618D7;
        Thu, 17 Feb 2022 17:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA24C340E8;
        Thu, 17 Feb 2022 17:36:57 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:36:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [PATCH 02/16] dept: Implement Dept(Dependency Tracker)
Message-ID: <20220217123656.389e8783@gandalf.local.home>
In-Reply-To: <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
        <1645095472-26530-3-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Feb 2022 19:57:38 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> diff --git a/include/linux/dept.h b/include/linux/dept.h
> new file mode 100644
> index 0000000..2ac4bca
> --- /dev/null
> +++ b/include/linux/dept.h
> @@ -0,0 +1,480 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DEPT(DEPendency Tracker) - runtime dependency tracker
> + *
> + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> + *
> + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> + */
> +
> +#ifndef __LINUX_DEPT_H
> +#define __LINUX_DEPT_H
> +
> +#ifdef CONFIG_DEPT
> +
> +#include <linux/types.h>
> +
> +struct task_struct;
> +
> +#define DEPT_MAX_STACK_ENTRY		16
> +#define DEPT_MAX_WAIT_HIST		64
> +#define DEPT_MAX_ECXT_HELD		48
> +
> +#define DEPT_MAX_SUBCLASSES		16
> +#define DEPT_MAX_SUBCLASSES_EVT		2
> +#define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
> +#define DEPT_MAX_SUBCLASSES_CACHE	2
> +
> +#define DEPT_SIRQ			0
> +#define DEPT_HIRQ			1
> +#define DEPT_IRQS_NR			2
> +#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
> +#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
> +
> +struct dept_ecxt;
> +struct dept_iecxt {
> +	struct dept_ecxt *ecxt;
> +	int enirq;
> +	bool staled; /* for preventing to add a new ecxt */
> +};
> +
> +struct dept_wait;
> +struct dept_iwait {
> +	struct dept_wait *wait;
> +	int irq;
> +	bool staled; /* for preventing to add a new wait */
> +	bool touched;
> +};

Nit. It makes it easier to read (and then review) if structures are spaced
where their fields are all lined up:

struct dept_iecxt {
	struct dept_ecxt		*ecxt;
	int				enirq;
	bool				staled;
};

struct dept_iwait {
	struct dept_wait		*wait;
	int				irq;
	bool				staled;
	bool				touched;
};

See, the fields stand out, and is nicer on the eyes. Especially for those
of us that are getting up in age, and our eyes do not work as well as they
use to ;-)

> +
> +struct dept_class {
> +	union {
> +		struct llist_node pool_node;
> +
> +		/*
> +		 * reference counter for object management
> +		 */
> +		atomic_t ref;
> +	};
> +
> +	/*
> +	 * unique information about the class
> +	 */
> +	const char *name;
> +	unsigned long key;
> +	int sub;
> +
> +	/*
> +	 * for BFS
> +	 */
> +	unsigned int bfs_gen;
> +	int bfs_dist;
> +	struct dept_class *bfs_parent;
> +
> +	/*
> +	 * for hashing this object
> +	 */
> +	struct hlist_node hash_node;
> +
> +	/*
> +	 * for linking all classes
> +	 */
> +	struct list_head all_node;
> +
> +	/*
> +	 * for associating its dependencies
> +	 */
> +	struct list_head dep_head;
> +	struct list_head dep_rev_head;
> +
> +	/*
> +	 * for tracking IRQ dependencies
> +	 */
> +	struct dept_iecxt iecxt[DEPT_IRQS_NR];
> +	struct dept_iwait iwait[DEPT_IRQS_NR];
> +};
> +


> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> new file mode 100644
> index 0000000..4a3ab39
> --- /dev/null
> +++ b/kernel/dependency/dept.c
> @@ -0,0 +1,2585 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DEPT(DEPendency Tracker) - Runtime dependency tracker
> + *
> + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> + *
> + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> + *
> + * DEPT provides a general way to detect deadlock possibility in runtime
> + * and the interest is not limited to typical lock but to every
> + * syncronization primitives.
> + *
[..]

> + *
> + *
> + * ---
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your ootion) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, you can access it online at
> + * http://www.gnu.org/licenses/gpl-2.0.html.

The SPDX at the top of the file is all that is needed. Please remove this
boiler plate. We do not use GPL boiler plates in the kernel anymore. The
SPDX code supersedes that.

> + */
> +
> +#include <linux/sched.h>
> +#include <linux/stacktrace.h>
> +#include <linux/spinlock.h>
> +#include <linux/kallsyms.h>
> +#include <linux/hash.h>
> +#include <linux/dept.h>
> +#include <linux/utsname.h>
> +
> +static int dept_stop;
> +static int dept_per_cpu_ready;
> +
> +#define DEPT_READY_WARN (!oops_in_progress)
> +
> +/*
> + * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
> + * prevent warning message.
> + */
> +#define DEPT_WARN_ON_ONCE(c)						\
> +	({								\
> +		int __ret = 0;						\
> +									\
> +		if (likely(DEPT_READY_WARN))				\
> +			__ret = WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);	\
> +		__ret;							\
> +	})
> +
> +#define DEPT_WARN_ONCE(s...)						\
> +	({								\
> +		if (likely(DEPT_READY_WARN))				\
> +			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
> +	})
> +
> +#define DEPT_WARN_ON(c)							\
> +	({								\
> +		int __ret = 0;						\
> +									\
> +		if (likely(DEPT_READY_WARN))				\
> +			__ret = WARN(c, "DEPT_WARN_ON: " #c);		\
> +		__ret;							\
> +	})
> +
> +#define DEPT_WARN(s...)							\
> +	({								\
> +		if (likely(DEPT_READY_WARN))				\
> +			WARN(1, "DEPT_WARN: " s);			\
> +	})
> +
> +#define DEPT_STOP(s...)							\
> +	({								\
> +		WRITE_ONCE(dept_stop, 1);				\
> +		if (likely(DEPT_READY_WARN))				\
> +			WARN(1, "DEPT_STOP: " s);			\
> +	})
> +
> +static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> +
> +/*
> + * DEPT internal engine should be careful in using outside functions
> + * e.g. printk at reporting since that kind of usage might cause
> + * untrackable deadlock.
> + */
> +static atomic_t dept_outworld = ATOMIC_INIT(0);
> +
> +static inline void dept_outworld_enter(void)
> +{
> +	atomic_inc(&dept_outworld);
> +}
> +
> +static inline void dept_outworld_exit(void)
> +{
> +	atomic_dec(&dept_outworld);
> +}
> +
> +static inline bool dept_outworld_entered(void)
> +{
> +	return atomic_read(&dept_outworld);
> +}
> +
> +static inline bool dept_lock(void)
> +{
> +	while (!arch_spin_trylock(&dept_spin))
> +		if (unlikely(dept_outworld_entered()))
> +			return false;
> +	return true;
> +}
> +
> +static inline void dept_unlock(void)
> +{
> +	arch_spin_unlock(&dept_spin);
> +}
> +
> +/*
> + * whether to stack-trace on every wait or every ecxt
> + */
> +static bool rich_stack = true;
> +
> +enum bfs_ret {
> +	BFS_CONTINUE,
> +	BFS_CONTINUE_REV,
> +	BFS_DONE,
> +	BFS_SKIP,
> +};
> +
> +static inline bool before(unsigned int a, unsigned int b)
> +{
> +	return (int)(a - b) < 0;
> +}
> +
> +static inline bool valid_stack(struct dept_stack *s)
> +{
> +	return s && s->nr > 0;
> +}
> +
> +static inline bool valid_class(struct dept_class *c)
> +{
> +	return c->key;
> +}
> +
> +static inline void inval_class(struct dept_class *c)
> +{
> +	c->key = 0UL;
> +}
> +
> +static inline struct dept_ecxt *dep_e(struct dept_dep *d)
> +{
> +	return d->ecxt;
> +}
> +
> +static inline struct dept_wait *dep_w(struct dept_dep *d)
> +{
> +	return d->wait;
> +}
> +
> +static inline struct dept_class *dep_fc(struct dept_dep *d)
> +{
> +	return dep_e(d)->class;
> +}
> +
> +static inline struct dept_class *dep_tc(struct dept_dep *d)
> +{
> +	return dep_w(d)->class;
> +}
> +
> +static inline const char *irq_str(int irq)
> +{
> +	if (irq == DEPT_SIRQ)
> +		return "softirq";
> +	if (irq == DEPT_HIRQ)
> +		return "hardirq";
> +	return "(unknown)";
> +}
> +
> +static inline struct dept_task *dept_task(void)
> +{
> +	return &current->dept_task;
> +}
> +
> +/*
> + * Pool
> + * =====================================================================
> + * DEPT maintains pools to provide objects in a safe way.
> + *
> + *    1) Static pool is used at the beginning of booting time.
> + *    2) Local pool is tried first before the static pool. Objects that
> + *       have been freed will be placed.
> + */
> +
> +enum object_t {
> +#define OBJECT(id, nr) OBJECT_##id,
> +	#include "dept_object.h"
> +#undef  OBJECT
> +	OBJECT_NR,
> +};
> +
> +#define OBJECT(id, nr)							\
> +static struct dept_##id spool_##id[nr];					\
> +static DEFINE_PER_CPU(struct llist_head, lpool_##id);
> +	#include "dept_object.h"
> +#undef  OBJECT
> +
> +static struct dept_pool pool[OBJECT_NR] = {
> +#define OBJECT(id, nr) {						\
> +	.name = #id,							\
> +	.obj_sz = sizeof(struct dept_##id),				\
> +	.obj_nr = ATOMIC_INIT(nr),					\
> +	.node_off = offsetof(struct dept_##id, pool_node),		\
> +	.spool = spool_##id,						\
> +	.lpool = &lpool_##id, },
> +	#include "dept_object.h"
> +#undef  OBJECT
> +};
> +
> +/*
> + * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
> + * enabled because DEPT never race with NMI by nesting control.

                         "never races with"

Although, I'm confused by what you mean with "by nesting control".

> + */
> +static void *from_pool(enum object_t t)
> +{
> +	struct dept_pool *p;
> +	struct llist_head *h;
> +	struct llist_node *n;
> +
> +	/*
> +	 * llist_del_first() doesn't allow concurrent access e.g.
> +	 * between process and IRQ context.
> +	 */
> +	if (DEPT_WARN_ON(!irqs_disabled()))
> +		return NULL;
> +
> +	p = &pool[t];
> +
> +	/*
> +	 * Try local pool first.
> +	 */
> +	if (likely(dept_per_cpu_ready))
> +		h = this_cpu_ptr(p->lpool);
> +	else
> +		h = &p->boot_pool;
> +
> +	n = llist_del_first(h);
> +	if (n)
> +		return (void *)n - p->node_off;
> +
> +	/*
> +	 * Try static pool.
> +	 */
> +	if (atomic_read(&p->obj_nr) > 0) {
> +		int idx = atomic_dec_return(&p->obj_nr);
> +		if (idx >= 0)
> +			return p->spool + (idx * p->obj_sz);
> +	}
> +
> +	DEPT_WARN_ONCE("Pool(%s) is empty.\n", p->name);
> +	return NULL;
> +}
> +
> +static void to_pool(void *o, enum object_t t)
> +{
> +	struct dept_pool *p = &pool[t];
> +	struct llist_head *h;
> +
> +	preempt_disable();
> +	if (likely(dept_per_cpu_ready))
> +		h = this_cpu_ptr(p->lpool);
> +	else
> +		h = &p->boot_pool;
> +
> +	llist_add(o + p->node_off, h);
> +	preempt_enable();
> +}
> +
> +#define OBJECT(id, nr)							\
> +static void (*ctor_##id)(struct dept_##id *a);				\
> +static void (*dtor_##id)(struct dept_##id *a);				\
> +static inline struct dept_##id *new_##id(void)				\
> +{									\
> +	struct dept_##id *a;						\
> +									\
> +	a = (struct dept_##id *)from_pool(OBJECT_##id);			\
> +	if (unlikely(!a))						\
> +		return NULL;						\
> +									\
> +	atomic_set(&a->ref, 1);						\
> +									\
> +	if (ctor_##id)							\
> +		ctor_##id(a);						\
> +									\
> +	return a;							\
> +}									\
> +									\
> +static inline struct dept_##id *get_##id(struct dept_##id *a)		\
> +{									\
> +	atomic_inc(&a->ref);						\
> +	return a;							\
> +}									\
> +									\
> +static inline void put_##id(struct dept_##id *a)			\
> +{									\
> +	if (!atomic_dec_return(&a->ref)) {				\
> +		if (dtor_##id)						\
> +			dtor_##id(a);					\
> +		to_pool(a, OBJECT_##id);				\
> +	}								\
> +}									\
> +									\
> +static inline void del_##id(struct dept_##id *a)			\
> +{									\
> +	put_##id(a);							\
> +}									\
> +									\
> +static inline bool id##_consumed(struct dept_##id *a)			\
> +{									\
> +	return a && atomic_read(&a->ref) > 1;				\
> +}
> +#include "dept_object.h"
> +#undef  OBJECT
> +
> +#define SET_CONSTRUCTOR(id, f) \
> +static void (*ctor_##id)(struct dept_##id *a) = f
> +
> +static void initialize_dep(struct dept_dep *d)
> +{
> +	INIT_LIST_HEAD(&d->bfs_node);
> +	INIT_LIST_HEAD(&d->dep_node);
> +	INIT_LIST_HEAD(&d->dep_rev_node);
> +}
> +SET_CONSTRUCTOR(dep, initialize_dep);
> +
> +static void initialize_class(struct dept_class *c)
> +{
> +	int i;
> +
> +	for (i = 0; i < DEPT_IRQS_NR; i++) {
> +		struct dept_iecxt *ie = &c->iecxt[i];
> +		struct dept_iwait *iw = &c->iwait[i];
> +
> +		ie->ecxt = NULL;
> +		ie->enirq = i;
> +		ie->staled = false;
> +
> +		iw->wait = NULL;
> +		iw->irq = i;
> +		iw->staled = false;
> +		iw->touched = false;
> +	}
> +	c->bfs_gen = 0U;

Is the U really necessary?

> +
> +	INIT_LIST_HEAD(&c->all_node);
> +	INIT_LIST_HEAD(&c->dep_head);
> +	INIT_LIST_HEAD(&c->dep_rev_head);
> +}
> +SET_CONSTRUCTOR(class, initialize_class);
> +
> +static void initialize_ecxt(struct dept_ecxt *e)
> +{
> +	int i;
> +
> +	for (i = 0; i < DEPT_IRQS_NR; i++) {
> +		e->enirq_stack[i] = NULL;
> +		e->enirq_ip[i] = 0UL;
> +	}
> +	e->ecxt_ip = 0UL;

Even UL is not necessary. Zero is zero.

> +	e->ecxt_stack = NULL;
> +	e->enirqf = 0UL;
> +	e->event_stack = NULL;
> +}
> +SET_CONSTRUCTOR(ecxt, initialize_ecxt);
> +

-- Steve
