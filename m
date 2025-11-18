Return-Path: <linux-fsdevel+bounces-68958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0CC6A6A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EEF64EB83D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C8368273;
	Tue, 18 Nov 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eun+AmGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A3368260
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480837; cv=none; b=ATMW70EHn0ZiQekueEbvjXXgdk9GFz0njwxkgL6YbEez1zX4JUvQI5084Lc6Ivgo/cmjH/33/ER9IvrLCqTFKDwt+nfSpiCsqqo0G3yTOgAodssrOFXNwZIxnwcjkchSfgZXy7WLun1nzLu6QK5FmioT/oL7AZaNfbu77MvCEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480837; c=relaxed/simple;
	bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+PLorr+xASDrsnVPsOV1MipU72mlsMSzZR7rbJCsfDuHCTFAlnTMFh6KP+OImzFTguvwnQETrX+zOaNfuIu02ebXNfYYetVxEWpF6SYbSeDNPhc73YEfJV87HtHWFHSY+qR7482KXtFlvwY+ZM1eTh97bK3q33yBXU0rYRas60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eun+AmGv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so9551287a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763480834; x=1764085634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
        b=eun+AmGvOpw0aPHJ92dR3mvU7aBmEP1wL43TgLu/vJ1c91YXgrGUwQNhAbTxMGYrIU
         BQfDaJ6Qfgiku7q2IvVqY1SzzcDfxX/ctIJxQCh5bCpM3PSTS29VUH1g3FxBbY6XHY5L
         vp4IaLmVXMcY6l21VxJAElhStIM6L7BDdn3AeKOHODp7BqIsmsXalgNr5NK9A+gt0HKa
         33PdHuCoje+K7nEd+z6SVFQp6uAWdLPsD2Ev713tUZ0SxWVYRRjNufOFW/IlgvvYfWZe
         Dre3ljKZ4RlxizZRkxjDoeYPeO/IgVwLGHqcpFBnbOzNWO325A0GC/x9z701cr+O9RGT
         ULgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480834; x=1764085634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSit9q9L9b/5E+Zs8jJoiIuLjTbwdZ6FtiEGsvw8Sos=;
        b=luFgf3Kfyb+K4p74bwk3Bo2o8OXWRaAXGFgbBF7IoOr569dsVVoUNyUkLsUdJBAuR+
         vDHAkUsF3L963D3OyFxbRETvAjNHxo13UA/vp6iDreb4oPc5dSWfJLTD39LbGxQZtMY9
         KmDJcB7ZfeA1XJ3yG2/OAzbkyFz9iRp+8nMm6Lnz/3zfKvV2o0XRLC4KSeWKexhmJn/S
         UB/CCl7ocignDsOsTibfzfGley0DbFaE+8cWw2X6wplKqlXOhmiXaA+3FfRChzhVL9Jb
         j01q2aX3DU6gsib35aXKsWKSCoTY64galiycBiitq2pEYrmbcWHkWCKJAmCJLfalTsPH
         mjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUXm8ljbmEAPBYy/2+F9RAJQ6JK7Kg7GPk+zZVNk6dXhOk0TvD1tJPnkhYZPwFq0mCS6VzU787jG9RJPpjD@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXiKMFDqjDbm7THnSK7L4ehGhUO4HCTxIjQ4YxF6u82kHB/NF
	LMOY9Df1E+7HyGFYzCnzXDQae5/ljg6KHo+Pt32OD+wQnwgNZRPvpO70GRBFiMab4nx/ozg5cSP
	iBGvalBG4MYULGhdBURZyt8xeM66WvWFAubW+uoJSSQ==
X-Gm-Gg: ASbGncuCbaIFa3cjSUlk6Su3UVloTmLImZw68pmR9MQxIRfQPhRmtQ+jTK+tedGg8Gr
	bpp/KNsQ0HINqwTRH7n/EQs1GZlXmx3q0FRpd5DX0WARMJAXJQv/qNrjseXjn3dnYV5YIGqtzEJ
	SNn8dISBrTkTy9YvFUBB/vDj1LZywj+h2oQcVEakRRk0ZzFmCrhWljDgxSMpvIrLgGgCTDbAzDd
	wm2Y1AFunULQMfPerd3rKFaHna6hmAsS+gYq1XrSoH64S4l1ZEtn5HtGlwL7dM9oOJEfxuOks6T
	Zvo=
X-Google-Smtp-Source: AGHT+IFl4FaDFqzlx6bWBXZq0K6NpC2OdnYDHICZqNqSZXVeIXY6NixyhYod+1/BeWpybcUus0n1F+KTrSDNCoyB1KE=
X-Received: by 2002:a05:6402:5c8:b0:641:5bb9:fdfb with SMTP id
 4fb4d7f45d1cf-64350e9d8acmr13722597a12.33.1763480833517; Tue, 18 Nov 2025
 07:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRnG8wDSSAtkEI_z@kernel.org> <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com>
 <aRoi-Pb8jnjaZp0X@kernel.org> <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
 <aRuODFfqP-qsxa-j@kernel.org> <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org> <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org> <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
 <20251118153631.GB90703@nvidia.com>
In-Reply-To: <20251118153631.GB90703@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 10:46:35 -0500
X-Gm-Features: AWmQ_blpsIaa7po7XSkrfRCPIMZ4WBj-h08xugNazGwsDJ_E9pCQg-N3cDPVz28
Message-ID: <CA+CK2bC6sZe1qYd4=KjqDY-eUb95RBPK-Us+-PZbvkrVsvS5Cw@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > This won't leak data, as /dev/liveupdate is completely disabled, so
> > nothing preserved in memory will be recoverable.
>
> This seems reasonable, but it is still dangerous.
>
> At the minimum the KHO startup either needs to succeed, panic, or fail
> to online most of the memory (ie run from the safe region only)

Allowing degrade booting using only scratch memory sounds like a very
good compromise. This allows the live-update boot to stay alive as a
sort of "crash kernel," particularly since kdump functionality is not
available here. However, it would require some work in KHO to enable
such a feature.

> The above approach works better for things like VFIO or memfd where
> you can boot significantly safely. Not sure about iommu though, if
> iommu doesn't deserialize properly then it probably corrupts all
> memory too.

Yes, DMA may corrupt memory if KHO is broken, *but* we are discussing
broken LUO recovering, the KHO preserved memory should still stay as
preserved but unretriable, so DMA activity should only happen to those
regions...

Pasha

>
> Jason

