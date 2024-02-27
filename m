Return-Path: <linux-fsdevel+bounces-12933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA20868CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1751F23528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE6137C4C;
	Tue, 27 Feb 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="j8N+B2rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE854BF6;
	Tue, 27 Feb 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028413; cv=none; b=HCJTJ1uMWOMzH7ypoZ91dekDd7PK14TCgaXsBtm+E2Bba9DE+6A1bbou8COoJM04ZHom5bE5Vd1w30BhWXGqPeuUvL59R+Junb5ujbJGfZNUjLZrj3nN247VgBJqD3mX45BnMXge8t26GgZGxvEI3idSDcjR+1NjudsKs+o1TKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028413; c=relaxed/simple;
	bh=7u0x9ez1yMCB7JX91p3n82D4CUmjf1MNdgM4EC09iUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leeU0tQlqPu3x8e7cuZsDKQh3FxWlITbgNQPkqtLqRxUISZMVYISknLIjoD4sAFy/s07hcio+vdUsA1DPNQTJ7zmaRBlzzkdlDykYXg6qbTnrijXnC7RXCeYbGE2hISFb2T0t8xg1ZtFmHaIPn5iae2vyNkxemPq8JUAQOciIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=j8N+B2rP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkY6p279pz9sQT;
	Tue, 27 Feb 2024 11:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709028402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GPizpXQfLZMMYkc4+cJdFUeRkcKBpv3GClb5bK+Zygo=;
	b=j8N+B2rP1wM2vqfcQ5wXsuK6VWRk3AETdPUfaEKIuzJtLXSdXO5bdkXIamNLmxiB91c1hy
	gIuslA4/0417HwlXiOU/fq7GpBzCLIV3lITwTvK8CTLO54VdJFocmMQ6aeLbvmzuwk9O9z
	NZGjEV8r/FP+HlnRpRmWJeiHrpGKy4mVBOhGK+1zvx+7zLPragr4/t/Wevbcxz+Fih80kO
	k+WTFm8AAfYxrVFMc63ZFxAWd6WVuthoyIzksqNZWDDugScrWqtjaUnK3pciOD3eGgR4NY
	XfCyKRA3uDcpwd4SG7Ja0wpC/a5s6PEK5ftYa5sr91MdQ+wbe+5pKT3I7MUxZA==
Date: Tue, 27 Feb 2024 11:06:37 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, chandan.babu@oracle.com, 
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, 
	djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 03/13] filemap: align the index to mapping_min_order in
 the page cache
Message-ID: <37kubwweih4zwvxzvjbhnhxunrafawdqaqggzcw6xayd6vtrfl@dllnk6n53akf>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-4-kernel@pankajraghav.com>
 <Zdyi6lFDAHXi8GPz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdyi6lFDAHXi8GPz@casper.infradead.org>
X-Rspamd-Queue-Id: 4TkY6p279pz9sQT

On Mon, Feb 26, 2024 at 02:40:42PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 10:49:26AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Supporting mapping_min_order implies that we guarantee each folio in the
> > page cache has at least an order of mapping_min_order. So when adding new
> > folios to the page cache we must ensure the index used is aligned to the
> > mapping_min_order as the page cache requires the index to be aligned to
> > the order of the folio.
> 
> This seems like a remarkably complicated way of achieving:
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5603ced05fb7..36105dad4440 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2427,9 +2427,11 @@ static int filemap_update_page(struct kiocb *iocb,
>  }
>  
>  static int filemap_create_folio(struct file *file,
> -		struct address_space *mapping, pgoff_t index,
> +		struct address_space *mapping, loff_t pos,
>  		struct folio_batch *fbatch)
>  {
> +	pgoff_t index;
> +	unsigned int min_order;
>  	struct folio *folio;
>  	int error;
>  
> @@ -2451,6 +2453,8 @@ static int filemap_create_folio(struct file *file,
>  	 * well to keep locking rules simple.
>  	 */
>  	filemap_invalidate_lock_shared(mapping);
> +	min_order = mapping_min_folio_order(mapping);
> +	index = (pos >> (min_order + PAGE_SHIFT)) << min_order;

That is some cool mathfu. I will add a comment here as it might not be
that obvious to some people (i.e me).

Thanks.

>  	error = filemap_add_folio(mapping, folio, index,
>  			mapping_gfp_constraint(mapping, GFP_KERNEL));
>  	if (error == -EEXIST)
> @@ -2511,8 +2515,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
> -		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
>  		if (err == AOP_TRUNCATED_PAGE)
>  			goto retry;
>  		return err;

