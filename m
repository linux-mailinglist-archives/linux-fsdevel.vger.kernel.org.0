Return-Path: <linux-fsdevel+bounces-16822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651D8A3478
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1912817AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6B114AD17;
	Fri, 12 Apr 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="TjDnn+YL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81414C596
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941652; cv=none; b=GtnOiQF9PO7jg/pM2u6tnilvVL41kD/tDYfGoUQOFZUdEehI3log0c2tYly4HFfIqG96v2oGKyAtw/wyixdt9E33+5iTRAkcT96Do80fg2DY6p3d1ZVavIzbQp+5kuCpfydetHGvhEixomh0E8y3P5Yy+yqY1T57Hb+sdkU1Q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941652; c=relaxed/simple;
	bh=5JFuYVePpmhoWdZk8WbeOoqlnSWSkoUYiXSyfRvyGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUxhgvHePW7vlIxHsIDF9iht/RaCT3NeteDyMxOJOca2Fxeo5Nwp9VCKLZZ6u5Z99nfXXoEEu0EZSpYCMtDBVr2LH1g8FjCjHXS5rslvdMiMxcq8/y/vdUdAw1zJ9UnxziL/wPqjK07SOZ9lSQuf5NX9yXjR8JOl1mMHJKgQjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=TjDnn+YL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43446959b33so4133641cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712941648; x=1713546448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=TjDnn+YLc4Pkh/akCRL4/SqjYG7P8QtAKysCpTbW8BKrCh58n6xjndCzTQrFbHWqZe
         OVzj89ZGTc3+N2dTGLdSzwWPsZXQeznKMurGiBv4i/fgFNuMGFqSDVbmMObKeH7RRebc
         NrjYo16o6FCAlwz2HOgVJoJKnRZQm3OZ5CqtE2uHNqEG64NJEzIi3SL+c2iW77RoUIwO
         eKBkIUEv4B2BgQjStijlqQWZtcpbwpGDjMQeGwtQAO23uAcSsqnP6nYP0rPJbOuNkTvd
         EIUwBn4o6Pz5hN/8RGiAUOtkcgfE/hLtdet7qZ/Vy5309XMhHtt2bnWVQ54xb9bQvrAU
         PnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941648; x=1713546448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=J7NM4/jzWIt4Lh7wY8iBtdbRTPOftDbMFbQMiGaXZpuS1Gk2TWWiUpDq//ZwsZxb+k
         1gLBeZwHTcxd3l0KsIZCyMWeZxvVnCkUtTE5pPuHl7iX3ztsotNLxCt/KRVekHTD6FVH
         wd9bohTpSS8vF/BRv8IbxxhbyEjAPfxpzJLOKeERnk1/5OKIyLha2qNP2QptYm1cdMdB
         myzw04wJSQvW+Q0o3LDGKGnTj+UR84zsICnadCYgJvgI3s0VCtEWcPCyIYJtsG3YXe4m
         LukMo2qZVZxWALgqVs+G+M+52G28Ej5l8/Z9z2m2c8qZGHbqYzllhoj17z2K5MPhVlq2
         Axlw==
X-Forwarded-Encrypted: i=1; AJvYcCXw/kEqHqPwbtf0BjSMBfHlUZ2e8IqjvS2RtCruJTX6lxP9A7aUcYME2+Q+pKv0lMhRqUHa45tXRgaoP+xORiFI2FVXoihkkIiktSuT5w==
X-Gm-Message-State: AOJu0Yyy+cdCKJHHvnQobJ8FpZLrZdYh8PgvHGw+/M7k2+wLIXP6Q6WQ
	5SyXcMLGfrWPFbW8Rf/oMga1g5Um1Af3TnF8qxRBdokiesMSvnyT0SFvLE3E2bOmayAmee61Ehl
	t5WTuVwVm3pC7Na+LzcELTxkisyB/+aLI6DA+tw==
X-Google-Smtp-Source: AGHT+IEXzcV5Ah/di4pWjeRuzI8bp8L5qdlySBiHU1tn4/tN30fitecIDCoiEvXNx6whVxsKgO+qRvqVW4OxECf95F8=
X-Received: by 2002:a05:622a:606:b0:434:89af:bd3b with SMTP id
 z6-20020a05622a060600b0043489afbd3bmr3794375qta.40.1712941648259; Fri, 12 Apr
 2024 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com> <ZhkIhtTCWg6bgl1o@8bytes.org>
In-Reply-To: <ZhkIhtTCWg6bgl1o@8bytes.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 12 Apr 2024 13:06:52 -0400
Message-ID: <CA+CK2bCjXGTP7ie=rFtXrmRaWxn_6VmfZb5BXR13z9a3scfETg@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
To: Joerg Roedel <joro@8bytes.org>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> Some problems with this:
>
>   1. I get DKIM failures when downloading this patch-set with b4, can
>      you please send them via a mailserver with working DKIM?

I was in the process of migrating from google domains to a different
registrar, but I think now the issue is resolved. I will verify it.

>   2. They don't apply to v6.9-rc3. Please rebase to that version and
>      are-send.

I will.

Thanks,
Pasha

