Return-Path: <linux-fsdevel+bounces-66409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FFDC1E208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 03:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F44E5F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E83325734;
	Thu, 30 Oct 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ey4KdRw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10632570F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791391; cv=none; b=SBk2h64NJUrT84g3e2mIG0i8/6iXA0NsStQZgnuYVfvzKNaD7VEw5Kcw8JLumcyqESl6rJ0JPHxDzqtjQSHMb5SHADC4R4XarWw/yW/ucuNUT8QtV6R4fhYlwHnGfHkNIpxTLR30KSwPaXKVaVhKIhaL0MKRggV7SL+FaN9lpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791391; c=relaxed/simple;
	bh=hHRxN5CiY7Gx4QWe8wmAeGr4/YKu9bFUbFH+1qPXlZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2p29xMw6XCUEeI1sI4NfdxUysLHG8/9BnOlaESU97wnjEcC8xwAYbPZ/8HCZRx/4EmH6ILIfp4dGswEk69R4ocx2VynBYEtZ8x6Vgrem0Tyr36S0gpHOqssbSlttV1jKphMpqGt4HYD9SmcChxSTntF5meiDBfxGOYgzGHyWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ey4KdRw1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2103b59-5cff-48a8-9eb8-ff9498dbde5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0oJwA47yZHkVimWM2fyRJ3wZQiGsiQFxNLLyULBfMc=;
	b=ey4KdRw1uackh5jZSEHqNgwTXAarUS+0SAPTiqv/KcQLBg4KotGPjRf/1EkmmkTz2iObFv
	hesUQa0gME5/gVXfROWM2yrGQBsjQJP45DO4uw8/+syG1ANQyRDi3FpTUdyOc2iOpbUEEY
	PuJnRNLHVgG58H7igkVaOKV2JtwmF2c=
Date: Thu, 30 Oct 2025 10:29:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio
 handling.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, jane.chu@oracle.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 linmiaohe@huawei.com, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, david@redhat.com
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-3-ziy@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/30 09:40, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
> 
> For soft offline, do not split the large folio if its min_order_for_folio()
> is not 0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
> 
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   mm/memory-failure.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..acc35c881547 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>    * there is still more to do, hence the page refcount we took earlier
>    * is still needed.
>    */
> -static int try_to_split_thp_page(struct page *page, bool release)
> +static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> +		bool release)
>   {
>   	int ret;
>   
>   	lock_page(page);
> -	ret = split_huge_page(page);
> +	ret = split_huge_page_to_order(page, new_order);
>   	unlock_page(page);
>   
>   	if (ret && release)
> @@ -2280,6 +2281,9 @@ int memory_failure(unsigned long pfn, int flags)
>   	folio_unlock(folio);
>   
>   	if (folio_test_large(folio)) {
> +		const int new_order = min_order_for_split(folio);
> +		int err;
> +
>   		/*
>   		 * The flag must be set after the refcount is bumped
>   		 * otherwise it may race with THP split.
> @@ -2294,7 +2298,16 @@ int memory_failure(unsigned long pfn, int flags)
>   		 * page is a valid handlable page.
>   		 */
>   		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p, false) < 0) {
> +		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> +		/*
> +		 * If splitting a folio to order-0 fails, kill the process.
> +		 * Split the folio regardless to minimize unusable pages.
> +		 * Because the memory failure code cannot handle large
> +		 * folios, this split is always treated as if it failed.
> +		 */
> +		if (err || new_order) {
> +			/* get folio again in case the original one is split */
> +			folio = page_folio(p);
>   			res = -EHWPOISON;
>   			kill_procs_now(p, pfn, flags, folio);
>   			put_page(p);
> @@ -2621,7 +2634,17 @@ static int soft_offline_in_use_page(struct page *page)
>   	};
>   
>   	if (!huge && folio_test_large(folio)) {
> -		if (try_to_split_thp_page(page, true)) {
> +		const int new_order = min_order_for_split(folio);
> +
> +		/*
> +		 * If new_order (target split order) is not 0, do not split the
> +		 * folio at all to retain the still accessible large folio.
> +		 * NOTE: if minimizing the number of soft offline pages is
> +		 * preferred, split it to non-zero new_order like it is done in
> +		 * memory_failure().
> +		 */
> +		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
> +						       /* release= */ true)) {
>   			pr_info("%#lx: thp split failed\n", pfn);
>   			return -EBUSY;
>   		}


