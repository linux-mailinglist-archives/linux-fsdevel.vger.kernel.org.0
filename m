Return-Path: <linux-fsdevel+bounces-68773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC291C65E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C6F8129DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A40C33374E;
	Mon, 17 Nov 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V4BdmbS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18B32ED58
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406056; cv=none; b=DyMO/keWw9mzYg1bm7P+bie7uD09EYUZn+zKnv0poEWZpwSRl3BBnYrilQsA7TeMbpxMBtwplAMloZ3RMmhZ+5bS2VrA/Y2UgO3MOCtYt4yHrppvGaIfPGOvf+396WK9abp/p+SPC4PLeRe2ljPw+NtTET87eLhHGbcwZEOHaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406056; c=relaxed/simple;
	bh=W/pP15q1CttsZvUfyX6F2C+iK5S6h3qctb/NEBwupaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RofIhm8OCdAHf9s1pxn/grxrNOFIZdpOlctHbcseAb22EdW6xX1ahl34lAvaUkxgZOJjvdoh2YKwHBvpgfMjEJxuRiGE3aqpObLD8N0+W42IlW+uUVMP5awSZnh6smlQxeQhbStu5gcZNthxh6U+0qDIVmvGcb35tTm75rKMtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=V4BdmbS2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so7132612a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763406053; x=1764010853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HPFoc/+4ns3fO2ktzkE/+/lUeXaO04xK8Lezo7jSI84=;
        b=V4BdmbS2aYVd3zPMLXZ8nNGnKhBWGeLQk1Rmw45vzvGzqb8xoAOlOWeQLht45ONAkU
         oRlsa8N5dj8Dbap92l9JEemjKwZxJbBu9+MXeeWtPbkMhm1KxXwk7BXyfmjGl0Wm2kNg
         sBIFQ0J4SVi1SM0ASfD30Gqf0b6Nk+Vb6yJX5MZaZx5oay8nyuaorRTe94iA1YqaGqv7
         Br+pWhCp7cnFXqj5bs75RyT2Tl8iWRKESqjBkIb13AB25scneGG54OmEGl5G+y3L1q6E
         HZWahSHEdcC2pkD5fNyhhLXRT+k324xymdsFLV/+g6pZjADxD3ouZ6hXEY/svxUJLKVp
         AUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406053; x=1764010853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPFoc/+4ns3fO2ktzkE/+/lUeXaO04xK8Lezo7jSI84=;
        b=B57GEeZsn9tJQXS/jodyTddvX2dXHF5mxgpvHSNxzdb4iuitmSU6+oM6p8qHG22e5C
         mzE58UHQvr5WiUQZojrZxURns7vuS53YLm+hpfxgTd35izYD6S10s2g9bIdD1JnPOTgp
         3I2lnbx7wpUKH4fel6TnWN/EfIrXDLrGIkQ1VL/BxznTyaGbkcicRxrCpKCOhlKwUER0
         +R2P4lfGwwPb0Ds6RqS/RYCYvYX5UexSHkyiur+Uz+Vk4V2il/eZk/JcQr0p+R7GjAXW
         AnKI0qZlweCT89bVnlotsArkebZ4koGOi28uKz/iq4M/y1w/Fqfz/MtPcgyXTysMlR0+
         0kWg==
X-Forwarded-Encrypted: i=1; AJvYcCVfnfHg7KZpgev19Eot4Ub9NMADERKQWFswT2B3NyQe5doZBvTWUfGcA4tF+I4YbH5yt1YhgFJpAryNDGwC@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgxtZTFsnC/sE4k/ZXRZBitr1bsIDP9t6Z/EwxTb07MYRMFU6
	EcqJomeeWbskzQMjwKtPMgTyqj4RoVz4ckdylF89OjrPdYzzaEYBXn+3gBB6RzqBmcj+xW2RZ+T
	BpEfWLHJrmv1p7Fw0PG6uCf15jR8oi5nhiOXk0tsqQA==
X-Gm-Gg: ASbGnctp4J00jG0qVYqqeREtoruOeo78ngIhXUok7mH4seAqvgUkDziKi92Ozmul5w9
	pzpkL+STyh4Aut2K6etFqzKQLxORXHXojgkTpZe8Qk19GmKxaQldx7xO29dcHJ6WnddO6i1iX3I
	7N5irF2iJi83k9Qasodd9rQKDM8N4o0d0Q1biyEaWiSS2RCfS+SOaHwTE4eU+ADcUY/ZfwXS0Mn
	OHtQoPTr6mUaDejmKRsGwWri5bgLH9ZmUaPEEb6EmTzVGxKSELtxXPb8/Kay6HEoGfL
X-Google-Smtp-Source: AGHT+IFV4NJXr23fgmib+nZZop8ZpcGlfzValh3mFozDE5HCWs4UKMYvFXIv7w0dSviSfrbdSBGLz4YMmJN++K6QINE=
X-Received: by 2002:a05:6402:2812:b0:640:bb28:9a28 with SMTP id
 4fb4d7f45d1cf-64350e237b9mr14060340a12.15.1763406052900; Mon, 17 Nov 2025
 11:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-21-pasha.tatashin@soleen.com> <aRsDb-4bXFQ9Zmtu@kernel.org>
In-Reply-To: <aRsDb-4bXFQ9Zmtu@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 14:00:15 -0500
X-Gm-Features: AWmQ_bm3PVSUD_ScaaBFLOLZ3gtlTTKqmWWQ6wfPBc2TSiFgvBGhnxI_qyTqjOU
Message-ID: <CA+CK2bCfPeY558f499JHKN7aekDzsxQkZJ9Uz4e+saR0qtXyfg@mail.gmail.com>
Subject: Re: [PATCH v6 20/20] tests/liveupdate: Add in-kernel liveupdate test
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

> >  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> > index df337c9c4f21..9a531096bdb5 100644
> > --- a/kernel/liveupdate/luo_file.c
> > +++ b/kernel/liveupdate/luo_file.c
> > @@ -834,6 +834,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> >       INIT_LIST_HEAD(&fh->flb_list);
> >       list_add_tail(&fh->list, &luo_file_handler_list);
> >
> > +     liveupdate_test_register(fh);
> > +
>
> Why this cannot be called from the test?

Because test does not have access to all file_handlers that are being
registered with LUO.

Pasha

