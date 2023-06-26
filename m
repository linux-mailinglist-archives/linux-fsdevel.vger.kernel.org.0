Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99BD73DF9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjFZMo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFZMoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:20 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F254CE60;
        Mon, 26 Jun 2023 05:44:12 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-a6-64997d6b352d
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 02/25] dept: Implement Dept(Dependency Tracker)
Date:   Mon, 26 Jun 2023 20:56:37 +0900
Message-Id: <20230626115700.13873-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjH+3y+PzvOvjuNr5gf17AxhOgZZoytrz8Mw0xsuXVfOircKWUz
        4bKUENVRrV2XnVud5GpW6q4r9EO46JbTrhDi6MfEtVJ+3Gn+efba87yf119vlpDZqGBWFX9C
        VMcrYuW0hJT0Ty5acuT0TWWosXoeZF0KBe+PNBIK7pppaCsrRWCuPIvB8zgCXg33IRh75iBA
        l9OGoOhdFwGVjd0IrKZzNLR/mAJO7yANLTkZNJwvvkvDi6/jGNy51zCUWrZC61UDBvvoJxJ0
        Hhrydeexb3zGMGosYcCYMh96THkMjL9bDi3dHRRYOxfDzUI3DbXWFhIaq3owtD8ooKHb/IeC
        1sZmEtqyMim4M2Cg4euwkQCjd5CBl3Y9hnKtT/Rl3IrhwvffFDRl2n106x4G5+saBLa0txgs
        5g4aHnr7MFRYcgj4efsxgp7L/QykXhplIP/sZQQZqbkkOH41UaB1r4KxkQJ6w1rhYd8gIWgr
        TgrWYT0pPDHwQnVeFyNobZ2MoLckCBWmRUJxrQcLRUNeSrCUXKQFy9A1Rkjvd2LB3VFLCwPP
        nzNC840xcvusSMk6pRirShTVy9YfkMSU6xzksazfVFJvYymZgtLayXTEsjwXxpu0u9JR4D98
        +6MJ+5nmFvIu1yjh5yBuLl+R2UulIwlLcMWT+E/Njxj/71RuE3/fu9GfIbn5/JVUG+FfS7lV
        vC0jYkI5hy8tt//TBHKr+ZqnBuRnmS9yzt1AT2TyA/ncuoQJnsHXm1zkVSTVo4ASJFPFJ8Yp
        VLFhS2OS41VJS6OPxlmQr1XG0+P7qtBQ284GxLFIPlkaOvuGUkYpEjXJcQ2IZwl5kHTaiE4p
        kyoVyadE9dEodUKsqGlAM1lSPl26YvikUsYdUpwQj4jiMVH9/4rZwOAUtDvbme0oCNmxs32S
        3qXZ5G66Xld0/db6biJpTX29UbfRJl37KnIkPC8m4PCCVnWnwdx1b+6Qa08krnzh+Gbak1YT
        Hjy4d4tTk+VRGg/u//XGhP8EeajsAVPZx+gZZvuZEDCkhm8+HhIxe2Sl3RYQ1vKere48EwVi
        2bbCD/biXjmpiVEsX0SoNYq/IfU9Z1EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGfd9zznsOnTWHDvVE8SNNkIQpooJ5zNyiMYajUXT+2LIly2js
        2WgohbRYxciCApMVUWqCFfkIFNMR6AYrbn5AGQEtZUxASxBNJUpURKtEbBldq66d2Z8nV+77
        zvXr4ShFI7OM0+jyJb1OpVUSGS3L+Lh4XXZhtTrlt8/AfCoFAv4yGmrb7ARGfmlFYL90HMP0
        jXS4M+dDELo5TIGlagRB48P7FFxyTSBwNp8g4Hm0CEYDMwQGqsoJFDe1Ebj1PIzBe+4shlbH
        XhistGLoCU7RYJkmUGMpxpHzFEPQ1sKCrSgBJpsvsBB+uAEGJsYY6KsbYMB57yOorvcS6HIO
        0OC6MonBc62WwIT9HQODLjcNI+YKBn5+aSXwfM5GgS0ww8LtngYM7SUR27OwE8MPr98y0F/R
        E6GLv2IYvduJoLvsAQaHfYxAX8CHocNRRcE/P91AMHn6BQulp4Is1Bw/jaC89BwNw2/6GSjx
        pkFovpZs2yr2+WYosaTjsOica6DFP62CePXCfVYs6b7Hig2OQ2JHc5LY1DWNxcbZACM6Wn4k
        omP2LCuaXoxi0TvWRcSXQ0Os6D4fovev+Eq2VS1pNUZJv/7TTFlWu2WYzjO/ZY48cbXSRajM
        Q5tQDCfwqcIDfz+OMuEThfHxIBXlOH610FHxhDEhGUfxTR8IU+7rrAlx3If8DuH3wPbohuYT
        hDOl3VQ0lvNpQnd5+nvlKqG1vec/TQy/Wej8y4qirIhMTnh7SSWSNaAFLShOozPmqDTatGRD
        dlaBTnMk+WBujgNFHsdWGDZfQX5Pei/iOaRcKE9ZeV6tYFRGQ0FOLxI4ShknXzJvUSvkalXB
        UUmf+43+kFYy9KLlHK1cKt/9hZSp4L9T5UvZkpQn6f9vMRezrAjFv1rLzN2ORcSklR2zunzu
        9Ot391tk+fU5bPzC6VCiP6ETx+7x7TOP9+9KXbPz+0FX6fznxu3my4WPV+iOnnydkYe3xC92
        GNweezguM/eg+mbM7tAzRcvXy6sbv93n33Hsj0+KNh6YGkmtXb/lqjdYadxz8kuKGno0W9/3
        d3KdfpOSNmSpNiRReoPqX9BW9iY0AwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CURRENT STATUS
--------------
Lockdep tracks acquisition order of locks in order to detect deadlock,
and IRQ and IRQ enable/disable state as well to take accident
acquisitions into account.

Lockdep should be turned off once it detects and reports a deadlock
since the data structure and algorithm are not reusable after detection
because of the complex design.

PROBLEM
-------
*Waits* and their *events* that never reach eventually cause deadlock.
However, Lockdep is only interested in lock acquisition order, forcing
to emulate lock acqusition even for just waits and events that have
nothing to do with real lock.

Even worse, no one likes Lockdep's false positive detection because that
prevents further one that might be more valuable. That's why all the
kernel developers are sensitive to Lockdep's false positive.

Besides those, by tracking acquisition order, it cannot correctly deal
with read lock and cross-event e.g. wait_for_completion()/complete() for
deadlock detection. Lockdep is no longer a good tool for that purpose.

SOLUTION
--------
Again, *waits* and their *events* that never reach eventually cause
deadlock. The new solution, Dept(DEPendency Tracker), focuses on waits
and events themselves. Dept tracks waits and events and report it if
any event would be never reachable.

Dept does:
   . Works with read lock in the right way.
   . Works with any wait and event e.i. cross-event.
   . Continue to work even after reporting multiple times.
   . Provides simple and intuitive APIs.
   . Does exactly what dependency checker should do.

Q & A
-----
Q. Is this the first try ever to address the problem?
A. No. Cross-release feature (b09be676e0ff2 locking/lockdep: Implement
   the 'crossrelease' feature) addressed it 2 years ago that was a
   Lockdep extension and merged but reverted shortly because:

   Cross-release started to report valuable hidden problems but started
   to give report false positive reports as well. For sure, no one
   likes Lockdep's false positive reports since it makes Lockdep stop,
   preventing reporting further real problems.

Q. Why not Dept was developed as an extension of Lockdep?
A. Lockdep definitely includes all the efforts great developers have
   made for a long time so as to be quite stable enough. But I had to
   design and implement newly because of the following:

   1) Lockdep was designed to track lock acquisition order. The APIs and
      implementation do not fit on wait-event model.
   2) Lockdep is turned off on detection including false positive. Which
      is terrible and prevents developing any extension for stronger
      detection.

Q. Do you intend to totally replace Lockdep?
A. No. Lockdep also checks if lock usage is correct. Of course, the
   dependency check routine should be replaced but the other functions
   should be still there.

Q. Do you mean the dependency check routine should be replaced right
   away?
A. No. I admit Lockdep is stable enough thanks to great efforts kernel
   developers have made. Lockdep and Dept, both should be in the kernel
   until Dept gets considered stable.

Q. Stronger detection capability would give more false positive report.
   Which was a big problem when cross-release was introduced. Is it ok
   with Dept?
A. It's ok. Dept allows multiple reporting thanks to simple and quite
   generalized design. Of course, false positive reports should be fixed
   anyway but it's no longer as a critical problem as it was.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h            |  577 ++++++
 include/linux/hardirq.h         |    3 +
 include/linux/sched.h           |    3 +
 init/init_task.c                |    2 +
 init/main.c                     |    2 +
 kernel/Makefile                 |    1 +
 kernel/dependency/Makefile      |    3 +
 kernel/dependency/dept.c        | 3009 +++++++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h   |   10 +
 kernel/dependency/dept_object.h |   13 +
 kernel/exit.c                   |    1 +
 kernel/fork.c                   |    2 +
 kernel/module/main.c            |    2 +
 kernel/sched/core.c             |    9 +
 lib/Kconfig.debug               |   27 +
 lib/locking-selftest.c          |    2 +
 16 files changed, 3666 insertions(+)
 create mode 100644 include/linux/dept.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_object.h

diff --git a/include/linux/dept.h b/include/linux/dept.h
new file mode 100644
index 000000000000..b6d45b4b1fd6
--- /dev/null
+++ b/include/linux/dept.h
@@ -0,0 +1,577 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DEPT(DEPendency Tracker) - runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_H
+#define __LINUX_DEPT_H
+
+#ifdef CONFIG_DEPT
+
+#include <linux/types.h>
+
+struct task_struct;
+
+#define DEPT_MAX_STACK_ENTRY		16
+#define DEPT_MAX_WAIT_HIST		64
+#define DEPT_MAX_ECXT_HELD		48
+
+#define DEPT_MAX_SUBCLASSES		16
+#define DEPT_MAX_SUBCLASSES_EVT		2
+#define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
+#define DEPT_MAX_SUBCLASSES_CACHE	2
+
+#define DEPT_SIRQ			0
+#define DEPT_HIRQ			1
+#define DEPT_IRQS_NR			2
+#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+
+struct dept_ecxt;
+struct dept_iecxt {
+	struct dept_ecxt		*ecxt;
+	int				enirq;
+	/*
+	 * for preventing to add a new ecxt
+	 */
+	bool				staled;
+};
+
+struct dept_wait;
+struct dept_iwait {
+	struct dept_wait		*wait;
+	int				irq;
+	/*
+	 * for preventing to add a new wait
+	 */
+	bool				staled;
+	bool				touched;
+};
+
+struct dept_class {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * unique information about the class
+			 */
+			const char	*name;
+			unsigned long	key;
+			int		sub_id;
+
+			/*
+			 * for BFS
+			 */
+			unsigned int	bfs_gen;
+			int		bfs_dist;
+			struct dept_class *bfs_parent;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking all classes
+			 */
+			struct list_head all_node;
+
+			/*
+			 * for associating its dependencies
+			 */
+			struct list_head dep_head;
+			struct list_head dep_rev_head;
+
+			/*
+			 * for tracking IRQ dependencies
+			 */
+			struct dept_iecxt iecxt[DEPT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_IRQS_NR];
+
+			/*
+			 * classified by a map embedded in task_struct,
+			 * not an explicit map
+			 */
+			bool		sched_map;
+		};
+	};
+};
+
+struct dept_key {
+	union {
+		/*
+		 * Each byte-wise address will be used as its key.
+		 */
+		char			base[DEPT_MAX_SUBCLASSES];
+
+		/*
+		 * for caching the main class pointer
+		 */
+		struct dept_class	*classes[DEPT_MAX_SUBCLASSES_CACHE];
+	};
+};
+
+struct dept_map {
+	const char			*name;
+	struct dept_key			*keys;
+
+	/*
+	 * subclass that can be set from user
+	 */
+	int				sub_u;
+
+	/*
+	 * It's local copy for fast access to the associated classes.
+	 * Also used for dept_key for static maps.
+	 */
+	struct dept_key			map_key;
+
+	/*
+	 * wait timestamp associated to this map
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * whether this map should be going to be checked or not
+	 */
+	bool				nocheck;
+};
+
+#define DEPT_MAP_INITIALIZER(n, k)					\
+{									\
+	.name = #n,							\
+	.keys = (struct dept_key *)(k),					\
+	.sub_u = 0,							\
+	.map_key = { .classes = { NULL, } },				\
+	.wgen = 0U,							\
+	.nocheck = false,						\
+}
+
+struct dept_stack {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * backtrace entries
+			 */
+			unsigned long	raw[DEPT_MAX_STACK_ENTRY];
+			int nr;
+		};
+	};
+};
+
+struct dept_ecxt {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * function that entered to this ecxt
+			 */
+			const char	*ecxt_fn;
+
+			/*
+			 * event function
+			 */
+			const char	*event_fn;
+
+			/*
+			 * associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * flag indicating which IRQ has been
+			 * enabled within the event context
+			 */
+			unsigned long	enirqf;
+
+			/*
+			 * where the IRQ-enabled happened
+			 */
+			unsigned long	enirq_ip[DEPT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+
+			/*
+			 * where the event context started
+			 */
+			unsigned long	ecxt_ip;
+			struct dept_stack *ecxt_stack;
+
+			/*
+			 * where the event triggered
+			 */
+			unsigned long	event_ip;
+			struct dept_stack *event_stack;
+		};
+	};
+};
+
+struct dept_wait {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * function causing this wait
+			 */
+			const char	*wait_fn;
+
+			/*
+			 * the associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * which IRQ the wait was placed in
+			 */
+			unsigned long	irqf;
+
+			/*
+			 * where the IRQ wait happened
+			 */
+			unsigned long	irq_ip[DEPT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+
+			/*
+			 * where the wait happened
+			 */
+			unsigned long	wait_ip;
+			struct dept_stack *wait_stack;
+
+			/*
+			 * whether this wait is for commit in scheduler
+			 */
+			bool		sched_sleep;
+		};
+	};
+};
+
+struct dept_dep {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * key data of dependency
+			 */
+			struct dept_ecxt *ecxt;
+			struct dept_wait *wait;
+
+			/*
+			 * This object can be referred without dept_lock
+			 * held but with IRQ disabled, e.g. for hash
+			 * lookup. So deferred deletion is needed.
+			 */
+			struct rcu_head rh;
+
+			/*
+			 * for BFS
+			 */
+			struct list_head bfs_node;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking to a class object
+			 */
+			struct list_head dep_node;
+			struct list_head dep_rev_node;
+		};
+	};
+};
+
+struct dept_hash {
+	/*
+	 * hash table
+	 */
+	struct hlist_head		*table;
+
+	/*
+	 * size of the table e.i. 2^bits
+	 */
+	int				bits;
+};
+
+struct dept_pool {
+	const char			*name;
+
+	/*
+	 * object size
+	 */
+	size_t				obj_sz;
+
+	/*
+	 * the number of the static array
+	 */
+	atomic_t			obj_nr;
+
+	/*
+	 * offset of ->pool_node
+	 */
+	size_t				node_off;
+
+	/*
+	 * pointer to the pool
+	 */
+	void				*spool;
+	struct llist_head		boot_pool;
+	struct llist_head __percpu	*lpool;
+};
+
+struct dept_ecxt_held {
+	/*
+	 * associated event context
+	 */
+	struct dept_ecxt		*ecxt;
+
+	/*
+	 * unique key for this dept_ecxt_held
+	 */
+	struct dept_map			*map;
+
+	/*
+	 * class of the ecxt of this dept_ecxt_held
+	 */
+	struct dept_class		*class;
+
+	/*
+	 * the wgen when the event context started
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * subclass that only works in the local context
+	 */
+	int				sub_l;
+};
+
+struct dept_wait_hist {
+	/*
+	 * associated wait
+	 */
+	struct dept_wait		*wait;
+
+	/*
+	 * unique id of all waits system-wise until wrapped
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * local context id to identify IRQ context
+	 */
+	unsigned int			ctxt_id;
+};
+
+struct dept_task {
+	/*
+	 * all event contexts that have entered and before exiting
+	 */
+	struct dept_ecxt_held		ecxt_held[DEPT_MAX_ECXT_HELD];
+	int				ecxt_held_pos;
+
+	/*
+	 * ring buffer holding all waits that have happened
+	 */
+	struct dept_wait_hist		wait_hist[DEPT_MAX_WAIT_HIST];
+	int				wait_hist_pos;
+
+	/*
+	 * sequential id to identify each IRQ context
+	 */
+	unsigned int			irq_id[DEPT_IRQS_NR];
+
+	/*
+	 * for tracking IRQ-enabled points with cross-event
+	 */
+	unsigned int			wgen_enirq[DEPT_IRQS_NR];
+
+	/*
+	 * for keeping up-to-date IRQ-enabled points
+	 */
+	unsigned long			enirq_ip[DEPT_IRQS_NR];
+
+	/*
+	 * current effective IRQ-enabled flag
+	 */
+	unsigned long			eff_enirqf;
+
+	/*
+	 * for reserving a current stack instance at each operation
+	 */
+	struct dept_stack		*stack;
+
+	/*
+	 * for preventing recursive call into DEPT engine
+	 */
+	int				recursive;
+
+	/*
+	 * for staging data to commit a wait
+	 */
+	struct dept_map			stage_m;
+	bool				stage_sched_map;
+	const char			*stage_w_fn;
+	unsigned long			stage_ip;
+
+	/*
+	 * the number of missing ecxts
+	 */
+	int				missing_ecxt;
+
+	/*
+	 * for tracking IRQ-enable state
+	 */
+	bool				hardirqs_enabled;
+	bool				softirqs_enabled;
+
+	/*
+	 * whether the current is on do_exit()
+	 */
+	bool				task_exit;
+
+	/*
+	 * whether the current is running __schedule()
+	 */
+	bool				in_sched;
+};
+
+#define DEPT_TASK_INITIALIZER(t)				\
+{								\
+	.wait_hist = { { .wait = NULL, } },			\
+	.ecxt_held_pos = 0,					\
+	.wait_hist_pos = 0,					\
+	.irq_id = { 0U },					\
+	.wgen_enirq = { 0U },					\
+	.enirq_ip = { 0UL },					\
+	.eff_enirqf = 0UL,					\
+	.stack = NULL,						\
+	.recursive = 0,						\
+	.stage_m = DEPT_MAP_INITIALIZER((t)->stage_m, NULL),	\
+	.stage_sched_map = false,				\
+	.stage_w_fn = NULL,					\
+	.stage_ip = 0UL,					\
+	.missing_ecxt = 0,					\
+	.hardirqs_enabled = false,				\
+	.softirqs_enabled = false,				\
+	.task_exit = false,					\
+	.in_sched = false,					\
+}
+
+extern void dept_on(void);
+extern void dept_off(void);
+extern void dept_init(void);
+extern void dept_task_init(struct task_struct *t);
+extern void dept_task_exit(struct task_struct *t);
+extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
+
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_request_event_wait_commit(void);
+extern void dept_clean_stage(void);
+extern void dept_stage_event(struct task_struct *t, unsigned long ip);
+extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
+extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
+extern void dept_request_event(struct dept_map *m);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
+extern void dept_sched_enter(void);
+extern void dept_sched_exit(void);
+
+static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
+{
+	dept_ecxt_enter(m, 0UL, 0UL, NULL, NULL, 0);
+}
+
+/*
+ * for users who want to manage external keys
+ */
+extern void dept_key_init(struct dept_key *k);
+extern void dept_key_destroy(struct dept_key *k);
+extern void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f, struct dept_key *new_k, unsigned long new_e_f, unsigned long new_ip, const char *new_c_fn, const char *new_e_fn, int new_sub_l);
+
+extern void dept_softirq_enter(void);
+extern void dept_hardirq_enter(void);
+extern void dept_softirqs_on_ip(unsigned long ip);
+extern void dept_hardirqs_on(void);
+extern void dept_hardirqs_on_ip(unsigned long ip);
+extern void dept_softirqs_off_ip(unsigned long ip);
+extern void dept_hardirqs_off(void);
+extern void dept_hardirqs_off_ip(unsigned long ip);
+#else /* !CONFIG_DEPT */
+struct dept_key  { };
+struct dept_map  { };
+struct dept_task { };
+
+#define DEPT_MAP_INITIALIZER(n, k) { }
+#define DEPT_TASK_INITIALIZER(t)   { }
+
+#define dept_on()					do { } while (0)
+#define dept_off()					do { } while (0)
+#define dept_init()					do { } while (0)
+#define dept_task_init(t)				do { } while (0)
+#define dept_task_exit(t)				do { } while (0)
+#define dept_free_range(s, sz)				do { } while (0)
+#define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_copy(t, f)				do { } while (0)
+
+#define dept_wait(m, w_f, ip, w_fn, sl)			do { (void)(w_fn); } while (0)
+#define dept_stage_wait(m, k, ip, w_fn)			do { (void)(k); (void)(w_fn); } while (0)
+#define dept_request_event_wait_commit()		do { } while (0)
+#define dept_clean_stage()				do { } while (0)
+#define dept_stage_event(t, ip)				do { } while (0)
+#define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, sl)	do { (void)(c_fn); (void)(e_fn); } while (0)
+#define dept_ecxt_holding(m, e_f)			false
+#define dept_request_event(m)				do { } while (0)
+#define dept_event(m, e_f, ip, e_fn)			do { (void)(e_fn); } while (0)
+#define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
+#define dept_sched_enter()				do { } while (0)
+#define dept_sched_exit()				do { } while (0)
+#define dept_ecxt_enter_nokeep(m)			do { } while (0)
+#define dept_key_init(k)				do { (void)(k); } while (0)
+#define dept_key_destroy(k)				do { (void)(k); } while (0)
+#define dept_map_ecxt_modify(m, e_f, n_k, n_e_f, n_ip, n_c_fn, n_e_fn, n_sl) do { (void)(n_k); (void)(n_c_fn); (void)(n_e_fn); } while (0)
+
+#define dept_softirq_enter()				do { } while (0)
+#define dept_hardirq_enter()				do { } while (0)
+#define dept_softirqs_on_ip(ip)				do { } while (0)
+#define dept_hardirqs_on()				do { } while (0)
+#define dept_hardirqs_on_ip(ip)				do { } while (0)
+#define dept_softirqs_off_ip(ip)			do { } while (0)
+#define dept_hardirqs_off()				do { } while (0)
+#define dept_hardirqs_off_ip(ip)			do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_H */
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06..bb279dbbe748 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking_state.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/ftrace_irq.h>
 #include <linux/sched.h>
 #include <linux/vtime.h>
@@ -106,6 +107,7 @@ void irq_exit_rcu(void);
  */
 #define __nmi_enter()						\
 	do {							\
+		dept_off();					\
 		lockdep_off();					\
 		arch_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
@@ -128,6 +130,7 @@ void irq_exit_rcu(void);
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		arch_nmi_exit();				\
 		lockdep_on();					\
+		dept_on();					\
 	} while (0)
 
 #define nmi_exit()						\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..fcb009900134 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -37,6 +37,7 @@
 #include <linux/kcsan.h>
 #include <linux/rv.h>
 #include <asm/kmap_size.h>
+#include <linux/dept.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1168,6 +1169,8 @@ struct task_struct {
 	struct held_lock		held_locks[MAX_LOCK_DEPTH];
 #endif
 
+	struct dept_task		dept_task;
+
 #if defined(CONFIG_UBSAN) && !defined(CONFIG_UBSAN_TRAP)
 	unsigned int			in_ubsan;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index ff6c4b9bfe6b..eb36ad68c912 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -12,6 +12,7 @@
 #include <linux/audit.h>
 #include <linux/numa.h>
 #include <linux/scs.h>
+#include <linux/dept.h>
 
 #include <linux/uaccess.h>
 
@@ -194,6 +195,7 @@ struct task_struct init_task
 	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
+	.dept_task = DEPT_TASK_INITIALIZER(init_task),
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.ret_stack		= NULL,
 	.tracing_graph_pause	= ATOMIC_INIT(0),
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..6e5b492640b2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -66,6 +66,7 @@
 #include <linux/debug_locks.h>
 #include <linux/debugobjects.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/kmemleak.h>
 #include <linux/padata.h>
 #include <linux/pid_namespace.h>
@@ -1080,6 +1081,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		      panic_param);
 
 	lockdep_init();
+	dept_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..d1eb49eaa739 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -51,6 +51,7 @@ obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
 obj-$(CONFIG_MODULES) += module/
+obj-y += dependency/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
new file mode 100644
index 000000000000..b5cfb8a03c0c
--- /dev/null
+++ b/kernel/dependency/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DEPT) += dept.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
new file mode 100644
index 000000000000..8ec638254e5f
--- /dev/null
+++ b/kernel/dependency/dept.c
@@ -0,0 +1,3009 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DEPT(DEPendency Tracker) - Runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *
+ * DEPT provides a general way to detect deadlock possibility in runtime
+ * and the interest is not limited to typical lock but to every
+ * syncronization primitives.
+ *
+ * The following ideas were borrowed from LOCKDEP:
+ *
+ *    1) Use a graph to track relationship between classes.
+ *    2) Prevent performance regression using hash.
+ *
+ * The following items were enhanced from LOCKDEP:
+ *
+ *    1) Cover more deadlock cases.
+ *    2) Allow muliple reports.
+ *
+ * TODO: Both LOCKDEP and DEPT should co-exist until DEPT is considered
+ * stable. Then the dependency check routine should be replaced with
+ * DEPT after. It should finally look like:
+ *
+ *
+ *
+ * As is:
+ *
+ *    LOCKDEP
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    |                                         |
+ *    |                                         |
+ *    | +-------------------------------------+ |
+ *    | | Dependency check                    | |
+ *    | | (by tracking lock acquisition order)| |
+ *    | +-------------------------------------+ |
+ *    |                                         |
+ *    +-----------------------------------------+
+ *
+ *    DEPT
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |
+ *    +-----------------------------------------+
+ *
+ *
+ *
+ * To be:
+ *
+ *    LOCKDEP
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    |                                         |
+ *    |                                         |
+ *    |       (Request dependency check)        |
+ *    |                    T                    |
+ *    +--------------------|--------------------+
+ *                         |
+ *    DEPT                 V
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |
+ *    +-----------------------------------------+
+ */
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/hash.h>
+#include <linux/dept.h>
+#include <linux/utsname.h>
+#include <linux/kernel.h>
+
+static int dept_stop;
+static int dept_per_cpu_ready;
+
+#define DEPT_READY_WARN (!oops_in_progress)
+
+/*
+ * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
+ * prevent warning message.
+ */
+#define DEPT_WARN_ON_ONCE(c)						\
+	({								\
+		int __ret = 0;						\
+									\
+		if (likely(DEPT_READY_WARN))				\
+			__ret = WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);	\
+		__ret;							\
+	})
+
+#define DEPT_WARN_ONCE(s...)						\
+	({								\
+		if (likely(DEPT_READY_WARN))				\
+			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
+	})
+
+#define DEPT_WARN_ON(c)							\
+	({								\
+		int __ret = 0;						\
+									\
+		if (likely(DEPT_READY_WARN))				\
+			__ret = WARN(c, "DEPT_WARN_ON: " #c);		\
+		__ret;							\
+	})
+
+#define DEPT_WARN(s...)							\
+	({								\
+		if (likely(DEPT_READY_WARN))				\
+			WARN(1, "DEPT_WARN: " s);			\
+	})
+
+#define DEPT_STOP(s...)							\
+	({								\
+		WRITE_ONCE(dept_stop, 1);				\
+		if (likely(DEPT_READY_WARN))				\
+			WARN(1, "DEPT_STOP: " s);			\
+	})
+
+#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+
+static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t stage_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+
+/*
+ * DEPT internal engine should be careful in using outside functions
+ * e.g. printk at reporting since that kind of usage might cause
+ * untrackable deadlock.
+ */
+static atomic_t dept_outworld = ATOMIC_INIT(0);
+
+static inline void dept_outworld_enter(void)
+{
+	atomic_inc(&dept_outworld);
+}
+
+static inline void dept_outworld_exit(void)
+{
+	atomic_dec(&dept_outworld);
+}
+
+static inline bool dept_outworld_entered(void)
+{
+	return atomic_read(&dept_outworld);
+}
+
+static inline bool dept_lock(void)
+{
+	while (!arch_spin_trylock(&dept_spin))
+		if (unlikely(dept_outworld_entered()))
+			return false;
+	return true;
+}
+
+static inline void dept_unlock(void)
+{
+	arch_spin_unlock(&dept_spin);
+}
+
+/*
+ * whether to stack-trace on every wait or every ecxt
+ */
+static bool rich_stack = true;
+
+enum bfs_ret {
+	BFS_CONTINUE,
+	BFS_CONTINUE_REV,
+	BFS_DONE,
+	BFS_SKIP,
+};
+
+static inline bool after(unsigned int a, unsigned int b)
+{
+	return (int)(b - a) < 0;
+}
+
+static inline bool before(unsigned int a, unsigned int b)
+{
+	return (int)(a - b) < 0;
+}
+
+static inline bool valid_stack(struct dept_stack *s)
+{
+	return s && s->nr > 0;
+}
+
+static inline bool valid_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+static inline void invalidate_class(struct dept_class *c)
+{
+	c->key = 0UL;
+}
+
+static inline struct dept_ecxt *dep_e(struct dept_dep *d)
+{
+	return d->ecxt;
+}
+
+static inline struct dept_wait *dep_w(struct dept_dep *d)
+{
+	return d->wait;
+}
+
+static inline struct dept_class *dep_fc(struct dept_dep *d)
+{
+	return dep_e(d)->class;
+}
+
+static inline struct dept_class *dep_tc(struct dept_dep *d)
+{
+	return dep_w(d)->class;
+}
+
+static inline const char *irq_str(int irq)
+{
+	if (irq == DEPT_SIRQ)
+		return "softirq";
+	if (irq == DEPT_HIRQ)
+		return "hardirq";
+	return "(unknown)";
+}
+
+static inline struct dept_task *dept_task(void)
+{
+	return &current->dept_task;
+}
+
+/*
+ * Dept doesn't work either when it's stopped by DEPT_STOP() or in a nmi
+ * context.
+ */
+static inline bool dept_working(void)
+{
+	return !READ_ONCE(dept_stop) && !in_nmi();
+}
+
+/*
+ * Even k == NULL is considered as a valid key because it would use
+ * &->map_key as the key in that case.
+ */
+struct dept_key __dept_no_validate__;
+static inline bool valid_key(struct dept_key *k)
+{
+	return &__dept_no_validate__ != k;
+}
+
+/*
+ * Pool
+ * =====================================================================
+ * DEPT maintains pools to provide objects in a safe way.
+ *
+ *    1) Static pool is used at the beginning of booting time.
+ *    2) Local pool is tried first before the static pool. Objects that
+ *       have been freed will be placed.
+ */
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef  OBJECT
+	OBJECT_NR,
+};
+
+#define OBJECT(id, nr)							\
+static struct dept_##id spool_##id[nr];					\
+static DEFINE_PER_CPU(struct llist_head, lpool_##id);
+	#include "dept_object.h"
+#undef  OBJECT
+
+static struct dept_pool pool[OBJECT_NR] = {
+#define OBJECT(id, nr) {						\
+	.name = #id,							\
+	.obj_sz = sizeof(struct dept_##id),				\
+	.obj_nr = ATOMIC_INIT(nr),					\
+	.node_off = offsetof(struct dept_##id, pool_node),		\
+	.spool = spool_##id,						\
+	.lpool = &lpool_##id, },
+	#include "dept_object.h"
+#undef  OBJECT
+};
+
+/*
+ * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
+ * enabled or not because NMI and other contexts in the same CPU never
+ * run inside of DEPT concurrently by preventing reentrance.
+ */
+static void *from_pool(enum object_t t)
+{
+	struct dept_pool *p;
+	struct llist_head *h;
+	struct llist_node *n;
+
+	/*
+	 * llist_del_first() doesn't allow concurrent access e.g.
+	 * between process and IRQ context.
+	 */
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return NULL;
+
+	p = &pool[t];
+
+	/*
+	 * Try local pool first.
+	 */
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	n = llist_del_first(h);
+	if (n)
+		return (void *)n - p->node_off;
+
+	/*
+	 * Try static pool.
+	 */
+	if (atomic_read(&p->obj_nr) > 0) {
+		int idx = atomic_dec_return(&p->obj_nr);
+
+		if (idx >= 0)
+			return p->spool + (idx * p->obj_sz);
+	}
+
+	DEPT_INFO_ONCE("---------------------------------------------\n"
+		"  Some of Dept internal resources are run out.\n"
+		"  Dept might still work if the resources get freed.\n"
+		"  However, the chances are Dept will suffer from\n"
+		"  the lack from now. Needs to extend the internal\n"
+		"  resource pools. Ask max.byungchul.park@gmail.com\n");
+	return NULL;
+}
+
+static void to_pool(void *o, enum object_t t)
+{
+	struct dept_pool *p = &pool[t];
+	struct llist_head *h;
+
+	preempt_disable();
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	llist_add(o + p->node_off, h);
+	preempt_enable();
+}
+
+#define OBJECT(id, nr)							\
+static void (*ctor_##id)(struct dept_##id *a);				\
+static void (*dtor_##id)(struct dept_##id *a);				\
+static inline struct dept_##id *new_##id(void)				\
+{									\
+	struct dept_##id *a;						\
+									\
+	a = (struct dept_##id *)from_pool(OBJECT_##id);			\
+	if (unlikely(!a))						\
+		return NULL;						\
+									\
+	atomic_set(&a->ref, 1);						\
+									\
+	if (ctor_##id)							\
+		ctor_##id(a);						\
+									\
+	return a;							\
+}									\
+									\
+static inline struct dept_##id *get_##id(struct dept_##id *a)		\
+{									\
+	atomic_inc(&a->ref);						\
+	return a;							\
+}									\
+									\
+static inline void put_##id(struct dept_##id *a)			\
+{									\
+	if (!atomic_dec_return(&a->ref)) {				\
+		if (dtor_##id)						\
+			dtor_##id(a);					\
+		to_pool(a, OBJECT_##id);				\
+	}								\
+}									\
+									\
+static inline void del_##id(struct dept_##id *a)			\
+{									\
+	put_##id(a);							\
+}									\
+									\
+static inline bool id##_consumed(struct dept_##id *a)			\
+{									\
+	return a && atomic_read(&a->ref) > 1;				\
+}
+#include "dept_object.h"
+#undef  OBJECT
+
+#define SET_CONSTRUCTOR(id, f) \
+static void (*ctor_##id)(struct dept_##id *a) = f
+
+static void initialize_dep(struct dept_dep *d)
+{
+	INIT_LIST_HEAD(&d->bfs_node);
+	INIT_LIST_HEAD(&d->dep_node);
+	INIT_LIST_HEAD(&d->dep_rev_node);
+}
+SET_CONSTRUCTOR(dep, initialize_dep);
+
+static void initialize_class(struct dept_class *c)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		struct dept_iecxt *ie = &c->iecxt[i];
+		struct dept_iwait *iw = &c->iwait[i];
+
+		ie->ecxt = NULL;
+		ie->enirq = i;
+		ie->staled = false;
+
+		iw->wait = NULL;
+		iw->irq = i;
+		iw->staled = false;
+		iw->touched = false;
+	}
+	c->bfs_gen = 0U;
+
+	INIT_LIST_HEAD(&c->all_node);
+	INIT_LIST_HEAD(&c->dep_head);
+	INIT_LIST_HEAD(&c->dep_rev_head);
+}
+SET_CONSTRUCTOR(class, initialize_class);
+
+static void initialize_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		e->enirq_stack[i] = NULL;
+		e->enirq_ip[i] = 0UL;
+	}
+	e->ecxt_ip = 0UL;
+	e->ecxt_stack = NULL;
+	e->enirqf = 0UL;
+	e->event_ip = 0UL;
+	e->event_stack = NULL;
+}
+SET_CONSTRUCTOR(ecxt, initialize_ecxt);
+
+static void initialize_wait(struct dept_wait *w)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		w->irq_stack[i] = NULL;
+		w->irq_ip[i] = 0UL;
+	}
+	w->wait_ip = 0UL;
+	w->wait_stack = NULL;
+	w->irqf = 0UL;
+}
+SET_CONSTRUCTOR(wait, initialize_wait);
+
+static void initialize_stack(struct dept_stack *s)
+{
+	s->nr = 0;
+}
+SET_CONSTRUCTOR(stack, initialize_stack);
+
+#define OBJECT(id, nr) \
+static void (*ctor_##id)(struct dept_##id *a);
+	#include "dept_object.h"
+#undef  OBJECT
+
+#undef  SET_CONSTRUCTOR
+
+#define SET_DESTRUCTOR(id, f) \
+static void (*dtor_##id)(struct dept_##id *a) = f
+
+static void destroy_dep(struct dept_dep *d)
+{
+	if (dep_e(d))
+		put_ecxt(dep_e(d));
+	if (dep_w(d))
+		put_wait(dep_w(d));
+}
+SET_DESTRUCTOR(dep, destroy_dep);
+
+static void destroy_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++)
+		if (e->enirq_stack[i])
+			put_stack(e->enirq_stack[i]);
+	if (e->class)
+		put_class(e->class);
+	if (e->ecxt_stack)
+		put_stack(e->ecxt_stack);
+	if (e->event_stack)
+		put_stack(e->event_stack);
+}
+SET_DESTRUCTOR(ecxt, destroy_ecxt);
+
+static void destroy_wait(struct dept_wait *w)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++)
+		if (w->irq_stack[i])
+			put_stack(w->irq_stack[i]);
+	if (w->class)
+		put_class(w->class);
+	if (w->wait_stack)
+		put_stack(w->wait_stack);
+}
+SET_DESTRUCTOR(wait, destroy_wait);
+
+#define OBJECT(id, nr) \
+static void (*dtor_##id)(struct dept_##id *a);
+	#include "dept_object.h"
+#undef  OBJECT
+
+#undef  SET_DESTRUCTOR
+
+/*
+ * Caching and hashing
+ * =====================================================================
+ * DEPT makes use of caching and hashing to improve performance. Each
+ * object can be obtained in O(1) with its key.
+ *
+ * NOTE: Currently we assume all the objects in the hashs will never be
+ * removed. Implement it when needed.
+ */
+
+/*
+ * Some information might be lost but it's only for hashing key.
+ */
+static inline unsigned long mix(unsigned long a, unsigned long b)
+{
+	int halfbits = sizeof(unsigned long) * 8 / 2;
+	unsigned long halfmask = (1UL << halfbits) - 1UL;
+
+	return (a << halfbits) | (b & halfmask);
+}
+
+static bool cmp_dep(struct dept_dep *d1, struct dept_dep *d2)
+{
+	return dep_fc(d1)->key == dep_fc(d2)->key &&
+	       dep_tc(d1)->key == dep_tc(d2)->key;
+}
+
+static unsigned long key_dep(struct dept_dep *d)
+{
+	return mix(dep_fc(d)->key, dep_tc(d)->key);
+}
+
+static bool cmp_class(struct dept_class *c1, struct dept_class *c2)
+{
+	return c1->key == c2->key;
+}
+
+static unsigned long key_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+#define HASH(id, bits)							\
+static struct hlist_head table_##id[1 << (bits)];			\
+									\
+static inline struct hlist_head *head_##id(struct dept_##id *a)		\
+{									\
+	return table_##id + hash_long(key_##id(a), bits);		\
+}									\
+									\
+static inline struct dept_##id *hash_lookup_##id(struct dept_##id *a)	\
+{									\
+	struct dept_##id *b;						\
+									\
+	hlist_for_each_entry_rcu(b, head_##id(a), hash_node)		\
+		if (cmp_##id(a, b))					\
+			return b;					\
+	return NULL;							\
+}									\
+									\
+static inline void hash_add_##id(struct dept_##id *a)			\
+{									\
+	get_##id(a);							\
+	hlist_add_head_rcu(&a->hash_node, head_##id(a));		\
+}									\
+									\
+static inline void hash_del_##id(struct dept_##id *a)			\
+{									\
+	hlist_del_rcu(&a->hash_node);					\
+	put_##id(a);							\
+}
+#include "dept_hash.h"
+#undef  HASH
+
+static inline struct dept_dep *lookup_dep(struct dept_class *fc,
+					  struct dept_class *tc)
+{
+	struct dept_ecxt onetime_e = { .class = fc };
+	struct dept_wait onetime_w = { .class = tc };
+	struct dept_dep  onetime_d = { .ecxt = &onetime_e,
+				       .wait = &onetime_w };
+	return hash_lookup_dep(&onetime_d);
+}
+
+static inline struct dept_class *lookup_class(unsigned long key)
+{
+	struct dept_class onetime_c = { .key = key };
+
+	return hash_lookup_class(&onetime_c);
+}
+
+/*
+ * Report
+ * =====================================================================
+ * DEPT prints useful information to help debuging on detection of
+ * problematic dependency.
+ */
+
+static inline void print_ip_stack(unsigned long ip, struct dept_stack *s)
+{
+	if (ip)
+		print_ip_sym(KERN_WARNING, ip);
+
+	if (valid_stack(s)) {
+		pr_warn("stacktrace:\n");
+		stack_trace_print(s->raw, s->nr, 5);
+	}
+
+	if (!ip && !valid_stack(s))
+		pr_warn("(N/A)\n");
+}
+
+#define print_spc(spc, fmt, ...)					\
+	pr_warn("%*c" fmt, (spc) * 4, ' ', ##__VA_ARGS__)
+
+static void print_diagram(struct dept_dep *d)
+{
+	struct dept_ecxt *e = dep_e(d);
+	struct dept_wait *w = dep_w(d);
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	bool firstline = true;
+	int spc = 1;
+	const char *w_fn = w->wait_fn ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+	const char *fc_n = fc->sched_map ? "<sched>" : (fc->name ?: "(unknown)");
+	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
+
+	irqf = e->enirqf & w->irqf;
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		if (!firstline)
+			pr_warn("\nor\n\n");
+		firstline = false;
+
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
+		print_spc(spc, "    <%s interrupt>\n", irq_str(irq));
+		print_spc(spc + 1, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
+	}
+
+	if (!irqf) {
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
+		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
+	}
+}
+
+static void print_dep(struct dept_dep *d)
+{
+	struct dept_ecxt *e = dep_e(d);
+	struct dept_wait *w = dep_w(d);
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	const char *w_fn = w->wait_fn ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+	const char *fc_n = fc->sched_map ? "<sched>" : (fc->name ?: "(unknown)");
+	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
+
+	irqf = e->enirqf & w->irqf;
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		pr_warn("%s has been enabled:\n", irq_str(irq));
+		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
+		pr_warn("\n");
+
+		pr_warn("[S] %s(%s:%d):\n", c_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->ecxt_ip, e->ecxt_stack);
+		pr_warn("\n");
+
+		pr_warn("[W] %s(%s:%d) in %s context:\n",
+		       w_fn, tc_n, tc->sub_id, irq_str(irq));
+		print_ip_stack(w->irq_ip[irq], w->irq_stack[irq]);
+		pr_warn("\n");
+
+		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->event_ip, e->event_stack);
+	}
+
+	if (!irqf) {
+		pr_warn("[S] %s(%s:%d):\n", c_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->ecxt_ip, e->ecxt_stack);
+		pr_warn("\n");
+
+		pr_warn("[W] %s(%s:%d):\n", w_fn, tc_n, tc->sub_id);
+		print_ip_stack(w->wait_ip, w->wait_stack);
+		pr_warn("\n");
+
+		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->event_ip, e->event_stack);
+	}
+}
+
+static void save_current_stack(int skip);
+
+/*
+ * Print all classes in a circle.
+ */
+static void print_circle(struct dept_class *c)
+{
+	struct dept_class *fc = c->bfs_parent;
+	struct dept_class *tc = c;
+	int i;
+
+	dept_outworld_enter();
+	save_current_stack(6);
+
+	pr_warn("===================================================\n");
+	pr_warn("DEPT: Circular dependency has been detected.\n");
+	pr_warn("%s %.*s %s\n", init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version,
+		print_tainted());
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("summary\n");
+	pr_warn("---------------------------------------------------\n");
+
+	if (fc == tc)
+		pr_warn("*** AA DEADLOCK ***\n\n");
+	else
+		pr_warn("*** DEADLOCK ***\n\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		pr_warn("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		if (fc != c)
+			pr_warn("\n");
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	pr_warn("\n");
+	pr_warn("[S]: start of the event context\n");
+	pr_warn("[W]: the wait blocked\n");
+	pr_warn("[E]: the event not reachable\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		pr_warn("---------------------------------------------------\n");
+		pr_warn("context %c's detail\n", 'A' + i);
+		pr_warn("---------------------------------------------------\n");
+		pr_warn("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		pr_warn("\n");
+		print_dep(d);
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("information that might be helpful\n");
+	pr_warn("---------------------------------------------------\n");
+	dump_stack();
+
+	dept_outworld_exit();
+}
+
+/*
+ * BFS(Breadth First Search)
+ * =====================================================================
+ * Whenever a new dependency is added into the graph, search the graph
+ * for a new circular dependency.
+ */
+
+static inline void enqueue(struct list_head *h, struct dept_dep *d)
+{
+	list_add_tail(&d->bfs_node, h);
+}
+
+static inline struct dept_dep *dequeue(struct list_head *h)
+{
+	struct dept_dep *d;
+
+	d = list_first_entry(h, struct dept_dep, bfs_node);
+	list_del(&d->bfs_node);
+	return d;
+}
+
+static inline bool empty(struct list_head *h)
+{
+	return list_empty(h);
+}
+
+static void extend_queue(struct list_head *h, struct dept_class *cur)
+{
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_head, dep_node) {
+		struct dept_class *next = dep_tc(d);
+
+		if (cur->bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_gen = cur->bfs_gen;
+		next->bfs_dist = cur->bfs_dist + 1;
+		next->bfs_parent = cur;
+		enqueue(h, d);
+	}
+}
+
+static void extend_queue_rev(struct list_head *h, struct dept_class *cur)
+{
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_rev_head, dep_rev_node) {
+		struct dept_class *next = dep_fc(d);
+
+		if (cur->bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_gen = cur->bfs_gen;
+		next->bfs_dist = cur->bfs_dist + 1;
+		next->bfs_parent = cur;
+		enqueue(h, d);
+	}
+}
+
+typedef enum bfs_ret bfs_f(struct dept_dep *d, void *in, void **out);
+static unsigned int bfs_gen;
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void bfs(struct dept_class *c, bfs_f *cb, void *in, void **out)
+{
+	LIST_HEAD(q);
+	enum bfs_ret ret;
+
+	if (DEPT_WARN_ON(!cb))
+		return;
+
+	/*
+	 * Avoid zero bfs_gen.
+	 */
+	bfs_gen = bfs_gen + 1 ?: 1;
+
+	c->bfs_gen = bfs_gen;
+	c->bfs_dist = 0;
+	c->bfs_parent = c;
+
+	ret = cb(NULL, in, out);
+	if (ret == BFS_DONE)
+		return;
+	if (ret == BFS_SKIP)
+		return;
+	if (ret == BFS_CONTINUE)
+		extend_queue(&q, c);
+	if (ret == BFS_CONTINUE_REV)
+		extend_queue_rev(&q, c);
+
+	while (!empty(&q)) {
+		struct dept_dep *d = dequeue(&q);
+
+		ret = cb(d, in, out);
+		if (ret == BFS_DONE)
+			break;
+		if (ret == BFS_SKIP)
+			continue;
+		if (ret == BFS_CONTINUE)
+			extend_queue(&q, dep_tc(d));
+		if (ret == BFS_CONTINUE_REV)
+			extend_queue_rev(&q, dep_fc(d));
+	}
+
+	while (!empty(&q))
+		dequeue(&q);
+}
+
+/*
+ * Main operations
+ * =====================================================================
+ * Add dependencies - Each new dependency is added into the graph and
+ * checked if it forms a circular dependency.
+ *
+ * Track waits - Waits are queued into the ring buffer for later use to
+ * generate appropriate dependencies with cross-event.
+ *
+ * Track event contexts(ecxt) - Event contexts are pushed into local
+ * stack for later use to generate appropriate dependencies with waits.
+ */
+
+static inline unsigned long cur_enirqf(void);
+static inline int cur_irq(void);
+static inline unsigned int cur_ctxt_id(void);
+
+static inline struct dept_iecxt *iecxt(struct dept_class *c, int irq)
+{
+	return &c->iecxt[irq];
+}
+
+static inline struct dept_iwait *iwait(struct dept_class *c, int irq)
+{
+	return &c->iwait[irq];
+}
+
+static inline void stale_iecxt(struct dept_iecxt *ie)
+{
+	if (ie->ecxt)
+		put_ecxt(ie->ecxt);
+
+	WRITE_ONCE(ie->ecxt, NULL);
+	WRITE_ONCE(ie->staled, true);
+}
+
+static inline void set_iecxt(struct dept_iecxt *ie, struct dept_ecxt *e)
+{
+	/*
+	 * ->ecxt will never be updated once getting set until the class
+	 * gets removed.
+	 */
+	if (ie->ecxt)
+		DEPT_WARN_ON(1);
+	else
+		WRITE_ONCE(ie->ecxt, get_ecxt(e));
+}
+
+static inline void stale_iwait(struct dept_iwait *iw)
+{
+	if (iw->wait)
+		put_wait(iw->wait);
+
+	WRITE_ONCE(iw->wait, NULL);
+	WRITE_ONCE(iw->staled, true);
+}
+
+static inline void set_iwait(struct dept_iwait *iw, struct dept_wait *w)
+{
+	/*
+	 * ->wait will never be updated once getting set until the class
+	 * gets removed.
+	 */
+	if (iw->wait)
+		DEPT_WARN_ON(1);
+	else
+		WRITE_ONCE(iw->wait, get_wait(w));
+
+	iw->touched = true;
+}
+
+static inline void touch_iwait(struct dept_iwait *iw)
+{
+	iw->touched = true;
+}
+
+static inline void untouch_iwait(struct dept_iwait *iw)
+{
+	iw->touched = false;
+}
+
+static inline struct dept_stack *get_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	return s ? get_stack(s) : NULL;
+}
+
+static inline void prepare_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	/*
+	 * The dept_stack is already ready.
+	 */
+	if (s && !stack_consumed(s)) {
+		s->nr = 0;
+		return;
+	}
+
+	if (s)
+		put_stack(s);
+
+	s = dept_task()->stack = new_stack();
+	if (!s)
+		return;
+
+	get_stack(s);
+	del_stack(s);
+}
+
+static void save_current_stack(int skip)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	if (!s)
+		return;
+	if (valid_stack(s))
+		return;
+
+	s->nr = stack_trace_save(s->raw, DEPT_MAX_STACK_ENTRY, skip);
+}
+
+static void finish_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	if (stack_consumed(s))
+		save_current_stack(2);
+}
+
+/*
+ * FIXME: For now, disable LOCKDEP while DEPT is working.
+ *
+ * Both LOCKDEP and DEPT report it on a deadlock detection using
+ * printk taking the risk of another deadlock that might be caused by
+ * locks of console or printk between inside and outside of them.
+ *
+ * For DEPT, it's no problem since multiple reports are allowed. But it
+ * would be a bad idea for LOCKDEP since it will stop even on a singe
+ * report. So we need to prevent LOCKDEP from its reporting the risk
+ * DEPT would take when reporting something.
+ */
+#include <linux/lockdep.h>
+
+void dept_off(void)
+{
+	dept_task()->recursive++;
+	lockdep_off();
+}
+
+void dept_on(void)
+{
+	dept_task()->recursive--;
+	lockdep_on();
+}
+
+static inline unsigned long dept_enter(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_irq_save();
+	dept_off();
+	prepare_current_stack();
+	return flags;
+}
+
+static inline void dept_exit(unsigned long flags)
+{
+	finish_current_stack();
+	dept_on();
+	arch_local_irq_restore(flags);
+}
+
+static inline unsigned long dept_enter_recursive(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_irq_save();
+	return flags;
+}
+
+static inline void dept_exit_recursive(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static struct dept_dep *__add_dep(struct dept_ecxt *e,
+				  struct dept_wait *w)
+{
+	struct dept_dep *d;
+
+	if (DEPT_WARN_ON(!valid_class(e->class)))
+		return NULL;
+
+	if (DEPT_WARN_ON(!valid_class(w->class)))
+		return NULL;
+
+	if (lookup_dep(e->class, w->class))
+		return NULL;
+
+	d = new_dep();
+	if (unlikely(!d))
+		return NULL;
+
+	d->ecxt = get_ecxt(e);
+	d->wait = get_wait(w);
+
+	/*
+	 * Add the dependency into hash and graph.
+	 */
+	hash_add_dep(d);
+	list_add(&d->dep_node, &dep_fc(d)->dep_head);
+	list_add(&d->dep_rev_node, &dep_tc(d)->dep_rev_head);
+	return d;
+}
+
+static enum bfs_ret cb_check_dl(struct dept_dep *d,
+				void *in, void **out)
+{
+	struct dept_dep *new = (struct dept_dep *)in;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d) {
+		dep_tc(new)->bfs_parent = dep_fc(new);
+
+		if (dep_tc(new) != dep_fc(new))
+			return BFS_CONTINUE;
+
+		/*
+		 * AA circle does not make additional deadlock. We don't
+		 * have to continue this BFS search.
+		 */
+		print_circle(dep_tc(new));
+		return BFS_DONE;
+	}
+
+	/*
+	 * Allow multiple reports.
+	 */
+	if (dep_tc(d) == dep_fc(new))
+		print_circle(dep_tc(new));
+
+	return BFS_CONTINUE;
+}
+
+/*
+ * This function is actually in charge of reporting.
+ */
+static inline void check_dl_bfs(struct dept_dep *d)
+{
+	bfs(dep_tc(d), cb_check_dl, (void *)d, NULL);
+}
+
+static enum bfs_ret cb_find_iw(struct dept_dep *d, void *in, void **out)
+{
+	int irq = *(int *)in;
+	struct dept_class *fc;
+	struct dept_iwait *iw;
+
+	if (DEPT_WARN_ON(!out))
+		return BFS_DONE;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d)
+		return BFS_CONTINUE_REV;
+
+	fc = dep_fc(d);
+	iw = iwait(fc, irq);
+
+	/*
+	 * If any parent's ->wait was set, then the children would've
+	 * been touched.
+	 */
+	if (!iw->touched)
+		return BFS_SKIP;
+
+	if (!iw->wait)
+		return BFS_CONTINUE_REV;
+
+	*out = iw;
+	return BFS_DONE;
+}
+
+static struct dept_iwait *find_iw_bfs(struct dept_class *c, int irq)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+	struct dept_iwait *found = NULL;
+
+	if (iw->wait)
+		return iw;
+
+	/*
+	 * '->touched == false' guarantees there's no parent that has
+	 * been set ->wait.
+	 */
+	if (!iw->touched)
+		return NULL;
+
+	bfs(c, cb_find_iw, (void *)&irq, (void **)&found);
+
+	if (found)
+		return found;
+
+	untouch_iwait(iw);
+	return NULL;
+}
+
+static enum bfs_ret cb_touch_iw_find_ie(struct dept_dep *d, void *in,
+					void **out)
+{
+	int irq = *(int *)in;
+	struct dept_class *tc;
+	struct dept_iecxt *ie;
+	struct dept_iwait *iw;
+
+	if (DEPT_WARN_ON(!out))
+		return BFS_DONE;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d)
+		return BFS_CONTINUE;
+
+	tc = dep_tc(d);
+	ie = iecxt(tc, irq);
+	iw = iwait(tc, irq);
+
+	touch_iwait(iw);
+
+	if (!ie->ecxt)
+		return BFS_CONTINUE;
+
+	if (!*out)
+		*out = ie;
+
+	return BFS_CONTINUE;
+}
+
+static struct dept_iecxt *touch_iw_find_ie_bfs(struct dept_class *c,
+					       int irq)
+{
+	struct dept_iecxt *ie = iecxt(c, irq);
+	struct dept_iwait *iw = iwait(c, irq);
+	struct dept_iecxt *found = ie->ecxt ? ie : NULL;
+
+	touch_iwait(iw);
+	bfs(c, cb_touch_iw_find_ie, (void *)&irq, (void **)&found);
+	return found;
+}
+
+/*
+ * Should be called with dept_lock held.
+ */
+static void __add_idep(struct dept_iecxt *ie, struct dept_iwait *iw)
+{
+	struct dept_dep *new;
+
+	/*
+	 * There's nothing to do.
+	 */
+	if (!ie || !iw || !ie->ecxt || !iw->wait)
+		return;
+
+	new = __add_dep(ie->ecxt, iw->wait);
+
+	/*
+	 * Deadlock detected. Let check_dl_bfs() report it.
+	 */
+	if (new) {
+		check_dl_bfs(new);
+		stale_iecxt(ie);
+		stale_iwait(iw);
+	}
+
+	/*
+	 * If !new, it would be the case of lack of object resource.
+	 * Just let it go and get checked by other chances. Retrying is
+	 * meaningless in that case.
+	 */
+}
+
+static void set_check_iecxt(struct dept_class *c, int irq,
+			    struct dept_ecxt *e)
+{
+	struct dept_iecxt *ie = iecxt(c, irq);
+
+	set_iecxt(ie, e);
+	__add_idep(ie, find_iw_bfs(c, irq));
+}
+
+static void set_check_iwait(struct dept_class *c, int irq,
+			    struct dept_wait *w)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+
+	set_iwait(iw, w);
+	__add_idep(touch_iw_find_ie_bfs(c, irq), iw);
+}
+
+static void add_iecxt(struct dept_class *c, int irq, struct dept_ecxt *e,
+		      bool stack)
+{
+	/*
+	 * This access is safe since we ensure e->class has set locally.
+	 */
+	struct dept_task *dt = dept_task();
+	struct dept_iecxt *ie = iecxt(c, irq);
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (unlikely(READ_ONCE(ie->staled)))
+		return;
+
+	/*
+	 * Skip add_iecxt() if ie->ecxt has ever been set at least once.
+	 * Which means it has a valid ->ecxt or been staled.
+	 */
+	if (READ_ONCE(ie->ecxt))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	if (unlikely(ie->staled))
+		goto unlock;
+	if (ie->ecxt)
+		goto unlock;
+
+	e->enirqf |= (1UL << irq);
+
+	/*
+	 * Should be NULL since it's the first time that these
+	 * enirq_{ip,stack}[irq] have ever set.
+	 */
+	DEPT_WARN_ON(e->enirq_ip[irq]);
+	DEPT_WARN_ON(e->enirq_stack[irq]);
+
+	e->enirq_ip[irq] = dt->enirq_ip[irq];
+	e->enirq_stack[irq] = stack ? get_current_stack() : NULL;
+
+	set_check_iecxt(c, irq, e);
+unlock:
+	dept_unlock();
+}
+
+static void add_iwait(struct dept_class *c, int irq, struct dept_wait *w)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (unlikely(READ_ONCE(iw->staled)))
+		return;
+
+	/*
+	 * Skip add_iwait() if iw->wait has ever been set at least once.
+	 * Which means it has a valid ->wait or been staled.
+	 */
+	if (READ_ONCE(iw->wait))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	if (unlikely(iw->staled))
+		goto unlock;
+	if (iw->wait)
+		goto unlock;
+
+	w->irqf |= (1UL << irq);
+
+	/*
+	 * Should be NULL since it's the first time that these
+	 * irq_{ip,stack}[irq] have ever set.
+	 */
+	DEPT_WARN_ON(w->irq_ip[irq]);
+	DEPT_WARN_ON(w->irq_stack[irq]);
+
+	w->irq_ip[irq] = w->wait_ip;
+	w->irq_stack[irq] = get_current_stack();
+
+	set_check_iwait(c, irq, w);
+unlock:
+	dept_unlock();
+}
+
+static inline struct dept_wait_hist *hist(int pos)
+{
+	struct dept_task *dt = dept_task();
+
+	return dt->wait_hist + (pos % DEPT_MAX_WAIT_HIST);
+}
+
+static inline int hist_pos_next(void)
+{
+	struct dept_task *dt = dept_task();
+
+	return dt->wait_hist_pos % DEPT_MAX_WAIT_HIST;
+}
+
+static inline void hist_advance(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->wait_hist_pos++;
+	dt->wait_hist_pos %= DEPT_MAX_WAIT_HIST;
+}
+
+static inline struct dept_wait_hist *new_hist(void)
+{
+	struct dept_wait_hist *wh = hist(hist_pos_next());
+
+	hist_advance();
+	return wh;
+}
+
+static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
+{
+	struct dept_wait_hist *wh = new_hist();
+
+	if (likely(wh->wait))
+		put_wait(wh->wait);
+
+	wh->wait = get_wait(w);
+	wh->wgen = wg;
+	wh->ctxt_id = ctxt_id;
+}
+
+/*
+ * Should be called after setting up e's iecxt and w's iwait.
+ */
+static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
+{
+	struct dept_class *fc = e->class;
+	struct dept_class *tc = w->class;
+	struct dept_dep *d;
+	int i;
+
+	if (lookup_dep(fc, tc))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	/*
+	 * __add_dep() will lookup_dep() again with lock held.
+	 */
+	d = __add_dep(e, w);
+	if (d) {
+		check_dl_bfs(d);
+
+		for (i = 0; i < DEPT_IRQS_NR; i++) {
+			struct dept_iwait *fiw = iwait(fc, i);
+			struct dept_iecxt *found_ie;
+			struct dept_iwait *found_iw;
+
+			/*
+			 * '->touched == false' guarantees there's no
+			 * parent that has been set ->wait.
+			 */
+			if (!fiw->touched)
+				continue;
+
+			/*
+			 * find_iw_bfs() will untouch the iwait if
+			 * not found.
+			 */
+			found_iw = find_iw_bfs(fc, i);
+
+			if (!found_iw)
+				continue;
+
+			found_ie = touch_iw_find_ie_bfs(tc, i);
+			__add_idep(found_ie, found_iw);
+		}
+	}
+	dept_unlock();
+}
+
+static atomic_t wgen = ATOMIC_INIT(1);
+
+static void add_wait(struct dept_class *c, unsigned long ip,
+		     const char *w_fn, int sub_l, bool sched_sleep)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait *w;
+	unsigned int wg = 0U;
+	int irq;
+	int i;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	w = new_wait();
+	if (unlikely(!w))
+		return;
+
+	WRITE_ONCE(w->class, get_class(c));
+	w->wait_ip = ip;
+	w->wait_fn = w_fn;
+	w->wait_stack = get_current_stack();
+	w->sched_sleep = sched_sleep;
+
+	irq = cur_irq();
+	if (irq < DEPT_IRQS_NR)
+		add_iwait(c, irq, w);
+
+	/*
+	 * Avoid adding dependency between user aware nested ecxt and
+	 * wait.
+	 */
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+
+		eh = dt->ecxt_held + i;
+
+		/*
+		 * the case of invalid key'ed one
+		 */
+		if (!eh->ecxt)
+			continue;
+
+		if (eh->ecxt->class != c || eh->sub_l == sub_l)
+			add_dep(eh->ecxt, w);
+	}
+
+	if (!wait_consumed(w) && !rich_stack) {
+		if (w->wait_stack)
+			put_stack(w->wait_stack);
+		w->wait_stack = NULL;
+	}
+
+	/*
+	 * Avoid zero wgen.
+	 */
+	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+	add_hist(w, wg, cur_ctxt_id());
+
+	del_wait(w);
+}
+
+static bool add_ecxt(struct dept_map *m, struct dept_class *c,
+		     unsigned long ip, const char *c_fn,
+		     const char *e_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_ecxt_held *eh;
+	struct dept_ecxt *e;
+	unsigned long irqf;
+	int irq;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return false;
+
+	if (DEPT_WARN_ON_ONCE(dt->ecxt_held_pos >= DEPT_MAX_ECXT_HELD))
+		return false;
+
+	if (m->nocheck) {
+		eh = dt->ecxt_held + (dt->ecxt_held_pos++);
+		eh->ecxt = NULL;
+		eh->map = m;
+		eh->class = get_class(c);
+		eh->wgen = atomic_read(&wgen);
+		eh->sub_l = sub_l;
+
+		return true;
+	}
+
+	e = new_ecxt();
+	if (unlikely(!e))
+		return false;
+
+	e->class = get_class(c);
+	e->ecxt_ip = ip;
+	e->ecxt_stack = ip && rich_stack ? get_current_stack() : NULL;
+	e->event_fn = e_fn;
+	e->ecxt_fn = c_fn;
+
+	eh = dt->ecxt_held + (dt->ecxt_held_pos++);
+	eh->ecxt = get_ecxt(e);
+	eh->map = m;
+	eh->class = get_class(c);
+	eh->wgen = atomic_read(&wgen);
+	eh->sub_l = sub_l;
+
+	irqf = cur_enirqf();
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+		add_iecxt(c, irq, e, false);
+
+	del_ecxt(e);
+	return true;
+}
+
+static int find_ecxt_pos(struct dept_map *m, struct dept_class *c,
+			 bool newfirst)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	if (newfirst) {
+		for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+			struct dept_ecxt_held *eh;
+
+			eh = dt->ecxt_held + i;
+			if (eh->map == m && eh->class == c)
+				return i;
+		}
+	} else {
+		for (i = 0; i < dt->ecxt_held_pos; i++) {
+			struct dept_ecxt_held *eh;
+
+			eh = dt->ecxt_held + i;
+			if (eh->map == m && eh->class == c)
+				return i;
+		}
+	}
+	return -1;
+}
+
+static bool pop_ecxt(struct dept_map *m, struct dept_class *c)
+{
+	struct dept_task *dt = dept_task();
+	int pos;
+	int i;
+
+	pos = find_ecxt_pos(m, c, true);
+	if (pos == -1)
+		return false;
+
+	if (dt->ecxt_held[pos].class)
+		put_class(dt->ecxt_held[pos].class);
+
+	if (dt->ecxt_held[pos].ecxt)
+		put_ecxt(dt->ecxt_held[pos].ecxt);
+
+	dt->ecxt_held_pos--;
+
+	for (i = pos; i < dt->ecxt_held_pos; i++)
+		dt->ecxt_held[i] = dt->ecxt_held[i + 1];
+	return true;
+}
+
+static inline bool good_hist(struct dept_wait_hist *wh, unsigned int wg)
+{
+	return wh->wait != NULL && before(wg, wh->wgen);
+}
+
+/*
+ * Binary-search the ring buffer for the earliest valid wait.
+ */
+static int find_hist_pos(unsigned int wg)
+{
+	int oldest;
+	int l;
+	int r;
+	int pos;
+
+	oldest = hist_pos_next();
+	if (unlikely(good_hist(hist(oldest), wg))) {
+		DEPT_INFO_ONCE("Need to expand the ring buffer.\n");
+		return oldest;
+	}
+
+	l = oldest + 1;
+	r = oldest + DEPT_MAX_WAIT_HIST - 1;
+	for (pos = (l + r) / 2; l <= r; pos = (l + r) / 2) {
+		struct dept_wait_hist *p = hist(pos - 1);
+		struct dept_wait_hist *wh = hist(pos);
+
+		if (!good_hist(p, wg) && good_hist(wh, wg))
+			return pos % DEPT_MAX_WAIT_HIST;
+		if (good_hist(wh, wg))
+			r = pos - 1;
+		else
+			l = pos + 1;
+	}
+	return -1;
+}
+
+static void do_event(struct dept_map *m, struct dept_class *c,
+		     unsigned int wg, unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait_hist *wh;
+	struct dept_ecxt_held *eh;
+	unsigned int ctxt_id;
+	int end;
+	int pos;
+	int i;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (m->nocheck)
+		return;
+
+	/*
+	 * The event was triggered before wait.
+	 */
+	if (!wg)
+		return;
+
+	pos = find_ecxt_pos(m, c, false);
+	if (pos == -1)
+		return;
+
+	eh = dt->ecxt_held + pos;
+
+	if (DEPT_WARN_ON(!eh->ecxt))
+		return;
+
+	eh->ecxt->event_ip = ip;
+	eh->ecxt->event_stack = get_current_stack();
+
+	/*
+	 * The ecxt already has done what it needs.
+	 */
+	if (!before(wg, eh->wgen))
+		return;
+
+	pos = find_hist_pos(wg);
+	if (pos == -1)
+		return;
+
+	ctxt_id = cur_ctxt_id();
+	end = hist_pos_next();
+	end = end > pos ? end : end + DEPT_MAX_WAIT_HIST;
+	for (wh = hist(pos); pos < end; wh = hist(++pos)) {
+		if (after(wh->wgen, eh->wgen))
+			break;
+
+		if (dt->in_sched && wh->wait->sched_sleep)
+			continue;
+
+		if (wh->ctxt_id == ctxt_id)
+			add_dep(eh->ecxt, wh->wait);
+	}
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		struct dept_ecxt *e;
+
+		if (before(dt->wgen_enirq[i], wg))
+			continue;
+
+		e = eh->ecxt;
+		add_iecxt(e->class, i, e, false);
+	}
+}
+
+static void del_dep_rcu(struct rcu_head *rh)
+{
+	struct dept_dep *d = container_of(rh, struct dept_dep, rh);
+
+	preempt_disable();
+	del_dep(d);
+	preempt_enable();
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_class(struct dept_class *c)
+{
+	struct dept_dep *d, *n;
+	int i;
+
+	list_for_each_entry_safe(d, n, &c->dep_head, dep_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+
+	list_for_each_entry_safe(d, n, &c->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		stale_iecxt(iecxt(c, i));
+		stale_iwait(iwait(c, i));
+	}
+}
+
+/*
+ * Context control
+ * =====================================================================
+ * Whether a wait is in {hard,soft}-IRQ context or whether
+ * {hard,soft}-IRQ has been enabled on the way to an event is very
+ * important to check dependency. All those things should be tracked.
+ */
+
+static inline unsigned long cur_enirqf(void)
+{
+	struct dept_task *dt = dept_task();
+	int he = dt->hardirqs_enabled;
+	int se = dt->softirqs_enabled;
+
+	if (he)
+		return DEPT_HIRQF | (se ? DEPT_SIRQF : 0UL);
+	return 0UL;
+}
+
+static inline int cur_irq(void)
+{
+	if (lockdep_softirq_context(current))
+		return DEPT_SIRQ;
+	if (lockdep_hardirq_context())
+		return DEPT_HIRQ;
+	return DEPT_IRQS_NR;
+}
+
+static inline unsigned int cur_ctxt_id(void)
+{
+	struct dept_task *dt = dept_task();
+	int irq = cur_irq();
+
+	/*
+	 * Normal process context
+	 */
+	if (irq == DEPT_IRQS_NR)
+		return 0U;
+
+	return dt->irq_id[irq] | (1UL << irq);
+}
+
+static void enirq_transition(int irq)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	/*
+	 * READ wgen >= wgen of an event with IRQ enabled has been
+	 * observed on the way to the event means, the IRQ can cut in
+	 * within the ecxt. Used for cross-event detection.
+	 *
+	 *    wait context	event context(ecxt)
+	 *    ------------	-------------------
+	 *    wait event
+	 *       WRITE wgen
+	 *			observe IRQ enabled
+	 *			   READ wgen
+	 *			   keep the wgen locally
+	 *
+	 *			on the event
+	 *			   check the local wgen
+	 */
+	dt->wgen_enirq[irq] = atomic_read(&wgen);
+
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+		struct dept_ecxt *e;
+
+		eh = dt->ecxt_held + i;
+		e = eh->ecxt;
+		if (e)
+			add_iecxt(e->class, irq, e, true);
+	}
+}
+
+static void enirq_update(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long irqf;
+	unsigned long prev;
+	int irq;
+
+	prev = dt->eff_enirqf;
+	irqf = cur_enirqf();
+	dt->eff_enirqf = irqf;
+
+	/*
+	 * Do enirq_transition() only on an OFF -> ON transition.
+	 */
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		if (prev & (1UL << irq))
+			continue;
+
+		dt->enirq_ip[irq] = ip;
+		enirq_transition(irq);
+	}
+}
+
+/*
+ * Ensure it has been called on ON/OFF transition.
+ */
+static void dept_enirq_transition(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * IRQ ON/OFF transition might happen while Dept is working.
+	 * We cannot handle recursive entrance. Just ingnore it.
+	 * Only transitions outside of Dept will be considered.
+	 */
+	if (dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	enirq_update(ip);
+
+	dept_exit(flags);
+}
+
+void dept_softirqs_on_ip(unsigned long ip)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->softirqs_enabled = true;
+	dept_enirq_transition(ip);
+}
+
+void dept_hardirqs_on(void)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = true;
+	dept_enirq_transition(_RET_IP_);
+}
+EXPORT_SYMBOL_GPL(dept_hardirqs_on);
+
+void dept_hardirqs_on_ip(unsigned long ip)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = true;
+	dept_enirq_transition(ip);
+}
+EXPORT_SYMBOL_GPL(dept_hardirqs_on_ip);
+
+void dept_softirqs_off_ip(unsigned long ip)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->softirqs_enabled = false;
+	dept_enirq_transition(ip);
+}
+
+void dept_hardirqs_off(void)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = false;
+	dept_enirq_transition(_RET_IP_);
+}
+EXPORT_SYMBOL_GPL(dept_hardirqs_off);
+
+void dept_hardirqs_off_ip(unsigned long ip)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = false;
+	dept_enirq_transition(ip);
+}
+EXPORT_SYMBOL_GPL(dept_hardirqs_off_ip);
+
+/*
+ * Ensure it's the outmost softirq context.
+ */
+void dept_softirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+}
+
+/*
+ * Ensure it's the outmost hardirq context.
+ */
+void dept_hardirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+}
+
+void dept_sched_enter(void)
+{
+	dept_task()->in_sched = true;
+}
+
+void dept_sched_exit(void)
+{
+	dept_task()->in_sched = false;
+}
+
+/*
+ * Exposed APIs
+ * =====================================================================
+ */
+
+static inline void clean_classes_cache(struct dept_key *k)
+{
+	int i;
+
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++) {
+		if (!READ_ONCE(k->classes[i]))
+			continue;
+
+		WRITE_ONCE(k->classes[i], NULL);
+	}
+}
+
+void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
+		   const char *n)
+{
+	unsigned long flags;
+
+	if (unlikely(!dept_working())) {
+		m->nocheck = true;
+		return;
+	}
+
+	if (DEPT_WARN_ON(sub_u < 0)) {
+		m->nocheck = true;
+		return;
+	}
+
+	if (DEPT_WARN_ON(sub_u >= DEPT_MAX_SUBCLASSES_USR)) {
+		m->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	clean_classes_cache(&m->map_key);
+
+	m->keys = k;
+	m->sub_u = sub_u;
+	m->name = n;
+	m->wgen = 0U;
+	m->nocheck = !valid_key(k);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_init);
+
+void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
+		     const char *n)
+{
+	unsigned long flags;
+
+	if (unlikely(!dept_working())) {
+		m->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	if (k) {
+		clean_classes_cache(&m->map_key);
+		m->keys = k;
+		m->nocheck = !valid_key(k);
+	}
+
+	if (sub_u >= 0 && sub_u < DEPT_MAX_SUBCLASSES_USR)
+		m->sub_u = sub_u;
+
+	if (n)
+		m->name = n;
+
+	m->wgen = 0U;
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_reinit);
+
+void dept_map_copy(struct dept_map *to, struct dept_map *from)
+{
+	if (unlikely(!dept_working())) {
+		to->nocheck = true;
+		return;
+	}
+
+	*to = *from;
+
+	/*
+	 * XXX: 'to' might be in a stack or something. Using the address
+	 * in a stack segment as a key is meaningless. Just ignore the
+	 * case for now.
+	 */
+	if (!to->keys) {
+		to->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Since the class cache can be modified concurrently we could
+	 * observe half pointers (64bit arch using 32bit copy insns).
+	 * Therefore clear the caches and take the performance hit.
+	 *
+	 * XXX: Doesn't work well with lockdep_set_class_and_subclass()
+	 *      since that relies on cache abuse.
+	 */
+	clean_classes_cache(&to->map_key);
+}
+
+static LIST_HEAD(classes);
+
+static inline bool within(const void *addr, void *start, unsigned long size)
+{
+	return addr >= start && addr < start + size;
+}
+
+void dept_free_range(void *start, unsigned int sz)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_class *c, *n;
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		DEPT_STOP("Failed to successfully free Dept objects.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	/*
+	 * dept_free_range() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_free_range() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	list_for_each_entry_safe(c, n, &classes, all_node) {
+		if (!within((void *)c->key, start, sz) &&
+		    !within(c->name, start, sz))
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+
+static inline int sub_id(struct dept_map *m, int e)
+{
+	return (m ? m->sub_u : 0) + e * DEPT_MAX_SUBCLASSES_USR;
+}
+
+static struct dept_class *check_new_class(struct dept_key *local,
+					  struct dept_key *k, int sub_id,
+					  const char *n, bool sched_map)
+{
+	struct dept_class *c = NULL;
+
+	if (DEPT_WARN_ON(sub_id >= DEPT_MAX_SUBCLASSES))
+		return NULL;
+
+	if (DEPT_WARN_ON(!k))
+		return NULL;
+
+	/*
+	 * XXX: Assume that users prevent the map from using if any of
+	 * the cached keys has been invalidated. If not, the cache,
+	 * local->classes should not be used because it would be racy
+	 * with class deletion.
+	 */
+	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
+		c = READ_ONCE(local->classes[sub_id]);
+
+	if (c)
+		return c;
+
+	c = lookup_class((unsigned long)k->base + sub_id);
+	if (c)
+		goto caching;
+
+	if (unlikely(!dept_lock()))
+		return NULL;
+
+	c = lookup_class((unsigned long)k->base + sub_id);
+	if (unlikely(c))
+		goto unlock;
+
+	c = new_class();
+	if (unlikely(!c))
+		goto unlock;
+
+	c->name = n;
+	c->sched_map = sched_map;
+	c->sub_id = sub_id;
+	c->key = (unsigned long)(k->base + sub_id);
+	hash_add_class(c);
+	list_add(&c->all_node, &classes);
+unlock:
+	dept_unlock();
+caching:
+	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
+		WRITE_ONCE(local->classes[sub_id], c);
+
+	return c;
+}
+
+/*
+ * Called between dept_enter() and dept_exit().
+ */
+static void __dept_wait(struct dept_map *m, unsigned long w_f,
+			unsigned long ip, const char *w_fn, int sub_l,
+			bool sched_sleep, bool sched_map)
+{
+	int e;
+
+	/*
+	 * Be as conservative as possible. In case of mulitple waits for
+	 * a single dept_map, we are going to keep only the last wait's
+	 * wgen for simplicity - keeping all wgens seems overengineering.
+	 *
+	 * Of course, it might cause missing some dependencies that
+	 * would rarely, probabily never, happen but it helps avoid
+	 * false positive report.
+	 */
+	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, sched_map);
+		if (!c)
+			continue;
+
+		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+	}
+}
+
+/*
+ * Called between dept_enter() and dept_exit().
+ */
+static void __dept_event(struct dept_map *m, unsigned long e_f,
+			 unsigned long ip, const char *e_fn,
+			 bool sched_map)
+{
+	struct dept_class *c;
+	struct dept_key *k;
+	int e;
+
+	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
+		goto exit;
+
+	/*
+	 * An event is an event. If the caller passed more than single
+	 * event, then warn it and handle the event corresponding to
+	 * the first bit anyway.
+	 */
+	DEPT_WARN_ON(1UL << e != e_f);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
+
+	if (c && add_ecxt(m, c, 0UL, NULL, e_fn, 0)) {
+		do_event(m, c, READ_ONCE(m->wgen), ip);
+		pop_ecxt(m, c);
+	}
+exit:
+	/*
+	 * Keep the map diabled until the next sleep.
+	 */
+	WRITE_ONCE(m->wgen, 0U);
+}
+
+void dept_wait(struct dept_map *m, unsigned long w_f,
+	       unsigned long ip, const char *w_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	if (m->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_wait);
+
+void dept_stage_wait(struct dept_map *m, struct dept_key *k,
+		     unsigned long ip, const char *w_fn)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (m && m->nocheck)
+		return;
+
+	/*
+	 * Either m or k should be passed. Which means Dept relies on
+	 * either its own map or the caller's position in the code when
+	 * determining its class.
+	 */
+	if (DEPT_WARN_ON(!m && !k))
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	arch_spin_lock(&stage_spin);
+
+	/*
+	 * Ensure the outmost dept_stage_wait() works.
+	 */
+	if (dt->stage_m.keys)
+		goto unlock;
+
+	if (m) {
+		dt->stage_m = *m;
+
+		/*
+		 * Ensure dt->stage_m.keys != NULL and it works with the
+		 * map's map_key, not stage_m's one when ->keys == NULL.
+		 */
+		if (!m->keys)
+			dt->stage_m.keys = &m->map_key;
+	} else {
+		dt->stage_m.name = w_fn;
+		dt->stage_sched_map = true;
+	}
+
+	/*
+	 * dept_map_reinit() includes WRITE_ONCE(->wgen, 0U) that
+	 * effectively disables the map just in case real sleep won't
+	 * happen. dept_request_event_wait_commit() will enable it.
+	 */
+	dept_map_reinit(&dt->stage_m, k, -1, NULL);
+
+	dt->stage_w_fn = w_fn;
+	dt->stage_ip = ip;
+unlock:
+	arch_spin_unlock(&stage_spin);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_stage_wait);
+
+void dept_clean_stage(void)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	arch_spin_lock(&stage_spin);
+	memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
+	dt->stage_sched_map = false;
+	dt->stage_w_fn = NULL;
+	dt->stage_ip = 0UL;
+	arch_spin_unlock(&stage_spin);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_clean_stage);
+
+/*
+ * Always called from __schedule().
+ */
+void dept_request_event_wait_commit(void)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	unsigned int wg;
+	unsigned long ip;
+	const char *w_fn;
+	bool sched_map;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * It's impossible that __schedule() is called while Dept is
+	 * working that already disabled IRQ at the entrance.
+	 */
+	if (DEPT_WARN_ON(dt->recursive))
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * Checks if current has staged a wait.
+	 */
+	if (!dt->stage_m.keys)
+		goto exit;
+
+	w_fn = dt->stage_w_fn;
+	ip = dt->stage_ip;
+	sched_map = dt->stage_sched_map;
+
+	/*
+	 * Avoid zero wgen.
+	 */
+	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+	WRITE_ONCE(dt->stage_m.wgen, wg);
+
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+exit:
+	dept_exit(flags);
+}
+
+/*
+ * Always called from try_to_wake_up().
+ */
+void dept_stage_event(struct task_struct *t, unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	struct dept_map m;
+	bool sched_map;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	arch_spin_lock(&stage_spin);
+	m = t->dept_task.stage_m;
+	sched_map = t->dept_task.stage_sched_map;
+	arch_spin_unlock(&stage_spin);
+
+	/*
+	 * ->stage_m.keys should not be NULL if it's in use. Should
+	 * make sure that it's not NULL when staging a valid map.
+	 */
+	if (!m.keys)
+		goto exit;
+
+	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map);
+exit:
+	dept_exit(flags);
+}
+
+/*
+ * Modifies the latest ecxt corresponding to m and e_f.
+ */
+void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
+			  struct dept_key *new_k, unsigned long new_e_f,
+			  unsigned long new_ip, const char *new_c_fn,
+			  const char *new_e_fn, int new_sub_l)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_ecxt_held *eh;
+	struct dept_class *c;
+	struct dept_key *k;
+	unsigned long flags;
+	int pos = -1;
+	int new_e;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * XXX: Couldn't handle re-enterance cases. Ingore it for now.
+	 */
+	if (dt->recursive)
+		return;
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		/*
+		 * When it found an ecxt for any event in e_f, done.
+		 */
+		pos = find_ecxt_pos(m, c, true);
+		if (pos != -1)
+			break;
+	}
+
+	if (unlikely(pos == -1))
+		goto exit;
+
+	eh = dt->ecxt_held + pos;
+	new_sub_l = new_sub_l >= 0 ? new_sub_l : eh->sub_l;
+
+	new_e = find_first_bit(&new_e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (new_e < DEPT_MAX_SUBCLASSES_EVT)
+		/*
+		 * Let it work with the first bit anyway.
+		 */
+		DEPT_WARN_ON(1UL << new_e != new_e_f);
+	else
+		new_e = e;
+
+	pop_ecxt(m, c);
+
+	/*
+	 * Apply the key to the map.
+	 */
+	if (new_k)
+		dept_map_reinit(m, new_k, -1, NULL);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, new_e), m->name, false);
+
+	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l))
+		goto exit;
+
+	/*
+	 * Successfully pop_ecxt()ed but failed to add_ecxt().
+	 */
+	dt->missing_ecxt++;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_ecxt_modify);
+
+void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
+		     const char *c_fn, const char *e_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	struct dept_class *c;
+	struct dept_key *k;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		dt->missing_ecxt++;
+		return;
+	}
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (e >= DEPT_MAX_SUBCLASSES_EVT)
+		goto missing_ecxt;
+
+	/*
+	 * An event is an event. If the caller passed more than single
+	 * event, then warn it and handle the event corresponding to
+	 * the first bit anyway.
+	 */
+	DEPT_WARN_ON(1UL << e != e_f);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, false);
+
+	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l))
+		goto exit;
+missing_ecxt:
+	dt->missing_ecxt++;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_enter);
+
+bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	bool ret = false;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return false;
+
+	if (dt->recursive)
+		return false;
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		if (find_ecxt_pos(m, c, true) != -1) {
+			ret = true;
+			break;
+		}
+	}
+
+	dept_exit(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_holding);
+
+void dept_request_event(struct dept_map *m)
+{
+	unsigned long flags;
+	unsigned int wg;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (m->nocheck)
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	/*
+	 * Avoid zero wgen.
+	 */
+	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+	WRITE_ONCE(m->wgen, wg);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_request_event);
+
+void dept_event(struct dept_map *m, unsigned long e_f,
+		unsigned long ip, const char *e_fn)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		/*
+		 * Dept won't work with this even though an event
+		 * context has been asked. Don't make it confused at
+		 * handling the event. Disable it until the next.
+		 */
+		WRITE_ONCE(m->wgen, 0U);
+		return;
+	}
+
+	if (m->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	__dept_event(m, e_f, ip, e_fn, false);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_event);
+
+void dept_ecxt_exit(struct dept_map *m, unsigned long e_f,
+		    unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		dt->missing_ecxt--;
+		return;
+	}
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		/*
+		 * When it found an ecxt for any event in e_f, done.
+		 */
+		if (pop_ecxt(m, c))
+			goto exit;
+	}
+
+	dt->missing_ecxt--;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_exit);
+
+void dept_task_exit(struct task_struct *t)
+{
+	struct dept_task *dt = &t->dept_task;
+	int i;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	raw_local_irq_disable();
+
+	if (dt->stack)
+		put_stack(dt->stack);
+
+	for (i = 0; i < dt->ecxt_held_pos; i++) {
+		if (dt->ecxt_held[i].class)
+			put_class(dt->ecxt_held[i].class);
+		if (dt->ecxt_held[i].ecxt)
+			put_ecxt(dt->ecxt_held[i].ecxt);
+	}
+
+	for (i = 0; i < DEPT_MAX_WAIT_HIST; i++)
+		if (dt->wait_hist[i].wait)
+			put_wait(dt->wait_hist[i].wait);
+
+	dt->task_exit = true;
+	dept_off();
+
+	raw_local_irq_enable();
+}
+
+void dept_task_init(struct task_struct *t)
+{
+	memset(&t->dept_task, 0x0, sizeof(struct dept_task));
+}
+
+void dept_key_init(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub_id;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		DEPT_STOP("Key initialization fails.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	clean_classes_cache(k);
+
+	/*
+	 * dept_key_init() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_init() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
+		struct dept_class *c;
+
+		c = lookup_class((unsigned long)k->base + sub_id);
+		if (!c)
+			continue;
+
+		DEPT_STOP("The class(%s/%d) has not been removed.\n",
+			  c->name, sub_id);
+		break;
+	}
+
+	dept_unlock();
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_key_init);
+
+void dept_key_destroy(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub_id;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive == 1 && dt->task_exit) {
+		/*
+		 * Need to allow to go ahead in this case where
+		 * ->recursive has been set to 1 by dept_off() in
+		 * dept_task_exit() and ->task_exit has been set to
+		 * true in dept_task_exit().
+		 */
+	} else if (dt->recursive) {
+		DEPT_STOP("Key destroying fails.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	/*
+	 * dept_key_destroy() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_destroy() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
+		struct dept_class *c;
+
+		c = lookup_class((unsigned long)k->base + sub_id);
+		if (!c)
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(dept_key_destroy);
+
+static void move_llist(struct llist_head *to, struct llist_head *from)
+{
+	struct llist_node *first = llist_del_all(from);
+	struct llist_node *last;
+
+	if (!first)
+		return;
+
+	for (last = first; last->next; last = last->next);
+	llist_add_batch(first, last, to);
+}
+
+static void migrate_per_cpu_pool(void)
+{
+	const int boot_cpu = 0;
+	int i;
+
+	/*
+	 * The boot CPU has been using the temperal local pool so far.
+	 * From now on that per_cpu areas have been ready, use the
+	 * per_cpu local pool instead.
+	 */
+	DEPT_WARN_ON(smp_processor_id() != boot_cpu);
+	for (i = 0; i < OBJECT_NR; i++) {
+		struct llist_head *from;
+		struct llist_head *to;
+
+		from = &pool[i].boot_pool;
+		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
+		move_llist(to, from);
+	}
+}
+
+#define B2KB(B) ((B) / 1024)
+
+/*
+ * Should be called after setup_per_cpu_areas() and before no non-boot
+ * CPUs have been on.
+ */
+void __init dept_init(void)
+{
+	size_t mem_total = 0;
+
+	local_irq_disable();
+	dept_per_cpu_ready = 1;
+	migrate_per_cpu_pool();
+	local_irq_enable();
+
+#define HASH(id, bits) BUILD_BUG_ON(1 << (bits) <= 0);
+	#include "dept_hash.h"
+#undef  HASH
+#define OBJECT(id, nr) mem_total += sizeof(struct dept_##id) * nr;
+	#include "dept_object.h"
+#undef  OBJECT
+#define HASH(id, bits) mem_total += sizeof(struct hlist_head) * (1 << (bits));
+	#include "dept_hash.h"
+#undef  HASH
+
+	pr_info("DEPendency Tracker: Copyright (c) 2020 LG Electronics, Inc., Byungchul Park\n");
+	pr_info("... DEPT_MAX_STACK_ENTRY: %d\n", DEPT_MAX_STACK_ENTRY);
+	pr_info("... DEPT_MAX_WAIT_HIST  : %d\n", DEPT_MAX_WAIT_HIST);
+	pr_info("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD);
+	pr_info("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES);
+#define OBJECT(id, nr)							\
+	pr_info("... memory used by %s: %zu KB\n",			\
+	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	#include "dept_object.h"
+#undef  OBJECT
+#define HASH(id, bits)							\
+	pr_info("... hash list head used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
+	#include "dept_hash.h"
+#undef  HASH
+	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
+}
diff --git a/kernel/dependency/dept_hash.h b/kernel/dependency/dept_hash.h
new file mode 100644
index 000000000000..fd85aab1fdfb
--- /dev/null
+++ b/kernel/dependency/dept_hash.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HASH(id, bits)
+ *
+ * id  : Id for the object of struct dept_##id.
+ * bits: 1UL << bits is the hash table size.
+ */
+
+HASH(dep, 12)
+HASH(class, 12)
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
new file mode 100644
index 000000000000..0b7eb16fe9fb
--- /dev/null
+++ b/kernel/dependency/dept_object.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * OBJECT(id, nr)
+ *
+ * id: Id for the object of struct dept_##id.
+ * nr: # of the object that should be kept in the pool.
+ */
+
+OBJECT(dep, 1024 * 8)
+OBJECT(class, 1024 * 8)
+OBJECT(stack, 1024 * 32)
+OBJECT(ecxt, 1024 * 16)
+OBJECT(wait, 1024 * 32)
diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec80c46..0f48752c8b4c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -916,6 +916,7 @@ void __noreturn do_exit(long code)
 	exit_tasks_rcu_finish();
 
 	lockdep_free_task(tsk);
+	dept_task_exit(tsk);
 	do_task_dead();
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..1d33fc3868f1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#include <linux/dept.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2219,6 +2220,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_task(p);
 #endif
+	dept_task_init(p);
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 48568a0f5651..2882ea2e1b5a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1194,6 +1194,7 @@ static void free_module(struct module *mod)
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
 	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
+	dept_free_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -2893,6 +2894,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
+	dept_free_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f..0dc066caed9a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -64,6 +64,7 @@
 #include <linux/vtime.h>
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
+#include <linux/dept.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_ENTRY
@@ -4070,6 +4071,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	int cpu, success = 0;
 
 	preempt_disable();
+	dept_stage_event(p, _RET_IP_);
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -6446,6 +6448,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
+	prev_state = READ_ONCE(prev->__state);
+	if (sched_mode != SM_PREEMPT && prev_state & TASK_NORMAL)
+		dept_request_event_wait_commit();
+
+	dept_sched_enter();
+
 	schedule_debug(prev, !!sched_mode);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
@@ -6560,6 +6568,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
+	dept_sched_exit();
 }
 
 void __noreturn do_task_dead(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..611fd01751a7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1255,6 +1255,33 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config DEPT
+	bool "Dependency tracking (EXPERIMENTAL)"
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	select DEBUG_SPINLOCK
+	select DEBUG_MUTEXES
+	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_RWSEMS
+	select DEBUG_WW_MUTEX_SLOWPATH
+	select DEBUG_LOCK_ALLOC
+	select TRACE_IRQFLAGS
+	select STACKTRACE
+	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
+	select KALLSYMS
+	select KALLSYMS_ALL
+	select PROVE_LOCKING
+	default n
+	help
+	  Check dependencies between wait and event and report it if
+	  deadlock possibility has been detected. Multiple reports are
+	  allowed if there are more than a single problem.
+
+	  This feature is considered EXPERIMENTAL that might produce
+	  false positive reports because new dependencies start to be
+	  tracked, that have never been tracked before. It's worth
+	  noting, to mitigate the impact by the false positives, multi
+	  reporting has been supported.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 8d24279fad05..cd89138d62ba 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1398,6 +1398,8 @@ static void reset_locks(void)
 	local_irq_disable();
 	lockdep_free_key_range(&ww_lockdep.acquire_key, 1);
 	lockdep_free_key_range(&ww_lockdep.mutex_key, 1);
+	dept_free_range(&ww_lockdep.acquire_key, 1);
+	dept_free_range(&ww_lockdep.mutex_key, 1);
 
 	I1(A); I1(B); I1(C); I1(D);
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
-- 
2.17.1

