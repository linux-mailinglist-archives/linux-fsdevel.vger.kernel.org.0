Return-Path: <linux-fsdevel+bounces-37355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95C9F1528
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D6E188ADC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EE1EC006;
	Fri, 13 Dec 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo7ddSDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22831E8855
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115455; cv=none; b=lE0xguCksOOYO0NYuvpwYgYnaLfXcTbl8CGFbrhfr1tS8vMRmHQNMs31dc13HUYFe5UkVGN5jCjeSr4pJyturZMfWlPIHH789/hf1sLIkOHuhCkniziNdnFsIAVHMyWzSN4gLbh5iwFf9tovSYMI/Nyw/D0iPv7ra9aCYRu+Wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115455; c=relaxed/simple;
	bh=PrWUrwY7qHzY0B+KSQIoccE5/ciDSAF6bVJg//w/has=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrNSywDXsXjSrZSsxUT8bL4dZ9t45Z6pmvs3SiGIe3GrFStCro/QjJ06ZCZ0xdwKSVJ1tIXSRQgZJdb0s5umaQ+rSKXOW1B4t6il8AhZ0UwuXqd3xGYNsqckJX7SZ79MBw8eYp8dr1QcwanUwrY+crgYDe3sMuoE/V8qPo3ymGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo7ddSDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE1C4CED1;
	Fri, 13 Dec 2024 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115453;
	bh=PrWUrwY7qHzY0B+KSQIoccE5/ciDSAF6bVJg//w/has=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uo7ddSDcszLidVmfoDPaz31X3jozrkOZ6TAza4qmtxenxFVVLvPiYYXxhDPr9TuBF
	 kzXiatXzBEhG93beaLWSbikknGgzZF7ok9dHVAT88BydY1WvJJA7zXx4TycHHHdgIn
	 iX79OnpSv8QoE6qStRgwemwcnz7VCbty2w/pOcAIbEnXa6Tu+rrXqPv5jLRTod1cqG
	 vHbZ3lT/NqiKKH0ft20lMaXfW00kEhSZrSKiA5vPP9tEN1nJ+klwtThjoKsKi8eQ22
	 WBkI7hMNMK5ix/sa9DxBjzDRb7jpGiOsQIIHIUVPWlzL8ScZ1vZm7Kn678a8583Tqw
	 hl45IuAO7Fk8A==
Date: Fri, 13 Dec 2024 19:44:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Ziljstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] fs: lockless mntns rbtree lookup
Message-ID: <20241213-vielfach-belaufen-793f8f8d9b58@brauner>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
 <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
 <df8360132897826abd1690a860ffbdc4b16cc49b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df8360132897826abd1690a860ffbdc4b16cc49b.camel@kernel.org>

On Fri, Dec 13, 2024 at 09:11:41AM -0500, Jeff Layton wrote:
> On Fri, 2024-12-13 at 00:03 +0100, Christian Brauner wrote:
> > Currently we use a read-write lock but for the simple search case we can
> > make this lockless. Creating a new mount namespace is a rather rare
> > event compared with querying mounts in a foreign mount namespace. Once
> > this is picked up by e.g., systemd to list mounts in another mount in
> > it's isolated services or in containers this will be used a lot so this
> > seems worthwhile doing.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/mount.h     |   5 ++-
> >  fs/namespace.c | 119 +++++++++++++++++++++++++++++++++++----------------------
> >  2 files changed, 77 insertions(+), 47 deletions(-)
> > 
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 185fc56afc13338f8185fe818051444d540cbd5b..36ead0e45e8aa7614c00001102563a711d9dae6e 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -12,7 +12,10 @@ struct mnt_namespace {
> >  	struct user_namespace	*user_ns;
> >  	struct ucounts		*ucounts;
> >  	u64			seq;	/* Sequence number to prevent loops */
> > -	wait_queue_head_t poll;
> > +	union {
> > +		wait_queue_head_t	poll;
> > +		struct rcu_head		mnt_ns_rcu;
> > +	};
> >  	u64 event;
> >  	unsigned int		nr_mounts; /* # of mounts in the namespace */
> >  	unsigned int		pending_mounts;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..52adee787eb1b6ee8831705b2b121854c3370fb3 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -79,6 +79,8 @@ static DECLARE_RWSEM(namespace_sem);
> >  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> >  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> >  static DEFINE_RWLOCK(mnt_ns_tree_lock);
> > +static seqcount_rwlock_t mnt_ns_tree_seqcount = SEQCNT_RWLOCK_ZERO(mnt_ns_tree_seqcount, &mnt_ns_tree_lock);
> > +
> >  static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
> >  
> >  struct mount_kattr {
> > @@ -105,17 +107,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
> >   */
> >  __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
> >  
> > -static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> > -{
> > -	u64 seq_b = ns->seq;
> > -
> > -	if (seq < seq_b)
> > -		return -1;
> > -	if (seq > seq_b)
> > -		return 1;
> > -	return 0;
> > -}
> > -
> >  static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
> >  {
> >  	if (!node)
> > @@ -123,19 +114,41 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
> >  	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
> >  }
> >  
> > -static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> > +static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
> >  {
> >  	struct mnt_namespace *ns_a = node_to_mnt_ns(a);
> >  	struct mnt_namespace *ns_b = node_to_mnt_ns(b);
> >  	u64 seq_a = ns_a->seq;
> > +	u64 seq_b = ns_b->seq;
> > +
> > +	if (seq_a < seq_b)
> > +		return -1;
> > +	if (seq_a > seq_b)
> > +		return 1;
> > +	return 0;
> > +}
> >  
> > -	return mnt_ns_cmp(seq_a, ns_b) < 0;
> > +static inline void mnt_ns_tree_write_lock(void)
> > +{
> > +	write_lock(&mnt_ns_tree_lock);
> > +	write_seqcount_begin(&mnt_ns_tree_seqcount);
> > +}
> > +
> > +static inline void mnt_ns_tree_write_unlock(void)
> > +{
> > +	write_seqcount_end(&mnt_ns_tree_seqcount);
> > +	write_unlock(&mnt_ns_tree_lock);
> >  }
> >  
> >  static void mnt_ns_tree_add(struct mnt_namespace *ns)
> >  {
> > -	guard(write_lock)(&mnt_ns_tree_lock);
> > -	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> > +	struct rb_node *node;
> > +
> > +	mnt_ns_tree_write_lock();
> > +	node = rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cmp);
> > +	mnt_ns_tree_write_unlock();
> > +
> > +	WARN_ON_ONCE(node);
> >  }
> >  
> >  static void mnt_ns_release(struct mnt_namespace *ns)
> > @@ -150,41 +163,36 @@ static void mnt_ns_release(struct mnt_namespace *ns)
> >  }
> >  DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
> >  
> > +static void mnt_ns_release_rcu(struct rcu_head *rcu)
> > +{
> > +	struct mnt_namespace *mnt_ns;
> > +
> > +	mnt_ns = container_of(rcu, struct mnt_namespace, mnt_ns_rcu);
> > +	mnt_ns_release(mnt_ns);
> > +}
> > +
> >  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
> >  {
> >  	/* remove from global mount namespace list */
> >  	if (!is_anon_ns(ns)) {
> > -		guard(write_lock)(&mnt_ns_tree_lock);
> > +		mnt_ns_tree_write_lock();
> >  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> > +		mnt_ns_tree_write_unlock();
> >  	}
> >  
> > -	mnt_ns_release(ns);
> > +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
> >  }
> >  
> > -/*
> > - * Returns the mount namespace which either has the specified id, or has the
> > - * next smallest id afer the specified one.
> > - */
> > -static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
> > +static int mnt_ns_find(const void *key, const struct rb_node *node)
> >  {
> > -	struct rb_node *node = mnt_ns_tree.rb_node;
> > -	struct mnt_namespace *ret = NULL;
> > -
> > -	lockdep_assert_held(&mnt_ns_tree_lock);
> > -
> > -	while (node) {
> > -		struct mnt_namespace *n = node_to_mnt_ns(node);
> > +	const u64 mnt_ns_id = *(u64 *)key;
> > +	const struct mnt_namespace *ns = node_to_mnt_ns(node);
> >  
> > -		if (mnt_ns_id <= n->seq) {
> > -			ret = node_to_mnt_ns(node);
> > -			if (mnt_ns_id == n->seq)
> > -				break;
> > -			node = node->rb_left;
> > -		} else {
> > -			node = node->rb_right;
> > -		}
> > -	}
> > -	return ret;
> > +	if (mnt_ns_id < ns->seq)
> > +		return -1;
> > +	if (mnt_ns_id > ns->seq)
> > +		return 1;
> > +	return 0;
> >  }
> >  
> >  /*
> > @@ -194,18 +202,37 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
> >   * namespace the @namespace_sem must first be acquired. If the namespace has
> >   * already shut down before acquiring @namespace_sem, {list,stat}mount() will
> >   * see that the mount rbtree of the namespace is empty.
> > + *
> > + * Note the lookup is lockless protected by a sequence counter. We only
> > + * need to guard against false negatives as false positives aren't
> > + * possible. So if we didn't find a mount namespace and the sequence
> > + * counter has changed we need to retry. If the sequence counter is
> > + * still the same we know the search actually failed.
> >   */
> >  static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
> >  {
> > -       struct mnt_namespace *ns;
> > +	struct mnt_namespace *ns;
> > +	struct rb_node *node;
> > +	unsigned int seq;
> > +
> > +	guard(rcu)();
> > +	do {
> > +		seq = read_seqcount_begin(&mnt_ns_tree_seqcount);
> > +		node = rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
> > +		if (node)
> > +			break;
> > +	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
> >  
> > -       guard(read_lock)(&mnt_ns_tree_lock);
> > -       ns = mnt_ns_find_id_at(mnt_ns_id);
> > -       if (!ns || ns->seq != mnt_ns_id)
> > -               return NULL;
> > +	if (!node)
> > +		return NULL;
> >  
> > -       refcount_inc(&ns->passive);
> > -       return ns;
> > +	/*
> > +	 * The last reference count is put with RCU delay so we can
> > +	 * unconditonally acquire a reference here.
> > +	 */
> > +	ns = node_to_mnt_ns(node);
> > +	refcount_inc(&ns->passive);
> 
> I'm a little uneasy with the unconditional refcount_inc() here. It
> seems quite possible that this could to a 0->1 transition here. You may
> be right that that technically won't cause a problem with the rcu lock
> held, but at the very least, that will cause a refcount warning to pop.
> 
> Maybe this should be a refcount_inc_not_zero() and then you just return
> NULL if the increment doesn't occur?

So this shouldn't be possible (and Paul is on the thread and can tell me
if I'm wrong) because:

call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
-> mnt_ns_release_rcu()
   -> mnt_ns_release()
      -> refcount_dec_and_test()

Which means that decrements are RCU delayed. Any reader must walk the
list holding the RCU lock. If they find the mount namespace still on the
list then mnt_ns_release() will be deferred until they are done.

In order for what you describe to happen a reader must find that mount
namespace still in the list or rbtree and mnt_ns_release() is called
directly.

But afaict that doesn't happen. mnt_ns_release() is only called directly
when the mount namespace has never been on any of the lists.

refcount_inc() will already WARN() if the previous value was 0 and
splat. If we use refcount_inc_not_zero() we're adding additional memory
barriers when we simply don't need them.

But if that's important to you though than I'd rather switch the passive
count to atomic_t and use atomic_dec_and_test() in mnt_ns_release() and
then use similar logic as I used for file_ref_inc(): 

unsigned long prior = atomic_fetch_inc_relaxed(&ns->passive);
WARN_ONCE(!prior, "increment from zero UAF condition present");

This would give us the opportunity to catch a "shouldn't happen
condition". But using refcount_inc_not_zero() would e.g., confuse me a
few months down the line (Yes, we could probably add a comment.).

> 
> > +	return ns;
> >  }
> >  
> >  static inline void lock_mount_hash(void)
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

