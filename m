Return-Path: <linux-fsdevel+bounces-22345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5491688D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133F51F2248C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573ED15A86A;
	Tue, 25 Jun 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZo/8bDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB58F6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320585; cv=none; b=Ga3nIyZOqhX7MbbKLfP28q2uqwhpAJmzcvpOyeDg1eshlt5FQB7mXdkwEPYO5PCulXIj80kmBMsOvA2R6yWDKghcVrzi09H9ixBy+R130dBlImhuEQ02/qPzeAkZNKGm/FfTf6yZoSD3Cyrc7dQcvZqrbZjXXF2kSNhlB4Xe+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320585; c=relaxed/simple;
	bh=ZlFSc/JI9us+gwcb2kIiJbBkP+RTLBeKAX3H+eCLOBs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOcsZrNxmledZVzArGTOkj1r/Imq8Q0RmxuIfcHSglMwR2udl7EFD8a0Iu3V3DONGN3Pu8qg8XTwguK9P7O+pvJraxhcEyxrtPchfN/WNmfkU5Vt/mcRUQ2EKhy6KCvmGZgNvODnoyozeyDuULzC0GwJWFN7x9KtGNayY1cR0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZo/8bDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D96C32781;
	Tue, 25 Jun 2024 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719320585;
	bh=ZlFSc/JI9us+gwcb2kIiJbBkP+RTLBeKAX3H+eCLOBs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LZo/8bDjzDGTEZ9Xtx1LKLebjGpP73uxB6ncD5cvhNBh2qqrudgl72VmiPXLzDXEu
	 KioEpx00TppuVm3q9Wd5wBCrerYOU7ehTyyzFpg3yPz+isLu9HBOGEsA4ul9BOnulK
	 vWk9cxqerXvCZJv85W8wXIZUgFabaBYSPjeFtEehqq7Rd5uxyi0UATPtZZlAso0xbU
	 mcT5osOjidMx2RUMNfufrYGtZNrTZGwGphgCk5jK/a12LQaKjZFG6TkXEV2uh595pv
	 TanpcOiml+hXhBuV4cL9LAG8W5JqoCqPpKOu8kT1MeyMsNOM5xJBjXaxM8YYyX+uXR
	 /HYBoFrY0CCHA==
Message-ID: <050ce2c523cc6f2651da4ca50aae1544c5b09730.camel@kernel.org>
Subject: Re: [PATCH 3/8] fs: keep an index of current mount namespaces
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, kernel-team@fb.com
Date: Tue, 25 Jun 2024 09:03:03 -0400
In-Reply-To: <e5fdd78a90f5b00a75bd893962a70f52a2c015cd.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
	 <e5fdd78a90f5b00a75bd893962a70f52a2c015cd.1719243756.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> In order to allow for listmount() to be used on different namespaces we
> need a way to lookup a mount ns by its id.=C2=A0 Keep a rbtree of the cur=
rent
> !anonymous mount name spaces indexed by ID that we can use to look up
> the namespace.
>=20
> Co-developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> =C2=A0fs/mount.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/namespace.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++=
++-
> =C2=A02 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/mount.h b/fs/mount.h
> index 4adce73211ae..ad4b1ddebb54 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -16,6 +16,8 @@ struct mnt_namespace {
> =C2=A0	u64 event;
> =C2=A0	unsigned int		nr_mounts; /* # of mounts in the namespace */
> =C2=A0	unsigned int		pending_mounts;
> +	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
> +	refcount_t		passive; /* number references not pinning @mounts */
> =C2=A0} __randomize_layout;
> =C2=A0
> =C2=A0struct mnt_pcp {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 45df82f2a059..babdebdb0a9c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -78,6 +78,8 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> =C2=A0static DECLARE_RWSEM(namespace_sem);
> =C2=A0static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> =C2=A0static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +static DEFINE_RWLOCK(mnt_ns_tree_lock);
> +static struct rb_root mnt_ns_tree =3D RB_ROOT; /* protected by namespace=
_sem */
> =C2=A0
> =C2=A0struct mount_kattr {
> =C2=A0	unsigned int attr_set;
> @@ -103,6 +105,109 @@ EXPORT_SYMBOL_GPL(fs_kobj);
> =C2=A0 */
> =C2=A0__cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
> =C2=A0
> +static int mnt_ns_cmp(u64 seq, const struct mnt_namespace *ns)
> +{
> +	u64 seq_b =3D ns->seq;
> +
> +	if (seq < seq_b)
> +		return -1;
> +	if (seq > seq_b)
> +		return 1;
> +	return 0;
> +}
> +
> +static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node =
*node)
> +{
> +	if (!node)
> +		return NULL;
> +	return rb_entry(node, struct mnt_namespace, mnt_ns_tree_node);
> +}
> +
> +static bool mnt_ns_less(struct rb_node *a, const struct rb_node *b)
> +{
> +	struct mnt_namespace *ns_a =3D node_to_mnt_ns(a);
> +	struct mnt_namespace *ns_b =3D node_to_mnt_ns(b);
> +	u64 seq_a =3D ns_a->seq;
> +
> +	return mnt_ns_cmp(seq_a, ns_b) < 0;
> +}
> +
> +static void mnt_ns_tree_add(struct mnt_namespace *ns)
> +{
> +	guard(write_lock)(&mnt_ns_tree_lock);
> +	rb_add(&ns->mnt_ns_tree_node, &mnt_ns_tree, mnt_ns_less);
> +}
> +
> +static void mnt_ns_release(struct mnt_namespace *ns)
> +{
> +	lockdep_assert_not_held(&mnt_ns_tree_lock);
> +

Why is it bad to hold this lock here? AFAICT, put_user_ns just does a
schedule_work when the counter goes to 0. Granted, I don't see a reason
why you would want to hold it here, but usually that sort of assertion
means that it _must_ be forbidden.


> +	/* keep alive for {list,stat}mount() */
> +	if (refcount_dec_and_test(&ns->passive)) {
> +		put_user_ns(ns->user_ns);
> +		kfree(ns);
> +	}
> +}
> +DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_relea=
se(_T))
> +
> +static void mnt_ns_tree_remove(struct mnt_namespace *ns)
> +{
> +	/* remove from global mount namespace list */
> +	if (!is_anon_ns(ns)) {
> +		guard(write_lock)(&mnt_ns_tree_lock);
> +		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> +	}
> +
> +	mnt_ns_release(ns);
> +}
> +
> +/*
> + * Returns the mount namespace which either has the specified id, or has=
 the
> + * next smallest id afer the specified one.
> + */
> +static struct mnt_namespace *mnt_ns_find_id_at(u64 mnt_ns_id)
> +{
> +	struct rb_node *node =3D mnt_ns_tree.rb_node;
> +	struct mnt_namespace *ret =3D NULL;
> +
> +	lockdep_assert_held(&mnt_ns_tree_lock);
> +
> +	while (node) {
> +		struct mnt_namespace *n =3D node_to_mnt_ns(node);
> +
> +		if (mnt_ns_id <=3D n->seq) {
> +			ret =3D node_to_mnt_ns(node);
> +			if (mnt_ns_id =3D=3D n->seq)
> +				break;
> +			node =3D node->rb_left;
> +		} else {
> +			node =3D node->rb_right;
> +		}
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Lookup a mount namespace by id and take a passive reference count. Ta=
king a
> + * passive reference means the mount namespace can be emptied if e.g., t=
he last
> + * task holding an active reference exits. To access the mounts of the
> + * namespace the @namespace_sem must first be acquired. If the namespace=
 has
> + * already shut down before acquiring @namespace_sem, {list,stat}mount()=
 will
> + * see that the mount rbtree of the namespace is empty.
> + */
> +static struct mnt_namespace *lookup_mnt_ns(u64 mnt_ns_id)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mnt_namespace *ns;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(read_lock)(&mnt_ns_tree_lock)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns =3D mnt_ns_find_id_at(mnt_ns_id)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ns || ns->seq !=3D mnt_ns_id)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return NULL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_inc(&ns->passive);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ns;
> +}
> +
> =C2=A0static inline void lock_mount_hash(void)
> =C2=A0{
> =C2=A0	write_seqlock(&mount_lock);
> @@ -3736,8 +3841,7 @@ static void free_mnt_ns(struct mnt_namespace *ns)
> =C2=A0	if (!is_anon_ns(ns))
> =C2=A0		ns_free_inum(&ns->ns);
> =C2=A0	dec_mnt_namespaces(ns->ucounts);
> -	put_user_ns(ns->user_ns);
> -	kfree(ns);
> +	mnt_ns_tree_remove(ns);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -3776,7 +3880,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct us=
er_namespace *user_ns, bool a
> =C2=A0	if (!anon)
> =C2=A0		new_ns->seq =3D atomic64_add_return(1, &mnt_ns_seq);
> =C2=A0	refcount_set(&new_ns->ns.count, 1);
> +	refcount_set(&new_ns->passive, 1);
> =C2=A0	new_ns->mounts =3D RB_ROOT;
> +	RB_CLEAR_NODE(&new_ns->mnt_ns_tree_node);
> =C2=A0	init_waitqueue_head(&new_ns->poll);
> =C2=A0	new_ns->user_ns =3D get_user_ns(user_ns);
> =C2=A0	new_ns->ucounts =3D ucounts;
> @@ -3853,6 +3959,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long fla=
gs, struct mnt_namespace *ns,
> =C2=A0		while (p->mnt.mnt_root !=3D q->mnt.mnt_root)
> =C2=A0			p =3D next_mnt(skip_mnt_tree(p), old);
> =C2=A0	}
> +	mnt_ns_tree_add(new_ns);
> =C2=A0	namespace_unlock();
> =C2=A0
> =C2=A0	if (rootmnt)
> @@ -5208,6 +5315,8 @@ static void __init init_mount_tree(void)
> =C2=A0
> =C2=A0	set_fs_pwd(current->fs, &root);
> =C2=A0	set_fs_root(current->fs, &root);
> +
> +	mnt_ns_tree_add(ns);
> =C2=A0}
> =C2=A0
> =C2=A0void __init mnt_init(void)


--=20
Jeff Layton <jlayton@kernel.org>

