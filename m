Return-Path: <linux-fsdevel+bounces-12822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DC86797D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6592D29B1AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9F132C08;
	Mon, 26 Feb 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L/tRy2rX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC012C533;
	Mon, 26 Feb 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958859; cv=none; b=ZSowzjpuZqSFE4K5vtMhVdBdg3glFFox0/vSMOQVMbj70aUQ2Me0q9UG+jF3E9F3HH/qF3930Mtwak7vCU+wBoebn4rRCSqS4CnpZaOSLw7a+XSMSWkRqxxkJCfljzkP6DW9qPHT5phsAMX98Cd5LzyRolm7RcGzCAlTjxnZcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958859; c=relaxed/simple;
	bh=Vsn8pIp7vt+bUR9MZs+/TiYMnBtUQAaqJD1uA8+MiBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t96YBnAPJFx9+ulXdIJvbErGqu7KQ0qLSmxNNcG5w/jU9rrzVZQ0mtyceI7iM7bEMlalX/pU3D84+TfTPdykyRxd8C+FaZhjGWGVR3PVtPpM5xozk20froIlZ34C5VXKslN7TjsDSMPQrF7g6itbPp3WGP+Lz3qDqrdp+DnMJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L/tRy2rX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yza63Q+E0MQPCYS+BMi7MSICGP+bYwaIfeMJZhSmHAE=; b=L/tRy2rXVkixtFmv5H9i8Qe5nM
	Rkutf9gUoZz55MoYgGdoS2SLSelhnx5JIy6iVW9qOmBQwDO97pFD0E6gFMz+j/5zakLyUBbdjxKtd
	0f7tR03m2a/31EnhM9wx122E7iYxVtO6DqesPtXlMfvsd8drPWY3a4GhY+ZUUkupNqwJ7J9zD/uQj
	YGUkzB+jpyB8gLppfcIacfTh/cULtqx5UXA1wS4Wflt/BC0T/wGbFoJVtBPLINgK4+qVXv8nGt0l3
	Dpl4cGVzMdnG56AI4qqdd6rbuQpsRIGVFLF5Gs9uCTcDY3MN93UQoHIiiR/q8JRYAJqUiZ942gv8q
	ELe8gzUw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1recGT-0000000HQ83-33XC;
	Mon, 26 Feb 2024 14:47:33 +0000
Date: Mon, 26 Feb 2024 14:47:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, djwong@kernel.org,
	gost.dev@samsung.com, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 04/13] filemap: use mapping_min_order while allocating
 folios
Message-ID: <ZdykhSuPbe6knu89@casper.infradead.org>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-5-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:27AM +0100, Pankaj Raghav (Samsung) wrote:
> Add some additional VM_BUG_ON() in page_cache_delete[batch] and
> __filemap_add_folio to catch errors where we delete or add folios that
> has order less than min_order.

I don't understand why we need these checks in the deletion path.  The
add path, yes, absolutely.  But the delete path?

> @@ -896,6 +900,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  			}
>  		}
>  
> +		VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
> +				folio);

But I don't understand why you put it here, while we're holding the
xa_lock.  That seems designed to cause maximum disruption.  Why not put
it at the beginning of the function with all the other VM_BUG_ON_FOLIO?

> @@ -1847,6 +1853,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
> +	unsigned int min_order = mapping_min_folio_order(mapping);
> +
> +	index = mapping_align_start_index(mapping, index);

I would not do this here.

>  repeat:
>  	folio = filemap_get_entry(mapping, index);
> @@ -1886,7 +1895,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;

Put it here instead.

>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
> @@ -1912,8 +1921,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp_t alloc_gfp = gfp;
>  
>  			err = -ENOMEM;
> +			if (order < min_order)
> +				order = min_order;
>  			if (order > 0)
>  				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +
> +			VM_BUG_ON(index & ((1UL << order) - 1));

Then you don't need this BUG_ON because it's obvious you just did it.
And the one in filemap_add_folio() would catch it anyway.


