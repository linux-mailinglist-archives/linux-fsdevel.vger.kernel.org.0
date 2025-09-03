Return-Path: <linux-fsdevel+bounces-60157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDBB4235E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A0E16567B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7930DD3A;
	Wed,  3 Sep 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2qkEx0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D22FCC0D;
	Wed,  3 Sep 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909046; cv=none; b=EyKGFxefhnXGMmha2K7m6HS/qNH0MWF0NdaO2/ZM3ciJXUZuH4fMvt83Wk19pkB8IP0zYMA4Ofe9nO1744UROrzIiQM3TVNYH9MRcTX4iWPp1oKwZO2fuYq60FaDS7b5EMpKtrrU2Oyv54flXH0nTIXtZ/YMayWGCQjcuNt0Ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909046; c=relaxed/simple;
	bh=rkSg1vCoekuc9whKWjo4hgqm1Elyfx6nN2+yYBdxBhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFgo4809J7RzDkntROlbTQKFaIcsJ52FDWFV2fM0vlrB6QMPUrRBVn1ro3+DxUa3/q3AVmKMqnTGvoYxHWeVbO2VtFf1tLRcEpnugLofrspQzyWrHwxN8QlU1Pu9TZEKq6cZUYXABwc0GbzaMl/D42Sm/lcld95Frz/j1nGPa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2qkEx0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075E6C4CEE7;
	Wed,  3 Sep 2025 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756909046;
	bh=rkSg1vCoekuc9whKWjo4hgqm1Elyfx6nN2+yYBdxBhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g2qkEx0srlnMZm9jvTuQkoAfUMqfZLmOGvMvWAXSFNRLeSDA5jxOcfWXXmUvxxNM8
	 yvdadUNZgnBX3z/+e4yDpoxMbRzcPuAnr38KTH3Vu7n/1F7mqMnQLDtY97FOFmU2qb
	 f3BqGPAIhHQlFrXQgm64XqEAf2KGNfJM92WGL8OAKBaRXkA/f3UgK0fIr7zt5swxiJ
	 hgOUO2rzO4bNzczWxkpktx7lTBG9e6nmau7vZmkjiEckwkS4MGMoDE1PbRdr39Xoxn
	 kj4QeQgwRxQT2rdLQor3kdwOYj76BPFKEkjV4l2X1fOg6RdjMK6qKg5Z6N5j4zrE8l
	 ZL568mTWs7NNw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <aLbYk30V2EEJJtAf@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <aLXIcUwt0HVzRpYW@kernel.org>
	<mafs0ldmyw1hp.fsf@kernel.org> <aLbYk30V2EEJJtAf@kernel.org>
Date: Wed, 03 Sep 2025 16:17:15 +0200
Message-ID: <mafs0qzwnvcwk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Tue, Sep 02 2025, Mike Rapoport wrote:

> Hi Pratyush,
>
> On Mon, Sep 01, 2025 at 07:01:38PM +0200, Pratyush Yadav wrote:
>> Hi Mike,
>> 
>> On Mon, Sep 01 2025, Mike Rapoport wrote:
>> 
>> > On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
>> >> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
>> >> 
>> >> > +	/*
>> >> > +	 * Most of the space should be taken by preserved folios. So take its
>> >> > +	 * size, plus a page for other properties.
>> >> > +	 */
>> >> > +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
>> >> > +	if (!fdt) {
>> >> > +		err = -ENOMEM;
>> >> > +		goto err_unpin;
>> >> > +	}
>> >> 
>> >> This doesn't seem to have any versioning scheme, it really should..
>> >> 
>> >> > +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
>> >> > +				       (void **)&preserved_folios);
>> >> > +	if (err) {
>> >> > +		pr_err("Failed to reserve folios property in FDT: %s\n",
>> >> > +		       fdt_strerror(err));
>> >> > +		err = -ENOMEM;
>> >> > +		goto err_free_fdt;
>> >> > +	}
>> >> 
>> >> Yuk.
>> >> 
>> >> This really wants some luo helper
>> >> 
>> >> 'luo alloc array'
>> >> 'luo restore array'
>> >> 'luo free array'
>> >
>> > We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
>> >
>> > Will wait for kbuild and then send proper patches.
>> 
>> I have been working on something similar, but in a more generic way.
>> 
>> I have implemented a sparse KHO-preservable array (called kho_array)
>> with xarray like properties. It can take in 4-byte aligned pointers and
>> supports saving non-pointer values similar to xa_mk_value(). For now it
>> doesn't support multi-index entries, but if needed the data format can
>> be extended to support it as well.
>> 
>> The structure is very similar to what you have implemented. It uses a
>> linked list of pages with some metadata at the head of each page.
>> 
>> I have used it for memfd preservation, and I think it is quite
>> versatile. For example, your kho_preserve_vmalloc() can be very easily
>> built on top of this kho_array by simply saving each physical page
>> address at consecutive indices in the array.
>
> I've started to work on something similar to your kho_array for memfd case
> and then I thought that since we know the size of the array we can simply
> vmalloc it and preserve vmalloc, and that lead me to implementing
> preservation of vmalloc :)
>
> I like the idea to have kho_array for cases when we don't know the amount
> of data to preserve in advance, but for memfd as it's currently
> implemented I think that allocating and preserving vmalloc is simpler.
>
> As for porting kho_preserve_vmalloc() to kho_array, I also feel that it
> would just make kho_preserve_vmalloc() more complex and I'd rather simplify
> it even more, e.g. with preallocating all the pages that preserve indices
> in advance.

I think there are two parts here. One is the data format of the KHO
array and the other is the way to build it. I think the format is quite
simple and versatile, and we can have many strategies of building it.

For example, if you are only concerned with pre-allocating data, I can
very well add a way to initialize the KHO array with with a fixed size
up front.

Beyond that, I think KHO array will actually make kho_preserve_vmalloc()
simpler since it won't have to deal with the linked list traversal
logic. It can just do ka_for_each() and just get all the pages. We can
also convert the preservation bitmaps to use it so the linked list logic
is in one place, and others just build on top of it.

>  
>> The code is still WIP and currently a bit hacky, but I will clean it up
>> in a couple days and I think it should be ready for posting. You can
>> find the current version at [0][1]. Would be good to hear your thoughts,
>> and if you agree with the approach, I can also port
>> kho_preserve_vmalloc() to work on top of kho_array as well.
>> 
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=5eb0d7316274a9c87acaeedd86941979fc4baf96
>> 
>> -- 
>> Regards,
>> Pratyush Yadav

-- 
Regards,
Pratyush Yadav

