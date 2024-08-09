Return-Path: <linux-fsdevel+bounces-25553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9294D59F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C347D281A4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123C131182;
	Fri,  9 Aug 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFtbajqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8217557
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225874; cv=none; b=e7HU+WrgASjgZOcJPXjhVlbL7jYOgG9O0ZNHItv3RwO4alHT0DbTA4YzgJZ0h87TipSCAl6DBxpzSPgOyNslZmU6kSXnx7CC5cFW5Ewu2cKVnjkmXW3iW2FL3NGucpUgild4+7rYdcZE6bDYWU1BT9y93vw1YmboHkBNNSQK+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225874; c=relaxed/simple;
	bh=8IR/mkH0Guo+lIHaPZIHH364Mfd0Qt+Ka5F6UUOc2Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgNxrWmGTh6YT9V/4enD9pCudN2/rvnYt1wp+7/tvS2IJOp8LiBGtcLFm9+jgf3U6uKDAw6jSQy6Vf6wmRMOoyhmlxeyjif4/h6IDHxwadLuCvi0oDB8ZTfFS9y+W3/pkhRiVE0cnDBAGOxsEmkvkKapPFfJEQT1cRcNSSaM3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFtbajqS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3dc16d00ba6so1549179b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723225872; x=1723830672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS2/KCvCm9mnTGvHBImwiGBH87PYPwcsqmjF5lg3AwY=;
        b=WFtbajqSFKfDCV5WfLdN/F/1UAtBEsbpi3QHU3zHr+qNqY+/dIyI4xgHPTTDc0Uv5C
         qiafKT5krRiFhvE/HzVbFlYkXChHOMnZ0kHYoEVXjBgKzZkeOG44T4ic5xK2vxtxe3ix
         cQA+CqBu6btqongAJz2NvykCGXw3n/pylqTVA7ojDRCa72JpbDMl0iDNfuxlZM/7/XVO
         sXjWBkgQ6eMKZOBunuij/xzYB9a5ZTjilrpxfo+zeUV7BKMIf7576YV8CQwdt8OdIYKC
         n3OVZyC7Kxlk2r3WeZR00Jvg2lH3tNAmfqxKfhf1wUx8wTMEQfyMJDFEx3sNW1BBwygb
         O5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723225872; x=1723830672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS2/KCvCm9mnTGvHBImwiGBH87PYPwcsqmjF5lg3AwY=;
        b=XqHd7Vm/U7y3B1j/DfHqhhW9+XE3Tj0hI6S4b5asdTM+PLTUqWpfkzeDfPgXbdkhOP
         Tpa00Px4bRLH9sXzXC/rl68IEKjqub7pYPVnubY9Edm2TILyoosOqljVgeCHXUeQvjkq
         LRoLuEO9fatC3LKl53q+jCYkHx/fJ3acQnaONKJ+Mc/jG7C5P14ep0DPYUfHhWU6pFUm
         AFpViHnezU0JIoygwu/9p/QtC7smsh9bRikNTjHg8fL7Y4bmaPV6fVhIZzZhSqldTiVr
         uiZlQNAK2S+/2odvoWU7m+RqnT24nxguFg9yYtEn6IpFDvR89ZXk8gof3cSdpIFAmfyf
         ajvg==
X-Forwarded-Encrypted: i=1; AJvYcCXU3/a34pFVup/RpLFwyLtc4KO4hDHwT9IA+NxpwAFzX0f5s5LsV2uYoWBVZZDEKqCJYxG/EiuNSvvLrHitMqZITuNjawhxbPKHTXigiQ==
X-Gm-Message-State: AOJu0YwM+q9M3Vh1a9aAHaQBzU2e00E5F+IZQ1TeoCAi/5+1uCIkuZ6s
	f+lPqtYZ8IFuGPU9IeS+pcFCA6QlXxfjI7/yybCOV7hMT6eOMYRBAQGw03cVWWj1CvC8/dDegVa
	/8M79FxF5/Hp3DFvoo3vFHuD4Cts=
X-Google-Smtp-Source: AGHT+IEl/SZIvc9NUrbSCR7IzO5/uT0y1+GkJpIGkk4JphWLR4sOvpAzWVikRCLpQbD9k0CAJaw6RnsEhnwFTuFzG5k=
X-Received: by 2002:a05:6808:148f:b0:3d5:6504:6713 with SMTP id
 5614622812f47-3dc416e3c8emr2524896b6e.43.1723225871812; Fri, 09 Aug 2024
 10:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com> <8d28f744-0f14-4cad-9b51-30dec0fec692@linux.alibaba.com>
In-Reply-To: <8d28f744-0f14-4cad-9b51-30dec0fec692@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Aug 2024 10:51:00 -0700
Message-ID: <CAJnrk1bZhd3jenHDvx1kDi3ZirYfQ5YaSnf80qiw=N5Kb22dRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for requests
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:22=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 8/9/24 3:01 AM, Joanne Koong wrote:
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
> > +                     WARN_ON(!test_bit(FR_FINISHED, &req->flags));
>
> Is there any possibility that FR_FINISHED bit has not been set for the
> request when the timeout handler finishes, e.g. for the following sequenc=
e?

Ah, i meant for this to be FR_FINISHING, not FR_FINISHED. Just as a
sanity check that the timeout handler was invoked, even if it wasn't
the one that ultimately cleaned up the request. I will make this fix
in v4. Thanks!

>
>
> ```
> # read                  # timer handler         #aborting
> fuse_dev_do_read
>   spin_lock(&fiq->lock)
>   # remove req from
>   # pending list
>   spin_unlock(&fiq->lock)
>
>                                                 fuse_abort_conn
>                                                   spin_lock(fpq->lock)
>                                                   fpq->connected =3D 0
>                                                   spin_unlock(fpq->lock)
>
>                         fuse_request_timeout
>   # disarm the timer
>     # wait for
>     # timer handler
>                           timeout_inflight_req
>                             spin_lock(&fpq->lock)
>                             if !fpq->connected:
>                               spin_unlock(&fpq->lock)
>                               return
>   WARN(no FR_FINISHED)!
>                                                   end_requests
>                                                     set FR_FINISHED bit
> ```
>
>
>
>
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
> > +
> >       spin_unlock(&fpq->lock);
> >       /* matches barrier in request_wait_answer() */
> >       smp_mb__after_atomic();
> >       if (test_bit(FR_INTERRUPTED, &req->flags))
> >               queue_interrupt(req);
> > +
>
> A nonsense newline diff?

I'll remove this newline in v4.

>
>
>
> --
> Thanks,
> Jingbo

Thanks,
Joanne

