Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7C55E678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbiF1Ox7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345648AbiF1Ox6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3ECBC60
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9+tG5yB4Seih6XBmLRm2TQGTu2ZKnvs/pM6VXO9QF8=;
        b=Einc7xjqYalg5yzbVlGlGyuGyvsMovhtxP4D9GuIc2n5OPVJhj7GRgEgvqq5N3ceaPizJo
        p9i6/xLW3SoFwHNZtxvUeANUiZ3g2bYu+HCNP2ginLD46O7KSbJ0E9UYh64zDV4cG5ls6G
        cqVsevq5kO3HeZloo+KnfD7sqWodB5w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-PcTmyIyzOLu8amQu9_LHaA-1; Tue, 28 Jun 2022 10:53:54 -0400
X-MC-Unique: PcTmyIyzOLu8amQu9_LHaA-1
Received: by mail-qk1-f198.google.com with SMTP id bs17-20020a05620a471100b006a734d3910dso13611445qkb.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9+tG5yB4Seih6XBmLRm2TQGTu2ZKnvs/pM6VXO9QF8=;
        b=GmsoeEB5dkHAQbgC1KghDjtgrYupGayhiciRJwHIDtyhW6nfQ2a1YcZGp9KZpigLX3
         mjk6XVta/rTJR2WC1VN6XsAq30s3r3nn5EoM38S9q808Ta8GEi2Cb6zCYUaVy2l4QsqC
         +UOXWfVfNh1jGcenYawhtM3ShRts+WrsvbMUHFqZGnLz1R0m+Y9W9TrhJ0im6m8meG6M
         KLIcyhn6BQGKlHfcHTa3bHdpXNzamlKo8PES/Y1ov0jvTHV8uXE3+IVbCBB8S6GBZC76
         13WKkPoxbkvoSBkIbulGntkXexn1+vIqg4Fu9IN/JwQvQfF8oY7+AijdtrNITKMB40vj
         3kgQ==
X-Gm-Message-State: AJIora/DhHWIYbaZiD7PZrF6qtXR6oDnN3RPpSOpOYGcL7K/dGrQbOFr
        CRVQnauMET/nWguMFE0/PZ38U+AvFHJNZPPvqwcodMqr+gy9e1/FX4AVXGVz4slDCjWli3I3IjS
        igwoGF2zOOHvK/RL3y/gmazVCFg==
X-Received: by 2002:ad4:584d:0:b0:470:4228:176 with SMTP id de13-20020ad4584d000000b0047042280176mr2599540qvb.129.1656428033631;
        Tue, 28 Jun 2022 07:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1svU+oIcLhlrzUcTeaUfjmkopSx4Qx3QqaJqtj14RIYcyWI0oaOk+zip3hLM3Kfl8jCZpHUNA==
X-Received: by 2002:ad4:584d:0:b0:470:4228:176 with SMTP id de13-20020ad4584d000000b0047042280176mr2599506qvb.129.1656428033190;
        Tue, 28 Jun 2022 07:53:53 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006a6b374d8bbsm13178473qkn.69.2022.06.28.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:53:52 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:53:50 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YrsV/uT2MDgNPMvR@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
 <YqnXVMtBkS2nbx70@bfoster>
 <YqnhW2CI1kbJ3NqR@casper.infradead.org>
 <YqnwFZxmiekL5ZOC@bfoster>
 <YqoJ+p83dLOcGfwX@casper.infradead.org>
 <20220628125511.s2frv6lw7zgyzou5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628125511.s2frv6lw7zgyzou5@wittgenstein>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:55:11PM +0200, Christian Brauner wrote:
> On Wed, Jun 15, 2022 at 05:34:02PM +0100, Matthew Wilcox wrote:
> > On Wed, Jun 15, 2022 at 10:43:33AM -0400, Brian Foster wrote:
> > > Interesting, thanks. I'll have to dig more into this to grok the current
> > > state of the radix-tree interface vs. the underlying data structure. If
> > > I follow correctly, you're saying the radix-tree api is essentially
> > > already a translation layer to the xarray these days, and we just need
> > > to move legacy users off the radix-tree api so we can eventually kill it
> > > off...
> > 
> > If only it were that easy ... the XArray has a whole bunch of debugging
> > asserts to make sure the users are actually using it correctly, and a
> > lot of radix tree users don't (they're probably not buggy, but they
> > don't use the XArray's embedded lock).
> > 
> > Anyway, here's a first cut at converting the PID allocator from the IDR
> > to the XArray API.  It boots, but I haven't tried to do anything tricky
> > with PID namespaces or CRIU.
> 
> It'd be great to see that conversion done.
> Fwiw, there's test cases for e.g. nested pid namespace creation with
> specifically requested PIDs in
> 

Ok, but I'm a little confused. Why open code the xarray usage as opposed
to work the idr bits closer to being able to use the xarray api (and/or
work the xarray to better support the idr use case)? I see 150+ callers
of idr_init(). Is the goal to eventually open code them all? That seems
a lot of potential api churn for something that is presumably a generic
interface (and perhaps inconsistent with ida, which looks like it uses
xarray directly?), but I'm probably missing details.

If the issue is open-coded locking across all the idr users conflicting
with internal xarray debug bits, I guess what I'm wondering is why not
implement your patch more generically within idr (i.e. expose some
locking apis, etc.)? Even if it meant creating something like a
temporary init_idr_xa() variant that users can switch over to as they're
audited for expected behavior, I don't quite grok why that couldn't be
made to work if changing this code over directly does and the various
core radix tree data structures idr uses are already #defined to xarray
variants. Hm?

Brian

> tools/selftests/clone3
> 
> and there's additional tests in
> 
> tools/selftests/pidfd
> 
> > 
> > 
> > diff --git a/fs/proc/loadavg.c b/fs/proc/loadavg.c
> > index f32878d9a39f..cec85a07184a 100644
> > --- a/fs/proc/loadavg.c
> > +++ b/fs/proc/loadavg.c
> > @@ -21,7 +21,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
> >  		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
> >  		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
> >  		nr_running(), nr_threads,
> > -		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
> > +		task_active_pid_ns(current)->cursor - 1);
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> > index 07481bb87d4e..68aaaf78491b 100644
> > --- a/include/linux/pid_namespace.h
> > +++ b/include/linux/pid_namespace.h
> > @@ -9,7 +9,7 @@
> >  #include <linux/threads.h>
> >  #include <linux/nsproxy.h>
> >  #include <linux/ns_common.h>
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> >  
> >  /* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> >  #define MAX_PID_NS_LEVEL 32
> > @@ -17,8 +17,9 @@
> >  struct fs_pin;
> >  
> >  struct pid_namespace {
> > -	struct idr idr;
> > +	struct xarray xa;
> >  	struct rcu_head rcu;
> > +	unsigned int cursor;
> >  	unsigned int pid_allocated;
> >  	struct task_struct *child_reaper;
> >  	struct kmem_cache *pid_cachep;
> > @@ -37,6 +38,20 @@ extern struct pid_namespace init_pid_ns;
> >  
> >  #define PIDNS_ADDING (1U << 31)
> >  
> > +/*
> > + * Note: disable interrupts while the xarray lock is held as an
> > + * interrupt might come in and do read_lock(&tasklist_lock).
> > + *
> > + * If we don't disable interrupts there is a nasty deadlock between
> > + * detach_pid()->free_pid() and another cpu that locks the PIDs
> > + * followed by an interrupt routine that does read_lock(&tasklist_lock);
> > + *
> > + * After we clean up the tasklist_lock and know there are no
> > + * irq handlers that take it we can leave the interrupts enabled.
> > + * For now it is easier to be safe than to prove it can't happen.
> > + */
> > +#define PID_XA_FLAGS	(XA_FLAGS_TRACK_FREE | XA_FLAGS_LOCK_IRQ)
> > +
> >  #ifdef CONFIG_PID_NS
> >  static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
> >  {
> > @@ -84,7 +99,7 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
> >  
> >  extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
> >  void pidhash_init(void);
> > -void pid_idr_init(void);
> > +void pid_init(void);
> >  
> >  static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
> >  {
> > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > index c34173e6c5f1..37e4391ee89f 100644
> > --- a/include/linux/threads.h
> > +++ b/include/linux/threads.h
> > @@ -38,7 +38,7 @@
> >   * Define a minimum number of pids per cpu.  Heuristically based
> >   * on original pid max of 32k for 32 cpus.  Also, increase the
> >   * minimum settable value for pid_max on the running system based
> > - * on similar defaults.  See kernel/pid.c:pid_idr_init() for details.
> > + * on similar defaults.  See kernel/pid.c:pid_init() for details.
> >   */
> >  #define PIDS_PER_CPU_DEFAULT	1024
> >  #define PIDS_PER_CPU_MIN	8
> > diff --git a/init/main.c b/init/main.c
> > index 0ee39cdcfcac..3944dcd10c09 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -73,7 +73,6 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/init.h>
> >  #include <linux/signal.h>
> > -#include <linux/idr.h>
> >  #include <linux/kgdb.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/async.h>
> > @@ -1100,7 +1099,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >  		late_time_init();
> >  	sched_clock_init();
> >  	calibrate_delay();
> > -	pid_idr_init();
> > +	pid_init();
> >  	anon_vma_init();
> >  #ifdef CONFIG_X86
> >  	if (efi_enabled(EFI_RUNTIME_SERVICES))
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 2fc0a16ec77b..de0b4614bdb8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -41,7 +41,7 @@
> >  #include <linux/anon_inodes.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/task.h>
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> >  #include <net/sock.h>
> >  #include <uapi/linux/pidfd.h>
> >  
> > @@ -66,15 +66,10 @@ int pid_max = PID_MAX_DEFAULT;
> >  int pid_max_min = RESERVED_PIDS + 1;
> >  int pid_max_max = PID_MAX_LIMIT;
> >  
> > -/*
> > - * PID-map pages start out as NULL, they get allocated upon
> > - * first use and are never deallocated. This way a low pid_max
> > - * value does not cause lots of bitmaps to be allocated, but
> > - * the scheme scales to up to 4 million PIDs, runtime.
> > - */
> >  struct pid_namespace init_pid_ns = {
> >  	.ns.count = REFCOUNT_INIT(2),
> > -	.idr = IDR_INIT(init_pid_ns.idr),
> > +	.xa = XARRAY_INIT(init_pid_ns.xa, PID_XA_FLAGS),
> > +	.cursor = 1,
> >  	.pid_allocated = PIDNS_ADDING,
> >  	.level = 0,
> >  	.child_reaper = &init_task,
> > @@ -86,22 +81,6 @@ struct pid_namespace init_pid_ns = {
> >  };
> >  EXPORT_SYMBOL_GPL(init_pid_ns);
> >  
> > -/*
> > - * Note: disable interrupts while the pidmap_lock is held as an
> > - * interrupt might come in and do read_lock(&tasklist_lock).
> > - *
> > - * If we don't disable interrupts there is a nasty deadlock between
> > - * detach_pid()->free_pid() and another cpu that does
> > - * spin_lock(&pidmap_lock) followed by an interrupt routine that does
> > - * read_lock(&tasklist_lock);
> > - *
> > - * After we clean up the tasklist_lock and know there are no
> > - * irq handlers that take it we can leave the interrupts enabled.
> > - * For now it is easier to be safe than to prove it can't happen.
> > - */
> > -
> > -static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
> > -
> >  void put_pid(struct pid *pid)
> >  {
> >  	struct pid_namespace *ns;
> > @@ -129,10 +108,11 @@ void free_pid(struct pid *pid)
> >  	int i;
> >  	unsigned long flags;
> >  
> > -	spin_lock_irqsave(&pidmap_lock, flags);
> >  	for (i = 0; i <= pid->level; i++) {
> >  		struct upid *upid = pid->numbers + i;
> >  		struct pid_namespace *ns = upid->ns;
> > +
> > +		xa_lock_irqsave(&ns->xa, flags);
> >  		switch (--ns->pid_allocated) {
> >  		case 2:
> >  		case 1:
> > @@ -149,9 +129,9 @@ void free_pid(struct pid *pid)
> >  			break;
> >  		}
> >  
> > -		idr_remove(&ns->idr, upid->nr);
> > +		__xa_erase(&ns->xa, upid->nr);
> > +		xa_unlock_irqrestore(&ns->xa, flags);
> >  	}
> > -	spin_unlock_irqrestore(&pidmap_lock, flags);
> >  
> >  	call_rcu(&pid->rcu, delayed_put_pid);
> >  }
> > @@ -161,7 +141,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> >  {
> >  	struct pid *pid;
> >  	enum pid_type type;
> > -	int i, nr;
> > +	int i;
> >  	struct pid_namespace *tmp;
> >  	struct upid *upid;
> >  	int retval = -ENOMEM;
> > @@ -205,43 +185,42 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> >  			set_tid_size--;
> >  		}
> >  
> > -		idr_preload(GFP_KERNEL);
> > -		spin_lock_irq(&pidmap_lock);
> > -
> >  		if (tid) {
> > -			nr = idr_alloc(&tmp->idr, NULL, tid,
> > -				       tid + 1, GFP_ATOMIC);
> > +			retval = xa_insert_irq(&tmp->xa, tid, NULL, GFP_KERNEL);
> > +
> >  			/*
> > -			 * If ENOSPC is returned it means that the PID is
> > +			 * If EBUSY is returned it means that the PID is
> >  			 * alreay in use. Return EEXIST in that case.
> >  			 */
> > -			if (nr == -ENOSPC)
> > -				nr = -EEXIST;
> > +			if (retval == -EBUSY)
> > +				retval = -EEXIST;
> >  		} else {
> >  			int pid_min = 1;
> > +
> > +			xa_lock_irq(&tmp->xa);
> >  			/*
> >  			 * init really needs pid 1, but after reaching the
> >  			 * maximum wrap back to RESERVED_PIDS
> >  			 */
> > -			if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> > +			if (tmp->cursor > RESERVED_PIDS)
> >  				pid_min = RESERVED_PIDS;
> >  
> >  			/*
> >  			 * Store a null pointer so find_pid_ns does not find
> >  			 * a partially initialized PID (see below).
> >  			 */
> > -			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> > -					      pid_max, GFP_ATOMIC);
> > +			retval = __xa_alloc_cyclic(&tmp->xa, &tid, NULL,
> > +					XA_LIMIT(pid_min, pid_max),
> > +					&tmp->cursor, GFP_KERNEL);
> > +			xa_unlock_irq(&tmp->xa);
> > +			if (retval == -EBUSY)
> > +				retval = -EAGAIN;
> >  		}
> > -		spin_unlock_irq(&pidmap_lock);
> > -		idr_preload_end();
> >  
> > -		if (nr < 0) {
> > -			retval = (nr == -ENOSPC) ? -EAGAIN : nr;
> > +		if (retval < 0)
> >  			goto out_free;
> > -		}
> >  
> > -		pid->numbers[i].nr = nr;
> > +		pid->numbers[i].nr = tid;
> >  		pid->numbers[i].ns = tmp;
> >  		tmp = tmp->parent;
> >  	}
> > @@ -266,34 +245,35 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> >  	INIT_HLIST_HEAD(&pid->inodes);
> >  
> >  	upid = pid->numbers + ns->level;
> > -	spin_lock_irq(&pidmap_lock);
> > +	xa_lock_irq(&ns->xa);
> >  	if (!(ns->pid_allocated & PIDNS_ADDING))
> >  		goto out_unlock;
> >  	for ( ; upid >= pid->numbers; --upid) {
> >  		/* Make the PID visible to find_pid_ns. */
> > -		idr_replace(&upid->ns->idr, pid, upid->nr);
> > +		if (upid->ns != ns)
> > +			xa_lock_irq(&ns->xa);
> > +		__xa_store(&upid->ns->xa, upid->nr, pid, 0);
> >  		upid->ns->pid_allocated++;
> > +		xa_unlock_irq(&ns->xa);
> >  	}
> > -	spin_unlock_irq(&pidmap_lock);
> >  
> >  	return pid;
> >  
> >  out_unlock:
> > -	spin_unlock_irq(&pidmap_lock);
> > +	xa_unlock_irq(&ns->xa);
> >  	put_pid_ns(ns);
> >  
> >  out_free:
> > -	spin_lock_irq(&pidmap_lock);
> >  	while (++i <= ns->level) {
> >  		upid = pid->numbers + i;
> > -		idr_remove(&upid->ns->idr, upid->nr);
> > +		xa_erase_irq(&upid->ns->xa, upid->nr);
> >  	}
> >  
> > +	xa_lock_irq(&ns->xa);
> >  	/* On failure to allocate the first pid, reset the state */
> >  	if (ns->pid_allocated == PIDNS_ADDING)
> > -		idr_set_cursor(&ns->idr, 0);
> > -
> > -	spin_unlock_irq(&pidmap_lock);
> > +		ns->cursor = 0;
> > +	xa_unlock_irq(&ns->xa);
> >  
> >  	kmem_cache_free(ns->pid_cachep, pid);
> >  	return ERR_PTR(retval);
> > @@ -301,14 +281,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> >  
> >  void disable_pid_allocation(struct pid_namespace *ns)
> >  {
> > -	spin_lock_irq(&pidmap_lock);
> > +	xa_lock_irq(&ns->xa);
> >  	ns->pid_allocated &= ~PIDNS_ADDING;
> > -	spin_unlock_irq(&pidmap_lock);
> > +	xa_unlock_irq(&ns->xa);
> >  }
> >  
> >  struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
> >  {
> > -	return idr_find(&ns->idr, nr);
> > +	return xa_load(&ns->xa, nr);
> >  }
> >  EXPORT_SYMBOL_GPL(find_pid_ns);
> >  
> > @@ -517,7 +497,9 @@ EXPORT_SYMBOL_GPL(task_active_pid_ns);
> >   */
> >  struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >  {
> > -	return idr_get_next(&ns->idr, &nr);
> > +	unsigned long index = nr;
> > +
> > +	return xa_find(&ns->xa, &index, ULONG_MAX, XA_PRESENT);
> >  }
> >  
> >  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > @@ -646,7 +628,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> >  	return fd;
> >  }
> >  
> > -void __init pid_idr_init(void)
> > +void __init pid_init(void)
> >  {
> >  	/* Verify no one has done anything silly: */
> >  	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
> > @@ -658,8 +640,6 @@ void __init pid_idr_init(void)
> >  				PIDS_PER_CPU_MIN * num_possible_cpus());
> >  	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
> >  
> > -	idr_init(&init_pid_ns.idr);
> > -
> >  	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
> >  			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> >  }
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index f4f8cb0435b4..947e25fb8546 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/export.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/sched/signal.h>
> > -#include <linux/idr.h>
> > +#include <linux/xarray.h>
> >  
> >  static DEFINE_MUTEX(pid_caches_mutex);
> >  static struct kmem_cache *pid_ns_cachep;
> > @@ -92,15 +92,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> >  	if (ns == NULL)
> >  		goto out_dec;
> >  
> > -	idr_init(&ns->idr);
> > +	xa_init_flags(&ns->xa, PID_XA_FLAGS);
> >  
> >  	ns->pid_cachep = create_pid_cachep(level);
> >  	if (ns->pid_cachep == NULL)
> > -		goto out_free_idr;
> > +		goto out_free_xa;
> >  
> >  	err = ns_alloc_inum(&ns->ns);
> >  	if (err)
> > -		goto out_free_idr;
> > +		goto out_free_xa;
> >  	ns->ns.ops = &pidns_operations;
> >  
> >  	refcount_set(&ns->ns.count, 1);
> > @@ -112,8 +112,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> >  
> >  	return ns;
> >  
> > -out_free_idr:
> > -	idr_destroy(&ns->idr);
> > +out_free_xa:
> > +	xa_destroy(&ns->xa);
> >  	kmem_cache_free(pid_ns_cachep, ns);
> >  out_dec:
> >  	dec_pid_namespaces(ucounts);
> > @@ -135,7 +135,7 @@ static void destroy_pid_namespace(struct pid_namespace *ns)
> >  {
> >  	ns_free_inum(&ns->ns);
> >  
> > -	idr_destroy(&ns->idr);
> > +	xa_destroy(&ns->xa);
> >  	call_rcu(&ns->rcu, delayed_free_pidns);
> >  }
> >  
> > @@ -165,7 +165,7 @@ EXPORT_SYMBOL_GPL(put_pid_ns);
> >  
> >  void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> >  {
> > -	int nr;
> > +	long nr;
> >  	int rc;
> >  	struct task_struct *task, *me = current;
> >  	int init_pids = thread_group_leader(me) ? 1 : 2;
> > @@ -198,8 +198,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> >  	 */
> >  	rcu_read_lock();
> >  	read_lock(&tasklist_lock);
> > -	nr = 2;
> > -	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
> > +	xa_for_each_range(&pid_ns->xa, nr, pid, 2, ULONG_MAX) {
> >  		task = pid_task(pid, PIDTYPE_PID);
> >  		if (task && !__fatal_signal_pending(task))
> >  			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
> > @@ -272,12 +271,12 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> >  	 * it should synchronize its usage with external means.
> >  	 */
> >  
> > -	next = idr_get_cursor(&pid_ns->idr) - 1;
> > +	next = pid_ns->cursor - 1;
> >  
> >  	tmp.data = &next;
> >  	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> >  	if (!ret && write)
> > -		idr_set_cursor(&pid_ns->idr, next + 1);
> > +		pid_ns->cursor = next + 1;
> >  
> >  	return ret;
> >  }
> 

