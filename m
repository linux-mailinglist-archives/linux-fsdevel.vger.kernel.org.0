Return-Path: <linux-fsdevel+bounces-11390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4D853623
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539A21F245EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBE321AA;
	Tue, 13 Feb 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTzZ5mKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE171BA2D;
	Tue, 13 Feb 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842072; cv=none; b=So4weD5D53zZo2s06QkEKthw+cVMmMwM3w9aQ6ZdXro0KeTnWmG+gK/56jO5f9ixahQZVwYx2edr3vw7nyzgwztZAFbOiyAH1Yi39Zyic4fNqeaS8wZnUbTju9swsJemdm2wqz0eAIT9K8nOk7xzVMT7V6Vav8xJ3P8llXWzg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842072; c=relaxed/simple;
	bh=vOnl585xawDmEhk+WRBKmj9SlAqAoo9n/at+gNzE5oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeGbXw0Yz16UWlC3sc5BiR/mDAmFcpNNydkR6MaTcLp7lJ5csPBhOzngK3DZlGWItUSvOL7/LOrgTLrVXJfvXZV0XdwD0R8yhzo+LX23Z3nvwpaWrtdC/Hi/a9Iv24A2NKMlq2QWd3mI4QOwe5aEE6kC33GH+2ArT26FzB8fFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTzZ5mKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2607AC433C7;
	Tue, 13 Feb 2024 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842072;
	bh=vOnl585xawDmEhk+WRBKmj9SlAqAoo9n/at+gNzE5oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTzZ5mKFv3NhctkwDebcPGufJ7b49XoS6YNLkyhVH8SjgSI7sIf2tKGQewny/w33s
	 qXAF4OJBTFY9kl92CGhEiI3ecJOQ2LTdO1jhS88u+Dy/arHIAfveor2b2W40WbGuID
	 jPPW4DV4U8vIOVoBcImJBXJjLE66NPu3ws1pmT8vJb7K9HLghNi4k8dMpGDDGlpdXM
	 kJjKZ+s5DM0R0Pl8CSH+VRG5mEgIghuTapg/qWsIvuyzwPXIA6Byr9wQCiJALZ6qp7
	 LzfFMGej3JbC+Ai5vcS/ogsL5UOY21frem9KkeAKgjZptGYOukc/3LUGGGlGJPu8n9
	 P0lZU0UGxX1xw==
Date: Tue, 13 Feb 2024 08:34:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <20240213163431.GS6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-2-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Some filesystems want to be able to limit the maximum size of folios,
> and some want to be able to ensure that folios are at least a certain
> size.  Add mapping_set_folio_orders() to allow this level of control.
> The max folio order parameter is ignored and it is always set to
> MAX_PAGECACHE_ORDER.

Why?  If MAX_PAGECACHE_ORDER is 8 and I instead pass in max==3, I'm
going to be surprised by my constraint being ignored.  Maybe I said that
because I'm not prepared to handle an order-7 folio; or some customer
will have some weird desire to twist this knob to make their workflow
faster.

--D

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/pagemap.h | 92 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 73 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d..5618f762187b 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -202,13 +202,18 @@ enum mapping_flags {
>  	AS_EXITING	= 4, 	/* final truncate in progress */
>  	/* writeback related tags are not used */
>  	AS_NO_WRITEBACK_TAGS = 5,
> -	AS_LARGE_FOLIO_SUPPORT = 6,
> -	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> -	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> +	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
> +	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>  				   folio contents */
> -	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
> +	AS_FOLIO_ORDER_MIN = 8,
> +	AS_FOLIO_ORDER_MAX = 13, /* Bit 8-17 are used for FOLIO_ORDER */
> +	AS_UNMOVABLE = 18,		/* The mapping cannot be moved, ever */
>  };
>  
> +#define AS_FOLIO_ORDER_MIN_MASK 0x00001f00
> +#define AS_FOLIO_ORDER_MAX_MASK 0x0003e000
> +#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
> +
>  /**
>   * mapping_set_error - record a writeback error in the address_space
>   * @mapping: the mapping in which an error should be set
> @@ -344,6 +349,53 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
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
> +/*
> + * mapping_set_folio_orders() - Set the range of folio sizes supported.
> + * @mapping: The file.
> + * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + * @max: Maximum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate which sizes of folio the VFS can use to cache the contents
> + * of the file.  This should only be used if the filesystem needs special
> + * handling of folio sizes (ie there is something the core cannot know).
> + * Do not tune it based on, eg, i_size.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_folio_orders(struct address_space *mapping,
> +					    unsigned int min, unsigned int max)
> +{
> +	if (min == 1)
> +		min = 2;
> +	if (max < min)
> +		max = min;
> +	if (max > MAX_PAGECACHE_ORDER)
> +		max = MAX_PAGECACHE_ORDER;
> +
> +	/*
> +	 * XXX: max is ignored as only minimum folio order is supported
> +	 * currently.
> +	 */
> +	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
> +			 (min << AS_FOLIO_ORDER_MIN) |
> +			 (MAX_PAGECACHE_ORDER << AS_FOLIO_ORDER_MAX);
> +}
> +
>  /**
>   * mapping_set_large_folios() - Indicate the file supports large folios.
>   * @mapping: The file.
> @@ -357,7 +409,22 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>   */
>  static inline void mapping_set_large_folios(struct address_space *mapping)
>  {
> -	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	mapping_set_folio_orders(mapping, 0, MAX_PAGECACHE_ORDER);
> +}
> +
> +static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
> +{
> +	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
> +}
> +
> +static inline unsigned int mapping_min_folio_order(struct address_space *mapping)
> +{
> +	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
> +}
> +
> +static inline unsigned int mapping_min_folio_nrpages(struct address_space *mapping)
> +{
> +	return 1U << mapping_min_folio_order(mapping);
>  }
>  
>  /*
> @@ -367,7 +434,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
>  static inline bool mapping_large_folio_support(struct address_space *mapping)
>  {
>  	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> +	       (mapping_max_folio_order(mapping) > 0);
>  }
>  
>  static inline int filemap_nr_thps(struct address_space *mapping)
> @@ -528,19 +595,6 @@ static inline void *detach_page_private(struct page *page)
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
> 2.43.0
> 
> 

