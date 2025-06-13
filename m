Return-Path: <linux-fsdevel+bounces-51595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CBAD9211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DD81692D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBD1FE45B;
	Fri, 13 Jun 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c+FDGAgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D601FC0FE;
	Fri, 13 Jun 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829999; cv=none; b=kR9gJpKX5q7LeqkGupDm4vH0bSIgnQJ0jt75FOdSPIf8pLE5UTh6QEIzE7Wp0Gi9CxTNX7+SkeGrYxRTH+85KgucyQbX4GqFRIyS7Qm5WsmEa5IY0/WW0gfZLc82vkc9EN6jKJuFhe+daBb9axat9UHYlpSBa1nAFRXO7ochavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829999; c=relaxed/simple;
	bh=KCbOPf7im1/siUa4zcRklkxs4U0uFsFhglkkw+HWepU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqhtOij8fE98N4LmrdU0Hawccf37q4CxICvT998CSn/WQN1J6hLk8HzQ4x3ywRZEYnDiKt2zh5OhvidGpH5zXGIoQz2R/uzVjsdCkDcOGX8s35sSrjST3luSbB357TMLtGiZ1TUyU/aSiXehKzpju2JC9UnNLWLudJef1jMOTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c+FDGAgp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dRLuGiEOnYULWZuKaColf4Y0dkhcrgbbKh5/xcBwYvc=; b=c+FDGAgpjQ+ltRMr65zRsYRCTG
	dtXp8sBRP1zuwTdauFLUmOWqU0yF8rIdXXxX/N+eWIr0PjeGQrXt8P1HR++C9n/ptytmj0ISGCFYj
	pLTbUaNkrtwcRuPy9b0BW+gdWsiyG9/n9ZubJCihKA8eZaJBRNoPk6gm3k6v4pzLwLjtj9gqPEJQ6
	bjPhsCk1RtwK0F23L9CUmT9baM42FNrgcgCnrUXuZaabJqHG+2WRJP1sQWeEfbJ8lQUJthtFfUYfA
	0ZzQGwjCKTD9XqAIpSzzZgdizfD8fRPfz4LRxeO8sxrLYhY463MSeSqIhp1kluCJ2KDhNrSBCASkT
	pH3MkvaA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ6iI-00358o-Co; Fri, 13 Jun 2025 17:53:06 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fuse: new workqueue to periodically invalidate
 expired dentries
In-Reply-To: <20250520154203.31359-1-luis@igalia.com> (Luis Henriques's
	message of "Tue, 20 May 2025 16:42:03 +0100")
References: <20250520154203.31359-1-luis@igalia.com>
Date: Fri, 13 Jun 2025 16:53:01 +0100
Message-ID: <87tt4jzlia.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 20 2025, Luis Henriques wrote:

> This patch adds a new module parameter 'inval_wq' which is used to start a
> workqueue to periodically invalidate expired dentries.  The value of this
> new parameter is the period, in seconds, of the workqueue.  When it is se=
t,
> every new dentry will be added to an rbtree, sorted by the dentry's expiry
> time.
>
> When the workqueue is executed, it will check the dentries in this tree a=
nd
> invalidate them if:
>
>   - The dentry has timed-out, or if
>   - The connection epoch has been incremented.
>
> The workqueue will run for, at most, 5 seconds each time.  It will
> reschedule itself if the dentries tree isn't empty.
>
> The workqueue period is set per filesystem with the 'inval_wq' parameter
> value when it is mounted.  This value can not be less than 5 seconds.  If
> this module parameter is changed later on, the mounted filesystems will
> keep using the old value until they are remounted.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi!
>
> I've been staring at this patch for a while and hopefully it's ready for a
> fresh set of eyes to find the bugs that are hiding from me.  I believe I
> addressed all Miklos comments, and decided to drop the RFC from the subje=
ct.
>
> As before, this patch depends on my previous patch (already in Miklos tre=
e)
> with subject: "fuse: add more control over cache invalidation behaviour".
>
> Feedback is welcome.

Gentle ping, feedback on the generic approach would be great.

Cheers,
--=20
Lu=C3=ADs

>
> Cheers,
> --=20
> Luis
>
> Changes since v2:
>
> - Major rework, the dentries tree nodes are now in fuse_dentry and they a=
re
>   tied to the actual dentry lifetime
> - Mount option is now a module parameter
> - workqueue now runs for at most 5 seconds before rescheduling
>
>  fs/fuse/dir.c    | 180 +++++++++++++++++++++++++++++++++++++++++------
>  fs/fuse/fuse_i.h |  12 ++++
>  fs/fuse/inode.c  |  21 ++++++
>  3 files changed, 190 insertions(+), 23 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1fb0b15a6088..257ca2b36b94 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -34,33 +34,153 @@ static void fuse_advise_use_readdirplus(struct inode=
 *dir)
>  	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>  }
>=20=20
> -#if BITS_PER_LONG >=3D 64
> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
> +struct fuse_dentry {
> +	u64 time;
> +	struct rcu_head rcu;
> +	struct rb_node node;
> +	struct dentry *dentry;
> +};
> +
> +static void __fuse_dentry_tree_del_node(struct fuse_conn *fc,
> +					struct fuse_dentry *fd)
>  {
> -	entry->d_fsdata =3D (void *) time;
> +	if (!RB_EMPTY_NODE(&fd->node)) {
> +		rb_erase(&fd->node, &fc->dentry_tree);
> +		RB_CLEAR_NODE(&fd->node);
> +	}
>  }
>=20=20
> -static inline u64 fuse_dentry_time(const struct dentry *entry)
> +static void fuse_dentry_tree_del_node(struct dentry *dentry)
>  {
> -	return (u64)entry->d_fsdata;
> +	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
> +	struct fuse_dentry *fd =3D dentry->d_fsdata;
> +
> +	if (!fc->inval_wq)
> +		return;
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +	__fuse_dentry_tree_del_node(fc, fd);
> +	spin_unlock(&fc->dentry_tree_lock);
>  }
>=20=20
> -#else
> -union fuse_dentry {
> -	u64 time;
> -	struct rcu_head rcu;
> -};
> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
> +{
> +	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
> +	struct fuse_dentry *fd =3D dentry->d_fsdata;
> +	struct fuse_dentry *cur;
> +	struct rb_node **p, *parent =3D NULL;
> +	bool start_work =3D false;
> +
> +	if (!fc->inval_wq)
> +		return;
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +
> +	if (!fc->inval_wq) {
> +		spin_unlock(&fc->dentry_tree_lock);
> +		return;
> +	}
> +
> +	start_work =3D RB_EMPTY_ROOT(&fc->dentry_tree);
> +	__fuse_dentry_tree_del_node(fc, fd);
> +
> +	p =3D &fc->dentry_tree.rb_node;
> +	while (*p) {
> +		parent =3D *p;
> +		cur =3D rb_entry(*p, struct fuse_dentry, node);
> +		if (fd->time > cur->time)
> +			p =3D &(*p)->rb_left;
> +		else
> +			p =3D &(*p)->rb_right;
> +	}
> +	rb_link_node(&fd->node, parent, p);
> +	rb_insert_color(&fd->node, &fc->dentry_tree);
> +	spin_unlock(&fc->dentry_tree_lock);
> +
> +	if (start_work)
> +		schedule_delayed_work(&fc->dentry_tree_work,
> +				      secs_to_jiffies(fc->inval_wq));
> +}
> +
> +void fuse_dentry_tree_prune(struct fuse_conn *fc)
> +{
> +	struct rb_node *n;
> +
> +	if (!fc->inval_wq)
> +		return;
> +
> +	fc->inval_wq =3D 0;
> +	cancel_delayed_work_sync(&fc->dentry_tree_work);
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +	while (!RB_EMPTY_ROOT(&fc->dentry_tree)) {
> +		n =3D rb_first(&fc->dentry_tree);
> +		rb_erase(n, &fc->dentry_tree);
> +		RB_CLEAR_NODE(&rb_entry(n, struct fuse_dentry, node)->node);
> +	}
> +	spin_unlock(&fc->dentry_tree_lock);
> +}
> +
> +/*
> + * workqueue that, when enabled, will periodically check for expired den=
tries in
> + * the dentries tree.
> + *
> + * A dentry has expired if:
> + *
> + *   1) it has been around for too long (timeout) or if
> + *
> + *   2) the connection epoch has been incremented.
> + *
> + * The workqueue will be rescheduled itself as long as the dentries tree=
 is not
> + * empty.  Also, it will not spend more than 5 seconds invalidating dent=
ries on
> + * each run.
> + */
> +void fuse_dentry_tree_work(struct work_struct *work)
> +{
> +	struct fuse_conn *fc =3D container_of(work, struct fuse_conn,
> +					    dentry_tree_work.work);
> +	struct fuse_dentry *fd;
> +	struct rb_node *node;
> +	u64 start, end;
> +	int epoch;
> +	bool reschedule;
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +	start =3D get_jiffies_64();
> +	/* Don't spend too much time invalidating dentries */
> +	end =3D start + secs_to_jiffies(5);
> +	epoch =3D atomic_read(&fc->epoch);
> +
> +	node =3D rb_first(&fc->dentry_tree);
> +	while (node && time_after64(end, get_jiffies_64())) {
> +		fd =3D rb_entry(node, struct fuse_dentry, node);
> +		if ((fd->dentry->d_time < epoch) || (fd->time < start)) {
> +			rb_erase(&fd->node, &fc->dentry_tree);
> +			RB_CLEAR_NODE(&fd->node);
> +			spin_unlock(&fc->dentry_tree_lock);
> +			d_invalidate(fd->dentry);
> +			spin_lock(&fc->dentry_tree_lock);
> +		} else
> +			break;
> +		node =3D rb_first(&fc->dentry_tree);
> +	}
> +	reschedule =3D !RB_EMPTY_ROOT(&fc->dentry_tree);
> +	spin_unlock(&fc->dentry_tree_lock);
> +
> +	if (reschedule)
> +		schedule_delayed_work(&fc->dentry_tree_work,
> +				      secs_to_jiffies(fc->inval_wq));
> +}
>=20=20
>  static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
>  {
> -	((union fuse_dentry *) dentry->d_fsdata)->time =3D time;
> +	((struct fuse_dentry *) dentry->d_fsdata)->time =3D time;
>  }
>=20=20
>  static inline u64 fuse_dentry_time(const struct dentry *entry)
>  {
> -	return ((union fuse_dentry *) entry->d_fsdata)->time;
> +	return ((struct fuse_dentry *) entry->d_fsdata)->time;
>  }
> -#endif
>=20=20
>  static void fuse_dentry_settime(struct dentry *dentry, u64 time)
>  {
> @@ -81,6 +201,7 @@ static void fuse_dentry_settime(struct dentry *dentry,=
 u64 time)
>  	}
>=20=20
>  	__fuse_dentry_settime(dentry, time);
> +	fuse_dentry_tree_add_node(dentry);
>  }
>=20=20
>  /*
> @@ -283,21 +404,36 @@ static int fuse_dentry_revalidate(struct inode *dir=
, const struct qstr *name,
>  	goto out;
>  }
>=20=20
> -#if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
> -	dentry->d_fsdata =3D kzalloc(sizeof(union fuse_dentry),
> -				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
> +	struct fuse_dentry *fd;
> +
> +	fd =3D kzalloc(sizeof(struct fuse_dentry),
> +			  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
> +	if (!fd)
> +		return -ENOMEM;
> +
> +	fd->dentry =3D dentry;
> +	RB_CLEAR_NODE(&fd->node);
> +	dentry->d_fsdata =3D fd;
>=20=20
> -	return dentry->d_fsdata ? 0 : -ENOMEM;
> +	return 0;
> +}
> +
> +static void fuse_dentry_prune(struct dentry *dentry)
> +{
> +	struct fuse_dentry *fd =3D dentry->d_fsdata;
> +
> +	if (!RB_EMPTY_NODE(&fd->node))
> +		fuse_dentry_tree_del_node(dentry);
>  }
> +
>  static void fuse_dentry_release(struct dentry *dentry)
>  {
> -	union fuse_dentry *fd =3D dentry->d_fsdata;
> +	struct fuse_dentry *fd =3D dentry->d_fsdata;
>=20=20
>  	kfree_rcu(fd, rcu);
>  }
> -#endif
>=20=20
>  static int fuse_dentry_delete(const struct dentry *dentry)
>  {
> @@ -334,18 +470,16 @@ static struct vfsmount *fuse_dentry_automount(struc=
t path *path)
>  const struct dentry_operations fuse_dentry_operations =3D {
>  	.d_revalidate	=3D fuse_dentry_revalidate,
>  	.d_delete	=3D fuse_dentry_delete,
> -#if BITS_PER_LONG < 64
>  	.d_init		=3D fuse_dentry_init,
> +	.d_prune	=3D fuse_dentry_prune,
>  	.d_release	=3D fuse_dentry_release,
> -#endif
>  	.d_automount	=3D fuse_dentry_automount,
>  };
>=20=20
>  const struct dentry_operations fuse_root_dentry_operations =3D {
> -#if BITS_PER_LONG < 64
>  	.d_init		=3D fuse_dentry_init,
> +	.d_prune	=3D fuse_dentry_prune,
>  	.d_release	=3D fuse_dentry_release,
> -#endif
>  };
>=20=20
>  int fuse_valid_type(int m)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f870d53a1bcf..3b7794f21573 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -978,6 +978,15 @@ struct fuse_conn {
>  		/* Request timeout (in jiffies). 0 =3D no timeout */
>  		unsigned int req_timeout;
>  	} timeout;
> +
> +	/** Cache dentries tree */
> +	struct rb_root dentry_tree;
> +	/** Look to protect dentry_tree access */
> +	spinlock_t dentry_tree_lock;
> +	/** Periodic delayed work to invalidate expired dentries */
> +	struct delayed_work dentry_tree_work;
> +	/** Period for the invalidation workqueue */
> +	unsigned int inval_wq;
>  };
>=20=20
>  /*
> @@ -1262,6 +1271,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>=20=20
> +void fuse_dentry_tree_prune(struct fuse_conn *fc);
> +void fuse_dentry_tree_work(struct work_struct *work);
> +
>  /**
>   * Invalidate inode attributes
>   */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b399784cca5f..7dbb11937344 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -57,6 +57,20 @@ MODULE_PARM_DESC(max_user_congthresh,
>   "Global limit for the maximum congestion threshold an "
>   "unprivileged user can set");
>=20=20
> +static unsigned __read_mostly inval_wq;
> +static int inval_wq_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 5, (unsigned int)(-1));
> +}
> +static const struct kernel_param_ops inval_wq_ops =3D {
> +	.set =3D inval_wq_set,
> +	.get =3D param_get_uint,
> +};
> +module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
> +__MODULE_PARM_TYPE(inval_wq, "uint");
> +MODULE_PARM_DESC(inval_wq,
> +		 "Dentries invalidation workqueue period in secs (>=3D 5).");
> +
>  #define FUSE_DEFAULT_BLKSIZE 512
>=20=20
>  /** Maximum number of outstanding background requests */
> @@ -959,6 +973,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>  	memset(fc, 0, sizeof(*fc));
>  	spin_lock_init(&fc->lock);
>  	spin_lock_init(&fc->bg_lock);
> +	spin_lock_init(&fc->dentry_tree_lock);
>  	init_rwsem(&fc->killsb);
>  	refcount_set(&fc->count, 1);
>  	atomic_set(&fc->dev_count, 1);
> @@ -968,6 +983,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>  	INIT_LIST_HEAD(&fc->bg_queue);
>  	INIT_LIST_HEAD(&fc->entry);
>  	INIT_LIST_HEAD(&fc->devices);
> +	fc->dentry_tree =3D RB_ROOT;
> +	fc->inval_wq =3D 0;
>  	atomic_set(&fc->num_waiting, 0);
>  	fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
>  	fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
> @@ -1844,6 +1861,9 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
>  	fc->group_id =3D ctx->group_id;
>  	fc->legacy_opts_show =3D ctx->legacy_opts_show;
>  	fc->max_read =3D max_t(unsigned int, 4096, ctx->max_read);
> +	fc->inval_wq =3D inval_wq;
> +	if (fc->inval_wq > 0)
> +		INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
>  	fc->destroy =3D ctx->destroy;
>  	fc->no_control =3D ctx->no_control;
>  	fc->no_force_umount =3D ctx->no_force_umount;
> @@ -2048,6 +2068,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>=20=20
>  	fuse_abort_conn(fc);
>  	fuse_wait_aborted(fc);
> +	fuse_dentry_tree_prune(fc);
>=20=20
>  	if (!list_empty(&fc->entry)) {
>  		mutex_lock(&fuse_mutex);
>

