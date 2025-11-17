Return-Path: <linux-fsdevel+bounces-68711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B87C63C36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF7C13803F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A932D0D4;
	Mon, 17 Nov 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0k3QEKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824632D0C6;
	Mon, 17 Nov 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377464; cv=none; b=DNaPW2/2Sf+HgQXuAjbOXhSIFhzeXImPbJqrZOotFalwUDR0ZpeWB3firlUNWRyPI7/5py53b77x+AB4IOUi6A/w6Qp6RiifgBr6N6aH8tCn3ZbZOcWOeow2L5xzbmkTeqKuYYmZWxcdk/S9+z5t5cMEARvzAJyi8sI4W5woEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377464; c=relaxed/simple;
	bh=WWE3t7I3SF3DlAE8BdmFrmCS1M/rFEV0vnSNWTBc5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZEm0YP0PSLkIzYtK4kQXBv+IlFA0tmWtDbWAul6lNb3PAzwdrfU/iOl4XKU3wGCwppbCvTG+DTIHQ+7s1SBG6zDDg3ME6nRUPYnRyjH7RdJvAP7ve6BIER6fx8S/fvaR/O9qsytwdQ5fjoenzBgGnfaScsfqsExiWG9vxbygZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0k3QEKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E08C4CEF5;
	Mon, 17 Nov 2025 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763377464;
	bh=WWE3t7I3SF3DlAE8BdmFrmCS1M/rFEV0vnSNWTBc5tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0k3QEKiD+rh0bxxX4fVCaTPVujvmto8tLg1+BtAac2R9g3v1tykJEAkfem0Pb348
	 5J7cMEYG97oQY/jmtHQL4hq0YWVyu9sjQ+bamnEw24il8JGqUNljNbi2tNf1SE8M1o
	 7kIb025ro7tzRhVKkfhrdWEt81mbmyXnC92DQCJfsIuoZ8JOBHVNmGYkW/+mcu+44H
	 vlDwPn8Ru9Iwj+/+x4jmCovyEDM6GMzKw5WJR2gC21oZNSZMie6FbcjuKvoCZqs1zS
	 vNI33MsNbl0wbkQ3l3Ms5VR1t1pU7GIybR5Pnkqj3TfEUhoojMKF9MbrI6OEw9HmVl
	 BTlC8ggjtSRNQ==
Date: Mon, 17 Nov 2025 13:03:59 +0200
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
Subject: Re: [PATCH v6 15/20] mm: memfd_luo: allow preserving memfd
Message-ID: <aRsBHy5aQ_Ypyy9r@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-16-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-16-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:34:01PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> The ability to preserve a memfd allows userspace to use KHO and LUO to
> transfer its memory contents to the next kernel. This is useful in many
> ways. For one, it can be used with IOMMUFD as the backing store for
> IOMMU page tables. Preserving IOMMUFD is essential for performing a
> hypervisor live update with passthrough devices. memfd support provides
> the first building block for making that possible.
> 
> For another, applications with a large amount of memory that takes time
> to reconstruct, reboots to consume kernel upgrades can be very
> expensive. memfd with LUO gives those applications reboot-persistent
> memory that they can use to quickly save and reconstruct that state.
> 
> While memfd is backed by either hugetlbfs or shmem, currently only
> support on shmem is added. To be more precise, support for anonymous
> shmem files is added.
> 
> The handover to the next kernel is not transparent. All the properties
> of the file are not preserved; only its memory contents, position, and
> size. The recreated file gets the UID and GID of the task doing the
> restore, and the task's cgroup gets charged with the memory.
> 
> Once preserved, the file cannot grow or shrink, and all its pages are
> pinned to avoid migrations and swapping. The file can still be read from
> or written to.
> 
> Use vmalloc to get the buffer to hold the folios, and preserve
> it using kho_preserve_vmalloc(). This doesn't have the size limit.
> 
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

The order of signed-offs seems wrong, Pasha's should be the last one.

> ---

...

> +/**
> + * DOC: memfd Live Update ABI
> + *
> + * This header defines the ABI for preserving the state of a memfd across a
> + * kexec reboot using the LUO.
> + *
> + * The state is serialized into a Flattened Device Tree which is then handed
> + * over to the next kernel via the KHO mechanism. The FDT is passed as the
> + * opaque `data` handle in the file handler callbacks.
> + *
> + * This interface is a contract. Any modification to the FDT structure,
> + * node properties, compatible string, or the layout of the serialization
> + * structures defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the MEMFD_LUO_FH_COMPATIBLE string.

The same comment about contract as for the generic LUO documentation
applies here (https://lore.kernel.org/all/aRnG8wDSSAtkEI_z@kernel.org/)

> + *
> + * FDT Structure Overview:
> + *   The memfd state is contained within a single FDT with the following layout:

...

> +static struct memfd_luo_folio_ser *memfd_luo_preserve_folios(struct file *file, void *fdt,
> +							     u64 *nr_foliosp)
> +{

If we are already returning nr_folios by reference, we might do it for
memfd_luo_folio_ser as well and make the function return int.

> +	struct inode *inode = file_inode(file);
> +	struct memfd_luo_folio_ser *pfolios;
> +	struct kho_vmalloc *kho_vmalloc;
> +	unsigned int max_folios;
> +	long i, size, nr_pinned;
> +	struct folio **folios;

pfolios and folios read like the former is a pointer to latter.
I'd s/pfolios/folios_ser/

> +	int err = -EINVAL;
> +	pgoff_t offset;
> +	u64 nr_folios;

...

> +	kvfree(folios);
> +	*nr_foliosp = nr_folios;
> +	return pfolios;
> +
> +err_unpreserve:
> +	i--;
> +	for (; i >= 0; i--)

Maybe a single line

	for (--i; i >= 0; --i)

> +		kho_unpreserve_folio(folios[i]);
> +	vfree(pfolios);
> +err_unpin:
> +	unpin_folios(folios, nr_folios);
> +err_free_folios:
> +	kvfree(folios);
> +	return ERR_PTR(err);
> +}
> +
> +static void memfd_luo_unpreserve_folios(void *fdt, struct memfd_luo_folio_ser *pfolios,
> +					u64 nr_folios)
> +{
> +	struct kho_vmalloc *kho_vmalloc;
> +	long i;
> +
> +	if (!nr_folios)
> +		return;
> +
> +	kho_vmalloc = (struct kho_vmalloc *)fdt_getprop(fdt, 0, MEMFD_FDT_FOLIOS, NULL);
> +	/* The FDT was created by this kernel so expect it to be sane. */
> +	WARN_ON_ONCE(!kho_vmalloc);

The FDT won't have FOLIOS property if size was zero, will it?
I think that if we add kho_vmalloc handle to struct memfd_luo_private and
pass that around it will make things easier and simpler.

> +	kho_unpreserve_vmalloc(kho_vmalloc);
> +
> +	for (i = 0; i < nr_folios; i++) {
> +		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
> +		struct folio *folio;
> +
> +		if (!pfolio->foliodesc)
> +			continue;

How can this happen? Can pfolios be a sparse array?

> +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> +
> +		kho_unpreserve_folio(folio);
> +		unpin_folio(folio);
> +	}
> +
> +	vfree(pfolios);
> +}

...

> +static void memfd_luo_finish(struct liveupdate_file_op_args *args)
> +{
> +	const struct memfd_luo_folio_ser *pfolios;
> +	struct folio *fdt_folio;
> +	const void *fdt;
> +	u64 nr_folios;
> +
> +	if (args->retrieved)
> +		return;
> +
> +	fdt_folio = memfd_luo_get_fdt(args->serialized_data);
> +	if (!fdt_folio) {
> +		pr_err("failed to restore memfd FDT\n");
> +		return;
> +	}
> +
> +	fdt = folio_address(fdt_folio);
> +
> +	pfolios = memfd_luo_fdt_folios(fdt, &nr_folios);
> +	if (!pfolios)
> +		goto out;
> +
> +	memfd_luo_discard_folios(pfolios, nr_folios);

Does not this free the actual folios that were supposed to be preserved?

> +	vfree(pfolios);
> +
> +out:
> +	folio_put(fdt_folio);
> +}

...

> +static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
> +{
> +	struct folio *fdt_folio;
> +	const u64 *pos, *size;
> +	struct file *file;
> +	int len, ret = 0;
> +	const void *fdt;
> +
> +	fdt_folio = memfd_luo_get_fdt(args->serialized_data);

Why do we need to kho_restore_folio() twice? Here and in
memfd_luo_finish()?

> +	if (!fdt_folio)
> +		return -ENOENT;
> +
> +	fdt = page_to_virt(folio_page(fdt_folio, 0));

folio_address()


-- 
Sincerely yours,
Mike.

