Return-Path: <linux-fsdevel+bounces-25047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B540F94854E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 00:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E08B22667
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681516D9DC;
	Mon,  5 Aug 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DId5l2KQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD178155351
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895821; cv=none; b=SQNF1av3erxDzHsdAuMXkpHBuSyJU68QoOPaTEA40/9Xigfyw8kmacIL4I/SmNGshDI7ECVLmsXVAX0+7GXJY/Yfq4TOo8VnUSri67SnELpgjeDl7pgABdFc+LAyzjhH4TOt+xFThNwfJPyJyN4HiWBmlZYUwDYBBfhKAfjzgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895821; c=relaxed/simple;
	bh=3NjDiCTrHmIQG+PZ3JlLStnwnaaDGsVFs/bcVPZhu8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRMkgwlt3HApDbNQfN0kAqv8nuSVlB87lF6d83IwRBI11hoy9hWEERaGJsIGcwMJsgY5WZVptMsbLWSKoIkUxBaBjLyxgteu69cslOo+xlbn8tF43MgmCu5cVZoriaNO4/xRJ7imm3ucIHS6uQPea9x9Qcrb401uuAHpNYcil3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DId5l2KQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44febbc323fso955611cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722895819; x=1723500619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HlbdVvjOvIPIiP6c4pXkGAJF8Pznknf0HLbw66ed9U=;
        b=DId5l2KQkGBW8+UNBocAxVGMS4dE+EmLoxMnTGB3oJlgpqD5Obgn/GsRRdCncXJnfl
         HhCxhOlCF3uRhzlVU7WDd2KZphaVfYLgbkxwmLVHwKEKTI3wrB40aXMcXJ2Zm9PkLciL
         GksuW0eQUh0B8Mpvkp6sA2+7OMa0UhHnOIHn8liMzbCJX0Ogx++OaTLNfertrLQxoPMV
         qqTzs2Yy2L3yntDbjHCXKb5znGdP/QhuCPIjQIGVZC0JIb8zpnDPv1FX+q7u9SQ/a00i
         bggLxZdaunpDSB7lrY2CrbRJk4cTyTpxaSYyEybQZYACKIzmOsy5s69zEMyKxCuJXy03
         dEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722895819; x=1723500619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HlbdVvjOvIPIiP6c4pXkGAJF8Pznknf0HLbw66ed9U=;
        b=ZXGtjkbuxY/V56DvIJlBAixzlW08hTR6Nikg0ip8g2Sn64EMlpVLvWQK4MkmN7rGPU
         A5w8AduU8n05XqWG8Akr1AFoVYvUnZ1SSk3iH1VwZqvQEVBhvQAahK+DtSOVycpl6MI+
         GXLvGzW2n+z3p0ZQ7EhwywzS22eio4DTNHfEFFYJ6k0Y9viuKWctpSL4tGhYj0nk39jy
         5u6VfZKtOnJcl0eAfv5PmlEmLLttM0f1G12Z3KvBP6LKjsfdJGKpvMUYzw+kSN0F4Izh
         m0ilyGGWf1tWRlIsIlQzCdc+2U/EEg+6iwB7vUs8Ofv3pVsHOskL+s5M8CXnZE2cRxFV
         fILw==
X-Forwarded-Encrypted: i=1; AJvYcCXodqg0qjqRJwvFGzRqBCLDqHlYQ56WKapcQlWwn5hv3dEji3AMrfnlnxuQGW4u157IefPXqFdnwhqyTOlvr15I6xe1k66MHpBSVlGBdg==
X-Gm-Message-State: AOJu0YzLanVnZ34hExpUdRWSZJM1Rf3k90Cbt/w77BFHFX8W2jImfHI2
	nBxNTHFxvBQMqnSTiSfNyqQmep7PJC2icDN85eMPAfpn4lRew8sEOsSC2gkLdvjwCREn8mBJgHP
	2vCK6VCHM5477PHXFs7bBizCHeZw=
X-Google-Smtp-Source: AGHT+IGXLaF3xZYiRYfNf+b7svk4K2y8Rsy+0BsX/5ZYV4g45E/EcMJtdEeYmBAbjjY77InIcESWxVrkOYFisSyPU2M=
X-Received: by 2002:a05:622a:1a1c:b0:44f:efab:22a with SMTP id
 d75a77b69052e-4518924a995mr157115651cf.38.1722895818584; Mon, 05 Aug 2024
 15:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com> <CAJnrk1Yf68HbGUuDv6zwfqkarMBsaHi1DJPdA0Fg5EyXvWbtFA@mail.gmail.com>
 <fc1ed986-fcd6-4a52-aed3-f3f61f2513a7@fastmail.fm>
In-Reply-To: <fc1ed986-fcd6-4a52-aed3-f3f61f2513a7@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Aug 2024 15:10:07 -0700
Message-ID: <CAJnrk1YVC58PiU6_gJno7i439uHUkcLDzKY4mXmupybeDO7LWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:26=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/5/24 06:52, Joanne Koong wrote:
> > On Mon, Jul 29, 2024 at 5:28=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> There are situations where fuse servers can become unresponsive or tak=
e
> >> too long to reply to a request. Currently there is no upper bound on
> >> how long a request may take, which may be frustrating to users who get
> >> stuck waiting for a request to complete.
> >>
> >> This commit adds a timeout option (in seconds) for requests. If the
> >> timeout elapses before the server replies to the request, the request
> >> will fail with -ETIME.
> >>
> >> There are 3 possibilities for a request that times out:
> >> a) The request times out before the request has been sent to userspace
> >> b) The request times out after the request has been sent to userspace
> >> and before it receives a reply from the server
> >> c) The request times out after the request has been sent to userspace
> >> and the server replies while the kernel is timing out the request
> >>
> >> While a request timeout is being handled, there may be other handlers
> >> running at the same time if:
> >> a) the kernel is forwarding the request to the server
> >> b) the kernel is processing the server's reply to the request
> >> c) the request is being re-sent
> >> d) the connection is aborting
> >> e) the device is getting released
> >>
> >> Proper synchronization must be added to ensure that the request is
> >> handled correctly in all of these cases. To this effect, there is a ne=
w
> >> FR_FINISHING bit added to the request flags, which is set atomically b=
y
> >> either the timeout handler (see fuse_request_timeout()) which is invok=
ed
> >> after the request timeout elapses or set by the request reply handler
> >> (see dev_do_write()), whichever gets there first. If the reply handler
> >> and the timeout handler are executing simultaneously and the reply han=
dler
> >> sets FR_FINISHING before the timeout handler, then the request will be
> >> handled as if the timeout did not elapse. If the timeout handler sets
> >> FR_FINISHING before the reply handler, then the request will fail with
> >> -ETIME and the request will be cleaned up.
> >>
> >> Currently, this is the refcount lifecycle of a request:
> >>
> >> Synchronous request is created:
> >> fuse_simple_request -> allocates request, sets refcount to 1
> >>    __fuse_request_send -> acquires refcount
> >>      queues request and waits for reply...
> >> fuse_simple_request -> drops refcount
> >>
> >> Background request is created:
> >> fuse_simple_background -> allocates request, sets refcount to 1
> >>
> >> Request is replied to:
> >> fuse_dev_do_write
> >>    fuse_request_end -> drops refcount on request
> >>
> >> Proper acquires on the request reference must be added to ensure that =
the
> >> timeout handler does not drop the last refcount on the request while
> >> other handlers may be operating on the request. Please note that the
> >> timeout handler may get invoked at any phase of the request's
> >> lifetime (eg before the request has been forwarded to userspace, etc).
> >>
> >> It is always guaranteed that there is a refcount on the request when t=
he
> >> timeout handler is executing. The timeout handler will be either
> >> deactivated by the reply/abort/release handlers, or if the timeout
> >> handler is concurrently executing on another CPU, the reply/abort/rele=
ase
> >> handlers will wait for the timeout handler to finish executing first b=
efore
> >> it drops the final refcount on the request.
> >>
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> ---
> >>   fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++=
--
> >>   fs/fuse/fuse_i.h |  14 ++++
> >>   fs/fuse/inode.c  |   7 ++
> >>   3 files changed, 200 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 9eb191b5c4de..9992bc5f4469 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
> >>
> >>   static struct kmem_cache *fuse_req_cachep;
> >>
> >> +static void fuse_request_timeout(struct timer_list *timer);
> >> +
> >>   static struct fuse_dev *fuse_get_dev(struct file *file)
> >>   {
> >>          /*
> >> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm,=
 struct fuse_req *req)
> >>          refcount_set(&req->count, 1);
> >>          __set_bit(FR_PENDING, &req->flags);
> >>          req->fm =3D fm;
> >> +       if (fm->fc->req_timeout)
> >> +               timer_setup(&req->timer, fuse_request_timeout, 0);
> >>   }
> >>
> >>   static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gf=
p_t flags)
> >> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >>    * the 'end' callback is called if given, else the reference to the
> >>    * request is released
> >>    */
> >> -void fuse_request_end(struct fuse_req *req)
> >> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer=
_callback)
> >>   {
> >>          struct fuse_mount *fm =3D req->fm;
> >>          struct fuse_conn *fc =3D fm->fc;
> >>          struct fuse_iqueue *fiq =3D &fc->iq;
> >>
> >> +       if (from_timer_callback)
> >> +               req->out.h.error =3D -ETIME;
> >> +
> >>          if (test_and_set_bit(FR_FINISHED, &req->flags))
> >>                  goto put_request;
> >>
> >> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
> >>                  list_del_init(&req->intr_entry);
> >>                  spin_unlock(&fiq->lock);
> >>          }
> >> -       WARN_ON(test_bit(FR_PENDING, &req->flags));
> >> -       WARN_ON(test_bit(FR_SENT, &req->flags));
> >>          if (test_bit(FR_BACKGROUND, &req->flags)) {
> >>                  spin_lock(&fc->bg_lock);
> >>                  clear_bit(FR_BACKGROUND, &req->flags);
> >> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
> >>                  wake_up(&req->waitq);
> >>          }
> >>
> >> +       if (!from_timer_callback && req->timer.function)
> >> +               timer_delete_sync(&req->timer);
> >> +
> >>          if (test_bit(FR_ASYNC, &req->flags))
> >>                  req->args->end(fm, req->args, req->out.h.error);
> >>   put_request:
> >>          fuse_put_request(req);
> >>   }
> >> +
> >> +void fuse_request_end(struct fuse_req *req)
> >> +{
> >> +       WARN_ON(test_bit(FR_PENDING, &req->flags));
> >> +       WARN_ON(test_bit(FR_SENT, &req->flags));
> >> +
> >> +       do_fuse_request_end(req, false);
> >> +}
> >>   EXPORT_SYMBOL_GPL(fuse_request_end);
> >>
> >> +static void timeout_inflight_req(struct fuse_req *req)
> >> +{
> >> +       struct fuse_conn *fc =3D req->fm->fc;
> >> +       struct fuse_iqueue *fiq =3D &fc->iq;
> >> +       struct fuse_pqueue *fpq;
> >> +
> >> +       spin_lock(&fiq->lock);
> >> +       fpq =3D req->fpq;
> >> +       spin_unlock(&fiq->lock);
> >> +
> >> +       /*
> >> +        * If fpq has not been set yet, then the request is aborting (=
which
> >> +        * clears FR_PENDING flag) before dev_do_read (which sets req-=
>fpq)
> >> +        * has been called. Let the abort handler handle this request.
> >> +        */
> >> +       if (!fpq)
> >> +               return;
> >> +
> >> +       spin_lock(&fpq->lock);
> >> +       if (!fpq->connected || req->out.h.error =3D=3D -ECONNABORTED) =
{
> >> +               /*
> >> +                * Connection is being aborted or the fuse_dev is bein=
g released.
> >> +                * The abort / release will clean up the request
> >> +                */
> >> +               spin_unlock(&fpq->lock);
> >> +               return;
> >> +       }
> >> +
> >> +       if (!test_bit(FR_PRIVATE, &req->flags))
> >> +               list_del_init(&req->list);
> >> +
> >> +       spin_unlock(&fpq->lock);
> >> +
> >> +       do_fuse_request_end(req, true);
> >> +}
> >> +
> >> +static void timeout_pending_req(struct fuse_req *req)
> >> +{
> >> +       struct fuse_conn *fc =3D req->fm->fc;
> >> +       struct fuse_iqueue *fiq =3D &fc->iq;
> >> +       bool background =3D test_bit(FR_BACKGROUND, &req->flags);
> >> +
> >> +       if (background)
> >> +               spin_lock(&fc->bg_lock);
> >> +       spin_lock(&fiq->lock);
> >> +
> >> +       if (!test_bit(FR_PENDING, &req->flags)) {
> >> +               spin_unlock(&fiq->lock);
> >> +               if (background)
> >> +                       spin_unlock(&fc->bg_lock);
> >> +               timeout_inflight_req(req);
> >> +               return;
> >> +       }
> >> +
> >> +       if (!test_bit(FR_PRIVATE, &req->flags))
> >> +               list_del_init(&req->list);
> >> +
> >> +       spin_unlock(&fiq->lock);
> >> +       if (background)
> >> +               spin_unlock(&fc->bg_lock);
> >> +
> >> +       do_fuse_request_end(req, true);
> >> +}
> >> +
> >> +static void fuse_request_timeout(struct timer_list *timer)
> >> +{
> >> +       struct fuse_req *req =3D container_of(timer, struct fuse_req, =
timer);
> >> +
> >> +       /*
> >> +        * Request reply is being finished by the kernel right now.
> >> +        * No need to time out the request.
> >> +        */
> >> +       if (test_and_set_bit(FR_FINISHING, &req->flags))
> >> +               return;
> >> +
> >> +       if (test_bit(FR_PENDING, &req->flags))
> >> +               timeout_pending_req(req);
> >> +       else
> >> +               timeout_inflight_req(req);
> >> +}
> >> +
> >>   static int queue_interrupt(struct fuse_req *req)
> >>   {
> >>          struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> >> @@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *r=
eq)
> >>
> >>   static void __fuse_request_send(struct fuse_req *req)
> >>   {
> >> -       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> >> +       struct fuse_conn *fc =3D req->fm->fc;
> >> +       struct fuse_iqueue *fiq =3D &fc->iq;
> >>
> >>          BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
> >>          spin_lock(&fiq->lock);
> >> @@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *=
req)
> >>                  /* acquire extra reference, since request is still ne=
eded
> >>                     after fuse_request_end() */
> >>                  __fuse_get_request(req);
> >> +               if (req->timer.function) {
> >> +                       req->timer.expires =3D jiffies + fc->req_timeo=
ut;
> >> +                       add_timer(&req->timer);
> >> +               }
> >>                  queue_request_and_unlock(fiq, req);
> >>
> >>                  request_wait_answer(req);
> >> @@ -539,6 +641,10 @@ static bool fuse_request_queue_background(struct =
fuse_req *req)
> >>                  if (fc->num_background =3D=3D fc->max_background)
> >>                          fc->blocked =3D 1;
> >>                  list_add_tail(&req->list, &fc->bg_queue);
> >> +               if (req->timer.function) {
> >> +                       req->timer.expires =3D jiffies + fc->req_timeo=
ut;
> >> +                       add_timer(&req->timer);
> >> +               }
> >>                  flush_bg_queue(fc);
> >>                  queued =3D true;
> >>          }
> >> @@ -1268,6 +1374,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev =
*fud, struct file *file,
> >>          req =3D list_entry(fiq->pending.next, struct fuse_req, list);
> >>          clear_bit(FR_PENDING, &req->flags);
> >>          list_del_init(&req->list);
> >> +       /* Acquire a reference in case the timeout handler starts exec=
uting */
> >> +       __fuse_get_request(req);
> >> +       req->fpq =3D fpq;
> >>          spin_unlock(&fiq->lock);
> >>
> >>          args =3D req->args;
> >> @@ -1280,6 +1389,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev =
*fud, struct file *file,
> >>                  if (args->opcode =3D=3D FUSE_SETXATTR)
> >>                          req->out.h.error =3D -E2BIG;
> >>                  fuse_request_end(req);
> >> +               fuse_put_request(req);
> >>                  goto restart;
> >
> > While rereading through fuse_dev_do_read, I just realized we also need
> > to handle the race condition for the error edge cases (here and in the
> > "goto out_end;"), since the timeout handler could have finished
> > executing by the time we hit the error edge case. We need to
> > test_and_set_bit(FR_FINISHING) so that either the timeout_handler or
> > dev_do_read cleans up the request, but not both. I'll fix this for v3.
>
> I know it would change semantics a bit, but wouldn't it be much easier /
> less racy if fuse_dev_do_read() would delete the timer when it takes a
> request from fiq->pending and add it back in (with new timeouts) before
> it returns the request?
>

Ooo I really like this idea! I'm worried though that this might allow
potential scenarios where the fuse_dev_do_read gets descheduled after
disarming the timer and a non-trivial amount of time elapses before it
gets scheduled back (eg on a system where the CPU is starved), in
which case the fuse req_timeout value will be (somewhat of) a lie. If
you and others think this is likely fine though, then I'll incorporate
this into v3 which will make this logic a lot simpler :)


Thanks,
Joanne

> Untested:
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9992bc5f4469..444f667e2f43 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1379,6 +1379,15 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *f=
ud, struct file *file,
>          req->fpq =3D fpq;
>          spin_unlock(&fiq->lock);
>
> +       if (req->timer.function) {
> +               /* request gets handled, remove the previous timeout */
> +               timer_delete_sync(&req->timer);
> +               if (test_bit(FR_FINISHED, &req->flags)) {
> +                       fuse_put_request(req);
> +                       goto restart;
> +               }
> +       }
> +
>          args =3D req->args;
>          reqsize =3D req->in.h.len;
>
> @@ -1433,24 +1442,10 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *=
fud, struct file *file,
>          if (test_bit(FR_INTERRUPTED, &req->flags))
>                  queue_interrupt(req);
>
> -       /*
> -        * Check if the timeout handler is running / ran. If it did, we n=
eed to
> -        * remove the request from any lists in case the timeout handler =
finished
> -        * before dev_do_read moved the request to the processing list.
> -        *
> -        * Check FR_SENT to distinguish whether the timeout or the write =
handler
> -        * is finishing the request. However, there can be the case where=
 the
> -        * timeout handler and resend handler are running concurrently, s=
o we
> -        * need to also check the FR_PENDING bit.
> -        */
> -       if (test_bit(FR_FINISHING, &req->flags) &&
> -           (test_bit(FR_SENT, &req->flags) || test_bit(FR_PENDING, &req-=
>flags))) {
> -               spin_lock(&fpq->lock);
> -               if (!test_bit(FR_PRIVATE, &req->flags))
> -                       list_del_init(&req->list);
> -               spin_unlock(&fpq->lock);
> -               fuse_put_request(req);
> -               return -ETIME;
> +       if (req->timer.function) {
> +               /* re-arm the request */
> +               req->timer.expires =3D jiffies + fc->req_timeout;
> +               add_timer(&req->timer);
>          }
>
>          fuse_put_request(req);
>
> Thanks,
> Bernd

