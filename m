Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23838297877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756431AbgJWUxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 16:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756428AbgJWUxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:53:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693F1208E4;
        Fri, 23 Oct 2020 20:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603486419;
        bh=ojQX8v4FWHWriM/9vutOQ7P1tVXDPKF1/x3d5VeoJaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kvqPjaUAbhgOA7v9m5hPwFhSot+9JpnZXoeCrdsm06tmZk3i0PrkuY3l00nQhXTO7
         mME/ZUGMaFJ8HfKVhEI2MvB8tG0mJXu0Oz9Lq5QXxDSvD9OeEOp7qTfPlU5UBnvfap
         tnFzhsUdlh/9ZNLst1GWoxnofysl3fTu/WbsWfz4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 03E563520D11; Fri, 23 Oct 2020 13:53:39 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:53:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 04/65] mm: Extract might_alloc() debug check
Message-ID: <20201023205338.GQ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:21:15PM +0200, Daniel Vetter wrote:
> Extracted from slab.h, which seems to have the most complete version
> including the correct might_sleep() check. Roll it out to slob.c.
> 
> Motivated by a discussion with Paul about possibly changing call_rcu
> behaviour to allocate memory, but only roughly every 500th call.
> 
> There are a lot fewer places in the kernel that care about whether
> allocating memory is allowed or not (due to deadlocks with reclaim
> code) than places that care whether sleeping is allowed. But debugging
> these also tends to be a lot harder, so nice descriptive checks could
> come in handy. I might have some use eventually for annotations in
> drivers/gpu.
> 
> Note that unlike fs_reclaim_acquire/release gfpflags_allow_blocking
> does not consult the PF_MEMALLOC flags. But there is no flag
> equivalent for GFP_NOWAIT, hence this check can't go wrong due to
> memalloc_no*_save/restore contexts.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Nice!!!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/sched/mm.h | 16 ++++++++++++++++
>  mm/slab.h                |  5 +----
>  mm/slob.c                |  6 ++----
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index f889e332912f..2b0037abac0b 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -205,6 +205,22 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
>  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>  #endif
>  
> +/**
> + * might_alloc - Marks possible allocation sites
> + * @gfp_mask: gfp_t flags that would be use to allocate
> + *
> + * Similar to might_sleep() and other annotations this can be used in functions
> + * that might allocate, but often dont. Compiles to nothing without
> + * CONFIG_LOCKDEP. Includes a conditional might_sleep() if @gfp allows blocking.
> + */
> +static inline void might_alloc(gfp_t gfp_mask)
> +{
> +	fs_reclaim_acquire(gfp_mask);
> +	fs_reclaim_release(gfp_mask);
> +
> +	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> +}
> +
>  /**
>   * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
>   *
> diff --git a/mm/slab.h b/mm/slab.h
> index 6cc323f1313a..fedd789b2270 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -492,10 +492,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>  {
>  	flags &= gfp_allowed_mask;
>  
> -	fs_reclaim_acquire(flags);
> -	fs_reclaim_release(flags);
> -
> -	might_sleep_if(gfpflags_allow_blocking(flags));
> +	might_alloc(flags);
>  
>  	if (should_failslab(s, flags))
>  		return NULL;
> diff --git a/mm/slob.c b/mm/slob.c
> index 7cc9805c8091..8d4bfa46247f 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -474,8 +474,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
>  
>  	gfp &= gfp_allowed_mask;
>  
> -	fs_reclaim_acquire(gfp);
> -	fs_reclaim_release(gfp);
> +	might_alloc(gfp);
>  
>  	if (size < PAGE_SIZE - minalign) {
>  		int align = minalign;
> @@ -597,8 +596,7 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
>  
>  	flags &= gfp_allowed_mask;
>  
> -	fs_reclaim_acquire(flags);
> -	fs_reclaim_release(flags);
> +	might_alloc(flags);
>  
>  	if (c->size < PAGE_SIZE) {
>  		b = slob_alloc(c->size, flags, c->align, node, 0);
> -- 
> 2.28.0
> 
