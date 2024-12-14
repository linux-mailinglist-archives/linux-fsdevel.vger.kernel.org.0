Return-Path: <linux-fsdevel+bounces-37421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E82D9F1E79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 13:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F41889DF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8166518FDBA;
	Sat, 14 Dec 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHlAVjqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8C16F0E8
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734178211; cv=none; b=WEMYseaL0CAZ9KeZIq9vNpukXNk9Ml/9Vi4uxrNmrBRkMVNP2b6owAx5WnpDwEISQ981HHYTl0hKS1X//xB/pi2QKnZPGiwbti75aUlr1VTkfB866zw+bxYQDGz8hd1+bgDCkQyv4YyC5c3/rfKiSTZnBO2w5eQ3fi18zC7YTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734178211; c=relaxed/simple;
	bh=KH3pfpJtJxzzuTmRSFTrAUipRssDF/pJojPF1tP59aY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4yEFXi58CX79EFPN0dPjd5niT3RCL35BJ9XBK0nso2l+m3XhGu8MsMOI1fX3UOv31ODuQrO58NdML4eC6fpnvF7PKw5O78rvUUZnmhCaUCDIDcwxZWHaDWNWrnd6IMOgEG77HgcQ4j46rqGlZpiO0eIJujJx17vcfpNSieQ5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHlAVjqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F460C4CED1;
	Sat, 14 Dec 2024 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734178211;
	bh=KH3pfpJtJxzzuTmRSFTrAUipRssDF/pJojPF1tP59aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pHlAVjqUCkYERsxy94dn2hyUxoRsKGvILjoPypnuu/fyVvtD4kmYVi3CBXTSje88+
	 dM7/XNlsElSr0CIxHP+fLGLHfcxTzV1+czbJpb7h6qLoSh9uSjXi+n1NWeTH3dYxPq
	 LKWFU332aXiTyAhmPRe+z6b/SWQLu9+aW6H+ndCFo/O9XHvlI+WInbpP9thzu38WC7
	 aRFMqybFF/Dd4zc4l55iXgvEpOquXogoevp6UBDONU7jA7bVg351B7RaEtm44AVRPR
	 7vkUxvSiMeBBSsD3a6S+AcCGxGvzi/ogMZZ10eOxzoGJOwIaPfRL9Itnu4OLKBn0XU
	 qy6uV10YnBrzQ==
Message-ID: <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for
 requests
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, senozhatsky@chromium.org,
 	tfiga@chromium.org, bgeffon@google.com, etmartin4313@gmail.com, 
	kernel-team@meta.com
Date: Sat, 14 Dec 2024 07:09:44 -0500
In-Reply-To: <20241214022827.1773071-2-joannelkoong@gmail.com>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
	 <20241214022827.1773071-2-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 18:28 -0800, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>=20
> This commit adds an option for enforcing a timeout (in seconds) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
>=20
> Please note that these timeouts are not 100% precise. For example, the
> request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond
> the requested timeout due to internal implementation, in order to
> mitigate overhead.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 22 +++++++++++++
>  fs/fuse/inode.c  | 23 ++++++++++++++
>  3 files changed, 128 insertions(+)
>=20
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..e97ba860ffcd 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,85 @@ static struct fuse_dev *fuse_get_dev(struct file *file=
)
>  	return READ_ONCE(file->private_data);
>  }
> =20
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeou=
t);
> +}
> +
> +/*
> + * Check if any requests aren't being completed by the time the request =
timeout
> + * elapses. To do so, we:
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
> +void fuse_check_timeout(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D to_delayed_work(work);
> +	struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> +					    timeout.work);
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
> +	queue_delayed_work(system_wq, &fc->timeout.work,
> +			   secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
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
> @@ -53,6 +132,7 @@ static void fuse_request_init(struct fuse_mount *fm, s=
truct fuse_req *req)
>  	refcount_set(&req->count, 1);
>  	__set_bit(FR_PENDING, &req->flags);
>  	req->fm =3D fm;
> +	req->create_time =3D jiffies;
>  }
> =20
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t =
flags)
> @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
> =20
>  		end_requests(&to_end);
> +
> +		if (fc->timeout.req_timeout)
> +			cancel_delayed_work(&fc->timeout.work);

As Sergey pointed out, this should be a cancel_delayed_work_sync(). The
workqueue job can still be running after cancel_delayed_work(), and
since it requeues itself, this might not be enough to kill it
completely.

Also, I'd probably do this at the start of fuse_abort_conn() instead of
waiting until the end. By the time you're in that function, you're
killing the connection anyway, and you probably don't want the
workqueue job running at the same time. They'll just end up competing
for the same locks.

>  	} else {
>  		spin_unlock(&fc->lock);
>  	}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..26eb00e5f043 100644
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
> @@ -528,6 +531,17 @@ struct fuse_pqueue {
>  	struct list_head io;
>  };
> =20
> +/* Frequency (in seconds) of request timeout checks, if opted into */
> +#define FUSE_TIMEOUT_TIMER_FREQ 15
> +
> +struct fuse_timeout {
> +	/* Worker for checking if any requests have timed out */
> +	struct delayed_work work;
> +
> +	/* Request timeout (in jiffies). 0 =3D no timeout */
> +	unsigned long req_timeout;
> +};
> +
>  /**
>   * Fuse device instance
>   */
> @@ -574,6 +588,8 @@ struct fuse_fs_context {
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> +	/*  Request timeout (in seconds). 0 =3D no timeout (infinite wait) */
> +	unsigned int req_timeout;
>  	const char *subtype;
> =20
>  	/* DAX device, may be NULL */
> @@ -923,6 +939,9 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/** Only used if the connection enforces request timeouts */
> +	struct fuse_timeout timeout;
>  };
> =20
>  /*
> @@ -1191,6 +1210,9 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
> =20
> +/* Check if any requests timed out */
> +void fuse_check_timeout(struct work_struct *work);
> +
>  /**
>   * Invalidate inode attributes
>   */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..02dac88d922e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -765,6 +765,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_REQUEST_TIMEOUT,
>  	OPT_ERR
>  };
> =20
> @@ -779,6 +780,7 @@ static const struct fs_parameter_spec fuse_fs_paramet=
ers[] =3D {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u32	("request_timeout",	OPT_REQUEST_TIMEOUT),
>  	{}
>  };
> =20
> @@ -874,6 +876,10 @@ static int fuse_parse_param(struct fs_context *fsc, =
struct fs_parameter *param)
>  		ctx->blksize =3D result.uint_32;
>  		break;
> =20
> +	case OPT_REQUEST_TIMEOUT:
> +		ctx->req_timeout =3D result.uint_32;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1004,6 +1010,8 @@ void fuse_conn_put(struct fuse_conn *fc)
> =20
>  		if (IS_ENABLED(CONFIG_FUSE_DAX))
>  			fuse_dax_conn_free(fc);
> +		if (fc->timeout.req_timeout)
> +			cancel_delayed_work_sync(&fc->timeout.work);
>  		if (fiq->ops->release)
>  			fiq->ops->release(fiq);
>  		put_pid_ns(fc->pid_ns);
> @@ -1723,6 +1731,20 @@ int fuse_init_fs_context_submount(struct fs_contex=
t *fsc)
>  }
>  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
> =20
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_co=
ntext *ctx)
> +{
> +	if (ctx->req_timeout) {
> +		if (check_mul_overflow(ctx->req_timeout, HZ, &fc->timeout.req_timeout)=
)
> +			fc->timeout.req_timeout =3D ULONG_MAX;
> +
> +		INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
> +		queue_delayed_work(system_wq, &fc->timeout.work,
> +				   secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
> +	} else {
> +		fc->timeout.req_timeout =3D 0;
> +	}
> +}
> +
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_contex=
t *ctx)
>  {
>  	struct fuse_dev *fud =3D NULL;
> @@ -1785,6 +1807,7 @@ int fuse_fill_super_common(struct super_block *sb, =
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

