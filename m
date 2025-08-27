Return-Path: <linux-fsdevel+bounces-59388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8930B385AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878FF3B97D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475A26FA5A;
	Wed, 27 Aug 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFB7Oh1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1D30CD8A;
	Wed, 27 Aug 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307047; cv=none; b=WPnhZI4mzufOfzaFrdZrSLv6Bcb85//TJL3EMKgtLk6jNPx8Dngahy5em2CvzgmJwdobSjT06//VGQ6/qcyy0A93/KpfTldMJeTo8moGpWmPyMZHEOshT3Aajd+9GmHwuf+ls6a7Ph9QN7F9xvupnonlpqpA+CcPpZZIcMN8fbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307047; c=relaxed/simple;
	bh=uo4Ob9kTPdoJmgAnEx6L4XzAms4E4Sy8+Nf0B+A98EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mg6vFhFo10IO/gB7J3DpGtimFfYnefUgTd5WO5dhsdsoCyQ5XqDECxEmCabRC+PneFWg00HqDJsSxzYor/olwVKCCe5vK50uqvyPwzdV7yeEsCRITy1XuD9ZRYhDIfhd9ZFQMUBdMxIHnNIH+4jYu6RM+qf4UUfEUw4YffGP+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFB7Oh1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D109C4CEEB;
	Wed, 27 Aug 2025 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307047;
	bh=uo4Ob9kTPdoJmgAnEx6L4XzAms4E4Sy8+Nf0B+A98EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GFB7Oh1eo+TReZoN3bwTBKHsq/yKs0Ec6wezEhYD6I52VzGWuajG/VUdqJlHo9GBa
	 sP5uM0oIsz73s+GR3PHPfQM4FtpF3efam0U/5zWK0ivK0fj6LbZC5fFyPNQgTeW63w
	 E7NL4+4i6tYIG42apLWejr2ppn7Fn5cZUKPnTLphMA4LKIcV/vG6hX/sMNARHSiFsV
	 jQkO6X8RnOY4b/EE++uh5xQ5m0rgUa3Pqfc7MVaJ/KmZBiq0S0kt05UaAncWvIBfdx
	 M34cS7vYly+aHvBfVvWPLH1rZ41QgDItwMsH34hBP87mp3hJpu4GzWzammLxdZZMf/
	 wwiiTIEjNHQnQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
In-Reply-To: <20250826162019.GD2130239@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com>
Date: Wed, 27 Aug 2025 17:03:55 +0200
Message-ID: <mafs0bjo0yffo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jason,

Thanks for the review.

On Tue, Aug 26 2025, Jason Gunthorpe wrote:

> On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
>
>> +	/*
>> +	 * Most of the space should be taken by preserved folios. So take its
>> +	 * size, plus a page for other properties.
>> +	 */
>> +	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
>> +	if (!fdt) {
>> +		err = -ENOMEM;
>> +		goto err_unpin;
>> +	}
>
> This doesn't seem to have any versioning scheme, it really should..

It does. See the "compatible" property.

    static const char memfd_luo_compatible[] = "memfd-v1";

static struct liveupdate_file_handler memfd_luo_handler = {
	.ops = &memfd_luo_file_ops,
	.compatible = memfd_luo_compatible,
};

This goes into the LUO FDT:

	static int luo_files_to_fdt(struct xarray *files_xa_out)
	[...]
	xa_for_each(files_xa_out, token, h) {
		[...]
		ret = fdt_property_string(luo_file_fdt_out, "compatible",
					  h->fh->compatible);

So this function only gets called for the version 1.

>
>> +	err = fdt_property_placeholder(fdt, "folios", preserved_size,
>> +				       (void **)&preserved_folios);
>> +	if (err) {
>> +		pr_err("Failed to reserve folios property in FDT: %s\n",
>> +		       fdt_strerror(err));
>> +		err = -ENOMEM;
>> +		goto err_free_fdt;
>> +	}
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

Yep, I agree. This version already runs into size limits of around 1 GiB
due to the FDT being limited to MAX_PAGE_ORDER, since that is the
largest contiguous piece of memory folio_alloc() can give us. On top,
FDT is only limited to 32 bits. While very large, it isn't unreasonable
to expect metadata exceeding that for some use cases (4 GiB is only 0.4%
of 1 TiB and there are systems a lot larger than that around).

I think we need something a luo_xarray data structure that users like
memfd (and later hugetlb and guest_memfd and maybe others) can build to
make serialization easier. It will cover both contiguous arrays and
arrays with some holes in them.

I did it this way mainly to keep things simple and get things out. But
Pasha already mentioned he is running into this limit for some tests, so
I think I will experiment around with a serialized xarray design.

>
>> +	for (; i < nr_pfolios; i++) {
>> +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
>> +		phys_addr_t phys;
>> +		u64 index;
>> +		int flags;
>> +
>> +		if (!pfolio->foliodesc)
>> +			continue;
>> +
>> +		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
>> +		folio = kho_restore_folio(phys);
>> +		if (!folio) {
>> +			pr_err("Unable to restore folio at physical address: %llx\n",
>> +			       phys);
>> +			goto put_file;
>> +		}
>> +		index = pfolio->index;
>> +		flags = PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
>> +
>> +		/* Set up the folio for insertion. */
>> +		/*
>> +		 * TODO: Should find a way to unify this and
>> +		 * shmem_alloc_and_add_folio().
>> +		 */
>> +		__folio_set_locked(folio);
>> +		__folio_set_swapbacked(folio);
>> 
>> +		ret = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
>> +		if (ret) {
>> +			pr_err("shmem: failed to charge folio index %d: %d\n",
>> +			       i, ret);
>> +			goto unlock_folio;
>> +		}
>
> [..]
>
>> +		folio_add_lru(folio);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +	}
>
> Probably some consolidation will be needed to make this less
> duplicated..

Maybe. I do have that as a TODO item, but I took a quick look today and
I am not sure if it will make things simple enough. There are a few
places that add a folio to the shmem page cache, and all of them have
subtle differences and consolidating them all might be tricky. Let me
give it a shot...

>
> But overall I think just using the memfd_luo_preserved_folio as the
> serialization is entirely file, I don't think this needs anything more
> complicated.
>
> What it does need is an alternative to the FDT with versioning.

As I explained above, the versioning is already there. Beyond that, why
do you think a raw C struct is better than FDT? It is just another way
of expressing the same information. FDT is a bit more cumbersome to
write and read, but comes at the benefit of more introspect-ability.

>
> Which seems to me to be entirely fine as:
>
>  struct memfd_luo_v0 {
>     __aligned_u64 size;
>     __aligned_u64 pos;
>     __aligned_u64 folios;
>  };
>
>  struct memfd_luo_v0 memfd_luo_v0 = {.size = size, pos = file->f_pos, folios = folios};
>  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);
>
> Which also shows the actual data needing to be serialized comes from
> more than one struct and has to be marshaled in code, somehow, to a
> single struct.
>
> Then I imagine a fairly simple forwards/backwards story. If something
> new is needed that is non-optional, lets say you compress the folios
> list to optimize holes:
>
>  struct memfd_luo_v1 {
>     __aligned_u64 size;
>     __aligned_u64 pos;
>     __aligned_u64 folios_list_with_holes;
>  };
>
> Obviously a v0 kernel cannot parse this, but in this case a v1 aware
> kernel could optionally duplicate and write out the v0 format as well:
>
>  luo_store_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0);
>  luo_store_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1);

I think what you describe here is essentially how LUO works currently,
just that the mechanisms are a bit different.

For example, instead of the subsystem calling luo_store_object(), the
LUO core calls back into the subsystem at the appropriate time to let it
populate the object. See memfd_luo_prepare() and the data argument. The
version is decided by the compatible string with which the handler was
registered.

Since LUO knows when to start serializing what, I think this flow of
calling into the subsystem and letting it fill in an object that LUO
tracks and hands over makes a lot of sense.

>
> Then the rule is fairly simple, when the sucessor kernel goes to
> deserialize it asks luo for the versions it supports:
>
>  if (luo_restore_object(&memfd_luo_v1, sizeof(memfd_luo_v1), <.. identifier for this fd..>, /*version=*/1))
>     restore_v1(&memfd_luo_v1)
>  else if (luo_restore_object(&memfd_luo_v0, sizeof(memfd_luo_v0), <.. identifier for this fd..>, /*version=*/0))
>     restore_v0(&memfd_luo_v0)
>  else
>     luo_failure("Do not understand this");

Similarly, on restore side, the new kernel can register handlers of all
the versions it can deal with, and LUO core takes care of calling into
the right callback. See  memfd_luo_retrieve() for example. If we now have
a v2, the new kernel can simply define a new handler for v2 and add a
new memfd_luo_retrieve_v2().

>
> luo core just manages this list of versioned data per serialized
> object. There is only one version per object.

This also holds true.

-- 
Regards,
Pratyush Yadav

