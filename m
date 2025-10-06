Return-Path: <linux-fsdevel+bounces-63505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1786BBE9DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D251899ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104C2D480F;
	Mon,  6 Oct 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VKxnlQon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892F1E5201
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767518; cv=none; b=iOun5EWB72hWAt6ZECKp3U5mtR8G1y97OiulLYXtamoHPYCWaAt5I1TIG62QwyGm9ooff9b+UIQ8rBkTgTA1qFYkOptWJYqL30L5j8hJX0NSVnqtolfXdSkhSQ1rPF+dwQSMFiaDuzATWLIkPrNy9zuR67Fi0RShTvZCye2dqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767518; c=relaxed/simple;
	bh=Qz9D6w3G/yjpN7oFudrZ5DCv7qahcZFISREkkOiWrf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goBmlau6GQXRFkrl2Rx1ivvHihX+mwKWdaODbvGTV50A5nMaQHh7alcYvtABpW0/B8O2NeRDFCZDWA9E/ay7D+5A4NRPFFWCCcm3OHw8y6qyAC1GwbcOK5hZc+M1sqhZRDY4oe7z31JB8D1GOvlQeZytSvnIfoa07gqJz/xZ4zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VKxnlQon; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e6d9573c2aso10699471cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759767514; x=1760372314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrjZ2N3nijkKvhfmQO1vA7QLR5P8LLIRs7v5R7YmxE0=;
        b=VKxnlQonDU17q6xDTEbfLgRYJ+JTaCw5HtH8g+bESBjpYEk2C9DC3hHwnntK3WJk/S
         2cp2hYKdkul/t9YZsAH7knaUSNCfjIu9aahu6mtuB0LfLfc5jlD3QS2E/c/oJTRH9X5/
         W/tougYGwUK6/pLT0sX0zvBkKVYRJFJzrX0xKDHX9H/ch2fPrDSwTvs3HHnuvK1Y7yQM
         M4RGvtAWl3DwYiPBesEhuN97tpbhLOUqYxVdlbiBeljlK1en4sSOZ9Iq+qtcDEY1p74U
         kQbnNPVWRxMSAhooqBAru8reNiFSoQlPZghLznA59oQkzSIQ2W5DDBo+TtDBhQWkuZD3
         b28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767514; x=1760372314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrjZ2N3nijkKvhfmQO1vA7QLR5P8LLIRs7v5R7YmxE0=;
        b=j4mg2mL5JkKpF/DqpIJF/zpnptVhNZPR3fafGcf1JBY5VGCZjZMGDunyfVJ+oHsOlv
         E7O9cQYwyoasyjF9ALS58Somcd5KWaszoYzyVVM5c1fGCR/49lyu/QSHhS7u0nM0752k
         YV5EK/A7GA8WksDSkC5NTa4va5RB7g+MU+TPDNLIyArhpC6QUnrCHXuAfHJX1K+nAR/h
         qoDNQk7tq9IXo3vR/niknaiXbXtdcF6QYB8OlsN6bRt0n3WDJp6ee7Uq2riXBzAyypGJ
         cdS0oCFTpgqfbuXxQi81+TyHrNJKvynoXNyQs9BmKO/L+/n6+iOXd7qeDvGwyiS4kBke
         z5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWcKTLoE6kiqJfji+QLyaL+I4/sGSXBaaCvZITXoU2jsq121Ht4GUYs/cymw1lhTp5EeILKu+gt1LNnB0nr@vger.kernel.org
X-Gm-Message-State: AOJu0YynRcNzEadv1HQA5YKtX2PgRCXNQUdWFtJazP2239ZVNdAhbGbX
	LSFATKPqNB1H5z60fAZ/J7lQ5tNwnTwhNEUHpnV8Z+j2qWNLBtlpYHvp5+sdr5VL0KPkop1WwRu
	2rRZm76BMmz/hMJCfGMNftJkkuXlhbynik0JUzdBx/w==
X-Gm-Gg: ASbGncs4hPRCTbTW6UAS8cnH0nyzwM3upifOH6PF/EwjMF7zdb9jtOWoz0XW3YIKTaP
	2Rb1aJ3x51YqGsQ07p37Ca54zOix/nF2mzeBJT1Ikq55rO0GoqMPfx0c5dJyeC0LK+9hhc7RHDd
	VH1WfkXqq+dQkd+FJvp9+14gPpbvE0z5efIfy80t9QhW0YKgm+f7aZw7wA1LyzVoUACv68OgjCP
	L1lBcxgFddHepaHo6tUNx707Y3zZiQwvKtrC8I=
X-Google-Smtp-Source: AGHT+IFwm4V/zCKBkbgm7pfKIp77PJD1NOmB2z+7xVCEcG6LKB3NFoKIKgya5mufGjYCV3AhGt61yn25CRIzX8BM9QU=
X-Received: by 2002:ac8:5fc5:0:b0:4b7:a7b6:eafc with SMTP id
 d75a77b69052e-4e576a5c404mr198174771cf.13.1759767511840; Mon, 06 Oct 2025
 09:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-4-pasha.tatashin@soleen.com> <mafs0bjmkp0gb.fsf@kernel.org>
In-Reply-To: <mafs0bjmkp0gb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 12:17:53 -0400
X-Gm-Features: AS18NWC8dVdnh9WrIeR8a0qx05q3jEVozl0VBzvOu40iLLzMHk8IAd4vKASusLs
Message-ID: <CA+CK2bBS-v_djpvw3v-xumPizzmOaiPsuPpoxnSUub-LocghjQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/30] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:30=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > The KHO framework uses a notifier chain as the mechanism for clients to
> > participate in the finalization process. While this works for a single,
> > central state machine, it is too restrictive for kernel-internal
> > components like pstore/reserve_mem or IMA. These components need a
> > simpler, direct way to register their state for preservation (e.g.,
> > during their initcall) without being part of a complex,
> > shutdown-time notifier sequence. The notifier model forces all
> > participants into a single finalization flow and makes direct
> > preservation from an arbitrary context difficult.
> > This patch refactors the client participation model by removing the
> > notifier chain and introducing a direct API for managing FDT subtrees.
> >
> > The core kho_finalize() and kho_abort() state machine remains, but
> > clients now register their data with KHO beforehand.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> This patch breaks build of test_kho.c (under CONFIG_TEST_KEXEC_HANDOVER):
>
>         lib/test_kho.c:49:14: error: =E2=80=98KEXEC_KHO_ABORT=E2=80=99 un=
declared (first use in this function)
>            49 |         case KEXEC_KHO_ABORT:
>               |              ^~~~~~~~~~~~~~~
>         [...]
>         lib/test_kho.c:51:14: error: =E2=80=98KEXEC_KHO_FINALIZE=E2=80=99=
 undeclared (first use in this function)
>            51 |         case KEXEC_KHO_FINALIZE:
>               |              ^~~~~~~~~~~~~~~~~~
>         [...]
>
> I think you need to update it as well to drop notifier usage.

Yes, thank you Pratyush. I missed this change in my patch.

Pasha

