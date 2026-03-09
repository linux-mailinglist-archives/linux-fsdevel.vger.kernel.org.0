Return-Path: <linux-fsdevel+bounces-79786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCZmJ5vSrmm1JAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:00:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CA23A35B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 15:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0994302F68A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF593CE4B2;
	Mon,  9 Mar 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovj5osbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9A38F948;
	Mon,  9 Mar 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064822; cv=none; b=jOXFqjCuwhTlf3hPDgTzHEWJ7jM7CBatopmxNBz5mh++BmU5O8LytrVWY+C4PGx3+RODzEWYsbClaPZ9bLu/3t6Qv5Q3yyh/+Lrgcde9MDAxkaHgxxZNZjBPvu7i8rtswcjChvRcMUb3ou1becz4WQWb9Fsggradi6amm6lE2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064822; c=relaxed/simple;
	bh=DnCTxrCceZEz1a9g0WegA+3Sbf1oc314HptMlIzKbcc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MhqisUpAl/LiL53bZYCbEKDfqqmdPF3k35VC9umOegXD915Z/sMLbdH9nsyZZRqqWMM4drcK30SqJkKxPL9gQ5jI6otgDJaCH2FmO2Oenke0kh+b7sMN+PoCanqJuoVoRLXi/kCD7Z7TTVzwUWKzB8GDQc2yo5d3bJpPRADR6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovj5osbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0526AC4CEF7;
	Mon,  9 Mar 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064822;
	bh=DnCTxrCceZEz1a9g0WegA+3Sbf1oc314HptMlIzKbcc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ovj5osbHOQZAbykrOKjaNKiC/PPZQXDRw1nyH+1XViznnSZDCqkeDx5eL9quBIBsQ
	 UJC+r+PeVEAN8FjGoAUaaUnJPFZsycuEXyK1aLyYFm/GX3yiwe1Fbikx5wo5UJMDLV
	 t10Ji3OWaEXZKc4PSXFCVEo0FVKQnUg5SUgfFK053iSmBp33N2MsYc/DSRmpr/4Jsv
	 vq+RV1XC7qsxFY0uDaafX1ZuQj6Fx7MFR86Q1orM8qJtHBkOGLsO8FwPp2RBLLZbjp
	 8xvRNFuZc0up6rzLjRwgdBlNLKCUbwfCpB6EwHAdTu2Vw3T5Q9uPTXbGs9bbimOBva
	 DxPEH+dJN/kWQ==
Message-ID: <0a25d83b-c6ea-4230-a89d-1f496b91764c@kernel.org>
Date: Mon, 9 Mar 2026 15:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: vbabka@kernel.org
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shicenci@gmail.com,
 cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
 viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
References: <aa5NmA25QsFDMhof@hyeyoo>
 <20260309072219.22653-1-harry.yoo@oracle.com>
In-Reply-To: <20260309072219.22653-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 211CA23A35B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79786-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,cmpxchg.org,linux.dev,kvack.org,gmail.com,gentwo.org,google.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 08:22, Harry Yoo wrote:
> obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> array from the same cache, to avoid creating slabs that are never freed.
> 
> There is one mistake that returns the original size when memory
> allocation profiling is disabled. The assumption was that
> memcg-triggered slabobj_ext allocation is always served from
> KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> allocation is served from normal kmalloc. This is because kmalloc_type()
> prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> KMALLOC_RECLAIM with KMALLOC_NORMAL.

Hm that's suboptimal (leads to sparsely used obj_exts in normal kmalloc
slabs) and maybe separately from this hotfix we could make sure that with
SLUB_TINY, __GFP_ACCOUNT is preferred going forward?

> As a result, the recursion guard is bypassed and the problematic slabs
> can be created. Fix this by removing the mem_alloc_profiling_enabled()
> check entirely. The remaining is_kmalloc_normal() check is still
> sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> avoid bumping the size if it's not.
> 
> Without SLUB_TINY, no functional change intended.
> With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> now allocate a larger array if the sizes equal.
> 
> Reported-by: Zw Tang <shicenci@gmail.com>
> Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
> Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Added to slab/for-next-fixes, thanks!

> ---
> 
> Zw Tang, could you please confirm that the warning disappears
> on your test environment, with this patch applied?
> 
>  mm/slub.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 20cb4f3b636d..6371838d2352 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
>  	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
>  	struct kmem_cache *obj_exts_cache;
>  
> -	/*
> -	 * slabobj_ext array for KMALLOC_CGROUP allocations
> -	 * are served from KMALLOC_NORMAL caches.
> -	 */
> -	if (!mem_alloc_profiling_enabled())
> -		return sz;
> -
>  	if (sz > KMALLOC_MAX_CACHE_SIZE)
>  		return sz;
>  
> 
> base-commit: 6432f15c818cb30eec7c4ca378ecdebd9796f741


