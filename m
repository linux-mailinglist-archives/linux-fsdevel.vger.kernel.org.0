Return-Path: <linux-fsdevel+bounces-28970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A085097275C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C63285A77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90814F122;
	Tue, 10 Sep 2024 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hw9BTAVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31393EA86;
	Tue, 10 Sep 2024 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936804; cv=none; b=K18rLC8IS1IBKbSAhLfgZiQH2dNRGhiMtHh015JtNLg9MByVXmo2o2XbZWfzNuMUVuAi0XZPX7DJS/KBQt/ou1Ogq31oZQLWQxa84uV99o4PyIAQYbDagT1pNqIuKpe5JBNgvUNMNWJ/cbvHMg7s6zyFnWalRcHRu2LOEvD9xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936804; c=relaxed/simple;
	bh=wm/tBCMImoTJUU11Nlkaw5AvEhiUOrjhZKRRf42HF44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsW0pcr4DQxmexMcCBkW5JHE2KTxslVrwp5BK/vqjgoaRTtxwPOBVla3Kmg9miwVwicEcDetWKdoHbSxuqvkSAdCljgnCUd3k8zJ8FppKx6aLK1RsHtR3q4j56AEmrAagGjplPN3XKTGi7LHyOWSfOWaoZXvfp+b7F7wTuCI3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hw9BTAVC; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725936794; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A9AxNolWd8sgIA+SoFXrv1HHtV5EHKQsRTnCHtVf7s8=;
	b=hw9BTAVCSTyWRaFTO8vRMULUUNDmj7j/ZtV/Y3iRlkerU1WqLcjE30M/nLpuaqk3ZgNU7Ki735z7IlAUyqJKKoJWoioYcgeLBm5/yZ3Waegi0w6fQ3rUk6x9+YB722tPMkPyk4JJ3Ds7/RXvU+HxegMLX2Yl15JatndZ7FQpu80=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEiMc3c_1725936793)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 10:53:13 +0800
Message-ID: <18dd8c07-5bb5-403b-8fda-b927c7761bd0@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: replace xa_get_order with xas_get_order where
 appropriate
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 linux-fsdevel@vger.kernel.org
References: <20240906230512.124643-1-shakeel.butt@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240906230512.124643-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/7 07:05, Shakeel Butt wrote:
> The tracing of invalidation and truncation operations on large files
> showed that xa_get_order() is among the top functions where kernel
> spends a lot of CPUs. xa_get_order() needs to traverse the tree to reach
> the right node for a given index and then extract the order of the
> entry. However it seems like at many places it is being called within an
> already happening tree traversal where there is no need to do another
> traversal. Just use xas_get_order() at those places.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/filemap.c | 6 +++---
>   mm/shmem.c   | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 070dee9791a9..7e3412941a8d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2112,7 +2112,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>   			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
>   					folio);
>   		} else {
> -			nr = 1 << xa_get_order(&mapping->i_pages, xas.xa_index);
> +			nr = 1 << xas_get_order(&xas);
>   			base = xas.xa_index & ~(nr - 1);
>   			/* Omit order>0 value which begins before the start */
>   			if (base < *start)
> @@ -3001,7 +3001,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
>   static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
>   {
>   	if (xa_is_value(folio))
> -		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
> +		return PAGE_SIZE << xas_get_order(xas);
>   	return folio_size(folio);
>   }
>   
> @@ -4297,7 +4297,7 @@ static void filemap_cachestat(struct address_space *mapping,
>   		if (xas_retry(&xas, folio))
>   			continue;
>   
> -		order = xa_get_order(xas.xa, xas.xa_index);
> +		order = xas_get_order(&xas);
>   		nr_pages = 1 << order;
>   		folio_first_index = round_down(xas.xa_index, 1 << order);
>   		folio_last_index = folio_first_index + nr_pages - 1;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 866d46d0c43d..4002c4f47d4d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -893,7 +893,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>   		if (xas_retry(&xas, page))
>   			continue;
>   		if (xa_is_value(page))
> -			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
> +			swapped += 1 << xas_get_order(&xas);
>   		if (xas.xa_index == max)
>   			break;
>   		if (need_resched()) {

