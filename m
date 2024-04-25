Return-Path: <linux-fsdevel+bounces-17801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DC8B2458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F30B26E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403A14A4FB;
	Thu, 25 Apr 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="lGc1j8mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757312BE8C;
	Thu, 25 Apr 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056475; cv=none; b=eQ/Oq+qpgJlVsqfqcW2iOm86BShR8C5O+lQyACiIJMikrXh0j9kdz8rg5Kf286Drf/IF3EPfkLdiWeArwC4mrhnLE192EmsSqn/Ew9HHnBgqID2Uv8A0wwKYE7HogAPI+60yZ7jU2BR3YVBr9ql/nX6OVgVYCtkjZZ0H16ZArfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056475; c=relaxed/simple;
	bh=xirADQnND4LpW3On1CYVvqiaJ7dFeYmjfzo0yqz5Uvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2C93yoMv3y1wulCv1FH1hbGEamsSdUt+/fGFUzWv5AVDsTVywOJFhKX36jNtWnvnuOuJbyZRUD3NHD2kz8yw8aBmTtZYUZt8m/2iEjVuxpwN1dFjQ0tawQPq+HCC51zWV7WaGTejbnUbhzlf2glJUBvyqmoRYAH+pc38ZRPhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=lGc1j8mm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VQJcN6X9fz9sn3;
	Thu, 25 Apr 2024 16:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714056468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uONcSOBmYm/zEIn/RVoq3cLXjOll3fnF/QGfQtQU1Y=;
	b=lGc1j8mmeffOqT4NiHrF7eoMXpDqgwvRCENRJJWBxgfN5pSWO/HKcAt9zSSDb0c3D4pvJa
	CW6TS2aHiXV16VOTzsX0x0YtSjv3SeljbDFVXOO0oBtzZlm3AKnobxFZNd+vYqbV+CTv+r
	tDnFzSd69F+bXUA01ebmZrATefPMztZaphHe2zCk2EPxMjAp1uVd2CxW+wi1v7nyguDKUF
	ilTj3f3nl4coS3k23fbERU7i/f9+ZZpVVbPonTUT8gMYTpCLASLFCxl8ogCRmONnG+BEp+
	ms5v36t6TERhrtEjb3ArfqGDXTEBZXNQypQOQNRA10K2e/IqwM7sSzZdT0ezWQ==
Date: Thu, 25 Apr 2024 14:47:41 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
	willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
	martin.petersen@oracle.com, nilay@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
	jbongio@google.com, okiselev@amazon.com
Subject: Re: [PATCH RFC 2/7] filemap: Change mapping_set_folio_min_order() ->
 mapping_set_folio_orders()
Message-ID: <20240425144741.houv6uoflhwmcc2u@quentin>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
 <20240422143923.3927601-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422143923.3927601-3-john.g.garry@oracle.com>

On Mon, Apr 22, 2024 at 02:39:18PM +0000, John Garry wrote:
> Borrowed from:
> 
> https://lore.kernel.org/linux-fsdevel/20240213093713.1753368-2-kernel@pankajraghav.com/
> (credit given in due course)
> 
> We will need to be able to only use a single folio order for buffered
> atomic writes, so allow the mapping folio order min and max be set.

> 
> We still have the restriction of not being able to support order-1
> folios - it will be required to lift this limit at some stage.

This is already supported upstream for file-backed folios:
commit: 8897277acfef7f70fdecc054073bea2542fc7a1b

> index fc8eb9c94e9c..c22455fa28a1 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -363,9 +363,10 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #endif
>  
>  /*
> - * mapping_set_folio_min_order() - Set the minimum folio order
> + * mapping_set_folio_orders() - Set the minimum and max folio order

In the new series (sorry forgot to CC you), I added a new helper called
mapping_set_folio_order_range() which does something similar to avoid
confusion based on willy's suggestion:
https://lore.kernel.org/linux-xfs/20240425113746.335530-3-kernel@pankajraghav.com/

mapping_set_folio_min_order() also sets max folio order to be 
MAX_PAGECACHE_ORDER order anyway. So no need of explicitly calling it
here?

>  /**
> @@ -400,7 +406,7 @@ static inline void mapping_set_folio_min_order(struct address_space *mapping,
>   */
>  static inline void mapping_set_large_folios(struct address_space *mapping)
>  {
> -	mapping_set_folio_min_order(mapping, 0);
> +	mapping_set_folio_orders(mapping, 0, MAX_PAGECACHE_ORDER);
>  }
>  
>  static inline unsigned int mapping_max_folio_order(struct address_space *mapping)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d81530b0aac0..d5effe50ddcb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1898,9 +1898,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
>  		unsigned int min_order = mapping_min_folio_order(mapping);
> -		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
> +		unsigned int max_order = mapping_max_folio_order(mapping);
> +		unsigned int order = FGF_GET_ORDER(fgp_flags);
>  		int err;
>  
> +		if (order > max_order)
> +			order = max_order;
> +		else if (order < min_order)
> +			order = max_order;

order = min_order; ?
--
Pankaj

