Return-Path: <linux-fsdevel+bounces-19817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D08C9F55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A326E280F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D571369B5;
	Mon, 20 May 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP17BERw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040328E7;
	Mon, 20 May 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217704; cv=none; b=P0xnJO20ivxEBKWFXBP3OvLcgvnxmwjegf86IWVRjhVSZrBHEn6JZrpqBQOvOnKjUsaFunGwYrsBw0gnXhXz6Jos1ERC53OI5OR64nTuSIH2rmixem+DHNU1rfPEvNYVXWxqIKc7qRdEGRuVa1gx83/qHnUskvKkeOJgReQdYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217704; c=relaxed/simple;
	bh=Oi/RYQGscIAWIJG1eFtbKOigRW+SxycxdQRM4QDt/nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYi9selkrWrLh+hY8CZjFUR/x0kIsFMtnxijcF1Tnh0cirR63/q3sVxNr/iFueNYD0dzMkVDyp3Bx/J4eMO8f4ModHYpW5AnZVftsgd3/jkNxowSq3t+cVA9Z0E5okvP7lVsf+nVXEVjPlNzPyKHZB759xNnLx3oLFCaUtIMdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP17BERw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3D4C32786;
	Mon, 20 May 2024 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716217703;
	bh=Oi/RYQGscIAWIJG1eFtbKOigRW+SxycxdQRM4QDt/nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qP17BERwdasNFuOebOeiXdQ+ao4yA6ICyEMCHEoZWX3xoujZjQiho2X1thydTC6+r
	 K49zgkTAs6y3H0iqBUnjJY7lpklsF7bhYYPpc7cyRNekYfr8G/5Bb4a4C9mpX+WDl4
	 B0Bv8T8dGWyP7kld47/MKyVDXRj6ppWfkE4flZcWdGbJrAHIbv/wz16PK1fahD/8Pa
	 HrxeBpN2Y0eLuEYFknht5CFsTuGvZ+DWH3s0m43AKio63Atshr5cO5cvTCplG+8rhA
	 sZHEPylznKO6vVv0B5iRciSzWgbg7Y2sMD9iZeR+sknLTHSRmxOUIZ0OuEkZA4lCme
	 GYzaGKmLVPx4A==
Date: Mon, 20 May 2024 08:08:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: Re: [PATCH v3] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-ID: <20240520150823.GA25518@frogsfrogsfrogs>
References: <20240520105525.2176322-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520105525.2176322-1-xu.yang_2@nxp.com>

On Mon, May 20, 2024 at 06:55:25PM +0800, Xu Yang wrote:
> Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
> iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
> mapping doesn't support large folio, only one page of maximum 4KB will
> be created and 4KB data will be writen to pagecache each time. Then,
> next 4KB will be handled in next iteration. This will cause potential
> write performance problem.
> 
> If chunk is 2MB, total 512 pages need to be handled finally. During this
> period, fault_in_iov_iter_readable() is called to check iov_iter readable
> validity. Since only 4KB will be handled each time, below address space
> will be checked over and over again:
> 
> start         	end
> -
> buf,    	buf+2MB
> buf+4KB, 	buf+2MB
> buf+8KB, 	buf+2MB
> ...
> buf+2044KB 	buf+2MB
> 
> Obviously the checking size is wrong since only 4KB will be handled each
> time. So this will get a correct chunk to let iomap work well in non-large
> folio case.
> 
> With this change, the write speed will be stable. Tested on ARM64 device.
> 
> Before:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)
> 
> After:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)
> 
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - fix address space description in message
> Changes in v3:
>  - adjust 'chunk' and add mapping_max_folio_size() in header file
>    as suggested by Matthew
>  - add write performance results in commit message
> ---
>  fs/iomap/buffered-io.c  |  2 +-
>  include/linux/pagemap.h | 37 ++++++++++++++++++++++++-------------
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 41c8f0c68ef5..c5802a459334 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -898,11 +898,11 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	loff_t length = iomap_length(iter);
> -	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iter->pos;
>  	ssize_t total_written = 0;
>  	long status = 0;
>  	struct address_space *mapping = iter->inode->i_mapping;
> +	size_t chunk = mapping_max_folio_size(mapping);
>  	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
>  
>  	do {
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c5e33e2ca48a..6be8e22360f1 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -346,6 +346,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  	m->gfp_mask = mask;
>  }
>  
> +/*
> + * There are some parts of the kernel which assume that PMD entries
> + * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> + * limit the maximum allocation order to PMD size.  I'm not aware of any
> + * assumptions about maximum order if THP are disabled, but 8 seems like
> + * a good order (that's 1MB if you're using 4kB pages)
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define MAX_PAGECACHE_ORDER	8
> +#endif
> +
>  /**
>   * mapping_set_large_folios() - Indicate the file supports large folios.
>   * @mapping: The file.
> @@ -372,6 +385,17 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
>  		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>  }
>  
> +/*
> + * Get max folio size in case of supporting large folio, otherwise return
> + * PAGE_SIZE.

Minor quibble -- the comment doesn't need to restate what the function
does because we can see that in the code below.

/* Return the maximum folio size for this pagecache mapping, in bytes. */

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> + */
> +static inline size_t mapping_max_folio_size(struct address_space *mapping)
> +{
> +	if (mapping_large_folio_support(mapping))
> +		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
> +	return PAGE_SIZE;
> +}
> +
>  static inline int filemap_nr_thps(struct address_space *mapping)
>  {
>  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
> @@ -530,19 +554,6 @@ static inline void *detach_page_private(struct page *page)
>  	return folio_detach_private(page_folio(page));
>  }
>  
> -/*
> - * There are some parts of the kernel which assume that PMD entries
> - * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> - * limit the maximum allocation order to PMD size.  I'm not aware of any
> - * assumptions about maximum order if THP are disabled, but 8 seems like
> - * a good order (that's 1MB if you're using 4kB pages)
> - */
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> -#else
> -#define MAX_PAGECACHE_ORDER	8
> -#endif
> -
>  #ifdef CONFIG_NUMA
>  struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
>  #else
> -- 
> 2.34.1
> 
> 

