Return-Path: <linux-fsdevel+bounces-48070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB327AA9341
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1468A176CD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F822578C;
	Mon,  5 May 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r9L+tAUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100582745E;
	Mon,  5 May 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448542; cv=none; b=IM5083y3pFcEOn8yxXArjiseojoNBqB0jieWCYq3lhDuJ6kbOFS3ODLgLd+PXZwBZrrxp8aNjkM3RPccBHXZIn8zLh06PnBUO4MoLPGX/1X9mMxBQgiXTcR+GKaubeJz5sfkWUAGqVqhlOhpGEuHIpxgV3WSMK6dhvABumF/2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448542; c=relaxed/simple;
	bh=/KwnWpU/4RDtBSw1306OO977KMGMgFoX0c+z/c6GyTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1JT3Verma/bV0FF3OJbADC983jUQvX1Ca2l7HF0VfppPWPXBxqRN8xj4P2P8Qw6CFAa+Iwd+kck7rpbnqf4Q8DkApeuN59Vjjo5454Dyk6ewMnnYD//7jCyfRFElYaYSfyLvKfKBP5PyXovL40YWPu2lvopECwSQe5ix9Nsf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r9L+tAUg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XOqoxdgsJ6dPnpxOWTKIvWJudfR4d/f3HgyOg86KqqQ=; b=r9L+tAUg/qkmyVzsyM+UasMEly
	ZoIwT1eFQq4+UDJGdPAshitlSG7HprN2r2RUgF5Ujxkc5+rjGuXl0CWF1bxaRR7IoAxt5ve7aJ+9O
	5uWLBkmraUsAiSChS0qWSmdLcu1CviXx/YbXWWMQcz8IYxMC6SB815B6THmbRB8YXggOdNHpm8BP3
	oqk95OHgdlmGPk9SgeKo84WTOW5fHQORplfaVkccQEXcUdZtnOVnlxercfwOuRtGWwEj/urlnXQ1I
	Ws5wFB7jR3LZ7CQpCYGIm2NDvWC55VBqqsezfcb6SQkYnw1gLf+Wuihyjve6yWd4bCH15vkFfWQMe
	La7qzvKg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uBuzb-003jFf-Et; Mon, 05 May 2025 14:35:29 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v2] fuse: add optional workqueue to periodically
 invalidate expired dentries
In-Reply-To: <20250415133801.28923-1-luis@igalia.com> (Luis Henriques's
	message of "Tue, 15 Apr 2025 14:38:01 +0100")
References: <20250415133801.28923-1-luis@igalia.com>
Date: Mon, 05 May 2025 13:35:28 +0100
Message-ID: <874ixzfd67.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Tue, Apr 15 2025, Luis Henriques wrote:

> This patch adds a new mount option that will allow to set a workqueue to
> periodically invalidate expired dentries.  When this parameter is set,
> every new (or revalidated) dentry will be added to a tree, sorted by
> expiry time.  The workqueue period is set when a filesystem is mounted
> using this new parameter, and can not be less than 5 seconds.
>

I wondering if you had the chance to have a look at this patch already.
Or maybe I misinterpreted your suggestion.

Cheers,
--=20
Lu=C3=ADs

> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> * Changes since v1:
>
> - Add mount option to enable the workqueue and set it's period
> - 'parent' initialisation missing in fuse_dentry_tree_add_node()
>
>  Documentation/filesystems/fuse.rst |   5 +
>  fs/fuse/dir.c                      | 147 +++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h                   |  13 +++
>  fs/fuse/inode.c                    |  18 ++++
>  4 files changed, 183 insertions(+)
>
> diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesyste=
ms/fuse.rst
> index 1e31e87aee68..b0a7be54e611 100644
> --- a/Documentation/filesystems/fuse.rst
> +++ b/Documentation/filesystems/fuse.rst
> @@ -103,6 +103,11 @@ blksize=3DN
>    Set the block size for the filesystem.  The default is 512.  This
>    option is only valid for 'fuseblk' type mounts.
>=20=20
> +inval_wq=3DN
> +  Enable a workqueue that will periodically invalidate dentries that
> +  have expired.  'N' is a value in seconds and has to be bigger than
> +  5 seconds.
> +
>  Control filesystem
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1fb0b15a6088..e16aafc522ef 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -62,6 +62,151 @@ static inline u64 fuse_dentry_time(const struct dentr=
y *entry)
>  }
>  #endif
>=20=20
> +struct dentry_node {
> +	struct rb_node node;
> +	struct dentry *dentry;
> +};
> +
> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
> +{
> +	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
> +	struct dentry_node *dn, *cur;
> +	struct rb_node **p, *parent =3D NULL;
> +	bool start_work =3D false;
> +
> +	if (!fc->inval_wq)
> +		return;
> +
> +	dn =3D kmalloc(sizeof(*dn), GFP_KERNEL);
> +	if (!dn)
> +		return;
> +	dn->dentry =3D dget(dentry);
> +	spin_lock(&fc->dentry_tree_lock);
> +	start_work =3D RB_EMPTY_ROOT(&fc->dentry_tree);
> +	p =3D &fc->dentry_tree.rb_node;
> +	while (*p) {
> +		parent =3D *p;
> +		cur =3D rb_entry(*p, struct dentry_node, node);
> +		if (fuse_dentry_time(dn->dentry) >
> +		    fuse_dentry_time(cur->dentry))
> +			p =3D &(*p)->rb_left;
> +		else
> +			p =3D &(*p)->rb_right;
> +	}
> +	rb_link_node(&dn->node, parent, p);
> +	rb_insert_color(&dn->node, &fc->dentry_tree);
> +	spin_unlock(&fc->dentry_tree_lock);
> +	if (start_work)
> +		schedule_delayed_work(&fc->dentry_tree_work,
> +				      secs_to_jiffies(fc->inval_wq));
> +}
> +
> +static void fuse_dentry_tree_del_node(struct dentry *dentry)
> +{
> +	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
> +	struct dentry_node *cur;
> +	struct rb_node **p;
> +
> +	if (!fc->inval_wq)
> +		return;
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +	p =3D &fc->dentry_tree.rb_node;
> +	while (*p) {
> +		cur =3D rb_entry(*p, struct dentry_node, node);
> +		if (fuse_dentry_time(dentry) > fuse_dentry_time(cur->dentry))
> +			p =3D &(*p)->rb_left;
> +		else if (fuse_dentry_time(dentry) <
> +			 fuse_dentry_time(cur->dentry))
> +			p =3D &(*p)->rb_right;
> +		else {
> +			rb_erase(*p, &fc->dentry_tree);
> +			dput(cur->dentry);
> +			kfree(cur);
> +			break;
> +		}
> +	}
> +	spin_unlock(&fc->dentry_tree_lock);
> +}
> +
> +void fuse_dentry_tree_prune(struct fuse_conn *fc)
> +{
> +	struct rb_node *n;
> +	struct dentry_node *dn;
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
> +		dn =3D rb_entry(n, struct dentry_node, node);
> +		rb_erase(n, &fc->dentry_tree);
> +		dput(dn->dentry);
> +		kfree(dn);
> +	}
> +	spin_unlock(&fc->dentry_tree_lock);
> +}
> +
> +/*
> + * Global workqueue task that will periodically check for expired dentri=
es in
> + * the dentries tree.
> + *
> + * A dentry has expired if:
> + *   1) it has been around for too long or
> + *   2) the connection epoch has been incremented
> + * For this second case, all dentries will be expired.
> + *
> + * The task will be rescheduled as long as the dentries tree is not empt=
y.
> + */
> +void fuse_dentry_tree_work(struct work_struct *work)
> +{
> +	struct fuse_conn *fc =3D container_of(work, struct fuse_conn,
> +					    dentry_tree_work.work);
> +	struct dentry_node *dn;
> +	struct rb_node *node;
> +	struct dentry *entry;
> +	u64 now;
> +	int epoch;
> +	bool expire_all =3D false;
> +	bool is_first =3D true;
> +	bool reschedule;
> +
> +	spin_lock(&fc->dentry_tree_lock);
> +	now =3D get_jiffies_64();
> +	epoch =3D atomic_read(&fc->epoch);
> +
> +	node =3D rb_first(&fc->dentry_tree);
> +
> +	while (node) {
> +		dn =3D rb_entry(node, struct dentry_node, node);
> +		node =3D rb_next(node);
> +		entry =3D dn->dentry;
> +		if (is_first) {
> +			/* expire all entries if epoch was incremented */
> +			if (entry->d_time < epoch)
> +				expire_all =3D true;
> +			is_first =3D false;
> +		}
> +		if (expire_all || (fuse_dentry_time(entry) < now)) {
> +			rb_erase(&dn->node, &fc->dentry_tree);
> +			d_invalidate(entry);
> +			dput(entry);
> +			kfree(dn);
> +		} else
> +			break;
> +	}
> +	reschedule =3D !RB_EMPTY_ROOT(&fc->dentry_tree);
> +	spin_unlock(&fc->dentry_tree_lock);
> +
> +	if (reschedule)
> +		schedule_delayed_work(&fc->dentry_tree_work,
> +				      secs_to_jiffies(fc->inval_wq));
> +}
> +
>  static void fuse_dentry_settime(struct dentry *dentry, u64 time)
>  {
>  	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
> @@ -81,6 +226,7 @@ static void fuse_dentry_settime(struct dentry *dentry,=
 u64 time)
>  	}
>=20=20
>  	__fuse_dentry_settime(dentry, time);
> +	fuse_dentry_tree_add_node(dentry);
>  }
>=20=20
>  /*
> @@ -280,6 +426,7 @@ static int fuse_dentry_revalidate(struct inode *dir, =
const struct qstr *name,
>=20=20
>  invalid:
>  	ret =3D 0;
> +	fuse_dentry_tree_del_node(entry);
>  	goto out;
>  }
>=20=20
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f870d53a1bcf..60be9d982490 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -603,6 +603,7 @@ struct fuse_fs_context {
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> +	unsigned int inval_wq;
>  	const char *subtype;
>=20=20
>  	/* DAX device, may be NULL */
> @@ -978,6 +979,15 @@ struct fuse_conn {
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
> @@ -1262,6 +1272,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
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
> index b399784cca5f..4e9c10e34b2e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -769,6 +769,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_INVAL_WQ,
>  	OPT_ERR
>  };
>=20=20
> @@ -783,6 +784,7 @@ static const struct fs_parameter_spec fuse_fs_paramet=
ers[] =3D {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u32	("inval_wq",		OPT_INVAL_WQ),
>  	{}
>  };
>=20=20
> @@ -878,6 +880,12 @@ static int fuse_parse_param(struct fs_context *fsc, =
struct fs_parameter *param)
>  		ctx->blksize =3D result.uint_32;
>  		break;
>=20=20
> +	case OPT_INVAL_WQ:
> +		if (result.uint_32 < 5)
> +			return invalfc(fsc, "Workqueue period is < 5s");
> +		ctx->inval_wq =3D result.uint_32;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -911,6 +919,8 @@ static int fuse_show_options(struct seq_file *m, stru=
ct dentry *root)
>  			seq_puts(m, ",allow_other");
>  		if (fc->max_read !=3D ~0)
>  			seq_printf(m, ",max_read=3D%u", fc->max_read);
> +		if (fc->inval_wq !=3D 0)
> +			seq_printf(m, ",inval_wq=3D%u", fc->inval_wq);
>  		if (sb->s_bdev && sb->s_blocksize !=3D FUSE_DEFAULT_BLKSIZE)
>  			seq_printf(m, ",blksize=3D%lu", sb->s_blocksize);
>  	}
> @@ -959,6 +969,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>  	memset(fc, 0, sizeof(*fc));
>  	spin_lock_init(&fc->lock);
>  	spin_lock_init(&fc->bg_lock);
> +	spin_lock_init(&fc->dentry_tree_lock);
>  	init_rwsem(&fc->killsb);
>  	refcount_set(&fc->count, 1);
>  	atomic_set(&fc->dev_count, 1);
> @@ -968,6 +979,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>  	INIT_LIST_HEAD(&fc->bg_queue);
>  	INIT_LIST_HEAD(&fc->entry);
>  	INIT_LIST_HEAD(&fc->devices);
> +	fc->dentry_tree =3D RB_ROOT;
> +	fc->inval_wq =3D 0;
>  	atomic_set(&fc->num_waiting, 0);
>  	fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
>  	fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
> @@ -1844,6 +1857,9 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
>  	fc->group_id =3D ctx->group_id;
>  	fc->legacy_opts_show =3D ctx->legacy_opts_show;
>  	fc->max_read =3D max_t(unsigned int, 4096, ctx->max_read);
> +	fc->inval_wq =3D ctx->inval_wq;
> +	if (fc->inval_wq > 0)
> +		INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
>  	fc->destroy =3D ctx->destroy;
>  	fc->no_control =3D ctx->no_control;
>  	fc->no_force_umount =3D ctx->no_force_umount;
> @@ -2009,6 +2025,7 @@ static int fuse_init_fs_context(struct fs_context *=
fsc)
>  		return -ENOMEM;
>=20=20
>  	ctx->max_read =3D ~0;
> +	ctx->inval_wq =3D 0;
>  	ctx->blksize =3D FUSE_DEFAULT_BLKSIZE;
>  	ctx->legacy_opts_show =3D true;
>=20=20
> @@ -2048,6 +2065,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>=20=20
>  	fuse_abort_conn(fc);
>  	fuse_wait_aborted(fc);
> +	fuse_dentry_tree_prune(fc);
>=20=20
>  	if (!list_empty(&fc->entry)) {
>  		mutex_lock(&fuse_mutex);
>


