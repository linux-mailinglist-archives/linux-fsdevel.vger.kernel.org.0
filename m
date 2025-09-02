Return-Path: <linux-fsdevel+bounces-59977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94960B3FE19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223B37B1C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACA2FD1BB;
	Tue,  2 Sep 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcGkOYvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C22FCC02;
	Tue,  2 Sep 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813485; cv=none; b=siQ1+w15vnO61SXjeanw40XM/fXQOaGUWG8qGDEGM4IpVru3/ChcSFLaKuzOWipIntr70GjcMmca1913iDb0ZL+uFVBCS9O8M2O1CufIHVHLVkX/QNppOq02CWdlQnjErv7K4Ou5PEKVNtegtSmUsGChwFKwAxl9igEGFsFfRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813485; c=relaxed/simple;
	bh=PsdWXEKScSpvyy0S+Dxl056IK+zdYsrlrpfYJKzyZ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1+vN3sdgJv2BHMUtZRJVcfsWITJRTBauSL0vquUTbNsktS2a7yr916es6959Zs+aK0R/PGqOmMItAd5veKHdJsAAqpDdY4dISzUNmmR9xKr5g7gaSV8uEwa3g7AvDJm4ZcxBILsmmRvs1N6pqMUwNPvNuLOl7XooI6wc3334ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcGkOYvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0680C4CEED;
	Tue,  2 Sep 2025 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813484;
	bh=PsdWXEKScSpvyy0S+Dxl056IK+zdYsrlrpfYJKzyZ9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcGkOYvoGCguKJ/jUPJf7VxrZdwrL4lVESQFTriaR2Al6lroyZ1GB6QAt5k5qWJf6
	 q3qN+YuCyjEj06tqOyAvFa6LmxWY+fkNRRvM2Fm/FaWZ47BrhQ57c5IkbTs+Kmjbxo
	 jYn3m/b2Qt+qEWFTfr7Motq5MlPMe1vWqQ2sCSESTGio/7/xhmbPYdOH4Q1OcuVHUj
	 0Qf6LRJj60aZatHetbId9ILp7QfUSrYcYBf+2DcIKerzqQP4jv1B+F4QtNdlONUyTb
	 oqSiFYIiLItMyOvFUFDVomGAq1PbDiyqYtk62VAgEE+tHDutp1f6++/ufGbmNlFvY7
	 geX873CKX7JcA==
Date: Tue, 2 Sep 2025 14:44:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <aLbYk30V2EEJJtAf@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <mafs0ldmyw1hp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmyw1hp.fsf@kernel.org>

Hi Pratyush,

On Mon, Sep 01, 2025 at 07:01:38PM +0200, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Mon, Sep 01 2025, Mike Rapoport wrote:
> 
> > On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
> >> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
> >> 
> >> > +	/*
> >> > +	 * Most of the space should be taken by preserved folios. So take its
> >> > +	 * size, plus a page for other properties.
> >> > +	 */
> >> > +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
> >> > +	if (!fdt) {
> >> > +		err = -ENOMEM;
> >> > +		goto err_unpin;
> >> > +	}
> >> 
> >> This doesn't seem to have any versioning scheme, it really should..
> >> 
> >> > +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
> >> > +				       (void **)&preserved_folios);
> >> > +	if (err) {
> >> > +		pr_err("Failed to reserve folios property in FDT: %s\n",
> >> > +		       fdt_strerror(err));
> >> > +		err = -ENOMEM;
> >> > +		goto err_free_fdt;
> >> > +	}
> >> 
> >> Yuk.
> >> 
> >> This really wants some luo helper
> >> 
> >> 'luo alloc array'
> >> 'luo restore array'
> >> 'luo free array'
> >
> > We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
> >
> > Will wait for kbuild and then send proper patches.
> 
> I have been working on something similar, but in a more generic way.
> 
> I have implemented a sparse KHO-preservable array (called kho_array)
> with xarray like properties. It can take in 4-byte aligned pointers and
> supports saving non-pointer values similar to xa_mk_value(). For now it
> doesn't support multi-index entries, but if needed the data format can
> be extended to support it as well.
> 
> The structure is very similar to what you have implemented. It uses a
> linked list of pages with some metadata at the head of each page.
> 
> I have used it for memfd preservation, and I think it is quite
> versatile. For example, your kho_preserve_vmalloc() can be very easily
> built on top of this kho_array by simply saving each physical page
> address at consecutive indices in the array.

I've started to work on something similar to your kho_array for memfd case
and then I thought that since we know the size of the array we can simply
vmalloc it and preserve vmalloc, and that lead me to implementing
preservation of vmalloc :)

I like the idea to have kho_array for cases when we don't know the amount
of data to preserve in advance, but for memfd as it's currently
implemented I think that allocating and preserving vmalloc is simpler.

As for porting kho_preserve_vmalloc() to kho_array, I also feel that it
would just make kho_preserve_vmalloc() more complex and I'd rather simplify
it even more, e.g. with preallocating all the pages that preserve indices
in advance.
 
> The code is still WIP and currently a bit hacky, but I will clean it up
> in a couple days and I think it should be ready for posting. You can
> find the current version at [0][1]. Would be good to hear your thoughts,
> and if you agree with the approach, I can also port
> kho_preserve_vmalloc() to work on top of kho_array as well.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=5eb0d7316274a9c87acaeedd86941979fc4baf96
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

