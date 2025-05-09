Return-Path: <linux-fsdevel+bounces-48550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CDAB0FC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ED29C359D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8650A28E5EC;
	Fri,  9 May 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BFOgVJ5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F32750ED;
	Fri,  9 May 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784837; cv=none; b=F2AKFTz+uTwavoSEXXjq4tSkzsPMh2wk0Uf1eScammA9MKf/gH8vgXcITMZOojHnJI0lZircm6y2eoBXyJVc8N4VA/ZNecL4l/saoe4EuDjsAqeW8NDOgwEGxitcWTxB2kdyT5tlChpxq3mB4gqcOnI+fXztEmD4phm9io8jEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784837; c=relaxed/simple;
	bh=I9TbpTlB7dLQLcXD2Dzw3nOXOPOcmJvhLbMdcSlGPqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHNhPVXj/NzNTOT1Y4bNEcZRg5bB21TMsL0V/8s5TsvEpNN9P1M7cZXwQCnetSLOk3H7c2m+6QL/jO4HSSxFs3Fs7x52J6hZpG6+vG2npvlHgs/DN1S+ZtO+6tIdv5NTSkXv3i55TGVR1WGz5KcdDg8exC+UjAz5XN0VlezqjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BFOgVJ5+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zv4Hs2XlNz9tmm;
	Fri,  9 May 2025 12:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1746784825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKXgpxfD7mmRDEDKIXuu87HZmsIYrRD/fM7ub6mxn3U=;
	b=BFOgVJ5+QR381y/dIAleHjzFrncarnnRrLIvkfIuVBJoCzdGHilzSjyWwzigpb8OHgcL1S
	brnGWQm/AffVHiQ8fWgJSEzKrzFQOTwCa7uUcc5Sj+NyP7rCPavkdpOduPyEY6jc1fTF7k
	Tmpjpv7hBmtj4HJNLjriLMY6BU8xkEng5hcA2/M7NgpBKfgUvmXjOTj4HbGrCR/LlwcOtE
	6plgndT3N6J46arHCoY0b/igVj5RSLw8x63A/uUKfi97CNG4y69OOeNgxLufVsEM0oz3sJ
	W5dJQA+jmz7kuAPNFd0mAFoIBvHMfPZdw69jnMMtuQwTY17OqpGVMjAkhgp7og==
Date: Fri, 9 May 2025 12:00:09 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 3/5] mm/readahead: Make space in struct
 file_ra_state
Message-ID: <vyyxrpfhdpz6lg4frvafi2mxpgvlciianyhcfmcvli3yobguy4@zxy5n4pwgbo5>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-4-ryan.roberts@arm.com>
X-Rspamd-Queue-Id: 4Zv4Hs2XlNz9tmm

On Wed, Apr 30, 2025 at 03:59:16PM +0100, Ryan Roberts wrote:
> We need to be able to store the preferred folio order associated with a
> readahead request in the struct file_ra_state so that we can more
> accurately increase the order across subsequent readahead requests. But
> struct file_ra_state is per-struct file, so we don't really want to
> increase it's size.
> 
> mmap_miss is currently 32 bits but it is only counted up to 10 *
> MMAP_LOTSAMISS, which is currently defined as 1000. So 16 bits should be
> plenty. Redefine it to unsigned short, making room for order as unsigned
> short in follow up commit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

> ---
>  include/linux/fs.h |  2 +-
>  mm/filemap.c       | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..44362bef0010 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1042,7 +1042,7 @@ struct file_ra_state {
>  	unsigned int size;
>  	unsigned int async_size;
>  	unsigned int ra_pages;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  	loff_t prev_pos;
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b90cbeb4a1a..fa129ecfd80f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3207,7 +3207,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
>  	unsigned long vm_flags = vmf->vma->vm_flags;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> @@ -3275,7 +3275,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	struct file_ra_state *ra = &file->f_ra;
>  	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
> -	unsigned int mmap_miss;
> +	unsigned short mmap_miss;
>  
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
> @@ -3595,7 +3595,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
>  static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  			struct folio *folio, unsigned long start,
>  			unsigned long addr, unsigned int nr_pages,
> -			unsigned long *rss, unsigned int *mmap_miss)
> +			unsigned long *rss, unsigned short *mmap_miss)
>  {
>  	vm_fault_t ret = 0;
>  	struct page *page = folio_page(folio, start);
> @@ -3657,7 +3657,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  
>  static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>  		struct folio *folio, unsigned long addr,
> -		unsigned long *rss, unsigned int *mmap_miss)
> +		unsigned long *rss, unsigned short *mmap_miss)
>  {
>  	vm_fault_t ret = 0;
>  	struct page *page = &folio->page;
> @@ -3699,7 +3699,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	struct folio *folio;
>  	vm_fault_t ret = 0;
>  	unsigned long rss = 0;
> -	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> +	unsigned int nr_pages = 0, folio_type;
> +	unsigned short mmap_miss = 0, mmap_miss_saved;
>  
>  	rcu_read_lock();
>  	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> -- 
> 2.43.0
> 

