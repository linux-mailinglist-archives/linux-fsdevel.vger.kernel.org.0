Return-Path: <linux-fsdevel+bounces-15445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A09F88E875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019AE1F321FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7120136E08;
	Wed, 27 Mar 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEXhPEfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AF136E07;
	Wed, 27 Mar 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551836; cv=none; b=kY8Joro3x8m+K7h0+7mQV1qsyDjezTs0Lp+8fuJRMzZxerccG/HPbg3Ot4g/KSo+/xsADu6SdVse1CeDE7ounKu49iCr5xQE2jVIukTnwmvupOdBXbwFsdrzBX0JgGe1Ynky+ouPT4RT3KuwB2zGKK5XJyW65wAgRchkomnIBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551836; c=relaxed/simple;
	bh=hrWUIu1S4DXcjUN8so6lC+qmnHu3MFuX+fS4XcrdbO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+/c1nrc5YP44ieggjB0K6LSlxxyFwN+/xHnGVkweYS4ALJpnC04V1zplYtz96jeYOcbnF5/X0509zG8VRpiAtuoxMr1Y1sB/gi9k4pQXxffAoa7kkzSl7nhKq4c4VqGfjsKCT+tt2SpHacWf7raXjawnaFskC41KgFpKyoXmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEXhPEfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA5C433F1;
	Wed, 27 Mar 2024 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551835;
	bh=hrWUIu1S4DXcjUN8so6lC+qmnHu3MFuX+fS4XcrdbO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEXhPEfA8uvevGFpChDpATF2dMUKGWLnO5+bt+v7isVd7EjxTKF99rLKMlCoCY2Jk
	 LuBNcgxFXvcAgzKgdn7vsNZjHWI/5Sxa9eaRM8pqyajO+AVM0tR5DZkT4hNHK6CO2A
	 w6S39o/WjUkgG+q0WSK5KMJFjhLU7SRfEIgObn/GsY8ta+z1NArzQzAOYHOeZnYnjW
	 e38vh+dRtIDDS4AosbPwEtJyLKxcC3Cc6m+WHoxDCOw+3s9xMFHxTRa22EtgGEEj/f
	 8i2TtvEZt8J0HLpsg/flQsmKDxLTLrVkjOuog3osUis787HulTYqsgEXHQXq6rhSio
	 WTScQfYfAJsMw==
Date: Wed, 27 Mar 2024 17:03:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 3/3] mm: use "GUP-fast" instead "fast GUP" in
 remaining comments
Message-ID: <ZgQ1LtMUiaj5maDO@kernel.org>
References: <20240327130538.680256-1-david@redhat.com>
 <20240327130538.680256-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327130538.680256-4-david@redhat.com>

On Wed, Mar 27, 2024 at 02:05:38PM +0100, David Hildenbrand wrote:
> Let's fixup the remaining comments to consistently call that thing
> "GUP-fast". With this change, we consistently call it "GUP-fast".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/filemap.c    | 2 +-
>  mm/khugepaged.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 387b394754fa..c668e11cd6ef 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1810,7 +1810,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
>   * C. Return the page to the page allocator
>   *
>   * This means that any page may have its reference count temporarily
> - * increased by a speculative page cache (or fast GUP) lookup as it can
> + * increased by a speculative page cache (or GUP-fast) lookup as it can
>   * be allocated by another user before the RCU grace period expires.
>   * Because the refcount temporarily acquired here may end up being the
>   * last refcount on the page, any page allocation must be freeable by
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 38830174608f..6972fa05132e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1169,7 +1169,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * huge and small TLB entries for the same virtual address to
>  	 * avoid the risk of CPU bugs in that area.
>  	 *
> -	 * Parallel fast GUP is fine since fast GUP will back off when
> +	 * Parallel GUP-fast is fine since GUP-fast will back off when
>  	 * it detects PMD is changed.
>  	 */
>  	_pmd = pmdp_collapse_flush(vma, address, pmd);
> -- 
> 2.43.2
> 

-- 
Sincerely yours,
Mike.

