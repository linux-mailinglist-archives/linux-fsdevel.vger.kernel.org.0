Return-Path: <linux-fsdevel+bounces-11397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2E853680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28733B22F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37D5FB95;
	Tue, 13 Feb 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbvtMQEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88577B661;
	Tue, 13 Feb 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842813; cv=none; b=PSlEzCedUv+3pb3t5bKUH6FToaylq/ys2eaKQwHxybReUldJ9U3M+T88+qbN71HsaZ4J1eFYcPt4ACHIUSwEg6uBe4XoGLVVZpmXmGnS7hILHSJiZPnL45HBQoYEUSfLLqwJrW29HQ8/pzJn+GuUVEWMQ1q6wgnObkRc2byokIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842813; c=relaxed/simple;
	bh=UIaYMvVbiLd0LqznaqT+7fzt02GVOhDFtbHk2fv+Cvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kklLofalgJhj7bo5TBOW6NWj59sS2DPMc1+MgkDcMYJ03zUFvxAMX1o03PDzhw/U710UocX3tJHKr0UMQ5V9mZB+ITI6xLAlOn2G82EcICIBRgK4HwDTPXuQDgDp/tfa/CU62LZDAhr/89HXRri9jUKvN8mQ0Yyc1XmprRxISHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbvtMQEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14340C433C7;
	Tue, 13 Feb 2024 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842813;
	bh=UIaYMvVbiLd0LqznaqT+7fzt02GVOhDFtbHk2fv+Cvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbvtMQEIsYfMfCVsu48mha6td20xWgCoxfEfdHrR28PhdR/EEXZAczp9nJLTGuEOw
	 Cyggj+LZP1Gesm6XvCoWq3Z44oxEygfxj/LqB93vTz0TwJxWp2903oApztblT8QQIV
	 6AS3fO0mgiI0RA1V40uHbEpz3TqrKVHiOgjBRokdR0Qa0YOzDNMb1VxDYTfaHCuamB
	 EmOkPO2stGG3NlwdocyPaIH6+a/4gKIV4hi6aNxYd8uuVXIDtZgjFmcp56w68bPqUE
	 9SHT4otc9aesnNdQBXbK5u4er+Bv1PrdIE/4XkINugqieDq3ZV/TC6NAr4QIC8iqGP
	 6OZG9toQ3vAJw==
Date: Tue, 13 Feb 2024 08:46:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 05/14] readahead: align index to mapping_min_order in
 ondemand_ra and force_ra
Message-ID: <20240213164652.GW6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-6-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:04AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Align the ra->start and ra->size to mapping_min_order in
> ondemand_readahead(), and align the index to mapping_min_order in
> force_page_cache_ra(). This will ensure that the folios allocated for
> readahead that are added to the page cache are aligned to
> mapping_min_order.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/readahead.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 4fa7d0e65706..5e1ec7705c78 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -315,6 +315,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
>  	struct file_ra_state *ra = ractl->ra;
>  	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>  	unsigned long max_pages, index;
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
>  
>  	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
>  		return;
> @@ -324,6 +325,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
>  	 * be up to the optimal hardware IO size
>  	 */
>  	index = readahead_index(ractl);
> +	if (!IS_ALIGNED(index, min_nrpages)) {
> +		unsigned long old_index = index;
> +
> +		index = round_down(index, min_nrpages);
> +		nr_to_read += (old_index - index);
> +	}
> +
>  	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
>  	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
>  	while (nr_to_read) {
> @@ -332,6 +340,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
>  		if (this_chunk > nr_to_read)
>  			this_chunk = nr_to_read;
>  		ractl->_index = index;
> +		VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
>  		do_page_cache_ra(ractl, this_chunk, 0);
>  
>  		index += this_chunk;
> @@ -344,11 +353,20 @@ void force_page_cache_ra(struct readahead_control *ractl,
>   * for small size, x 4 for medium, and x 2 for large
>   * for 128k (32 page) max ra
>   * 1-2 page = 16k, 3-4 page 32k, 5-8 page = 64k, > 8 page = 128k initial
> + *
> + * For higher order address space requirements we ensure no initial reads
> + * are ever less than the min number of pages required.
> + *
> + * We *always* cap the max io size allowed by the device.
>   */
> -static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
> +static unsigned long get_init_ra_size(unsigned long size,
> +				      unsigned int min_nrpages,
> +				      unsigned long max)
>  {
>  	unsigned long newsize = roundup_pow_of_two(size);
>  
> +	newsize = max_t(unsigned long, newsize, min_nrpages);
> +
>  	if (newsize <= max / 32)
>  		newsize = newsize * 4;
>  	else if (newsize <= max / 4)
> @@ -356,6 +374,8 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>  	else
>  		newsize = max;
>  
> +	VM_BUG_ON(newsize & (min_nrpages - 1));
> +
>  	return newsize;
>  }
>  
> @@ -364,14 +384,16 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>   *  return it as the new window size.
>   */
>  static unsigned long get_next_ra_size(struct file_ra_state *ra,
> +				      unsigned int min_nrpages,
>  				      unsigned long max)
>  {
> -	unsigned long cur = ra->size;
> +	unsigned long cur = max(ra->size, min_nrpages);
>  
>  	if (cur < max / 16)
>  		return 4 * cur;
>  	if (cur <= max / 2)
>  		return 2 * cur;
> +
>  	return max;
>  }
>  
> @@ -561,7 +583,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  	unsigned long add_pages;
>  	pgoff_t index = readahead_index(ractl);
>  	pgoff_t expected, prev_index;
> -	unsigned int order = folio ? folio_order(folio) : 0;
> +	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(ractl->mapping);
> +	unsigned int order = folio ? folio_order(folio) : min_order;
> +
> +	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
>  
>  	/*
>  	 * If the request exceeds the readahead window, allow the read to
> @@ -583,8 +609,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  	expected = round_down(ra->start + ra->size - ra->async_size,
>  			1UL << order);
>  	if (index == expected || index == (ra->start + ra->size)) {
> -		ra->start += ra->size;
> -		ra->size = get_next_ra_size(ra, max_pages);
> +		ra->start += round_down(ra->size, min_nrpages);
> +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
>  		ra->async_size = ra->size;
>  		goto readit;
>  	}
> @@ -603,13 +629,18 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  				max_pages);
>  		rcu_read_unlock();
>  
> +		start = round_down(start, min_nrpages);
> +
> +		VM_BUG_ON(folio->index & (folio_nr_pages(folio) - 1));
> +
>  		if (!start || start - index > max_pages)
>  			return;
>  
>  		ra->start = start;
>  		ra->size = start - index;	/* old async_size */
> +
>  		ra->size += req_size;
> -		ra->size = get_next_ra_size(ra, max_pages);
> +		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
>  		ra->async_size = ra->size;
>  		goto readit;
>  	}
> @@ -646,7 +677,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  
>  initial_readahead:
>  	ra->start = index;
> -	ra->size = get_init_ra_size(req_size, max_pages);
> +	ra->size = get_init_ra_size(req_size, min_nrpages, max_pages);
>  	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
>  
>  readit:
> @@ -657,7 +688,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  	 * Take care of maximum IO pages as above.
>  	 */
>  	if (index == ra->start && ra->size == ra->async_size) {
> -		add_pages = get_next_ra_size(ra, max_pages);
> +		add_pages = get_next_ra_size(ra, min_nrpages, max_pages);
>  		if (ra->size + add_pages <= max_pages) {
>  			ra->async_size = add_pages;
>  			ra->size += add_pages;
> @@ -668,6 +699,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>  	}
>  
>  	ractl->_index = ra->start;
> +	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
>  	page_cache_ra_order(ractl, ra, order);
>  }
>  
> -- 
> 2.43.0
> 
> 

