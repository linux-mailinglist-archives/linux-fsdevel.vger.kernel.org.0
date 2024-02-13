Return-Path: <linux-fsdevel+bounces-11398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D292853688
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A4F28D8FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA8605AC;
	Tue, 13 Feb 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoO0smDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B485FF13;
	Tue, 13 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842824; cv=none; b=fp72kPNGgQvz3Ejk6vqnssM8VMtIxFzOXke4KLQjc61DoQdBRqlfh2GY3gjaLdfalghD+S/1acYb8R5kPHIM1lx8Gy8k+inJlvosUBH7c2QsZGKj45OVO8X00LJB8Gkz9alffiWKhYM9b0zwJ5UJY7pQzS9Dp5kl2wmWfkNum7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842824; c=relaxed/simple;
	bh=fZLzxiWiWqQTQTGcyFG3odxLRJgONwBOdACD0HVg7b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NplBjCdAy40XW2/8K7KAMq5AqJ2l/Amnq0odKBKocnjykXFSis86bjw5QOLWeYjUzKtV4H7yadLXxIns88OxgyIzwkI9vYEZhVZD7FwFBN9ZD+afNf5I/pharTYdn5Gvd1gC3n2mXN6JSRYMWCqE0ThvZLoZ4hwVTfMIn6iTSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoO0smDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C6CC433C7;
	Tue, 13 Feb 2024 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842823;
	bh=fZLzxiWiWqQTQTGcyFG3odxLRJgONwBOdACD0HVg7b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoO0smDcFbjVUaJydJooe2n0xA7HNBbrfT5nr/hwB/CJvoDIvNHE61hXMB+j9pp9C
	 AKFIWh5LT4H+FMMDdkbTgyqfmnmERNCSL+SJ8bJNbbACtV9YZiIKGtBvGnmppMqRl0
	 0hLJDQkPLYiGU/nGrBADDZk+X0nbto40y8dplPN/7dWAiCNIcCzsTMb8acukJHx9QT
	 IKpg1aBUkYXfOxDY7iH0Izo4xIp5JAL+PVnzRm/6dzBfGhRj86GCgyPabu4qu25ZcJ
	 1qZjj8wbBv/ZUbcwvd1yFwdkVWkbg0yC14O7+AmmAO4JCVwpZBWPbb6uZ4b+C2hUtA
	 eHRaar1QTSF6g==
Date: Tue, 13 Feb 2024 08:47:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 06/14] readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <20240213164702.GX6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-7-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-7-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:05AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Rework the loop in page_cache_ra_unbounded() to advance with
> the number of pages in a folio instead of just one page at a time.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/readahead.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 5e1ec7705c78..13b62cbd3b79 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -213,7 +213,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	struct address_space *mapping = ractl->mapping;
>  	unsigned long index = readahead_index(ractl);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> -	unsigned long i;
> +	unsigned long i = 0;
>  
>  	/*
>  	 * Partway through the readahead operation, we will have added
> @@ -231,7 +231,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */
> -	for (i = 0; i < nr_to_read; i++) {
> +	while (i < nr_to_read) {
>  		struct folio *folio = xa_load(&mapping->i_pages, index + i);
>  
>  		if (folio && !xa_is_value(folio)) {
> @@ -244,8 +244,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			 * not worth getting one just for that.
>  			 */
>  			read_pages(ractl);
> -			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			ractl->_index += folio_nr_pages(folio);
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  
> @@ -257,13 +257,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  			folio_put(folio);
>  			read_pages(ractl);
>  			ractl->_index++;
> -			i = ractl->_index + ractl->_nr_pages - index - 1;
> +			i = ractl->_index + ractl->_nr_pages - index;
>  			continue;
>  		}
>  		if (i == nr_to_read - lookahead_size)
>  			folio_set_readahead(folio);
>  		ractl->_workingset |= folio_test_workingset(folio);
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += folio_nr_pages(folio);
> +		i += folio_nr_pages(folio);
>  	}
>  
>  	/*
> -- 
> 2.43.0
> 
> 

