Return-Path: <linux-fsdevel+bounces-59895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A73B3ECD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235E91B21034
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC630E831;
	Mon,  1 Sep 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8kA9PWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBC32F75C;
	Mon,  1 Sep 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746110; cv=none; b=mZ/F/QdVkm9N70qguuWlGvmk/j3B3wsGKnR4CfahUmhwH6f2b8Z8a/hSmYqIIMKawPz61ReS4MU362QsgdouS6CIdOrqyVRtSXZi1R56MElW//2igsFB8PvjKt9KMiTRT80Hw5ynZnTYGevElv8U6a7/pTNzWFpzWxNgEtyRmQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746110; c=relaxed/simple;
	bh=Xid0o6B2H0awNyRJaNWd4FT6j6sbVMwx8IaWar55E1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sixnMaprzoXQPNh1DF3GRtaf5+50NauTttQEu4W7VPSQOf+6bDQPrZy44fBiP8jTA3xLsIYEVbOeRLhtz9MCaMI17W2scBavAKE5+0X1HANoAxBaN+F3Pt/L0cEZPlEa3JDUlePMD4VCzDwc9hmUPaeqVyugJOyxyLA7D+G8UUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8kA9PWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D11C4CEF0;
	Mon,  1 Sep 2025 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746110;
	bh=Xid0o6B2H0awNyRJaNWd4FT6j6sbVMwx8IaWar55E1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A8kA9PWJsKdpYQ2CpBqzkOfqBwEeEF4/2ZT4gBaEtbBfff2ixrbCh57x0BX3PL1Q/
	 LRcsPWqd+g4xHYH+APQddZHFzqVWwZtUGJUL2ugp7dNJ1M1NQ0kWAey74Ljdd8rPfU
	 ZvXvt45+3GFJD7X0CdQALwh2fmjLib0nmKVV44Q/jVNYJ91jBDD1ekyWQYEPwFNhRr
	 J4nVEA23qJollhtoj3dgmfuLPd4lPGfQRvyFL4gH+tTmPZ1S4lMR6JZk2fC2OZNJqo
	 DYuErBJZvCnW6V2ChlHm3UiUC2OzRxbT3tqer9lZp7wib/mCTkg6T5qSjex029nZPr
	 /XWqER5/3Pu+A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  pratyush@kernel.org,  jasonmiu@google.com,
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
In-Reply-To: <aLXIcUwt0HVzRpYW@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <aLXIcUwt0HVzRpYW@kernel.org>
Date: Mon, 01 Sep 2025 19:01:38 +0200
Message-ID: <mafs0ldmyw1hp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Mon, Sep 01 2025, Mike Rapoport wrote:

> On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
>> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
>> 
>> > +	/*
>> > +	 * Most of the space should be taken by preserved folios. So take its
>> > +	 * size, plus a page for other properties.
>> > +	 */
>> > +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
>> > +	if (!fdt) {
>> > +		err = -ENOMEM;
>> > +		goto err_unpin;
>> > +	}
>> 
>> This doesn't seem to have any versioning scheme, it really should..
>> 
>> > +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
>> > +				       (void **)&preserved_folios);
>> > +	if (err) {
>> > +		pr_err("Failed to reserve folios property in FDT: %s\n",
>> > +		       fdt_strerror(err));
>> > +		err = -ENOMEM;
>> > +		goto err_free_fdt;
>> > +	}
>> 
>> Yuk.
>> 
>> This really wants some luo helper
>> 
>> 'luo alloc array'
>> 'luo restore array'
>> 'luo free array'
>
> We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
>
> Will wait for kbuild and then send proper patches.

I have been working on something similar, but in a more generic way.

I have implemented a sparse KHO-preservable array (called kho_array)
with xarray like properties. It can take in 4-byte aligned pointers and
supports saving non-pointer values similar to xa_mk_value(). For now it
doesn't support multi-index entries, but if needed the data format can
be extended to support it as well.

The structure is very similar to what you have implemented. It uses a
linked list of pages with some metadata at the head of each page.

I have used it for memfd preservation, and I think it is quite
versatile. For example, your kho_preserve_vmalloc() can be very easily
built on top of this kho_array by simply saving each physical page
address at consecutive indices in the array.

The code is still WIP and currently a bit hacky, but I will clean it up
in a couple days and I think it should be ready for posting. You can
find the current version at [0][1]. Would be good to hear your thoughts,
and if you agree with the approach, I can also port
kho_preserve_vmalloc() to work on top of kho_array as well.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af
[1] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=5eb0d7316274a9c87acaeedd86941979fc4baf96

-- 
Regards,
Pratyush Yadav

