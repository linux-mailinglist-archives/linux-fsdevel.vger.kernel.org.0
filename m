Return-Path: <linux-fsdevel+bounces-20075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF38CDBBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 23:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BA01C2048C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B762127E06;
	Thu, 23 May 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMjxjrtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7B84D04;
	Thu, 23 May 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498547; cv=none; b=iGPMLIRVqxK69h8geOiezgMrndccsY2wrbhEq+9jYnBg9JIrm2wHFKsmXlZKmilcgdY0HvdXid3ZaANt8r67AqOdPqunDr2GfbgS1nJEvWcb2qQZEULdFvPU34RfrSQOQh3LDTnPfu6mkepX3tmx/tNvXPf6oZvpoEi9Qkw0kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498547; c=relaxed/simple;
	bh=CuLd6TYGiS2+rBvn4z08Wn3+YNLIR/6ODCNpJdMqEg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMltebJN6H63TqZTl/xP3hBF/LP+2zMS1/2sp1+vKGj5FQQDtmLHnaI5LIp17w03F8gzcPZndBCYgjJBt6nwNT9x85RFApTOO7qR/ZxnTGOqj1m0N1o1tu30AdKAqAOo3yFNuPSFDndIAeboalh0uuhZ39NtrMLNMY9wCREXipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMjxjrtH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kfXLI35AfLCSFV6qQpB+s4UJzywNe6zaOkdmoMWLhoA=; b=rMjxjrtHoKYBcGVQ1mLGX02Da9
	MhBSwsAUQz8UyEwOojru4LeYNEf9ECbRJHigOYDGFkoOutPwb5OD7MzcAH0D/wRqzwmQ6ZC4znrAY
	BsqS4JEms1QSmWH+SHakY/tLJjsKiLFL1ruP/8BTGu+tjyVi8wGgNUbxGODtUvxPQzggDDM9I/UC6
	783sO5NBSp44JcRpEpq34873WCE0VME4hQqZW9RXBXSi/EcCwlItSaPkjoPTy7HQncXWcJwM0N2oi
	iWFUAKV1hXtWwuog8XFzgRfMb7hPHCH2+2nZmpJ9pkrCrhjRamU06UWQd3jaiZpqximFG34AuMiE0
	/t/t7t8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAFgJ-00000002690-3zOP;
	Thu, 23 May 2024 21:09:00 +0000
Date: Thu, 23 May 2024 22:08:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Liu Wei <liuwei09@cestc.cn>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when
 io with IOCB_NOWAIT
Message-ID: <Zk-wa_GvvrxpX9kn@casper.infradead.org>
References: <20240513132339.26269-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513132339.26269-1-liuwei09@cestc.cn>

On Mon, May 13, 2024 at 09:23:39PM +0800, Liu Wei wrote:
> After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),

If you're reporting problems with a particular commit, it's good form
to cc the people who actually wrote that commit.

> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
> process context will not be blocked.
> 
> However, if the device already has page cache in memory, EAGAIN will be
> returned. And even when trying to reissue the AIO with direct I/O and
> IOCB_NOWAIT again, we consistently receive EAGAIN.
> 
> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
> the same time.
> 
> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> ---
>  mm/filemap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 30de18c4fd28..1852a00caf31 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2697,8 +2697,15 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>  		/* we could block if there are any pages in the range */
> -		if (filemap_range_has_page(mapping, pos, end))
> +		if (filemap_range_has_page(mapping, pos, end)) {
> +			if (mapping_needs_writeback(mapping)) {
> +				__filemap_fdatawrite_range(mapping,
> +						pos, end, WB_SYNC_NONE);
> +			}
> +			invalidate_mapping_pages(mapping,
> +					pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>  			return -EAGAIN;
> +		}
>  	} else {
>  		ret = filemap_write_and_wait_range(mapping, pos, end);
>  		if (ret)
> -- 
> 2.42.1
> 
> 
> 

