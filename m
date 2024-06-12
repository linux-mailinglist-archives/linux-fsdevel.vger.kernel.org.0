Return-Path: <linux-fsdevel+bounces-21563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383B905BB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B4D285267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E582893;
	Wed, 12 Jun 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HCmF8r2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88E381AF;
	Wed, 12 Jun 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219307; cv=none; b=U4/J/rCoWJLu5mR+IgwCrWyueGAHYYraCb9XCX4JDVXBjeGh4eE+qW2E2VAglqf3xEhmdS4Eo+oeL0J6sunBUr5i2k78q7SyJteQa3UYZVklKqyk2bFciTbGhSBrAUBKvcgXRrAcdt6LTIRe4ayA+uAQJkFkGKrMvKyUh+YirPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219307; c=relaxed/simple;
	bh=acyp+foR3H6xaVXmAsc6xlFxbLgR9ZZPxI1Etk5jNaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9J+CKB+DhlLuZEu9KJNYyfTOcRO+b3KmopfxpIF61bB9QvF+Z6DWrHpkuJfQOOYXmC00d4H1drgkjxKTECNMbrjRlEnJtGe69aIwQRrQGGHLqygefSX6ayjwoJyHs6XJv+geVFHVSnqfk/2oCIkXSn7G0kVyoqR3yzmM4BWA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HCmF8r2F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nXMsYCyv4Yf7/Yu0L4W/RILlfgsgIycAWX2uQcsZwVg=; b=HCmF8r2FVSCYuICzIMuXFI/Cci
	kfi3EelJoIlhXTo027+7qAg8KPfT+I8Y9B1pRhU/mfiGb2/y88pqAAClO7sJERJU2KbJU4JuCfjvM
	aOjxzUtwo/hGHToL7VI98vwE3CbIyciALaQDc+hY5E5JxUvAgIqEZh23bB7efTVtkT4TYhHn6K2ja
	WWZBTD48mR+KKa8ou0/C4UJ7Iuo+E4fi0FpmuWZ9qC0zkiXRWyaS6V4FMxJT4Hs9yKOdHnquLTIdo
	xHtqx8pyTEu+jI9shrlDU3fAIUNfdDwY1VSzAr+iRxuMZgfSQk6riQ8PTkbEvW64WEnPlobIvlbqL
	fnSlGl7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHTKR-0000000F0Aj-1j7U;
	Wed, 12 Jun 2024 19:08:15 +0000
Date: Wed, 12 Jun 2024 20:08:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-7-kernel@pankajraghav.com>

On Fri, Jun 07, 2024 at 02:58:57PM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Usually the page cache does not extend beyond the size of the inode,
> therefore, no PTEs are created for folios that extend beyond the size.
> 
> But with LBS support, we might extend page cache beyond the size of the
> inode as we need to guarantee folios of minimum order. Cap the PTE range
> to be created for the page cache up to the max allowed zero-fill file
> end, which is aligned to the PAGE_SIZE.

I think this is slightly misleading because we might well zero-fill
to the end of the folio.  The issue is that we're supposed to SIGBUS
if userspace accesses pages which lie entirely beyond the end of this
file.  Can you rephrase this?

(from mmap(2))
       SIGBUS Attempted access to a page of the buffer that lies beyond the end
              of the mapped file.  For an explanation of the treatment  of  the
              bytes  in  the  page that corresponds to the end of a mapped file
              that is not a multiple of the page size, see NOTES.


The code is good though.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> An fstests test has been created to trigger this edge case [0].
> 
> [0] https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/filemap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8bb0d2bc93c5..0e48491b3d10 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3610,7 +3610,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct file *file = vma->vm_file;
>  	struct address_space *mapping = file->f_mapping;
> -	pgoff_t last_pgoff = start_pgoff;
> +	pgoff_t file_end, last_pgoff = start_pgoff;
>  	unsigned long addr;
>  	XA_STATE(xas, &mapping->i_pages, start_pgoff);
>  	struct folio *folio;
> @@ -3636,6 +3636,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		goto out;
>  	}
>  
> +	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> +	if (end_pgoff > file_end)
> +		end_pgoff = file_end;
> +
>  	folio_type = mm_counter_file(folio);
>  	do {
>  		unsigned long end;
> -- 
> 2.44.1
> 

