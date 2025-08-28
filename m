Return-Path: <linux-fsdevel+bounces-59529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901DB3ADEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A554467C85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010B2C08B2;
	Thu, 28 Aug 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3ssYPyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648A26F477
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422032; cv=none; b=tjzVB/oRgMLFXE+J3B8ZqFWPhjxZDCLHVaYfZzJUyDciigUkkc6Kjm5jBIiX0veR3TUrEmueqf/Bx+aNU+/i3WZRQPe7z8vgTKTcSbW1V4Z9V25Pk86iba3ycl8+ldRzJlckPWY+gIMHL2wS5dQgwaWIKvC0edGUn88bqyAoEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422032; c=relaxed/simple;
	bh=30fk9NHjTb+YHallX3yV7R6e7ygOcFwvrpZnNLQLRbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICOzKLrgnnnOFGM/umK50g4Z+GQCdGEHGyXQLJnrpR2OOAO6aKRl+oaZ5boSrwa1N9MJJKv0gNUhk4Zfc416DdGb6r8QgoRHcx9e96/JHnt2Y/T6HRSMbtIXR09il/xTywb34iVOWsxlQWjbImmPJf8QX+GhAwfK4WXFtu55xT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3ssYPyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB71C4CEF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756422031;
	bh=30fk9NHjTb+YHallX3yV7R6e7ygOcFwvrpZnNLQLRbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U3ssYPyIZf4bYjFozVRTageNbBGWYnc0BLQHgtQCltO6D/wkhm6Ma8Pow5iTRUxn1
	 Ooi3zc5WYwmOGr5knJMQgsVpkf9TqEm8MilGpoORDWF1EDpalWL/2t3chxjK+JGmx0
	 Hwt9jdTB75A2Kxcc2WQ3H6YwutEKx6pEhLq4iU/tHRD3XzlAfIjPcbCMy3TSCFzFaK
	 9uu/dluZEdUB27iqtAyb+n6OwAocbz1SbqbQiLL1TRxyTDXUGW+JyWaK5+4ooS5oCp
	 NN2KfHo55A/69tSBlFlcka6JRfMKJI46BYY6ILyQ3eMXfisYnEkNEggK2P4onyoLtR
	 d/B7R6bcnFhhw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b7ed944d2so16845e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:00:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuBvAjAt9VYGu+oEdyZ6zq2hy/dELTI8ASMDIe/v36JZ5tB2FRGL+IpBEM67Sx2fDchI9JR+ai1caI5gRa@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpDPEcDnf3BgBp/Gd7eYiq0yhBfUL4dw10BuNUAruLONwgBGH
	f0oAZmCrNXOm9wOuCh7N1HUhcJa8e+p1+LkUCPw0cLmBF1QybsyEdKHRgmcY6AgAJjvk1UEwI67
	+pGn8/KemlPzmg7q+rnGfJ1okKhJC6k00mOWarN5/
X-Google-Smtp-Source: AGHT+IF37cR06H6qWz1gtR2Q33GyRHew0V5B6RhMXUxYEwLPyE0Qes9gQWNNur2aLf3Td0YQjtjqefGyXYAmbB98VJw=
X-Received: by 2002:a05:600c:a408:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b66a2b6b4mr5476195e9.2.1756422029193; Thu, 28 Aug 2025
 16:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org> <20250828124320.GB7333@nvidia.com>
In-Reply-To: <20250828124320.GB7333@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 28 Aug 2025 16:00:18 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMcD4HA_CjK7iZ_47jgnu63pF-0WRrhdREvUmMVOgWBEg@mail.gmail.com>
X-Gm-Features: Ac12FXwgAj48kKV8-NSqN51LxVJutv6tGbA-WA_eygERRbP7T7KY6y3bnmWLRPM
Message-ID: <CAF8kJuMcD4HA_CjK7iZ_47jgnu63pF-0WRrhdREvUmMVOgWBEg@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Aug 27, 2025 at 05:03:55PM +0200, Pratyush Yadav wrote:
>
> > I think we need something a luo_xarray data structure that users like
> > memfd (and later hugetlb and guest_memfd and maybe others) can build to
> > make serialization easier. It will cover both contiguous arrays and
> > arrays with some holes in them.
>
> I'm not sure xarray is the right way to go, it is very complex data
> structure and building a kho variation of it seems like it is a huge
> amount of work.
>
> I'd stick with simple kvalloc type approaches until we really run into
> trouble.
>
> You can always map a sparse xarray into a kvalloc linear list by
> including the xarray index in each entry.

Each entry will be 16 byte, 8 for index and 8 for XAvalue, right?

> Especially for memfd where we don't actually expect any sparsity in
> real uses cases there is no reason to invest a huge effort to optimize
> for it..

Ack.

>
> > As I explained above, the versioning is already there. Beyond that, why
> > do you think a raw C struct is better than FDT? It is just another way
> > of expressing the same information. FDT is a bit more cumbersome to
> > write and read, but comes at the benefit of more introspect-ability.
>
> Doesn't have the size limitations, is easier to work list, runs
> faster.

Yes, especially when you have a large array.

Chris

