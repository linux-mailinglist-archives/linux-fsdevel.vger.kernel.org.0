Return-Path: <linux-fsdevel+bounces-48919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A83DAB5E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1801730E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BEA202C2D;
	Tue, 13 May 2025 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1j7FbaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC031E4110
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171755; cv=none; b=aCDfDrQKQkb9pK45plbx46vpsgYqHycVddDOu8mXJza/RMYASwxcjaLRbZMFz6QovI1f5vrumfxkan+OaUfFnMtc11D/t7hzoJxHQQSEhcQO6/DD6sxRgMLWYgLm7AgU770MA5GsOi8pgDyolLlYdYLYXj0yHsX8KNzLbzM0Vhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171755; c=relaxed/simple;
	bh=9RHky7BK93AADijckRx1FBj4vF5XDE0QdJax76cxvHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh2FDziCq3pbEzBne5rSDcoUMGRhF92e66qyFnKeptb9IZWsGUMgqNupmDMja/kzA3EGvf5Dm+pKQaG8VT9BZBFVJT/c8Vg7F4JB+MAXlT4g3ZxBFps1i/2cWOvVdQwbm77CmflTO5+BHMieNURzlfhfcCamjmjIT7WPyZvZV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1j7FbaF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47ae894e9b7so115537841cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747171752; x=1747776552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RHky7BK93AADijckRx1FBj4vF5XDE0QdJax76cxvHg=;
        b=Y1j7FbaFs2ekliTc0eJwViJMOQ5EV/qjh0nj2SXa5Th7yMRq/q8d6wT2dZEKg/eXpD
         1up0sRweASo8LmUHqUuVqa6wtoBSqYoXhREmICYS9g3w5MpcpZSO5o2NsvuceAZ9vpFU
         VzdvtLTkrgyimmWJjEEdHkWIU581BmUK/uGG/Atc5t4cntog+h+3VES4UwO/VJkLp81V
         9qZG/m2LZU2YUn5Hl80th4EYgBLp3UUejQY1LdedGkS5ipOkziMoK7jKjuOgwFgQRo83
         L9S0v4QD7rDQK+j606I+NJB55GxlbtKRVoRzT+7VuXnH8bZ2+VePmRcA6wdVxaGDF17/
         tOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747171752; x=1747776552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RHky7BK93AADijckRx1FBj4vF5XDE0QdJax76cxvHg=;
        b=l5s9nSjxEcx1MHC1WT4SHdAGB3gRH54/m+NsE4U8PMLl0YXJrWtMWJORSF/BDtgLe2
         dUunt78dgAIv0DTFaNW+6otTPCpnv1qaSKzTRJFz9dv+ttI3p26YuOzP+Fg81oJSU4t0
         hUWR1kpfv/anYTgaVkhORXVdkwRM2ZbnIvBVo8NMnTn7uWtt9G4+akRUSOuD5YZVF+3s
         JoW2padNVofhSzA84U9eeNoAvUHITNMJ+urqdmmVIYt/LlwJJauAooEt+fayeTeMbrlP
         JhsRbCOI8eLWV4C7FCk1Tzddob8KR71Xz1Ue7d3fNEXXsj6s0BP7ZuH3yhJZzC9jyCd7
         M7YQ==
X-Gm-Message-State: AOJu0YzV/Kdv0IJC6gP3XwYTCZNzsMIIyxO5djqJBL6DuiE9IFQiEBLc
	eLqNJA4HXPXs7nEqaERK6PEyhYLNUgPdF7ZyFwFEkyaIxB9UGuijOH29jucUjiDVKengN8sZ3H2
	OLeOYlKgELSaOtMcjO2e+rbeYazM=
X-Gm-Gg: ASbGnculHsWrqZnrvUxS0I/XVKFCUcomLPgjNREC7BpFGM2lvFZT47AFkA0LSr7AUYM
	TGjSD2TKvxSZjcAIPExUHpQPVYFFI81MZ6OIQ/Oy4MSMBprg21ThK389ZpctTmtiq50zqMtq4x8
	ZEF7I/FLSFup/53csANpQ+nF/u8XtHhhOkSfQN15OtKvLQOcKm
X-Google-Smtp-Source: AGHT+IEUBaGpycfc6eso1RaxGBd4veYA1/yRZq2l5h0WyTqfjpnYd4dHpsT17+W4sW6gwhDH4Syawynozt7q7aa0hqU=
X-Received: by 2002:a05:622a:59cc:b0:48b:5789:34ac with SMTP id
 d75a77b69052e-49495c527d2mr18769581cf.3.1747171752393; Tue, 13 May 2025
 14:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com> <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
In-Reply-To: <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 May 2025 14:29:01 -0700
X-Gm-Features: AX0GCFuRCzwNZgBESz98vYmOuM4YFLoaI2UkFbzDIFvB9bE1qQCKlUnspL1WpUg
Message-ID: <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:46=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 12 May 2025 at 21:03, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > On Wed, May 7, 2025 at 7:45=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >
> > > On Wed, 23 Apr 2025 at 01:56, Joanne Koong <joannelkoong@gmail.com> w=
rote:
> > >
> > > > For servers that do not need to access pages after answering the
> > > > request, splice gives a non-trivial improvement in performance.
> > > > Benchmarks show roughly a 40% speedup.
> > >
> > > Hmm, have you looked at where this speedup comes from?
> > >
> > > Is this a real zero-copy scenario where the server just forwards the
> > > pages to a driver which does DMA, so that the CPU never actually
> > > touches the page contents?
> >
> > I ran the benchmarks last month on the passthrough_ll server (from the
> > libfuse examples) with the actual copying out / buffer processing
> > removed (eg the .write_buf handler immediately returns
> > "fuse_reply_write(req, fuse_buf_size(in_buf));".
>
> Ah, ok.
>
> It would be good to see results in a more realistic scenario than that
> before deciding to do this.

The results vary depending on how IO-intensive the server-side
processing logic is (eg ones that are not as intensive would show a
bigger relative performance speedup than ones where a lot of time is
spent on server-side processing). I can include the results from
benchmarks on our internal fuse server, which forwards the data in the
write buffer to a remote server over the network. For that, we saw
roughly a 5% improvement in throughput for 5 GB writes with 16 MB
chunk sizes, and a 2.45% improvement in throughput for 12 parallel
writes of 16 GB files with 64 MB chunk sizes.


Thanks,
Joanne

>
> Thanks,
> Miklos

