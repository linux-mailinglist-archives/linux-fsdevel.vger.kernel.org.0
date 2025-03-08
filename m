Return-Path: <linux-fsdevel+bounces-43509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6873A5787A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 06:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63FC3B3768
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927D17A2EC;
	Sat,  8 Mar 2025 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DwDzzk3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979E196
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741411922; cv=none; b=FJriqAsx8BOyzrqM3GHmPlllAtcbvzJXgf12t31TwpOXI5tvzDGEsXZ8wtnCnEL1PYLG7ryvTc8uqA1yqCOdAVddWvUxiR/l8t7bBXlfwTpu/pMiEuCEhwiQoL42kI3tcBu18YqN99yN1fLteyBwu2i1U37pmjtFvbL1wxxXtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741411922; c=relaxed/simple;
	bh=r3WmQzKBN5y6VbEOdWMIT8xbnZLiiBRRi1vK4WFLKIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=It3VUyGJpughN3uF3Ao0mFkz3/uxZejr+GY/5PEeF0Kkq7RDT7apt7A6AVe+jUetildX7OIPM3l771JswkaOU2LJILXnYdrncF8hx5UwrZ2eS6d08LYaz9iQtCOdajseexVvsnvlwkZAdr0qALTEVQAwD4q5+M4AS75rfoTu1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DwDzzk3T; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741411915; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QwGokHK8MWELbszfeUznitYDMBt/G0N6Dzae0aons/k=;
	b=DwDzzk3TsYNZrCbUqCaW5g2xtYFbyOjWMtd+tWgrkSle5SdDeFE3coeQRSRX9KaUXxpzDAh6cqDRtkJpsGL5rCnI6ks1zbMVgBSXOgw2GEGSC1/GrMx+X4Eljoj0fcNUbsus0SdWxMYLYeE0c04e8YsqF4fQv2lm6BSa87bzq/I=
Received: from 30.221.80.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQu7mhO_1741411914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 13:31:55 +0800
Message-ID: <88098e5c-1514-4d8d-a220-531a9b473ae3@linux.alibaba.com>
Date: Sat, 8 Mar 2025 13:31:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] shmem: Add shmem_writeout()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, intel-gfx@lists.freedesktop.org
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-9-willy@infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250307135414.2987755-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/7 21:54, Matthew Wilcox (Oracle) wrote:
> This will be the replacement for shmem_writepage().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/shmem_fs.h |  7 ++++---
>   mm/shmem.c               | 20 ++++++++++++++------
>   2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 0b273a7b9f01..5f03a39a26f7 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -104,10 +104,11 @@ static inline bool shmem_mapping(struct address_space *mapping)
>   	return false;
>   }
>   #endif /* CONFIG_SHMEM */
> -extern void shmem_unlock_mapping(struct address_space *mapping);
> -extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> +void shmem_unlock_mapping(struct address_space *mapping);
> +struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>   					pgoff_t index, gfp_t gfp_mask);
> -extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
> +int shmem_writeout(struct folio *folio, struct writeback_control *wbc);
> +void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>   int shmem_unuse(unsigned int type);
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ba162e991285..427b7f70fffb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1536,12 +1536,20 @@ int shmem_unuse(unsigned int type)
>   	return error;
>   }
>   
> -/*
> - * Move the page from the page cache to the swap cache.
> - */
>   static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   {
> -	struct folio *folio = page_folio(page);
> +	return shmem_writeout(page_folio(page), wbc);
> +}
> +
> +/**
> + * shmem_writeout - Write the folio to swap
> + * @folio: The folio to write
> + * @wbc: How writeback is to be done
> + *
> + * Move the folio from the page cache to the swap cache.
> + */
> +int shmem_writeout(struct folio *folio, struct writeback_control *wbc)
> +{
>   	struct address_space *mapping = folio->mapping;
>   	struct inode *inode = mapping->host;
>   	struct shmem_inode_info *info = SHMEM_I(inode);
> @@ -1586,9 +1594,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   try_split:
>   		/* Ensure the subpages are still dirty */
>   		folio_test_set_dirty(folio);
> -		if (split_huge_page_to_list_to_order(page, wbc->list, 0))
> +		if (split_folio_to_list(folio, wbc->list))
>   			goto redirty;
> -		folio = page_folio(page);
>   		folio_clear_dirty(folio);
>   	}
>   
> @@ -1660,6 +1667,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	folio_unlock(folio);
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(shmem_writeout);
>   
>   #if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
>   static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)

