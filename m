Return-Path: <linux-fsdevel+bounces-20996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DF8FC025
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3C31F25569
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785A14E2C0;
	Tue,  4 Jun 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii35dO9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9614D6E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544718; cv=none; b=KUpxk/KlYPZDGjaPIRunGMpwHo3YJdQAltMQwKZJPjBh6x74AvBMYiYYAC5AHrwf1hjFvuVM2S2ajNnvMb85kQLS60gbAuY5P05o3U0vDmpiqS3ffx/xV9YBNQ6zuiKXS7eyOzkA7PVhO6tEbsB4dFDuQqK0hqoS/n7La1QXkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544718; c=relaxed/simple;
	bh=stETFfnRRb6Hne9Q8Bjmr9lmUhhhlh26o1aqaAC1XuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+FywXJ0oaEcaljV2meWjYlHHYKLigziCNSUW873dsSkM6da+JbjXiIPY0vbe1RG3aH1JrN97B3/aORn64oH7FaROnr4Nq4wgQM+TcCkB9ISZaAPo3XWE9HHYcpqT977ExwKmVLBRGwFY44+t6zW8mwSOncRGsdb5zzIOG8JGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ii35dO9x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717544715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXZh0KwFhXAR4SA+Lj8Y93PPzSjoD2fSnEAWnfuXfzg=;
	b=ii35dO9xZ//jzgSunusVJyDwmhDizrJj/LJJnD8wN3j+dEVnTEdrMr5S5c7k4zDpPjs/Y+
	DNnRdz1oF01RD28Zh55lfpsn1OqllEkPv67+0pwnNH6r20IdfQ/lAJeHrZsA923omE71XU
	zcMuCe1b9bJn1tRPo6OuIVWfe2FR4UI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-NcznjxfAOxewO6AyUxAnog-1; Tue, 04 Jun 2024 19:45:14 -0400
X-MC-Unique: NcznjxfAOxewO6AyUxAnog-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48bc062acddso375495137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 16:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544713; x=1718149513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXZh0KwFhXAR4SA+Lj8Y93PPzSjoD2fSnEAWnfuXfzg=;
        b=vQQlQRYq26DZTvCOXc8ujwbfEOz50T4AU5Jzum4H2j1PtgHBMOt6PwOhwU6exAaClr
         YWtoRggHPt/kdv2o2JPI3VhMHNY12QrxpNV6Z2dccG/bHA8C4O5zgWRaoT9PmghQdhcV
         nKfzFltpVERFlv0xxrmlrNd2jEiWawhxMnApq5jBuJYbPq8K/FMl7QjFhB7MtN36mfgK
         45QUEDZ1lA69hxi/8rUtArWQPsvYpw15YzvM1mXvq76SWux/Lly77ysiajqNl+Vx5fW4
         cd8r31VjvPfO5l/WqzdsAFBElFpVX39vLDiR5jAgb43yQcMfoPp+slzEhFvq9ubS443V
         MCCA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsit1BUbslgRHRLKWyhAXybfzm1m74H9dI2kWczweo64jCrIeRJql8R2Fr83NcPYoWIo1Xju+3Du/sZvGB04qTAvsQYeiCZaAiQlzfQ==
X-Gm-Message-State: AOJu0YzKI7bSQhelQhwG3xFSyLBmyjfa/pUodSoBsn1dxnQXMWWktT7P
	j0eU/kURismkJXD7j4W9/TTLAhGWLD/XMZa1eae2JrLHcYWN1eWjkrzaapbo2UMi/r9FEIRPoK7
	M0YtZ+gZOkG1MVIOM1CRnpBXpxKvlWPQj6ZfMZxaG7SMr+c8m8G9O7Lh5icMF71hdaTtByvSfwB
	PrrmFdEA2PyIvs8s8zdL6wMpiBWFKP7sGnRTuCEw==
X-Received: by 2002:a67:eb02:0:b0:488:f11a:f3d6 with SMTP id ada2fe7eead31-48c04a4e3f1mr1090903137.2.1717544713474;
        Tue, 04 Jun 2024 16:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKAGGgpsqRrU79YUDBLRsPtRoMS0ZU0o21Yq+K4onrqf89q9w9lINsjz0eGmk5k681UJ+u3BEmqkJKutL6nsk=
X-Received: by 2002:a67:eb02:0:b0:488:f11a:f3d6 with SMTP id
 ada2fe7eead31-48c04a4e3f1mr1090880137.2.1717544712887; Tue, 04 Jun 2024
 16:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <5mimjjxul2sc2g7x6pttnit46pbw3astwj2giqfr4xayp63el2@fb5bgtiavwgv>
 <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm> <9db5fc0c-cce5-4d01-af60-f28f55c3aa99@kernel.dk>
In-Reply-To: <9db5fc0c-cce5-4d01-af60-f28f55c3aa99@kernel.dk>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 5 Jun 2024 07:45:01 +0800
Message-ID: <CAFj5m9L8PvzngHcn6pEhUeP2NbjSP6J8ufxxHYOtzrsPi5JgnA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
To: Jens Axboe <axboe@kernel.dk>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 12:21=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 5/30/24 10:02 AM, Bernd Schubert wrote:
> >
> >
> > On 5/30/24 17:36, Kent Overstreet wrote:
> >> On Wed, May 29, 2024 at 08:00:35PM +0200, Bernd Schubert wrote:
> >>> From: Bernd Schubert <bschubert@ddn.com>
> >>>
> >>> This adds support for uring communication between kernel and
> >>> userspace daemon using opcode the IORING_OP_URING_CMD. The basic
> >>> appraoch was taken from ublk.  The patches are in RFC state,
> >>> some major changes are still to be expected.
> >>>
> >>> Motivation for these patches is all to increase fuse performance.
> >>> In fuse-over-io-uring requests avoid core switching (application
> >>> on core X, processing of fuse server on random core Y) and use
> >>> shared memory between kernel and userspace to transfer data.
> >>> Similar approaches have been taken by ZUFS and FUSE2, though
> >>> not over io-uring, but through ioctl IOs
> >>
> >> What specifically is it about io-uring that's helpful here? Besides th=
e
> >> ringbuffer?
> >>
> >> So the original mess was that because we didn't have a generic
> >> ringbuffer, we had aio, tracing, and god knows what else all
> >> implementing their own special purpose ringbuffers (all with weird
> >> quirks of debatable or no usefulness).
> >>
> >> It seems to me that what fuse (and a lot of other things want) is just=
 a
> >> clean simple easy to use generic ringbuffer for sending what-have-you
> >> back and forth between the kernel and userspace - in this case RPCs fr=
om
> >> the kernel to userspace.
> >>
> >> But instead, the solution seems to be just toss everything into a new
> >> giant subsystem?
> >
> >
> > Hmm, initially I had thought about writing my own ring buffer, but then
> > io-uring got IORING_OP_URING_CMD, which seems to have exactly what we
> > need? From interface point of view, io-uring seems easy to use here,
> > has everything we need and kind of the same thing is used for ublk -
> > what speaks against io-uring? And what other suggestion do you have?
> >
> > I guess the same concern would also apply to ublk_drv.
> >
> > Well, decoupling from io-uring might help to get for zero-copy, as ther=
e
> > doesn't seem to be an agreement with Mings approaches (sorry I'm only
> > silently following for now).

We have concluded pipe & splice isn't good for zero copy, and io_uring
provides zc in async way, which is really nice for async application.

>
> If you have an interest in the zero copy, do chime in, it would
> certainly help get some closure on that feature. I don't think anyone
> disagrees it's a useful and needed feature, but there are different view
> points on how it's best solved.

Now generic sqe group feature is being added, and generic zero copy can be
built over it easily, can you or anyone take a look?

https://lore.kernel.org/linux-block/20240511001214.173711-1-ming.lei@redhat=
.com/


Thanks,
Ming


