Return-Path: <linux-fsdevel+bounces-69517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB1C7E296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4DAF3418B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139D2D73BE;
	Sun, 23 Nov 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8qOsmK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C91F584C;
	Sun, 23 Nov 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911774; cv=none; b=UcQJUfN2q3U5ymQZEslmvXmr28/6SvF+6bwNI7t3A6MdhzIXCHsMPpqi/BvpzwnoJaz1AWyxwqrf53k0+kbEYg0NV6WG2h94Bk2BQjPLnrQMSWaCMGzXimMqXpZUm5dwfNhhKh3fIDa52mlKc5OFbGsbphyT+qDjFZ/8vaMLA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911774; c=relaxed/simple;
	bh=KJ7T2gPWZjYh1cz0HfYyKYPb/10E/Fx5BaTXqTs2/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4ZntGQI5HWaXxLXSHdM8wxAkQG8vdSaWAARxq+sknB0DGAPVLVcCgpBDueAOU6e0jwVGxmkpIwUsFF4Eyc28degtZf4WZ4qkKIt5zqBlyv40Lwbaan24iRoPMVdglV5lgYv7evHLo5v9zAOer4QMPbjv/qSDl0/uzoklt0Lnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8qOsmK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919A4C113D0;
	Sun, 23 Nov 2025 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763911774;
	bh=KJ7T2gPWZjYh1cz0HfYyKYPb/10E/Fx5BaTXqTs2/Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8qOsmK0MFixaOE+ur9RDYKjJNzgQETCBx4Oa3wWC/9H1PoxgtrNQNX7/5A4GpW/U
	 v0JV7rkpnvyJL1rYx6chzjbZgoupm4vdk57fliNPi39btz2xk1F5FCee4m+Rr8Cqe1
	 E9l6XiQcA2IWOIwOMkCEhjEqnPIJml2n1VV2Eze/Ydq0SxT4eVjeex+rOaqjxgNVxe
	 53QRcV94fUWhBLEk/49eJ3jbINePYq/OtvXRBht1s5jNKnMBp3RxBxQ8lxoVUsjDPB
	 tQkNIka36Z6rQKVe/hymFXQ83s2NhHD4on6LZ3syqdlujrr7+PFw2Mcordkbsq1LyH
	 /sCwFTOTSrNUQ==
Date: Sun, 23 Nov 2025 17:29:09 +0200
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
Subject: Re: [PATCH v7 11/22] mm: shmem: allow freezing inode mapping
Message-ID: <aSMoRRtanMkHo9Tr@kernel.org>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-12-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122222351.1059049-12-pasha.tatashin@soleen.com>

On Sat, Nov 22, 2025 at 05:23:38PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> To prepare a shmem inode for live update, its index -> folio mappings
> must be serialized. Once the mappings are serialized, they cannot change
> since it would cause the serialized data to become inconsistent. This
> can be done by pinning the folios to avoid migration, and by making sure
> no folios can be added to or removed from the inode.
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
>  mm/shmem.c               | 19 ++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 650874b400b5..d34a64eafe60 100644
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
> +static inline void shmem_freeze(struct inode *inode, bool freeze)
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
> index 1d5036dec08a..cb74a5d202ac 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1292,9 +1292,13 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>  		loff_t newsize = attr->ia_size;
>  
>  		/* protected by i_rwsem */
> -		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> -		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> -			return -EPERM;
> +		if (newsize != oldsize) {
> +			if (info->flags & SHMEM_F_MAPPING_FROZEN)
> +				return -EPERM;
> +			if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
> +			    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> +				return -EPERM;
> +		}
>  
>  		if (newsize != oldsize) {

I'd stick 

			if (info->flags & SHMEM_F_MAPPING_FROZEN)
				return -EPERM;

here and leave the seals check alone.

Other than than

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

