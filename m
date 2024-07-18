Return-Path: <linux-fsdevel+bounces-23948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6245935100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572571F225BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52931145332;
	Thu, 18 Jul 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqPzbuZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCE144D13
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321942; cv=none; b=Lu7BlcjBRNqmfWmg6vgCsW+l0rVWAp0ZiVs6+YgFBGhbMviSkXgF31Ryd1Q0VdrmApfrfeV7VH/rgxjWMa/IUAibQMIb1R+jR7nYJkHWVxrqrLpfAAQ8G8RCfIIDg7x0lGYqrDzzhF5/vcmyEOc0pSrmpA11FUEY4JCTn4F+Jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321942; c=relaxed/simple;
	bh=PdMSDXoPBpsSuX1k8mSgAGCqQe1QKjqLHe2ZIgc5ixM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nfd+4Gs6mvEAFulhWxe+mwRWRRv/sCBYW2EjvIJH4aiPSjkKWufeKs2F8P1oKewNvm0tXDgacwxoEk9GxlKj+bEBudY/05DHzwcdYoCUIpC/LOv9YA0uiVljAAbHsB/zaBb8DWhQpZLUqOABWMowDzSwNlr7MW3y+IzNYBjvSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqPzbuZJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44aa1464dc1so2691691cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321940; x=1721926740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZcwSIp370dxOuW1fXePm+f1ZJ6S1wtSTZAvg6qwDAM=;
        b=YqPzbuZJ8YQWeswkEBry9WhLK5Gput5LeXdFU8v3dHOOT6OxCIBfjW6sv5aUJFkMHU
         SKypZz1V9xoM1TtBjngjfr1afZ5qWMtTiUk3Zu6nTQJesuCTCyqR1ia/8TN0R0JkC/E1
         5gnRGjW+8iCC9X1WTmtd32BDszyBUohmX23gESWfP4PjEyDK6U68ZbQAOBPpBQeg9dAW
         Y+MQIJxRMPzE5zHue2IhqWVIvOK1CD6ziOKc6p4Q3dJvohcVqJXd5dtH5HNKTTv/QpmQ
         Tu/JOqGoRNHNsh5SXpBiwhLL2oPtB6n2kcNJgfAa1OmFg4/dhCYyyCdivCdYnnDcgVoe
         i52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321940; x=1721926740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZcwSIp370dxOuW1fXePm+f1ZJ6S1wtSTZAvg6qwDAM=;
        b=blVMly/xNyeT/9PUouqRx3R85BvVm+6JEJLqihvRK9yc0gKMI1S3jd+V6n1GReWNfq
         jZOt0cOGiqaK6g34+iaOml+rxBN1jC1nv3s0ALOTt/KGQ1PVyssnTvMmBC3M4SXTFU6Y
         0P254d8gyhqGpn+hiY/On6XS3cMucZzc+cF7bUx9/niXrE3ZbDW0AHTSu0x/5nkL7elm
         wC3bVtK+4M8hXQXwmmKESpk/D9G9vmZv0QPoBUnFF8Y9lgqGUYh9b7DXrShk9phNzLbj
         wPDpJx3DCNyXaBAbujZ+115dbLJuYQZd9AtHC4eDmLHjDcJquffgHnkg9E2SzFgaiId1
         yppQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxepmMWzlheo/WErxELIdvTeCla0N2jtMN2mNcn6f1fC+aKRXPIvMEGzHJ17pPWynaOSreRemuK4pC//IaYmQDZMyZYhP1mA86fCpZaw==
X-Gm-Message-State: AOJu0Yw3ypCFabpZEXNYZnBezK6FW7dw51HjO+3qLDk6nXb5InambJNB
	YTd31+pdo76z08sinBgKC9Hxg0CNddcMlIgScx+NLz9JbrRJsYdQ4n+bM6a/7sbrhQws6kC9E82
	NDnoHtfPPjbdzMce0K28v4CfDXic=
X-Google-Smtp-Source: AGHT+IHi+HWnGfLHtgzIXqWDRyCqN01dAQU6imKVgDC7kKw1kCKFRcOMRbMmjR7RZUUuvzGQuDbV1HQqtrbS9dtJtnA=
X-Received: by 2002:ac8:5ac7:0:b0:447:e393:f301 with SMTP id
 d75a77b69052e-44f969b32b9mr18309161cf.32.1721321939608; Thu, 18 Jul 2024
 09:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717213458.1613347-1-joannelkoong@gmail.com> <20240718144430.GA2099026@perftesting>
In-Reply-To: <20240718144430.GA2099026@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 18 Jul 2024 09:58:48 -0700
Message-ID: <CAJnrk1YgUkkA2Pnb22WvCJrEpotkE3ioQr0F+b5gXrSzs7LUfg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:44=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Jul 17, 2024 at 02:34:58PM -0700, Joanne Koong wrote:
...
> > ---
> >  fs/fuse/dev.c    | 177 ++++++++++++++++++++++++++++++++++++++++++++---
> >  fs/fuse/fuse_i.h |  12 ++++
> >  fs/fuse/inode.c  |   7 ++
> >  3 files changed, 188 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 9eb191b5c4de..7dd7b244951b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -331,6 +331,69 @@ void fuse_request_end(struct fuse_req *req)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_request_end);
> >
> > +/* fuse_request_end for requests that timeout */
> > +static void fuse_request_timeout(struct fuse_req *req)
> > +{
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_pqueue *fpq;
> > +
> > +     spin_lock(&fiq->lock);
> > +     if (!fiq->connected) {
> > +             spin_unlock(&fiq->lock);
> > +             /*
> > +              * Connection is being aborted. The abort will release
> > +              * the refcount on the request
> > +              */
> > +             req->out.h.error =3D -ECONNABORTED;
> > +             return;
> > +     }
> > +     if (test_bit(FR_PENDING, &req->flags)) {
> > +             /* Request is not yet in userspace, bail out */
> > +             list_del(&req->list);
> > +             spin_unlock(&fiq->lock);
> > +             req->out.h.error =3D -ETIME;
> > +             __fuse_put_request(req);
>
> Why is this safe?  We could be the last holder of the reference on this r=
equest
> correct?  The only places using __fuse_put_request() would be where we ar=
e in a
> path where the caller already holds a reference on the request.  Since th=
is is
> async it may not be the case right?
>
> If it is safe then it's just confusing and warrants a comment.
>

There is always a refcount still held on the request by
fuse_simple_request() when this is called. I'll add a comment about
this.
I also just noticed that I use fuse_put_request()  at the end of this
function, I'll change that to __fuse_put_request() as well.

> > +             return;
> > +     }
> > +     if (test_bit(FR_INTERRUPTED, &req->flags))
> > +             list_del_init(&req->intr_entry);
> > +
> > +     fpq =3D req->fpq;
> > +     spin_unlock(&fiq->lock);
> > +
> > +     if (fpq) {
> > +             spin_lock(&fpq->lock);
> > +             if (!fpq->connected && (!test_bit(FR_PRIVATE, &req->flags=
))) {
>                                        ^^
>
> You don't need the extra () there.
>
> > +                     spin_unlock(&fpq->lock);
> > +                     /*
> > +                      * Connection is being aborted. The abort will re=
lease
> > +                      * the refcount on the request
> > +                      */
> > +                     req->out.h.error =3D -ECONNABORTED;
> > +                     return;
> > +             }
> > +             if (req->out.h.error =3D=3D -ESTALE) {
> > +                     /*
> > +                      * Device is being released. The fuse_dev_release=
 call
> > +                      * will drop the refcount on the request
> > +                      */
> > +                     spin_unlock(&fpq->lock);
> > +                     return;
> > +             }
> > +             if (!test_bit(FR_PRIVATE, &req->flags))
> > +                     list_del_init(&req->list);
> > +             spin_unlock(&fpq->lock);
> > +     }
> > +
> > +     req->out.h.error =3D -ETIME;
> > +
> > +     if (test_bit(FR_ASYNC, &req->flags))
> > +             req->args->end(req->fm, req->args, req->out.h.error);
> > +
> > +     fuse_put_request(req);
> > +}
>
> Just a general styling thing, we have two different states for requests h=
ere,
> PENDING and !PENDING correct?  I think it may be better to do something l=
ike
>
> if (test_bit(FR_PENDING, &req->flags))
>         timeout_pending_req();
> else
>         timeout_inflight_req();
>
> and then in timeout_pending_req() you do
>
> spin_lock(&fiq->lock);
> if (!test_bit(FR_PENDING, &req->flags)) {
>         spin_unlock(&fiq_lock);
>         timeout_inflight_req();
>         return;
> }
>
> This will keep the two different state cleanup functions separate and a l=
ittle
> cleaner to grok.
>
Thanks for the suggestion, I will make this change for v2.
> > +
> >  static int queue_interrupt(struct fuse_req *req)
> >  {
> >       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> > @@ -361,6 +424,62 @@ static int queue_interrupt(struct fuse_req *req)
> >       return 0;
> >  }
> >
> > +enum wait_type {
> > +     WAIT_TYPE_INTERRUPTIBLE,
> > +     WAIT_TYPE_KILLABLE,
> > +     WAIT_TYPE_NONINTERRUPTIBLE,
> > +};
> > +
> > +static int fuse_wait_event_interruptible_timeout(struct fuse_req *req)
> > +{
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +
> > +     return wait_event_interruptible_timeout(req->waitq,
> > +                                             test_bit(FR_FINISHED,
> > +                                                      &req->flags),
> > +                                             fc->daemon_timeout);
> > +}
> > +ALLOW_ERROR_INJECTION(fuse_wait_event_interruptible_timeout, ERRNO);
> > +
> > +static int wait_answer_timeout(struct fuse_req *req, enum wait_type ty=
pe)
> > +{
> > +     struct fuse_conn *fc =3D req->fm->fc;
> > +     int err;
> > +
> > +wait_answer_start:
> > +     if (type =3D=3D WAIT_TYPE_INTERRUPTIBLE)
> > +             err =3D fuse_wait_event_interruptible_timeout(req);
> > +     else if (type =3D=3D WAIT_TYPE_KILLABLE)
> > +             err =3D wait_event_killable_timeout(req->waitq,
> > +                                               test_bit(FR_FINISHED, &=
req->flags),
> > +                                               fc->daemon_timeout);
> > +
> > +     else if (type =3D=3D WAIT_TYPE_NONINTERRUPTIBLE)
> > +             err =3D wait_event_timeout(req->waitq, test_bit(FR_FINISH=
ED, &req->flags),
> > +                                      fc->daemon_timeout);
> > +     else
> > +             WARN_ON(1);
>
> This will leak some random value for err, so initialize err to something =
that
> will be dealt with, like -EINVAL;
>
> > +
> > +     /* request was answered */
> > +     if (err > 0)
> > +             return 0;
> > +
> > +     /* request was not answered in time */
> > +     if (err =3D=3D 0) {
> > +             if (test_and_set_bit(FR_PROCESSING, &req->flags))
> > +                     /* request reply is being processed by kernel rig=
ht now.
> > +                      * we should wait for the answer.
> > +                      */
>
> Format for multiline comments is
>
> /*
>  * blah
>  * blah
>  */
>
> and since this is a 1 line if statement put it above the if statement.
>
> > +                     goto wait_answer_start;
> > +
> > +             fuse_request_timeout(req);
> > +             return 0;
> > +     }
> > +
> > +     /* else request was interrupted */
> > +     return err;
> > +}
> > +
> >  static void request_wait_answer(struct fuse_req *req)
> >  {
> >       struct fuse_conn *fc =3D req->fm->fc;
> > @@ -369,8 +488,11 @@ static void request_wait_answer(struct fuse_req *r=
eq)
> >
> >       if (!fc->no_interrupt) {
> >               /* Any signal may interrupt this */
> > -             err =3D wait_event_interruptible(req->waitq,
> > -                                     test_bit(FR_FINISHED, &req->flags=
));
> > +             if (fc->daemon_timeout)
> > +                     err =3D wait_answer_timeout(req, WAIT_TYPE_INTERR=
UPTIBLE);
> > +             else
> > +                     err =3D wait_event_interruptible(req->waitq,
> > +                                                    test_bit(FR_FINISH=
ED, &req->flags));
> >               if (!err)
> >                       return;
> >
> > @@ -383,8 +505,11 @@ static void request_wait_answer(struct fuse_req *r=
eq)
> >
> >       if (!test_bit(FR_FORCE, &req->flags)) {
> >               /* Only fatal signals may interrupt this */
> > -             err =3D wait_event_killable(req->waitq,
> > -                                     test_bit(FR_FINISHED, &req->flags=
));
> > +             if (fc->daemon_timeout)
> > +                     err =3D wait_answer_timeout(req, WAIT_TYPE_KILLAB=
LE);
> > +             else
> > +                     err =3D wait_event_killable(req->waitq,
> > +                                               test_bit(FR_FINISHED, &=
req->flags));
> >               if (!err)
> >                       return;
> >
> > @@ -404,7 +529,10 @@ static void request_wait_answer(struct fuse_req *r=
eq)
> >        * Either request is already in userspace, or it was forced.
> >        * Wait it out.
> >        */
> > -     wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> > +     if (fc->daemon_timeout)
> > +             wait_answer_timeout(req, WAIT_TYPE_NONINTERRUPTIBLE);
> > +     else
> > +             wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags)=
);
> >  }
> >
> >  static void __fuse_request_send(struct fuse_req *req)
> > @@ -1268,6 +1396,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *=
fud, struct file *file,
> >       req =3D list_entry(fiq->pending.next, struct fuse_req, list);
> >       clear_bit(FR_PENDING, &req->flags);
> >       list_del_init(&req->list);
> > +     /* Acquire a reference since fuse_request_timeout may also be exe=
cuting  */
> > +     __fuse_get_request(req);
> > +     req->fpq =3D fpq;
> >       spin_unlock(&fiq->lock);
> >
>
> There's a race here with completion.  If we timeout a request right here,=
 we can
> end up sending that same request below.

I don't think there's any way around this unless we take the fpq lock
while we do the fuse_copy stuff, because even if we check the
FR_PROCESSING bit, the timeout handler could start running after the
fpq lock is released when we do the fuse_copy calls.

In my point of view, I don't think this race matters. We could have
this situation happen on a regular timed-out request. For example, we
send out a request to userspace and if the server takes too long to
reply, the request is cancelled/invalidated in the kernel but the
server will still see the request anyways.

WDYT?

>
> You are going to need to check
>
> test_bit(FR_PROCESSING)
>
> after you take the fpq->lock just below here to make sure you didn't race=
 with
> the timeout handler and time the request out already.
>
> >       args =3D req->args;
> > @@ -1280,6 +1411,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *=
fud, struct file *file,
> >               if (args->opcode =3D=3D FUSE_SETXATTR)
> >                       req->out.h.error =3D -E2BIG;
> >               fuse_request_end(req);
> > +             fuse_put_request(req);
> >               goto restart;
> >       }
> >       spin_lock(&fpq->lock);
> > @@ -1316,13 +1448,23 @@ static ssize_t fuse_dev_do_read(struct fuse_dev=
 *fud, struct file *file,
> >       }
> >       hash =3D fuse_req_hash(req->in.h.unique);
> >       list_move_tail(&req->list, &fpq->processing[hash]);
> > -     __fuse_get_request(req);
> >       set_bit(FR_SENT, &req->flags);
> >       spin_unlock(&fpq->lock);
> >       /* matches barrier in request_wait_answer() */
> >       smp_mb__after_atomic();
> >       if (test_bit(FR_INTERRUPTED, &req->flags))
> >               queue_interrupt(req);
> > +
> > +     /* Check if request timed out */
> > +     if (test_bit(FR_PROCESSING, &req->flags)) {
> > +             spin_lock(&fpq->lock);
> > +             if (!test_bit(FR_PRIVATE, &req->flags))
> > +                     list_del_init(&req->list);
> > +             spin_unlock(&fpq->lock);
> > +             fuse_put_request(req);
> > +             return -ETIME;
> > +     }
>
> This isn't quite right, we could have FR_PROCESSING set because we comple=
ted the
> request before we got here.  If you put a schedule_timeout(HZ); right abo=
ve this
> you could easily see where a request gets completed by userspace, but now=
 you've
> fimed it out.

Oh I see, you're talking about the race where a request is replied to
immediately after the fuse_copy calls and before this gets called.
Then when we get here, we can't differentiate between whether
FR_PROCESSING was set by the timeout handler or the reply handler.

I think the simplest way around this is to check if the FR_SENT flag
was cleared (the reply handler clears it while holding the fpq lock
where FR_PROCESSING gets set and the timeout handler doesn't clear
it), then return -ETIME if it wasn't and 0 if it was.

I'll add this into v2.

>
> Additionally if we have FR_PROCESSING set from the timeout, shouldn't thi=
s
> cleanup have been done already?  I don't understand why we need to handle=
 this
> here, we should just return and whoever is waiting on the request will ge=
t the
> error.

In most cases yes, but there is a race where the timeout handler may
finish executing before the logic in dev_do_read that adds the request
to the fpq lists. If this happens, the freed request will remain on
the list.

i think this race currently exists  prior to these changes as well -
in the case you mentioned above where the request may have been
completed right after the fuse_copy calls in dev_do_read  and before
dev_do_read moves the request to the fpq lists. We would get into the
same situation with a freed request still on the list.


Thanks,
Joanne
>
> Thanks,
>
> Josef

