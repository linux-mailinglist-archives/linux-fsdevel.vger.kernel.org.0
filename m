Return-Path: <linux-fsdevel+bounces-50893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49123AD0B70
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C71170767
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661691F37A1;
	Sat,  7 Jun 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wCxUccFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021521CFBA;
	Sat,  7 Jun 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749277212; cv=none; b=T36pKTJNHUavvU7Iiz1TF4gymDIEtn8ehjB5EqwKz7J0YFHKREZwtJmIa49JZEEubOKfgweVSbBRYWtf3yTCmicEPJRrrVhMQlTnjmQ3A4o9NRuhqkyQwa5Sp/dwM3RsHc1Z8xRQ8P7Ch66YXa3T2i+AF8uUxKhUmPNxJ6dTtqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749277212; c=relaxed/simple;
	bh=wuz7p5awEUVGQ7DoGzP1iq474yL/WruhyFqYahUxc/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqnFUcNcyxkVEvYQFYs8JFi1eq900Gzq5tAbiW+mkqOjH2QfISDJesZLnXFk5c+o53BfQCoe1E9KMfWQxeG5/SmKwyCQOhw+/NS4cOBP8RX1FlNnIG4+5dJQ6mrbJe6pWBC9JAGnwXY6ozL7zUXMLPzhMCtQ5sUrmrQ2DEqtBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wCxUccFM; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749277202; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bMeCFCD1QdJYT9NdwI2Crw14jemcen+0Ba1sGRO6y6Q=;
	b=wCxUccFMf/DUWKu8/vWMkzgmI4Q2k2Fvg+cETr2ZqB0kVUkmB4TtoBnVVtqBFk/ra5xappaOpXg311Kcl3enXEpKnXmCbu8PSTawHaQp/ZDgiozUwYHPqYzHD00fmuqmytpmzVuilzQZOAoxGmSeDRVtRZvxjMNqldFEwO5vkRE=
Received: from 30.39.161.173(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdEIVfO_1749277201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Jun 2025 14:20:01 +0800
Message-ID: <c05b8612-83a6-47f7-84f8-72276c08a4ac@linux.alibaba.com>
Date: Sat, 7 Jun 2025 14:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shmem: avoid setting error on splited entries in
 shmem_set_folio_swapin_error()
To: Kemeng Shi <shikemeng@huaweicloud.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-3-shikemeng@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250605221037.7872-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/6 06:10, Kemeng Shi wrote:
> When large entry is splited, the first entry splited from large entry
> retains the same entry value and index as original large entry but it's
> order is reduced. In shmem_set_folio_swapin_error(), if large entry is
> splited before xa_cmpxchg_irq(), we may replace the first splited entry
> with error entry while using the size of original large entry for release
> operations. This could lead to a WARN_ON(i_blocks) due to incorrect
> nr_pages used by shmem_recalc_inode() and could lead to used after free
> due to incorrect nr_pages used by swap_free_nr().

I wonder if you have actually triggered this issue? When a large swap 
entry is split, it means the folio is already at order 0, so why would 
the size of the original large entry be used for release operations? Or 
is there another race condition?

> Skip setting error if entry spliiting is detected to fix the issue. The
> bad entry will be replaced with error entry anyway as we will still get
> IO error when we swap in the bad entry at next time.
> 
> Fixes: 12885cbe88ddf ("mm: shmem: split large entry if the swapin folio is not large")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/shmem.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e27d19867e03..f1062910a4de 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2127,16 +2127,25 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>   	struct address_space *mapping = inode->i_mapping;
>   	swp_entry_t swapin_error;
>   	void *old;
> -	int nr_pages;
> +	int nr_pages = folio_nr_pages(folio);
> +	int order;
>   
>   	swapin_error = make_poisoned_swp_entry();
> -	old = xa_cmpxchg_irq(&mapping->i_pages, index,
> -			     swp_to_radix_entry(swap),
> -			     swp_to_radix_entry(swapin_error), 0);
> -	if (old != swp_to_radix_entry(swap))
> +	xa_lock_irq(&mapping->i_pages);
> +	order = xa_get_order(&mapping->i_pages, index);
> +	if (nr_pages != (1 << order)) {
> +		xa_unlock_irq(&mapping->i_pages);
>   		return;
> +	}
> +	old = __xa_cmpxchg(&mapping->i_pages, index,
> +			   swp_to_radix_entry(swap),
> +			   swp_to_radix_entry(swapin_error), 0);
> +	if (old != swp_to_radix_entry(swap)) {
> +		xa_unlock_irq(&mapping->i_pages);
> +		return;
> +	}
> +	xa_unlock_irq(&mapping->i_pages);
>   
> -	nr_pages = folio_nr_pages(folio);
>   	folio_wait_writeback(folio);
>   	if (!skip_swapcache)
>   		delete_from_swap_cache(folio);

