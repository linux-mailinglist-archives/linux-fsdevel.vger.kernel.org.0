Return-Path: <linux-fsdevel+bounces-68339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935AFC591EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B141426372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DA35A951;
	Thu, 13 Nov 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dr1KI76g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA08328B57
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052966; cv=none; b=XbYRk9E+qwBAB5RmKr/IguvL+jIzotUQo68VtMQyNa3YWYfEuOW4OSh7FBfsZWb+V1+IZZ04+4U0L5nGGCaHexd1SPQE1p2YMA7IN4UoAahsnYWAvLh0q/V2XKjJapQih6rafEUHYUzN+DjnOdF4Z1yqklw16bn9x2Nozzz8g6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052966; c=relaxed/simple;
	bh=uGvdD/ipW2kG9og5miefSvlr2P5i5Da/ls3E4y5uIkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZbnNMkKudAULSNspUjmUit9MvfxoknpGRcCDdEjDCvPUKK4w7WisKZob95PTB4f5ObCFni+shZxcW+eyPdmWNMWWhOwKlmQfty+SpIHASGURQ8BKBc4ZqYOh9M7NBpohae7yzZkCrxHJtlHz5GFTqHIWRpsxiqiPlWO/W9bWmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dr1KI76g; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1819395a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763052962; x=1763657762; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMCY5fmkZI76R3Lm7+dKka7numEpthvdX92HaVpx2Bo=;
        b=dr1KI76g1gnpIh6V24siUjM+7mWoW13NR8UVu0XZREszhttQ3sg5JgHnrgqROqV4Qi
         ToM2yxDt8f9U8F3EljmVY32kUqRZebZupzv9EcrYhxGGKm4dZi6HTta9CXRqn8YwB5uX
         9q2xXIuWmYI6yAP30++i3Bsol/vxej349AgL1tAq+XgMzbOUY22a6MVt2yrAWy03By1p
         Ah8vMhLpWT63v8YxNdu5N1cRs0QkhmcpX43UO2Ef3jgBsBLC4+GE3A8TMqnfqVeYs/Fp
         pp92Afy93DXuKd0YiT3sYnzOZgV0ZLl+it3sNin5wn3HYikAI9lJseXjQTRpuVfNT41A
         Y+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052962; x=1763657762;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMCY5fmkZI76R3Lm7+dKka7numEpthvdX92HaVpx2Bo=;
        b=B+ltp78kWzqWgCn4OhsWiHcB5cwjtlL4RdF1LPayFBuV8jiEqzBEMuN9g9jrv9GNTk
         LOu/6A3REaVuqYZz4M+p7tfxsDj2ErorVD3ZIKTFYzz8v/E9g+YcDl4E0iNNXVL6l7n4
         YrLxA5cgr1LQN8zrsAs8SnEqEJ/B7m8zKGc+or/lECN+Ngh0TdEc0t8UvKwj2BJ1L+K9
         h/MK7/uE1W2ZHi620s2adgs+aJ18qpDSZGUjZ9qJvUm5U4zzB+4HeX1yqHXxzXOZn0PD
         iYOWoNo85RNZXywRdeemOuC+PBgv3xo78WDZzhGcgmLkSSAw+i8i1e9LE+3/+XQD26vt
         yNSg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwBKXr61ZzeFLx737zVhH7AfLx3l0ReEcG/CAghxHVuj5/jrB50adYJE69amY4VeJpRXl1tUOXJPbIkti@vger.kernel.org
X-Gm-Message-State: AOJu0YzHlKmhLcIFwReDRqzCzI6X35kIX6qEGbH/uE3W95z2M871EkZX
	7dL99g6dNJEguide/pu3DlZ/4Hu/XFFszITny/eaNlKGYIys5uasRHjQ4jaJhMLPa+GsOA9sDgH
	krqZUVE75Vnf1EmQiyCjwHCzHlfD4amu7+buYm6pQcw==
X-Gm-Gg: ASbGncsdj85hdRBtJLrXmXrSAfWom70uxaz2aC575PLb8xAM1mzXqzvXHl/7CelHSGJ
	iVGqlIb5Tnw6TNqguGvG1qee+vCwebjngGi1YFhb+L2ot4qpQ+NktCH+wxvO2R2SIZNWj/hvZ9n
	hmljuFuQzfb2Q1B0ZccrwBCCTVyxR0w/utwH0UAt8Hhvg7UreRkxxtr098J1QprSWYuj453B6Ta
	Ak+3CEgS3p0BCyaW4GzMVZGb94JAaElUn+g/eLgVKxTuOVcS0X60yNB0lHXp9Ug2HMA
X-Google-Smtp-Source: AGHT+IF7MT7H/N1FGVv2fGcWDDSq4G0lsAr/9izNZqOxycuQNiS8y26Pa9vU+efWnOrN6wB/Co4CNJQLTQPPNB+6gYM=
X-Received: by 2002:a05:6402:20d5:20b0:640:6650:9173 with SMTP id
 4fb4d7f45d1cf-6431a5906c4mr5014541a12.33.1763052961708; Thu, 13 Nov 2025
 08:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com> <20251107210526.257742-19-pasha.tatashin@soleen.com>
In-Reply-To: <20251107210526.257742-19-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 11:55:25 -0500
X-Gm-Features: AWmQ_bncXGN-eqIRVfciSwqz1sfkpOsYp0SxgOx72ZS1NRyOW1CKwiM1xe3CWB4
Message-ID: <CA+CK2bBmSD_YftJ-9w1zidLz2=a4NynnLz_gLPsScF145bu5dQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/22] docs: add documentation for memfd preservation
 via LUO
To: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	pasha.tatashin@soleen.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
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

> +Limitations
> +===========
> +
> +The current implementation has the following limitations:
> +
> +Size
> +  Currently the size of the file is limited by the size of the FDT. The FDT can
> +  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
> +  pages. Each page in the file is tracked using 16 bytes. This limits the
> +  maximum size of the file to 1 GiB.

The above should be removed, as we are using KHO vmalloc that resolves
this limitation. Pratyush, I suggest for v6 let's move memfd
documnetation right into the code: memfd_luo.c and
liveupdate/abi/memfd.h, and source it from there.

Keeping documentation with the code helps reduce code/doc divergence.

Pasha

