Return-Path: <linux-fsdevel+bounces-59896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF30B3ED33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7817B414
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4215320A37;
	Mon,  1 Sep 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUUI4mWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59A306492;
	Mon,  1 Sep 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746666; cv=none; b=gES8A/shU2vYcdYfO/Rf9Pz9ZNnDkwLZ5ad1gqqQbxGy5MYts+QIxvONSv+8Jf9HvrigzMnq28p6Qx0LZCL5HcaNykhOPxxtZaBdZReKDVkYkV4uD7flDadUFc6Esitbu1udCH7SkP7z1Hg9GNjTEF/aqSUd4ZR1RhAuOhMnHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746666; c=relaxed/simple;
	bh=4H0TvV5SATbPpUhZV/kpTrbxsbMRGPlfcGGMf566Pzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P5rMcy/J9vUgWL5tMKlq0/cHEbOU+JzIz23JsnhjLkcBPIgTRsnIJuqPDSA2KKh5JSxof9N6zpaPlnCExVBWw8fZTGnW9naloHZpUaEzua650R+vaE5LcbGqRROnr9ZO3uQLd4zY7eAPypjPH9sNYd2yemVIi18TA6zfyjRKGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUUI4mWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20273C4CEF0;
	Mon,  1 Sep 2025 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746665;
	bh=4H0TvV5SATbPpUhZV/kpTrbxsbMRGPlfcGGMf566Pzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TUUI4mWIbQYkLpKOkdoxxSUBAWTkDGIYzdhS0o8slwr8l2r1Piu0dUL/l4nBep+rG
	 0yJmQw4jAg/OFnBDLBuTCbytHtcsfNnnUgNkZT3gLgEb3ShbgGVAKwQxkOyPSP18C8
	 7llU/i7XIFhO9U0XbVOYJRMrxGrbX605fmK7MccA+FrMFzq540oBoLsId10kVkUbl0
	 lAs6X6RqdrVdsl02+4MM4ddwO3muSKKRwdLGGmbbS8cho5TRe0jnQdsfS22uYIMObg
	 eUQz4JMDeISgSUyU3IB3lnscaMdUMFfjTXMsM05sKQlT4UprJfC0pJ8VwXpakPhqL8
	 FF3vY5xHeeBDA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
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
In-Reply-To: <20250828124320.GB7333@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <mafs0bjo0yffo.fsf@kernel.org>
	<20250828124320.GB7333@nvidia.com>
Date: Mon, 01 Sep 2025 19:10:53 +0200
Message-ID: <mafs0h5xmw12a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jason,

On Thu, Aug 28 2025, Jason Gunthorpe wrote:

> On Wed, Aug 27, 2025 at 05:03:55PM +0200, Pratyush Yadav wrote:
>
>> I think we need something a luo_xarray data structure that users like
>> memfd (and later hugetlb and guest_memfd and maybe others) can build to
>> make serialization easier. It will cover both contiguous arrays and
>> arrays with some holes in them.
>
> I'm not sure xarray is the right way to go, it is very complex data
> structure and building a kho variation of it seems like it is a huge
> amount of work.
>
> I'd stick with simple kvalloc type approaches until we really run into
> trouble.
>
> You can always map a sparse xarray into a kvalloc linear list by
> including the xarray index in each entry.
>
> Especially for memfd where we don't actually expect any sparsity in
> real uses cases there is no reason to invest a huge effort to optimize
> for it..

Full xarray is too complex, sure. But I think a simple sparse array with
xarray-like properties (4-byte pointers, values using xa_mk_value()) is
fairly simple to implement. More advanced features of xarray like
multi-index entries can be added later if needed.

In fact, I have a WIP version of such an array and have used it for
memfd preservation, and it looks quite alright to me. You can find the
code at [0]. It is roughly 300 lines of code. I still need to clean it
up to make it post-able, but it does work.

Building kvalloc on top of this becomes trivial.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af

>
>> As I explained above, the versioning is already there. Beyond that, why
>> do you think a raw C struct is better than FDT? It is just another way
>> of expressing the same information. FDT is a bit more cumbersome to
>> write and read, but comes at the benefit of more introspect-ability.
>
> Doesn't have the size limitations, is easier to work list, runs
> faster.
>
>> >  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);
>> >  luo_store_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1);
>> 
>> I think what you describe here is essentially how LUO works currently,
>> just that the mechanisms are a bit different.
>
> The bit different is a very important bit though :)
>
> The versioning should be first class, not hidden away as some emergent
> property of registering multiple serializers or something like that.

That makes sense. How about some simple changes to the LUO interfaces to
make the version more prominent:

	int (*prepare)(struct liveupdate_file_handler *handler,
		       struct file *file, u64 *data, char **compatible);

This lets the subsystem fill in the compatible (AKA version) (string
here, but you can make it an integer if you want) when it serialized its
data.

And on restore side, LUO can pass in the compatible:

	int (*retrieve)(struct liveupdate_file_handler *handler,
			u64 data, char *compatible, struct file **file);


-- 
Regards,
Pratyush Yadav

