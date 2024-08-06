Return-Path: <linux-fsdevel+bounces-25141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C69495CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B4E288E79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BED40858;
	Tue,  6 Aug 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9zbZumc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64F2C697
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962609; cv=none; b=j1jYD+c4xewdPIDFFQIRHcJGlGnXKJdf4L5Hby0C57n0UoNpewRZlihQaNIU3ps43DEw8OIrgeMAKo791YC84Q4aYv58TEDxal/y40KbIepxnAm0dYdCVdArUE+loZf9aJsHNZMV2fc9+g016AIuwNG++CnC2uMljwXFg6VxIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962609; c=relaxed/simple;
	bh=spAKRxMAHtLIWo0kMt00qH4Ikj5s7K6LpFUO6oCpdi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBp8EZljusUUAjLwPhuGq2dfW8teeFzK30/Kid2WHvQvwyAg1Xy31by1ljy7s0PM3ev806CgwTctn7BIa/cY6pmG+XV547/8J6svQ/giDGxCaJmNvN46V4/JgeRbKLVnzv490gyXMphp+1eByuOfAkAzSKgRfzLG0qr0yYhS+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9zbZumc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9e13ef8edso475827b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962606; x=1723567406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28R1IyvrLm1Fj1Ee5LR+kpFbCkRxYd7hCQ6BmSH1fwY=;
        b=D9zbZumcda0WjBMz/78/bBLCxDCEENqLM22MVhr1YPfhLIeWXKeC1qmy3vfSB6OSK7
         +g6ZVCyqGDdu2/GdisFXprCX9f+1WzX8sDU4uWP/t72KbBefUWzB0Vdr6JycofhbFsOE
         s7X9xw+gjyVhlHkqedBnKcZMhpovrE/2jgrfV4XaGjPCKQkmhiMUkzBI1E5KTqDN4j6B
         vQmSQgPW8hNGHX/O+aGVTObZCY6pHfKzHhr3YbwNorlEFjoHBAdIiRSkNSWqQCREnx9e
         o4VI4XUkTIm7ZaEsWT4Gx2AlBxuPW+3rp2/7IgXRri8+qGQHrKMS88ZGUb6yApN6VqbS
         0f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962606; x=1723567406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28R1IyvrLm1Fj1Ee5LR+kpFbCkRxYd7hCQ6BmSH1fwY=;
        b=GgPCrI+aoLGHW3egf2HQYXg2C1Qc1ebbR9803PvNdDSZxmyC2bq0na1cixcY/ccmVP
         PQZ32ZijWWviIJ3QZJtTfGx63d6vFzpsVmOCAYenswNscDRvgXm3YW8voziAYp0/lWuw
         CcBPLYI05uwgM218ee8jesUIvVCnghZ9aOPFcpuAn8OBHskbvD4sy8Vo0SeZWfULot1A
         BptmkbVNE1jEx4MTSJ6l/4vm+OwzsFVzeCMxbCKVLu5spTY2XlQTJtFWqOGGHJAo18ax
         h4fopHQWyTyT916DPX4I4zMypbTJRkydjSw3ba4KO6mN5i2vPmfoxQBvDSyRr0soH5VW
         5+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/2dc+ajdsT+Uxzu6fthtrirFLkXEkbeYO48w6I/ApTdP9j4s+FddXY0jaWp/2PYwtysti+cSAJt3BPLbkF3kEwGhXptVvuEhYtjGEJA==
X-Gm-Message-State: AOJu0YwlpBF0PM33RchdUa6B3J6zbxPoZTA83YDvAMn+rGl8u/sKJhiX
	KneSk+JULImKMRIpEbZ12Hmh95jibU33bi/hsMIQC0NI9hv+xLWzTwKp5hrt4RLeoqFQfn3d/Q1
	COo00vXPpQo6vVDwy1t+PBGbtg48=
X-Google-Smtp-Source: AGHT+IEhM+ruFyVEITgHxays2TpoB5dpwa1cW8EkAV5NLZ4tLFF0dgCGs0e10QGbxqB2630sd3cwA42k64sYRYQnJhg=
X-Received: by 2002:a05:6808:301e:b0:3da:a032:24c5 with SMTP id
 5614622812f47-3db5580dd35mr16360564b6e.22.1722962606152; Tue, 06 Aug 2024
 09:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com> <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
 <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com> <c238a20d-807f-41d2-9ce0-519bffe5ab26@linux.alibaba.com>
In-Reply-To: <c238a20d-807f-41d2-9ce0-519bffe5ab26@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Aug 2024 09:43:15 -0700
Message-ID: <CAJnrk1boHEZ4_tp0U_3dck0DhH2gtP3k5HG5L7ZfjMLihRJchg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for requests
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 7:45=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 8/6/24 6:53 AM, Joanne Koong wrote:
> > On Mon, Aug 5, 2024 at 12:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> On 7/30/24 8:23 AM, Joanne Koong wrote:
> >>> There are situations where fuse servers can become unresponsive or ta=
ke
> >>> too long to reply to a request. Currently there is no upper bound on
> >>> how long a request may take, which may be frustrating to users who ge=
t
> >>> stuck waiting for a request to complete.
> >>>
> >>> This commit adds a timeout option (in seconds) for requests. If the
> >>> timeout elapses before the server replies to the request, the request
> >>> will fail with -ETIME.
> >>>
> >>> There are 3 possibilities for a request that times out:
> >>> a) The request times out before the request has been sent to userspac=
e
> >>> b) The request times out after the request has been sent to userspace
> >>> and before it receives a reply from the server
> >>> c) The request times out after the request has been sent to userspace
> >>> and the server replies while the kernel is timing out the request
> >>>
> >>> While a request timeout is being handled, there may be other handlers
> >>> running at the same time if:
> >>> a) the kernel is forwarding the request to the server
> >>> b) the kernel is processing the server's reply to the request
> >>> c) the request is being re-sent
> >>> d) the connection is aborting
> >>> e) the device is getting released
> >>>
> >>> Proper synchronization must be added to ensure that the request is
> >>> handled correctly in all of these cases. To this effect, there is a n=
ew
> >>> FR_FINISHING bit added to the request flags, which is set atomically =
by
> >>> either the timeout handler (see fuse_request_timeout()) which is invo=
ked
> >>> after the request timeout elapses or set by the request reply handler
> >>> (see dev_do_write()), whichever gets there first. If the reply handle=
r
> >>> and the timeout handler are executing simultaneously and the reply ha=
ndler
> >>> sets FR_FINISHING before the timeout handler, then the request will b=
e
> >>> handled as if the timeout did not elapse. If the timeout handler sets
> >>> FR_FINISHING before the reply handler, then the request will fail wit=
h
> >>> -ETIME and the request will be cleaned up.
> >>>
> >>> Currently, this is the refcount lifecycle of a request:
> >>>
> >>> Synchronous request is created:
> >>> fuse_simple_request -> allocates request, sets refcount to 1
> >>>   __fuse_request_send -> acquires refcount
> >>>     queues request and waits for reply...
> >>> fuse_simple_request -> drops refcount
> >>>
> >>> Background request is created:
> >>> fuse_simple_background -> allocates request, sets refcount to 1
> >>>
> >>> Request is replied to:
> >>> fuse_dev_do_write
> >>>   fuse_request_end -> drops refcount on request
> >>>
> >>> Proper acquires on the request reference must be added to ensure that=
 the
> >>> timeout handler does not drop the last refcount on the request while
> >>> other handlers may be operating on the request. Please note that the
> >>> timeout handler may get invoked at any phase of the request's
> >>> lifetime (eg before the request has been forwarded to userspace, etc)=
.
> >>>
> >>> It is always guaranteed that there is a refcount on the request when =
the
> >>> timeout handler is executing. The timeout handler will be either
> >>> deactivated by the reply/abort/release handlers, or if the timeout
> >>> handler is concurrently executing on another CPU, the reply/abort/rel=
ease
> >>> handlers will wait for the timeout handler to finish executing first =
before
> >>> it drops the final refcount on the request.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>  fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++=
--
> >>>  fs/fuse/fuse_i.h |  14 ++++
> >>>  fs/fuse/inode.c  |   7 ++
> >>>  3 files changed, 200 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >>> index 9eb191b5c4de..9992bc5f4469 100644
> >>> --- a/fs/fuse/dev.c
> >>> +++ b/fs/fuse/dev.c
> >>> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
> >>>
> >>>  static struct kmem_cache *fuse_req_cachep;
> >>>
> >>> +static void fuse_request_timeout(struct timer_list *timer);
> >>> +
> >>>  static struct fuse_dev *fuse_get_dev(struct file *file)
> >>>  {
> >>>       /*
> >>> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm=
, struct fuse_req *req)
> >>>       refcount_set(&req->count, 1);
> >>>       __set_bit(FR_PENDING, &req->flags);
> >>>       req->fm =3D fm;
> >>> +     if (fm->fc->req_timeout)
> >>> +             timer_setup(&req->timer, fuse_request_timeout, 0);
> >>>  }
> >>>
> >>>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gf=
p_t flags)
> >>> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc=
)
> >>>   * the 'end' callback is called if given, else the reference to the
> >>>   * request is released
> >>>   */
> >>> -void fuse_request_end(struct fuse_req *req)
> >>> +static void do_fuse_request_end(struct fuse_req *req, bool from_time=
r_callback)
> >>>  {
> >>>       struct fuse_mount *fm =3D req->fm;
> >>>       struct fuse_conn *fc =3D fm->fc;
> >>>       struct fuse_iqueue *fiq =3D &fc->iq;
> >>>
> >>> +     if (from_timer_callback)
> >>> +             req->out.h.error =3D -ETIME;
> >>> +
> >>
> >> FMHO, could we move the above error assignment up to the caller to mak=
e
> >> do_fuse_request_end() look cleaner?
> >
> > Sure, I was thinking that it looks cleaner setting this in
> > do_fuse_request_end() instead of having to set it in both
> > timeout_pending_req() and timeout_inflight_req(), but I see your point
> > as well.
> > I'll make this change in v3.
> >
> >>
> >>
> >>>       if (test_and_set_bit(FR_FINISHED, &req->flags))
> >>>               goto put_request;
> >>>
> >>> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
> >>>               list_del_init(&req->intr_entry);
> >>>               spin_unlock(&fiq->lock);
> >>>       }
> >>> -     WARN_ON(test_bit(FR_PENDING, &req->flags));
> >>> -     WARN_ON(test_bit(FR_SENT, &req->flags));
> >>>       if (test_bit(FR_BACKGROUND, &req->flags)) {
> >>>               spin_lock(&fc->bg_lock);
> >>>               clear_bit(FR_BACKGROUND, &req->flags);
> >>> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
> >>>               wake_up(&req->waitq);
> >>>       }
> >>>
> >>> +     if (!from_timer_callback && req->timer.function)
> >>> +             timer_delete_sync(&req->timer);
> >>> +
> >>
> >> Similarly, move the caller i.e. fuse_request_end() call
> >> timer_delete_sync() instead?
> >
> > I don't think we can do that because the fuse_put_request() at the end
> > of this function often holds the last refcount on the request which
> > frees the request when it releases the ref.
>
> Initially I mean timer_delete_sync() could be called before
> do_fuse_request_end() inside fuse_request_end().  But anyway it's a
> rough idea just for making the code look cleaner, without thinking if
> this logic change is right or not.

Ahh I see now what you were saying. Great suggestion! I'll change this for =
v3.

>
>
> >>> +static void timeout_pending_req(struct fuse_req *req)
> >>> +{
> >>> +     struct fuse_conn *fc =3D req->fm->fc;
> >>> +     struct fuse_iqueue *fiq =3D &fc->iq;
> >>> +     bool background =3D test_bit(FR_BACKGROUND, &req->flags);
> >>> +
> >>> +     if (background)
> >>> +             spin_lock(&fc->bg_lock);
> >>
> >> Just out of curious, why fc->bg_lock is needed here, which makes the
> >> code look less clean?
> >
> > The fc->bg_lock is needed because the background request may still be
> > on the fc->bg_queue when the request times out (eg the request hasn't
> > been flushed yet). We need to acquire the fc->bg_lock so that we can
> > delete it from the queue, in case somehting else is modifying the
> > queue at the same time.
>
> I can understand now.  Thanks!
>
> >
> >>
> >>
> >>> +     spin_lock(&fiq->lock);
> >>> +
> >>> +     if (!test_bit(FR_PENDING, &req->flags)) {
> >>> +             spin_unlock(&fiq->lock);
> >>> +             if (background)
> >>> +                     spin_unlock(&fc->bg_lock);
> >>> +             timeout_inflight_req(req);
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     if (!test_bit(FR_PRIVATE, &req->flags))
> >>> +             list_del_init(&req->list);
> >>> +
> >>> +     spin_unlock(&fiq->lock);
> >>> +     if (background)
> >>> +             spin_unlock(&fc->bg_lock);
> >>> +
> >>> +     do_fuse_request_end(req, true);
> >>
> >> I'm not sure if special handling for requests in fpq->io list in neede=
d
> >> here.  At least when connection is aborted, thos LOCKED requests in
> >> fpq->io list won't be finished instantly until they are unlocked.
> >>
> >
> > The places where FR_LOCKED gets set on the request are in
> > fuse_dev_do_write and fuse_dev_do_read when we do some of the page
> > copying stuff. In both those functions, this timeout_pending_req()
> > path isn't hit while we have the lock obtained - in fuse_dev_do_write,
> > we test and set FR_FINISHING first before doing the page copying (the
> > timeout handler will return before calling timeout_pending_req()), and
> > in fuse_dev_do_read, the locking is called after the FR_PENDING flag
> > has been cleared.
> >
> > I think there is a possibility that the timeout handler executes
> > timeout_inflight_req() while the lock is obtained in fuse_dev_do_read
> > during the page copying, but this patch added an extra
> > __fuse_get_request() on the request before doing the page copying,
> > which means the timeout handler will not free out the request while
> > the lock is held and the page copying is being done.
> >
>
> Yes, this is the only possible place where the timeout handler could
> concurrently run while the request is in copying state (i.e. LOCKED).
> As I described above, when connection is aborted, the LOCKED requests
> will be left there and won't be finished until they are unlocked.  I'm
> not sure why this special handling is needed for LOCKED requests, but I
> guess it's not because of UAF issue.  From the comment of
> lock_request(), "Up to the next unlock_request() there mustn't be
> anything that could cause a page-fault.", though I can't understand in
> which case there will be a page fault and it will be an issue.

It's not clear to me either what in the end_requests() logic that
abort_conn would call could cause a page fault. It would be great to
get some light on this.

For v3 I'm going to integrate Bernd's suggestion and disarm the timer
before dev_do_read's main logic and rearm it after, which will also
obviate this possible scenario of the timeout handler executing while
the request is in locked copying state.

Thanks,
Joanne

>
> Maybe I'm wrong.  It would be helpful if someone could shed light on this=
.
>
>
> --
> Thanks,
> Jingbo

