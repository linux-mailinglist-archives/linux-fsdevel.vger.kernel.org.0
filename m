Return-Path: <linux-fsdevel+bounces-68738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C75C6498D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEA263482DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF793328F3;
	Mon, 17 Nov 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fI36bZ2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15F1F19A
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388609; cv=none; b=nhhZm3yrtWgQN36mR4exbZlhQn+xzuU7EmkxMZHbuQVX0slek96ZQCUSS3IPTXbjlUOoztuFHLMT7qTZKcofaiQiOxL0aLnp/7twnaBUGSopTf20RmdfRmlTmTcqP+NAYOmpKIG9fM04XpPmUmDYkDKHdy1OnGbbSo4IPmPaFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388609; c=relaxed/simple;
	bh=ji/Y9Qq7wFGzKoh1h+90Adh1o23a0XJeM2uSU9uvfvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/apgME5c8ndZyETTjr3ApeVWVVaDBxV9pKsZq9CBi3gKlW0luE2YD8pUmHASNr8XX9MTAgbcYdjnFcTclXeCuxqUjJFM0KIOPTbRraOIg1rosP47dpk3b0So/Apktt1eeF1xvZ/xnh7qo850e480P1C6LeOerT6+ANZs9aG310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fI36bZ2C; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso3220127a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763388605; x=1763993405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PGJ4MM2xZvUtFSBpssoTJJO3KUHMCo+rFkEgLZfONk=;
        b=fI36bZ2Cd/qh4g9R+lz5NPae3/nblICrVl7RFEg9qFGGSM6MyPhMPgG1rrR8qiNahz
         f+Q962bfAxR6K+qlQFlnfI5qxMl6akntKsp0p/rlq0T9tmCJB4lgyP+4DNDnOa9yqTy3
         C+FCUsvW9Lvjs7FniB5f2YQnfts5dGhLTK8k8MuxQZNMFhik1MJt+JJeRzogpcZ007XT
         KLZhSV1RB25chIA3MZV5FiAOHGqw3g2ZeUxO4AykVyTLv1BJnqzkO9z5LYvJ5yR17JSk
         YZePBcZK56I8FLibQe6SUYf7qgpHbs8yqL7qI9fNM9vRhoJG7G6N9aN0nXgVJxWx1560
         dMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388605; x=1763993405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PGJ4MM2xZvUtFSBpssoTJJO3KUHMCo+rFkEgLZfONk=;
        b=ZdtkS0lECHP6Kptn6zs14XrTQcvEmHgjqWsbnvTfnc6918nwFJ6+znKcyasYmVt4Xn
         +LV+C8GbC2zjKLuNbBux0fbzrFTqDG46/mZlY3Ik/gAqhs3KmfqxtaHSfzvxT2SpC+Kd
         cbTwj27ckRBl6/AziWqVl4Stv6Xr9nctoNdU9iiMUqukDdtWGkeB2pxftVvrxM6c6948
         b0Adyg9fZzFe+3TqizFSCKfw/NzWuWtkH9XfjOO7sE9wf746axC5eFWZYmGIRO/34Aqy
         w3T6Oqgzud6uIW6gPFIOc4QXk6QyYI1gAq1rag9GjCYNe2zfN11G4Eiqd5GaBTmRalkk
         ziXg==
X-Forwarded-Encrypted: i=1; AJvYcCV+htbsHIyovjqVQXw0cT9ttk56zlHbERbZJvsfh/OWF0Up7nFn8fheVn/TcqMi/LUQyAsoinZJaj5g/aFD@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5/isyuQ3tKuyzyNk4gsMdQzJ/rQu8NsPakyJMh9gtOHKRR+s
	mpqyiqWV91vC3XEOMuSzIapiShXBnJBiedPAog+sEMdZxPnMHQp0absew8No6hmUGIXP8afsuJj
	PRD6G7vcJMXRDZTukrlzC3ZnvnASeZbna3hN0/+/gHQ==
X-Gm-Gg: ASbGnctglxl51Up6ohczRWP5dGtPFiFDrG6/SA3dxyXCzp0cWnN3lNrRM5rpyvPAzEc
	tdhodXYwSZStBGnZOq5EonzWaNF0pJ/wnhvUzSiO+PbTVNpSBECvC5QqLtxljt3/umQroA1PGQS
	quy+maH52EYYmoe7LiJndxk2f7FKozZZhb2ufk4nOMowPZTKpori4KUMDYyG0AdmoKZRLNNrf+C
	3QcQXluIJfQvwzVxPqUQPt2LOqbiZfz+BxVNOZTQZIIukU86YLwbTSMcA==
X-Google-Smtp-Source: AGHT+IHyLzyeccVSv3nqReJu90qTJog06h04xHxwwv6NgUkMio7F7ZWagqKrKcNrhIU9HnI/zZ5Tv0lJMZm643IIHWQ=
X-Received: by 2002:a05:6402:13d3:b0:640:ef03:82de with SMTP id
 4fb4d7f45d1cf-6434f80ffe7mr13322416a12.4.1763388605308; Mon, 17 Nov 2025
 06:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-23-pasha.tatashin@soleen.com> <aRTs3ZouoL1CGHst@kernel.org>
 <CA+CK2bBVRHwBu6a77gkvsbmWkQFDcTvNo+5aOT586mie13zqqA@mail.gmail.com> <aRoZq2bYYm5MGihy@kernel.org>
In-Reply-To: <aRoZq2bYYm5MGihy@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 09:09:27 -0500
X-Gm-Features: AWmQ_bn46kZnBDhZ7XIZjxCaG1X1VXV9A3jh512R99RJsaOy_fU1KnHkeK4KJxI
Message-ID: <CA+CK2bCeYfUGHo49PWqC4sngxKWP3MjcSL9EU7bNNCfsJtDCXg@mail.gmail.com>
Subject: Re: [PATCH v5 22/22] tests/liveupdate: Add in-kernel liveupdate test
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 1:36=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Nov 12, 2025 at 03:40:53PM -0500, Pasha Tatashin wrote:
> > On Wed, Nov 12, 2025 at 3:24=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Fri, Nov 07, 2025 at 04:03:20PM -0500, Pasha Tatashin wrote:
> > > > Introduce an in-kernel test module to validate the core logic of th=
e
> > > > Live Update Orchestrator's File-Lifecycle-Bound feature. This
> > > > provides a low-level, controlled environment to test FLB registrati=
on
> > > > and callback invocation without requiring userspace interaction or
> > > > actual kexec reboots.
> > > >
> > > > The test is enabled by the CONFIG_LIVEUPDATE_TEST Kconfig option.
> > > >
> > > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  kernel/liveupdate/luo_file.c     |   2 +
> > > >  kernel/liveupdate/luo_internal.h |   8 ++
> > > >  lib/Kconfig.debug                |  23 ++++++
> > > >  lib/tests/Makefile               |   1 +
> > > >  lib/tests/liveupdate.c           | 130 +++++++++++++++++++++++++++=
++++
> > > >  5 files changed, 164 insertions(+)
> > > >  create mode 100644 lib/tests/liveupdate.c
> > > >
> > > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_f=
ile.c
> > > > index 713069b96278..4c0a75918f3d 100644
> > > > --- a/kernel/liveupdate/luo_file.c
> > > > +++ b/kernel/liveupdate/luo_file.c
> > > > @@ -829,6 +829,8 @@ int liveupdate_register_file_handler(struct liv=
eupdate_file_handler *fh)
> > > >       INIT_LIST_HEAD(&fh->flb_list);
> > > >       list_add_tail(&fh->list, &luo_file_handler_list);
> > > >
> > > > +     liveupdate_test_register(fh);
> > > > +
> > >
> > > Do it mean that every flb user will be added here?
> >
> > No, FLB users will use:
> >
> > liveupdate_register_flb() from various subsystems. This
> > liveupdate_test_register() is only to allow kernel test to register
> > test-FLBs to every single file-handler for in-kernel testing purpose
> > only.
>
> Why the in kernel test cannot liveupdate_register_flb()?

The kernel tests call liveupdate_register_flb() with every
file-handler that registers with LUO. It is unreasonable to expect
that all file handlers from various subsystems are going to be
exported and accessible to kernel test.

>
> > Pasha
>
> --
> Sincerely yours,
> Mike.

