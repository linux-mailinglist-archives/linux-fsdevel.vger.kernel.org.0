Return-Path: <linux-fsdevel+bounces-21612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08090674F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C041D1C21844
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BF13E8BF;
	Thu, 13 Jun 2024 08:44:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1A13777D;
	Thu, 13 Jun 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268258; cv=none; b=WBmQomqJNTfkvzFQKnppImVFJkwZwLBo6drfWoh831iTDrnK2Jl1hoKklK7hFvmcmij7VNH9Z+0wgzFQ9O/KKncCgSNH+dgYApReDigMBFX9Uf/lLBgr9mcyFhz3QlMVqe9+gjiwDGmx9ePCrSjyOEerXk/DcauBQceGIspQG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268258; c=relaxed/simple;
	bh=NSrOqHEzu2xbZAdhX9ligMyBTflH4RGvPxAtZPprF1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqjrALJKls8RG3T0GLRt0PmPXteNVazjwq3lMymodNUo5M3F6QQ5m7WEUMoSoGQBZ2aGhLRFLD9R/VUAmUdUOH5RE+fiW7Jrig5Xo8zQ909pVbPMbBzQ9a8z4vpjhjKV+aFfQHZaDlAuGLUrLSQHoSB0/fVMppcdE3YcQO1uKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B74A468AFE; Thu, 13 Jun 2024 10:44:10 +0200 (CEST)
Date: Thu, 13 Jun 2024 10:44:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240613084409.GA23371@lst.de>
References: <20240607145902.1137853-1-kernel@pankajraghav.com> <20240607145902.1137853-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-4-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 02:58:54PM +0000, Pankaj Raghav (Samsung) wrote:
> +static inline unsigned long mapping_min_folio_nrpages(struct address_space *mapping)
> +{
> +	return 1UL << mapping_min_folio_order(mapping);
> +}

Overly long line here, just line break after the return type.

Then again it only has a single user just below and no documentation
so maybe just fold it into the caller?

>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> -		unsigned order = FGF_GET_ORDER(fgp_flags);
> +		unsigned int min_order = mapping_min_folio_order(mapping);
> +		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
>  		int err;
> +		index = mapping_align_start_index(mapping, index);

I wonder if at some point splitting this block that actually allocates
a new folio into a separate helper would be nice.  It just keep growing
in size and complexity.

> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    min_order);

Nit: no need to split this into multiple lines.

>  	if (!folio)
>  		return -ENOMEM;
>  
> @@ -2471,6 +2478,8 @@ static int filemap_create_folio(struct file *file,
>  	 * well to keep locking rules simple.
>  	 */
>  	filemap_invalidate_lock_shared(mapping);
> +	/* index in PAGE units but aligned to min_order number of pages. */

in PAGE_SIZE units?  Maybe also make this a complete sentence?


