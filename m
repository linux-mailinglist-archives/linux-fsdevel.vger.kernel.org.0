Return-Path: <linux-fsdevel+bounces-20022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26D8CC7C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 22:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B490B1F20FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0E146001;
	Wed, 22 May 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IdFLD86Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AF41A80;
	Wed, 22 May 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410475; cv=none; b=r8HQgtxzPLWkkIKBo4tGaxB589jSwSHxq66VqSSuZDVpl1N53n0DiAbTfPH+w4wYxdcHEWNj7olGu+TxIjLOB2t8ZEfGa8JoAX16Ol0Rdyqo85YrzCpU0/0b8SmliSvGFWohp//L4nCm0hz8/A1Ef0E5idcICqPt4X0E6J8klns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410475; c=relaxed/simple;
	bh=NZsrz9PLoulYtLMOSlsyCu3RUdCjnta2LLVxU7X+m6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5RJDDIOcU32HP0DuikJ0pTdRyxCe7QHMkpdFM5zhYMSKUAXNIz6FDuoAhC4lm08oKzQ6aayGCmve5JNSIvYOtqOf/G3UxK/aRXDb304piCrU+lrq+9d9BrXehgVKMNNMKmbNtSFwIZUQAWscsEa4ETv15J/XghQ9DotkOmH8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IdFLD86Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JhVTKxKlyu0H6sYvRMYXIsYgq8stj205p+1EbJBz9Nk=; b=IdFLD86QKk36M995cjI8dOgkGL
	6MIp10Gj2YVuZ9ZDsjGB/QjgajsSalXLRME3uzWHLJyw6us6C/H+n3/7VX+qh1/VVxs5E3upOXoA9
	rYREYxGPwRumC+sjsnZJCAdiMaPvVFQBTBeCZOilk8hHrK1tQAdsLCEhSaeK/k6CCg5xpGqzZ8JFJ
	31sH51odVPgs+Nc0CED1/i/GjyMWfQUelirmNX8Z1O+8t7e+YHS10ONd4wDcALqhrxCAtw2iDzlMf
	sViRcIXjWhXewgWq86ryYosRaARYBwN9f+fXJyRHh0nfzPhMf1veUXZqVVo5taBAOaWdePeJVBOBc
	XKztxpbA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9slq-000000010ny-1ySA;
	Wed, 22 May 2024 20:41:10 +0000
Date: Wed, 22 May 2024 21:41:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: trondmy@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] filemap: Return the error in do_read_cache_page()
Message-ID: <Zk5YZqwrBptULWO0@casper.infradead.org>
References: <20240522203115.27252-1-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522203115.27252-1-trondmy@kernel.org>

On Wed, May 22, 2024 at 04:31:14PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If the call to do_read_cache_folio() returns an error, then we should
> pass that back to the caller of do_read_cache_page().

this patch is a no-op.  it generates exactly the same code.
only now it doesn't have the '&folio->page' signature that lets everyone
know it's part of the compat code.

> Fixes: 539a3322f208 ("filemap: Add read_cache_folio and read_mapping_folio")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 30de18c4fd28..8f3b3604f73b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3812,7 +3812,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
>  
>  	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
>  	if (IS_ERR(folio))
> -		return &folio->page;
> +		return ERR_CAST(folio);
>  	return folio_file_page(folio, index);
>  }
>  
> -- 
> 2.45.1
> 

