Return-Path: <linux-fsdevel+bounces-40797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97CA27BD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98893A1A11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8112054EF;
	Tue,  4 Feb 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMUWcwRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B580158558
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698477; cv=none; b=HuCgPgnQPEuC3o2g0IX2kN2JRptIn2p+H0aFe432kaladUgIRTxwrIR+F3mq37+FmgGd/XenP8YTmn8Hu+1R1Zks71sswHg4RVYA8NKHFByIMM3+kZfbtgN7tnDylh6b7fKRb2EyoR9ofB9sY4C8QRZy91XvVSVpFRZorFtOyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698477; c=relaxed/simple;
	bh=TWcljjHVyRNTDXriFzBxk4UCl4WrqQEpk1bjqXnqVrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPZ7p7Dq+DVk4s69ZXBF8TqzeePsEYywGF3jOYoverskZBw2L2hTAVs7mwlzetaBqFEDgOEyMTU40zp3q/ZxL+O55G3nLTDeLtxSVAM68w2D4ubX4OhEWlx6lbMRdtsXvqzvIGS54JcfChb2Fbxr4Qq1OldlbPEthfLdChML+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMUWcwRU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679ea3b13bso45524891cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698474; x=1739303274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uz/bhCxOkiqiQ5fGNubuTRvJEzNY2vW4oESVyrGZLg=;
        b=CMUWcwRU0Np/CQVmUFNB96OI5gydzGySQr3PCeZ6hhHvIg4D1UINUM/Vcaz0EBApNg
         eFHz96BUG4i/Seac+AB+fy/2OOPVCgd70E7WopDfdxdqkPC7kkpix2t8TJjpYoKD3zGM
         V+oOxPWeAhjoSip2o88iXcHTgi8ttu57HVLYKjeXZswYXeNzcbiMa+cpDAPyjdQdcvZ2
         836Hv5uJkSFOZCYVmOHXbrDDnnrrJqKyfUDPKR3cussiq3R3/HpcPxtj3GV8Pc8EbWbC
         pyITnvWvWep699VQxLyylMqF67FN4Z7r3TirWbet9DdeyWH61DgKkMqBGsd7n8bEg1Gq
         Y0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698474; x=1739303274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uz/bhCxOkiqiQ5fGNubuTRvJEzNY2vW4oESVyrGZLg=;
        b=HOPRMI8sYhKbY7O5aLOmqJi4vPPqDz9DDJ2jwWnTSlkkqryuLCmHpALHfiru2B8WwV
         8rmYoPuQHbZTeskOhhfVimoeKQBwqYvo8neLhQIpX6tm+QpNzilG6azg1crH+YY3K53C
         vIfdgdqdsfarKSHBVccn+U1TIRonWeh7P8zr1P9Dy/sjs/Mt3+f4MCFmmiy+c2yJXmWh
         zrh6EovZepjrEbO0kGqrNjDzxTrRpeTFbcBlqkHXqBkn5HGkA0uJ3qnYeQlkhQTufjpY
         BdH2hL1BTJ8iyjGUxgvMVG+ppaTF0DWZsnS9q0StOhDbUxKQ9/YsJxxENMv8zmBinTh1
         xhBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XDEVUEeOPda8uhLud3TgqVr+x05GGmKX+RPj/9hUbMjqTnpuNxuaHxRrpYOxmLxXbQWfB9MdVtiSGG2f@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMPUdwmh4zk2jIS7beNc6gpsmjij8RpZQW8HEz1FUv7T2zyrv
	s4BmrJkaEWJ/MmaMhPInLXhdrDXWLMwiwPZvmPdKtsaL8Us/U7pUa/pz9UCB0Z+e4kZ7FcTqJ3a
	6u1fVf5WV5oFmXk7mHBF4pxlRJIE=
X-Gm-Gg: ASbGncsD612w8Mc+iPQkNA4mOSct2QUhkXfssgtxaJ+9beoZdpSzSC0xDKOn2Xgm03+
	0HVdZADXzKAyculuyQiBsb5/W1jikVcMOof5f4yJN3HXTuKCcwUqDPMsktMv4sH6GqGqTVfDliQ
	==
X-Google-Smtp-Source: AGHT+IH02QfsDRJvDdyceupuGtCbfc3qm4jr184JjC5XC4Wm5Hi7fZ/BuFDbJvhEddt7RsLltUF7r8vqf2BsD16aAUM=
X-Received: by 2002:a05:622a:108:b0:467:528b:fb7c with SMTP id
 d75a77b69052e-46fd0a6efa1mr370216501cf.25.1738698474276; Tue, 04 Feb 2025
 11:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm> <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
In-Reply-To: <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 11:47:43 -0800
X-Gm-Features: AWEUYZmE8SXIanM1Mhv3pXhqFRdUBAQ3dy4gspLFa2pyIT1_AVn7-YYUoaKwdvk
Message-ID: <CAJnrk1asrJ4tsCSZno_saV1f4LJYausv5-rOTP5VdFn_szP84A@mail.gmail.com>
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:26=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Hi Bernd,
>
> On Tue, Feb 4, 2025 at 3:03=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > Hi Joanne,
> >
> > On 2/3/25 19:50, Joanne Koong wrote:
> > > req->flags is set/tested/cleared atomically in fuse. When the FR_PEND=
ING
> > > bit is cleared from the request flags when assigning a request to a
> > > uring entry, the fiq->lock does not need to be held.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch suppor=
t")
> > > ---
> > >  fs/fuse/dev_uring.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > index ab8c26042aa8..42389d3e7235 100644
> > > --- a/fs/fuse/dev_uring.c
> > > +++ b/fs/fuse/dev_uring.c
> > > @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct=
 fuse_ring_ent *ent,
> > >                       ent->state);
> > >       }
> > >
> > > -     spin_lock(&fiq->lock);
> > >       clear_bit(FR_PENDING, &req->flags);
> > > -     spin_unlock(&fiq->lock);
> > >       ent->fuse_req =3D req;
> > >       ent->state =3D FRRS_FUSE_REQ;
> > >       list_move(&ent->list, &queue->ent_w_req_queue);
> >
> > I think that would have an issue in request_wait_answer(). Let's say
> >
> >
> > task-A, request_wait_answer(),
> >                 spin_lock(&fiq->lock);
> >                 /* Request is not yet in userspace, bail out */
> >                 if (test_bit(FR_PENDING, &req->flags)) {  // =3D=3D=3D=
=3D=3D=3D=3D=3D> if passed
> >                         list_del(&req->list);  // --> removes from the =
list
> >
> > task-B,
> > fuse_uring_add_req_to_ring_ent()
> >         clear_bit(FR_PENDING, &req->flags);
> >         ent->fuse_req =3D req;
> >         ent->state =3D FRRS_FUSE_REQ;
> >         list_move_tail(&ent->list, &queue->ent_w_req_queue);
> >         fuse_uring_add_to_pq(ent, req);  // =3D=3D> Add to list
> >
> >
> >
> > What I mean is, task-A passes the if, but is then slower than task-B. I=
.e.
> > task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
> >
>
> Is this race condition possible given that fiq->ops->send_req() is
> called (and completed) before request_wait_answer() is called? The
> path I see is this:
>
> __fuse_simple_request()
>     __fuse_request_send()
>         fuse_send_one()
>             fiq->ops->send_req()
>                   fuse_uring_queue_fuse_req()
>                       fuse_uring_add_req_to_ring_ent()
>                            clear FR_PENDING bit
>                            fuse_uring_add_to_pq()
>         request_wait_answer()
>
> It doesn't seem like task A can call request_wait_answer() while task
> B is running fuse_uring_queue_fuse_req() on the same request while the
> request still has the FR_PENDING bit set.
>
> This case of task A running request_wait_answer() while task B is
> executing fuse_uring_add_req_to_ring_ent() can happen through
> fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
> that point the FR_PENDING flag will have already been cleared on the
> request, so this would bypass the "if (test_bit(FR_PENDING,...))"
> check in request_wait_answer().
>
> Is there something I'm missing? I think if this race condition is
> possible, then we also have a bigger problem where the request can be
> freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
> &req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
> fuse_uring_add_to_pq() dereferences it still.

Oh okay so in the case where there is no ring entry available when we
send the request, then the pending bit does not get set on the request
and then a fuse_uring_commit_fetch() ->
fuse_uring_add_req_to_ring_ent() can run in parallel with the
request_wait_answer() ->  if (test_bit(FR_PENDING, &req->flags))
logic.

But it looks like this race condition can happen right now in the
existing code where the last refcount on the request will get dropped
and the request freed while we're dereferencing it in
fuse_uring_add_to_pq(). I'm looking at fuse_uring_ent_assign_req()
right now - maybe we need to grab the fiq lock before we dequeue from
req_queue and then clear FR_PENDING wihile the lock is held? Gonna
think about this some more.

Thanks,
Joanne

>
>
> Thanks,
> Joanne
>
> >
> > Now the ring entry gets handled by fuse-server, comes back to fuse-clie=
nt
> > and does not find the request anymore, because both tasks raced.
> > The entire ring entry will be lost - it not be used anymore for
> > the live time of the connection.
> >
> > And the other issue might be total list corruption, because two tasks m=
ight
> > access the list at the same time.
> >
> >
> > Thanks,
> > Bernd
> >

