Return-Path: <linux-fsdevel+bounces-69040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D18FEC6C849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE1B7345847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76862DC76A;
	Wed, 19 Nov 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X6sXQiw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471732D73B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521425; cv=none; b=Dt03DCfU//UUQoo3Mytyka35XF4DTG6yMMYu3lUG0l8sIQ6EjCZh0ry03bgc0jI880/GChch5beDTW/kewDVmYJ8bctKbU+1cHaDUq9Z/5cz7x8S9oeLwFZsjXD7qMWuvvDMorDvfgoYXqlCmI9vdcbGq7FRuQf7G+QZKJ3v7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521425; c=relaxed/simple;
	bh=iLVQ9fpSMwb+/1OgxzSqM9eSJCO8OgdCf7gGWf7HfaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYK4oPYrtuQBAFRXQ/fFbWgYxph7oM6/rR+TlUksDIk/8RD8nBsukrfa/YsX9sMOPLR4ItLkFjMYtVuBqnbKP0ZStsNetf0xg6NYs2JfYyOF5COXuxNUOPhAov4KDfsQUyqh34krP8NRnAe7rxK253nVFYIvjvIbfy/bppKaAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=X6sXQiw7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso601304e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 19:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763521421; x=1764126221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLVQ9fpSMwb+/1OgxzSqM9eSJCO8OgdCf7gGWf7HfaQ=;
        b=X6sXQiw7T/4xI6jTDRQdUDiFVxRN2lcSZdE5g0J/kphBQOfMv4LFWFd5zOAQ+h3z+g
         i2UzCSeZAfD4+70gkbdcy0b2D3122C7kHQTa3Qf2UJLOt3YUgyilen8ZiSrBJS9zJECH
         6ERPaNWT4fUwV18yz5mxGNFYSWIFtfhXDGKadj+UL6FJVnuBPkl51kNLxqX1NnSpJDPo
         0v1VWg46cJtUhjBiDCbQDww0odIEBU7jxZ9qreA/7vjv4/khH6Vv/oaYsX03+ZCJFGQa
         sNlJAX+bxFx8IRiLoECZPAqB2nsMhjhyLkhq9UQjTRB0VPFpJbJh7+0TsFl1VY0UhDeU
         oWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763521421; x=1764126221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLVQ9fpSMwb+/1OgxzSqM9eSJCO8OgdCf7gGWf7HfaQ=;
        b=h+GHlI8Dym5pOpDTdHp6pMAN3vp4Cr3cjYycAXZUNiJS7ZEUmjNh5DWcKv7aKczaqf
         x12gSCtjIjjDM6BJng6DtK/i1JgfUF8QIwmROWGlYcjDW/1PMmFGHZJRjjD0p3kYzYVz
         9ZN2l17HyhOdd0DnTPax42qaU2s66Fp1RRepCIFGxBtr0K+pkQVjuYH9KKzT283xLDl9
         Ayc/UAkipHl643JkxI+Ln/uw1K1/fUCAHuRRbu/KFv9h/2+Wa5R2XsPBP/zk+iopGL4F
         rgiGJtoRoRddX/GEdKp0rKVsdZH1HrLZWJLEL7iG/xNYiQQhc1w2r+m7zAY7LNGgmqTl
         Fjyw==
X-Forwarded-Encrypted: i=1; AJvYcCVs5UPYPA9ubUJRcbJ7TYpRsUhBJ6DImNQ9tP7R5ReFSISd3RZQXuo33qBCEKGl4lt3QsO00Oh+ZZO3d+mX@vger.kernel.org
X-Gm-Message-State: AOJu0YxTE6sX4klyVoGQLOTcUnP9y5cA/dzCVkcX6QNu5pRO5t8htaMJ
	PaUVeyUw7PUfPVwMxVVgWBNFYy1SeAHMt7qIdFM03gHnxxvdod3VNngf1YEbuD9LuYEhe1K0Dhx
	oXffFlHaWA57iaIXAtemTMHOtBv3XMvty9qNZslL9mQ==
X-Gm-Gg: ASbGnctGvnbPs12UEiSrJUlH2BqmkpNW57lDNLlaD+EL7mrS6hq4+rUpXp2+OLKCqs/
	OiW4l544J+4jpiL9G5JIVltIhDKtbAtAelZzQzBcIFvGXk2yw8OqDOG+RvG7qAay5Te7MWTrV5+
	MeeruzivRBw24MtH25X2Y0J/h7McX8TjFfbHGpus4XN2nsHoG5Bj0v8YLJ6OPATNnDMLpZBs9lZ
	cIuDjdt0/YtepZKqFUdTBqPFNfaJ30SWG40/DMsCuh1/L6rZUIKMfjq5MBxgyeELQ2h
X-Google-Smtp-Source: AGHT+IF6jFUgyWxnWzJx/waEh+e8ZZZcrBjexbTkHm8gmlq1XM1TXAgMYp45D6MyYvw+W6OQW+owK+2k/XNdPzJADA8=
X-Received: by 2002:a05:6512:239a:b0:594:3d20:f021 with SMTP id
 2adb3069b0e04-595841e10e3mr6573440e87.3.1763521421110; Tue, 18 Nov 2025
 19:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRuODFfqP-qsxa-j@kernel.org> <CA+CK2bAEdNE0Rs1i7GdHz8Q3DK9Npozm8sRL8Epa+o50NOMY7A@mail.gmail.com>
 <aRxWvsdv1dQz8oZ4@kernel.org> <20251118140300.GK10864@nvidia.com>
 <aRyLbB8yoQwUJ3dh@kernel.org> <CA+CK2bBFtG3LWmCtLs-5vfS8FYm_r24v=jJra9gOGPKKcs=55g@mail.gmail.com>
 <20251118153631.GB90703@nvidia.com> <CA+CK2bC6sZe1qYd4=KjqDY-eUb95RBPK-Us+-PZbvkrVsvS5Cw@mail.gmail.com>
 <20251118161526.GD90703@nvidia.com> <CA+CK2bCguutAdsXETdDSEPCPT_=OQupgyTfGKQuxi924mOfhTQ@mail.gmail.com>
 <20251118232517.GD120075@nvidia.com>
In-Reply-To: <20251118232517.GD120075@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 22:03:03 -0500
X-Gm-Features: AWmQ_bkhtJuHwb_aYM1P0vArDeVsoqrPaefrD9sFZo9CLgQiJu240K99k3Hl7qU
Message-ID: <CA+CK2bCtJD-FGtmCOfz8arUGqO6hFkxWcjG-wHz_S1Abt7rXEw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:25=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Nov 18, 2025 at 05:07:15PM -0500, Pasha Tatashin wrote:
>
> > In this case, we cannot even rely on having "safe" memory, i.e. this
> > scratch only boot to preserve dmesg/core etc, this is unfortunate. Is
> > there a way to avoid defaulting to identify mode when we are booting
> > into the "maintenance" mode?
>
> Maybe one could be created?
>
> It's tricky though because you also really want to block drivers from
> using the iommu if you don't know they are quieted and you can't do
> that without parsing the KHO data, which you can't do because it
> doesn't understand it..
>
> IDK, I think the "maintenance" mode is something that is probably best
> effort and shouldn't be relied on. It will work if the iommu data is
> restored or other lucky conditions hit, so it is not useless, but it
> is certainly not robust or guaranteed.

Right, even kdump has always been best-effort; many types of crashes
do not make it to the crash kernel.

> You are better to squirt a panic message out of the serial port and

For early boot LUO mismatches, or if FLB data is inaccessible for any
reason, devices might go rogue, so triggering a panic during boot is
appropriate.

However, session and file data structures are deserialized later, when
/dev/liveupdate is first opened by userspace. If deserialization fails
at that stage, I think we should simply fail the open(/dev/liveupdate)
call with an error such as -EIO.

Pasha

