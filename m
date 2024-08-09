Return-Path: <linux-fsdevel+bounces-25554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE39994D64B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DD81F21EA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DB14B96C;
	Fri,  9 Aug 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/u0iDyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C62F41
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228430; cv=none; b=YNxyhF54zULZW6nUWlH4pIdQSPQwoTC5XYXwsQCNXQ+HlmmxezhZ3Zc6bIodQblr/1HPpOcfc4fislJm7q8Hb2OWvphH5ub0iSoK0veFJt6DmqdEvfrdY022/+R/HUffVQ0t85oxU0z/SGhBiQ9x3RQDt1vt21O/TAAae19fWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228430; c=relaxed/simple;
	bh=sax4dU70FQ1lE7PK7wnI+Xr5K5a1JNdBQ4rPk1vuiYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A302RjGqqUorBk8+a0vWEic82ZoZuapsBn+yaNgMSMSD1b+A9zdV359+zmx+/RBsGWew2mAeY5ivCABeqBOjlBoxGmueuXT3pDlOu4A2r5Bl8/1SaTIglkXQCAlyGv0b2eb3JUuaWa1CBhvmmeabI+8tiUNVQ88Wd05mH3acIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/u0iDyp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db23a608eeso1755287b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723228428; x=1723833228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn1UuRY15K5l6GZv+j73xbsfKIzYb4xUSwEmnFOdRc8=;
        b=D/u0iDypGQK5ECUv1oPbkEOrDfVdAIbu2/BtN92V2+XqDMNSKnwRqBVpCG6a4fqbg+
         vd41wgu1SfSHZYeFKugn/ppTAshkglEOD1sF+PFvfXMccKzZLlZJgQeAB6/DovpL30DP
         C8aZMol3HyQao+jQkL/Mfy8zcGiMjiWTDzHxBR5Mz0/ZpBiygrbBPnAP+gLVwqBSemVB
         Pu84fM3ihfKtNmGa3IFvnPHBP/OhFTMGNzFK/bOJEYKlaPP4wr8Xj8KNnT2oXKVZwjba
         X7IrJ5FQdeSqASk5HvmXChYYCZDZHjHYAzAEIEJboDR4lVG7rxIb39S8Cbx/hs2+DbpR
         UuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228428; x=1723833228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn1UuRY15K5l6GZv+j73xbsfKIzYb4xUSwEmnFOdRc8=;
        b=vsp5GihhqlqIsb59iFsRHbo+gAWdzxHreb9GmOTFI1LtF3h4IMtZXhD/HkUchPtkgQ
         cBhFR9ueiJXeG3diMsHiaVchxJpdhfTc9O7klAH/nwfzLn2aE/DpQiWzFKg3FUKYzJt0
         dKM2jc8uL8ILf3i4kTiI3xZLbz2oA4R7SdlYPeCgaWUCf77ww9qrlaLJeqYtDOKqrXFN
         qEESGxH+Dz7yqiy5f9JMUfb0+4ckKOpKMshHg9muwRvwX7DIdJTaoqYXaJ3ghpjJv5pM
         49rD3fdpz2pz6cIupSXDoPGurmoffHl8ggTa7+t5C9x6FdRY/MsPxut+I8YctGA0sUcD
         BH0g==
X-Forwarded-Encrypted: i=1; AJvYcCUOvDCY7RfoaShV5crBR1IJLDJphgHdwnhopR6h3iexZOGV8konbeFTtF0CcFmqPI7oH5/ypAWWkLv4PwcR@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNwQ7540g2gmNqQOjXb2tvODIWuxuI1pNqr73B4JxQsckLezL
	e23LNPQxOC2TwReKewSiP5dMAGnqX/fXfaFJfGlOdCTfZTl6e7sf5LkZCaOAJhmkoQsPzh9hrDh
	beKzjCRTUNDsqEXVA6nR7KqRPpS0=
X-Google-Smtp-Source: AGHT+IEhkfdVX8aJJDAR/jJORDA50Dx9qePNs/Q1q9lZ3/LOB/oK2kB7IBxLZE/mn8ETt+1wO4l7nWiKRPmHrKRpdp8=
X-Received: by 2002:a05:6808:10cf:b0:3d9:da81:6d59 with SMTP id
 5614622812f47-3dc416dd189mr3063080b6e.34.1723228427559; Fri, 09 Aug 2024
 11:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com> <20240808205006.GA625513@perftesting>
In-Reply-To: <20240808205006.GA625513@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Aug 2024 11:33:35 -0700
Message-ID: <CAJnrk1bSXakZkyiHJ38TD42wbVRE5mQ0amapGM++3Py0PTcD3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:50=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Thu, Aug 08, 2024 at 12:01:09PM -0700, Joanne Koong wrote:
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
> >  fs/fuse/dev.c    | 197 +++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h |  14 ++++
> >  fs/fuse/inode.c  |   7 ++
> >  3 files changed, 210 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 9eb191b5c4de..bcb9ff2156c0 100644
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
> > @@ -277,7 +281,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >   * the 'end' callback is called if given, else the reference to the
> >   * request is released
> >   */
> > -void fuse_request_end(struct fuse_req *req)
> > +static void do_fuse_request_end(struct fuse_req *req)
> >  {
> >       struct fuse_mount *fm =3D req->fm;
> >       struct fuse_conn *fc =3D fm->fc;
> > @@ -296,8 +300,6 @@ void fuse_request_end(struct fuse_req *req)
> >               list_del_init(&req->intr_entry);
> >               spin_unlock(&fiq->lock);
> >       }
> > -     WARN_ON(test_bit(FR_PENDING, &req->flags));
> > -     WARN_ON(test_bit(FR_SENT, &req->flags));
> >       if (test_bit(FR_BACKGROUND, &req->flags)) {
> >               spin_lock(&fc->bg_lock);
> >               clear_bit(FR_BACKGROUND, &req->flags);
> > @@ -329,8 +331,104 @@ void fuse_request_end(struct fuse_req *req)
> >  put_request:
> >       fuse_put_request(req);
> >  }
> > +
> > +void fuse_request_end(struct fuse_req *req)
> > +{
> > +     WARN_ON(test_bit(FR_PENDING, &req->flags));
> > +     WARN_ON(test_bit(FR_SENT, &req->flags));
> > +
> > +     if (req->timer.function)
> > +             timer_delete_sync(&req->timer);
>
> This becomes just timer_delete_sync();
>
> > +
> > +     do_fuse_request_end(req);
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
> > +     req->out.h.error =3D -ETIME;
> > +
> > +     do_fuse_request_end(req);
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
> > +     req->out.h.error =3D -ETIME;
> > +
> > +     do_fuse_request_end(req);
> > +}
> > +
> > +static void fuse_request_timeout(struct timer_list *timer)
> > +{
> > +     struct fuse_req *req =3D container_of(timer, struct fuse_req, tim=
er);
> > +
> > +     /*
> > +      * Request reply is being finished by the kernel right now.
> > +      * No need to time out the request.
> > +      */
> > +     if (test_and_set_bit(FR_FINISHING, &req->flags))
> > +             return;
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
> > @@ -393,6 +491,11 @@ static void request_wait_answer(struct fuse_req *r=
eq)
> >               if (test_bit(FR_PENDING, &req->flags)) {
> >                       list_del(&req->list);
> >                       spin_unlock(&fiq->lock);
> > +                     if (req->timer.function) {
> > +                             bool timed_out =3D !timer_delete_sync(&re=
q->timer);
> > +                             if (timed_out)
> > +                                     return;
> > +                     }
>
> This can just be
>
>         if (!timer_delete_sync(&req->timer))
>                 return;
>
> >                       __fuse_put_request(req);
> >                       req->out.h.error =3D -EINTR;
> >                       return;
> > @@ -409,7 +512,8 @@ static void request_wait_answer(struct fuse_req *re=
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
> > @@ -421,6 +525,10 @@ static void __fuse_request_send(struct fuse_req *r=
eq)
> >               /* acquire extra reference, since request is still needed
> >                  after fuse_request_end() */
> >               __fuse_get_request(req);
> > +             if (req->timer.function) {
> > +                     req->timer.expires =3D jiffies + fc->req_timeout;
> > +                     add_timer(&req->timer);
> > +             }
>
> This can just be
>
> if (req->timer.function)
>         mod_timer(&req->timer, jiffies + fc->req_timeout);
>
> >               queue_request_and_unlock(fiq, req);
> >
> >               request_wait_answer(req);
> > @@ -539,6 +647,10 @@ static bool fuse_request_queue_background(struct f=
use_req *req)
> >               if (fc->num_background =3D=3D fc->max_background)
> >                       fc->blocked =3D 1;
> >               list_add_tail(&req->list, &fc->bg_queue);
> > +             if (req->timer.function) {
> > +                     req->timer.expires =3D jiffies + fc->req_timeout;
> > +                     add_timer(&req->timer);
> > +             }
>
> Same comment as above.
>
> >               flush_bg_queue(fc);
> >               queued =3D true;
> >       }
> > @@ -594,6 +706,10 @@ static int fuse_simple_notify_reply(struct fuse_mo=
unt *fm,
> >
> >       spin_lock(&fiq->lock);
> >       if (fiq->connected) {
> > +             if (req->timer.function) {
> > +                     req->timer.expires =3D jiffies + fm->fc->req_time=
out;
> > +                     add_timer(&req->timer);
> > +             }
>
> Here as well.
>
> >               queue_request_and_unlock(fiq, req);
> >       } else {
> >               err =3D -ENODEV;
> > @@ -1268,8 +1384,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev =
*fud, struct file *file,
> >       req =3D list_entry(fiq->pending.next, struct fuse_req, list);
> >       clear_bit(FR_PENDING, &req->flags);
> >       list_del_init(&req->list);
> > +     /* Acquire a reference in case the timeout handler starts executi=
ng */
> > +     __fuse_get_request(req);
> > +     req->fpq =3D fpq;
> >       spin_unlock(&fiq->lock);
> >
> > +     if (req->timer.function) {
> > +             /*
> > +              * Temporarily disable the timer on the request to avoid =
race
> > +              * conditions between this code and the timeout handler.
> > +              *
> > +              * The timer is readded at the end of this function.
> > +              */
> > +             bool timed_out =3D !timer_delete_sync(&req->timer);
> > +             if (timed_out) {
>
> This can also just be
>
> if (!timer_delete_sync(&req->timer));
>
> > +                     WARN_ON(!test_bit(FR_FINISHED, &req->flags));
> > +                     fuse_put_request(req);
> > +                     goto restart;
> > +             }
> > +     }
> > +
> >       args =3D req->args;
> >       reqsize =3D req->in.h.len;
> >
> > @@ -1280,6 +1414,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *=
fud, struct file *file,
> >               if (args->opcode =3D=3D FUSE_SETXATTR)
> >                       req->out.h.error =3D -E2BIG;
> >               fuse_request_end(req);
> > +             fuse_put_request(req);
> >               goto restart;
> >       }
> >       spin_lock(&fpq->lock);
> > @@ -1316,13 +1451,18 @@ static ssize_t fuse_dev_do_read(struct fuse_dev=
 *fud, struct file *file,
> >       }
> >       hash =3D fuse_req_hash(req->in.h.unique);
> >       list_move_tail(&req->list, &fpq->processing[hash]);
> > -     __fuse_get_request(req);
> >       set_bit(FR_SENT, &req->flags);
> > +
> > +     /* re-arm the original timer */
> > +     if (req->timer.function)
> > +             add_timer(&req->timer);
>
> This will not change anything if the timer was already armed, do you want
> mod_timer_pending() here?  Or maybe just mod_timer()?  Thanks,

In this path, the timer will always be inactive here (we deactivated
it earlier in this function to make race condition handling simpler),
so I will keep this as add_timer() here.

>
> Josef

Thanks for your review, Josef! I will add these changes into v4.

