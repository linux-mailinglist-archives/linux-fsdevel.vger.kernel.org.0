Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF77D6D14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 04:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfJOCA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 22:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJOCA0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:00:26 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A7321848;
        Tue, 15 Oct 2019 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571104825;
        bh=xU45u6apTcaRCcaac5+AoDuv/WHB07zCoTILoXG+ekw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cKp+jMGDtl3LKahXgjBhD5Kxi510BeL/xusX9wmePWj6qUFTt24z7LGPXqkfA8hc/
         F+ka70ZT3EV9hPBgMtQAxP43YBXbm5sNGOwuyl9/N/BsL31YS2sKCHqs6zvcHnpzH+
         seVjHiSU4jYiiVYg+mu69p4SjxDX03lMRuYRinY0=
Date:   Mon, 14 Oct 2019 19:00:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Sterba <dsterba@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] rcu: make PREEMPT_RCU to be a decoration of TREE_RCU
Message-ID: <20191015020023.GO2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191013125959.3280-1-laijs@linux.alibaba.com>
 <20191014184832.GA125935@google.com>
 <20191015014650.GL2689@paulmck-ThinkPad-P72>
 <CAJhGHyCMa7mU_K+-22MHGwJ+BfFun=2ndzehZCMoNrgYfBowaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCMa7mU_K+-22MHGwJ+BfFun=2ndzehZCMoNrgYfBowaQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:50:21AM +0800, Lai Jiangshan wrote:
> On Tue, Oct 15, 2019 at 9:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Oct 14, 2019 at 02:48:32PM -0400, Joel Fernandes wrote:
> > > On Sun, Oct 13, 2019 at 12:59:57PM +0000, Lai Jiangshan wrote:
> > > > Currently PREEMPT_RCU and TREE_RCU are "contrary" configs
> > > > when they can't be both on. But PREEMPT_RCU is actually a kind
> > > > of TREE_RCU in the implementation. It seams to be appropriate
> > > > to make PREEMPT_RCU to be a decorative option of TREE_RCU.
> > > >
> > >
> > > Looks like a nice simplification and so far I could not poke any holes in the
> > > code...
> > >
> > > I am in support of this patch for further review and testing. Thanks!
> > >
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Thank you both!
> >
> > Lai, what is this patch against?  It does not want to apply to the current
> > -rcu "dev" branch.
> 
> Oh, sorry
> 
> I wrongly made the change base on upstream.
> I will rebase later.

Very good, looking forward to this updated version.

							Thanx, Paul

> thanks
> Lai
> 
> >
> >                                                         Thanx, Paul
> >
> > > thanks,
> > >
> > >  - Joel
> > >
> > >
> > > > Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > ---
> > > >  include/linux/rcupdate.h   |  4 ++--
> > > >  include/trace/events/rcu.h |  4 ++--
> > > >  kernel/rcu/Kconfig         | 13 +++++++------
> > > >  kernel/rcu/Makefile        |  1 -
> > > >  kernel/rcu/rcu.h           |  2 +-
> > > >  kernel/rcu/update.c        |  2 +-
> > > >  kernel/sysctl.c            |  2 +-
> > > >  7 files changed, 14 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 75a2eded7aa2..1eee9f6c27f9 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -167,7 +167,7 @@ do { \
> > > >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > > >   */
> > > >
> > > > -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> > > > +#if defined(CONFIG_TREE_RCU)
> > > >  #include <linux/rcutree.h>
> > > >  #elif defined(CONFIG_TINY_RCU)
> > > >  #include <linux/rcutiny.h>
> > > > @@ -583,7 +583,7 @@ do {                                                                          \
> > > >   * read-side critical section that would block in a !PREEMPT kernel.
> > > >   * But if you want the full story, read on!
> > > >   *
> > > > - * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
> > > > + * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
> > > >   * it is illegal to block while in an RCU read-side critical section.
> > > >   * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
> > > >   * kernel builds, RCU read-side critical sections may be preempted,
> > > > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > > > index 694bd040cf51..1ce15c5be4c8 100644
> > > > --- a/include/trace/events/rcu.h
> > > > +++ b/include/trace/events/rcu.h
> > > > @@ -41,7 +41,7 @@ TRACE_EVENT(rcu_utilization,
> > > >     TP_printk("%s", __entry->s)
> > > >  );
> > > >
> > > > -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> > > > +#if defined(CONFIG_TREE_RCU)
> > > >
> > > >  /*
> > > >   * Tracepoint for grace-period events.  Takes a string identifying the
> > > > @@ -425,7 +425,7 @@ TRACE_EVENT_RCU(rcu_fqs,
> > > >               __entry->cpu, __entry->qsevent)
> > > >  );
> > > >
> > > > -#endif /* #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) */
> > > > +#endif /* #if defined(CONFIG_TREE_RCU) */
> > > >
> > > >  /*
> > > >   * Tracepoint for dyntick-idle entry/exit events.  These take a string
> > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > index 7644eda17d62..0303934e6ef0 100644
> > > > --- a/kernel/rcu/Kconfig
> > > > +++ b/kernel/rcu/Kconfig
> > > > @@ -7,7 +7,7 @@ menu "RCU Subsystem"
> > > >
> > > >  config TREE_RCU
> > > >     bool
> > > > -   default y if !PREEMPTION && SMP
> > > > +   default y if SMP
> > > >     help
> > > >       This option selects the RCU implementation that is
> > > >       designed for very large SMP system with hundreds or
> > > > @@ -17,6 +17,7 @@ config TREE_RCU
> > > >  config PREEMPT_RCU
> > > >     bool
> > > >     default y if PREEMPTION
> > > > +   select TREE_RCU
> > > >     help
> > > >       This option selects the RCU implementation that is
> > > >       designed for very large SMP systems with hundreds or
> > > > @@ -78,7 +79,7 @@ config TASKS_RCU
> > > >       user-mode execution as quiescent states.
> > > >
> > > >  config RCU_STALL_COMMON
> > > > -   def_bool ( TREE_RCU || PREEMPT_RCU )
> > > > +   def_bool TREE_RCU
> > > >     help
> > > >       This option enables RCU CPU stall code that is common between
> > > >       the TINY and TREE variants of RCU.  The purpose is to allow
> > > > @@ -86,13 +87,13 @@ config RCU_STALL_COMMON
> > > >       making these warnings mandatory for the tree variants.
> > > >
> > > >  config RCU_NEED_SEGCBLIST
> > > > -   def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
> > > > +   def_bool ( TREE_RCU || TREE_SRCU )
> > > >
> > > >  config RCU_FANOUT
> > > >     int "Tree-based hierarchical RCU fanout value"
> > > >     range 2 64 if 64BIT
> > > >     range 2 32 if !64BIT
> > > > -   depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
> > > > +   depends on TREE_RCU && RCU_EXPERT
> > > >     default 64 if 64BIT
> > > >     default 32 if !64BIT
> > > >     help
> > > > @@ -112,7 +113,7 @@ config RCU_FANOUT_LEAF
> > > >     int "Tree-based hierarchical RCU leaf-level fanout value"
> > > >     range 2 64 if 64BIT
> > > >     range 2 32 if !64BIT
> > > > -   depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
> > > > +   depends on TREE_RCU && RCU_EXPERT
> > > >     default 16
> > > >     help
> > > >       This option controls the leaf-level fanout of hierarchical
> > > > @@ -187,7 +188,7 @@ config RCU_BOOST_DELAY
> > > >
> > > >  config RCU_NOCB_CPU
> > > >     bool "Offload RCU callback processing from boot-selected CPUs"
> > > > -   depends on TREE_RCU || PREEMPT_RCU
> > > > +   depends on TREE_RCU
> > > >     depends on RCU_EXPERT || NO_HZ_FULL
> > > >     default n
> > > >     help
> > > > diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
> > > > index 020e8b6a644b..82d5fba48b2f 100644
> > > > --- a/kernel/rcu/Makefile
> > > > +++ b/kernel/rcu/Makefile
> > > > @@ -9,6 +9,5 @@ obj-$(CONFIG_TINY_SRCU) += srcutiny.o
> > > >  obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
> > > >  obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
> > > >  obj-$(CONFIG_TREE_RCU) += tree.o
> > > > -obj-$(CONFIG_PREEMPT_RCU) += tree.o
> > > >  obj-$(CONFIG_TINY_RCU) += tiny.o
> > > >  obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > index 8fd4f82c9b3d..4149ba76824f 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -452,7 +452,7 @@ enum rcutorture_type {
> > > >     INVALID_RCU_FLAVOR
> > > >  };
> > > >
> > > > -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> > > > +#if defined(CONFIG_TREE_RCU)
> > > >  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > > >                         unsigned long *gp_seq);
> > > >  void rcutorture_record_progress(unsigned long vernum);
> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index 1861103662db..34a7452b25fd 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -435,7 +435,7 @@ struct debug_obj_descr rcuhead_debug_descr = {
> > > >  EXPORT_SYMBOL_GPL(rcuhead_debug_descr);
> > > >  #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > >
> > > > -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) || defined(CONFIG_RCU_TRACE)
> > > > +#if defined(CONFIG_TREE_RCU) || defined(CONFIG_RCU_TRACE)
> > > >  void do_trace_rcu_torture_read(const char *rcutorturename, struct rcu_head *rhp,
> > > >                            unsigned long secs,
> > > >                            unsigned long c_old, unsigned long c)
> > > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > > index 00fcea236eba..2ace158a4d72 100644
> > > > --- a/kernel/sysctl.c
> > > > +++ b/kernel/sysctl.c
> > > > @@ -1268,7 +1268,7 @@ static struct ctl_table kern_table[] = {
> > > >             .proc_handler   = proc_do_static_key,
> > > >     },
> > > >  #endif
> > > > -#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
> > > > +#if defined(CONFIG_TREE_RCU)
> > > >     {
> > > >             .procname       = "panic_on_rcu_stall",
> > > >             .data           = &sysctl_panic_on_rcu_stall,
> > > > --
> > > > 2.20.1
> > > >
