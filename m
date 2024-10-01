Return-Path: <linux-fsdevel+bounces-30571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E698C758
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB561F255A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B61CCEFD;
	Tue,  1 Oct 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLgn3b9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42114B972;
	Tue,  1 Oct 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817040; cv=none; b=uvY0s/2Kyv8GAz5oT8IUhS0B77UIdAdZ1KIF1GshFAsg4Y42k2KOrNdezJkbozi+APt5UXJkM9mOutAO+1frQDRUB5Eq+GvxDoAdKFBaYfN6ockU4B3t4dpdsWWCh/eR6DqyPhhsoSqDNRdHBTiYROC/XJI8NZWI76rhnCqlCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817040; c=relaxed/simple;
	bh=BdLPaNlX/F3gzkLxlYzljybqQgCh1CZlleMAH3/NzJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyEv0zt22UyABkfHXCyzY5oIknqfdRsewP23oaPtCmDkDaxFjFpGilr12uUD9PsDUEhMSZkBjeFkux19QhiDj/zY+BidKsKJQcAWPlNNdp5IHsL7VSOp25087pQAJTd25/Nb+vwe4KMkkVCgW9bCqJ2SEYo8YpFDlzqUF++mwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLgn3b9K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2faccada15bso28636491fa.3;
        Tue, 01 Oct 2024 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817037; x=1728421837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5FPHhbte4Tmc4ZuPG7hVMprQvRDLf4/a9y4DExRTII=;
        b=CLgn3b9KoSx9JIAdndd0qu5wGcg/6R4xE0JJJWHm3hYT7fHVTwpv2UbZDk6QFhqQ5z
         qCFq+K/UsssncG5hieEIqSui913bI5MwRgRjdy7DxdYZg1vEaFQpTx3XUm02AvA8/NOL
         6nKmxML9RPR8VOMp7BPkoC49urkG5ruColaQQRo1G/OwitDFgCp15YYA4XQtyyWA0edh
         bwy+UWbgZUafvH4Htuc+8Dlu1y+2yYvKdKsCD+VD048C1ODs/YBBKrDQyis3A9O0aPN3
         94wMwQhdF5cz2Uey+enmfo0+0NqU+PDaI2bGTi5RXxd2oTsjPJVVe34Qn7AepqxFT8BD
         N4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817037; x=1728421837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5FPHhbte4Tmc4ZuPG7hVMprQvRDLf4/a9y4DExRTII=;
        b=SwSHGP0feJ1qzJccy4YePLClZ2/H14zA4upYAkPMpW9mz4RoozF7ZNq7t2iXS+wDAa
         B1QcSa7RoDwGMBgtQRc5N7ujE5r1ZRP11Ic1Zhzpf8mNDwXaHeQGypKtnqfZfPcKX+I0
         bhN3ZwbN7IRnTvJP9y74t7I0Mp3WEybAtYsKeRR3oh4KmsoiwacaIOYih0q3Q4S2XJot
         Rh9tUkshpVLd3ExzQI4BjDvEVZWmy7a/nDatruvuYcc5pHLgQc9JOTgIvwoQoxTtq6dP
         ir4Y2gNz9ehGx53Ofce+QBR/ULw0y1QYrlKI9tDFT9gg7+aA9tpvAa3UjtdghkEBOiXF
         ldOA==
X-Forwarded-Encrypted: i=1; AJvYcCV9YkoWBif9GTfBcV5t7ZAk/OSPRFBkn8YueSErk2UC1i1sv+GNfljRiWVJI+TtmbDdHX/BRRBW8oGe@vger.kernel.org, AJvYcCXHMEpBT7rBMI/uAO/9dwOlfjVh/Ypaf9+Xdb4CQFOjAMaS0Ubm8hCUz2kKWYI6Ff3kbzahC5Y0fa/l+TcM@vger.kernel.org, AJvYcCXM0afpXGUmhICT0DuK7bhe0GNEUuyNEmgDwfCFTmDvsANejPM0W5zkIBcAm7fre4D43PkvFlwZaZdYATMF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5BIjiGD2SnclvtEoruDbfViQVcH1IY5h//vMrYlewnW6b/vI
	X7uaRTePvrblI1g7Zmve3hOdFBx3AjsYg9fJ2mAdBBmvCLg+g/sUjOSP/Jcuc2PBrHfQSOGm9pf
	mCEm+nskbWfDpTuMNVrk8ymqMNmM=
X-Google-Smtp-Source: AGHT+IHyH38WiVX8HHUwc+OFQWovZwKbJEqW/O3u3XocYkPNvtQCAvFmTdZx0nP6F2Y0oSa7jC6KgiPT019755iLMPg=
X-Received: by 2002:a2e:be9e:0:b0:2f7:6e3a:7c1d with SMTP id
 38308e7fff4ca-2fae1044cf5mr8284241fa.15.1727817036745; Tue, 01 Oct 2024
 14:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a3b09db-23e8-4a06-85f8-a0d7bbc3228b@meta.com>
 <87plotvuo1.fsf@gentoo.org> <CAMgjq7A3uRcr5VzPYo-hvM91fT+01tB-D3HPvk6_wcx3pq+m+Q@mail.gmail.com>
 <87y13dtaih.fsf@gentoo.org> <0bdce668-5711-4315-ab05-1a3492cb8bf6@kernel.dk>
In-Reply-To: <0bdce668-5711-4315-ab05-1a3492cb8bf6@kernel.dk>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 2 Oct 2024 05:10:20 +0800
Message-ID: <CAMgjq7DMWGyXDdf86tkZ=1N6CnFQza4xzRhZXcw1j1WQXWBn=g@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Sam James <sam@gentoo.org>, Greg KH <gregkh@linuxfoundation.org>, stable@kernel.org, 
	clm@meta.com, Matthew Wilcox <willy@infradead.org>, ct@flyingcircus.io, david@fromorbit.com, 
	dqminh@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	regressions@leemhuis.info, regressions@lists.linux.dev, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:58=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 9/27/24 8:51 AM, Sam James wrote:
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> >> On Wed, Sep 25, 2024 at 1:16?AM Sam James <sam@gentoo.org> wrote:
> >>>
> >>> Kairui, could you send them to the stable ML to be queued if Willy is
> >>> fine with it?
> >>>
> >>
> >> Hi Sam,
> >
> > Hi Kairui,
> >
> >>
> >> Thanks for adding me to the discussion.
> >>
> >> Yes I'd like to, just not sure if people are still testing and
> >> checking the commits.
> >>
> >> And I haven't sent seperate fix just for stable fix before, so can
> >> anyone teach me, should I send only two patches for a minimal change,
> >> or send a whole series (with some minor clean up patch as dependency)
> >> for minimal conflicts? Or the stable team can just pick these up?
> >
> > Please see https://www.kernel.org/doc/html/v6.11/process/stable-kernel-=
rules.html.
> >
> > If Option 2 can't work (because of conflicts), please follow Option 3
> > (https://www.kernel.org/doc/html/v6.11/process/stable-kernel-rules.html=
#option-3).
> >
> > Just explain the background and link to this thread in a cover letter
> > and mention it's your first time. Greg didn't bite me when I fumbled my
> > way around it :)y
> >
> > (greg, please correct me if I'm talking rubbish)
>
> It needs two cherry picks, one of them won't pick cleanly. So I suggest
> whoever submits this to stable does:
>
> 1) Cherry pick the two commits, fixup the simple issue with one of them.
>    I forget what it was since it's been a week and a half since I did
>    it, but it's trivial to fixup.
>
>    Don't forget to add the "commit XXX upstream" to the commit message.
>
> 2) Test that it compiles and boots and send an email to
>    stable@vger.kernel.org with the patches attached and CC the folks in
>    this thread, to help spot if there are mistakes.
>
> and that should be it. Worst case, we'll need a few different patches
> since this affects anything back to 5.19, and each currently maintained
> stable kernel version will need it.
>

Hi Sam, Jens,

Thanks very much, currently maintained upstream kernels are
6.10, 6.6, 6.1, 5.15, 5.10, 5.4, 4.19.

I think only 6.6 and 6.1 need backport, I've sent a fix for these two,
it's three checkpicks from the one 6.10 series so the conflict is
minimal. The stable series can be applied without conflict for both.

