Return-Path: <linux-fsdevel+bounces-57695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC7B24A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1261B60F86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C92E4252;
	Wed, 13 Aug 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHkAe35r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3921B808;
	Wed, 13 Aug 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090012; cv=none; b=HUIYcUVkhl1bobkE60w0alfRSJDcdlTrViK1pR53wjmrFO0r99+HCGBHmugf3nfSjcr2YxT7MeIg9A60MtTnKvF22jgXoGySsMgJQdeQFlTY7cPHnVr+zu3UVEcK4HMbcXQxVckerfDl3qD27dvt0Z3h5HBKoHJ+hLKPZUz3PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090012; c=relaxed/simple;
	bh=aDg93MqIzbCDJ7vJIE6yLKnul53KhyAjtWb8ml+qZ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXqpO44zhUklNqqCFHK09FPthKcIIIw1xIcvwkLiQIBLCbNIDp85pYjl5RYS2l3kb5VM04ARVZWCYCswFHeZ3jzAI6wx/3pPOKBrqSQlrckoTT71bj5m0bjDYQRQlIKvi+JEnQ6svnO7eGMroOjN7cSZ+isdQlZbV8cmw/HGUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHkAe35r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3948C4CEF6;
	Wed, 13 Aug 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755090011;
	bh=aDg93MqIzbCDJ7vJIE6yLKnul53KhyAjtWb8ml+qZ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHkAe35rDb59ZjrgQqqrFZCnTIqaXOuDdWp6zvt1tpP3B819KzeRSVCjHGSrTFpmC
	 4JAbz1C5K5F1x62spsgdcFf5RN4faSIJHukqDu8llADLTXLJSvYAlzzjHIqySRpplu
	 XIIYl4MaxFu+HwXSLY/4JcPE/MigMbNNLkHojeOA=
Date: Wed, 13 Aug 2025 15:00:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Vipin Sharma <vipinsh@google.com>,
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
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <2025081334-rotten-visible-517a@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250813063407.GA3182745.vipinsh@google.com>
 <2025081310-custodian-ashamed-3104@gregkh>
 <mafs01ppfxwe8.fsf@kernel.org>
 <2025081351-tinsel-sprinkler-af77@gregkh>
 <20250813124140.GA699432@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813124140.GA699432@nvidia.com>

On Wed, Aug 13, 2025 at 09:41:40AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 13, 2025 at 02:14:23PM +0200, Greg KH wrote:
> > On Wed, Aug 13, 2025 at 02:02:07PM +0200, Pratyush Yadav wrote:
> > > On Wed, Aug 13 2025, Greg KH wrote:
> > > 
> > > > On Tue, Aug 12, 2025 at 11:34:37PM -0700, Vipin Sharma wrote:
> > > >> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> > > >> > From: Pratyush Yadav <ptyadav@amazon.de>
> > > >> > +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
> > > >> > +					unsigned int nr_folios)
> > > >> > +{
> > > >> > +	unsigned int i;
> > > >> > +
> > > >> > +	for (i = 0; i < nr_folios; i++) {
> > > >> > +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> > > >> > +		struct folio *folio;
> > > >> > +
> > > >> > +		if (!pfolio->foliodesc)
> > > >> > +			continue;
> > > >> > +
> > > >> > +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> > > >> > +
> > > >> > +		kho_unpreserve_folio(folio);
> > > >> 
> > > >> This one is missing WARN_ON_ONCE() similar to the one in
> > > >> memfd_luo_preserve_folios().
> > > >
> > > > So you really want to cause a machine to reboot and get a CVE issued for
> > > > this, if it could be triggered?  That's bold :)
> > > >
> > > > Please don't.  If that can happen, handle the issue and move on, don't
> > > > crash boxes.
> > > 
> > > Why would a WARN() crash the machine? That is what BUG() does, not
> > > WARN().
> > 
> > See 'panic_on_warn' which is enabled in a few billion Linux systems
> > these days :(
> 
> This has been discussed so many times already:
> 
> https://lwn.net/Articles/969923/
> 
> When someone tried to formalize this "don't use WARN_ON" position 
> in the coding-style.rst it was NAK'd:
> 
> https://lwn.net/ml/linux-kernel/10af93f8-83f2-48ce-9bc3-80fe4c60082c@redhat.com/
> 
> Based on Linus's opposition to the idea:
> 
> https://lore.kernel.org/all/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com/
> 
> Use the warn ons. Make sure they can't be triggered by userspace. Use
> them to detect corruption/malfunction in the kernel.
> 
> In this case if kho_unpreserve_folio() fails in this call chain it
> means some error unwind is wrongly happening out of sequence, and we
> are now forced to leak memory. Unwind is not something that userspace
> should be controlling, so of course we want a WARN_ON here.

"should be" is the key here.  And it's not obvious from this patch if
that's true or not, which is why I mentioned it.

I will keep bringing this up, given the HUGE number of CVEs I keep
assigning each week for when userspace hits WARN_ON() calls until that
flow starts to die out either because we don't keep adding new calls, OR
we finally fix them all.  Both would be good...

thanks,

greg k-h

