Return-Path: <linux-fsdevel+bounces-37880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F09F8632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 21:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1F1895CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAB1C2304;
	Thu, 19 Dec 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImN9BSAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AB1A0BDB
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641085; cv=none; b=sVxrD1idEwnw/5YiE0fzOQtKvOgZ7KFVIs0XVXwOzTI8FpO8oAE/SKdqy8TDLbi2dB/EyX6c7W9j2tm4BkHTfNg9eQE48CZfBkEjGDCLDC/Eka5ZYLIwBXjwKSqIq9yTn6PrEQQC1bMbSmqd4ZXmYNReeDTY/vrtYNNxJnmNJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641085; c=relaxed/simple;
	bh=+qMni8dG6abeUOAQ5BHmpSNqUPPx/oVG4feU+C77fEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuDkpB27seP+fXEwu1RqUzmgpmVn3fTgiop1f+9SKJl8t5ff6rFHIZm9rGxtCxoNO5exRW5OWYMfTj3gV5FnOMhef8fR0v9T3JAxS0Eox39EPKAh1EDHpmfZqWjQJQrqE0rLH2V6DI7+kXWN4gZZEKCs/xn7F1UW5zRmxLJUKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImN9BSAN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a1ee7ff2so9478161cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734641082; x=1735245882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJTl1UqpqYWwf/s+zJr5/L9ru1ntD41SE85JllxNjRU=;
        b=ImN9BSANJQ9dRa5ljRF/7xiFs+UZ+lYnGWKFB4ZJx4DZRsJBFjwiGxofhY6b+nUJfq
         TM6yBPOMZpI2eil1ABlCl/vpAzjFqS3iDo0Iqi39zmF77G5nofVAywuUyhqJCDzE+dgQ
         IutO1iIDdYYoXbETS+cemYJSfJAv3CNVWTU4Ymw8xEWvNGw8dLoC+9ACRlcXvRxMnZ4K
         /jx/vnMql62MJYxc3gOy0v4spOOw69JJGHx1rTOyeXPPT+gytQqx7rEG9cQS3Fciz1T1
         MYhGaVfudsx725cpspIuAXO7uj91kWMWzQKa31iYu0pVfebxKHDG8b6L6h7Naf/kk2Qz
         rCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641082; x=1735245882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJTl1UqpqYWwf/s+zJr5/L9ru1ntD41SE85JllxNjRU=;
        b=q6rBtNi52cdbRhJPXXCMkbdO3ddiPZ2dFcCjQ5Pk8p6dWZy/QwR8CjxzfbTU+OSFsx
         6hhDFrEzFrbl2+Ub3EuKUoD/QNtxXY0wkTfii4FyVzN4gzaagDLv2f8Ln1aZShozjmiV
         R8FGdgnNTIlzkm2uu7qxlxRur9KMN/U/WRKvU2VcTX9OhD6vNd3YZlUoUkbhmz24zdEl
         Pxm4jlNm18b27gu8ijwXAHzhGle8yt3CRoNous1ZB1IwNGS9zccDO/RoEYRAYV8b3Kqb
         c95F06qjUJdFenLlam18wAUKGvVJsogGfrBHlKY5WQ1neZSnVHihNxNPRe77ARm+fLYs
         cY1w==
X-Forwarded-Encrypted: i=1; AJvYcCXR0uyDbCgq2mskR7EMB8KEJw4U5IoUbcsX7zrEpFKfT454nqPdeEcVKW2SZXoIcG9A9jkcpH6eak4KrRd4@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/RIa23b9zH/XXHiM4PPhE8uFPFZNOduU80tze2rmyS0FHXdu
	4GjYNr4xtACLW5R1QSIxliRQzhF19Dd9EyV6hf6tKz6uWrIpYcGdtgm4FxmSXc0n46eSawfuWbR
	ayXr831zwNgVSNRVQMCm6lQvncoU=
X-Gm-Gg: ASbGncut/yl0aK+lLzpxZbeln85kMklo1daBNQI51PcbhiCCGtU+Pmq9RuwSoqQsHL8
	9Pomll0DmU8gYcjIZ/MTceCrbW5ajvDAUXvMVva0=
X-Google-Smtp-Source: AGHT+IFRs4q7ljszN7n3I8Y2/xlFInVGd3+Jrjrkw2NYAeK+UWqSsthxPQkW7GFU61Kwc1J2ER5KmrNu8ZZerOOnoWM=
X-Received: by 2002:ac8:5fcd:0:b0:461:161b:c178 with SMTP id
 d75a77b69052e-46a4a8e2635mr7307681cf.13.1734641082510; Thu, 19 Dec 2024
 12:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218222630.99920-1-joannelkoong@gmail.com> <20241218222630.99920-2-joannelkoong@gmail.com>
In-Reply-To: <20241218222630.99920-2-joannelkoong@gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Thu, 19 Dec 2024 15:44:31 -0500
Message-ID: <CAMHPp_RSBbmq7qci1dG9oauz4ST_aQyZZd=Nsa0ZBKB24v0D6g@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] fuse: add kernel-enforced timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:27=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>
> This commit adds an option for enforcing a timeout (in seconds) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
>
> Please note that these timeouts are not 100% precise. For example, the
> request may take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond
> the requested timeout due to internal implementation, in order to
> mitigate overhead.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

This solution seems to be holding fine with my TC. However, personally
as a non-fuse person, I feel that it's hard to judge if the check
timeout logic is doing the right thing in every scenario and more
specifically for my use-case where I'm going to backport that logic to
older stable branches.

So for that reason I've been trying to figure out a simpler solution
and I stumbled on something last night which is giving good results so
far. Just a basic time distribution sliding window. Very
straightforward, no list, no timer scale issue and low overhead.
Sending that patch as a RFC to see if we can leverage that trick
maybe... OR something along those lines?

https://lore.kernel.org/linux-fsdevel/20241219204149.11958-2-etmartin4313@g=
mail.com/T/#mcfa362bf41860e151177a2aa49eee8a141324477

PS I don't want to put a monkey wrench into this series and again this
solution is holding fine for me. I'm just looking for something more
straightforward if possible.

thanks,
Etienne



>  fs/fuse/dev.c    | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 22 +++++++++++++
>  fs/fuse/inode.c  | 23 +++++++++++++
>  3 files changed, 130 insertions(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..bcf8a7994944 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,87 @@ static struct fuse_dev *fuse_get_dev(struct file *file=
)
>         return READ_ONCE(file->private_data);
>  }
>
> +static bool request_expired(struct fuse_conn *fc, struct list_head *list=
)
> +{
> +       struct fuse_req *req;
> +
> +       req =3D list_first_entry_or_null(list, struct fuse_req, list);
> +       if (!req)
> +               return false;
> +       return time_is_before_jiffies(req->create_time + fc->timeout.req_=
timeout);
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
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> +                                           timeout.work);
> +       struct fuse_iqueue *fiq =3D &fc->iq;
> +       struct fuse_dev *fud;
> +       struct fuse_pqueue *fpq;
> +       bool expired =3D false;
> +       int i;
> +
> +       if (!atomic_read(&fc->num_waiting))
> +           goto out;
> +
> +       spin_lock(&fiq->lock);
> +       expired =3D request_expired(fc, &fiq->pending);
> +       spin_unlock(&fiq->lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->bg_lock);
> +       expired =3D request_expired(fc, &fc->bg_queue);
> +       spin_unlock(&fc->bg_lock);
> +       if (expired)
> +               goto abort_conn;
> +
> +       spin_lock(&fc->lock);
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               return;
> +       }
> +       list_for_each_entry(fud, &fc->devices, entry) {
> +               fpq =3D &fud->pq;
> +               spin_lock(&fpq->lock);
> +               if (request_expired(fc, &fpq->io))
> +                       goto fpq_abort;
> +
> +               for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +                       if (request_expired(fc, &fpq->processing[i]))
> +                               goto fpq_abort;
> +               }
> +               spin_unlock(&fpq->lock);
> +       }
> +       spin_unlock(&fc->lock);
> +
> +out:
> +       queue_delayed_work(system_wq, &fc->timeout.work,
> +                          secs_to_jiffies(FUSE_TIMEOUT_TIMER_FREQ));
> +       return;
> +
> +fpq_abort:
> +       spin_unlock(&fpq->lock);
> +       spin_unlock(&fc->lock);
> +abort_conn:
> +       fuse_abort_conn(fc);
> +}
> +
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *re=
q)
>  {
>         INIT_LIST_HEAD(&req->list);
> @@ -53,6 +134,7 @@ static void fuse_request_init(struct fuse_mount *fm, s=
truct fuse_req *req)
>         refcount_set(&req->count, 1);
>         __set_bit(FR_PENDING, &req->flags);
>         req->fm =3D fm;
> +       req->create_time =3D jiffies;
>  }
>
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t =
flags)
> @@ -2260,6 +2342,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>                 LIST_HEAD(to_end);
>                 unsigned int i;
>
> +               if (fc->timeout.req_timeout)
> +                       cancel_delayed_work(&fc->timeout.work);
> +
>                 /* Background queuing checks fc->connected under bg_lock =
*/
>                 spin_lock(&fc->bg_lock);
>                 fc->connected =3D 0;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..26eb00e5f043 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -438,6 +438,9 @@ struct fuse_req {
>
>         /** fuse_mount this request belongs to */
>         struct fuse_mount *fm;
> +
> +       /** When (in jiffies) the request was created */
> +       unsigned long create_time;
>  };
>
>  struct fuse_iqueue;
> @@ -528,6 +531,17 @@ struct fuse_pqueue {
>         struct list_head io;
>  };
>
> +/* Frequency (in seconds) of request timeout checks, if opted into */
> +#define FUSE_TIMEOUT_TIMER_FREQ 15
> +
> +struct fuse_timeout {
> +       /* Worker for checking if any requests have timed out */
> +       struct delayed_work work;
> +
> +       /* Request timeout (in jiffies). 0 =3D no timeout */
> +       unsigned long req_timeout;
> +};
> +
>  /**
>   * Fuse device instance
>   */
> @@ -574,6 +588,8 @@ struct fuse_fs_context {
>         enum fuse_dax_mode dax_mode;
>         unsigned int max_read;
>         unsigned int blksize;
> +       /*  Request timeout (in seconds). 0 =3D no timeout (infinite wait=
) */
> +       unsigned int req_timeout;
>         const char *subtype;
>
>         /* DAX device, may be NULL */
> @@ -923,6 +939,9 @@ struct fuse_conn {
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> +
> +       /** Only used if the connection enforces request timeouts */
> +       struct fuse_timeout timeout;
>  };
>
>  /*
> @@ -1191,6 +1210,9 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>
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
>         OPT_ALLOW_OTHER,
>         OPT_MAX_READ,
>         OPT_BLKSIZE,
> +       OPT_REQUEST_TIMEOUT,
>         OPT_ERR
>  };
>
> @@ -779,6 +780,7 @@ static const struct fs_parameter_spec fuse_fs_paramet=
ers[] =3D {
>         fsparam_u32     ("max_read",            OPT_MAX_READ),
>         fsparam_u32     ("blksize",             OPT_BLKSIZE),
>         fsparam_string  ("subtype",             OPT_SUBTYPE),
> +       fsparam_u32     ("request_timeout",     OPT_REQUEST_TIMEOUT),
>         {}
>  };
>
> @@ -874,6 +876,10 @@ static int fuse_parse_param(struct fs_context *fsc, =
struct fs_parameter *param)
>                 ctx->blksize =3D result.uint_32;
>                 break;
>
> +       case OPT_REQUEST_TIMEOUT:
> +               ctx->req_timeout =3D result.uint_32;
> +               break;
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -1004,6 +1010,8 @@ void fuse_conn_put(struct fuse_conn *fc)
>
>                 if (IS_ENABLED(CONFIG_FUSE_DAX))
>                         fuse_dax_conn_free(fc);
> +               if (fc->timeout.req_timeout)
> +                       cancel_delayed_work_sync(&fc->timeout.work);
>                 if (fiq->ops->release)
>                         fiq->ops->release(fiq);
>                 put_pid_ns(fc->pid_ns);
> @@ -1723,6 +1731,20 @@ int fuse_init_fs_context_submount(struct fs_contex=
t *fsc)
>  }
>  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_co=
ntext *ctx)
> +{
> +       if (ctx->req_timeout) {
> +               if (check_mul_overflow(ctx->req_timeout, HZ, &fc->timeout=
.req_timeout))
> +                       fc->timeout.req_timeout =3D ULONG_MAX;
> +
> +               INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
> +               queue_delayed_work(system_wq, &fc->timeout.work,
> +                                  secs_to_jiffies(FUSE_TIMEOUT_TIMER_FRE=
Q));
> +       } else {
> +               fc->timeout.req_timeout =3D 0;
> +       }
> +}
> +
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_contex=
t *ctx)
>  {
>         struct fuse_dev *fud =3D NULL;
> @@ -1785,6 +1807,7 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
>         fc->destroy =3D ctx->destroy;
>         fc->no_control =3D ctx->no_control;
>         fc->no_force_umount =3D ctx->no_force_umount;
> +       fuse_init_fc_timeout(fc, ctx);
>
>         err =3D -ENOMEM;
>         root =3D fuse_get_root_inode(sb, ctx->rootmode);
> --
> 2.43.5
>

