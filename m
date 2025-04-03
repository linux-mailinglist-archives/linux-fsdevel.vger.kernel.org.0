Return-Path: <linux-fsdevel+bounces-45661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D4CA7A7D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64ED188637A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0EB2512D3;
	Thu,  3 Apr 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XElAYKJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE82505BB;
	Thu,  3 Apr 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697316; cv=none; b=Yp05tpq43biNLYo3C4WFuYAKB6mM7nObGXNX67eHXXV/RHyLt+hnXDCiGK74wB7zBxTiQpR5UY4Ca3z058sfxkPoG36uTMY1mcpq9AdzYmb92Ogjpj36zK+qmL7IGeCdAVzffZuU3qH1Tx8tinZHwr/NZIOmEjHe80h54d5yxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697316; c=relaxed/simple;
	bh=hEwo2BARUEQeXAHpKtc6UfpXpgB0pd/FflGY/8PW2F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS2NbIHIZOPMBW+cemqBjEKBP+NPrQDGgykKWqnEpsvfZmcSX0isTHdWSw+FUWsCPPnI1KbpVx8PX9py4IaLEpCxgiiTCoe7SOF5IkQTWBxeaJ6j5aiNZAi4NsTGSX9OSaTIRtexjYfPlt9tbCCiLH7/KWgiYdUqedypwrrIRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XElAYKJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56612C4CEE3;
	Thu,  3 Apr 2025 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697315;
	bh=hEwo2BARUEQeXAHpKtc6UfpXpgB0pd/FflGY/8PW2F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XElAYKJ3FzgVQIEhT4DYu/b7dHiMk1PXDg2iUizmMtmFdEiKYsw5MjpA1UeJW907K
	 G+16RfNxz8JXAus7puijYLLjxqz3/hraDLyLRtqwdrx+SN8lFKcbdr14scqSdgLzM8
	 7udRXXsWgervZvBL/SQvSolHSkhBmdvt9jsge3Ox49/HQQXWI0ZvhPIwueNAQUqWR5
	 sGI/mYcQwkPr4mCN9EmnS6RnP6IcVUgPXFdvMAcROtBhsRXHUNABStNa2VLkMkW7lm
	 HhdMQm7JqOQ726K9eWU+1O+HG/OfMgT9q/thPRRHZRexf0DBbJQPXVtLSqcOxi3ASu
	 uH4tLFT+Tp5mw==
Date: Thu, 3 Apr 2025 09:21:50 -0700
From: Kees Cook <kees@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, joel.granados@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <202504030920.EB65CCA2@keescook>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-48K0OdNxZXcnkB@tiehlicka>

On Thu, Apr 03, 2025 at 09:43:39AM +0200, Michal Hocko wrote:
> There are users like xfs which need larger allocations with NOFAIL
> sementic. They are not using kvmalloc currently because the current
> implementation tries too hard to allocate through the kmalloc path
> which causes a lot of direct reclaim and compaction and that hurts
> performance a lot (see 8dc9384b7d75 ("xfs: reduce kvmalloc overhead for
> CIL shadow buffers") for more details).
> 
> kvmalloc does support __GFP_RETRY_MAYFAIL semantic to express that
> kmalloc (physically contiguous) allocation is preferred and we should go
> more aggressive to make it happen. There is currently no way to express
> that kmalloc should be very lightweight and as it has been argued [1]
> this mode should be default to support kvmalloc(NOFAIL) with a
> lightweight kmalloc path which is currently impossible to express as
> __GFP_NOFAIL cannot be combined by any other reclaim modifiers.
> 
> This patch makes all kmalloc allocations GFP_NOWAIT unless
> __GFP_RETRY_MAYFAIL is provided to kvmalloc. This allows to support both
> fail fast and retry hard on physically contiguous memory with vmalloc
> fallback.
> 
> There is a potential downside that relatively small allocations (smaller
> than PAGE_ALLOC_COSTLY_ORDER) could fallback to vmalloc too easily and
> cause page block fragmentation. We cannot really rule that out but it
> seems that xlog_cil_kvmalloc use doesn't indicate this to be happening.
> 
> [1] https://lore.kernel.org/all/Z-3i1wATGh6vI8x8@dread.disaster.area/T/#u
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Thanks for finding a solution for this! It makes way more sense to me to
kick over to vmap by default for kvmalloc users.

> ---
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b46f87662e71..2da40c2f6478 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4972,14 +4972,16 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>  	 * We want to attempt a large physically contiguous block first because
>  	 * it is less likely to fragment multiple larger blocks and therefore
>  	 * contribute to a long term fragmentation less than vmalloc fallback.
> -	 * However make sure that larger requests are not too disruptive - no
> -	 * OOM killer and no allocation failure warnings as we have a fallback.
> +	 * However make sure that larger requests are not too disruptive - i.e.
> +	 * do not direct reclaim unless physically continuous memory is preferred
> +	 * (__GFP_RETRY_MAYFAIL mode). We still kick in kswapd/kcompactd to start
> +	 * working in the background but the allocation itself.

I think a word is missing here? "...but do the allocation..." or
"...allocation itself happens" ?

-- 
Kees Cook

