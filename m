Return-Path: <linux-fsdevel+bounces-33074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5A9B33DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D421F2280A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B581DE2AA;
	Mon, 28 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCvjvipb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE21DB350;
	Mon, 28 Oct 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126502; cv=none; b=nPxtaakp26c/yqSl4BmZYU01Zr1Dt0Ok5ZkD6ZhntX36KC9d+OvTfhdNQGh/qhkrp17TMl/pb5BVgDfYUB7YPnLaiVfbxZlprUWoFP3Z7xvXoIA+Ta4cjHep+FLeaL4PGpTVM45RQaStw0KIoQbPzvoU7kAFO8wRnaKrCKWdFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126502; c=relaxed/simple;
	bh=iDR3Xj6nglLd6JXk8qWi2FL2TJGzRt+aL0T8F2fg1/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc/XGhYNbjo6fAkTx7oQiDFFt11dWWVOsa3E4T7lIdUG13JJ5GUhE1P0kCqz/IBzK/Yfdx028LE88NWaWW/hnSeibSfrvcaIEFEVaZSD/Pfn+plTYPjGhKZ14wByF3POt+NF9GXikSsDFjs0JmhhzuC09ea6o4E0Q6a567qDSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCvjvipb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34219C4CEC3;
	Mon, 28 Oct 2024 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126501;
	bh=iDR3Xj6nglLd6JXk8qWi2FL2TJGzRt+aL0T8F2fg1/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCvjvipb9Xw/NpUdRMbQX7UVhFg27V14zdPRu/GsX60IhJydkL/JLLWdFFMTR3hhZ
	 eoN35D3pbBtO+0ATcZkNWv+o+ALdADvxH9XIMttwPUtgFDRart8VSrTk6VuqQyHIR5
	 dBXkZ+EMGAlVGtM6XBMx2oqYtu3xwwkQLlKkKbAhI/8Ih7PsG1EeJBFcPhtvk1CYSr
	 UKkdcay7x0WkavMNtsU+AKMccuBvrvZbn9g9u5wWjssb3977bJBr3bIDpp8TaHVuKi
	 Z29bREUl6Nwq46nszaXaQNk/PcfpBvteZDVagp4tEQJKmYT/e1tIFBd6kzAd0J8pTy
	 88zkwJc/m7zdA==
Date: Mon, 28 Oct 2024 15:41:37 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net, clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com, 
	surenb@google.com, kristen.c.accardi@intel.com, zanussi@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, mcgrof@kernel.org, 
	kees@kernel.org, bfoster@redhat.com, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [RFC PATCH v1 13/13] mm: vmscan, swap, zswap: Compress batching
 of folios in shrink_folio_list().
Message-ID: <eg5ld76leezya7hbyuj4lrp4idjb3npgfu5u4oaitzrocwrht2@mqa3ur2l4yz5>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-14-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018064101.336232-14-kanchana.p.sridhar@intel.com>

On Thu, Oct 17, 2024 at 11:41:01PM -0700, Kanchana P Sridhar wrote:
> This patch enables the use of Intel IAA hardware compression acceleration
> to reclaim a batch of folios in shrink_folio_list(). This results in
> reclaim throughput and workload/sys performance improvements.
> 
> The earlier patches on compress batching deployed multiple IAA compress
> engines for compressing up to SWAP_CRYPTO_SUB_BATCH_SIZE pages within a
> large folio that is being stored in zswap_store(). This patch further
> propagates the efficiency improvements demonstrated with IAA "batching
> within folios", to vmscan "batching of folios" which will also use
> batching within folios using the extensible architecture of
> the __zswap_store_batch_core() procedure added earlier, that accepts
> an array of folios.

...

> +static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
> +{
> +}
> +
>  static inline bool zswap_store(struct folio *folio)
>  {
>  	return false;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48..b8d6b599e9ae 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2064,6 +2064,15 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= (void *)&page_cluster_max,
>  	},
> +	{
> +		.procname	= "compress-batchsize",
> +		.data		= &compress_batchsize,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
Why not use proc_douintvec_minmax? These are the reasons I think you
should use that (please correct me if I miss-read your patch):

1. Your range is [1,32] -> so no negative values
2. You are using the value to compare with an unsinged int
   (simc->nr_folios) in your `struct swap_in_memory_cache_cb`. So
   instead of going from int to uint, you should just do uint all
   around. No?
3. Using proc_douintvec_minmax will automatically error out on negative
   input without event considering your range, so there is less code
   executed at the end.

> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= (void *)&compress_batchsize_max,
> +	},
>  	{
>  		.procname	= "dirtytime_expire_seconds",
>  		.data		= &dirtytime_expire_interval,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a28d28b6b3ce..065db25309b8 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,6 +226,131 @@ static void swap_zeromap_folio_clear(struct folio *folio)
>  	}
>  }

...

Best

-- 

Joel Granados

