Return-Path: <linux-fsdevel+bounces-57911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D6B26A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5347B02DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6E20B215;
	Thu, 14 Aug 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bZk5HtTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDF1AAE28
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183946; cv=none; b=axnwkjq7kavQNLvWGJNxR3I0LqoNNgqBhaNFSOzQ48Ctvxxw/nZJmE8yWLIf4K1msv7ip93pjWloosi0Pm4tL33fgdxFo3lEyYNdj4aS6jGe69YqOeZ5iOZRi7S4J0S5NUGbxGZ/q4Z+fJWUM6IIkdfqVe86Q/4Jhh3rLC0HQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183946; c=relaxed/simple;
	bh=MYtHCpNH7rm/Grf+WS5Mwx7BfujxUdXEAVIXm4oRgeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKy7we1/enGeWcJqucrvM22t67EfHFKMn6iTfTQCcWtAg6x6lBVk/GVRHZqWauHX33MZNiggOEWv4ximveg+nnDVgVX/IF59/EibmqhdsCc0bI4XR9lbv64ImH2dNezHr5kpAIPsaok9YLzQDSsjD7+g3bqdeiYPcHqoK17iEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bZk5HtTP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0faa6601cso21451391cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755183943; x=1755788743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zaTlP5pzo/qg9qINxtiKx2DfK943m3JT2OR6iyYMuY=;
        b=bZk5HtTP3xdifzseYfqy3JsWZKqx2xgMaoYvXb9szp4i5kpLke+Yt8ifotwtltcyd0
         /PJzV27vjC6pOU/v5rHOF66UH8gE3fpwZSCUBkQFRQBKHfZMRlOvsGHFlOPd1TUYKovu
         1bzkN8JisNI8cral03BJDzCDUP65OiViBh/1cWd6Yk3X2thq6v68kq1Zp7kwdBjV8tqq
         QlhqqKTC0VAWAksy3QLMqid6llYtFGrnZVJbh7NXhb2Ra0BgBPehaDzOx3UcsBi5SaJk
         KLBr6VIShk0tjB9KXAW8M+80j+n9AgzHchRfxxmxL93fG3CKYgwX6hErgyyQf2LBSXLw
         QRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183943; x=1755788743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zaTlP5pzo/qg9qINxtiKx2DfK943m3JT2OR6iyYMuY=;
        b=NnSg2zXZP/AdASeMXlZ3UCeOgHIbkvarj7s1ol+hZu8a9pSYmqDQk+w51nKxS7UG4G
         C8R01faTXykNIDAze9ETgxC99Oh/Cu0iQ+U42Pp/mNuhLmf7uL3g+V5r2rIcQMtTJfjU
         Dv8JiMCiR9qAutImkLg0GxXsCA+rRcYjP0WDvdSqwUMfXfeY7wrVpwtqL2b6um0w1CHy
         jQ2i1NeM1XgHbR8zau31mavC5Uh93Q/buGpsDPuA8oAwO+1IS8BMMOXrQI8LzpzLSVG8
         o3Z+4VhDRtnV/HwbL4WMs9cpGauJNESw2634I1lQorgW5EoGNSz3wJ1NyvFQ36SItuQm
         GgpA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0G6v90fcSLNbsgFCxl5AAI9SC5r4F1ydFSLlObwumLCQrSR/tfuq7Nfcu78K5xzbK64OJRbX+VyufkGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FLjynx5VaEIChWoqL/tkKdDiRL5/yKIrUR/3eE1moOLDDoO8
	ZSdAxxyC4DlAPSiEAVeX+SGZZE2zAkvhfxIjqYohpxergx8k/YjkHIsouEMINqT9RikzCyy6Vy9
	zuewi9NGYBqCth0Z0a0ADNEbau3TNmQWJRpSObqCZbw==
X-Gm-Gg: ASbGncuFrEzW3wC6xsvzK8Qe40kTds86XY6YFYvXxNrO8+jZpuK4Dm89IZvaNmjeKl7
	SN6RW4sStJAXOGgKqIjHE7doL0O/UXklWkbWqj5D8WD95aWadn+zRHdfw6d75JaXmKXcuE8aic0
	AxvkZMKzMmW4Ul8mYVQmOp7AmM+EDqCdTfWVaL016PEm/FcX1BnzusnfH77bQ4GIGKw0OVlEPy4
	qUPxJ8fU/XA5jE=
X-Google-Smtp-Source: AGHT+IGd/DJ84Imu5KYRHkgnpNm4NZ636lX1WUQFrgSI87aMZKq+0zSxGBg+110FdN/squBIYOywjRpAp8ettpbigko=
X-Received: by 2002:a05:622a:5e09:b0:4b1:1109:6090 with SMTP id
 d75a77b69052e-4b1110964camr21827551cf.4.1755183943358; Thu, 14 Aug 2025
 08:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com> <20250814132233.GB802098@nvidia.com>
In-Reply-To: <20250814132233.GB802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Aug 2025 15:05:04 +0000
X-Gm-Features: Ac12FXy7hDZjxYMY4c9rpouOJZeOk5g8OwQ5wREtab5YlBDjZqQf27ADm8vAB8Y
Message-ID: <CA+CK2bCbjmRKtVVAok7GH8xvh8JWrga5Oj-iK-p=1M79AqvhRA@mail.gmail.com>
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:22=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:13AM +0000, Pasha Tatashin wrote:
> > +int kho_unpreserve_phys(phys_addr_t phys, size_t size)
> > +{
>
> Why are we adding phys apis? Didn't we talk about this before and
> agree not to expose these?

It is already there, this patch simply completes a lacking unpreserve part.

We can talk about removing it in the future, but the phys interface
provides a benefit of not having to preserve  power of two in length
objects.

>
> The places using it are goofy:
>
> +static int luo_fdt_setup(void)
> +{
> +       fdt_out =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +                                          get_order(LUO_FDT_SIZE));
>
> +       ret =3D kho_preserve_phys(__pa(fdt_out), LUO_FDT_SIZE);
>
> +       WARN_ON_ONCE(kho_unpreserve_phys(__pa(fdt_out), LUO_FDT_SIZE));
>
> It literally allocated a page and then for some reason switches to
> phys with an open coded __pa??
>
> This is ugly, if you want a helper to match __get_free_pages() then
> make one that works on void * directly. You can get the order of the
> void * directly from the struct page IIRC when using GFP_COMP.

I will make this changes.

>
> Which is perhaps another comment, if this __get_free_pages() is going
> to be a common pattern (and I guess it will be) then the API should be
> streamlined alot more:
>
>  void *kho_alloc_preserved_memory(gfp, size);
>  void kho_free_preserved_memory(void *);

Hm, not all GFP flags are compatible with KHO preserve, but we could
add this or similar API, but first let's make KHO completely
stateless: remove, finalize and abort parts from it.

>
> Which can wrapper the get_free_pages and the preserve logic and gives
> a nice path to possibly someday supporting non-PAGE_SIZE allocations.
>
> Jason

