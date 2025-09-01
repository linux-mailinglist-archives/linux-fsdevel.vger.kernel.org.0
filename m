Return-Path: <linux-fsdevel+bounces-59892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF603B3EC1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5344436D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265A306481;
	Mon,  1 Sep 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC0bYdjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710B32F771;
	Mon,  1 Sep 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743819; cv=none; b=tZ+tPnzazjRLmbnCjXpUACcJeVNdtNodi8t/PjJ+aKYkf2YJShafboO27tcGXl0JDd/MYwSv/71c8XyDfJmbTlyiqWIlJLaZ1Ljt8AfrfRPJE0nOyD19uYuUEXRVONi4pFVYjtYlnVVhZKBvfYKkbayfWdcyDZFR/a8JGsZ+yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743819; c=relaxed/simple;
	bh=xXNMYxeUtrPT4DN76aplpZeN8UnkslUNoZEbarD5RAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTQhsLV85Aa3YsV12+hiZqjekQWVCh85WrzR/iCt7QKJ0fyBtNnd+SmDurRl+snz/+nOgPkvRgMVbMctA7l+9W7eTfWXaRRVLYRRfmOSKUp0MhoEow4RdF268ZoiYfc1ScLO15Fou4GvDX61Np3+M/k71cqJ6imvdyHS/L754AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC0bYdjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E1C4CEF0;
	Mon,  1 Sep 2025 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756743818;
	bh=xXNMYxeUtrPT4DN76aplpZeN8UnkslUNoZEbarD5RAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IC0bYdjTaLnYXvKhfLlUnPms9FmtHm4xOtQJJVSO6DQpdytk6rYZjHGnqqjYm4HVj
	 S0XuCekWHj19c74E0buaHpy/u5gTOdn6UTiV83sq+04+OGJLP7bgv/RUseKsFBRMi3
	 vVIqEHGk6iuEZB8ayAg27GHA387gsmzPtP4xor3EyrLiwtysE9lhJAHYiWWSaSCSGG
	 owfP7we/gtmDXLd4HPbSkHxEMfF2vJXqLD1ixH/6jvietSz7mE8dVU8pn8PcBgZ2Io
	 SrqpD2E5Yh/tSDxNqdGRKr3r/PoVWLPQLLUH5bx4dQxbxEvDKrYHOlDen3eoSeGW0W
	 T6JnpKlHJIwdQ==
Date: Mon, 1 Sep 2025 19:23:13 +0300
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
Message-ID: <aLXIcUwt0HVzRpYW@kernel.org>
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
> > +	/*
> > +	 * Most of the space should be taken by preserved folios. So take its
> > +	 * size, plus a page for other properties.
> > +	 */
> > +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
> > +	if (!fdt) {
> > +		err = -ENOMEM;
> > +		goto err_unpin;
> > +	}
> 
> This doesn't seem to have any versioning scheme, it really should..
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

We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1

Will wait for kbuild and then send proper patches.
 

-- 
Sincerely yours,
Mike.

