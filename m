Return-Path: <linux-fsdevel+bounces-33270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E79B6AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210DD1C23429
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F64217902;
	Wed, 30 Oct 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9RAKVva"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5467216E18
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308893; cv=none; b=LsA7bCkIbfNZy5ABBetmHAT8HNBgPhoWfh7VZ6OpvZARu4sIIJNuwkg/SrJp4z7aZBudTxhnfk+lKM4VLRG++Y4kNm2TBfLvxcql80IeV2XmBkuR8sQa3L3bB5pC6tHPr1Z5ft6YPm1EpSaK1sT9W/cq0+KxmcU+/S9kfD7pWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308893; c=relaxed/simple;
	bh=h9ZoV6PU9Vwga3npxCLp9st+OWybouy1Yu7vioenGIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhDlMdm2QaAqB08WpUAA0BfGU16Vf1gSYLxF50IFOTzPt1IwkfbW0l1I4gdp999mT/ovrGSmnq19V7khq2kQBvVuPozNnyYBKeoOpRIkc9WQsFfx8KQxP+VVWURP6ltlTM76zBmuYSNMF40fiRG+6AhlSP6ipuTuY3HxIl3kDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9RAKVva; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460ad0440ddso781521cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308889; x=1730913689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMRUO/DsLQtA92CbNruySHsqUzJiOyGvqy9EOksh9eg=;
        b=E9RAKVvaiAkd8/irH3UgNvD8dPNHO4gI+UgVv8hCZnwlbXfLoLirClvLzXmkxznrS9
         l3a0xghtTAmpSz4hAQOR/OOMUlu1dcjYVhcenrduXVMgiRCmxclrhrv42nksdM/DxOJg
         NfxcxaYLJtC29lywg8LE7Z70Kwz6wNJ/AK2x4tTRe8BxqjwI0k4yhfD+TFFsRck5HVST
         Ckfe4heITnfKL2WiA4OiAOfuRnhEkhF53iHvb8jhoEemvnm0J2tx45v4k90HxI1xM2Xh
         k0Ic+qH9pLmeSh5kBdngviP/gOgMV6Au707lq5p9mT76HWjN+Wy1XAlQdNkQfYlByUlj
         l+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308889; x=1730913689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMRUO/DsLQtA92CbNruySHsqUzJiOyGvqy9EOksh9eg=;
        b=NEdr2u79QWKVldp5p61Ch6VBZD8HXcAh7MeQaCFsJmxmgS0qYKY9sleXDwYn4aCtEc
         hAChHm0Cu+G5rwHWPQkPVRrB6fLkAkL7p4nFQCnHKyiE2l2BOv8vFl3+Nrmpq2egoa8d
         Z5IGe5gbe9SQvzJfe36wU/BcAdEIKmR4Boo7tlfb5LrpWCNw9xUTwihAgqTlN6njfjjW
         r3e/+M6ldrdMFMWMYbsW5V+dEKCbfQ6dmt6qjTVgd3RYvX+wZtoXZfSDTdiL7KnJ4RSU
         L+Fe80Tg3dwyuoyQX6ZWP3Q4pmIGzA/TvDQRpVo6umcvj8pHPu7W95VLbs4Qi0yRfqdE
         GhVA==
X-Forwarded-Encrypted: i=1; AJvYcCXb+6pkb/sf8fQtM6cE+IdQgCmqsfehfRJMZxEsj9Y3kJ8Z9XGuWoAlKCoFQNMRTQou+X38fyJnlvRTXyG3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gey2PkpWLm7MNfH8HaHkwtZx6GGsddLDGoX9r4VrItDldZv6
	yB+ULbQDNFpdnHA//UwEC7gPM6NZluje0woncdzMdLcu5+8KuCwRnmyMkawW0YnEjRSYMUqOGMY
	/eKMkaK67zEITxv5uXY3TyGnIYs4=
X-Google-Smtp-Source: AGHT+IHRLub3W9xftE0vwMRE0k3VD9Pe4dJdnE21+5czHcW4+gwXus6D3uSq50AcDcZ4HEfzAhLNKqdnL9iLD0FCkaA=
X-Received: by 2002:a05:622a:2c2:b0:460:e2d8:9d3c with SMTP id
 d75a77b69052e-4613c19840fmr239221001cf.56.1730308889475; Wed, 30 Oct 2024
 10:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-3-joannelkoong@gmail.com> <9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm>
In-Reply-To: <9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 10:21:18 -0700
Message-ID: <CAJnrk1b7N3uPueBbZJ1E8qVj1pQh-Bu4V-rYJAGmR0JtzbEPKg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:17=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 10/11/24 21:13, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in minutes) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> > timeout due to how it's internally implemented.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 21 +++++++++++++
> >  fs/fuse/inode.c  | 21 +++++++++++++
> >  3 files changed, 122 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 1f64ae6d7a69..054bfa2a26ed 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *fi=
le)
> >       return READ_ONCE(file->private_data);
> >  }
> >
> > +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req=
)
> > +{
> > +     return jiffies > req->create_time + fc->timeout.req_timeout;
> > +}
> > +
> > +/*
> > + * Check if any requests aren't being completed by the specified reque=
st
> > + * timeout. To do so, we:
> > + * - check the fiq pending list
> > + * - check the bg queue
> > + * - check the fpq io and processing lists
> > + *
> > + * To make this fast, we only check against the head request on each l=
ist since
> > + * these are generally queued in order of creation time (eg newer requ=
ests get
> > + * queued to the tail). We might miss a few edge cases (eg requests tr=
ansitioning
> > + * between lists, re-sent requests at the head of the pending list hav=
ing a
> > + * later creation time than other requests on that list, etc.) but tha=
t is fine
> > + * since if the request never gets fulfilled, it will eventually be ca=
ught.
> > + */
> > +void fuse_check_timeout(struct timer_list *timer)
> > +{
> > +     struct fuse_conn *fc =3D container_of(timer, struct fuse_conn, ti=
meout.timer);
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_req *req;
> > +     struct fuse_dev *fud;
> > +     struct fuse_pqueue *fpq;
> > +     bool expired =3D false;
> > +     int i;
> > +
> > +     spin_lock(&fiq->lock);
> > +     req =3D list_first_entry_or_null(&fiq->pending, struct fuse_req, =
list);
> > +     if (req)
> > +             expired =3D request_expired(fc, req);
> > +     spin_unlock(&fiq->lock);
> > +     if (expired)
> > +             goto abort_conn;
> > +
> > +     spin_lock(&fc->bg_lock);
> > +     req =3D list_first_entry_or_null(&fc->bg_queue, struct fuse_req, =
list);
> > +     if (req)
> > +             expired =3D request_expired(fc, req);
> > +     spin_unlock(&fc->bg_lock);
> > +     if (expired)
> > +             goto abort_conn;
> > +
> > +     spin_lock(&fc->lock);
> > +     if (!fc->connected) {
> > +             spin_unlock(&fc->lock);
> > +             return;
> > +     }
> > +     list_for_each_entry(fud, &fc->devices, entry) {
> > +             fpq =3D &fud->pq;
> > +             spin_lock(&fpq->lock);
> > +             req =3D list_first_entry_or_null(&fpq->io, struct fuse_re=
q, list);
> > +             if (req && request_expired(fc, req))
> > +                     goto fpq_abort;
> > +
> > +             for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                     req =3D list_first_entry_or_null(&fpq->processing=
[i], struct fuse_req, list);
> > +                     if (req && request_expired(fc, req))
> > +                             goto fpq_abort;
> > +             }
> > +             spin_unlock(&fpq->lock);
> > +     }
> > +     spin_unlock(&fc->lock);
>
> I really don't have a strong opinion on that - I wonder if it wouldn't
> be better for this part to have an extra timeout list per fud or pq as
> previously. That would slightly increases memory usage and overhead per
> request as a second list is needed, but would reduce these 1/min cpu
> spikes as only one list per fud would need to be checked. But then, it
> would be easy to change that later, if timeout checks turn out to be a
> problem.
>

Thanks for the review.

On v7 [1] which used an extra timeout list, the feedback was

"One thing I worry about is adding more roadblocks on the way to making
request queuing more scalable.

Currently there's fc->num_waiting that's touched on all requests and
bg_queue/bg_lock that are touched on background requests.  We should
be trying to fix these bottlenecks instead of adding more.

Can't we use the existing lists to scan requests?

It's more complex, obviously, but at least it doesn't introduce yet
another per-fc list to worry about."


[1] https://lore.kernel.org/linux-fsdevel/CAJfpegs9A7iBbZpPMF-WuR48Ho_=3Dz_=
ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com/

>
> > +
> > +     mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> > +     return;
> > +
> > +fpq_abort:
> > +     spin_unlock(&fpq->lock);
> > +     spin_unlock(&fc->lock);
> > +abort_conn:
> > +     fuse_abort_conn(fc);
> > +}
> > +
> >  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *=
req)
> >  {
> >       INIT_LIST_HEAD(&req->list);
> > @@ -53,6 +129,7 @@ static void fuse_request_init(struct fuse_mount *fm,=
 struct fuse_req *req)
> >       refcount_set(&req->count, 1);
> >       __set_bit(FR_PENDING, &req->flags);
> >       req->fm =3D fm;
> > +     req->create_time =3D jiffies;
> >  }
> >
> >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_=
t flags)
> > @@ -2296,6 +2373,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >               spin_unlock(&fc->lock);
> >
> >               end_requests(&to_end);
> > +
> > +             if (fc->timeout.req_timeout)
> > +                     timer_delete(&fc->timeout.timer);
> >       } else {
> >               spin_unlock(&fc->lock);
> >       }
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7ff00bae4a84..ef4558c2c44e 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -435,6 +435,9 @@ struct fuse_req {
> >
> >       /** fuse_mount this request belongs to */
> >       struct fuse_mount *fm;
> > +
> > +     /** When (in jiffies) the request was created */
> > +     unsigned long create_time;
> >  };
> >
> >  struct fuse_iqueue;
> > @@ -525,6 +528,16 @@ struct fuse_pqueue {
> >       struct list_head io;
> >  };
> >
> > +/* Frequency (in seconds) of request timeout checks, if opted into */
> > +#define FUSE_TIMEOUT_TIMER_FREQ 60 * HZ
> > +
> > +struct fuse_timeout {
> > +     struct timer_list timer;
> > +
> > +     /* Request timeout (in jiffies). 0 =3D no timeout */
> > +     unsigned long req_timeout;
> > +};
> > +
> >  /**
> >   * Fuse device instance
> >   */
> > @@ -571,6 +584,8 @@ struct fuse_fs_context {
> >       enum fuse_dax_mode dax_mode;
> >       unsigned int max_read;
> >       unsigned int blksize;
> > +     /*  Request timeout (in minutes). 0 =3D no timeout (infinite wait=
) */
> > +     unsigned int req_timeout;
> >       const char *subtype;
> >
> >       /* DAX device, may be NULL */
> > @@ -914,6 +929,9 @@ struct fuse_conn {
> >       /** IDR for backing files ids */
> >       struct idr backing_files_map;
> >  #endif
> > +
> > +     /** Only used if the connection enforces request timeouts */
> > +     struct fuse_timeout timeout;
> >  };
> >
> >  /*
> > @@ -1175,6 +1193,9 @@ void fuse_request_end(struct fuse_req *req);
> >  void fuse_abort_conn(struct fuse_conn *fc);
> >  void fuse_wait_aborted(struct fuse_conn *fc);
> >
> > +/* Check if any requests timed out */
> > +void fuse_check_timeout(struct timer_list *timer);
> > +
> >  /**
> >   * Invalidate inode attributes
> >   */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index f1779ff3f8d1..a78aac76b942 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -735,6 +735,7 @@ enum {
> >       OPT_ALLOW_OTHER,
> >       OPT_MAX_READ,
> >       OPT_BLKSIZE,
> > +     OPT_REQUEST_TIMEOUT,
> >       OPT_ERR
> >  };
> >
> > @@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_param=
eters[] =3D {
> >       fsparam_u32     ("max_read",            OPT_MAX_READ),
> >       fsparam_u32     ("blksize",             OPT_BLKSIZE),
> >       fsparam_string  ("subtype",             OPT_SUBTYPE),
> > +     fsparam_u16     ("request_timeout",     OPT_REQUEST_TIMEOUT),
> >       {}
> >  };
> >
> > @@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc=
, struct fs_parameter *param)
> >               ctx->blksize =3D result.uint_32;
> >               break;
> >
> > +     case OPT_REQUEST_TIMEOUT:
> > +             ctx->req_timeout =3D result.uint_16;
> > +             break;
> > +
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -973,6 +979,8 @@ void fuse_conn_put(struct fuse_conn *fc)
> >
> >               if (IS_ENABLED(CONFIG_FUSE_DAX))
> >                       fuse_dax_conn_free(fc);
> > +             if (fc->timeout.req_timeout)
> > +                     timer_shutdown_sync(&fc->timeout.timer);
> >               if (fiq->ops->release)
> >                       fiq->ops->release(fiq);
> >               put_pid_ns(fc->pid_ns);
> > @@ -1691,6 +1699,18 @@ int fuse_init_fs_context_submount(struct fs_cont=
ext *fsc)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
> >
> > +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> > +{
> > +     if (ctx->req_timeout) {
> > +             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +                     fc->timeout.req_timeout =3D U32_MAX;
>
>
> ULONG_MAX?

Nice, I'll change this to ULONG_MAX. We only run into this overflow on
32-bit systems (and only if the kernel has configured HZ to greater
than 1092) so U32_MAX is the same as ULONG_MAX,  but ULONG_MAX looks
nicer since "fc->timeout.req_timeout" is an unsigned long.


Thanks,
Joanne

>
> > +             timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> > +             mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
> > +     } else {
> > +             fc->timeout.req_timeout =3D 0;
> > +     }
> > +}
> > +
> >  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_cont=
ext *ctx)
> >  {
> >       struct fuse_dev *fud =3D NULL;
> > @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb=
, struct fuse_fs_context *ctx)
> >       fc->destroy =3D ctx->destroy;
> >       fc->no_control =3D ctx->no_control;
> >       fc->no_force_umount =3D ctx->no_force_umount;
> > +     fuse_init_fc_timeout(fc, ctx);
> >
> >       err =3D -ENOMEM;
> >       root =3D fuse_get_root_inode(sb, ctx->rootmode);
>
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

