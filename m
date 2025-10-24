Return-Path: <linux-fsdevel+bounces-65574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51727C07ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166E41AA41AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA462BEFF9;
	Fri, 24 Oct 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz0GK/aH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EA2BEFF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334680; cv=none; b=Sl3m/ob56t6PcaZo0a8H/qXKltCzzCkgi02G+8+nr1rGnpNgRW/wXFi/ZNAHYi6KiPkLr8i/xiRSj9NODbUO+AVEKM6NTxyh0/4oxAbUpQXll6AXDYoUa93yq4a+L9vQpARR6GbmfddUtvuKeuqcXREMoR1iqGpWni0ESv1D/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334680; c=relaxed/simple;
	bh=jxCaOjNQtTL+qljTyPA1mHAF4C8g0MF1oaDOxEFrxKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFBzTXV3r0icF0uw8qz7GrlA8xeTvOFeMLyEJGYW7Z74mr8jI3LhN44R4KbsL4603Lm4l8n9VgdgTJRZk3ipgqVAtamJgMM+mFr91lOkvk42k7kOoRw8W/0K6dprc2fuwbDs8RrYx6lHe49ljcbgQDtJ3fViQSmIEp3SaX0dQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz0GK/aH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4e89ac45e61so23822681cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761334678; x=1761939478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxCaOjNQtTL+qljTyPA1mHAF4C8g0MF1oaDOxEFrxKQ=;
        b=Iz0GK/aHIkFSEYF+f3+qeGlQWnCIjN7jvt5BHJhXt95VBC9a1diV0k/W8QZlVwHF8A
         AkJJg/eFRZpFds0IhYQKk4Xq3mwKUwaZWmYB9tE+e4drcxLRxKqWrviYgiHatoFI55iW
         QtP007XJdodmF+n5sqXftpgqF/osP1LJ/e1TXQ3cx2E4LCNc74eVqhJo28l2zyPnBynQ
         uVDBXAn+gK8CSk/uQEec/Ja8pkMYJiz98lAw1hF4HocJXzWegByKAldZ3YFE6NWk0qmp
         Ulx/moFoi7R+ghKGzoI78kpOUp5DfVitk7P+rtr2Ry8rJsoC47Vmc7pxe6MepY1jXhCC
         1AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761334678; x=1761939478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxCaOjNQtTL+qljTyPA1mHAF4C8g0MF1oaDOxEFrxKQ=;
        b=AnJTPdxb7YBwhctd9PS3kKLwncKRXHeRrAnUPYxXN3NQh4dfZYKsZWWEZVDUb/MEfj
         twApyYjlZdhpVi7UGlRx2DRas8C0+4GcHiaf21NvYy7TW4ADSbibRqrAYF+laIlXrOej
         9lSqvCL3eChpL9F9/vbw0AX2kbbmo1NKmo5UZbwdEfa5fl/0rD0KD3njFE5a6KzXmJW6
         YxG3tt/GN16vmroEgcGLHcJU15v8l7gBoLS+XAg30GR7RmyPAozfIg2Xzp/NmNjWvtuf
         ppgKQBX3FvzlrLLMkomwocFBe49oZlNey17sVsy6dgwgMsoCAlT48cZOeD5+LGwtc1BK
         tWSA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+FOjRIo36BndDGNOGkDTuuFn5ORxOEGsviESqMrkxh0J/ObstHcMeZ+7qfxvg2fUNZNSFdP4wcQWGeoR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+z7XJfPuRGcBpJ/TJRYMYam1PdBnV5cu2rtXmnZiRjJPQ+cKq
	DND4npeClVxO7lDYzFMMdOolON4//641uARAAWGPsanbd65+v1gjzMS3TiJmd0ViimDAaCngIB0
	u5IhY03hQAR+1FTfWBBfFUyNZO+/wjU4=
X-Gm-Gg: ASbGncuHm7kmjtzRKSNQM7TPKiiBob0E6UW6K/ovEutPUKHLPfO70gvBd1Uv1/hz7ig
	78gBG+cU0pMNhKBsCOQyOLav/YOM63emEAmvfVSeTTkxCky3KV4LSqU4mlvBEeK1Krd5wC+tTlD
	wz8PyGlCdeB+IiuuzqhlVI1dUintD8nuD3EnqlRhls+rc0+nORNizK5di+gdmE/E98j4mu1kaUN
	gncN6bKuq7HK1T2jxwgCaFVVFi3sWJhmPX3m2ZcqMkOU2pBbCMEfPvASxF18m9Mptt3oS0dMqKs
	bU3jo7Ms8CaMFozIFZkHO0nB/w==
X-Google-Smtp-Source: AGHT+IGNRbLKWdFqdFsvsbww+Es4iTgJjDnipZsGHEvkTewYe9MtMpl+0UXONNgsdyKyONe+l+UOqMc5fN6AQ87ulXo=
X-Received: by 2002:ac8:7d8d:0:b0:4e8:b4a5:7f1c with SMTP id
 d75a77b69052e-4eb815dce14mr103197821cf.79.1761334677821; Fri, 24 Oct 2025
 12:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com>
 <539ebaba-e105-4cf3-ade4-4184a4365710@ddn.com> <CAJnrk1Y2cKgc3snAK8jJpVn5EJpLPE87nqxjcE-eKBWK0TvUgg@mail.gmail.com>
 <a2aaea17-0719-425e-8999-16a8367c57e7@ddn.com>
In-Reply-To: <a2aaea17-0719-425e-8999-16a8367c57e7@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 12:37:47 -0700
X-Gm-Features: AS18NWAgNJy26ZwWDRXhJAQPOqkLUFwSxBJ4VjbCGnz8wNPHfrenMJ66HVeqa4I
Message-ID: <CAJnrk1Y3z1=douWdDDxnq0bWOTggKEgrrZrLGO+0wcA028MxPg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse io_uring: support registered buffers
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:12=E2=80=AFAM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> On 10/24/25 00:27, Joanne Koong wrote:
> > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Bernd Schubert <bschubert@ddn.c=
om> wrote:
> >>
> >> On 10/22/25 22:20, Joanne Koong wrote:
> >>> This adds support for daemons who preregister buffers to minimize the=
 overhead
> >>> of pinning/unpinning user pages and translating virtual addresses. Re=
gistered
> >>> buffers pay the cost once during registration then reuse the pre-pinn=
ed pages,
> >>> which helps reduce the per-op overhead.
> >>>
> >>> This is on top of commit 211ddde0823f in the iouring tree.
> >>
> >> Interesting, on a first glance this looks like an alternative
> >> implementation of page pinning
> >>
> >> https://lore.kernel.org/all/20240901-b4-fuse-uring-rfcv3-without-mmap-=
v3-17-9207f7391444@ddn.com/
> >>
> >> At DDN we are running with that patch (changed commit message) and ano=
ther
> >> one that avoids io_uring_cmd_complete_in_task() - with pinned pages
> >> the IO submitting application can directly write into header and paylo=
ad
> >> (note that the latter also required pinned headers)
> >>
> >> Going to look into your approach tomorrow.
> >
> > Thanks for taking a look when you get the chance. The libfuse changes
> > are in this branch
> > https://github.com/joannekoong/libfuse/tree/registered_buffers btw.
>
> Sorry, still didn't manage another task for tomorrow. Btw, the reason
> hadn't sent my patches is that I hadn't handled memory accounting yet.
> And then got busy with other tasks for much too long...
>
> I see in io_sqe_buffers_register() how that is done, although I'm
> confused why it first calls io_pin_pages() and only then accounts. I.e.
> it can temporarily go above the limit - I wonder what happens if the
> user opens another application that time that just needs a little locked
> memory...
>
> In general I think your solution more complex than mine - I think I'm
> going to update my patches (there are conflicts due to folio conversion)
> and then we can compare.

Hi Bernd,

I think this solution is actually less complex because all the pinning
and accounting stuff is taken care of by io-uring and there's one
pinned buffer instead of pinning the header and payload separately.

I think the part that looks complex maybe is the integration of the
bvec iter with header copying. For v2 I have it vastly simplified so
that we just kmap the header, which makes it play more nicely with
directly accessing the header struct members instead of going through
the bvec iter.

Thanks,
Joanne

>
>
> Thanks,
> Bernd

