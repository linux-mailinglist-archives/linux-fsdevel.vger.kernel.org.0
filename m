Return-Path: <linux-fsdevel+bounces-68061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B92C527EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE309188C410
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A73385AA;
	Wed, 12 Nov 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrJfWier"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA932D44F;
	Wed, 12 Nov 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954446; cv=none; b=jUz0nkMwJaO+OaWHAoRvJkKHl8YpK4gwehxG67OlYa2sM74lt+H5tGHqpo8eAmm5t6eWfWTiAIDBCzka7docfUZ4lWEviELqxWRvFiat/XHGSmtuG905/01wFX2zqHUU0dVp8v/6oiwYA753kPItr2YT4+ESkaSwC47X6ViWT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954446; c=relaxed/simple;
	bh=qbSj2P7cauAyPGofpRuk2eH237ghZw6hFXEaJ7Ed/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqiCi7rtc//VzqOofAOUEXXm6t4vQf3tx5Ufws+NjYOVNesoM+aQlmBPg7qX+Sny1fU7Pmnupyhhom5OGNjRBQnyBP/OTC4GbzBkeDrAd5dU5cmOfC/RSDgUSPTvIwwAvwg4cRJPzXC/rld39OJFChDNjwg3x1obhbazBcx1yGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrJfWier; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41D9C16AAE;
	Wed, 12 Nov 2025 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954445;
	bh=qbSj2P7cauAyPGofpRuk2eH237ghZw6hFXEaJ7Ed/gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrJfWierYi07WtFcEryrFiK6Au3xJI//n+EazQJsB4b0URzBvOjJ2BPBvBPoM7FvZ
	 XWPWQhLqrXXbk6Los7kqf3Hu8uafXdEsjQxORzsfBLgMdTU6sehs9FlWa9STelJO6B
	 OWz3HlWFH/uCzNh2VZL47Gng+Ch9YiD7yBzskEndLdC70aFjLKWUcBaq0XFoDHp60t
	 0wx+iCnlCp9J1RZS79PtlT4DNB84z8R8sl+GyTqFXcqT3qGXpr8ALU3f1PIB1jKeK2
	 8K/l0BTJHUIz6SWhepPCUMWA1Uk5bb1RAQCRj5RdZtH28whozTzBEJKm7YoNIweTse
	 RnTOFGNsvHEfQ==
Date: Wed, 12 Nov 2025 15:33:39 +0200
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
Message-ID: <aRSMsz4zy8QBbsIH@kernel.org>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com>
 <aRObz4bQzRHH5hJb@kernel.org>
 <CA+CK2bDnaLJS9GdO_7Anhwah2uQrYYk_RhQMSiRL-YB=8ZZZWQ@mail.gmail.com>
 <CA+CK2bD3hps+atqUZ2LKyuoOSRRUWpTPE+frd5g13js4EAFK8g@mail.gmail.com>
 <aRRflLTejNQXWa1Z@kernel.org>
 <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bB8731z-EKv2K8-x5SH8rjOTTuWkfkrc4Qj6skW+Kr7-g@mail.gmail.com>

On Wed, Nov 12, 2025 at 07:46:23AM -0500, Pasha Tatashin wrote:
> On Wed, Nov 12, 2025 at 5:21 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Nov 11, 2025 at 03:42:24PM -0500, Pasha Tatashin wrote:
> > > On Tue, Nov 11, 2025 at 3:39 PM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > >
> > > > > >       kho_memory_init();
> > > > > >
> > > > > > +     /* Live Update should follow right after KHO is initialized */
> > > > > > +     liveupdate_init();
> > > > > > +
> > > > >
> > > > > Why do you think it should be immediately after kho_memory_init()?
> > > > > Any reason this can't be called from start_kernel() or even later as an
> > > > > early_initcall() or core_initall()?
> > > >
> > > > Unfortunately, no, even here it is too late, and we might need to find
> > > > a way to move the kho_init/liveupdate_init earlier. We must be able to
> > > > preserve HugeTLB pages, and those are reserved earlier in boot.
> > >
> > > Just to clarify: liveupdate_init() is needed to start using:
> > > liveupdate_flb_incoming_* API, and FLB data is needed during HugeTLB
> > > reservation.
> >
> > Since flb is "file-lifecycle-bound", it implies *file*. Early memory
> > reservations in hugetlb are not bound to files, they end up in file objects
> > way later.
> 
> FLB global objects act similarly to subsystem-wide data, except their
> data has a clear creation and destruction time tied to preserved
> files. When the first file of a particular type is added to LUO, this
> global data is created; when the last file of that type is removed
> (unpreserved or finished), this global data is destroyed, this is why
> its life is bound to file lifecycle. Crucially, this global data is
> accessible at any time while LUO owns the associated files spanning
> the early boot update boundary.

But there are no files at mm_core_init(). I'm really confused here.
 
> > So I think for now we can move liveupdate_init() later in boot and we will
> > solve the problem of hugetlb reservations when we add support for hugetlb.
> 
> HugeTLB reserves memory early in boot. If we already have preserved
> HugeTLB pages via LUO/KHO, we must ensure they are counted against the
> boot-time reservation. For example, if hugetlb_cma_reserve() needs to
> reserve ten 1G pages, but LUO has already preserved seven, we only
> need to reserve three new pages and the rest are going to be restored
> with the files.
> 
> Since this count is contained in the FLB global object, that data
> needs to be available during the early reservation phase. (Pratyush is
> working on HugeTLB preservation and can explain further).

Not sure I really follow the design here, but in my understanding the gist
here is that hugetlb reservations need to be aware of the preserved state.
If that's the case, we definitely can move liveupdate_init() to an initcall
and revisit this when hugetlb support for luo comes along.
 
> Pasha
> 

-- 
Sincerely yours,
Mike.

