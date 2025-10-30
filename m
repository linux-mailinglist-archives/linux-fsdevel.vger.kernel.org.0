Return-Path: <linux-fsdevel+bounces-66538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D7C22BD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC204011E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928A2DC766;
	Thu, 30 Oct 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeofDQwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B02C234F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868252; cv=none; b=AHtqlOmnAU5if6yNIRC7QV3eFOpknRPDZMHNeiTJSu6cDzyrAhIU0UxG8eSy7jTQ2Q/E0+Rlv7A2TzShVY6IiriQh/PYZ//p02QgeM4HoxXxKKYOlPlle6vdaphSe6aqoaAk5WAScT1G6w8Br4Wl5U0n5xwD18Ivn1KSGF3jKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868252; c=relaxed/simple;
	bh=vVutEoJZmNj1T2Xj29z64MYSeF69ysf7pcVScY532Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcLebHvmRlBazA7CMYFrqPYVxB8CSyaY+VWsFKYcBibk+D0DBKr0MsHwluJNl+kSZKgTGeaUVmlMnJGV7W38biJ0ASzcfqkf04Lh4/IkMcN85h6yPGJWSdt3Ab/cR9oKcZLaM3LjPMNjhDbRx6oEFKIPJJm5cOKKT0Jr0hWNI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeofDQwG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e4d9fc4316so17879151cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761868248; x=1762473048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVutEoJZmNj1T2Xj29z64MYSeF69ysf7pcVScY532Dg=;
        b=eeofDQwGOZCLZ3pKisZGag7MsyCqW3yqS/NQO2PzB3Ffd3WuTkyrLHA4XFTycO/wuQ
         mM0m573UqyocjTr5F2c+/ccHva3kVlMBGV5PpQ9TmuyLEa9sj9gXKwPBELzSv1XeGlDh
         g46eraWsaZbtArkHiNOBWXJNYQmuZhtsszDq+I6Hvo3Vj8C/TgyHq7ihikR5NU/cA4EI
         HoRCtz/twJl9yKhiK2KSasTSiBwAe5Z/35MJ1PXYKRlXXtFshh4kicSzCY/u+YCrGwH4
         t5Y2CmTTnmAdkgg6V6FeLYtcRAH59cb6YpijI5tzouIqOTGcbNEDB95OYuxL8Hxdwv33
         ItaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761868248; x=1762473048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVutEoJZmNj1T2Xj29z64MYSeF69ysf7pcVScY532Dg=;
        b=omGCBU9/76px0HzfBzFzwG0SBl3W+JzgATSkNDOv+UpFbGO4yk3iyTAqLPh6N61tco
         gcotiFCbtlWFyjMf1sxUkGMrLvTnbVrZI4m7a0UJHOyph2wQQqkYkQbH7KUdJDM5sPpa
         r828Hi0onPfaNV92OA4DF3TBGIcGng8xIFtnM13XLnLn8xXJ7LkYpDuuHuaRi3gefQZq
         i1NekgCdlPF/Z9AZrmmJ31T2gHVb78Xe9nTeW7JlS57QrKiH4AIeGAN3pf+jH9EO64lf
         o4JCmwGEkZEihW807eMq5NEjeXLD5o50CQe+lo8ts7BD2PcNBrJRSzkg0YfZ8FofGg2p
         R8QA==
X-Forwarded-Encrypted: i=1; AJvYcCUFn+m7+w4gYwjPZQO5INrtgQ8Nn16By/VMVKhJ7HTRJOH6LlF8aLhHcpAQq6NNl7gXlvDcI4mr55b8Oruj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95z3Nje+kbQHflzs4gJDxBZRjbxuPrPg99A75klYUIp39ryOs
	bNAGJZS9kfLep+V8vTiG1mjXUBGtDKkS0mRAlmscIVX62DANuSTmtcp+syfDgpOTcGLEsO+Nld0
	x3mznyHuZwfH0z+AkEXQ0l7mgSL4+FPg=
X-Gm-Gg: ASbGnctQ7j8F5r1lQ71qnKCITrv2lJ8aJchHIQkLTMYzcKz6925jKGk2A0Uhe5xEIOr
	jql3XeHRBor1NmJRJ/t1SjQoF3db+tpVcWFbuTbXwc19c0YIZtIB4uz8USYWR1gNznKYoc2IegE
	UjjKEUyfWfxNjgm/Ex9wsoCmBsZC384o5lmoww1Qs4GYNbamGj7gX1IhFfz1SAQxvkr2iY/FxIe
	Z/PNpxPpGStryXPITS6WWtH1ORPAXNuwko0clcYqcbe2FJ2GhbTAbNriA9Xm4Sls54Lx+8ao6HM
	2zxjkXJUDrWPQZ4=
X-Google-Smtp-Source: AGHT+IHhxuai3R8JXCa4oArp1P6xppghmdyrkdjIcOLJO/GuWykVPCals4nCRj9LH5gdIb7py6mTIl0tkcSMTibzvu8=
X-Received: by 2002:a05:622a:544d:b0:4ec:76d8:e73f with SMTP id
 d75a77b69052e-4ed30d56d0emr18637591cf.10.1761868248462; Thu, 30 Oct 2025
 16:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
 <20251027222808.2332692-2-joannelkoong@gmail.com> <455fe1cb-bff1-4716-add7-cc4edecc98d2@gmail.com>
 <CAJnrk1ZaGkEdWwhR=4nQe4kQOp6KqQQHRoS7GbTRcwnKrR5A3g@mail.gmail.com>
 <9f0debb1-ce0e-4085-a3fe-0da7a8fd76a6@gmail.com> <96c4d33d-4f56-4937-bae7-9bda17f3264f@ddn.com>
In-Reply-To: <96c4d33d-4f56-4937-bae7-9bda17f3264f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Oct 2025 16:50:37 -0700
X-Gm-Features: AWmQ_bn8sxUTPkGvtX8x09nhmTRPb9iEdoxvSDFRsp686lTAxrG84Kp382dNekU
Message-ID: <CAJnrk1ah68G4NpDj8A41tX6J2M+NB6jNAUYdWEzTD3N_QrDJ_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] io_uring/uring_cmd: add io_uring_cmd_import_fixed_full()
To: Bernd Schubert <bschubert@ddn.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, miklos@szeredi.hu, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com, csander@purestorage.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:24=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 10/30/25 19:06, Pavel Begunkov wrote:
> > On 10/29/25 18:37, Joanne Koong wrote:
> >> On Wed, Oct 29, 2025 at 7:01=E2=80=AFAM Pavel Begunkov <asml.silence@g=
mail.com> wrote:
> >>>
> >>> On 10/27/25 22:28, Joanne Koong wrote:
> >>>> Add an API for fetching the registered buffer associated with a
> >>>> io_uring cmd. This is useful for callers who need access to the buff=
er
> >>>> but do not have prior knowledge of the buffer's user address or leng=
th.
> >>>
> >>> Joanne, is it needed because you don't want to pass {offset,size}
> >>> via fuse uapi? It's often more convenient to allocate and register
> >>> one large buffer and let requests to use subchunks. Shouldn't be
> >>> different for performance, but e.g. if you try to overlay it onto
> >>> huge pages it'll be severely overaccounted.
> >>>
> >>
> >> Hi Pavel,
> >>
> >> Yes, I was thinking this would be a simpler interface than the
> >> userspace caller having to pass in the uaddr and size on every
> >> request. Right now the way it is structured is that userspace
> >> allocates a buffer per request, then registers all those buffers. On
> >> the kernel side when it fetches the buffer, it'll always fetch the
> >> whole buffer (eg offset is 0 and size is the full size).
> >>
> >> Do you think it is better to allocate one large buffer and have the
> >> requests use subchunks?
> >
> > I think so, but that's general advice, I don't know the fuse
> > implementation details, and it's not a strong opinion. It'll be great
> > if you take a look at what other server implementations might want and
> > do, and if whether this approach is flexible enough, and how amendable
> > it is if you change it later on. E.g. how many registered buffers it
> > might need? io_uring caps it at some 1000s. How large buffers are?
> > Each separate buffer has memory footprint. And because of the same
> > footprint there might be cache misses as well if there are too many.
> > Can you always predict the max number of buffers to avoid resizing
> > the table? Do you ever want to use huge pages while being
> > restricted by mlock limits? And so on.
> >
> > In either case, I don't have a problem with this patch, just
> > found it a bit off.
>
> Maybe we could address that later on, so far I don't like the idea
> of a single buffer size for all ring entries. Maybe it would make
> sense to introduce buffer pools of different sizes and let ring
> entries use a needed buffer size dynamically.
>
> The part I'm still not too happy about is the need for fuse server
> changes - my alternative patch didn't need that at all.
>

With pinning through io-uring registered buffers, this lets us also
automatically use pinned pages for writing it out (eg if we're writing
it out to local disk, we can pass that sqe directly to
io_uring_prep_rw() and since it's marked as a registered buffer in io
uring, it'll skip that pinning/translation overhead).

Thanks,
Joanne

> Thanks,
> Bernd

