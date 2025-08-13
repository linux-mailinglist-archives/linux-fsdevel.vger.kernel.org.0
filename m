Return-Path: <linux-fsdevel+bounces-57687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7933B2494E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39B98804F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A72FF16C;
	Wed, 13 Aug 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rujDt7ws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AC2D542A;
	Wed, 13 Aug 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087267; cv=none; b=oKpagVfGkvbN/nEFyn7MFDQiOQ2tLNbUGw17nIymGLRMCOmAUTuG9Hk1rgf5ba3ChVztaoRQBPAT3ZW63V9zyFfqce8NMoVRm3tm7h/Pl+S6tzhJgaj6c+lTR8LCOPY+UJiCa7vXI471aUXX3vOgb4N1DRG24cmqUM+Ze+Bo7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087267; c=relaxed/simple;
	bh=tLOV7MuxuGZuAFjpe/xUc874h2DrbSyeczMhXjDQFOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Zz3YQTOvBcgvmlyoV7fO7mWB+/fELDoT8B301O3eGHOXbywcaY7YqlQQSWFj+8zlpfrQhrxj0xnnU+4Tmf3Iezk6a5ahPosAcajHZ4drGkESfEepioCEHsFHax/cYyFyL3m8SgRQPsV9pb+bbL4JGO8DkfNTsNTsu1Ymqra3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rujDt7ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10ECC4CEEB;
	Wed, 13 Aug 2025 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755087266;
	bh=tLOV7MuxuGZuAFjpe/xUc874h2DrbSyeczMhXjDQFOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rujDt7wsKQqVTbCwQrtiVRdM2aH76LameWGzvTdZ5npEBlrG95aNQxa3fQpNRodhk
	 QJbxh/7YOXP2RZlRsBQ3Euf+xwHlnxbyvDua1jB4H6D5yGcYFwDUM1uYw6W6cryK3z
	 Pug/jEnZ7mb8BeSzL61ybm0Sudo+Z5LhYzcQFvOs=
Date: Wed, 13 Aug 2025 14:14:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
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
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <2025081351-tinsel-sprinkler-af77@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250813063407.GA3182745.vipinsh@google.com>
 <2025081310-custodian-ashamed-3104@gregkh>
 <mafs01ppfxwe8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs01ppfxwe8.fsf@kernel.org>

On Wed, Aug 13, 2025 at 02:02:07PM +0200, Pratyush Yadav wrote:
> On Wed, Aug 13 2025, Greg KH wrote:
> 
> > On Tue, Aug 12, 2025 at 11:34:37PM -0700, Vipin Sharma wrote:
> >> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> >> > From: Pratyush Yadav <ptyadav@amazon.de>
> >> > +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
> >> > +					unsigned int nr_folios)
> >> > +{
> >> > +	unsigned int i;
> >> > +
> >> > +	for (i = 0; i < nr_folios; i++) {
> >> > +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> >> > +		struct folio *folio;
> >> > +
> >> > +		if (!pfolio->foliodesc)
> >> > +			continue;
> >> > +
> >> > +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> >> > +
> >> > +		kho_unpreserve_folio(folio);
> >> 
> >> This one is missing WARN_ON_ONCE() similar to the one in
> >> memfd_luo_preserve_folios().
> >
> > So you really want to cause a machine to reboot and get a CVE issued for
> > this, if it could be triggered?  That's bold :)
> >
> > Please don't.  If that can happen, handle the issue and move on, don't
> > crash boxes.
> 
> Why would a WARN() crash the machine? That is what BUG() does, not
> WARN().

See 'panic_on_warn' which is enabled in a few billion Linux systems
these days :(

