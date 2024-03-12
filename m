Return-Path: <linux-fsdevel+bounces-14232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8139879BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CF5289357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C64142623;
	Tue, 12 Mar 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMHEXlN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA927BB0A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269579; cv=none; b=anFOBUMRc1e0QsrgS4XWikSeIa25d5IRpHLqF14EE2MB6NoaHbBjeAIU0aCQtaxX4FjsI3bgG+EuZwx22uo65710fWBVdnVEh9z9h4sAYwUOrovghjlWq/A2/KV8UlEaAVqBolpFlBv6K0rWUi18DYmQJ7FAeYB6x/3+fDuEsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269579; c=relaxed/simple;
	bh=NKg4Q71TmG2wl3jNVwI2w6kog2D0YPNFn53K+82hu64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMB40/CAY9z6k7G5ZVCagMiNmWyQN5/Xe2+QPsoJYYOzjQlAoe0U78oBAQlETOG1EE9zfU2ppZdtvBENGEfRSYx7zgNqBkUf+7SZtv0fSS4CVcFx3gprAp11OrEnN1g02lj4yAk8fpExlJzI1vCXhXOYeE4I1xbsrXzZESKWeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMHEXlN8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 11:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710269574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB9p4AvFVqG7BzTvwz43ZlsmGe2aR9Z38/ULirCZ1Xs=;
	b=aMHEXlN8b45FtQM0pRTQ8DM07syqKxAPvaKz0ABqgotLq+deoNr8afEOlc6CKRZ2v0k9E6
	a3P5y8gz/TOouO5c09EhY0Rs9i2czqGoJGzyZDMPGbY0GJc2E1dpz830jhg8Df+eUWarjv
	ks8+DS5cwsk8Ga5QHoEc6NIZLTd/L7k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] mm, slab: move memcg charging to post-alloc hook
Message-ID: <ZfCkfpogPQVMZnIG@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-slab-memcg-v1-1-359328a46596@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 06:07:08PM +0100, Vlastimil Babka wrote:
> The MEMCG_KMEM integration with slab currently relies on two hooks
> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
> to the allocated object(s).
> 
> As Linus pointed out, this is unnecessarily complex. Failing to charge
> due to memcg limits should be rare, so we can optimistically allocate
> the object(s) and do the charging together with assigning the objcg
> pointer in a single post_alloc hook. In the rare case the charging
> fails, we can free the object(s) back.
> 
> This simplifies the code (no need to pass around the objcg pointer) and
> potentially allows to separate charging from allocation in cases where
> it's common that the allocation would be immediately freed, and the
> memcg handling overhead could be saved.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Nice cleanup, Vlastimil!
Couple of small nits below, but otherwise, please, add my

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

 ---
>  mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
>  1 file changed, 77 insertions(+), 103 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..7022a1246bab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1897,23 +1897,36 @@ static inline size_t obj_full_size(struct kmem_cache *s)
>  	return s->size + sizeof(struct obj_cgroup *);
>  }
>  
> -/*
> - * Returns false if the allocation should fail.
> - */
> -static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> -					struct list_lru *lru,
> -					struct obj_cgroup **objcgp,
> -					size_t objects, gfp_t flags)
> +static bool __memcg_slab_post_alloc_hook(struct kmem_cache *s,
> +					 struct list_lru *lru,
> +					 gfp_t flags, size_t size,
> +					 void **p)
>  {
> +	struct obj_cgroup *objcg;
> +	struct slab *slab;
> +	unsigned long off;
> +	size_t i;
> +
>  	/*
>  	 * The obtained objcg pointer is safe to use within the current scope,
>  	 * defined by current task or set_active_memcg() pair.
>  	 * obj_cgroup_get() is used to get a permanent reference.
>  	 */
> -	struct obj_cgroup *objcg = current_obj_cgroup();
> +	objcg = current_obj_cgroup();
>  	if (!objcg)
>  		return true;
>  
> +	/*
> +	 * slab_alloc_node() avoids the NULL check, so we might be called with a
> +	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
> +	 * the whole requested size.
> +	 * return success as there's nothing to free back
> +	 */
> +	if (unlikely(*p == NULL))
> +		return true;

Probably better to move this check up? current_obj_cgroup() != NULL check is more
expensive.

> +
> +	flags &= gfp_allowed_mask;
> +
>  	if (lru) {
>  		int ret;
>  		struct mem_cgroup *memcg;
> @@ -1926,71 +1939,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  			return false;
>  	}
>  
> -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
> +	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
>  		return false;
>  
> -	*objcgp = objcg;
> +	for (i = 0; i < size; i++) {
> +		slab = virt_to_slab(p[i]);

Not specific to this change, but I wonder if it makes sense to introduce virt_to_slab()
variant without any extra checks for this and similar cases, where we know for sure
that p resides on a slab page. What do you think?

