Return-Path: <linux-fsdevel+bounces-69519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E2C7E2D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A15734611F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C452C327E;
	Sun, 23 Nov 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwmBbpCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE71DE4DC;
	Sun, 23 Nov 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763912897; cv=none; b=IaH1Zt3q3EdR9UJMCjQ7cvse3jCe1RZhfVf5fYkXsJxrfa6w7yel3OKPBtTxpMTmbWsgSRtYZzGvsa6EiNsxua8X/inBH/2kxRy2ESFuFniqMBzV6vnHZptM7EqUpuxjJd/QkGO5iLHixDZHi9COREE570mCuFRD3bgdPD8soYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763912897; c=relaxed/simple;
	bh=o5jgDCNTQXVfP4NRsI3yDEVhzmocDH9FvcpdxoKKU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbc9s3LNDGd91PSKqQX673mbjNGNtlAr6aplbKM4iFUFjgFADA3j7Cc4B8pf+kEgTP+N/sT3LehGtwvH8PS1KBmiiIGTCXKg0zNyeO2IXg/I00BnXDCUOMh+7rv3YW618u0ATNn6rXCTuW8jFcrmz0NBC1Ilbal5f6qdXdhAAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwmBbpCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8D3C113D0;
	Sun, 23 Nov 2025 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763912896;
	bh=o5jgDCNTQXVfP4NRsI3yDEVhzmocDH9FvcpdxoKKU7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwmBbpCfluPNbVa8nNxo6qv3CPg0ynY53dii+jFo759U2j2PAl5zeYmMh6E0JMmPE
	 WwQpU6awV4qjEG5YxIwCRw4y/63MIxWorq1LmMs1/LKoONkHSSD3bEHobrUldnrFet
	 asluAC12CMOLpH/awxcqBQtCuel236oFDPMgCPkjjCkWS4yuB+7o8J80uY8GPTGfnO
	 plEEB3X7ErYve841jf0cyBHV+SsmHnhw2xsC5ZhkJfQ4u2+/tXjuGdsXZDi3B/6Pa9
	 dfKYcuPNcyq4pk7JqWEnQT+r2TfKtLTkX0MGEj2KVmiJpZ1loep4NwxtG/3KgfeoSr
	 9eG3ny7UxekUg==
Date: Sun, 23 Nov 2025 17:47:52 +0200
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
Subject: Re: [PATCH v7 14/22] mm: memfd_luo: allow preserving memfd
Message-ID: <aSMsqD5mB2mHHH9v@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-15-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-15-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:41PM -0500, Pasha Tatashin wrote:
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
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

...

> +static int memfd_luo_retrieve_folios(struct file *file,
> +				     struct memfd_luo_folio_ser *folios_ser,
> +				     u64 nr_folios)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct folio *folio;
> +	long i = 0;
> +	int err;
> +
> +	for (; i < nr_folios; i++) {
> +		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> +		phys_addr_t phys;
> +		u64 index;
> +		int flags;
> +
> +		if (!pfolio->pfn)
> +			continue;
> +
> +		phys = PFN_PHYS(pfolio->pfn);
> +		folio = kho_restore_folio(phys);
> +		if (!folio) {
> +			pr_err("Unable to restore folio at physical address: %llx\n",
> +			       phys);
> +			goto put_folios;
> +		}
> +		index = pfolio->index;
> +		flags = pfolio->flags;
> +
> +		/* Set up the folio for insertion. */
> +		__folio_set_locked(folio);
> +		__folio_set_swapbacked(folio);
> +
> +		err = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
> +		if (err) {
> +			pr_err("shmem: failed to charge folio index %ld: %d\n",
> +			       i, err);
> +			goto unlock_folio;
> +		}
> +
> +		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
> +					      mapping_gfp_mask(mapping));
> +		if (err) {
> +			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
> +			       i, err);
> +			goto unlock_folio;
> +		}
> +
> +		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
> +			folio_mark_uptodate(folio);
> +		if (flags & MEMFD_LUO_FOLIO_DIRTY)
> +			folio_mark_dirty(folio);
> +
> +		err = shmem_inode_acct_blocks(inode, 1);
> +		if (err) {
> +			pr_err("shmem: failed to account folio index %ld: %d\n",
> +			       i, err);
> +			goto unlock_folio;
> +		}
> +
> +		shmem_recalc_inode(inode, 1, 0);
> +		folio_add_lru(folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +
> +	return 0;
> +
> +unlock_folio:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	i++;
 
I'd add a counter and use it int the below for loop.

> +put_folios:
> +	/*
> +	 * Note: don't free the folios already added to the file. They will be
> +	 * freed when the file is freed. Free the ones not added yet here.
> +	 */
> +	for (; i < nr_folios; i++) {
> +		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> +
> +		folio = kho_restore_folio(pfolio->pfn);
> +		if (folio)
> +			folio_put(folio);
> +	}
> +
> +	return err;
> +}

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

