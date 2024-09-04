Return-Path: <linux-fsdevel+bounces-28475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A217E96B057
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 07:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DC1F2622C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653D82863;
	Wed,  4 Sep 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8QpU5kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B47433A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426762; cv=none; b=MCfDYSN4//NetI+m7y59VyvcOs8PIlWVbDjRRxxN+rTu8dXSCin+z9dw44ISJ3VnwXcSOcF7asppobGIoAen3llP8cuYfmCCabvPfqptQtVhxjpVVMzqqFQpwAMo+V1zs0Zm6DChETFrAEORitPtQNSAKfuhUV/FdN5JTOvd6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426762; c=relaxed/simple;
	bh=GXFWYq12M7jhDfSzBGBOkv4zE3MWpY6bG8JUUY369Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXX9RsOSWmmg6Ynrt61mikV6ph2v1bHht0YfZGrehrIwavoDS8SBG7PyDcell0ClU7oRlzFFNaTEXbIgjNG+skt+5ml52s14014tRGF0nGk8dTYyYcLZl5Jwcok8RHL1j8wIVRYR1AIQPLvtRknxEVxOSBFx5aLVQYfpi7frTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8QpU5kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5CC4CEC2;
	Wed,  4 Sep 2024 05:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725426760;
	bh=GXFWYq12M7jhDfSzBGBOkv4zE3MWpY6bG8JUUY369Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8QpU5kZoR4R4obOW+wGLt1u0bVapKFaaHW/zhK1GP2/yXAtvQYSjSYI3j0hXOfEU
	 SLMsHe6+kKWGj8xu2jT90WpNgf8gnw3gfMYDSLpqi+RnQrBPWJbVVdQKepAdsM2f0X
	 amrPznZE9O2/6jAb3Qj5vaVjfs4fWPMVaA3883ilIeJD99b5sudPDpobgFjDbQRpJq
	 jjDkx1l/AsFGZHC0LHHDyWmDMXcIgRpgDld/nCIzyWGvmu9W0NHS7lTOPKTXSa54FO
	 vwakGWaQS71ZM8yE90jNvvA+84sxZjL8IS++a7EP4SU28bZJvs4CVBiVUBJYmtvneV
	 wMIfwkvnJ0GCQ==
Date: Wed, 4 Sep 2024 08:09:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 11/15] slab: port KMEM_CACHE_USERCOPY() to struct
 kmem_cache_args
Message-ID: <Ztfroyuk8TPOy37i@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-11-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-11-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:52PM +0200, Christian Brauner wrote:
> Make KMEM_CACHE_USERCOPY() use struct kmem_cache_args.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/slab.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d9c2ed5bc02f..aced16a08700 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -294,12 +294,14 @@ int kmem_cache_shrink(struct kmem_cache *s);
>   * To whitelist a single field for copying to/from usercopy, use this
>   * macro instead for KMEM_CACHE() above.
>   */
> -#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)			\
> -		kmem_cache_create_usercopy(#__struct,			\
> -			sizeof(struct __struct),			\
> -			__alignof__(struct __struct), (__flags),	\
> -			offsetof(struct __struct, __field),		\
> -			sizeof_field(struct __struct, __field), NULL)
> +#define KMEM_CACHE_USERCOPY(__struct, __flags, __field)						\
> +	__kmem_cache_create_args(#__struct, sizeof(struct __struct),				\
> +			&(struct kmem_cache_args) {						\
> +				.align		= __alignof__(struct __struct),			\
> +				.useroffset	= offsetof(struct __struct, __field),		\
> +				.usersize	= sizeof_field(struct __struct, __field),	\
> +				.ctor		= NULL,						\
> +			}, (__flags))
>  
>  /*
>   * Common kmalloc functions provided by all allocators
> 
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

