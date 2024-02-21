Return-Path: <linux-fsdevel+bounces-12263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553F85DA8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EE11C21567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758AD7F7C9;
	Wed, 21 Feb 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiBXL6Vx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2E7E78F;
	Wed, 21 Feb 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522170; cv=none; b=tyGtXln04cWn4qJh9+V6I03s1mtpp0RbiP/pyew4DDtk4mHxbw+e4qD+XToiEP36R/ax6Cksl2X6oKmU82LYt3/kyZ8XW79w+01p/fcelJ6ah/sQH2Jf6xC5RmiokuBy0ZBhNVzUK0eqXRsb0KHwKYithrjX4oSBxuDbPH4/iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522170; c=relaxed/simple;
	bh=1uXA3tuk5DSrYBKlcNHOd+IpgOiOvjcTfXfos632w+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkt8DjHEcCX6Q0tcMxgTAsfB4ucFIzJBkqFRxfcC8DhBVCGGeZrmymKG55kkIrymtbk/WKYgZf+Y+nvnUB/3MS3Gyc8ILHF9aTiMeUKqoHXq58MOhLoej4utNIt65L6up/wGODve7470JU80cvhSojfMqnqDUOVpXJSBaTN3yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiBXL6Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A34C43390;
	Wed, 21 Feb 2024 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522170;
	bh=1uXA3tuk5DSrYBKlcNHOd+IpgOiOvjcTfXfos632w+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiBXL6VxZWpc4KOcEK2JVTNsblnglRNXqfOhTGNFEOOP3Z05SEHo/yJJZgGTfy6Yy
	 x5i2ENXsswo0PsZfBbOQAsZyHoNv/onQNmWuZpA+8n/oxElvFdoqRi0mzLwWVmnusP
	 4o020bDIPLnaGgwRaawuQ6ExPSxEwS9tjNHSOU3RRAgwx0t3fpNdN4N9xYYf8nH+f/
	 AOtHcMNsU9xJMldnzfakVY3MacOvm0l/CKsIgCAZnZ61GsXNnBfAEtA1aDxQgVd0+n
	 jM6rpcQZPk7BVwHx5KaEP4lSa8C5hCRPVxHKvPn3uCLDMLLgfnPAlq21qZXhNA05QB
	 jflhzGp8tFFOg==
Date: Wed, 21 Feb 2024 13:29:19 +0000
From: Will Deacon <will@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	yu-cheng.yu@intel.com, rientjes@google.com
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
Message-ID: <20240221132919.GC7273@willie-the-truck>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com>
 <20240213131210.GA28926@willie-the-truck>
 <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
 <20240216175752.GB2374@willie-the-truck>
 <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 16, 2024 at 02:48:00PM -0500, Pasha Tatashin wrote:
> On Fri, Feb 16, 2024 at 12:58 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:44:53AM -0500, Pasha Tatashin wrote:
> > > > >  SecPageTables
> > > > > -              Memory consumed by secondary page tables, this currently
> > > > > -              currently includes KVM mmu allocations on x86 and arm64.
> > > > > +              Memory consumed by secondary page tables, this currently includes
> > > > > +              KVM mmu and IOMMU allocations on x86 and arm64.
> > >
> > > Hi Will,
> > >
> > > > While I can see the value in this for IOMMU mappings managed by VFIO,
> > > > doesn't this end up conflating that with the normal case of DMA domains?
> > > > For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> > > > wrong to subject that to accounting constraints.
> > >
> > > The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
> > > is passed to the iommu mapping functions. We do that from the vfio,
> > > iommufd, and vhost. Without this flag, the memory useage is reported
> > > in /proc/meminfo as part of  SecPageTables field, but not constrained
> > > in cgroup.
> >
> > Thanks, Pasha, that explanation makes sense. I still find it bizarre to
> > include IOMMU allocations from the DMA API in SecPageTables though, and
> > I worry that it will confuse people who are using that metric as a way
> > to get a feeling for how much memory is being used by KVM's secondary
> > page-tables. As an extreme example, having a non-zero SecPageTables count
> > without KVM even compiled in is pretty bizarre.
> 
> I agree; I also prefer a new field in /proc/meminfo named
> 'IOMMUPageTables'. This is what I proposed at LPC, but I was asked to
> reuse the existing 'SecPageTables' field instead. The rationale was
> that 'secondary' implies not only KVM page tables, but any other
> non-regular page tables.
> 
> I would appreciate the opinion of IOMMU maintainers on this: is it
> preferable to bundle the information with 'SecPageTables' or maintain
> a separate field?

I personally find it confusing to add all IOMMU page-table allocations
to SecPageTables, considering that userspace could be using that today
with a reasonable expectation that it's concerned only with virtual
machine overhead. However, if the opposite conclusion was reached at LPC,
then I really don't want to re-open the discussion and derail your
patchset.

Will

