Return-Path: <linux-fsdevel+bounces-5093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9637F807FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 05:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EDA1F20FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3A1400F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJovVp0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54DEA3;
	Wed,  6 Dec 2023 20:16:56 -0800 (PST)
Date: Wed, 6 Dec 2023 23:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701922614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNe/f5rAqesLPfJC2GbJ9GN0ksK5lZDul4OlDPlZJWI=;
	b=jJovVp0PMthG0Fxd+36NA6aiVeZ0cUop/mARCXienhJod0P8rjipoXIV3vyPsRwR++Hltt
	KZos0d6bAQlhsYSXLnBC8LyY4chkQWLGfLDZHfGVIbBecpWDyhIu9oyZGDpWDN25rl6KDv
	9810V143X27MqeRBM+FMKQqyc6/x2t4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] list_bl: don't use bit locks for PREEMPT_RT or
 lockdep
Message-ID: <20231207041650.3tzzmv2jfrr5vppl@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-11-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-11-david@fromorbit.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 06, 2023 at 05:05:39PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> hash-bl nests spinlocks inside the bit locks. This causes problems
> for CONFIG_PREEMPT_RT which converts spin locks to sleeping locks,
> and we're not allowed to sleep while holding a spinning lock.
> 
> Further, lockdep does not support bit locks, so we lose lockdep
> coverage of the inode hash table with the hash-bl conversion.
> 
> To enable these configs to work, add an external per-chain spinlock
> to the hlist_bl_head() and add helpers to use this instead of the
> bit spinlock when preempt_rt or lockdep are enabled.
> 
> This converts all users of hlist-bl to use the external spinlock in
> these situations, so we also gain lockdep coverage of things like
> the dentry cache hash table with this change.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Sleepable bit locks can be done with wait_on_bit(), is that worth
considering for PREEMPT_RT? Or are the other features of real locks
important there?

(not a request for the current patchset, just perhaps a note for future
work)

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  include/linux/list_bl.h    | 126 ++++++++++++++++++++++++++++---------
>  include/linux/rculist_bl.h |  13 ++++
>  2 files changed, 110 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> index 8ee2bf5af131..990ad8e24e0b 100644
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -4,14 +4,27 @@
>  
>  #include <linux/list.h>
>  #include <linux/bit_spinlock.h>
> +#include <linux/spinlock.h>
>  
>  /*
>   * Special version of lists, where head of the list has a lock in the lowest
>   * bit. This is useful for scalable hash tables without increasing memory
>   * footprint overhead.
>   *
> - * For modification operations, the 0 bit of hlist_bl_head->first
> - * pointer must be set.
> + * Whilst the general use of bit spin locking is considered safe, PREEMPT_RT
> + * introduces a problem with nesting spin locks inside bit locks: spin locks
> + * become sleeping locks, and we can't sleep inside spinning locks such as bit
> + * locks. However, for RTPREEMPT, performance is less of an issue than
> + * correctness, so we trade off the memory and cache footprint of a spinlock per
> + * list so the list locks are converted to sleeping locks and work correctly
> + * with PREEMPT_RT kernels.
> + *
> + * An added advantage of this is that we can use the same trick when lockdep is
> + * enabled (again, performance doesn't matter) and gain lockdep coverage of all
> + * the hash-bl operations.
> + *
> + * For modification operations when using pure bit locking, the 0 bit of
> + * hlist_bl_head->first pointer must be set.
>   *
>   * With some small modifications, this can easily be adapted to store several
>   * arbitrary bits (not just a single lock bit), if the need arises to store
> @@ -30,16 +43,21 @@
>  #define LIST_BL_BUG_ON(x)
>  #endif
>  
> +#undef LIST_BL_USE_SPINLOCKS
> +#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_LOCKDEP)
> +#define LIST_BL_USE_SPINLOCKS	1
> +#endif
>  
>  struct hlist_bl_head {
>  	struct hlist_bl_node *first;
> +#ifdef LIST_BL_USE_SPINLOCKS
> +	spinlock_t lock;
> +#endif
>  };
>  
>  struct hlist_bl_node {
>  	struct hlist_bl_node *next, **pprev;
>  };
> -#define INIT_HLIST_BL_HEAD(ptr) \
> -	((ptr)->first = NULL)
>  
>  static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
>  {
> @@ -54,6 +72,69 @@ static inline bool  hlist_bl_unhashed(const struct hlist_bl_node *h)
>  	return !h->pprev;
>  }
>  
> +#ifdef LIST_BL_USE_SPINLOCKS
> +#define INIT_HLIST_BL_HEAD(ptr) do { \
> +	(ptr)->first = NULL; \
> +	spin_lock_init(&(ptr)->lock); \
> +} while (0)
> +
> +static inline void hlist_bl_lock(struct hlist_bl_head *b)
> +{
> +	spin_lock(&b->lock);
> +}
> +
> +static inline void hlist_bl_unlock(struct hlist_bl_head *b)
> +{
> +	spin_unlock(&b->lock);
> +}
> +
> +static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
> +{
> +	return spin_is_locked(&b->lock);
> +}
> +
> +static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
> +{
> +	return h->first;
> +}
> +
> +static inline void hlist_bl_set_first(struct hlist_bl_head *h,
> +					struct hlist_bl_node *n)
> +{
> +	h->first = n;
> +}
> +
> +static inline void hlist_bl_set_before(struct hlist_bl_node **pprev,
> +					struct hlist_bl_node *n)
> +{
> +	WRITE_ONCE(*pprev, n);
> +}
> +
> +static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
> +{
> +	return !READ_ONCE(h->first);
> +}
> +
> +#else /* !LIST_BL_USE_SPINLOCKS */
> +
> +#define INIT_HLIST_BL_HEAD(ptr) \
> +	((ptr)->first = NULL)
> +
> +static inline void hlist_bl_lock(struct hlist_bl_head *b)
> +{
> +	bit_spin_lock(0, (unsigned long *)b);
> +}
> +
> +static inline void hlist_bl_unlock(struct hlist_bl_head *b)
> +{
> +	__bit_spin_unlock(0, (unsigned long *)b);
> +}
> +
> +static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
> +{
> +	return bit_spin_is_locked(0, (unsigned long *)b);
> +}
> +
>  static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
>  {
>  	return (struct hlist_bl_node *)
> @@ -69,11 +150,21 @@ static inline void hlist_bl_set_first(struct hlist_bl_head *h,
>  	h->first = (struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK);
>  }
>  
> +static inline void hlist_bl_set_before(struct hlist_bl_node **pprev,
> +					struct hlist_bl_node *n)
> +{
> +	WRITE_ONCE(*pprev,
> +		   (struct hlist_bl_node *)
> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> +}
> +
>  static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
>  {
>  	return !((unsigned long)READ_ONCE(h->first) & ~LIST_BL_LOCKMASK);
>  }
>  
> +#endif /* LIST_BL_USE_SPINLOCKS */
> +
>  static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>  					struct hlist_bl_head *h)
>  {
> @@ -94,11 +185,7 @@ static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>  	n->pprev = pprev;
>  	n->next = next;
>  	next->pprev = &n->next;
> -
> -	/* pprev may be `first`, so be careful not to lose the lock bit */
> -	WRITE_ONCE(*pprev,
> -		   (struct hlist_bl_node *)
> -			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> +	hlist_bl_set_before(pprev, n);
>  }
>  
>  static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> @@ -119,11 +206,7 @@ static inline void __hlist_bl_del(struct hlist_bl_node *n)
>  
>  	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
>  
> -	/* pprev may be `first`, so be careful not to lose the lock bit */
> -	WRITE_ONCE(*pprev,
> -		   (struct hlist_bl_node *)
> -			((unsigned long)next |
> -			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
> +	hlist_bl_set_before(pprev, next);
>  	if (next)
>  		next->pprev = pprev;
>  }
> @@ -165,21 +248,6 @@ static inline bool hlist_bl_fake(struct hlist_bl_node *n)
>  	return n->pprev == &n->next;
>  }
>  
> -static inline void hlist_bl_lock(struct hlist_bl_head *b)
> -{
> -	bit_spin_lock(0, (unsigned long *)b);
> -}
> -
> -static inline void hlist_bl_unlock(struct hlist_bl_head *b)
> -{
> -	__bit_spin_unlock(0, (unsigned long *)b);
> -}
> -
> -static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
> -{
> -	return bit_spin_is_locked(0, (unsigned long *)b);
> -}
> -
>  /**
>   * hlist_bl_for_each_entry	- iterate over list of given type
>   * @tpos:	the type * to use as a loop cursor.
> diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
> index 0b952d06eb0b..2d5eb5153121 100644
> --- a/include/linux/rculist_bl.h
> +++ b/include/linux/rculist_bl.h
> @@ -8,6 +8,18 @@
>  #include <linux/list_bl.h>
>  #include <linux/rcupdate.h>
>  
> +#ifdef LIST_BL_USE_SPINLOCKS
> +static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
> +					struct hlist_bl_node *n)
> +{
> +	rcu_assign_pointer(h->first, n);
> +}
> +
> +static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
> +{
> +	return rcu_dereference_check(h->first, hlist_bl_is_locked(h));
> +}
> +#else /* !LIST_BL_USE_SPINLOCKS */
>  static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
>  					struct hlist_bl_node *n)
>  {
> @@ -23,6 +35,7 @@ static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
>  	return (struct hlist_bl_node *)
>  		((unsigned long)rcu_dereference_check(h->first, hlist_bl_is_locked(h)) & ~LIST_BL_LOCKMASK);
>  }
> +#endif /* LIST_BL_USE_SPINLOCKS */
>  
>  /**
>   * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
> -- 
> 2.42.0
> 

