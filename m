Return-Path: <linux-fsdevel+bounces-40792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468BA27B34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1A5163117
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6D219A63;
	Tue,  4 Feb 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2L9aa7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C259215F72
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697213; cv=none; b=OVPb5LLIdX5f7qe21pYHawGcU9lQtN8OeKH44lA7PsK1NrHhGn44t1XAqP4Iz35blDQ/FOPZM6Ussvrg9OMFu5m687pJn/cr/n+9MxXMZMo7c5eKpcZhi5tCgtlsGVa89xzJOKBtDQ3OPRy4TSCqrHjwOr8DT226xYMqcjj3J2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697213; c=relaxed/simple;
	bh=8iOrN4gChF8s0JNrVndRmGGRrlp6PTw3IiRceR3NKGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgpVmVnCka0CrtQ30+devQF8iwBCl9sX6JoAd7eXFFTQxEurAxQwoQWqqabsKeBTCMWfBrHjp8VeNjtgKG09AIy0FNQ+zGuSPvmyvmUjuck/G8p590uFNPfwLq232HqHyeTEXUL6Dsw/84IMK7WOTi9lGtW8bYAojcXkvo8ZOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2L9aa7O; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b086e0easo26578471cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 11:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697210; x=1739302010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX+ebhHFUJCciirr60UXuPNF1SKMt4VoirsEV8vhr0M=;
        b=H2L9aa7OnzB8y7kHtXotgD3MEMDSjGGSUaoXFv8DBvFisaNB1UVYHhK0T2eysA73BG
         nWm7PfDeaVBaYbXg9TC7qs0SQnaQve2mPSeS4u0hAIzF9cIAZ8KAuppICiDzj9+igbq6
         OADc3WyWJYakRJtCNdlZSkxMIsNPlf1UPAhXF4KIbmIneGgZCMstmEFoJ3BdfoWRdLFt
         4Pl9yKK7drotJqcYPOpac1EX87lL4B2/4Yf86zBqlOw23ZwUqvTdU0bTKYpsRc5V2HmA
         b0x7S7fLp/xDQpdS35pkdHAQ9HqIbhbwSjI3Q7LFXSI91hW8TDXWIgsCzi9V3uQoVowV
         jkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697210; x=1739302010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX+ebhHFUJCciirr60UXuPNF1SKMt4VoirsEV8vhr0M=;
        b=l5EQwmyKRKlyLL9FgS86G7nNteSAAFqkb7l7Y3SvQPKPsH/bS+mnl+iHwRtLI1ifBs
         SpiDc3i2C82zQSkiE/n5+YPJkGqtkM4dn+M6Hu5/itZKyDZO8wScusX1rT3jqD/t3ew/
         iFIFLjEkYIqR11dvsgTkuiQRHNngpJaevqUa7RHKepBLuVdRO2p5lV2+FNbWAcZurRDH
         +/mAqjgv4fllYRGXkDNPHbYLxZqqN70NQoTlHj8UG2mQivG1SPZbhUL5LK3zXJMYyLS0
         1NMyCWd0ww+jmYN0uFe+gow/geVC+Z9gyGueXgjvHs29yKuIbeqCrpvqL8m0Oo5tBRTJ
         wrPg==
X-Forwarded-Encrypted: i=1; AJvYcCVb5IBM5GMcP7jdp3/vQV50B+NPr1KA6B+z32cVjj9pVueHWOH5F2xq+IZj8aNqMv3+i5zilwUpDrewenNi@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWIRDI/f+7dSZWfyt0EfgTQYzg4dNww/KrIYmMlN0qk/qI81r
	dNRD8neZXZ5DVK0MC4wnKcVUA/o8k4hu+n9BQCLBlci01KCMC9lOm9ayB5bLL0hklGFuzHnPa4S
	lHHUU72w6Z/U0QgfI7W7jfr6kGT4RYKFeu9g=
X-Gm-Gg: ASbGncuWXINN8rll1AwvCwDItQQ8CMif4jgYsHXFkZsYmBXJB/j4cn8YRkVnaaeIPx6
	Xyhpyt0YCZDQgbA/szT7kDvH1Tutrrkn1gT0KqvSoBoUXYArTSwcGCzMTysMbxVX5RxV3LeRS7g
	==
X-Google-Smtp-Source: AGHT+IEC0GwUTsNvOBPSQRy4z/zKOdVJEHcundNILKtqXgD3Jp6fJyBmKefMQogL9mW0Hs4tyF9jioDzMF2DizDdlbk=
X-Received: by 2002:a05:622a:4108:b0:469:715:d94c with SMTP id
 d75a77b69052e-46fd0a123abmr384553441cf.6.1738697210000; Tue, 04 Feb 2025
 11:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203185040.2365113-1-joannelkoong@gmail.com> <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
In-Reply-To: <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 4 Feb 2025 11:26:39 -0800
X-Gm-Features: AWEUYZmKvnK5zwr1AFfr91nvFuAJk1Zp3kWVo1zpA8fBeLk97Ir7wifidyCfvP8
Message-ID: <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

On Tue, Feb 4, 2025 at 3:03=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 2/3/25 19:50, Joanne Koong wrote:
> > req->flags is set/tested/cleared atomically in fuse. When the FR_PENDIN=
G
> > bit is cleared from the request flags when assigning a request to a
> > uring entry, the fiq->lock does not need to be held.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support"=
)
> > ---
> >  fs/fuse/dev_uring.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index ab8c26042aa8..42389d3e7235 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct f=
use_ring_ent *ent,
> >                       ent->state);
> >       }
> >
> > -     spin_lock(&fiq->lock);
> >       clear_bit(FR_PENDING, &req->flags);
> > -     spin_unlock(&fiq->lock);
> >       ent->fuse_req =3D req;
> >       ent->state =3D FRRS_FUSE_REQ;
> >       list_move(&ent->list, &queue->ent_w_req_queue);
>
> I think that would have an issue in request_wait_answer(). Let's say
>
>
> task-A, request_wait_answer(),
>                 spin_lock(&fiq->lock);
>                 /* Request is not yet in userspace, bail out */
>                 if (test_bit(FR_PENDING, &req->flags)) {  // =3D=3D=3D=3D=
=3D=3D=3D=3D> if passed
>                         list_del(&req->list);  // --> removes from the li=
st
>
> task-B,
> fuse_uring_add_req_to_ring_ent()
>         clear_bit(FR_PENDING, &req->flags);
>         ent->fuse_req =3D req;
>         ent->state =3D FRRS_FUSE_REQ;
>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
>         fuse_uring_add_to_pq(ent, req);  // =3D=3D> Add to list
>
>
>
> What I mean is, task-A passes the if, but is then slower than task-B. I.e=
.
> task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
>

Is this race condition possible given that fiq->ops->send_req() is
called (and completed) before request_wait_answer() is called? The
path I see is this:

__fuse_simple_request()
    __fuse_request_send()
        fuse_send_one()
            fiq->ops->send_req()
                  fuse_uring_queue_fuse_req()
                      fuse_uring_add_req_to_ring_ent()
                           clear FR_PENDING bit
                           fuse_uring_add_to_pq()
        request_wait_answer()

It doesn't seem like task A can call request_wait_answer() while task
B is running fuse_uring_queue_fuse_req() on the same request while the
request still has the FR_PENDING bit set.

This case of task A running request_wait_answer() while task B is
executing fuse_uring_add_req_to_ring_ent() can happen through
fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
that point the FR_PENDING flag will have already been cleared on the
request, so this would bypass the "if (test_bit(FR_PENDING,...))"
check in request_wait_answer().

Is there something I'm missing? I think if this race condition is
possible, then we also have a bigger problem where the request can be
freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
&req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
fuse_uring_add_to_pq() dereferences it still.


Thanks,
Joanne

>
> Now the ring entry gets handled by fuse-server, comes back to fuse-client
> and does not find the request anymore, because both tasks raced.
> The entire ring entry will be lost - it not be used anymore for
> the live time of the connection.
>
> And the other issue might be total list corruption, because two tasks mig=
ht
> access the list at the same time.
>
>
> Thanks,
> Bernd
>

