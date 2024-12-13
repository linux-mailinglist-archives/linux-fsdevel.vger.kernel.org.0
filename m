Return-Path: <linux-fsdevel+bounces-37305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13ED9F0EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D64528341D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1A1E105B;
	Fri, 13 Dec 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6vnN5sG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3D1E0E10
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099103; cv=none; b=h4Umw2THp548YxvhG5Eyu6SlZ0nLnAeEFAohiDtdT+RXeVKThD1lnTkc3gHn8hUTiDF9Xi7ZmLr1IDaNRmsExOYKgxNylvRD87Rz+p1vue+BZOtMhvPxY5vfZI8J4Gr5rLTiYJ7wyM4ircum5yrOsC/Z+AGIl5u+xWUgs48RafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099103; c=relaxed/simple;
	bh=Qq23nloZ4h7NrunmteXDHG+tm8kZ9iCfCEIK2EDzTBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j3D+woVvrKZ5VyLzDpKK4OVeRUgmYdcBNqswE4T8T4dfxnlq3OfJfDkwM4gj+Zm+afd7txZ0O8714h41Ia6UZh6hEbwI4J5B3TVf1QGEXWvVSU3mxazwDcFM9wsTi6Na6Kfw4cvgVY1ffpOwE2GJ2Yck6B9L5Bs7hFtadaCh4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6vnN5sG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9607EC4CED0;
	Fri, 13 Dec 2024 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734099103;
	bh=Qq23nloZ4h7NrunmteXDHG+tm8kZ9iCfCEIK2EDzTBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c6vnN5sGnJzkI+qaKDLOM8bCujtP8c0Cgf2iARaLcyCcxknj+AdiAw9UCk/faICbQ
	 5UuqK2GzzYDxEsRipKVhn9Gkbw4wkWydZXqqYFfEI7ZfrRlbCs98KWrZ+xNnsLy4LY
	 OR4tvJHohzYAXbSVOhS2yiGk1eaj4GXffB6nD5zS94b/6+/e+Vjy5/ZG/Zba0FufYq
	 ku2nAsEx6kid3gFq9wi1QUsmzGz+w03gom7h5ritTrP9HADSyaXMGVDHznc24jZUfY
	 Lo7JgnWw6MqJolR1v7OxbKioVp3gpFFoxFDRm2QMLc75fY9e/Gv0otf5PQJtH7pFj2
	 0ZXMNCjSTYgFg==
Message-ID: <df8360132897826abd1690a860ffbdc4b16cc49b.camel@kernel.org>
Subject: Re: [PATCH v3 03/10] fs: lockless mntns rbtree lookup
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Ziljstra
	 <peterz@infradead.org>, linux-fsdevel@vger.kernel.org
Date: Fri, 13 Dec 2024 09:11:41 -0500
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
References: 
	<20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
	 <20241213-work-mount-rbtree-lockless-v3-3-6e3cdaf9b280@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 00:03 +0100, Christian Brauner wrote:
> Currently we use a read-write lock but for the simple search case we can
> make this lockless. Creating a new mount namespace is a rather rare
> event compared with querying mounts in a foreign mount namespace. Once
> this is picked up by e.g., systemd to list mounts in another mount in
> it's isolated services or in containers this will be used a lot so this
> seems worthwhile doing.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/mount.h     |   5 ++-
>  fs/namespace.c | 119 +++++++++++++++++++++++++++++++++++----------------=
------
>  2 files changed, 77 insertions(+), 47 deletions(-)
>=20
> diff --git a/fs/mount.h b/fs/mount.h
> index 185fc56afc13338f8185fe818051444d540cbd5b..36ead0e45e8aa7614c0000110=
2563a711d9dae6e 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -12,7 +12,10 @@ struct mnt_namespace {
>  	struct user_namespace	*user_ns;
>  	struct ucounts		*ucounts;
>  	u64			seq;	/* Sequence number to prevent loops */
> -	wait_queue_head_t poll;
> +	union {
> +		wait_queue_head_t	poll;
> +		struct rcu_head		mnt_ns_rcu;
> +	};
>  	u64 event;
>  	unsigned int		nr_mounts; /* # of mounts in the namespace */
>  	unsigned int		pending_mounts;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 10fa18dd66018fadfdc9d18c59a851eed7bd55ad..52adee787eb1b6ee8831705b2=
b121854c3370fb3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -79,6 +79,8 @@ static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  static DEFINE_RWLOCK(mnt_ns_tree_lock);
> +static seqcount_rwlock_t mnt_ns_tree_seqcount =3D SEQCNT_RWLOCK_ZERO(mnt=
_ns_tree_seqcount, &mnt_ns_tree_lock);
> +
>  static struct rb_root mnt_ns_tree =3D RB_ROOT; /* protected by mnt_ns_tr=
ee_lock */
> =20
>  struct mount_kattr {
> @@ -105,17 +107,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
>   */
>  __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
> =20
> -static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> -{
> -	u64 seq_b =3D ns->seq;
> -
> -	if (seq < seq_b)
> -		return -1;
> -	if (seq > seq_b)
> -		return 1;
> -	return 0;
> -}
> -
>  static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node =
*node)
>  {
>  	if (!node)
> @@ -123,19 +114,41 @@ static inline struct mnt_namespace *node_to_mnt_ns(=
const struct rb_node *node)
>  	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
>  }
> =20
> -static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> +static int mnt_ns_cmp(struct rb_node *a, const struct rb_node *b)
>  {
>  	struct mnt_namespace *ns_a =3D node_to_mnt_ns(a);
>  	struct mnt_namespace *ns_b =3D node_to_mnt_ns(b);
>  	u64 seq_a =3D ns_a->seq;
> +	u64 seq_b =3D ns_b->seq;
> +
> +	if (seq_a < seq_b)
> +		return -1;
> +	if (seq_a > seq_b)
> +		return 1;
> +	return 0;
> +}
> =20
> -	return mnt_ns_cmp(seq_a, ns_b) < 0;
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
> =20
>  static void mnt_ns_tree_add(struct mnt_namespace *ns)
>  {
> -	guard(write_lock)(&mnt_ns_tree_lock);
> -	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> +	struct rb_node *node;
> +
> +	mnt_ns_tree_write_lock();
> +	node =3D rb_find_add_rcu(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_cm=
p);
> +	mnt_ns_tree_write_unlock();
> +
> +	WARN_ON_ONCE(node);
>  }
> =20
>  static void mnt_ns_release(struct mnt_namespace *ns)
> @@ -150,41 +163,36 @@ static void mnt_ns_release(struct mnt_namespace *ns=
)
>  }
>  DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_relea=
se(_T))
> =20
> +static void mnt_ns_release_rcu(struct rcu_head *rcu)
> +{
> +	struct mnt_namespace *mnt_ns;
> +
> +	mnt_ns =3D container_of(rcu, struct mnt_namespace, mnt_ns_rcu);
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
> =20
> -	mnt_ns_release(ns);
> +	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
>  }
> =20
> -/*
> - * Returns the mount namespace which either has the specified id, or has=
 the
> - * next smallest id afer the specified one.
> - */
> -static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
> +static int mnt_ns_find(const void *key, const struct rb_node *node)
>  {
> -	struct rb_node *node =3D mnt_ns_tree.rb_node;
> -	struct mnt_namespace *ret =3D NULL;
> -
> -	lockdep_assert_held(&mnt_ns_tree_lock);
> -
> -	while (node) {
> -		struct mnt_namespace *n =3D node_to_mnt_ns(node);
> +	const u64 mnt_ns_id =3D *(u64 *)key;
> +	const struct mnt_namespace *ns =3D node_to_mnt_ns(node);
> =20
> -		if (mnt_ns_id <=3D n->seq) {
> -			ret =3D node_to_mnt_ns(node);
> -			if (mnt_ns_id =3D=3D n->seq)
> -				break;
> -			node =3D node->rb_left;
> -		} else {
> -			node =3D node->rb_right;
> -		}
> -	}
> -	return ret;
> +	if (mnt_ns_id < ns->seq)
> +		return -1;
> +	if (mnt_ns_id > ns->seq)
> +		return 1;
> +	return 0;
>  }
> =20
>  /*
> @@ -194,18 +202,37 @@ static struct mnt_namespace *mnt_ns_find_id_at(u64 =
mnt_ns_id)
>   * namespace the @namespace_sem must first be acquired. If the namespace=
 has
>   * already shut down before acquiring @namespace_sem, {list,stat}mount()=
 will
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
> +	struct rb_node *node;
> +	unsigned int seq;
> +
> +	guard(rcu)();
> +	do {
> +		seq =3D read_seqcount_begin(&mnt_ns_tree_seqcount);
> +		node =3D rb_find_rcu(&mnt_ns_id, &mnt_ns_tree, mnt_ns_find);
> +		if (node)
> +			break;
> +	} while (read_seqcount_retry(&mnt_ns_tree_seqcount, seq));
> =20
> -       guard(read_lock)(&mnt_ns_tree_lock);
> -       ns =3D mnt_ns_find_id_at(mnt_ns_id);
> -       if (!ns || ns->seq !=3D mnt_ns_id)
> -               return NULL;
> +	if (!node)
> +		return NULL;
> =20
> -       refcount_inc(&ns->passive);
> -       return ns;
> +	/*
> +	 * The last reference count is put with RCU delay so we can
> +	 * unconditonally acquire a reference here.
> +	 */
> +	ns =3D node_to_mnt_ns(node);
> +	refcount_inc(&ns->passive);

I'm a little uneasy with the unconditional refcount_inc() here. It
seems quite possible that this could to a 0->1 transition here. You may
be right that that technically won't cause a problem with the rcu lock
held, but at the very least, that will cause a refcount warning to pop.

Maybe this should be a refcount_inc_not_zero() and then you just return
NULL if the increment doesn't occur?

> +	return ns;
>  }
> =20
>  static inline void lock_mount_hash(void)
>=20

--=20
Jeff Layton <jlayton@kernel.org>

