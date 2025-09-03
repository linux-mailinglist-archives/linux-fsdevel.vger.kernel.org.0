Return-Path: <linux-fsdevel+bounces-60199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38086B42A11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D423A1942
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C72D4B6F;
	Wed,  3 Sep 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz6uxsup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41772C18A;
	Wed,  3 Sep 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928390; cv=none; b=JUc1Zr8xyVhKXjnuk5gGVTWL5qW2AQvci0uYQ91XJSy5SrIeOJJ/Ur4bBSNh74iJvN12GgWCY6OCe58VNKINlzHjSX4opsiNox8au+dftFisQQGpgD8WjGak7nue5g5BUeshbX/ern4LGAwFsp7omMa418cn6myyAcvgJ4OLu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928390; c=relaxed/simple;
	bh=Pu+vu6g6LwE10wMxZrFW5TxKz0JITY2Crb4lMaPJ9SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK3VgtLDSNwOeWbzfW+qQyM22GpNUttb9lkZ9C9lyKgpGl/HJSMkO9UB6vkABPLDjOxTqMEUc9RvvR2iRm7FTvl4cn3AcqZ8WRUVAJ4SVgCY3DRX6iM2t9nroUO+F1p9Iv1Om2gCoo6eGtvq2l6r/d8o8tFNysIXUGYjvxwit8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz6uxsup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6955FC4CEE7;
	Wed,  3 Sep 2025 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756928389;
	bh=Pu+vu6g6LwE10wMxZrFW5TxKz0JITY2Crb4lMaPJ9SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gz6uxsup5NvrDysGKeMXZ44qZPYIGuzbclLbViCOP9MmigNiunGxpJvcdJnlmXqRe
	 AvBU8YwMwhCvjlAHFoATnl84QP8uDsa4o5/G2NhtFJzt0BCNE56oil5QKBjz4Ql5N2
	 E4pDBHs9enBiGj/gq1J1rHF0uh+0ZcV/MMTT9d7aeTnt/+LPqShw6YKXuL29ocn3HW
	 4sg84FuqSg5Ty/PGCMeMCWkcmYiZ/KRSXV/BOVZAtgkck9rDjLsJvr4kGeQuvmgGwP
	 eDgZRyMDXPjrWqCYLL5Ybug/VIq8TSxZb2Pyz8B5bRFd7JLQ4veEthmtrikmpPB4mw
	 QmDw761qL8u6w==
Date: Wed, 3 Sep 2025 22:39:25 +0300
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
Message-ID: <aLiZbb_F5R2x9-y2@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <mafs0ldmyw1hp.fsf@kernel.org>
 <aLbYk30V2EEJJtAf@kernel.org>
 <mafs0qzwnvcwk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0qzwnvcwk.fsf@kernel.org>

Hi Pratyush,

On Wed, Sep 03, 2025 at 04:17:15PM +0200, Pratyush Yadav wrote:
> On Tue, Sep 02 2025, Mike Rapoport wrote:
> >
> > As for porting kho_preserve_vmalloc() to kho_array, I also feel that it
> > would just make kho_preserve_vmalloc() more complex and I'd rather simplify
> > it even more, e.g. with preallocating all the pages that preserve indices
> > in advance.
> 
> I think there are two parts here. One is the data format of the KHO
> array and the other is the way to build it. I think the format is quite
> simple and versatile, and we can have many strategies of building it.
> 
> For example, if you are only concerned with pre-allocating data, I can
> very well add a way to initialize the KHO array with with a fixed size
> up front.

I wasn't concerned with preallocation vs allocating a page at a time, I
though with preallocation the vmalloc code will become even simpler, but
it's not :)
 
> Beyond that, I think KHO array will actually make kho_preserve_vmalloc()
> simpler since it won't have to deal with the linked list traversal
> logic. It can just do ka_for_each() and just get all the pages.
>
> We can also convert the preservation bitmaps to use it so the linked list
> logic is in one place, and others just build on top of it.

I disagree. The boilerplate to initialize and iterate the kho_array will
not make neither vmalloc nor bitmaps preservation simpler IMO.

And for bitmaps Pasha and Jason M. are anyway working on a different data
structure already, so if their proposal moves forward converting bitmap
preservation to anything would be a wasted effort.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

