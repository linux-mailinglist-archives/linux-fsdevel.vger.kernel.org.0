Return-Path: <linux-fsdevel+bounces-40815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C9A27CCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43543A45A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CE219A80;
	Tue,  4 Feb 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXJroEng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9420A5DA
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700975; cv=none; b=Ge4ldtrlkkQDqEP/pMqSTBjKG5pCB3pWM8hoDRAbI/XZveTnozTanL64nHWSlBOwkZo1NjRIjoFQNEh6Ae8u33Mvbr1HQtOofFU79+C144MMVF1waxtQ+ujMJnaNo5+rwnWaRNvb2X6M3paV5pYUQYkHGUt+/QZ4XHq6DMvdjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700975; c=relaxed/simple;
	bh=wcuDD8n7x39WKFmwJBCUOTdwUyh1/Ql7mX+S07B/g+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv3zBiw2JIyCAefa/HQahTUxnBVullXVrSJmFHSxue/uDoQFxHsZ30Lbo8DGci4p3f8gEgO6waLCEHBHMMzDomvB9Ucyonahu6Cjavc6y3wZT4yOSQEBUI8Y9XLXk1iXZQyvbdLW7Ukcc3WtcKy6xf/nH4az2kFgDlC/fTu9rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXJroEng; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a6ecaa54so45616881cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738700972; x=1739305772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9d2LmXiXp9XgeFwSRW79+9wD+ceyS39+5wCN9tOA/8=;
        b=MXJroEngDH+oa4pouBlUCnq4dBWVQZr6s8oe4bFKY/dnCKKT/4BepA7dws9hp0ajgh
         4t8JqnATbytG+ZEIB1NbM0l4c3nGT/Esi6DEtP5MshOLn6CPGvoNw+zTLr8xIsOS/aSC
         ixYwO+bnbNRSzadkAFKV+s52SR1PKq4UkSgMPEliv7umEp+o2tqUmbMvm8Np2kw+puE7
         I5wDVDUG/9CrQq4cFU28yJRBxRYiSPTbrsIE9Tb3SsvLxM0Z/N4zRLRs5QeH0RQxdyS8
         VvESK0JZyMWdRmnozGSXFU3g2aE5jqHmlSxl8rk6ZK1OT68bOIHj6Bb7AMhtkZl6gvoM
         q9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738700972; x=1739305772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9d2LmXiXp9XgeFwSRW79+9wD+ceyS39+5wCN9tOA/8=;
        b=Oq+CuglrUcYTYGNIo7vB/Cg3s8MabmwTmNdRhFAVOsdtCG7N/kufN/CErBgvHbq20o
         siAYuYTUfr0ONt8ZG5ynxFRERWFCdi6Ui3EtTXs0jbRJeXYLvtD/Ax+ihG80nM0BtM5c
         /GAjO8ucWsM63uV1YyI10yjvZNVTrOobzn4p0/8UvDoYU4mk9tuWKpNzPxBd1qHEpoav
         JEAsgn9M+rIteiVtXKGwxLjVO4Zl7v0ZtLqLso3pE71jMwVfNSRaPdLNHlZSHoF3VSoZ
         nAE9/KsSMi3bqWMtmf4RKc/tKYi0xOiquKRn0YAWbtKJGi6gmrJZmkKFMJqe6vE3emFa
         GmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhOaVf6IZEw8n1OOEAVYtaB4p3LG9HrXaaUlsQM55jq+Qubl0k0vQKeaZ5V0pgm1kFzyxufJPlQb9iURjr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oOSKREpSb7J2CB3na2ZUsXBViJvBqBulhfYs2jstp1cujEG5
	YR55I/uBjIcp/4XAEzvV+7a3boj73bt5ojYBoNuOuCMUz2tCqDozKSl/0I1sgU9bAbQENmMou/B
	egJYVKSSRJhAoPX/dFmtiuLEgGJ4=
X-Gm-Gg: ASbGncuGP1jl/iPQK6WiJH5R0QVtMbZQf5aVCVuF7bV4L231AIP6KasZnaBfERIaUH1
	Hlgap76XssgnAMNk8QjS6Yg13IJXGCtSnWebVTdB+pL6L39w9/4PytyFCYceTJefmgtqJHCVrTw
	==
X-Google-Smtp-Source: AGHT+IEAoD4roSs8AjISfBVrxofBuZVakFr9r/2+dFFVIvRhHm1+vk8vpiRoYIpFqh/qIjh2DIRuv/b8PcUPe9kdJkg=
X-Received: by 2002:a05:622a:260b:b0:46a:3579:d137 with SMTP id
 d75a77b69052e-470282b8b9dmr624441cf.43.1738700970930; Tue, 04 Feb 2025
 12:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm> <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
 <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
In-Reply-To: <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 12:29:19 -0800
X-Gm-Features: AWEUYZmyslhKuXlyXW2e4yh_i10g_GUIhjWt7x-SjN8U-S6z-lIwgyw89SeA27Q
Message-ID: <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:00=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/4/25 20:26, Joanne Koong wrote:
> > Hi Bernd,
> >
> > On Tue, Feb 4, 2025 at 3:03=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On 2/3/25 19:50, Joanne Koong wrote:
> >>> req->flags is set/tested/cleared atomically in fuse. When the FR_PEND=
ING
> >>> bit is cleared from the request flags when assigning a request to a
> >>> uring entry, the fiq->lock does not need to be held.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch suppor=
t")
> >>> ---
> >>>  fs/fuse/dev_uring.c | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>> index ab8c26042aa8..42389d3e7235 100644
> >>> --- a/fs/fuse/dev_uring.c
> >>> +++ b/fs/fuse/dev_uring.c
> >>> @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct=
 fuse_ring_ent *ent,
> >>>                       ent->state);
> >>>       }
> >>>
> >>> -     spin_lock(&fiq->lock);
> >>>       clear_bit(FR_PENDING, &req->flags);
> >>> -     spin_unlock(&fiq->lock);
> >>>       ent->fuse_req =3D req;
> >>>       ent->state =3D FRRS_FUSE_REQ;
> >>>       list_move(&ent->list, &queue->ent_w_req_queue);
> >>
> >> I think that would have an issue in request_wait_answer(). Let's say
> >>
> >>
> >> task-A, request_wait_answer(),
> >>                 spin_lock(&fiq->lock);
> >>                 /* Request is not yet in userspace, bail out */
> >>                 if (test_bit(FR_PENDING, &req->flags)) {  // =3D=3D=3D=
=3D=3D=3D=3D=3D> if passed
> >>                         list_del(&req->list);  // --> removes from the=
 list
> >>
> >> task-B,
> >> fuse_uring_add_req_to_ring_ent()
> >>         clear_bit(FR_PENDING, &req->flags);
> >>         ent->fuse_req =3D req;
> >>         ent->state =3D FRRS_FUSE_REQ;
> >>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
> >>         fuse_uring_add_to_pq(ent, req);  // =3D=3D> Add to list
> >>
> >>
> >>
> >> What I mean is, task-A passes the if, but is then slower than task-B. =
I.e.
> >> task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
> >>
> >
> > Is this race condition possible given that fiq->ops->send_req() is
> > called (and completed) before request_wait_answer() is called? The
> > path I see is this:
> >
> > __fuse_simple_request()
> >     __fuse_request_send()
> >         fuse_send_one()
> >             fiq->ops->send_req()
> >                   fuse_uring_queue_fuse_req()
> >                       fuse_uring_add_req_to_ring_ent()
> >                            clear FR_PENDING bit
> >                            fuse_uring_add_to_pq()
> >         request_wait_answer()
> >
> > It doesn't seem like task A can call request_wait_answer() while task
> > B is running fuse_uring_queue_fuse_req() on the same request while the
> > request still has the FR_PENDING bit set.
> >
> > This case of task A running request_wait_answer() while task B is
> > executing fuse_uring_add_req_to_ring_ent() can happen through
> > fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
> > that point the FR_PENDING flag will have already been cleared on the
> > request, so this would bypass the "if (test_bit(FR_PENDING,...))"
> > check in request_wait_answer().
>
> I mean this case. I don't think FR_PENDING is cleared - why should it?
> And where? The request is pending state, waiting to get into 'FR_SENT'?
>
> >
> > Is there something I'm missing? I think if this race condition is
> > possible, then we also have a bigger problem where the request can be
> > freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
> > &req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
> > fuse_uring_add_to_pq() dereferences it still.
>
> I don't think so, if we take the lock.
>

the path I'm looking at is this:

task A -
__fuse_simple_request()
    fuse_get_req() -> request is allocated (req refcount is 1)
    __fuse_request_send()
        __fuse_get_request() -> req refcount is 2
        fuse_send_one() -> req gets sent to uring
        request_wait_answer()
               ...
               hits the interrupt case, goes into "if
test_bit(FR_PENDING, ...)" case which calls __fuse_put_request(), req
refcount is now 1
    fuse_put_request() -> req refcount is dropped to 0, request is freed

while in task B -
fuse_uring_commit_fetch()
    fuse_uring_next_fuse_req()
        fuse_uring_ent_assign_req()
            gets req off fuse_req_queue
            fuse_uring_add_req_to_ring_ent()
                 clear FR_PENDING
                 fuse_uring_add_to_pq()
                     dereferences req

if task A hits the interrupt case in request_wait_answer() and then
calls fuse_put_request() before task B clears the pending flag (and
after it's gotten the request from the fuse_req_queue in
fuse_uring_ent_assign_req()), then I think we hit this case, no?


Thanks,
Joanne
>
> Thanks,
> Bernd
>

