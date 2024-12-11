Return-Path: <linux-fsdevel+bounces-37025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C49EC6AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5CF160196
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A71D31A5;
	Wed, 11 Dec 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/8HjU3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6F78F40
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904800; cv=none; b=GMdYr+oxyHB8M3XwYePvoVbtxUp826WqCgu3aUu6ZqNICbEH8RaXBRejgGiNnytZ2VckBfM60R0G0oJgaOtylhJPdE5TLQrEfm625Buv0L1S9Fm7cFpMwOojMdcgWt3DbpV2W4NiUvB7R/YhXWIw1seMKH7D/F5pk2YGWFErNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904800; c=relaxed/simple;
	bh=oHBztPoI1R0vAbZOAQMDeszyWcVtHI/jVmuHQulYpPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlTmyZIofzC2ZnZybFG2bxcv4SyIMLjL6GGnPl2HSrHXsyWR/Qgw33SzclCWmto1ptXZLCVQloXfz7SKebYPBpc++tHbQHCYLEYGJg7elmKOxoo1vRO5RNvzPumUxa7lZ8SQktO0wNI3TtQ2la8K4/2J8ksvWZ7bhsgKAZixtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/8HjU3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAE2C4CED2;
	Wed, 11 Dec 2024 08:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733904800;
	bh=oHBztPoI1R0vAbZOAQMDeszyWcVtHI/jVmuHQulYpPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/8HjU3anf6LkKL5PJQ6QUZgxXQOPk9nJfvtlFHrBeFhXlfBjrX26qK7MQCDqC3Ue
	 iBpjzoP8zE1/6iemkbbaudeaks6n1j8Rg2rgJrC/qFZdL6Q+pq/rBfILVGC/DY1Ki1
	 8ry6htQ2qgxBg9cz7BV0BuIkjwVLTJ9w1/wlZFgPxRwn3/cLQeG4H4ngDsFHWYwqvp
	 Cbg41ZpHacnst0d0KbG//9fYqjNbqJ/6SyhyMlPqs0jcWg6QRuk2PTOO+h6+ojeQoM
	 qCzYZ9vuuHMZdtdGDS3dFHtR0p4yvY4a08Nix68qTrE9T31je66o4qw++nnrVJGej3
	 HbTpDj7UI4TrQ==
Date: Wed, 11 Dec 2024 09:13:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: lockless mntns rbtree lookup
Message-ID: <20241211-agieren-leiblich-3b6f866f27bf@brauner>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
 <20241210-work-mount-rbtree-lockless-v1-3-338366b9bbe4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210-work-mount-rbtree-lockless-v1-3-338366b9bbe4@kernel.org>

Hey Peter,

I had a question for you and meant to Cc you but forgot. This makes one
of our rbtree uses lockless using the seqlock pattern. See below.

I saw that in 50a38035ed5c ("rbtree: provide rb_find_rcu() /
rb_find_add_rcu()") you added new _rcu() variants.

We're using another search function that allows us to walk the tree in
either direction:

        guard(read_lock)(&mnt_ns_tree_lock);
        for (;;) {
                struct rb_node *node;

                if (previous)
                        node = rb_prev(&mntns->mnt_ns_tree_node);
                else
                        node = rb_next(&mntns->mnt_ns_tree_node);
                if (!node)
                        return ERR_PTR(-ENOENT);

                mntns = node_to_mnt_ns(node);
                node = &mntns->mnt_ns_tree_node;

But afaict neither rb_prev() nor rb_next() are rcu safe. Have you ever
considered adding rcu safe variants for those two as well?

Thanks!
Christian

On Tue, Dec 10, 2024 at 09:57:59PM +0100, Christian Brauner wrote:
> Currently we use a read-write lock but for the simple search case we can
> make this lockless. Creating a new mount namespace is a rather rare
> event compared with querying mounts in a foreign mount namespace. Once
> this is picked up by e.g., systemd to list mounts in another mount in
> it's isolated services or in containers this will be used a lot so this
> seems worthwhile doing.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/mount.h     |  5 ++-
>  fs/namespace.c | 99 ++++++++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 73 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13338f8185fe818051444d540cbd5b..3c3763d8ae821d6a117c528808dbc94d0251f964 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -16,7 +16,10 @@ struct mnt_namespace {
>  	u64 event;
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
> -	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> +	union {
> +		struct rb_node	mnt_ns_tree_node; /* node in the mnt_ns_tree */
> +		struct rcu_head mnt_ns_rcu;
> +	};
>  	refcount_t		passive; /* number references not pinning @mounts */
>  } __randomize_layout;
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..21e990482c5b2e1844d17413b55b58803fa7b008 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -79,6 +79,8 @@ static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static DEFINE_RWLOCK(mnt_ns_tree_lock);
> +static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
> +
>  static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
>  
>  struct mount_kattr {
> @@ -105,17 +107,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
>   */
>  __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
>  
> -static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> -{
> -	u64 seq_b = ns->seq;
> -
> -	if (seq < seq_b)
> -		return -1;
> -	if (seq > seq_b)
> -		return 1;
> -	return 0;
> -}
> -
>  static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  {
>  	if (!node)
> @@ -123,19 +114,41 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
>  }
>  
> -static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> +static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
>  {
>  	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
>  	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
>  	u64 seq_a = ns_a->seq;
> +	u64 seq_b = ns_b->seq;
>  
> -	return mnt_ns_cmp(seq_a, ns_b) < 0;
> +	if (seq_a < seq_b)
> +		return -1;
> +	if (seq_a > seq_b)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline void mnt_ns_tree_write_lock(void)
> +{
> +	write_lock(&mnt_ns_tree_lock);
> +	write_seqcount_begin(&mnt_ns_tree_seqcount);
> +}
> +
> +static inline void mnt_ns_tree_write_unlock(void)
> +{
> +	write_seqcount_end(&mnt_ns_tree_seqcount);
> +	write_unlock(&mnt_ns_tree_lock);
>  }
>  
>  static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  {
> -	guard(write_lock)(&mnt_ns_tree_lock);
> -	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> +	struct rb_node *node;
> +
> +	mnt_ns_tree_write_lock();
> +	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> +	mnt_ns_tree_write_unlock();
> +
> +	WARN_ON_ONCE(node);
>  }
>  
>  static void mnt_ns_release(struct mnt_namespace *ns)
> @@ -150,15 +163,24 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  }
>  DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
>  
> +static void mnt_ns_release_rcu(struct rcu_head *rcu)
> +{
> +	struct mnt_namespace *mnt_ns;
> +
> +	mnt_ns = container_of(rcu, struct mnt_namespace, mnt_ns_rcu);
> +	mnt_ns_release(mnt_ns);
> +}
> +
>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
>  	if (!is_anon_ns(ns)) {
> -		guard(write_lock)(&mnt_ns_tree_lock);
> +		mnt_ns_tree_write_lock();
>  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> +		mnt_ns_tree_write_unlock();
>  	}
>  
> -	mnt_ns_release(ns);
> +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
>  }
>  
>  /*
> @@ -168,23 +190,23 @@ static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
>  {
>  	struct rb_node *node = mnt_ns_tree.rb_node;
> -	struct mnt_namespace *ret = NULL;
> +	struct mnt_namespace *mnt_ns = NULL;
>  
> -	lockdep_assert_held(&mnt_ns_tree_lock);
> +	lockdep_assert(rcu_read_lock_held());
>  
>  	while (node) {
>  		struct mnt_namespace *n = node_to_mnt_ns(node);
>  
>  		if (mnt_ns_id <= n->seq) {
> -			ret = node_to_mnt_ns(node);
> +			mnt_ns = node_to_mnt_ns(node);
>  			if (mnt_ns_id == n->seq)
>  				break;
> -			node = node->rb_left;
> +			node = rcu_dereference_raw(node->rb_left);
>  		} else {
> -			node = node->rb_right;
> +			node = rcu_dereference_raw(node->rb_right);
>  		}
>  	}
> -	return ret;
> +	return mnt_ns;
>  }
>  
>  /*
> @@ -194,18 +216,35 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
>   * namespace the @namespace_sem must first be acquired. If the namespace has
>   * already shut down before acquiring @namespace_sem, {list,stat}mount() will
>   * see that the mount rbtree of the namespace is empty.
> + *
> + * Note the lookup is lockless protected by a sequence counter. We only
> + * need to guard against false negatives as false positives aren't
> + * possible. So if we didn't find a mount namespace and the sequence
> + * counter has changed we need to retry. If the sequence counter is
> + * still the same we know the search actually failed.
>   */
>  static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
>  {
> -       struct mnt_namespace *ns;
> +	struct mnt_namespace *ns;
> +	unsigned int seq;
>  
> -       guard(read_lock)(&mnt_ns_tree_lock);
> -       ns = mnt_ns_find_id_at(mnt_ns_id);
> -       if (!ns || ns->seq != mnt_ns_id)
> -               return NULL;
> +	guard(rcu)();
> +	do {
> +		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
> +		ns = mnt_ns_find_id_at(mnt_ns_id);
> +		if (ns)
> +			break;
> +	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
>  
> -       refcount_inc(&ns->passive);
> -       return ns;
> +	if (!ns || ns->seq != mnt_ns_id)
> +		return NULL;
> +
> +	/*
> +	* The last reference count is put with after RCU delay so we
> +	* don't need to use refcount_inc_not_zero().
> +	*/
> +	refcount_inc(&ns->passive);
> +	return ns;
>  }
>  
>  static inline void lock_mount_hash(void)
> 
> -- 
> 2.45.2
> 

