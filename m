Return-Path: <linux-fsdevel+bounces-70959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D94CAC84A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 09:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A185330378B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D81280A29;
	Mon,  8 Dec 2025 08:37:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496C255E43;
	Mon,  8 Dec 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183040; cv=none; b=WWgOoEbjIWfwierAZEA2zv1Qt/Na9tULSKjcVFXwN5HcJKpmPbn+SChQGzxImIoKaMES5zQ0FSbZ+iCodr0FjhoKnM0PEZHbhFfJie++ETwGkoSUUAM6CArgW2LQZbChqVafjI+5mF3IJkhgSyL3j9NfkTvbp2EbzHeCa2noWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183040; c=relaxed/simple;
	bh=9tI/dl1JDBfwMbM9NfR872I+RA21xb3rVGCE4aZ8elk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bcwk7DRYgrcK48IsSKWayFLqI3tRte/COOz0tcRSNAzd4zjiRaRq9Ok0HQsnkWFiLFpXeNokj+ZAQHkn5zUthG+2D4qYDTnuBdi4cLWcub1motIOCX/zMTjgaVVO27XEVok9uvvo3AQGh54A6x/2MyGELnBHxyYttmTNP4BDpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407A11691;
	Mon,  8 Dec 2025 00:37:10 -0800 (PST)
Received: from [10.164.18.59] (MacBook-Pro.blr.arm.com [10.164.18.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5D823F740;
	Mon,  8 Dec 2025 00:37:14 -0800 (PST)
Message-ID: <3813db02-118d-472f-a889-d58c9d01e736@arm.com>
Date: Mon, 8 Dec 2025 14:07:11 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@kernel.org, shardulsb08@gmail.com, janak@mpiricsoftware.com
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/12/25 7:56 pm, Shardul Bankar wrote:
> xas_create_range() is typically called in a retry loop that uses
> xas_nomem() to handle -ENOMEM errors. xas_nomem() may allocate a spare
> xa_node and store it in xas->xa_alloc for use in the retry.
>
> If the lock is dropped after xas_nomem(), another thread can expand the

Nit: "When the lock is dropped after xas_create_range()".

> xarray tree in the meantime. On the next retry, xas_create_range() can
> then succeed without consuming the spare node stored in xas->xa_alloc.
> If the function returns without freeing this spare node, it leaks.
>
> xas_create_range() calls xas_create() multiple times in a loop for
> different index ranges. A spare node that isn't needed for one range
> iteration might be needed for the next, so we cannot free it after each
> xas_create() call. We can only safely free it after xas_create_range()
> completes.
>
> Fix this by calling xas_destroy() at the end of xas_create_range() to
> free any unused spare node. This makes the API safer by default and
> prevents callers from needing to remember cleanup.
>
> This fixes a memory leak in mm/khugepaged.c and potentially other
> callers that use xas_nomem() with xas_create_range().
>
> Link: https://syzkaller.appspot.com/bug?id=a274d65fc733448ed518ad15481ed575669dd98c
> Link: https://lore.kernel.org/all/20251201074540.3576327-1-shardul.b@mpiricsoftware.com/ ("v3")
> Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>   v4:
>   - Drop redundant `if (xa_alloc)` around xas_destroy(), as xas_destroy()
>     already checks xa_alloc internally.
>   v3:
>   - Move fix from collapse_file() to xas_create_range() as suggested by Matthew Wilcox
>   - Fix in library function makes API safer by default, preventing callers from needing
>     to remember cleanup
>   - Use shared cleanup label that both restore: and success: paths jump to
>   - Clean up unused spare node on both success and error exit paths
>   v2:
>   - Call xas_destroy() on both success and failure
>   - Explained retry semantics and xa_alloc / concurrency risk
>   - Dropped cleanup_empty_nodes from previous proposal
>
>   lib/xarray.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9a8b4916540c..f49ccfa5f57d 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -744,11 +744,16 @@ void xas_create_range(struct xa_state *xas)
>   	xas->xa_shift = shift;
>   	xas->xa_sibs = sibs;
>   	xas->xa_index = index;
> -	return;
> +	goto cleanup;
> +
>   success:
>   	xas->xa_index = index;
>   	if (xas->xa_node)
>   		xas_set_offset(xas);
> +
> +cleanup:
> +	/* Free any unused spare node from xas_nomem() */
> +	xas_destroy(xas);
>   }
>   EXPORT_SYMBOL_GPL(xas_create_range);

Since there are other code paths doing this fashion of xas_create/xas_store followed by
calling xas_nomem till the former succeeds, I believe we should handle this in the caller -
for example, I believe we need to fix xa_store_range() as well? It does xas_create, then
drops the lock in the same fashion, and I believe we have no choice here but to handle it
in the caller - we should not put xas_destroy inside xas_create.

Although for this particular case, we have only one caller of xas_create_range, so this
is fine really.


>   

