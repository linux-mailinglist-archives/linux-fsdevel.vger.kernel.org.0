Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308BD47948D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhLQTHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 14:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhLQTHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:07:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824FC061574;
        Fri, 17 Dec 2021 11:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80CF6B827DF;
        Fri, 17 Dec 2021 19:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6DCC36AE2;
        Fri, 17 Dec 2021 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639768030;
        bh=pK1AOpDLW35YHNcat2B5ZQ3ZzjFzSEo0RkRTtgZvaus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gO+Gi8qORGyE+XcvH2fSlOsMGW0E7Dyt+jNsKVyI9qX3N47fDGonaWJuRMEsfzgHG
         XVBAFEHOvsFkNg2TFDam4bInyNiJTAdRcvvP9daEZhO+HF9x4AbZ0Sa7RWOD2kwAQB
         C6OSVV7Lk6qIc3i+tUDhUWBca1wE/D0T9UkduoBbcZZmJyfuf1VTNki5b2kq5dWy/h
         svnaSbMC/8oTaXhV4HdaDTejEdpPkZkhh/XRda3XHxsbeyvvW6td6ssSnk2seI9wR4
         41QHQ4QHgfrj9gE3aEapsRlgEixoFDMEwuMsuS2AznFQSIqjwT7TNoe5un1xpUZzoK
         A5WVxHzSw+OWA==
Message-ID: <71635415237b406c5fe9e568aae8dd148445a72b.camel@kernel.org>
Subject: Re: [PATCH v3 17/68] fscache: Implement simple cookie state machine
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 14:07:07 -0500
In-Reply-To: <163967105456.1823006.14730395299835841776.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
         <163967105456.1823006.14730395299835841776.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-12-16 at 16:10 +0000, David Howells wrote:
> Implement a very simple cookie state machine to handle lookup,
> invalidation, withdrawal, relinquishment and, to be added later, commit on
> LRU discard.
> 
> Three cache methods are provided: ->lookup_cookie() to look up and, if
> necessary, create a data storage object; ->withdraw_cookie() to free the
> resources associated with that object and potentially delete it; and
> ->prepare_to_write(), to do prepare for changes to the cached data to be
> modified locally.
> 
> Changes
> =======
> ver #3:
>  - Fix a race between LRU discard and relinquishment whereby the former
>    would override the latter and thus the latter would never happen[1].
> 
> ver #2:
>  - Don't hold n_accesses elevated whilst cache is bound to a cookie, but
>    rather add a flag that prevents the state machine from being queued when
>    n_accesses reaches 0.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/599331.1639410068@warthog.procyon.org.uk/ [1]
> Link: https://lore.kernel.org/r/163819599657.215744.15799615296912341745.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163906903925.143852.1805855338154353867.stgit@warthog.procyon.org.uk/ # v2
> ---
> 
>  fs/fscache/cookie.c            |  313 +++++++++++++++++++++++++++++++++++-----
>  include/linux/fscache-cache.h  |   27 +++
>  include/trace/events/fscache.h |    4 +
>  3 files changed, 300 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
> index 04d2127bd354..336046de08ee 100644
> --- a/fs/fscache/cookie.c
> +++ b/fs/fscache/cookie.c
> @@ -15,7 +15,8 @@
>  
>  struct kmem_cache *fscache_cookie_jar;
>  
> -static void fscache_drop_cookie(struct fscache_cookie *cookie);
> +static void fscache_cookie_worker(struct work_struct *work);
> +static void fscache_unhash_cookie(struct fscache_cookie *cookie);
>  
>  #define fscache_cookie_hash_shift 15
>  static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
> @@ -62,6 +63,19 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
>  	kmem_cache_free(fscache_cookie_jar, cookie);
>  }
>  
> +static void __fscache_queue_cookie(struct fscache_cookie *cookie)
> +{
> +	if (!queue_work(fscache_wq, &cookie->work))
> +		fscache_put_cookie(cookie, fscache_cookie_put_over_queued);
> +}
> +
> +static void fscache_queue_cookie(struct fscache_cookie *cookie,
> +				 enum fscache_cookie_trace where)
> +{
> +	fscache_get_cookie(cookie, where);
> +	__fscache_queue_cookie(cookie);
> +}
> +
>  /*
>   * Initialise the access gate on a cookie by setting a flag to prevent the
>   * state machine from being queued when the access counter transitions to 0.
> @@ -98,9 +112,8 @@ void fscache_end_cookie_access(struct fscache_cookie *cookie,
>  	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
>  			     n_accesses, why);
>  	if (n_accesses == 0 &&
> -	    !test_bit(FSCACHE_COOKIE_NO_ACCESS_WAKE, &cookie->flags)) {
> -		// PLACEHOLDER: Need to poke the state machine
> -	}
> +	    !test_bit(FSCACHE_COOKIE_NO_ACCESS_WAKE, &cookie->flags))
> +		fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
>  }
>  EXPORT_SYMBOL(fscache_end_cookie_access);
>  
> @@ -171,35 +184,58 @@ static inline void wake_up_cookie_state(struct fscache_cookie *cookie)
>  	wake_up_var(&cookie->state);
>  }
>  
> +/*
> + * Change the state a cookie is at and wake up anyone waiting for that.  Impose
> + * an ordering between the stuff stored in the cookie and the state member.
> + * Paired with fscache_cookie_state().
> + */
>  static void __fscache_set_cookie_state(struct fscache_cookie *cookie,
>  				       enum fscache_cookie_state state)
>  {
> -	cookie->state = state;
> +	smp_store_release(&cookie->state, state);
>  }
>  
> -/*
> - * Change the state a cookie is at and wake up anyone waiting for that - but
> - * only if the cookie isn't already marked as being in a cleanup state.
> - */
> -void fscache_set_cookie_state(struct fscache_cookie *cookie,
> -			      enum fscache_cookie_state state)
> +static void fscache_set_cookie_state(struct fscache_cookie *cookie,
> +				     enum fscache_cookie_state state)
>  {
> -	bool changed = false;
> -
>  	spin_lock(&cookie->lock);
> -	switch (cookie->state) {
> -	case FSCACHE_COOKIE_STATE_RELINQUISHING:
> -		break;
> -	default:
> -		__fscache_set_cookie_state(cookie, state);
> -		changed = true;
> -		break;
> -	}
> +	__fscache_set_cookie_state(cookie, state);
>  	spin_unlock(&cookie->lock);
> -	if (changed)
> -		wake_up_cookie_state(cookie);
> +	wake_up_cookie_state(cookie);
> +}
> +
> +/**
> + * fscache_cookie_lookup_negative - Note negative lookup
> + * @cookie: The cookie that was being looked up
> + *
> + * Note that some part of the metadata path in the cache doesn't exist and so
> + * we can release any waiting readers in the certain knowledge that there's
> + * nothing for them to actually read.
> + *
> + * This function uses no locking and must only be called from the state machine.
> + */
> +void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
> +{
> +	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> +	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_CREATING);
> +}
> +EXPORT_SYMBOL(fscache_cookie_lookup_negative);
> +
> +/**
> + * fscache_caching_failed - Report that a failure stopped caching on a cookie
> + * @cookie: The cookie that was affected
> + *
> + * Tell fscache that caching on a cookie needs to be stopped due to some sort
> + * of failure.
> + *
> + * This function uses no locking and must only be called from the state machine.
> + */
> +void fscache_caching_failed(struct fscache_cookie *cookie)
> +{
> +	clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
> +	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_FAILED);
>  }
> -EXPORT_SYMBOL(fscache_set_cookie_state);
> +EXPORT_SYMBOL(fscache_caching_failed);
>  
>  /*
>   * Set the index key in a cookie.  The cookie struct has space for a 16-byte
> @@ -291,10 +327,10 @@ static struct fscache_cookie *fscache_alloc_cookie(
>  
>  	refcount_set(&cookie->ref, 1);
>  	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
> -	cookie->state = FSCACHE_COOKIE_STATE_QUIESCENT;
>  	spin_lock_init(&cookie->lock);
>  	INIT_LIST_HEAD(&cookie->commit_link);
> -	INIT_WORK(&cookie->work, NULL /* PLACEHOLDER */);
> +	INIT_WORK(&cookie->work, fscache_cookie_worker);
> +	__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
>  
>  	write_lock(&fscache_cookies_lock);
>  	list_add_tail(&cookie->proc_link, &fscache_cookies);
> @@ -417,6 +453,192 @@ struct fscache_cookie *__fscache_acquire_cookie(
>  }
>  EXPORT_SYMBOL(__fscache_acquire_cookie);
>  
> +/*
> + * Prepare a cache object to be written to.
> + */
> +static void fscache_prepare_to_write(struct fscache_cookie *cookie)
> +{
> +	cookie->volume->cache->ops->prepare_to_write(cookie);
> +}
> +
> +/*
> + * Look up a cookie in the cache.
> + */
> +static void fscache_perform_lookup(struct fscache_cookie *cookie)
> +{
> +	enum fscache_access_trace trace = fscache_access_lookup_cookie_end_failed;
> +	bool need_withdraw = false;
> +
> +	_enter("");
> +
> +	if (!cookie->volume->cache_priv) {
> +		fscache_create_volume(cookie->volume, true);
> +		if (!cookie->volume->cache_priv) {
> +			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
> +			goto out;
> +		}
> +	}
> +
> +	if (!cookie->volume->cache->ops->lookup_cookie(cookie)) {
> +		if (cookie->state != FSCACHE_COOKIE_STATE_FAILED)
> +			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
> +		need_withdraw = true;
> +		_leave(" [fail]");
> +		goto out;
> +	}
> +
> +	fscache_see_cookie(cookie, fscache_cookie_see_active);
> +	fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_ACTIVE);
> +	trace = fscache_access_lookup_cookie_end;
> +
> +out:
> +	fscache_end_cookie_access(cookie, trace);
> +	if (need_withdraw)
> +		fscache_withdraw_cookie(cookie);
> +	fscache_end_volume_access(cookie->volume, cookie, trace);
> +}
> +
> +/*
> + * Perform work upon the cookie, such as committing its cache state,
> + * relinquishing it or withdrawing the backing cache.  We're protected from the
> + * cache going away under us as object withdrawal must come through this
> + * non-reentrant work item.
> + */
> +static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
> +{
> +	enum fscache_cookie_state state;
> +	bool wake = false;
> +
> +	_enter("c=%x", cookie->debug_id);
> +
> +again:
> +	spin_lock(&cookie->lock);
> +again_locked:
> +	state = cookie->state;
> +	switch (state) {
> +	case FSCACHE_COOKIE_STATE_QUIESCENT:
> +		/* The QUIESCENT state is jumped to the LOOKING_UP state by
> +		 * fscache_use_cookie().
> +		 */
> +
> +		if (atomic_read(&cookie->n_accesses) == 0 &&
> +		    test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags)) {
> +			__fscache_set_cookie_state(cookie,
> +						   FSCACHE_COOKIE_STATE_RELINQUISHING);
> +			wake = true;
> +			goto again_locked;
> +		}
> +		break;
> +
> +	case FSCACHE_COOKIE_STATE_LOOKING_UP:
> +		spin_unlock(&cookie->lock);
> +		fscache_init_access_gate(cookie);
> +		fscache_perform_lookup(cookie);
> +		goto again;
> +
> +	case FSCACHE_COOKIE_STATE_ACTIVE:
> +		if (test_and_clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags)) {
> +			spin_unlock(&cookie->lock);
> +			fscache_prepare_to_write(cookie);
> +			spin_lock(&cookie->lock);
> +		}
> +		fallthrough;
> +
> +	case FSCACHE_COOKIE_STATE_FAILED:
> +		if (atomic_read(&cookie->n_accesses) != 0)
> +			break;
> +		if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags)) {
> +			__fscache_set_cookie_state(cookie,
> +						   FSCACHE_COOKIE_STATE_RELINQUISHING);
> +			wake = true;
> +			goto again_locked;
> +		}
> +		if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags)) {
> +			__fscache_set_cookie_state(cookie,
> +						   FSCACHE_COOKIE_STATE_WITHDRAWING);
> +			wake = true;
> +			goto again_locked;
> +		}
> +		break;
> +
> +	case FSCACHE_COOKIE_STATE_RELINQUISHING:
> +	case FSCACHE_COOKIE_STATE_WITHDRAWING:
> +		if (cookie->cache_priv) {
> +			spin_unlock(&cookie->lock);
> +			cookie->volume->cache->ops->withdraw_cookie(cookie);
> +			spin_lock(&cookie->lock);
> +		}
> +
> +		switch (state) {
> +		case FSCACHE_COOKIE_STATE_RELINQUISHING:
> +			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
> +			fscache_unhash_cookie(cookie);
> +			__fscache_set_cookie_state(cookie,
> +						   FSCACHE_COOKIE_STATE_DROPPED);
> +			wake = true;
> +			goto out;
> +		case FSCACHE_COOKIE_STATE_WITHDRAWING:
> +			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
> +			break;
> +		default:
> +			BUG();
> +		}
> +

Ugh, the nested switch here is a bit hard to follow. It makes it seem
like the state could change due to the withdraw_cookie and you're
checking it again, but it doesn't do that.

This would be clearer if you just duplicated the withdraw_cookie stanza
for both states and moved the stuff below here to a helper or to a new
goto block.

> +		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
> +		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
> +		clear_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
> +		clear_bit(FSCACHE_COOKIE_DO_PREP_TO_WRITE, &cookie->flags);
> +		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> +		__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
> +		wake = true;
> +		goto again_locked;
> +
> +	case FSCACHE_COOKIE_STATE_DROPPED:
> +		break;
> +
> +	default:
> +		WARN_ONCE(1, "Cookie %x in unexpected state %u\n",
> +			  cookie->debug_id, state);
> +		break;
> +	}
> +
> +out:
> +	spin_unlock(&cookie->lock);
> +	if (wake)
> +		wake_up_cookie_state(cookie);
> +	_leave("");
> +}
> +
> +static void fscache_cookie_worker(struct work_struct *work)
> +{
> +	struct fscache_cookie *cookie = container_of(work, struct fscache_cookie, work);
> +
> +	fscache_see_cookie(cookie, fscache_cookie_see_work);
> +	fscache_cookie_state_machine(cookie);
> +	fscache_put_cookie(cookie, fscache_cookie_put_work);
> +}
> +
> +/*
> + * Wait for the object to become inactive.  The cookie's work item will be
> + * scheduled when someone transitions n_accesses to 0 - but if someone's
> + * already done that, schedule it anyway.
> + */
> +static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
> +{
> +	int n_accesses;
> +	bool unpinned;
> +
> +	unpinned = test_and_clear_bit(FSCACHE_COOKIE_NO_ACCESS_WAKE, &cookie->flags);
> +
> +	/* Need to read the access count after unpinning */
> +	n_accesses = atomic_read(&cookie->n_accesses);
> +	if (unpinned)
> +		trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
> +				     n_accesses, fscache_access_cache_unpin);
> +	if (n_accesses == 0)
> +		fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
> +}
> +
>  /*
>   * Remove a cookie from the hash table.
>   */
> @@ -432,21 +654,27 @@ static void fscache_unhash_cookie(struct fscache_cookie *cookie)
>  	hlist_bl_del(&cookie->hash_link);
>  	clear_bit(FSCACHE_COOKIE_IS_HASHED, &cookie->flags);
>  	hlist_bl_unlock(h);
> +	fscache_stat(&fscache_n_relinquishes_dropped);
>  }
>  
> -/*
> - * Finalise a cookie after all its resources have been disposed of.
> - */
> -static void fscache_drop_cookie(struct fscache_cookie *cookie)
> +static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
>  {
> -	spin_lock(&cookie->lock);
> -	__fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_DROPPED);
> -	spin_unlock(&cookie->lock);
> -	wake_up_cookie_state(cookie);
> +	__fscache_withdraw_cookie(cookie);
> +}
>  
> -	fscache_unhash_cookie(cookie);
> -	fscache_stat(&fscache_n_relinquishes_dropped);
> +/**
> + * fscache_withdraw_cookie - Mark a cookie for withdrawal
> + * @cookie: The cookie to be withdrawn.
> + *
> + * Allow the cache backend to withdraw the backing for a cookie for its own
> + * reasons, even if that cookie is in active use.
> + */
> +void fscache_withdraw_cookie(struct fscache_cookie *cookie)
> +{
> +	set_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
> +	fscache_drop_withdraw_cookie(cookie);
>  }
> +EXPORT_SYMBOL(fscache_withdraw_cookie);
>  
>  /*
>   * Allow the netfs to release a cookie back to the cache.
> @@ -473,12 +701,13 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
>  	ASSERTCMP(atomic_read(&cookie->volume->n_cookies), >, 0);
>  	atomic_dec(&cookie->volume->n_cookies);
>  
> -	set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
> -
> -	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags))
> -		; // PLACEHOLDER: Do something here if the cookie was cached
> -	else
> -		fscache_drop_cookie(cookie);
> +	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags)) {
> +		set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
> +		fscache_drop_withdraw_cookie(cookie);
> +	} else {
> +		fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_DROPPED);
> +		fscache_unhash_cookie(cookie);
> +	}
>  	fscache_put_cookie(cookie, fscache_cookie_put_relinquish);
>  }
>  EXPORT_SYMBOL(__fscache_relinquish_cookie);
> diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
> index 936ef731bbc7..ae6a75976450 100644
> --- a/include/linux/fscache-cache.h
> +++ b/include/linux/fscache-cache.h
> @@ -57,6 +57,15 @@ struct fscache_cache_ops {
>  
>  	/* Free the cache's data attached to a volume */
>  	void (*free_volume)(struct fscache_volume *volume);
> +
> +	/* Look up a cookie in the cache */
> +	bool (*lookup_cookie)(struct fscache_cookie *cookie);
> +
> +	/* Withdraw an object without any cookie access counts held */
> +	void (*withdraw_cookie)(struct fscache_cookie *cookie);
> +
> +	/* Prepare to write to a live cache object */
> +	void (*prepare_to_write)(struct fscache_cookie *cookie);
>  };
>  
>  extern struct workqueue_struct *fscache_wq;
> @@ -72,6 +81,7 @@ extern int fscache_add_cache(struct fscache_cache *cache,
>  			     void *cache_priv);
>  extern void fscache_withdraw_cache(struct fscache_cache *cache);
>  extern void fscache_withdraw_volume(struct fscache_volume *volume);
> +extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
>  
>  extern void fscache_io_error(struct fscache_cache *cache);
>  
> @@ -85,8 +95,21 @@ extern void fscache_put_cookie(struct fscache_cookie *cookie,
>  			       enum fscache_cookie_trace where);
>  extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
>  				      enum fscache_access_trace why);
> -extern void fscache_set_cookie_state(struct fscache_cookie *cookie,
> -				     enum fscache_cookie_state state);
> +extern void fscache_cookie_lookup_negative(struct fscache_cookie *cookie);
> +extern void fscache_caching_failed(struct fscache_cookie *cookie);
> +
> +/**
> + * fscache_cookie_state - Read the state of a cookie
> + * @cookie: The cookie to query
> + *
> + * Get the state of a cookie, imposing an ordering between the cookie contents
> + * and the state value.  Paired with fscache_set_cookie_state().
> + */
> +static inline
> +enum fscache_cookie_state fscache_cookie_state(struct fscache_cookie *cookie)
> +{
> +	return smp_load_acquire(&cookie->state);
> +}
>  
>  /**
>   * fscache_get_key - Get a pointer to the cookie key
> diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
> index 1d576bd8112e..030c97bb9c8b 100644
> --- a/include/trace/events/fscache.h
> +++ b/include/trace/events/fscache.h
> @@ -68,6 +68,8 @@ enum fscache_access_trace {
>  	fscache_access_acquire_volume_end,
>  	fscache_access_cache_pin,
>  	fscache_access_cache_unpin,
> +	fscache_access_lookup_cookie_end,
> +	fscache_access_lookup_cookie_end_failed,
>  	fscache_access_relinquish_volume,
>  	fscache_access_relinquish_volume_end,
>  	fscache_access_unlive,
> @@ -124,6 +126,8 @@ enum fscache_access_trace {
>  	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
>  	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
>  	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
> +	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
> +	EM(fscache_access_lookup_cookie_end_failed,"END   lookupf")	\
>  	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
>  	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\
>  	E_(fscache_access_unlive,		"END   unlive ")
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
