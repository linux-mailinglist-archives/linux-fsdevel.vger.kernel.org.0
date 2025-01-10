Return-Path: <linux-fsdevel+bounces-38847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DEA08CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042333AB585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48520A5D1;
	Fri, 10 Jan 2025 09:46:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B820A5EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502383; cv=none; b=NLw/Kx/P4VuhkFJdxi1Z8hqF3hWCcAOwaK0BKFY2rh7/QU5eCqZycfvHmOvbnWogoe7/xgiSJWYlIPE8RiJMoj6OYhXJXKSOEA3mdAU+UC1N04mZPmaksCy9xVHqGNNSnu2WETa+EQh+7pnFJdE4x8oFBHmVLwlA3C7l87C0Yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502383; c=relaxed/simple;
	bh=IhHAB+g3YILCD4U/mzbFjdV5HdNKs7m3Y2YEmxXkl1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6dGCUdoRdLcPJYGp2UdJxLdZay07VKpUzjL+KX90VNf21hvGLUM2reERQfWqa1Z3YRZS7c7mB4YnGASGV9sK1+NyvVaUZ2I4IBtU6vzi3edC4e3mrCvBaDMRe4TiIslp0SzPJcceZZ2ndQqKg4yu5Z876hM1qqSrin/AMLmpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC0613D5;
	Fri, 10 Jan 2025 01:46:49 -0800 (PST)
Received: from [10.57.94.123] (unknown [10.57.94.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C0E3F673;
	Fri, 10 Jan 2025 01:46:20 -0800 (PST)
Message-ID: <20301851-d7c9-4ff9-81ad-8789d21f4b85@arm.com>
Date: Fri, 10 Jan 2025 09:46:19 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Phillip Lougher <phillip@squashfs.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-5-willy@infradead.org>
 <c37bc614-2656-44c4-9aed-c30fe6438677@squashfs.org.uk>
 <5cf5a52c-e5f4-4486-8421-c7fe913c43c4@arm.com>
 <c842632d-3924-4228-b92d-9255aae9939b@arm.com>
 <269c495b-e0f4-4c0c-aaf4-0e49823276d1@arm.com>
 <Z4CAYCSJaF2dmJwj@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z4CAYCSJaF2dmJwj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2025 02:05, Matthew Wilcox wrote:
> On Thu, Jan 09, 2025 at 05:34:43PM +0000, Ryan Roberts wrote:
>> I started getting a different oops after I fixed this issue. It turns out that
>> __filemap_get_folio() returns ERR_PTR() on error whereas
>> grab_cache_page_nowait() (used previously) returns NULL. So the continue
>> condition needs to change. This fixes both for me:
> 
> Hey Ryan, can you try this amalgam of three patches?
> If it works out, I'll send the two which aren't yet in akpm's tree to
> him.

Yep that fixes it. Feel free to add:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>


> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index da25d6fa45ce..5ca2baa16dc2 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -400,7 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>  			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>  		struct folio *push_folio;
>  		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> -		bool uptodate = true;
> +		bool updated = false;
>  
>  		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>  
> @@ -409,15 +409,15 @@ void squashfs_copy_cache(struct folio *folio,
>  					FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
>  					mapping_gfp_mask(mapping));
>  
> -		if (!push_folio)
> +		if (IS_ERR(push_folio))
>  			continue;
>  
>  		if (folio_test_uptodate(push_folio))
>  			goto skip_folio;
>  
> -		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
> +		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
>  skip_folio:
> -		folio_end_read(push_folio, uptodate);
> +		folio_end_read(push_folio, updated);
>  		if (i != folio->index)
>  			folio_put(push_folio);
>  	}
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 12ba297bb85e..3b1eefa9aab8 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1505,7 +1505,7 @@ void folio_end_read(struct folio *folio, bool success)
>  	/* Must be in bottom byte for x86 to work */
>  	BUILD_BUG_ON(PG_uptodate > 7);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> -	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
> +	VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
>  
>  	if (likely(success))
>  		mask |= 1 << PG_uptodate;


