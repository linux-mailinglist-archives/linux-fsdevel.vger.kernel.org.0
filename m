Return-Path: <linux-fsdevel+bounces-57712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FDB24B52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973B916A737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F02EBB95;
	Wed, 13 Aug 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCPLqBCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5C2EAB93;
	Wed, 13 Aug 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093235; cv=none; b=nVh0FZsHiiUbNZBNpQcToO4jRhdME7v8XuUb6EZVJrb3+3BR1euJpXDpbcINE4IZ/U/2eXfGXS8FnPsv3J+WKo7bdPCEbo7c6+t4zfqwpofjGcVZoN/z3eUgRUCCR/HwSEKpDdtMu0w2wz8L7bzN+tvtjpz8Tv2UKwEFGw/jiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093235; c=relaxed/simple;
	bh=cb6IHvKJI6s9a7NefYpZ8pOVcYdWMtHhY4ST4nI1r9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3g3nrp8TxEJKOI7ERmq/ewZZNnALPyPyktaad2FSm/Pfm8GdVgke7LXSWJzgwYUIS68pvZHXNpbyQYedtHcpcjKDkAQr0fEtMpvPU26nc8rkjLaMWBshxHDreqbre+EyB255+3XLW3GKRqRhPH1g3a4/FLCwOry5kuMSbdpIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCPLqBCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCA9C4CEEB;
	Wed, 13 Aug 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755093235;
	bh=cb6IHvKJI6s9a7NefYpZ8pOVcYdWMtHhY4ST4nI1r9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCPLqBCSonSc1PNeIvJP/EqqsgjspL0NafTpNdgQPnaWvE+58pv1tAJIxRQFCqssg
	 fsmFmez2PBUkvRpKyzO3qstcs7257EdUEUwtOG/D9v50oaSbwpUPsxgceky8bhOziJ
	 LAcRHaYPuhwABBEmpo24LwWWfyqXdq2hKPRbw6eA=
Date: Wed, 13 Aug 2025 15:53:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
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
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <2025081341-essence-unheard-63a1@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250813063407.GA3182745.vipinsh@google.com>
 <2025081310-custodian-ashamed-3104@gregkh>
 <mafs01ppfxwe8.fsf@kernel.org>
 <2025081351-tinsel-sprinkler-af77@gregkh>
 <20250813124140.GA699432@nvidia.com>
 <2025081334-rotten-visible-517a@gregkh>
 <mafs07bz7wdfk.fsf@kernel.org>
 <CA+CK2bDs9prKNSo=Ris-L7T43ZFU7ji3cBH3KD1=FxXg7hFbFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDs9prKNSo=Ris-L7T43ZFU7ji3cBH3KD1=FxXg7hFbFA@mail.gmail.com>

On Wed, Aug 13, 2025 at 01:41:51PM +0000, Pasha Tatashin wrote:
> On Wed, Aug 13, 2025 at 1:37 PM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > On Wed, Aug 13 2025, Greg KH wrote:
> >
> > > On Wed, Aug 13, 2025 at 09:41:40AM -0300, Jason Gunthorpe wrote:
> > [...]
> > >> Use the warn ons. Make sure they can't be triggered by userspace. Use
> > >> them to detect corruption/malfunction in the kernel.
> > >>
> > >> In this case if kho_unpreserve_folio() fails in this call chain it
> > >> means some error unwind is wrongly happening out of sequence, and we
> > >> are now forced to leak memory. Unwind is not something that userspace
> > >> should be controlling, so of course we want a WARN_ON here.
> > >
> > > "should be" is the key here.  And it's not obvious from this patch if
> > > that's true or not, which is why I mentioned it.
> > >
> > > I will keep bringing this up, given the HUGE number of CVEs I keep
> > > assigning each week for when userspace hits WARN_ON() calls until that
> > > flow starts to die out either because we don't keep adding new calls, OR
> > > we finally fix them all.  Both would be good...
> >
> > Out of curiosity, why is hitting a WARN_ON() considered a vulnerability?
> > I'd guess one reason is overwhelming system console which can cause a
> > denial of service, but what about WARN_ON_ONCE() or WARN_RATELIMIT()?
> 
> My understanding that it is vulnerability only if it can be triggered
> from userspace, otherwise it is a preferred method to give a notice
> that something is very wrong.
> 
> Given the large number of machines that have panic_on_warn, a reliable
> kernel crash that is triggered from userspace is a vulnerability(?).

Yes, and so is a unreliable one :)

