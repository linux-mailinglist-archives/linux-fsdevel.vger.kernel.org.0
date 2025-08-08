Return-Path: <linux-fsdevel+bounces-57136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6BB1EF03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9805862826B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461B288514;
	Fri,  8 Aug 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="eCJDu3rB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74827B500
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682702; cv=none; b=kTNdW6FbZhCT9bgamllAowwUxniTpvf+NBjPPmgjosLH1h2J+EHVh+yMWwZavKJWZMXvG0OCiwb3JTBdRRKTRHAMcHBz9L6T9xa5O7/Vv65KbVhYNU1AwZpDWyilusZohGzo6C44M/GFWNuds/XqdU7rpoOua5Ij1VluVVnOcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682702; c=relaxed/simple;
	bh=BHL0fkXpKKjHtLjXIr2YakBJO2tAgTy6UPx3ySoZ6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqbZKXGbI7pdkisPzUsXGMUucIN3anNyUmS++3Q38yWK/AHOG8GrlThKobNXIqwLL8wD/JfZZT5XLhH54tDYN9tad9iudLgFwRDlJgLAf/GjqKUVbbtNuhyY5ssB8k6VwRa7N5CTtYgXdSGodWUGl7+eE7mP6HwoeOAU2QJOFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=eCJDu3rB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b0a2dd3a75so25367631cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754682699; x=1755287499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI3NF4nmF87wkVHXd95sZzslTewp5Rg+7HCCf5M8kbU=;
        b=eCJDu3rB9W6i7ZSxgnM3kWTQIfXiFfn5dNp3bdZ1Ws91iRaiO+Gm0BaH2KvTX/vR2n
         2lDowxIqVHUlKBiCwfboBUHzaWvRZ1yFADbz7hvbASCYag4cvkoX+x6FqvAGratVsRx9
         YERtobn1eHy3IXvG2xoGNlNllu2GImAu2tqKjU4oIV8AKgIhUamt8x/O0xBi2PjyRCd9
         iBlZoAdDd3Vl2EWSHjM+u2/WOzm4ZtVIqQQpgn0TRqUBV6wh46pwXyaAd/cJmCIZY1Au
         9qEL7qQy2l0ROyUer/lJQEEJRC9m3eoY9B/QE0QjtRJFeyW1dB2NMTAHP2kX1OZxnKom
         xntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682699; x=1755287499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZI3NF4nmF87wkVHXd95sZzslTewp5Rg+7HCCf5M8kbU=;
        b=HuZfOeQ1qMC4dcYCQKBnF27H2g3C4p6Aifg609XUu4g4VsCq2L5x5hlH/zLpqSPmgx
         Vj8Y2qujd44qAYG/YB9miiJ7dfURsODZs8ZYI/aIAV+JyisxsBDDviNkpOz6GiWH/U+1
         Jih0V40kL14wiBqgF66pBjQqf7Nz3E5CwDh8L8fQW91AABo0lHAzhKfwmP77PPH03JE+
         bl0Fxhw7VGyH2imhB4wA8LIYJI9M9FEzoZ/JTOwW0IhsIMDg2qPamMAk9LvskaWZSBbT
         AjgElyog7KgCwFFcU1SE0zF6JUOXhXGh36foc/kbWw1pGpEAmEwh2o00MmL8jpYEhjPW
         f1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqz6jv6HUX3tr6SoDoqvpQ5lvR64KSOnmui/VHOB5QYIWUntdtpdJxhPRVENDUfR0nk0oKQTQ94UqH8rfw@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjV3dvVigNi6n9EmvgbtD7UsyoBNzXmDR0RrbHWIGbxNp7tP9
	HrO+h2YS9+CxqsDqHkqzYEfz18l03Jv0QPzjv0Fr0CO+Hgxvu1Hpd5/kYbgC1j4TMEOO0ljvi0w
	qnGBYr9o4uIi+VV7vlcAtrBAj4zBdtE+y9kabG5Q1Pw==
X-Gm-Gg: ASbGncsu6JQvtwePhHWdX6yNHM3ZdXL1Rj+GiMk5iiN62TsUxuRNXSSqsLyvlrOIFta
	v1JJFkaF+1037dYym0Mq4eq3rh/bkGm96GpO25ubn2H99SMUOfm3T26yjr7mKDDv9ajt+ROFvd8
	ig2EGMoJAVgd9cZ/NhZUmeJc26pXDs6IBDM4MzaIj/oq+10ouKcSZuHqLTvehnmfngvRkpLYdMs
	pfq
X-Google-Smtp-Source: AGHT+IHCcrYg7/jG4VG+Cw86KyymKHrjmDEsAzQfWB1gMcCPUUW3z00Eo/TfCPxNGcOawpm+qrN8GOrYgzTiH++NeZ4=
X-Received: by 2002:ac8:58d1:0:b0:4b0:82ee:f732 with SMTP id
 d75a77b69052e-4b0aee3b087mr66564781cf.53.1754682699519; Fri, 08 Aug 2025
 12:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-2-pasha.tatashin@soleen.com> <mafs0o6sqavkx.fsf@kernel.org>
 <mafs0bjoqav4j.fsf@kernel.org> <CA+CK2bBoMNEfyFKgvKR0JvECpZrGKP1mEbC_fo8SqystEBAQUA@mail.gmail.com>
 <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org>
In-Reply-To: <20250808120616.40842e9a9fdc056c9eb74123@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 19:51:01 +0000
X-Gm-Features: Ac12FXzwr7BB3_YD7FWm0iRwopXjM6LILZ73ll6nomRu2PpALziQgUA6db3Oe8A
Message-ID: <CA+CK2bCVziiUZzdGaEabmPSB4Dq41QZe7gVxtgwy4pWmpo=D_w@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > Thanks Pratyush, I will make this simplification change if Andrew does
> > not take this patch in before the next revision.
> >
>
> Yes please on the simplification - the original has an irritating
> amount of kinda duplication of things from other places.  Perhaps a bit
> of a redo of these functions would clean things up.  But later.
>
> Can we please have this as a standalone hotfix patch with a cc:stable?
> As Pratyush helpfully suggested in
> https://lkml.kernel.org/r/mafs0sei2aw80.fsf@kernel.org.

I think we should take the first three patches as hotfixes.

Let me send them as a separate series in the next 15 minutes.

Pasha

