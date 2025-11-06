Return-Path: <linux-fsdevel+bounces-67385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD4C3D8A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 23:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C734E2AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5B296BC8;
	Thu,  6 Nov 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKlAVkBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE228E5
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466526; cv=none; b=eDfbj/Wm7TJR6yv3p767yyAzomVAfMBwvYuCr0G83nGC3JVW3SKML66LUli+y8MbzRDSp2a3RNj7l/j/h+WgWjiuJRNEv1IXygRjfG//w6D0Sr5Ir8+ew7pwSPyX2C8ksRPGk38USNH0MjTgd/xSAACjNkX2wKjk/2DMja/3hMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466526; c=relaxed/simple;
	bh=mrsa0f5Qc7bK2Lms5hMsEQaTFhm8qXq++RH5qRXimgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jX9QtlNjb2emJvQ89SNpQihaOOZOLhCpS3ooW7fx4il0tRNl8B1vs+2lgJex8wJSTMnXh/tQylT/8yyTaMh6KYKJNCvNgohmiUr6/lQvYQNflCU/HgmeLQlDT3YZctBAJ3BbO08WG4Zxntn6ktdyYFiU1XAmbVaENtYqMjsT524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKlAVkBp; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so52598137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762466524; x=1763071324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6INUOA0K2Lpi4SpJZChX5AXaiVPcqyJDA2BrZOyVDK4=;
        b=KKlAVkBpDE70JsMzCNFDmom0szikiu37mv2zFQF+blGTwRFh7FUqcEPtEmSzQt6OIz
         ZX1OPlD4b1LgGAh8uPWD85uemrRmIFL4anmyYZG9P+ZwmeiRlJB5GdC46wZ6fhlLM2l2
         XRKVYFhEg9CimvcRWuAURqYZl0O20saTQjyFefLmSYX2hzLty3JUFDL2NtEw1CoTXRFw
         tD2UB2R1Rzd4fD3e46LrpJhiVUeqiYvOH5SoEcAoGVX2IL3l3vTUGooBioYeF58j3Wez
         HsfY2aoBV4qkiIHikTQL3LOMjKF4n30+xgSHkGOXJIogvyOa0mYFDQxVp4VlaIlISYuY
         s50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466524; x=1763071324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6INUOA0K2Lpi4SpJZChX5AXaiVPcqyJDA2BrZOyVDK4=;
        b=lvb43LqFhBKMV1Hhtib63ikLg9jQn8v3DVX6M2ksCxZTpS82QN4WGKEArKGgG8lQU2
         j7kY1jCQ7kuFc4+IjwHUsnuuocU1gJGYSufIPxIs5uEianL/Fa6/MlQMywDRQWAGQYFl
         Mlw6rwOb9PR3+kKz8DXewo81Z8LXoofiKhF7vugkOvh09nIbj2NMEdAsfOPlnUQB6N4w
         NUTdUm4CC5G1mYVLxRZzYmcGVYV+OESRe2zjV8Zg258kSwuTnfpP1DbIC5bjwjSlP377
         RhwcIoC1GCb5n0wiv3Hf/2JGLmnbxLxrQSTZvC5qmUwBJAuEcSQLe/ZI+CGn+qvfuS78
         6rfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsh1jqINg6frkCNVULZ/NkeSCaOnab2Kmhy6igpsx7J1IRbdooxbwmErmMea57csFwWQQmRiOihmDhf5hk@vger.kernel.org
X-Gm-Message-State: AOJu0YxY48cBewb5RqPuVozhKs8MLFoCPQ3VM2taus8218H9zMn13AwT
	OTiYpLOH1gDhE511v99zfSyJNK0POoLx54HwrnIZa9X46vG6hvkMPquGDvQIhVWe5gPQB+1acHk
	peIAzpyXJ5buZ84V1QmGiCXAkDEHW/MQ=
X-Gm-Gg: ASbGncvjJ623VuLjwvu6AoQ31J+9wZTpx3Kf5JOy4TrCE8bJF0TYIqGdh2xQn6M42tZ
	gZ6AfQ8tKvzVvprTbGHnnzd1bGkQ3rEzR0L9SoB2XD2llQSje22Qu3xiaWu9Ed8GsxjFYoWzNzM
	VuApjJe08WCEenWu9sXAkGZrdi847qAYkQD9R0eNLs87MdAt0ASiJXIzYSlB7bqp5ecSnVI/H96
	ARk2U6pL3fZr9/UH6KcyTQPMlLkLqkhSdSw8h/rkSBlIvH3cstJ728aU1aVH1e0R4wxRs8VyALa
	9NSoAThLAUm6Fso=
X-Google-Smtp-Source: AGHT+IH67bXGQ9AWgEOqCzuZoVhl46p0WlyB0LGf2+8GipzKWVLXlViWXbfoLz7RtP+8mcfTZY95Wk7QcNRei+5uj4I=
X-Received: by 2002:a05:6102:41a8:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5ddb20e6e72mr377504137.5.1762466523533; Thu, 06 Nov 2025
 14:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
 <20251027222808.2332692-8-joannelkoong@gmail.com> <0e77afcc-b9a7-46f6-8aad-9731dc840008@ddn.com>
In-Reply-To: <0e77afcc-b9a7-46f6-8aad-9731dc840008@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 14:01:52 -0800
X-Gm-Features: AWmQ_bmJ-gGSjlIn96rgezHC0epAiVYIqmVrBpowJdzaDmOhFFTnNXS2G7z0FVY
Message-ID: <CAJnrk1ZENK5Zp+r5eqm_ZAQySvTcn-6R1dUkmDHXMbw6F170BA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] fuse: refactor setting up copy state for payload copying
To: Bernd Schubert <bschubert@ddn.com>
Cc: "miklos@szeredi.hu" <miklos@szeredi.hu>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
	"xiaobing.li@samsung.com" <xiaobing.li@samsung.com>, 
	"csander@purestorage.com" <csander@purestorage.com>, "kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:53=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> On 10/27/25 23:28, Joanne Koong wrote:
> > Add a new helper function setup_fuse_copy_state() to contain the logic
> > for setting up the copy state for payload copying.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c | 39 +++++++++++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index c814b571494f..c6b22b14b354 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -630,6 +630,28 @@ static int copy_header_from_ring(struct fuse_ring_=
ent *ent,
> >       return 0;
> >  }
> >
> > +static int setup_fuse_copy_state(struct fuse_ring *ring, struct fuse_r=
eq *req,
> > +                              struct fuse_ring_ent* ent, int rw,
> > +                              struct iov_iter *iter,
> > +                              struct fuse_copy_state *cs)
>
> Maybe 'struct fuse_copy_state *cs' as first argument? Just a suggestion a=
nd would
> good if it wouldn't end up in the middle when there are more arguments ad=
ded at some
> point.
>
I like your suggestion a lot, I think that makes it clearer to read
too :) I'll reorder this to be the first arg. Thanks!

