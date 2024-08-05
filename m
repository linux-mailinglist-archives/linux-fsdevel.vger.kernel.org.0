Return-Path: <linux-fsdevel+bounces-24966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C929E94746E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 06:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463E41F21290
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8D13C809;
	Mon,  5 Aug 2024 04:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1DMNQ3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30527A94B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833146; cv=none; b=iXLgP753LfFfglM0Nhvs2yM7G+ZNd9YkwNzZXgmqyZuYVZ0T01/AK5vadSJpmV/H0zoaqKqDXGcD34nxwX1/MyLJOGl7O4rDZX9AHN0cXgaH5ROM2IJ47hvlXcYFc0TxjtSXaMzdqihOYSq/PNo+LUkQ85L1xf/ZH6dsWgc9G40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833146; c=relaxed/simple;
	bh=HhVAeeXBWmJ4Q/hVprPo0AwFBMCDC/Y0inZhd+NgAWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWA1lPVMgWxgwA+2BurLAwf8VdQc1SCrZtmxnH5vH0zPH7c+l1+0ht7MzuNx3AtlDk5qN0usGGgNKzl0JhPpUuJOgK8sBhILkkHqNp2t1JkCa0UoWL7bCr1UjdMSZCGbcfylzCCJQ2JFniqHacHbm1jeZbZoVv2HHLAEEeTaSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1DMNQ3q; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45019dccc3aso47938441cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722833143; x=1723437943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlaIVlHEJTy+yNcCkVFw9sVjcvlGr85XS9oVFN24R4E=;
        b=h1DMNQ3qdLUrVNZ/RlczSQqaQEHn0wQkVKH+6Hy/F79UFkd/j603gBUIvqowA6Vqpv
         oNHCG1X8+CabdZM1Zx2BOYY/bz6KIBc+OdZrHzhnhV5RrjbGmyexI8VktROx2HrwNLSL
         zRYphgOrhv0CeThGZpjmITsl2yFafL8bY6J1hrgDGouYeXkWHJUcNOriT89ccT8eMvPa
         9PDb1jx8UQjvrDwT0JlShcmR2T2N6go5jSSKREhUbkDhAgNKHz4+tuL3Qh1LEP9W5zQ0
         SswFyZ/eyGN3mnJqDU9ZIvFt3pIf52NUUIbHL6G+06fsdEtzv/R192D2bHaqkJ575/3U
         hsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722833143; x=1723437943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlaIVlHEJTy+yNcCkVFw9sVjcvlGr85XS9oVFN24R4E=;
        b=fiXRdf9GGimesxXYvvvd97G4JTyX8NREABfZ5BTk1mXZE/q6tyzyUuYQGKJ9vejSpL
         fX3Z/b4/OlG5KjZPKkL/pElzFClNxVBqbrBQo6t3tOdQrSXTomeKm1e/bfCPufkdcNRe
         WP//8dB9xgBEC06ZeWDvh23sHzaDP1a/x5jUE5f9+/g1AGardHP+ZtcED8LNTGlZwI1g
         v0vSN6XI4XLeJilhDD3XuVeiOHyyeehmLbkLJBLwYqNv6thfNEB2ssyQ14xFqESJ8xeU
         eyunsA1aHeTIwJgPJsmE28+OjDdq4lVY+L63EpSSil+oYkaWmBOqbE84KzFqPnl2Zf8F
         43ug==
X-Forwarded-Encrypted: i=1; AJvYcCUMD7ovo3+pPQn0qHU+0RVJfcM+8r9LKdjBVMtcHG4304Xg8zTYNKtWL9UarZ8K4cKgTjRM9v7rLOTyyHWT@vger.kernel.org
X-Gm-Message-State: AOJu0YzhehkGlf2oru6b52rAHDrXsySo8gkAruDWv1JkWgr9QPmCdYkZ
	U47a2OkiLIclYKRxcwGxgLh51UtKSowzrTX+XVLaRxiyLiVKhGHojWNTw5yqYeh+4HQvKKdqPX1
	vevoq0m8x60cW1pTZrHFGyAaY4Nx2INViwDI=
X-Google-Smtp-Source: AGHT+IGvUrKVaf2slwopgkTwlh4fQbxKcNiaYzA1ybWpfviHoBhCyq5V/XfCxJGvXFX+P9pvA6u6JJfGhPI8sTMr28Q=
X-Received: by 2002:a05:622a:1b8f:b0:44f:e056:fe06 with SMTP id
 d75a77b69052e-45189240d5emr151562531cf.36.1722833142919; Sun, 04 Aug 2024
 21:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com> <51a1d881-d3c6-4be6-93e7-358200df1bdd@fastmail.fm>
In-Reply-To: <51a1d881-d3c6-4be6-93e7-358200df1bdd@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Sun, 4 Aug 2024 21:45:32 -0700
Message-ID: <CAJnrk1aqKeo1zY3SMw1vFvQjHdHbmva5qSL0uAYBmQDKiHL_AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 3:46=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 7/30/24 02:23, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This commit adds a timeout option (in seconds) for requests. If the
> > timeout elapses before the server replies to the request, the request
> > will fail with -ETIME.
> >
> > There are 3 possibilities for a request that times out:
> > a) The request times out before the request has been sent to userspace
> > b) The request times out after the request has been sent to userspace
> > and before it receives a reply from the server
> > c) The request times out after the request has been sent to userspace
> > and the server replies while the kernel is timing out the request
> >
> > While a request timeout is being handled, there may be other handlers
> > running at the same time if:
> > a) the kernel is forwarding the request to the server
> > b) the kernel is processing the server's reply to the request
> > c) the request is being re-sent
> > d) the connection is aborting
> > e) the device is getting released
> >
> > Proper synchronization must be added to ensure that the request is
> > handled correctly in all of these cases. To this effect, there is a new
> > FR_FINISHING bit added to the request flags, which is set atomically by
> > either the timeout handler (see fuse_request_timeout()) which is invoke=
d
> > after the request timeout elapses or set by the request reply handler
> > (see dev_do_write()), whichever gets there first. If the reply handler
> > and the timeout handler are executing simultaneously and the reply hand=
ler
> > sets FR_FINISHING before the timeout handler, then the request will be
> > handled as if the timeout did not elapse. If the timeout handler sets
> > FR_FINISHING before the reply handler, then the request will fail with
> > -ETIME and the request will be cleaned up.
> >
> > Currently, this is the refcount lifecycle of a request:
> >
> > Synchronous request is created:
> > fuse_simple_request -> allocates request, sets refcount to 1
> >   __fuse_request_send -> acquires refcount
> >     queues request and waits for reply...
> > fuse_simple_request -> drops refcount
> >
> > Background request is created:
> > fuse_simple_background -> allocates request, sets refcount to 1
> >
> > Request is replied to:
> > fuse_dev_do_write
> >   fuse_request_end -> drops refcount on request
> >
> > Proper acquires on the request reference must be added to ensure that t=
he
> > timeout handler does not drop the last refcount on the request while
> > other handlers may be operating on the request. Please note that the
> > timeout handler may get invoked at any phase of the request's
> > lifetime (eg before the request has been forwarded to userspace, etc).
> >
> > It is always guaranteed that there is a refcount on the request when th=
e
> > timeout handler is executing. The timeout handler will be either
> > deactivated by the reply/abort/release handlers, or if the timeout
> > handler is concurrently executing on another CPU, the reply/abort/relea=
se
> > handlers will wait for the timeout handler to finish executing first be=
fore
> > it drops the final refcount on the request.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h |  14 ++++
> >  fs/fuse/inode.c  |   7 ++
> >  3 files changed, 200 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 9eb191b5c4de..9992bc5f4469 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
> >
> >  static struct kmem_cache *fuse_req_cachep;
> >
> > +static void fuse_request_timeout(struct timer_list *timer);
> > +
> >  static struct fuse_dev *fuse_get_dev(struct file *file)
> >  {
> >       /*
> > @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, =
struct fuse_req *req)
> >       refcount_set(&req->count, 1);
> >       __set_bit(FR_PENDING, &req->flags);
> >       req->fm =3D fm;
> > +     if (fm->fc->req_timeout)
> > +             timer_setup(&req->timer, fuse_request_timeout, 0);
> >  }
> >
> >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_=
t flags)
> > @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >   * the 'end' callback is called if given, else the reference to the
> >   * request is released
> >   */
> > -void fuse_request_end(struct fuse_req *req)
> > +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_=
callback)
> >  {
> >       struct fuse_mount *fm =3D req->fm;
> >       struct fuse_conn *fc =3D fm->fc;
> >       struct fuse_iqueue *fiq =3D &fc->iq;
> >
> > +     if (from_timer_callback)
> > +             req->out.h.error =3D -ETIME;
> > +
> >       if (test_and_set_bit(FR_FINISHED, &req->flags))
> >               goto put_request;
> >
> > @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
> >               list_del_init(&req->intr_entry);
> >               spin_unlock(&fiq->lock);
> >       }
> > -     WARN_ON(test_bit(FR_PENDING, &req->flags));
> > -     WARN_ON(test_bit(FR_SENT, &req->flags));
> >       if (test_bit(FR_BACKGROUND, &req->flags)) {
> >               spin_lock(&fc->bg_lock);
> >               clear_bit(FR_BACKGROUND, &req->flags);
> > @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
> >               wake_up(&req->waitq);
> >       }
> >
> > +     if (!from_timer_callback && req->timer.function)
> > +             timer_delete_sync(&req->timer);
> > +
> >       if (test_bit(FR_ASYNC, &req->flags))
> >               req->args->end(fm, req->args, req->out.h.error);
> >  put_request:
> >       fuse_put_request(req);
> >  }
> > +
> > +void fuse_request_end(struct fuse_req *req)
> > +{
> > +     WARN_ON(test_bit(FR_PENDING, &req->flags));
> > +     WARN_ON(test_bit(FR_SENT, &req->flags));
> > +
> > +     do_fuse_request_end(req, false);
> > +}
> >  EXPORT_SYMBOL_GPL(fuse_request_end);
> >
> > +static void timeout_inflight_req(struct fuse_req *req)
> > +{
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_pqueue *fpq;
> > +
> > +     spin_lock(&fiq->lock);
> > +     fpq =3D req->fpq;
> > +     spin_unlock(&fiq->lock);
> > +
> > +     /*
> > +      * If fpq has not been set yet, then the request is aborting (whi=
ch
> > +      * clears FR_PENDING flag) before dev_do_read (which sets req->fp=
q)
> > +      * has been called. Let the abort handler handle this request.
> > +      */
> > +     if (!fpq)
> > +             return;
> > +
> > +     spin_lock(&fpq->lock);
> > +     if (!fpq->connected || req->out.h.error =3D=3D -ECONNABORTED) {
> > +             /*
> > +              * Connection is being aborted or the fuse_dev is being r=
eleased.
> > +              * The abort / release will clean up the request
> > +              */
> > +             spin_unlock(&fpq->lock);
> > +             return;
> > +     }
> > +
> > +     if (!test_bit(FR_PRIVATE, &req->flags))
> > +             list_del_init(&req->list);
> > +
> > +     spin_unlock(&fpq->lock);
> > +
> > +     do_fuse_request_end(req, true);
> > +}
> > +
> > +static void timeout_pending_req(struct fuse_req *req)
> > +{
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     bool background =3D test_bit(FR_BACKGROUND, &req->flags);
> > +
> > +     if (background)
> > +             spin_lock(&fc->bg_lock);
> > +     spin_lock(&fiq->lock);
> > +
> > +     if (!test_bit(FR_PENDING, &req->flags)) {
> > +             spin_unlock(&fiq->lock);
> > +             if (background)
> > +                     spin_unlock(&fc->bg_lock);
> > +             timeout_inflight_req(req);
> > +             return;
> > +     }
> > +
> > +     if (!test_bit(FR_PRIVATE, &req->flags))
> > +             list_del_init(&req->list);
> > +
> > +     spin_unlock(&fiq->lock);
> > +     if (background)
> > +             spin_unlock(&fc->bg_lock);
> > +
> > +     do_fuse_request_end(req, true);
> > +}
> > +
> > +static void fuse_request_timeout(struct timer_list *timer)
> > +{
> > +     struct fuse_req *req =3D container_of(timer, struct fuse_req, tim=
er);
>
> Let's say the timeout thread races with the thread that does
> fuse_dev_do_write() and that thread is much faster and already calls :
>
> fuse_dev_do_write():
>         fuse_request_end(req);
>         fuse_put_request(req);
> out:
>         return err ? err : nbytes;
>
>
> (What I mean is that the timeout triggered, but did not reach
> FR_FINISHING yet and at the same time another thread on another core
> calls fuse_dev_do_write()).
>
> > +
> > +     /*
> > +      * Request reply is being finished by the kernel right now.
> > +      * No need to time out the request.
> > +      */
> > +     if (test_and_set_bit(FR_FINISHING, &req->flags))
> > +             return;
>
> Wouldn't that trigger an UAF when the fuse_dev_do_write() was proceding
> much faster and already released the request?

I don't believe so. In fuse_dev_do_write(), the call to
fuse_request_end() will call timer_delete_sync(), which will either
cancel the timer or wait for the timer to finish running if it's
concurrently running on another CPU.
>
> > +
> > +     if (test_bit(FR_PENDING, &req->flags))
> > +             timeout_pending_req(req);
> > +     else
> > +             timeout_inflight_req(req);
> > +}
> > +
> >  static int queue_interrupt(struct fuse_req *req)
> >  {
> >       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> > @@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *re=
q)
> >
> >  static void __fuse_request_send(struct fuse_req *req)
> >  {
> > -     struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> >
> >       BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
> >       spin_lock(&fiq->lock);
> > @@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *r=
eq)
> >               /* acquire extra reference, since request is still needed
> >                  after fuse_request_end() */
> >               __fuse_get_request(req);
> > +             if (req->timer.function) {
> > +                     req->timer.expires =3D jiffies + fc->req_timeout;
> > +                     add_timer(&req->timer);
> > +             }
>
> Does this leave a chance to put in a timeout of 0, if someone first sets
>  fc->req_timeout and then sets it back to 0?

I don't think so. The req_timeout is per connection and specified at
mount time. Once the fc->req_timeout is set for the connection it
can't be changed even if the default_req_timeout sysctl gets set to 0.

>
>
> (I'm going to continue reviewing tomorrow, gets very late here).

Thanks for reviewing.
>
>
> Thanks,
> Bernd

