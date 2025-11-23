Return-Path: <linux-fsdevel+bounces-69511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DCC7E0F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 13:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 661EF4E1EF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649712D47E0;
	Sun, 23 Nov 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="d1IvU7Y4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AD1CAA65
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900185; cv=none; b=oFDbEtoapWjCn79eohdwQgJ6bKJ6hgKPlBUMalxxjx5JwbUtELdMwRb/0RbD0IqC5De0yQXuYR529jQltk/EbbiCdSp52cHS6LUlXoLKxxGnNpOMMWtov7ucWrPLmiGwsL2OmCf+1Uz1sWZReadW6bO5bQrcffaT2KxZyVyhgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900185; c=relaxed/simple;
	bh=UM+vF6TEu8yhAkj30JLGbyIbI4WPh5cn7qRbJB4QgGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slEnken0LO3idxkrcHlsUssfRULHwZb9ABnrph5aB30kOZM0tbYZY1X9rNlyxHVyJ1dZ70paUU3uL+Jl6JXlWmbW2Mzw+R2f65tJWCyX379prtFhZnu2W1SEOhplnVA7Xzdp5y0uaW1Sh4MCuNziinL6tLVZWkR6Aff5004t/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=d1IvU7Y4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so5258587a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763900181; x=1764504981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmnwA2LRgXHvVpWEUlTYwlypqcI9gTX6hAKhklpoPjU=;
        b=d1IvU7Y431NYcsrDpSOKfvh0SSOeI4IP4COWYsS+etxiSP7UgrMWEtc9gC6P+fTte0
         qNMjeS0NFxqWSZtMonv3cPqRz2ZWpSOm1EZ4YmyPiOFrGg5hpWkE7fONUZ92hUAab44+
         OkRF9vuJzSs58Tl1YFaDf/oM8Xsav811LOiZx3UFd8LyTv5iNztZvnU37XW5Uq1XzNXj
         mpwjvn4s83+nnECY62kSsdIAf6APU+XMPfYu/jiep0+1syHVujuFsdaaCjY3iCqIrugN
         NlglTm6yXdEywLna6NBKYOU5DsH6fScACuEZ0vH306QGXnBUyEA4t6Rgf1FtMeq4bx+Y
         6vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900181; x=1764504981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmnwA2LRgXHvVpWEUlTYwlypqcI9gTX6hAKhklpoPjU=;
        b=fXUe4R3kzUXGAF0+R79B9jD4X5T21TLc+sT+14elu6FO7n1D0mTNoSDU/LeuzIP+Mo
         L+ecW0ZJggp8BqVbpoKsLQTtP7HW3zbjrrKJTvo8aEVyHRdz4FqRL7UugK0pXblgPWos
         WS1UtRcVgPFCDhzS9xwQrC2qhDjXEuBLdCaMN6TCvACsTfehPgIIN+6ObN/GGi7nkprb
         kbBX35WZrvz4AfsFu3Dh0+7hahqUn4RSXzwq/64Smp8M/g+nv+5vb1FRhqCdUSXs80ub
         patE88MqtAaFvApAwABAVz3LsF1MJdweBPL09u2mogKw6/uvCpJRAXdvGdIySlcXwtEj
         Evfg==
X-Forwarded-Encrypted: i=1; AJvYcCVDfsqtssJbLv24ErEPG0BsAKJNvf13iSMSsuJN2oy/ejAHF1y4h8hjrf9GZhh6BfHSXChsn0JKKJO0+CR/@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdBJ6b19yc+DGmkxR9DQwitXr7fRdf+PLkSfmdCQ9ct064n+Q
	ehjlU/ttABD6zalCBjTdRVG4y5/hq+MUNreYf1petxyqbiHNlbd9lb8GlOyD00rd83qmEtQ/YOG
	HpoPMUKC+JPMncNSFebNNuu4eYpds4cixPmQqeo2xhg==
X-Gm-Gg: ASbGnct2WxEgFpxBej3W55WggKkrO1sOZA/ohvrcgAXs3jcrjLg5s4oEQURP+mQcIZR
	epO/bGz/txfwtxmpPgrbAlOuMFqF354e+cUjBxNV0KU+6Ubvl7xgu8wrxpeKzlrXEo0zNl73+sA
	dES336Ly2s7R16Hi+qkRhnXrtm3WT6aa+9cchUAMET+gqiD21bsJcuD3UGTfqeO3BxVrXKqmv/k
	z9TsKibk9Jz/zyQ0PdTiF9Tk9KtjcXuvgZZeUF8GY9hErUps8m/ERrNSVm+Bn1lZQbhzk6Gf6KX
	FYU=
X-Google-Smtp-Source: AGHT+IEImagg3AdF5WYifMqKzRIwHznKxuAvKL3KeryKA1i40NWKG5ne+tX3JUrb7aTNo7+cwTyqLluVcxsGwvMzoxU=
X-Received: by 2002:a05:6402:1447:b0:643:ce6:a7e6 with SMTP id
 4fb4d7f45d1cf-64555d22c5bmr7096672a12.31.1763900181343; Sun, 23 Nov 2025
 04:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-2-pasha.tatashin@soleen.com> <aSLsCxLhrnyUlcy4@kernel.org>
In-Reply-To: <aSLsCxLhrnyUlcy4@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 07:15:44 -0500
X-Gm-Features: AWmQ_bn_xMt7b_XynypKNmLzsgZ0R3niD3BWBC1dy3KZJb4mBkKZVlkWV4PjVSU
Message-ID: <CA+CK2bCN7x=eMwfTXF-2+vR=Gn3=41z6Xxx6wM1m7i-rxzug9w@mail.gmail.com>
Subject: Re: [PATCH v7 01/22] liveupdate: luo_core: Live Update Orchestrator
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 6:12=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 22, 2025 at 05:23:28PM -0500, Pasha Tatashin wrote:
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec). The primary use case is updating hypervisors with minimal
> > disruption to running virtual machines. For userspace side of hyperviso=
r
> > update we have copyless migration. LUO is for updating the kernel.
> >
> > This initial patch lays the groundwork for the LUO subsystem.
> >
> > Further functionality, including the implementation of state transition
> > logic, integration with KHO, and hooks for subsystems and file
> > descriptors, will be added in subsequent patches.
> >
> > Create a character device at /dev/liveupdate.
> >
> > A new uAPI header, <uapi/linux/liveupdate.h>, will define the necessary
> > structures. The magic number for IOCTL is registered in
> > Documentation/userspace-api/ioctl/ioctl-number.rst.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you

>
> with a few nits below
>
> > ---
>
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index a973a54447de..90857dccb359 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -1,4 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (c) 2025, Google LLC.
> > +# Pasha Tatashin <pasha.tatashin@soleen.com>
> > +#
> > +# Live Update Orchestrator
> > +#
>
> If you are adding copyrights it should have Amazon and Microsoft as well.
> I believe those from kexec_handover.c would work.
>
> @Alex?

Sure, or I can remove all of them from Kconfig, whatever you prefer :-)

>
> >  menu "Live Update and Kexec HandOver"
> >       depends on !DEFERRED_STRUCT_PAGE_INIT
> > @@ -51,4 +57,25 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
> >         The default behavior can still be overridden at boot time by
> >         passing 'kho=3Doff'.
> >
> > +config LIVEUPDATE
> > +     bool "Live Update Orchestrator"
> > +     depends on KEXEC_HANDOVER
> > +     help
> > +       Enable the Live Update Orchestrator. Live Update is a mechanism=
,
> > +       typically based on kexec, that allows the kernel to be updated
> > +       while keeping selected devices operational across the transitio=
n.
> > +       These devices are intended to be reclaimed by the new kernel an=
d
> > +       re-attached to their original workload without requiring a devi=
ce
> > +       reset.
> > +
> > +       Ability to handover a device from current to the next kernel de=
pends
> > +       on specific support within device drivers and related kernel
> > +       subsystems.
>
> Sorry, somehow this slipped during v6 review.
> These days LUO is less about devices and more about file descriptors :)

Device preservation through file descriptors: memfd, iommufd, vfiofd
are all dependencies for preserving devices.

That Kconfig description is correct and essential because the core
complexity of the LUO is the preservation of device state and I/O
across a kernel transition, which is a harder problem than just
preserving memory or files, for that we could have used a file system
instead of inventing something new with logic of can_preserve() etc.

Device preservation requires exactly what is stated in the description
for this config:
"Ability to handover a device from current to the next kernel depends
on specific support within device drivers and related kernel
subsystems." The only subsystem that is getting upstreamed with this
series is MEMFD, it is a hard pre-requirement for iommufd
preservation; the other subsystems: VFIO, PCI, IOMMU are WIP.

> > +
> > +       This feature primarily targets virtual machine hosts to quickly=
 update
> > +       the kernel hypervisor with minimal disruption to the running vi=
rtual
> > +       machines.
> > +
> > +       If unsure, say N.
> > +
> >  endmenu
>
> --
> Sincerely yours,
> Mike.

