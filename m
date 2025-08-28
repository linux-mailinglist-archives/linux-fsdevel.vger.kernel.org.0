Return-Path: <linux-fsdevel+bounces-59466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369DB394D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30D7188F647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FB2D542F;
	Thu, 28 Aug 2025 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIzhXS8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413832C3242;
	Thu, 28 Aug 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365280; cv=none; b=tHt92vjBwmtH2i/eGgQxqo+qaR5/ry/L11pgowADBqE4JyJSUjQI/Wv2fOlydyvIYP9q5b/pJoDF0vIgA87NkZIPi56B8ihvRVa/+3iSfXFDI/fz5f/fsK8lJKIeVD7a2LS1Jziq5wK5V5Bju8dL/MK0HloE2EzeSCxHyvsSL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365280; c=relaxed/simple;
	bh=u7MU8S7IUKFLA+3rSi4qDipSi5TbBda36l1aewE2udM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWbiSWxAtKh9l84UDM91ighr3qFqgvdmqbGxKY41LMWhGKRyqSRMdHEAkQhv7M/WKXzfPdaWffG7mUDAkiarPo7LkbZKGyV6zLL7/f3z494pHb4ZHXTbSP75o/7dgjJp+DKM3r2f06Md9ksQc94ov3B9Wo+j0aoGbl69K7TFkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIzhXS8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CFEC4CEED;
	Thu, 28 Aug 2025 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756365279;
	bh=u7MU8S7IUKFLA+3rSi4qDipSi5TbBda36l1aewE2udM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIzhXS8PSnxYCSsCp5sOq9LQVBuQ368mCesgVvzDRbMdYsHsF986cg37wXBeCyBMt
	 +9JcuR+1Z6xLXbpb50R0WlQlVSU630yE+rXFA13Rz/ar7HDUsG+SQqVQ/qPuaU9PSc
	 st0CQpt/2vSNT+yhe5uzUC96g26FsCxSN3bQiUqxds342dEEdlsQZSDrKvMBsCjaJA
	 XbinE3bU++eTmz6yOUC9S2cjzgETY60Ju2PpaQh3yK3XNsKsgK7Dyky37zuld+l3EI
	 PlxGGISs04ykUysfnAZ+YNhYIGKhbXLwvpl/Khe/e/KH4qf9uCyuGDTImM3somOfat
	 y9luVBQTC6Mkg==
Date: Thu, 28 Aug 2025 10:14:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
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
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <aLABxkpPcbxyv6m_@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826162019.GD2130239@nvidia.com>

On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
> 
> > +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
> > +				       (void **)&preserved_folios);
> > +	if (err) {
> > +		pr_err("Failed to reserve folios property in FDT: %s\n",
> > +		       fdt_strerror(err));
> > +		err = -ENOMEM;
> > +		goto err_free_fdt;
> > +	}
> 
> Yuk.
> 
> This really wants some luo helper
> 
> 'luo alloc array'
> 'luo restore array'
> 'luo free array'
> 
> Which would get a linearized list of pages in the vmap to hold the
> array and then allocate some structure to record the page list and
> return back the u64 of the phys_addr of the top of the structure to
> store in whatever.
> 
> Getting fdt to allocate the array inside the fds is just not going to
> work for anything of size.

I agree that we need a side-car structure for preserving large (potentially
sparse) arrays, but I think it should be a part of KHO rather than LUO.

-- 
Sincerely yours,
Mike.

