Return-Path: <linux-fsdevel+bounces-48045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6119AA90A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A79A7A7842
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38415B546;
	Mon,  5 May 2025 10:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372E1FDE00;
	Mon,  5 May 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439770; cv=none; b=F8jETqkQ06VZBjw4J26qEZ9BsTpQkHqItXjLy02nJ91BGG/8bCPlHLnndls9n37ZoP2BpnxHqvLP2F65Da1AMGxFC0SovbtRO3P9L/eu209tluY+23xKNmcLKGbfiNmkCNhp9eu6Om8oyhyc/9LpAo39Ha6Yi4Vd9kAfJrp5d/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439770; c=relaxed/simple;
	bh=+VHZDed0Da1cp3yBvTy9cTZsLWHLoy6+HRHFV9c4X3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZT1z+/wPM04uZPHbYeRvWXPChh2hmrL73MmQZtQSBunVnYI6sVswl7Q9IiOX3V9XuJLcxIm09lycK/j8RAUh4abWSwczIpZeNHUjGtUY1NuZ9bqcz7Jl2siCbygQ2Hb1zdHZ7ulxPyhmeeY+Dr0Qy4aoSIwfp5azQ3nq10qPlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A85761007;
	Mon,  5 May 2025 03:09:17 -0700 (PDT)
Received: from [10.163.53.144] (unknown [10.163.53.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDD73F5A1;
	Mon,  5 May 2025 03:09:21 -0700 (PDT)
Message-ID: <8e3ca5fc-dadc-4a0a-902e-d2522740cbce@arm.com>
Date: Mon, 5 May 2025 15:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250430145920.3748738-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 20:29, Ryan Roberts wrote:
> page_cache_ra_order() takes a parameter called new_order, which is
> intended to express the preferred order of the folios that will be
> allocated for the readahead operation. Most callers indeed call this
> with their preferred new order. But page_cache_async_ra() calls it with
> the preferred order of the previous readahead request (actually the
> order of the folio that had the readahead marker, which may be smaller
> when alignment comes into play).
> 
> And despite the parameter name, page_cache_ra_order() always treats it
> at the old order, adding 2 to it on entry. As a result, a cold readahead
> always starts with order-2 folios.
> 
> Let's fix this behaviour by always passing in the *new* order.

Makes sense.

> 
> Worked example:
> 
> Prior to the change, mmaping an 8MB file and touching each page
> sequentially, resulted in the following, where we start with order-2
> folios for the first 128K then ramp up to order-4 for the next 128K,
> then get clamped to order-5 for the rest of the file because pa_pages is
> limited to 128K:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00004000      16384        0        4      4      2
> FOLIO  0x00004000  0x00008000      16384        4        8      4      2
> FOLIO  0x00008000  0x0000c000      16384        8       12      4      2
> FOLIO  0x0000c000  0x00010000      16384       12       16      4      2
> FOLIO  0x00010000  0x00014000      16384       16       20      4      2
> FOLIO  0x00014000  0x00018000      16384       20       24      4      2
> FOLIO  0x00018000  0x0001c000      16384       24       28      4      2
> FOLIO  0x0001c000  0x00020000      16384       28       32      4      2
> FOLIO  0x00020000  0x00030000      65536       32       48     16      4
> FOLIO  0x00030000  0x00040000      65536       48       64     16      4
> FOLIO  0x00040000  0x00060000     131072       64       96     32      5
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
> ...
> 
> After the change, the same operation results in the first 128K being
> order-0, then we start ramping up to order-2, -4, and finally get
> clamped at order-5:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00001000       4096        0        1      1      0
> FOLIO  0x00001000  0x00002000       4096        1        2      1      0
> FOLIO  0x00002000  0x00003000       4096        2        3      1      0
> FOLIO  0x00003000  0x00004000       4096        3        4      1      0
> FOLIO  0x00004000  0x00005000       4096        4        5      1      0
> FOLIO  0x00005000  0x00006000       4096        5        6      1      0
> FOLIO  0x00006000  0x00007000       4096        6        7      1      0
> FOLIO  0x00007000  0x00008000       4096        7        8      1      0
> FOLIO  0x00008000  0x00009000       4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000       4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000       4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000       4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000       4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000       4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000       4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000       4096       15       16      1      0
> FOLIO  0x00010000  0x00011000       4096       16       17      1      0
> FOLIO  0x00011000  0x00012000       4096       17       18      1      0
> FOLIO  0x00012000  0x00013000       4096       18       19      1      0
> FOLIO  0x00013000  0x00014000       4096       19       20      1      0
> FOLIO  0x00014000  0x00015000       4096       20       21      1      0
> FOLIO  0x00015000  0x00016000       4096       21       22      1      0
> FOLIO  0x00016000  0x00017000       4096       22       23      1      0
> FOLIO  0x00017000  0x00018000       4096       23       24      1      0
> FOLIO  0x00018000  0x00019000       4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000       4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
> FOLIO  0x00030000  0x00034000      16384       48       52      4      2
> FOLIO  0x00034000  0x00038000      16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000      16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000      16384       60       64      4      2
> FOLIO  0x00040000  0x00050000      65536       64       80     16      4
> FOLIO  0x00050000  0x00060000      65536       80       96     16      4
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000     131072      192      224     32      5

I guess performance wise this will be worse than earlier ? Although it
does fix the semantics for page_cache_ra_order() with respect to the
parameter 'new_order'.

> ...
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/readahead.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a4e96b69702..8bb316f5a842 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = min(limit, index + ra->size - 1);
>  
> -	if (new_order < mapping_max_folio_order(mapping))
> -		new_order += 2;
> -
>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	new_order = max(new_order, min_order);
> @@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	ra->size = get_next_ra_size(ra, max_pages);
>  	ra->async_size = ra->size;
>  readit:

Should not the earlier conditional check also be brought here before
incrementing the order ? Just curious.

if (new_order < mapping_max_folio_order(mapping))

> +	order += 2;
>  	ractl->_index = ra->start;
>  	page_cache_ra_order(ractl, ra, order);
>  }

