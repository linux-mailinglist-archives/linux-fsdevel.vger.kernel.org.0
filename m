Return-Path: <linux-fsdevel+bounces-57086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E363B1E9C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82C27AA2CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C327E07B;
	Fri,  8 Aug 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fYzyli9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEE246BCD
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661648; cv=none; b=srd2eYBvlvtfVxkcKq7gwl8yHzbyZklZZBrTRqt8rcF+vhfn4ImBat76b6xXYVX6Yh2pfPbC6CrMs3wMzSTp3X3GCIJX8wwNgxLpJirPNPUEnA0nh+PkwpkO9EFTho3E95MfeIHQLlBfpFnKUyxfMc/lgUKosxbSYSnNuU/dpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661648; c=relaxed/simple;
	bh=x4ha9INZKS3qtde5fpadJaWJod/g+Zi1d0xN7YAlf3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4JiUnOV2H42Hf5pEfV/5ITmr7uesubG1izYABdXHCtTQ81789P9vdIhWhM+vF4btxhCzxx6Iub5TLivab5B8xePg8WmdEDzTWbUjA+CMYLxMYdm18ijzu7IhWu6LDcqP1tPxL2R0MCY2BVRV4n/7ku3POpcNJfp6bQxR7YVA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fYzyli9L; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b08a0b63c6so24855951cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661645; x=1755266445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqINGqOAKkihtWhqv8aP2ZlDWCyF3eZIl3dlPcJlrEs=;
        b=fYzyli9LeJhZI3OL2lOmQmUB/2hupW00LWygDlRVwGMxBR6yau6SZv2gOz0tzUT4ea
         snHxd+H9EFl1H+/X1Kuw/Ay6esXEphiIW0Wea0tYgDRhnyH80AU1JlRrdlnyQFGH5nHQ
         qBXOAOTE7nE66vqCtARk4xwfHgLypH8vftFTfMPNHT+4rD0HNyW2CCJB7skOr4/pZtNV
         r5h6moz4C1iZV/8WF/H2qJoMGWJHm10+N2EdNBQ2C5BLDovti2qlpQwWWf4LSWkFatbg
         CktxOs8XWJC4y8m4FEB8cFeqpPOvpFk4O7UwXT6V0ihyQxWLHFJ25SXcpb9rfinl3Gs7
         AMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661645; x=1755266445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqINGqOAKkihtWhqv8aP2ZlDWCyF3eZIl3dlPcJlrEs=;
        b=ES86qvr4UZEhB0hw9LmhcBMEFEAuhClXVqsDcR+xA6Q8gD9IwiulaSAoDde+gDFX/G
         Qfaw+bwY3v2KFl/D5KKws+m318O5q9T9uP+ZzyFIIbwjWdS+2NRQW/Lbq+9wtFc17KNk
         F1ECe5al2efVz4QERccIauXmfgAG8k19g489j1OR9G0s2i2L5777QmLo2u5R4XuW8a/O
         ALeg11q4RZ2LZNHZ+neskQ1s+kfWeULqEsSvXQepy5g8kLfnTBX54jG3fq3orn7QhxFv
         /vfEnZjfhA4HRASfL1H3YIkjsmcDwNIhqaHw+VB3fBEJq/g0tuDmPUT7ZdWIkNX4A6YJ
         vAuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNW9hHKpC9hf3Ud8l0UHwPvoEtKo35Pc7uADQlV/fbGeXfih2OZ/33bR8L0Y0TXeISjFY3A5ecHi43ROik@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8aiNuBL+kcg4HRMRHGBfGS64FItV09QJJ/9wwDf7+0ydjwXT
	+HxhTw3ok2c4j4jeiue/J1CEZTiM4fvL58/yBM8YZUTiyHTHaVWCDN0+8ah2OIn2aD2wjeC6RAk
	EhBOAcPzd0rrsZDvR3FNW1ND0tOj5TRVGPUG6sOv+Bg==
X-Gm-Gg: ASbGncuonDBk3RBJfX//hB/v0dzm1SFid3pQw8TKxree/G16sUqAwhgib315gYXca7G
	BcTEQTKKCZuzkAwN0Ck5f4iaNA545OWj9Uft6tZpVdfwoChwf+lkTOXQGZAnRSti5hZUvU/kTJI
	Vt6NzVAoP8mPzxRNsEs1675fZFSHXXP+UQAB4Vn93B2tL58whybFc9i+f4HopOJ6C46zMq/UaBl
	n87
X-Google-Smtp-Source: AGHT+IGU7X5qeX8OS2DQuYKdpYSGfIFno/a95GYTX1d6NB06BqBHy2416czan27fZPJSukzaA24gTw9e0PS+96Ajhto=
X-Received: by 2002:a05:622a:5a0f:b0:4af:4bac:e523 with SMTP id
 d75a77b69052e-4b0aed0f0e9mr39963141cf.8.1754661645094; Fri, 08 Aug 2025
 07:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org>
In-Reply-To: <mafs0bjoqav4j.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 14:00:08 +0000
X-Gm-Features: Ac12FXyA0-d-njVDnQIR5bUTLVyM1KEOMfZexHnLlS_vPOyE1wA5_qbuL5SMqTM
Message-ID: <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
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
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Fri, Aug 08 2025, Pratyush Yadav wrote:
> [...]
> >> @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_t=
rack *track, unsigned long pfn,
> >>                              unsigned int order)
> >>  {
> >>      struct kho_mem_phys_bits *bits;
> >> -    struct kho_mem_phys *physxa;
> >> +    struct kho_mem_phys *physxa, *new_physxa;
> >>      const unsigned long pfn_high =3D pfn >> order;
> >>
> >>      might_sleep();
> >>
> >> -    physxa =3D xa_load_or_alloc(&track->orders, order, sizeof(*physxa=
));
> >> -    if (IS_ERR(physxa))
> >> -            return PTR_ERR(physxa);
> >> +    physxa =3D xa_load(&track->orders, order);
> >> +    if (!physxa) {
> >> +            new_physxa =3D kzalloc(sizeof(*physxa), GFP_KERNEL);
> >> +            if (!new_physxa)
> >> +                    return -ENOMEM;
> >> +
> >> +            xa_init(&new_physxa->phys_bits);
> >> +            physxa =3D xa_cmpxchg(&track->orders, order, NULL, new_ph=
ysxa,
> >> +                                GFP_KERNEL);
> >> +            if (xa_is_err(physxa)) {
> >> +                    int err =3D xa_err(physxa);
> >> +
> >> +                    xa_destroy(&new_physxa->phys_bits);
> >> +                    kfree(new_physxa);
> >> +
> >> +                    return err;
> >> +            }
> >> +            if (physxa) {
> >> +                    xa_destroy(&new_physxa->phys_bits);
> >> +                    kfree(new_physxa);
> >> +            } else {
> >> +                    physxa =3D new_physxa;
> >> +            }
> >
> > I suppose this could be simplified a bit to:
> >
> >       err =3D xa_err(physxa);
> >         if (err || physxa) {
> >               xa_destroy(&new_physxa->phys_bits);
> >                 kfree(new_physxa);
> >
> >               if (err)
> >                       return err;
> >       } else {
> >               physxa =3D new_physxa;
> >       }
>
> My email client completely messed the whitespace up so this is a bit
> unreadable. Here is what I meant:
>
>         err =3D xa_err(physxa);
>         if (err || physxa) {
>                 xa_destroy(&new_physxa->phys_bits);
>                 kfree(new_physxa);
>
>                 if (err)
>                         return err;
>         } else {
>                 physxa =3D new_physxa;
>         }
>
> [...]

Thanks Pratyush, I will make this simplification change if Andrew does
not take this patch in before the next revision.

Pasha

