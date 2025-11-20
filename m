Return-Path: <linux-fsdevel+bounces-69262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84737C75FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FBAD34C99B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DE2D94BB;
	Thu, 20 Nov 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOs6yqUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268491DA62E;
	Thu, 20 Nov 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664654; cv=none; b=eeWhbIc7dwXamQPh2g/0eInlW0cHnPdyJG81OTMUdp5+AL+muK387QyKj5bFkCm0VGwcXR2kevUlA0svgOdELUktdRmYdE6lj7YDz/vlN4+qGNFT/INoB9m7EuQI04ZwaCh0b2fg8RC3gL0af2cF0tCipfdOJ9wFpj8fN1tSPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664654; c=relaxed/simple;
	bh=vPRGeK1JlWNpX03eDI4u9Y0zZmIO0F9Wudh52np23Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqG5qVgd26+yJ7vwQxHSbtgw7wFPf658MR5R0xicRqc3xSzDl6DKuczGMCM++SgFNpU9SUou71VFUuoxIgzHDq4JIcga/dx+DHd+b+jGyKnf1KFP8rFO9H1732NP5C00waWFGauFxAhMotFbHP+E+6EwBf7YPmz7t5XqDEIaNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOs6yqUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413DEC4CEF1;
	Thu, 20 Nov 2025 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763664653;
	bh=vPRGeK1JlWNpX03eDI4u9Y0zZmIO0F9Wudh52np23Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOs6yqUY+iuUwLBYPwtmKAg5456PAWbrEvmwHkMNqH4VqjEhi9O7xpwTIiIGpvGZy
	 3d2NyIVcnsWNqqbcJnDNliNJ8nEyf0GkStq3JbTUBQGa0xkdGhGt25FGuT5EClqWPA
	 Yu/6EBzI5wPk3TLaQQBW1wkSfWv+p/FYYU9VWUB00uqbLvt46Xj/Xc0/FZ92xAx3D7
	 EdtTPXDLurOV6TykBn92FQV3pbHRxACd8jc6z3H/R/N40zNZRBCrg/pczFXy3Apls7
	 UZ9ksDiH3DOcQS1C1tB8Z3QKJAYa2r6fR5MwPSCsy61j9hauRgzLW4JRNHa0DMHNtk
	 8Y1O/k79jZnhw==
Date: Thu, 20 Nov 2025 20:50:29 +0200
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
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
Subject: Re: [PATCH v6 08/20] liveupdate: luo_flb: Introduce
 File-Lifecycle-Bound global state
Message-ID: <aR9i9SXGDQ6bi1mi@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-9-pasha.tatashin@soleen.com>
 <aRrtRfJaaIHw5DZN@kernel.org>
 <CA+CK2bBxVNRkJ-8Qv1AzfHEwpxnc4fSxdzKCL_7ku0TMd6Rjow@mail.gmail.com>
 <aRxYQKrQeP8BzR_2@kernel.org>
 <CA+CK2bASYtBndN24HZhkndDpsrU1rwjCokE=9eLZUq2Jhj6bag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bASYtBndN24HZhkndDpsrU1rwjCokE=9eLZUq2Jhj6bag@mail.gmail.com>

On Tue, Nov 18, 2025 at 10:37:30AM -0500, Pasha Tatashin wrote:
> On Tue, Nov 18, 2025 at 6:28 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Nov 17, 2025 at 10:54:29PM -0500, Pasha Tatashin wrote:
> > > >
> > > > The concept makes sense to me, but it's hard to review the implementation
> > > > without an actual user.
> > >
> > > There are three users: we will have HugeTLB support that is going to
> > > be posted as RFC in a few weeks. Also, in two weeks we are going to
> > > have an updated VFIO and IOMMU series posted both using FLBs. In the
> > > mean time, this series provides an FLB in-kernel test that verifies
> > > that multiple FLBs can be attached to File-Handlers, and the basic
> > > interfaces are working.
> >
> > Which means that essentially there won't be a real kernel user for FLB for
> > a while.
> > We usually don't merge dead code because some future patchset depends on
> > it.
> 
> I understand the concern. I would prefer to merge FLB with the rest of
> the LUO series; I don't view it as completely dead code since I have
> added the in-kernel test that specifically exercises and validates
> this API.

The test exercises a simple happy flow, but it still does not validate that
this API is what we'll be using in the end.
It's quite probable that the first upstream user of FLB will use this exact
API, but chances are that it will require adjustments to "the real life".

It does look sane, but without an actual user (sorry, but the test does not
count) it's hard to anticipate the potential required changes and potential
corner cases.

Let's hold FLB until it can be actually consumed by HugeTLB or VFIO or
IOMMU.
 
> > I think it should stay in mm-nonmm-unstable if Andrew does not mind keeping
> > it there until the first user is going to land and then FLB will move
> > upstream along with that user.
> 
> My reasoning for pushing for inclusion now is that there are many
> developers who currently depend on the FLB functionality. Having it in
> a public tree, preferably upstream, or at least linux-next, would be
> highly beneficial for their development and testing.
> 
> However, to avoid blocking the entire series, I am going to move the
> FLB patch and the in-kernel test patch to be the last two patches in
> LUOv7.
> 
> This way, the rest of the LUO series can be merged without them if
> they are blocked, however, in this case it would be best if the two
> FLB patches stayed in mm tree to allow VFIO/IOMMU/PCI/HugeTLB
> preservation developers to use them, as they all depend on functional
> FLB.

That's pretty much what I'm suggesting just without "if they are blocked" :) 
 
> Pasha

-- 
Sincerely yours,
Mike.

