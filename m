Return-Path: <linux-fsdevel+bounces-68703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56757C6379A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F25C348779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1B30DD2E;
	Mon, 17 Nov 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyjp8I30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5C30C344;
	Mon, 17 Nov 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374114; cv=none; b=BVYaSGb0cLpEgYTaZuHzgm2+goKVx67LGuKYhpkP6ekIyWwxRcFXeGCdjaL0/uQK8IZi7aUODlrpbfjc6gryYF6O1Bll+9Nhp71b6ostmHriyOndIl/kKvywb62VdiGYJUYaHLlcYI7pGY08uxVvTpqh0/nkExAhTWzm5s5jiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374114; c=relaxed/simple;
	bh=NfEctPhiqLwKM7Al5ilCJVKY/ooOPtorS0nazjY5qF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLL9jyUDDu/jLGhcKyuhud2CEgBeDQ2Wbt2dTUp8yEErDy0m9AQvSMxSTplQnFa7eV3rQgoubtwE/pq7e8oxc0hFA216blRVsfdofoO0mF258vSVr/5xh2gRiv02egbhV/UlTFfoe1upGBnp/nyhFA0V2Lv5p3x41uHkqkxnFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyjp8I30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080FC4CEF1;
	Mon, 17 Nov 2025 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763374114;
	bh=NfEctPhiqLwKM7Al5ilCJVKY/ooOPtorS0nazjY5qF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyjp8I30CMsVwAFn9pOiUTamRKt1uRSpOdE7O2jvI4OTBEvKMg4uqklLdOpQB0cTB
	 7hHYlDan0L0oNCir7r5ZwY4Ze1MUR+Tc6/AcZxyTGFksM/YJQ2xzH4ukZrQxGbhIce
	 YTJJly5hrZOjWrGCfHCEpIzoGzNCIx8ezeXHddI6w0fZSg1Y/j/jY3eHHyIEI/6J4q
	 Jxtx9gkWqj7xCl8h+ggjG83fdiZ34qLZTR2P9DcFpD1W5m5qelmcIP6t9o6dcb8Prv
	 kmHR3mG7h1z19hn9UOwxRdhQdpnkKDudEOZxRksOyz+oRXe8F0db8Dio3oOjHY3CML
	 zQVyCqEEoWARg==
Date: Mon, 17 Nov 2025 12:08:09 +0200
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
Subject: Re: [PATCH v6 12/20] mm: shmem: allow freezing inode mapping
Message-ID: <aRr0CQsV16usRW1J@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-13-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-13-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:58PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> To prepare a shmem inode for live update via the Live Update
> Orchestrator (LUO), its index -> folio mappings must be serialized. Once
> the mappings are serialized, they cannot change since it would cause the
> serialized data to become inconsistent. This can be done by pinning the
> folios to avoid migration, and by making sure no folios can be added to
> or removed from the inode.
> 
> While mechanisms to pin folios already exist, the only way to stop
> folios being added or removed are the grow and shrink file seals. But
> file seals come with their own semantics, one of which is that they
> can't be removed. This doesn't work with liveupdate since it can be
> cancelled or error out, which would need the seals to be removed and the
> file's normal functionality to be restored.
> 
> Introduce SHMEM_F_MAPPING_FROZEN to indicate this instead. It is
> internal to shmem and is not directly exposed to userspace. It functions
> similar to F_SEAL_GROW | F_SEAL_SHRINK, but additionally disallows hole
> punching, and can be removed.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/shmem_fs.h | 17 +++++++++++++++++
>  mm/shmem.c               | 12 +++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 650874b400b5..a9f5db472a39 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -24,6 +24,14 @@ struct swap_iocb;
>  #define SHMEM_F_NORESERVE	BIT(0)
>  /* Disallow swapping. */
>  #define SHMEM_F_LOCKED		BIT(1)
> +/*
> + * Disallow growing, shrinking, or hole punching in the inode. Combined with
> + * folio pinning, makes sure the inode's mapping stays fixed.
> + *
> + * In some ways similar to F_SEAL_GROW | F_SEAL_SHRINK, but can be removed and
> + * isn't directly visible to userspace.
> + */
> +#define SHMEM_F_MAPPING_FROZEN	BIT(2)
>  
>  struct shmem_inode_info {
>  	spinlock_t		lock;
> @@ -186,6 +194,15 @@ static inline bool shmem_file(struct file *file)
>  	return shmem_mapping(file->f_mapping);
>  }
>  
> +/* Must be called with inode lock taken exclusive. */
> +static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)

_mapping usually refers to operations on struct address_space.
It seems that all shmem methods that take inode are just shmem_<operation>,
so shmem_freeze() looks more appropriate.

> +{
> +	if (freeze)
> +		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
> +	else
> +		SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
> +}
> +
>  /*
>   * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
>   * beyond i_size's notion of EOF, which fallocate has committed to reserving:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1d5036dec08a..05c3db840257 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1292,7 +1292,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  		loff_t newsize = attr->ia_size;
>  
>  		/* protected by i_rwsem */
> -		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> +		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||

A corner case: if newsize == oldsize this will be a false positive

> +		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>  			return -EPERM;
>  
> @@ -3289,6 +3290,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  			return -EPERM;
>  	}
>  
> +	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
> +		     pos + len > inode->i_size))
> +		return -EPERM;
> +
>  	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
>  	if (ret)
>  		return ret;
> @@ -3662,6 +3667,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  
>  	inode_lock(inode);
>  
> +	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
> +		error = -EPERM;
> +		goto out;
> +	}
> +
>  	if (mode & FALLOC_FL_PUNCH_HOLE) {
>  		struct address_space *mapping = file->f_mapping;
>  		loff_t unmap_start = round_up(offset, PAGE_SIZE);
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

