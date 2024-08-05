Return-Path: <linux-fsdevel+bounces-25048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1410948585
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 00:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36F31C21FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8516B399;
	Mon,  5 Aug 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VErm2aW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54841166F37
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898399; cv=none; b=HTu+RtXLFNRT9xOCYueiBJMR16S1y/pQS8zItC1wOjddnQFYCTVtzmG5BmXfe8sKSN+4YV0qkZORe6EEL3GDV3Cq3Y5AH8AzNv2W0LpcuIdKUXd+N/SgJdcKhbhbaH+Ucpk2DKn27/WgQBkBJAiAP9hDUVGDFb0AaNgKLJnzJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898399; c=relaxed/simple;
	bh=0UJ6F5wDOSYT+xVNYQMYeI3i+5wf2QgfAN9B7fGJUJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0sbnqV6HVPon4WK6tfuZsvCWXyhDqq1crBgbKq0Nf8kNAgrR9sU2WH9xL8LX0pNWZq1oUVqsh2OPgxpC6zvJgVxCGyut502pAPpQzOLLrCnG9mCJAcKSAlSMH8in4hnS2PnJUTqiowCfNtcqGElgn9R6eh3ROzJ6vAtHMkXqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VErm2aW7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db157cb959so5459b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722898396; x=1723503196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNH58678FxQMmexeWfEqA5tyYFR0TmufZaswZj2+yZA=;
        b=VErm2aW7uzQzaSGD8us7XShfG9o/R/lTL6uQRkWlWRERdiCCcZt385UkcgFzYjkiix
         w0vLugE/gG82UryI0MsN8LnFPY0xaFicIDfNXvvrcVOHzWFUk7HOi5CLsjas3LmFF1Vm
         Q1HRVGVM24daQAHLTiiuWfUaqWxNpF7u8jW4ckchD/I9H53qJYk2v7Q5QZYljsQSFoJn
         xR9YToBIvaZWrSnhOPlZ/bcif3fenqhNJeQxrEzj37/gYS0+s0OfgPzfD8AQJS1D3hCW
         1yYmUeCjkfI5i1fzc9lUuI8eSK2qWJbSTNEi9qMcqEe9YF3lEDsfDaLW2npAVuSF2HvL
         +DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898396; x=1723503196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNH58678FxQMmexeWfEqA5tyYFR0TmufZaswZj2+yZA=;
        b=eP0uRsTrpiclN+RWJ9T7kCm0NUcpb2vdZXgRAdWKoZU3QV5aygxTJ3fBWq7m545G+7
         QfgLIsr3fGMSTIslgtuGiLxv3bTh6tyVn38q3n4srjPN6QXmRgaZ84oOEZCjRMUeD1Y2
         ll48tjC5aBNBpknLr/GHsOBK7FgJKLipROgaGnb53JpNLOJBpdjEHUKTFnomGACjxrUW
         UbALVL7bmLkLTGeeeXpCn4Yegf1O8vt6CuzhlLzf/TfclB3rTBx6iHdduAWzYWRETPzD
         Kuqcl3GmU8Jt+ObBqZTKFcGpCpXoOkA7wMyfIEhYpl52InmEX1pCV9xcNxZ7lHrHez71
         Z5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLbcJhuBgvjbvy4uv9uhzcs8T3iboXT8/PvuI3Pw1Ou0l7auRHlir/VEM9K7IcOfXIBUNNW4G65LWiJagOfrw3BWc5Y85cgvd1XM8nVA==
X-Gm-Message-State: AOJu0Yz04lQNh7oOhtokPuSr3M6r+2APHMtGKJrrswq1L+v7YtnoLDdR
	NBZV+1U2BttprS3lNH81dQwgO8h61U46n2lVNxtfEB+/AN2rLjvbFQZzma4I12a+JAm0ZXOO6Zv
	oih5AoTKHJmq2SvTMzx03jbVZs1qvONl3N44=
X-Google-Smtp-Source: AGHT+IHsKWKb3Wectk0TbzZs8nX5dmbQrblMFuic5zT+6GFrZBZg7fKBUITPX4T9ZguUr5kklY7kwsGylnxlluelg4k=
X-Received: by 2002:a05:6808:1313:b0:3da:a6ce:f011 with SMTP id
 5614622812f47-3db557f8201mr18968129b6e.4.1722898396204; Mon, 05 Aug 2024
 15:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com> <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
In-Reply-To: <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Aug 2024 15:53:05 -0700
Message-ID: <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 7/30/24 8:23 AM, Joanne Koong wrote:
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
>
> FMHO, could we move the above error assignment up to the caller to make
> do_fuse_request_end() look cleaner?

Sure, I was thinking that it looks cleaner setting this in
do_fuse_request_end() instead of having to set it in both
timeout_pending_req() and timeout_inflight_req(), but I see your point
as well.
I'll make this change in v3.

>
>
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
>
> Similarly, move the caller i.e. fuse_request_end() call
> timer_delete_sync() instead?

I don't think we can do that because the fuse_put_request() at the end
of this function often holds the last refcount on the request which
frees the request when it releases the ref.

>
>
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
>
> Just out of curious, why fc->bg_lock is needed here, which makes the
> code look less clean?

The fc->bg_lock is needed because the background request may still be
on the fc->bg_queue when the request times out (eg the request hasn't
been flushed yet). We need to acquire the fc->bg_lock so that we can
delete it from the queue, in case somehting else is modifying the
queue at the same time.

>
>
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
>
> I'm not sure if special handling for requests in fpq->io list in needed
> here.  At least when connection is aborted, thos LOCKED requests in
> fpq->io list won't be finished instantly until they are unlocked.
>

The places where FR_LOCKED gets set on the request are in
fuse_dev_do_write and fuse_dev_do_read when we do some of the page
copying stuff. In both those functions, this timeout_pending_req()
path isn't hit while we have the lock obtained - in fuse_dev_do_write,
we test and set FR_FINISHING first before doing the page copying (the
timeout handler will return before calling timeout_pending_req()), and
in fuse_dev_do_read, the locking is called after the FR_PENDING flag
has been cleared.

I think there is a possibility that the timeout handler executes
timeout_inflight_req() while the lock is obtained in fuse_dev_do_read
during the page copying, but this patch added an extra
__fuse_get_request() on the request before doing the page copying,
which means the timeout handler will not free out the request while
the lock is held and the page copying is being done.


Thanks,
Joanne
>
>
> --
> Thanks,
> Jingbo

