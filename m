Return-Path: <linux-fsdevel+bounces-40517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7DA2441A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C133AA4AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2D1F4E3E;
	Fri, 31 Jan 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lrsblSRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16651F4E3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355282; cv=none; b=SQ4h7nNFI1ZsjvAwWOmbdEDx105sUPTtWuLdfwNTqLTZoZIokF7HQtACAoeClkS4qg70kdh6Gk5hrd7m0gd6p2jc3jb45YZ/9KdIutKHvxamaRh9OZ3I5NSpNkSL8/OgyqezOQ2q6pWkPA7NIJhxJcNfNsAI48Olpft+p5FAEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355282; c=relaxed/simple;
	bh=8rgLxrw9qVMEYsbd46Aj4ZL+ZxD1p+A1WFzSXZgVMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1VoQSxyOqJQixyTYKgKj8fFbfUhC0R6sk7siI7lBApjPy/Eez4vnpU/pMwubrlkGC53fNOfKoDIDJu4UJDDfVMs0Q93cVgKIjDOFzQF+eOwFgb3pMB9NSkG2KxsXMwGZ1Cz3gTSk/orF93dJ2sXva1JiR5G8/JfnHYCzEIP30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lrsblSRz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 31 Jan 2025 12:27:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738355268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7BhC7vLoh7VtzfmXLESUsTqxQbrPIF6WzzF0QtgvNjc=;
	b=lrsblSRzlb3U+VBSguFAbcREpGVVQMrtG0UN6409a/fosRBCk4L0jLE6FhAQypEB2fAOSm
	N2A2tLZnVmRItxbwLORJuWRgDvy7Gkv2CDnNDSNBFBiBFJxyAqrUf95g9+GCYJkAmPEa8U
	BHDzzwIL0WWDQKyoESpoRnvF5jGA2nk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/11] drm/i915/gem: Convert __shmem_writeback() to
 folios
Message-ID: <gtknttjvbestmrulqy2w5afqzcdetnrrgcgcfz4fwqb5zg2p4e@pow2uwawcjt4>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
 <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 12:00:40PM +0200, Kirill A. Shutemov wrote:
> Use folios instead of pages.
> 
> This is preparation for removing PG_reclaim.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index fe69f2c8527d..9016832b20fc 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -320,25 +320,25 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
>  
>  	/* Begin writeback on each dirty page */
>  	for (i = 0; i < size >> PAGE_SHIFT; i++) {

With folio conversion, should the iteration step be folio_nr_pages()
instead of 1?

> -		struct page *page;
> +		struct folio *folio;
>  
> -		page = find_lock_page(mapping, i);
> -		if (!page)
> +		folio = filemap_lock_folio(mapping, i);
> +		if (!folio)
>  			continue;
>  
> -		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
> +		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio)) {
>  			int ret;
>  
> -			SetPageReclaim(page);
> -			ret = mapping->a_ops->writepage(page, &wbc);
> +			folio_set_reclaim(folio);
> +			ret = mapping->a_ops->writepage(&folio->page, &wbc);
>  			if (!PageWriteback(page))
> -				ClearPageReclaim(page);
> +				folio_clear_reclaim(folio);
>  			if (!ret)
>  				goto put;
>  		}
> -		unlock_page(page);
> +		folio_unlock(folio);
>  put:
> -		put_page(page);
> +		folio_put(folio);
>  	}
>  }
>  
> -- 
> 2.47.2
> 

