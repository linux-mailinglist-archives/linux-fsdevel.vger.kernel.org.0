Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20573474B39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhLNSwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 13:52:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57370 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhLNSwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:52:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71EBD616AA;
        Tue, 14 Dec 2021 18:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BE5C34600;
        Tue, 14 Dec 2021 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639507963;
        bh=sFcVPN5clyYdSF7gvMl35kJy4N9a/kuMi/inoGniR6s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S296IbuTXyiwW1YsjB3eLANjFVWRY0OCgTM6Y9QzNHIRLCRNt3KzYCKCt5/d5AeVb
         yPpYrZ0AwNIvNHjiZ7mbhZlYF24v7XEZhagWwpW6QUBIzeREmLEEtR7rdMMh9FuZ6W
         fCs1IoE7ziubMjM6Y/7as1DbZ0Ym1JhkpeEL/1QMef598xdCvR1Zmr6RO7r/ZluuLP
         TCnRASY08+0uWmw6STPiviM58m7cD7Ciy6COhKr4hYAM9RZ+HqGkaIjHIvBk+SAFh3
         wHJIFgA3gFS9+/FbemON3/jMrR9Toh0ErCqxTga1/3QG83q854dvRkEufyCO05s94n
         O7JJkRSRw28TQ==
Message-ID: <87e6960c660eaa883d6ee81c25449cf6fa3c9c19.camel@kernel.org>
Subject: Re: [PATCH v2 09/67] fscache: Implement volume registration
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
Date:   Tue, 14 Dec 2021 13:52:41 -0500
In-Reply-To: <163906890630.143852.13972180614535611154.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
         <163906890630.143852.13972180614535611154.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-12-09 at 16:55 +0000, David Howells wrote:
> Add functions to the fscache API to allow volumes to be acquired and
> relinquished by the network filesystem.  A volume is an index of data
> storage cache objects.  A volume is represented by a volume cookie in the
> API.  A filesystem would typically create a volume for a superblock and
> then create per-inode cookies within it.
> 
> To request a volume, the filesystem calls:
> 
> 	struct fscache_volume *
> 	fscache_acquire_volume(const char *volume_key,
> 			       const char *cache_name,
> 			       u64 coherency_data)
> 
> The volume_key is a printable string used to match the volume in the cache.
> It should not contain any '/' characters.  For AFS, for example, this would
> be "afs,<cellname>,<volume_id>", e.g. "afs,example.com,523001".
> 
> The cache_name can be NULL, but if not it should be a string indicating the
> name of the cache to use if there's more than one available.
> 
> The coherency data is a 64-bit integer that's attached to the volume and is
> compared when the volume is looked up.  If it doesn't match, the old volume
> is judged to be out of date and it and everything within it is discarded.
> 
> Acquiring a volume twice concurrently is disallowed, though the function
> will wait if an old volume cookie is being relinquishing.
> 
> 

Do we need the last two parameters to fscache_acquire_volume? I'll note
that all of the callers in the current set just pass "NULL, 0" for them.

> When a network filesystem has finished with a volume, it should return the
> volume cookie by calling:
> 
> 	void
> 	fscache_relinquish_volume(struct fscache_volume *volume,
> 				  u64 coherency_data,
> 				  bool invalidate)
> 
> If invalidate is true, the entire volume will be discarded; if false, the
> volume will be synced and the coherency_data will be set.
> 


Ditto here on the coherency data. That parameter is just ignored in the
final set. Maybe that part should go away, or do you have future plans
to do something with it?

> Changes
> =======
> ver #2:
>  - Fix error check[1].
>  - Make a fscache_acquire_volume() return errors, including EBUSY if a
>    conflicting volume cookie already exists.  No error is printed now -
>    that's left to the netfs.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/20211203095608.GC2480@kili/ [1]
> Link: https://lore.kernel.org/r/163819588944.215744.1629085755564865996.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  fs/fscache/Makefile            |    3 
>  fs/fscache/internal.h          |   14 ++
>  fs/fscache/proc.c              |    4 
>  fs/fscache/stats.c             |   12 +
>  fs/fscache/volume.c            |  341 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fscache.h        |   81 ++++++++++
>  include/trace/events/fscache.h |   61 +++++++
>  7 files changed, 514 insertions(+), 2 deletions(-)
>  create mode 100644 fs/fscache/volume.c
> 
> diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
> index d9fc22c18090..bb5282ae682f 100644
> --- a/fs/fscache/Makefile
> +++ b/fs/fscache/Makefile
> @@ -5,7 +5,8 @@
>  
>  fscache-y := \
>  	cache.o \
> -	main.o
> +	main.o \
> +	volume.o
>  
>  fscache-$(CONFIG_PROC_FS) += proc.o
>  fscache-$(CONFIG_FSCACHE_STATS) += stats.o
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index 2788435361f9..52d1b7934326 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -72,6 +72,9 @@ extern void fscache_proc_cleanup(void);
>   * stats.c
>   */
>  #ifdef CONFIG_FSCACHE_STATS
> +extern atomic_t fscache_n_volumes;
> +extern atomic_t fscache_n_volumes_collision;
> +extern atomic_t fscache_n_volumes_nomem;
>  
>  static inline void fscache_stat(atomic_t *stat)
>  {
> @@ -93,6 +96,17 @@ int fscache_stats_show(struct seq_file *m, void *v);
>  #define fscache_stat_d(stat) do {} while (0)
>  #endif
>  
> +/*
> + * volume.c
> + */
> +extern const struct seq_operations fscache_volumes_seq_ops;
> +
> +struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
> +					  enum fscache_volume_trace where);
> +void fscache_put_volume(struct fscache_volume *volume,
> +			enum fscache_volume_trace where);
> +void fscache_create_volume(struct fscache_volume *volume, bool wait);
> +
>  
>  /*****************************************************************************/
>  /*
> diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
> index 7400568bf85e..c6970d4a44f1 100644
> --- a/fs/fscache/proc.c
> +++ b/fs/fscache/proc.c
> @@ -23,6 +23,10 @@ int __init fscache_proc_init(void)
>  			     &fscache_caches_seq_ops))
>  		goto error;
>  
> +	if (!proc_create_seq("fs/fscache/volumes", S_IFREG | 0444, NULL,
> +			     &fscache_volumes_seq_ops))
> +		goto error;
> +
>  #ifdef CONFIG_FSCACHE_STATS
>  	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
>  				fscache_stats_show))
> diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
> index bd92f93e1680..b811a4d03585 100644
> --- a/fs/fscache/stats.c
> +++ b/fs/fscache/stats.c
> @@ -10,12 +10,24 @@
>  #include <linux/seq_file.h>
>  #include "internal.h"
>  
> +/*
> + * operation counters
> + */
> +atomic_t fscache_n_volumes;
> +atomic_t fscache_n_volumes_collision;
> +atomic_t fscache_n_volumes_nomem;
> +
>  /*
>   * display the general statistics
>   */
>  int fscache_stats_show(struct seq_file *m, void *v)
>  {
>  	seq_puts(m, "FS-Cache statistics\n");
> +	seq_printf(m, "Cookies: v=%d vcol=%u voom=%u\n",
> +		   atomic_read(&fscache_n_volumes),
> +		   atomic_read(&fscache_n_volumes_collision),
> +		   atomic_read(&fscache_n_volumes_nomem)
> +		   );
>  
>  	netfs_stats_show(m);
>  	return 0;
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> new file mode 100644
> index 000000000000..ab34a077b26a
> --- /dev/null
> +++ b/fs/fscache/volume.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Volume-level cache cookie handling.
> + *
> + * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define FSCACHE_DEBUG_LEVEL COOKIE
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +#define fscache_volume_hash_shift 10
> +static struct hlist_bl_head fscache_volume_hash[1 << fscache_volume_hash_shift];
> +static atomic_t fscache_volume_debug_id;
> +static LIST_HEAD(fscache_volumes);
> +
> +struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
> +					  enum fscache_volume_trace where)
> +{
> +	int ref;
> +
> +	__refcount_inc(&volume->ref, &ref);
> +	trace_fscache_volume(volume->debug_id, ref + 1, where);
> +	return volume;
> +}
> +
> +static void fscache_see_volume(struct fscache_volume *volume,
> +			       enum fscache_volume_trace where)
> +{
> +	int ref = refcount_read(&volume->ref);
> +
> +	trace_fscache_volume(volume->debug_id, ref, where);
> +}
> +
> +static long fscache_compare_volume(const struct fscache_volume *a,
> +				   const struct fscache_volume *b)
> +{
> +	size_t klen;
> +
> +	if (a->key_hash != b->key_hash)
> +		return (long)a->key_hash - (long)b->key_hash;
> +	if (a->cache != b->cache)
> +		return (long)a->cache    - (long)b->cache;
> +	if (a->key[0] != b->key[0])
> +		return (long)a->key[0]   - (long)b->key[0];
> +
> +	klen = round_up(a->key[0] + 1, sizeof(unsigned int));
> +	return memcmp(a->key, b->key, klen);
> +}
> +
> +static bool fscache_is_acquire_pending(struct fscache_volume *volume)
> +{
> +	return test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &volume->flags);
> +}
> +
> +static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
> +					     unsigned int collidee_debug_id)
> +{
> +	wait_var_event_timeout(&candidate->flags,
> +			       fscache_is_acquire_pending(candidate), 20 * HZ);
> +	if (!fscache_is_acquire_pending(candidate)) {
> +		pr_notice("Potential volume collision new=%08x old=%08x",
> +			  candidate->debug_id, collidee_debug_id);
> +		fscache_stat(&fscache_n_volumes_collision);
> +		wait_var_event(&candidate->flags, fscache_is_acquire_pending(candidate));
> +	}
> +}
> +
> +/*
> + * Attempt to insert the new volume into the hash.  If there's a collision, we
> + * wait for the old volume to complete if it's being relinquished and an error
> + * otherwise.
> + */
> +static bool fscache_hash_volume(struct fscache_volume *candidate)
> +{
> +	struct fscache_volume *cursor;
> +	struct hlist_bl_head *h;
> +	struct hlist_bl_node *p;
> +	unsigned int bucket, collidee_debug_id = 0;
> +
> +	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_volume_hash) - 1);
> +	h = &fscache_volume_hash[bucket];
> +
> +	hlist_bl_lock(h);
> +	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
> +		if (fscache_compare_volume(candidate, cursor) == 0) {
> +			if (!test_bit(FSCACHE_VOLUME_RELINQUISHED, &cursor->flags))
> +				goto collision;
> +			fscache_see_volume(cursor, fscache_volume_get_hash_collision);
> +			set_bit(FSCACHE_VOLUME_COLLIDED_WITH, &cursor->flags);
> +			set_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags);
> +			collidee_debug_id = cursor->debug_id;
> +			break;
> +		}
> +	}
> +
> +	hlist_bl_add_head(&candidate->hash_link, h);
> +	hlist_bl_unlock(h);
> +
> +	if (test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags))
> +		fscache_wait_on_volume_collision(candidate, collidee_debug_id);
> +	return true;
> +
> +collision:
> +	fscache_see_volume(cursor, fscache_volume_collision);
> +	hlist_bl_unlock(h);
> +	return false;
> +}
> +
> +/*
> + * Allocate and initialise a volume representation cookie.
> + */
> +static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
> +						   const char *cache_name,
> +						   u64 coherency_data)
> +{
> +	struct fscache_volume *volume;
> +	struct fscache_cache *cache;
> +	size_t klen, hlen;
> +	char *key;
> +
> +	cache = fscache_lookup_cache(cache_name, false);
> +	if (IS_ERR(cache))
> +		return NULL;
> +
> +	volume = kzalloc(sizeof(*volume), GFP_KERNEL);
> +	if (!volume)
> +		goto err_cache;
> +
> +	volume->cache = cache;
> +	volume->coherency = coherency_data;
> +	INIT_LIST_HEAD(&volume->proc_link);
> +	INIT_WORK(&volume->work, NULL /* PLACEHOLDER */);
> +	refcount_set(&volume->ref, 1);
> +	spin_lock_init(&volume->lock);
> +
> +	/* Stick the length on the front of the key and pad it out to make
> +	 * hashing easier.
> +	 */
> +	klen = strlen(volume_key);
> +	hlen = round_up(1 + klen + 1, sizeof(unsigned int));
> +	key = kzalloc(hlen, GFP_KERNEL);
> +	if (!key)
> +		goto err_vol;
> +	key[0] = klen;
> +	memcpy(key + 1, volume_key, klen);
> +
> +	volume->key = key;
> +	volume->key_hash = fscache_hash(0, (unsigned int *)key,
> +					hlen / sizeof(unsigned int));
> +
> +	volume->debug_id = atomic_inc_return(&fscache_volume_debug_id);
> +	down_write(&fscache_addremove_sem);
> +	atomic_inc(&cache->n_volumes);
> +	list_add_tail(&volume->proc_link, &fscache_volumes);
> +	fscache_see_volume(volume, fscache_volume_new_acquire);
> +	fscache_stat(&fscache_n_volumes);
> +	up_write(&fscache_addremove_sem);
> +	_leave(" = v=%x", volume->debug_id);
> +	return volume;
> +
> +err_vol:
> +	kfree(volume);
> +err_cache:
> +	fscache_put_cache(cache, fscache_cache_put_alloc_volume);
> +	fscache_stat(&fscache_n_volumes_nomem);
> +	return NULL;
> +}
> +
> +/*
> + * Acquire a volume representation cookie and link it to a (proposed) cache.
> + */
> +struct fscache_volume *__fscache_acquire_volume(const char *volume_key,
> +						const char *cache_name,
> +						u64 coherency_data)
> +{
> +	struct fscache_volume *volume;
> +
> +	volume = fscache_alloc_volume(volume_key, cache_name, coherency_data);
> +	if (!volume)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!fscache_hash_volume(volume)) {
> +		fscache_put_volume(volume, fscache_volume_put_hash_collision);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	// PLACEHOLDER: Create the volume if we have a cache available
> +	return volume;
> +}
> +EXPORT_SYMBOL(__fscache_acquire_volume);
> +
> +static void fscache_wake_pending_volume(struct fscache_volume *volume,
> +					struct hlist_bl_head *h)
> +{
> +	struct fscache_volume *cursor;
> +	struct hlist_bl_node *p;
> +
> +	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
> +		if (fscache_compare_volume(cursor, volume) == 0) {
> +			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
> +			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> +			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> +			return;
> +		}
> +	}
> +}
> +
> +/*
> + * Remove a volume cookie from the hash table.
> + */
> +static void fscache_unhash_volume(struct fscache_volume *volume)
> +{
> +	struct hlist_bl_head *h;
> +	unsigned int bucket;
> +
> +	bucket = volume->key_hash & (ARRAY_SIZE(fscache_volume_hash) - 1);
> +	h = &fscache_volume_hash[bucket];
> +
> +	hlist_bl_lock(h);
> +	hlist_bl_del(&volume->hash_link);
> +	if (test_bit(FSCACHE_VOLUME_COLLIDED_WITH, &volume->flags))
> +		fscache_wake_pending_volume(volume, h);
> +	hlist_bl_unlock(h);
> +}
> +
> +/*
> + * Drop a cache's volume attachments.
> + */
> +static void fscache_free_volume(struct fscache_volume *volume)
> +{
> +	struct fscache_cache *cache = volume->cache;
> +
> +	if (volume->cache_priv) {
> +		// PLACEHOLDER: Detach any attached cache
> +	}
> +
> +	down_write(&fscache_addremove_sem);
> +	list_del_init(&volume->proc_link);
> +	atomic_dec(&volume->cache->n_volumes);
> +	up_write(&fscache_addremove_sem);
> +
> +	if (!hlist_bl_unhashed(&volume->hash_link))
> +		fscache_unhash_volume(volume);
> +
> +	trace_fscache_volume(volume->debug_id, 0, fscache_volume_free);
> +	kfree(volume->key);
> +	kfree(volume);
> +	fscache_stat_d(&fscache_n_volumes);
> +	fscache_put_cache(cache, fscache_cache_put_volume);
> +}
> +
> +/*
> + * Drop a reference to a volume cookie.
> + */
> +void fscache_put_volume(struct fscache_volume *volume,
> +			enum fscache_volume_trace where)
> +{
> +	if (volume) {
> +		unsigned int debug_id = volume->debug_id;
> +		bool zero;
> +		int ref;
> +
> +		zero = __refcount_dec_and_test(&volume->ref, &ref);
> +		trace_fscache_volume(debug_id, ref - 1, where);
> +		if (zero)
> +			fscache_free_volume(volume);
> +	}
> +}
> +
> +/*
> + * Relinquish a volume representation cookie.
> + */
> +void __fscache_relinquish_volume(struct fscache_volume *volume,
> +				 u64 coherency_data,
> +				 bool invalidate)
> +{
> +	if (WARN_ON(test_and_set_bit(FSCACHE_VOLUME_RELINQUISHED, &volume->flags)))
> +		return;
> +
> +	if (invalidate)
> +		set_bit(FSCACHE_VOLUME_INVALIDATE, &volume->flags);
> +
> +	fscache_put_volume(volume, fscache_volume_put_relinquish);
> +}
> +EXPORT_SYMBOL(__fscache_relinquish_volume);
> +
> +#ifdef CONFIG_PROC_FS
> +/*
> + * Generate a list of volumes in /proc/fs/fscache/volumes
> + */
> +static int fscache_volumes_seq_show(struct seq_file *m, void *v)
> +{
> +	struct fscache_volume *volume;
> +
> +	if (v == &fscache_volumes) {
> +		seq_puts(m,
> +			 "VOLUME   REF   nCOOK ACC FL CACHE           KEY\n"
> +			 "======== ===== ===== === == =============== ================\n");
> +		return 0;
> +	}
> +
> +	volume = list_entry(v, struct fscache_volume, proc_link);
> +	seq_printf(m,
> +		   "%08x %5d %5d %3d %02lx %-15.15s %s\n",
> +		   volume->debug_id,
> +		   refcount_read(&volume->ref),
> +		   atomic_read(&volume->n_cookies),
> +		   atomic_read(&volume->n_accesses),
> +		   volume->flags,
> +		   volume->cache->name ?: "-",
> +		   volume->key + 1);
> +	return 0;
> +}
> +
> +static void *fscache_volumes_seq_start(struct seq_file *m, loff_t *_pos)
> +	__acquires(&fscache_addremove_sem)
> +{
> +	down_read(&fscache_addremove_sem);
> +	return seq_list_start_head(&fscache_volumes, *_pos);
> +}
> +
> +static void *fscache_volumes_seq_next(struct seq_file *m, void *v, loff_t *_pos)
> +{
> +	return seq_list_next(v, &fscache_volumes, _pos);
> +}
> +
> +static void fscache_volumes_seq_stop(struct seq_file *m, void *v)
> +	__releases(&fscache_addremove_sem)
> +{
> +	up_read(&fscache_addremove_sem);
> +}
> +
> +const struct seq_operations fscache_volumes_seq_ops = {
> +	.start  = fscache_volumes_seq_start,
> +	.next   = fscache_volumes_seq_next,
> +	.stop   = fscache_volumes_seq_stop,
> +	.show   = fscache_volumes_seq_show,
> +};
> +#endif /* CONFIG_PROC_FS */
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 1cf90c252aac..5958aeee7e53 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -20,13 +20,94 @@
>  #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
>  #define __fscache_available (1)
>  #define fscache_available() (1)
> +#define fscache_volume_valid(volume) (volume)
>  #define fscache_cookie_valid(cookie) (cookie)
>  #define fscache_cookie_enabled(cookie) (cookie)
>  #else
>  #define __fscache_available (0)
>  #define fscache_available() (0)
> +#define fscache_volume_valid(volume) (0)
>  #define fscache_cookie_valid(cookie) (0)
>  #define fscache_cookie_enabled(cookie) (0)
>  #endif
>  
> +/*
> + * Volume representation cookie.
> + */
> +struct fscache_volume {
> +	refcount_t			ref;
> +	atomic_t			n_cookies;	/* Number of data cookies in volume */
> +	atomic_t			n_accesses;	/* Number of cache accesses in progress */
> +	unsigned int			debug_id;
> +	unsigned int			key_hash;	/* Hash of key string */
> +	char				*key;		/* Volume ID, eg. "afs@example.com@1234" */
> +	struct list_head		proc_link;	/* Link in /proc/fs/fscache/volumes */
> +	struct hlist_bl_node		hash_link;	/* Link in hash table */
> +	struct work_struct		work;
> +	struct fscache_cache		*cache;		/* The cache in which this resides */
> +	void				*cache_priv;	/* Cache private data */
> +	u64				coherency;	/* Coherency data */
> +	spinlock_t			lock;
> +	unsigned long			flags;
> +#define FSCACHE_VOLUME_RELINQUISHED	0	/* Volume is being cleaned up */
> +#define FSCACHE_VOLUME_INVALIDATE	1	/* Volume was invalidated */
> +#define FSCACHE_VOLUME_COLLIDED_WITH	2	/* Volume was collided with */
> +#define FSCACHE_VOLUME_ACQUIRE_PENDING	3	/* Volume is waiting to complete acquisition */
> +#define FSCACHE_VOLUME_CREATING		4	/* Volume is being created on disk */
> +};
> +
> +/*
> + * slow-path functions for when there is actually caching available, and the
> + * netfs does actually have a valid token
> + * - these are not to be called directly
> + * - these are undefined symbols when FS-Cache is not configured and the
> + *   optimiser takes care of not using them
> + */
> +extern struct fscache_volume *__fscache_acquire_volume(const char *, const char *, u64);
> +extern void __fscache_relinquish_volume(struct fscache_volume *, u64, bool);
> +
> +/**
> + * fscache_acquire_volume - Register a volume as desiring caching services
> + * @volume_key: An identification string for the volume
> + * @cache_name: The name of the cache to use (or NULL for the default)
> + * @coherency_data: Piece of arbitrary coherency data to check
> + *
> + * Register a volume as desiring caching services if they're available.  The
> + * caller must provide an identifier for the volume and may also indicate which
> + * cache it should be in.  If a preexisting volume entry is found in the cache,
> + * the coherency data must match otherwise the entry will be invalidated.
> + *
> + * Returns a cookie pointer on success, -ENOMEM if out of memory or -EBUSY if a
> + * cache volume of that name is already acquired.  Note that "NULL" is a valid
> + * cookie pointer and can be returned if caching is refused.
> + */
> +static inline
> +struct fscache_volume *fscache_acquire_volume(const char *volume_key,
> +					      const char *cache_name,
> +					      u64 coherency_data)
> +{
> +	if (!fscache_available())
> +		return NULL;
> +	return __fscache_acquire_volume(volume_key, cache_name, coherency_data);
> +}
> +
> +/**
> + * fscache_relinquish_volume - Cease caching a volume
> + * @volume: The volume cookie
> + * @coherency_data: Piece of arbitrary coherency data to set
> + * @invalidate: True if the volume should be invalidated
> + *
> + * Indicate that a filesystem no longer desires caching services for a volume.
> + * The caller must have relinquished all file cookies prior to calling this.
> + * The coherency data stored is updated.
> + */
> +static inline
> +void fscache_relinquish_volume(struct fscache_volume *volume,
> +			       u64 coherency_data,
> +			       bool invalidate)
> +{
> +	if (fscache_volume_valid(volume))
> +		__fscache_relinquish_volume(volume, coherency_data, invalidate);
> +}
> +
>  #endif /* _LINUX_FSCACHE_H */
> diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
> index 3b8e0597b2c1..eeb3e7d88e20 100644
> --- a/include/trace/events/fscache.h
> +++ b/include/trace/events/fscache.h
> @@ -23,9 +23,26 @@ enum fscache_cache_trace {
>  	fscache_cache_collision,
>  	fscache_cache_get_acquire,
>  	fscache_cache_new_acquire,
> +	fscache_cache_put_alloc_volume,
>  	fscache_cache_put_cache,
>  	fscache_cache_put_prep_failed,
>  	fscache_cache_put_relinquish,
> +	fscache_cache_put_volume,
> +};
> +
> +enum fscache_volume_trace {
> +	fscache_volume_collision,
> +	fscache_volume_get_cookie,
> +	fscache_volume_get_create_work,
> +	fscache_volume_get_hash_collision,
> +	fscache_volume_free,
> +	fscache_volume_new_acquire,
> +	fscache_volume_put_cookie,
> +	fscache_volume_put_create_work,
> +	fscache_volume_put_hash_collision,
> +	fscache_volume_put_relinquish,
> +	fscache_volume_see_create_work,
> +	fscache_volume_see_hash_wake,
>  };
>  
>  #endif
> @@ -37,9 +54,25 @@ enum fscache_cache_trace {
>  	EM(fscache_cache_collision,		"*COLLIDE*")		\
>  	EM(fscache_cache_get_acquire,		"GET acq  ")		\
>  	EM(fscache_cache_new_acquire,		"NEW acq  ")		\
> +	EM(fscache_cache_put_alloc_volume,	"PUT alvol")		\
>  	EM(fscache_cache_put_cache,		"PUT cache")		\
>  	EM(fscache_cache_put_prep_failed,	"PUT pfail")		\
> -	E_(fscache_cache_put_relinquish,	"PUT relnq")
> +	EM(fscache_cache_put_relinquish,	"PUT relnq")		\
> +	E_(fscache_cache_put_volume,		"PUT vol  ")
> +
> +#define fscache_volume_traces						\
> +	EM(fscache_volume_collision,		"*COLLIDE*")		\
> +	EM(fscache_volume_get_cookie,		"GET cook ")		\
> +	EM(fscache_volume_get_create_work,	"GET creat")		\
> +	EM(fscache_volume_get_hash_collision,	"GET hcoll")		\
> +	EM(fscache_volume_free,			"FREE     ")		\
> +	EM(fscache_volume_new_acquire,		"NEW acq  ")		\
> +	EM(fscache_volume_put_cookie,		"PUT cook ")		\
> +	EM(fscache_volume_put_create_work,	"PUT creat")		\
> +	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
> +	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
> +	EM(fscache_volume_see_create_work,	"SEE creat")		\
> +	E_(fscache_volume_see_hash_wake,	"SEE hwake")
>  
>  /*
>   * Export enum symbols via userspace.
> @@ -50,6 +83,7 @@ enum fscache_cache_trace {
>  #define E_(a, b) TRACE_DEFINE_ENUM(a);
>  
>  fscache_cache_traces;
> +fscache_volume_traces;
>  
>  /*
>   * Now redefine the EM() and E_() macros to map the enums to the strings that
> @@ -86,6 +120,31 @@ TRACE_EVENT(fscache_cache,
>  		      __entry->usage)
>  	    );
>  
> +TRACE_EVENT(fscache_volume,
> +	    TP_PROTO(unsigned int volume_debug_id,
> +		     int usage,
> +		     enum fscache_volume_trace where),
> +
> +	    TP_ARGS(volume_debug_id, usage, where),
> +
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,		volume		)
> +		    __field(int,			usage		)
> +		    __field(enum fscache_volume_trace,	where		)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->volume	= volume_debug_id;
> +		    __entry->usage	= usage;
> +		    __entry->where	= where;
> +			   ),
> +
> +	    TP_printk("V=%08x %s u=%d",
> +		      __entry->volume,
> +		      __print_symbolic(__entry->where, fscache_volume_traces),
> +		      __entry->usage)
> +	    );
> +
>  #endif /* _TRACE_FSCACHE_H */
>  
>  /* This part must be outside protection */
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>
