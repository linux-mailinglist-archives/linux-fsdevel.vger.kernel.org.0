Return-Path: <linux-fsdevel+bounces-24211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97C93B830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 22:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721BB28427E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503713A240;
	Wed, 24 Jul 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkRn4+Pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2A136658
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853864; cv=none; b=KO5XgKn6f2KcTSlWW5A+ZloDULPgWySL4ATR6kJyBFsGhD9ARG/chfpepMC2ezOc1UAjJHMzv/hSW0kC/WoBOb1ctLWXFzbUTrdK9HuYnABmWQacyo2jo9SJETs4LSKq6gqDTqGqboTy4XmOO5L4zoAwzybBjj0ptZ7BKAgw4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853864; c=relaxed/simple;
	bh=JHZ+23lbSSw81nDuEBI9Pc+b5LZD+eaIwVc8T3+tyF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpBLHjbdXDcCh11NK9BE/eaFTAMj2pN7V+7CL3ED6QxpGkGfurekSmbzidGdlq8srzbwlSJfTKkRX22yXh3Dmco9oxQ9gOvCjrb5xhYBnurH1uynqByxAE0U91GrzDDkj71HrizjVU64IbQ/+P+knbbbZTcz1X8umsvofnvlP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkRn4+Pk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44c2c4ccb7aso11739741cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721853861; x=1722458661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4afP4IjqqMAFaL6Ln45Y1LA47H0y2mC7Wn7mbREdUg=;
        b=kkRn4+Pkzrtjrt3W7c6XIcJeOJMMGYWiRY8kVqGc3TVtOrVf2QRaKOFH1cfmNdJIxi
         xf98kpgKW+1QFG81fXWKJH2XFgXxqT89p0xATOMPHiAxoLF3jHAfgo/ZJb4eGXn5/srS
         md9GH33K6FCn6raL3lQopAsKKzLn+J0vb77Oc6VRqsRyM9DATIDpj6uNCtMy5L7PNKup
         nIVzbdwZJ5/7YY/GIE09cPkKdD/9o/M3/OFynSYmVlvn+WJTL1XqKLTRwy0X2QmBFEhk
         bVqMfcw6hAxmaxc6D2rgh0AF4X1nV38743KSx8tazKhcBU7gBQJZuj8EyJCbKUlNE7b5
         Ufrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853861; x=1722458661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4afP4IjqqMAFaL6Ln45Y1LA47H0y2mC7Wn7mbREdUg=;
        b=m+wz3k35ZYvpDz9+5Nz0cctpEuFeCE4umuww0KxJGKTSmwUfhJxDeAAfZZkMrtw3aA
         1FcJQdlY7Xy3TWRliBPHAlx/lbS+7/nWy5ytCHRvxi48fWjcPuiHH7DpvaT0ZWO1tFsz
         EKHwfIJDm+DIB56iIgi2lP3s8nm/sUhW8ZFftCx0A7nPLTSdI1rMi74Ii9FpzWDz3pdU
         KIn92des2THrq/1kPEKFmoVIwtXCZ37h9KGhi+vOtwoOf9SuaJcCcpahAFJ4pthhT6Fg
         hRGlxIRmbEQ+EdpaVtt19GoAxUqqnXjYh/2AyP0AgLLCWOiODoAscgE7mFPqT9Qux8zc
         jtqA==
X-Forwarded-Encrypted: i=1; AJvYcCVRFyYTsnexRkZnZGFZBMw8qwDPNt/znKNaBc9UsD7tVDKsNTMQV5sO0S6rfYLLwmBN0ogIkxhTQX1HSF6yAZnvPup16tHUBlGsZbCiIA==
X-Gm-Message-State: AOJu0YziPzZ7KRawCwpmqKujXWbAH+CKiE1m7sQgZR1Cwem8AfYm2vyK
	RMJqO5uSxzblFsOnuirZ7R9AzcythICSLJgbt6v06rPK4cEZ7F/jyQTbKxqOq+byPIoHvsCGB+Z
	1PapyC07lhOMF9Ko0553JDr+p14HRm8HL
X-Google-Smtp-Source: AGHT+IFRX2wt4vXUSjuBI5M9qLd6TxSTXWS7liGlQHgcqskIAKTj1c+Zn7TR4ydcBi1yp9zAHNeQdHx6HpNJxCQ2NH0=
X-Received: by 2002:a05:622a:199e:b0:447:f6c7:65ee with SMTP id
 d75a77b69052e-44fd7af6604mr47776401cf.10.1721853861284; Wed, 24 Jul 2024
 13:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <20240718144430.GA2099026@perftesting> <CAJnrk1YgUkkA2Pnb22WvCJrEpotkE3ioQr0F+b5gXrSzs7LUfg@mail.gmail.com>
In-Reply-To: <CAJnrk1YgUkkA2Pnb22WvCJrEpotkE3ioQr0F+b5gXrSzs7LUfg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Jul 2024 13:44:10 -0700
Message-ID: <CAJnrk1bHA=gT87pknd8JVcM96THy4JPFPb=-Ue8wSGCH_Lwh-g@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 9:58=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Jul 18, 2024 at 7:44=E2=80=AFAM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Wed, Jul 17, 2024 at 02:34:58PM -0700, Joanne Koong wrote:
> ...
> > > ---
> > >  fs/fuse/dev.c    | 177 ++++++++++++++++++++++++++++++++++++++++++++-=
--
> > >  fs/fuse/fuse_i.h |  12 ++++
> > >  fs/fuse/inode.c  |   7 ++
> > >  3 files changed, 188 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 9eb191b5c4de..7dd7b244951b 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -331,6 +331,69 @@ void fuse_request_end(struct fuse_req *req)
> > >  }
> > >  EXPORT_SYMBOL_GPL(fuse_request_end);
> > >
> > > +/* fuse_request_end for requests that timeout */
> > > +static void fuse_request_timeout(struct fuse_req *req)
> > > +{
> > > +     struct fuse_conn *fc =3D req->fm->fc;
> > > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > > +     struct fuse_pqueue *fpq;
> > > +
> > > +     spin_lock(&fiq->lock);
> > > +     if (!fiq->connected) {
> > > +             spin_unlock(&fiq->lock);
> > > +             /*
> > > +              * Connection is being aborted. The abort will release
> > > +              * the refcount on the request
> > > +              */
> > > +             req->out.h.error =3D -ECONNABORTED;
> > > +             return;
> > > +     }
> > > +     if (test_bit(FR_PENDING, &req->flags)) {
> > > +             /* Request is not yet in userspace, bail out */
> > > +             list_del(&req->list);
> > > +             spin_unlock(&fiq->lock);
> > > +             req->out.h.error =3D -ETIME;
> > > +             __fuse_put_request(req);
> >
> > Why is this safe?  We could be the last holder of the reference on this=
 request
> > correct?  The only places using __fuse_put_request() would be where we =
are in a
> > path where the caller already holds a reference on the request.  Since =
this is
> > async it may not be the case right?
> >
> > If it is safe then it's just confusing and warrants a comment.
> >
>
> There is always a refcount still held on the request by
> fuse_simple_request() when this is called. I'll add a comment about
> this.
> I also just noticed that I use fuse_put_request()  at the end of this
> function, I'll change that to __fuse_put_request() as well.
>
> > > +             return;
> > > +     }
> > > +     if (test_bit(FR_INTERRUPTED, &req->flags))
> > > +             list_del_init(&req->intr_entry);
> > > +
> > > +     fpq =3D req->fpq;
> > > +     spin_unlock(&fiq->lock);
> > > +
> > > +     if (fpq) {
> > > +             spin_lock(&fpq->lock);
> > > +             if (!fpq->connected && (!test_bit(FR_PRIVATE, &req->fla=
gs))) {
> >                                        ^^
> >
> > You don't need the extra () there.
> >
> > > +                     spin_unlock(&fpq->lock);
> > > +                     /*
> > > +                      * Connection is being aborted. The abort will =
release
> > > +                      * the refcount on the request
> > > +                      */
> > > +                     req->out.h.error =3D -ECONNABORTED;
> > > +                     return;
> > > +             }
> > > +             if (req->out.h.error =3D=3D -ESTALE) {
> > > +                     /*
> > > +                      * Device is being released. The fuse_dev_relea=
se call
> > > +                      * will drop the refcount on the request
> > > +                      */
> > > +                     spin_unlock(&fpq->lock);
> > > +                     return;
> > > +             }
> > > +             if (!test_bit(FR_PRIVATE, &req->flags))
> > > +                     list_del_init(&req->list);
> > > +             spin_unlock(&fpq->lock);
> > > +     }
> > > +
> > > +     req->out.h.error =3D -ETIME;
> > > +
> > > +     if (test_bit(FR_ASYNC, &req->flags))
> > > +             req->args->end(req->fm, req->args, req->out.h.error);
> > > +
> > > +     fuse_put_request(req);
> > > +}
> >
> > Just a general styling thing, we have two different states for requests=
 here,
> > PENDING and !PENDING correct?  I think it may be better to do something=
 like
> >
> > if (test_bit(FR_PENDING, &req->flags))
> >         timeout_pending_req();
> > else
> >         timeout_inflight_req();
> >
> > and then in timeout_pending_req() you do
> >
> > spin_lock(&fiq->lock);
> > if (!test_bit(FR_PENDING, &req->flags)) {
> >         spin_unlock(&fiq_lock);
> >         timeout_inflight_req();
> >         return;
> > }
> >
> > This will keep the two different state cleanup functions separate and a=
 little
> > cleaner to grok.
> >
> Thanks for the suggestion, I will make this change for v2.
> > > +
> > >  static int queue_interrupt(struct fuse_req *req)
> > >  {
> > >       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> > > @@ -361,6 +424,62 @@ static int queue_interrupt(struct fuse_req *req)
> > >       return 0;
> > >  }
> > >
> > > +enum wait_type {
> > > +     WAIT_TYPE_INTERRUPTIBLE,
> > > +     WAIT_TYPE_KILLABLE,
> > > +     WAIT_TYPE_NONINTERRUPTIBLE,
> > > +};
> > > +
> > > +static int fuse_wait_event_interruptible_timeout(struct fuse_req *re=
q)
> > > +{
> > > +     struct fuse_conn *fc =3D req->fm->fc;
> > > +
> > > +     return wait_event_interruptible_timeout(req->waitq,
> > > +                                             test_bit(FR_FINISHED,
> > > +                                                      &req->flags),
> > > +                                             fc->daemon_timeout);
> > > +}
> > > +ALLOW_ERROR_INJECTION(fuse_wait_event_interruptible_timeout, ERRNO);
> > > +
> > > +static int wait_answer_timeout(struct fuse_req *req, enum wait_type =
type)
> > > +{
> > > +     struct fuse_conn *fc =3D req->fm->fc;
> > > +     int err;
> > > +
> > > +wait_answer_start:
> > > +     if (type =3D=3D WAIT_TYPE_INTERRUPTIBLE)
> > > +             err =3D fuse_wait_event_interruptible_timeout(req);
> > > +     else if (type =3D=3D WAIT_TYPE_KILLABLE)
> > > +             err =3D wait_event_killable_timeout(req->waitq,
> > > +                                               test_bit(FR_FINISHED,=
 &req->flags),
> > > +                                               fc->daemon_timeout);
> > > +
> > > +     else if (type =3D=3D WAIT_TYPE_NONINTERRUPTIBLE)
> > > +             err =3D wait_event_timeout(req->waitq, test_bit(FR_FINI=
SHED, &req->flags),
> > > +                                      fc->daemon_timeout);
> > > +     else
> > > +             WARN_ON(1);
> >
> > This will leak some random value for err, so initialize err to somethin=
g that
> > will be dealt with, like -EINVAL;
> >
> > > +
> > > +     /* request was answered */
> > > +     if (err > 0)
> > > +             return 0;
> > > +
> > > +     /* request was not answered in time */
> > > +     if (err =3D=3D 0) {
> > > +             if (test_and_set_bit(FR_PROCESSING, &req->flags))
> > > +                     /* request reply is being processed by kernel r=
ight now.
> > > +                      * we should wait for the answer.
> > > +                      */
> >
> > Format for multiline comments is
> >
> > /*
> >  * blah
> >  * blah
> >  */
> >
> > and since this is a 1 line if statement put it above the if statement.
> >
> > > +                     goto wait_answer_start;
> > > +
> > > +             fuse_request_timeout(req);
> > > +             return 0;
> > > +     }
> > > +
> > > +     /* else request was interrupted */
> > > +     return err;
> > > +}
> > > +
> > >  static void request_wait_answer(struct fuse_req *req)
> > >  {
> > >       struct fuse_conn *fc =3D req->fm->fc;
> > > @@ -369,8 +488,11 @@ static void request_wait_answer(struct fuse_req =
*req)
> > >
> > >       if (!fc->no_interrupt) {
> > >               /* Any signal may interrupt this */
> > > -             err =3D wait_event_interruptible(req->waitq,
> > > -                                     test_bit(FR_FINISHED, &req->fla=
gs));
> > > +             if (fc->daemon_timeout)
> > > +                     err =3D wait_answer_timeout(req, WAIT_TYPE_INTE=
RRUPTIBLE);
> > > +             else
> > > +                     err =3D wait_event_interruptible(req->waitq,
> > > +                                                    test_bit(FR_FINI=
SHED, &req->flags));
> > >               if (!err)
> > >                       return;
> > >
> > > @@ -383,8 +505,11 @@ static void request_wait_answer(struct fuse_req =
*req)
> > >
> > >       if (!test_bit(FR_FORCE, &req->flags)) {
> > >               /* Only fatal signals may interrupt this */
> > > -             err =3D wait_event_killable(req->waitq,
> > > -                                     test_bit(FR_FINISHED, &req->fla=
gs));
> > > +             if (fc->daemon_timeout)
> > > +                     err =3D wait_answer_timeout(req, WAIT_TYPE_KILL=
ABLE);
> > > +             else
> > > +                     err =3D wait_event_killable(req->waitq,
> > > +                                               test_bit(FR_FINISHED,=
 &req->flags));
> > >               if (!err)
> > >                       return;
> > >
> > > @@ -404,7 +529,10 @@ static void request_wait_answer(struct fuse_req =
*req)
> > >        * Either request is already in userspace, or it was forced.
> > >        * Wait it out.
> > >        */
> > > -     wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> > > +     if (fc->daemon_timeout)
> > > +             wait_answer_timeout(req, WAIT_TYPE_NONINTERRUPTIBLE);
> > > +     else
> > > +             wait_event(req->waitq, test_bit(FR_FINISHED, &req->flag=
s));
> > >  }
> > >
> > >  static void __fuse_request_send(struct fuse_req *req)
> > > @@ -1268,6 +1396,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev=
 *fud, struct file *file,
> > >       req =3D list_entry(fiq->pending.next, struct fuse_req, list);
> > >       clear_bit(FR_PENDING, &req->flags);
> > >       list_del_init(&req->list);
> > > +     /* Acquire a reference since fuse_request_timeout may also be e=
xecuting  */
> > > +     __fuse_get_request(req);
> > > +     req->fpq =3D fpq;
> > >       spin_unlock(&fiq->lock);
> > >
> >
> > There's a race here with completion.  If we timeout a request right her=
e, we can
> > end up sending that same request below.
>
> I don't think there's any way around this unless we take the fpq lock
> while we do the fuse_copy stuff, because even if we check the
> FR_PROCESSING bit, the timeout handler could start running after the
> fpq lock is released when we do the fuse_copy calls.
>
> In my point of view, I don't think this race matters. We could have
> this situation happen on a regular timed-out request. For example, we
> send out a request to userspace and if the server takes too long to
> reply, the request is cancelled/invalidated in the kernel but the
> server will still see the request anyways.
>
> WDYT?
>
> >
> > You are going to need to check
> >
> > test_bit(FR_PROCESSING)
> >
> > after you take the fpq->lock just below here to make sure you didn't ra=
ce with
> > the timeout handler and time the request out already.
> >
> > >       args =3D req->args;
> > > @@ -1280,6 +1411,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev=
 *fud, struct file *file,
> > >               if (args->opcode =3D=3D FUSE_SETXATTR)
> > >                       req->out.h.error =3D -E2BIG;
> > >               fuse_request_end(req);
> > > +             fuse_put_request(req);
> > >               goto restart;
> > >       }
> > >       spin_lock(&fpq->lock);
> > > @@ -1316,13 +1448,23 @@ static ssize_t fuse_dev_do_read(struct fuse_d=
ev *fud, struct file *file,
> > >       }
> > >       hash =3D fuse_req_hash(req->in.h.unique);
> > >       list_move_tail(&req->list, &fpq->processing[hash]);
> > > -     __fuse_get_request(req);
> > >       set_bit(FR_SENT, &req->flags);
> > >       spin_unlock(&fpq->lock);
> > >       /* matches barrier in request_wait_answer() */
> > >       smp_mb__after_atomic();
> > >       if (test_bit(FR_INTERRUPTED, &req->flags))
> > >               queue_interrupt(req);
> > > +
> > > +     /* Check if request timed out */
> > > +     if (test_bit(FR_PROCESSING, &req->flags)) {
> > > +             spin_lock(&fpq->lock);
> > > +             if (!test_bit(FR_PRIVATE, &req->flags))
> > > +                     list_del_init(&req->list);
> > > +             spin_unlock(&fpq->lock);
> > > +             fuse_put_request(req);
> > > +             return -ETIME;
> > > +     }
> >
> > This isn't quite right, we could have FR_PROCESSING set because we comp=
leted the
> > request before we got here.  If you put a schedule_timeout(HZ); right a=
bove this
> > you could easily see where a request gets completed by userspace, but n=
ow you've
> > fimed it out.
>
> Oh I see, you're talking about the race where a request is replied to
> immediately after the fuse_copy calls and before this gets called.
> Then when we get here, we can't differentiate between whether
> FR_PROCESSING was set by the timeout handler or the reply handler.
>
> I think the simplest way around this is to check if the FR_SENT flag
> was cleared (the reply handler clears it while holding the fpq lock
> where FR_PROCESSING gets set and the timeout handler doesn't clear
> it), then return -ETIME if it wasn't and 0 if it was.
>
> I'll add this into v2.
>
> >
> > Additionally if we have FR_PROCESSING set from the timeout, shouldn't t=
his
> > cleanup have been done already?  I don't understand why we need to hand=
le this
> > here, we should just return and whoever is waiting on the request will =
get the
> > error.
>
> In most cases yes, but there is a race where the timeout handler may
> finish executing before the logic in dev_do_read that adds the request
> to the fpq lists. If this happens, the freed request will remain on
> the list.
>
> i think this race currently exists  prior to these changes as well -

amendment: this statement is not accurate. In the existing code, there
is no race between the reply handler and dev_do_read, because the
reply handler can only handle the request once the request is on the
fpq->processing list.
(We do need to account for this race with the timeout handler though
since the timeout handler can get triggered at any time).

Also, while working on v2 I noticed we also need to handle races
between the timeout handler and requests being re-sent
(fuse_resend()). This will get addressed in v2.

> in the case you mentioned above where the request may have been
> completed right after the fuse_copy calls in dev_do_read  and before
> dev_do_read moves the request to the fpq lists. We would get into the
> same situation with a freed request still on the list.
>
>
> Thanks,
> Joanne
> >
> > Thanks,
> >
> > Josef

