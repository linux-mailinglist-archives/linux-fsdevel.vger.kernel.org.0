Return-Path: <linux-fsdevel+bounces-68037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AFFC51A21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013BE1888D60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855F30214E;
	Wed, 12 Nov 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYpDmnFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3A2594BD;
	Wed, 12 Nov 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942895; cv=none; b=jps52Ed6aZTjHx0XZ7OiJj7/tEU1EmOC6ejMY9rqhM2C3YGXnQ5JWpWjT6/sNliIGADJxop/aMCIvZJqwDxrVtN/LztS2MZoAAF9bzPacGfc7TbEfGLaA/6Bp9zmI1cof1Fs5cgAmwuT05xONh4P23rjDIfdRTfvJabBqJ+VvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942895; c=relaxed/simple;
	bh=zRFgC/LqmJXdXGt/uR0LzuT7bkCTv1lA/W99nU6OL50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2Zl+ObIXy/Fe6ygDCAX468z+/348xDL5nAKyUJ2CNLqMkYRA0v1J6sag2X2WCwWGk5rFbP9yLLZWxM7OyrUoRPqrY6PosCxlSB32fm9RYoQy8MIR7PWYupi1TOMUQjGDkmq4pMqhJWglmpmi5fXIP6jTldOUdCsyZ4NXN6WJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYpDmnFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3FDC4CEF5;
	Wed, 12 Nov 2025 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762942894;
	bh=zRFgC/LqmJXdXGt/uR0LzuT7bkCTv1lA/W99nU6OL50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYpDmnFDGaK39JayZljdcDCvnD5nmaI0NwULXoCt86nssEl/3uJZwSo0NOYyBe0SZ
	 h9tyvZEpL4z3hbdxUIVrWi9IBdYJapZ0foBkg5Zg/gX7O0jz1UdlNyp7pDN4cOC8LL
	 s89A81086/C++ItH13Aq4kxXmrKYWWKTMksaYAEOuQ8gEW9g3n/Rzvg9LB5+cs+fL8
	 5DBHHNMKo8VKyTTxpJSCLVuiiwGzgpMo+1aFqCvjWUTwfiHhMxaPU2g0PGxrEJxs80
	 Nb9EvMmhqR0SYpN37rVtdjokI51KBP4T5T+Se67mEXcqPdh9KUhWEv1Kt3ksgDPwuw
	 o4SMHTw1GA+5g==
Date: Wed, 12 Nov 2025 12:21:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
Message-ID: <aRRflLTejNQXWa1Z@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
 <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>

On Tue, Nov 11, 2025 at 03:42:24PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 11, 2025 at 3:39 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > > >       kho_memory_init();
> > > >
> > > > +     /* Live Update should follow right after KHO is initialized */
> > > > +     liveupdate_init();
> > > > +
> > >
> > > Why do you think it should be immediately after kho_memory_init()?
> > > Any reason this can't be called from start_kernel() or even later as an
> > > early_initcall() or core_initall()?
> >
> > Unfortunately, no, even here it is too late, and we might need to find
> > a way to move the kho_init/liveupdate_init earlier. We must be able to
> > preserve HugeTLB pages, and those are reserved earlier in boot.
> 
> Just to clarify: liveupdate_init() is needed to start using:
> liveupdate_flb_incoming_* API, and FLB data is needed during HugeTLB
> reservation.

Since flb is "file-lifecycle-bound", it implies *file*. Early memory
reservations in hugetlb are not bound to files, they end up in file objects
way later.

So I think for now we can move liveupdate_init() later in boot and we will
solve the problem of hugetlb reservations when we add support for hugetlb.
 
> Pasha

-- 
Sincerely yours,
Mike.

