Return-Path: <linux-fsdevel+bounces-70301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C7C96366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBA33A2E30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF612F1FD7;
	Mon,  1 Dec 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ/EUarb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BD2D77EA;
	Mon,  1 Dec 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578384; cv=none; b=oDMbho611bjwRS7BU/YXPmk9oafPFXAP/IpJr5VjD7YBTGEexIlWLe58rqnVGdwCi9t0DtVFDmRaBi/F3mBjd5+CNyj1ZEa3gozjnbHfJvniEdakplhKo2Ow9rK66I2wfEDmnRWDn3ESkKzRpw28wTquEUC+Hkv1D8q1eR6eWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578384; c=relaxed/simple;
	bh=XYenxbNtRDcljVH7RQaYzSMIHfmS/eO9eGSsWEIrEb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0ekIY5ZJ/27h46br3nSZDdS93zLhFqhDfG6diorS2wlQE00ksTsfQOyjOdaQckF4cyefruoX6LxOqTbiKAQ7/L1p3x2TLV+yifuNGDEQ9btfhDyFA60R/YLyE0MbzAd29D36ulJXBxKoy3o1sJHfBwkcp3FI6J8pDKoKoZRb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ/EUarb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C698CC4CEF1;
	Mon,  1 Dec 2025 08:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764578384;
	bh=XYenxbNtRDcljVH7RQaYzSMIHfmS/eO9eGSsWEIrEb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQ/EUarbzUDm53fskUfuzSV7ydeutc4npZNqkjfZ7euWoVS1JbWShBeqv8bgcnexj
	 cCgULmAPJUzV2hyS4hSB7h4FoLRpkD2wsIKVwSn7SG9EfLCKmomCs4HLJ6l0ydkZ/C
	 OWJqHlghNne4mQq6cebNQe4TzWRpWJzWshpPcjCTNvCro1SKh4t/XAXVLAjoEhL3OP
	 5/rROsyMiFoBoNYQmi/OfZVxaiJYQQL8iElP2rlF/+tafkfkZM76SrYY1kh0QxS7yK
	 tFwgaM+CejsPS+/Z9P/ctPHrO2ww8Jk4bUVS29TPu+IySaIkl++y0tVaNfIjTYzSB+
	 TAw9YpFgFGt7g==
Message-ID: <57d5793d-2343-49b3-a30c-cd12dc40460d@kernel.org>
Date: Mon, 1 Dec 2025 09:39:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib: xarray: free unused spare node in
 xas_create_range()
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, willy@infradead.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: dev.jain@arm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shardulsb08@gmail.com, janak@mpiricsoftware.com
References: <7a31f01ac0d63788e5fbac15192c35229e1f980a.camel@mpiricsoftware.com>
 <20251201074540.3576327-1-shardul.b@mpiricsoftware.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251201074540.3576327-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 08:45, Shardul Bankar wrote:

Please don't post new versions as reply to old versions.

> xas_create_range() is typically called in a retry loop that uses
> xas_nomem() to handle -ENOMEM errors. xas_nomem() may allocate a spare
> xa_node and store it in xas->xa_alloc for use in the retry.
> 
> If the lock is dropped after xas_nomem(), another thread can expand the
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
> Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
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
>   lib/xarray.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 9a8b4916540c..a924421c0c4c 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -744,11 +744,17 @@ void xas_create_range(struct xa_state *xas)
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
> +	if (xas->xa_alloc)
> +		xas_destroy(xas);

The first thing xas_destroy() does is check whether xa_alloc is set.

I'd assume that the compiler is smart enough to inline xas_destroy() 
completely here, so likely the xa_alloc check here can just be dropped.


Staring at xas_destroy() callers, we only have a single one outside of 
lib: mm/huge_memory.c:__folio_split()

Is that one still required?

-- 
Cheers

David

