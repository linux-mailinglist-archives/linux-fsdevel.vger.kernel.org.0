Return-Path: <linux-fsdevel+bounces-36675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84369E79DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4FC18818D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C351D90BD;
	Fri,  6 Dec 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVHzHYVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBED1C5490
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515947; cv=none; b=V9I8ftXhc6S5OjPE5WdgIIxgqEn0yLz4RMj+KvJ3xO+0C1Eh50tSCi7K3YWKWTo++bVQowEHDuwUmniiQ5PR+VoGXbcbEJGvQUK79KuHPLEyGIgxSvj3zHSKMSfPbV1isSH6zDdxDVXoiOprPbXRk4eL3HZgOax3LbJ9yw9VIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515947; c=relaxed/simple;
	bh=0C52Sn5Gxq/tr6ghaONRhyjaKJ5kVGpO8URfZgv0FDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uv/o3buOBAiZnWmw3DIdXMEiplNwwPi4YUAfCYO99TPPOKlf9M8WK3hx9u//cWiF1bvqbtHKQuA+964oipGu00L2xdW14ohRHM4a11DhbHytbIGm3k+K82Na8w9KVG98I2Mqqkz/DdhLtqaoyItvba9K/Xra+8S+COL3MNpgLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVHzHYVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B3C4CED1;
	Fri,  6 Dec 2024 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515947;
	bh=0C52Sn5Gxq/tr6ghaONRhyjaKJ5kVGpO8URfZgv0FDM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hVHzHYVGJnzFnC26UiEKyYLYDThrHoWbdgjyguMmjRogW1Ss2jZtpvDL3UEnmIeik
	 PAH2CP5N15XJ9iI7TGvj0uA3TNhJ+JgTTwxnwIrmIMZko5rumjZAf1AdWTGaHX5n7Q
	 AsKWhVYgsOel5g01dUcrY4ZA/M39IRclR76fQW04wHo1zhJrkWuHJBRzWUWNXvpC66
	 1t2+I5+9AjHFZqpeCPX/GWdwuZN/A+jkHha4951Q6aBm0y0jblL70cicHa2dcYF/TI
	 defxmbt/+OM3MzLFW+rAB+HrqEckR5ADIVASiv7gOJ4DDjISKC+QM5aeeBh74FRCcx
	 ynZ9Ai05ZyiuA==
Message-ID: <4321a4aca4f67226165004b7096b417f88c11e7e.camel@kernel.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced
 timeout for requests
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com,
 Bernd Schubert <bschubert@ddn.com>
Date: Fri, 06 Dec 2024 15:12:25 -0500
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
	 <20241114191332.669127-3-joannelkoong@gmail.com>
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

On Thu, 2024-11-14 at 11:13 -0800, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>=20
> This commit adds an option for enforcing a timeout (in minutes) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
>=20
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> timeout due to how it's internally implemented.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 21 +++++++++++++
>  fs/fuse/inode.c  | 21 +++++++++++++
>  3 files changed, 122 insertions(+)
>=20
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 29fc61a072ba..536aa4525e8f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *file=
)
>  	return READ_ONCE(file->private_data);
>  }
> =20
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	return jiffies > req->create_time + fc->timeout.req_timeout;
> +}
> +
> +/*
> + * Check if any requests aren't being completed by the specified request
> + * timeout. To do so, we:
> + * - check the fiq pending list
> + * - check the bg queue
> + * - check the fpq io and processing lists
> + *
> + * To make this fast, we only check against the head request on each lis=
t since
> + * these are generally queued in order of creation time (eg newer reques=
ts get
> + * queued to the tail). We might miss a few edge cases (eg requests tran=
sitioning
> + * between lists, re-sent requests at the head of the pending list havin=
g a
> + * later creation time than other requests on that list, etc.) but that =
is fine
> + * since if the request never gets fulfilled, it will eventually be caug=
ht.
> + */
> +void fuse_check_timeout(struct timer_list *timer)
> +{
> +	struct fuse_conn *fc =3D container_of(timer, struct fuse_conn, timeout.=
timer);
> +	struct fuse_iqueue *fiq =3D &fc->iq;
> +	struct fuse_req *req;
> +	struct fuse_dev *fud;
> +	struct fuse_pqueue *fpq;
> +	bool expired =3D false;
> +	int i;
> +
> +	spin_lock(&fiq->lock);
> +	req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
> +	if (req)
> +		expired =3D request_expired(fc, req);
> +	spin_unlock(&fiq->lock);
> +	if (expired)
> +		goto abort_conn;
> +
> +	spin_lock(&fc->bg_lock);
> +	req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req, list);
> +	if (req)
> +		expired =3D request_expired(fc, req);
> +	spin_unlock(&fc->bg_lock);
> +	if (expired)
> +		goto abort_conn;
> +
> +	spin_lock(&fc->lock);
> +	if (!fc->connected) {
> +		spin_unlock(&fc->lock);
> +		return;
> +	}
> +	list_for_each_entry(fud, &fc->devices, entry) {
> +		fpq =3D &fud->pq;
> +		spin_lock(&fpq->lock);
> +		req =3D list_first_entry_or_null(&fpq->io, struct fuse_req, list);
> +		if (req && request_expired(fc, req))
> +			goto fpq_abort;
> +
> +		for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +			req =3D list_first_entry_or_null(&fpq->processing[i], struct fuse_req=
, list);
> +			if (req && request_expired(fc, req))
> +				goto fpq_abort;
> +		}
> +		spin_unlock(&fpq->lock);
> +	}
> +	spin_unlock(&fc->lock);
> +
> +	mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> +	return;
> +
> +fpq_abort:
> +	spin_unlock(&fpq->lock);
> +	spin_unlock(&fc->lock);
> +abort_conn:
> +	fuse_abort_conn(fc);
> +}
> +
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *re=
q)
>  {
>  	INIT_LIST_HEAD(&req->list);
> @@ -53,6 +129,7 @@ static void fuse_request_init(struct fuse_mount *fm, s=
truct fuse_req *req)
>  	refcount_set(&req->count, 1);
>  	__set_bit(FR_PENDING, &req->flags);
>  	req->fm =3D fm;
> +	req->create_time =3D jiffies;
>  }
> =20
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t =
flags)
> @@ -2308,6 +2385,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
> =20
>  		end_requests(&to_end);
> +
> +		if (fc->timeout.req_timeout)
> +			timer_delete(&fc->timeout.timer);
>  	} else {
>  		spin_unlock(&fc->lock);
>  	}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index d35c37ccf9b5..9092201c4e0b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -438,6 +438,9 @@ struct fuse_req {
> =20
>  	/** fuse_mount this request belongs to */
>  	struct fuse_mount *fm;
> +
> +	/** When (in jiffies) the request was created */
> +	unsigned long create_time;
>  };
> =20
>  struct fuse_iqueue;
> @@ -528,6 +531,16 @@ struct fuse_pqueue {
>  	struct list_head io;
>  };
> =20
> +/* Frequency (in seconds) of request timeout checks, if opted into */
> +#define FUSE_TIMEOUT_TIMER_FREQ 60 * HZ
> +
> +struct fuse_timeout {
> +	struct timer_list timer;
> +
> +	/* Request timeout (in jiffies). 0 =3D no timeout */
> +	unsigned long req_timeout;
> +};
> +
>  /**
>   * Fuse device instance
>   */
> @@ -574,6 +587,8 @@ struct fuse_fs_context {
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> +	/*  Request timeout (in minutes). 0 =3D no timeout (infinite wait) */
> +	unsigned int req_timeout;
>  	const char *subtype;
> =20
>  	/* DAX device, may be NULL */
> @@ -920,6 +935,9 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/** Only used if the connection enforces request timeouts */
> +	struct fuse_timeout timeout;
>  };
> =20
>  /*
> @@ -1181,6 +1199,9 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
> =20
> +/* Check if any requests timed out */
> +void fuse_check_timeout(struct timer_list *timer);
> +
>  /**
>   * Invalidate inode attributes
>   */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f1779ff3f8d1..ee006f09cd04 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -735,6 +735,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_REQUEST_TIMEOUT,
>  	OPT_ERR
>  };
> =20
> @@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_paramet=
ers[] =3D {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u16	("request_timeout",	OPT_REQUEST_TIMEOUT),
>  	{}
>  };
> =20
> @@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc, =
struct fs_parameter *param)
>  		ctx->blksize =3D result.uint_32;
>  		break;
> =20
> +	case OPT_REQUEST_TIMEOUT:
> +		ctx->req_timeout =3D result.uint_16;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -973,6 +979,8 @@ void fuse_conn_put(struct fuse_conn *fc)
> =20
>  		if (IS_ENABLED(CONFIG_FUSE_DAX))
>  			fuse_dax_conn_free(fc);
> +		if (fc->timeout.req_timeout)
> +			timer_shutdown_sync(&fc->timeout.timer);
>  		if (fiq->ops->release)
>  			fiq->ops->release(fiq);
>  		put_pid_ns(fc->pid_ns);
> @@ -1691,6 +1699,18 @@ int fuse_init_fs_context_submount(struct fs_contex=
t *fsc)
>  }
>  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
> =20
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_co=
ntext *ctx)
> +{
> +	if (ctx->req_timeout) {
> +		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_tim=
eout))
> +			fc->timeout.req_timeout =3D ULONG_MAX;
> +		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> +		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> +	} else {
> +		fc->timeout.req_timeout =3D 0;
> +	}
> +}
> +


Does fuse_check_timeout need to run in IRQ context? It doesn't seem
like it does. Have you considered setting up a recurring delayed
workqueue job instead? That would run in process context, which might
make the locking in that function less hairy.


>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_contex=
t *ctx)
>  {
>  	struct fuse_dev *fud =3D NULL;
> @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
>  	fc->destroy =3D ctx->destroy;
>  	fc->no_control =3D ctx->no_control;
>  	fc->no_force_umount =3D ctx->no_force_umount;
> +	fuse_init_fc_timeout(fc, ctx);
> =20
>  	err =3D -ENOMEM;
>  	root =3D fuse_get_root_inode(sb, ctx->rootmode);

--=20
Jeff Layton <jlayton@kernel.org>

