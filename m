Return-Path: <linux-fsdevel+bounces-13063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6A86AC39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F341F23917
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D592763F2;
	Wed, 28 Feb 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDUIKRk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF9745F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116318; cv=none; b=Tr/Z/APW4WKTqncQtkOv7CN26H+5Tc7j8HfoK3JhlMThAuUTq/Qj5MUyGTP3GyzAr43K+Z8GgToJKOzVlR/rg1C2baIUgpO8o3j9w4msahVzUbBqBwxwwZ1ERPeE6WORe4BF4SI6gZzALLgWTJtzFuTE/0srdINCoSvknffuVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116318; c=relaxed/simple;
	bh=QtMVd8MfOkwZVeJr+7bvKB+Jv/uBDmSwr8adt/Z3VcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAxdHfva/Q+rbfx4/c+ZaGf7DJ7fkjLdKtwfw6SIB9nBzYfO2ygIzZnywERpX5Wgd9Zl3asI8NNYMx/SU1bdEodPahuwpQwIDUOzh6bQL0wkyuGiWOotg0c7LfYJMnmp85u91CGhn55Hfr4WeF39pRkcS+PRSbonpTQnAPKwo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDUIKRk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709116315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R5nPJc5wHy0mfNIo9LccGmQA1ipGTS8wbRwCe+Rx9QU=;
	b=RDUIKRk625lLwS6sTxrTJYTkwCrz+RPHxWyEQGVeNL8CPm2fdd7e19u8rJt1V0UXmWllkJ
	W1ZgdX+gqUymZxpolv4KSKaDHNT13uEpJ7Eor1DZDCtStv4XiB1G3agA3XZmbcxQKdzaP6
	edWKm1hkSzgD/lOCfEqZzzk+J0BuJuk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-nmxuNurNOwajYHze7lEoag-1; Wed, 28 Feb 2024 05:31:54 -0500
X-MC-Unique: nmxuNurNOwajYHze7lEoag-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5131bf5d21bso394381e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 02:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116313; x=1709721113;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5nPJc5wHy0mfNIo9LccGmQA1ipGTS8wbRwCe+Rx9QU=;
        b=nxF0y/udqGO+lDDREk3djGAFe4UD8YMM10k+bO8R95UqQuzFgPRmqAmiASRKxniUiC
         1jPbt8Qfp+vtUtdM3POhc+KIOKfQN97BoQlljH/0CPKXTJwCx4sLey1WzIV2alHrS0XB
         OFdBLLaj6SdPcPjQn0vrm3g7+m7EOJE2iqPZY5LXqqZbN/r5D2oY0/GPmV9dZfxVrg4G
         o8lVvZXGEYCCULkhr85uIxY/8eg3t2nX42LAfTD4uYXN4B/D8wziKaemrQtN1h/ViaEZ
         6yO/3kGDF5d9F+iB+wZUtTFA+qcomWfN+8pGzpbBxkAbPFBVaYUFcarBnPIdkTxKM7ZH
         873w==
X-Forwarded-Encrypted: i=1; AJvYcCXJmMUxZpRWDPVbK6hMo8bqROSrlfZxmHbBXl0xfAGn0iSl68jYVX0k2ie3u38elsQalo2Fx5XM7YPYPrNOJwVTEGiR+5to9vN61nvTEA==
X-Gm-Message-State: AOJu0Yx74RTrt7uBwOpwpH1m6dN8aO0eh6f5u4Pf6V0JGRXptCIuGI0Y
	e+aajNm7tuDYK3aiCJtN11hI1CcWYeOLq50YsMrqoDr3CSd7J/toJmWUwH9xOhdlSreEzlqj0Ns
	lqiVZQ/kvdev8LgR2SX2wIakkUAyglSUuM2HH3TTr6QOas/Dc1Cjbl9Hlgez7T64=
X-Received: by 2002:a05:6512:3d1a:b0:513:43e:e22d with SMTP id d26-20020a0565123d1a00b00513043ee22dmr3680436lfv.35.1709116312718;
        Wed, 28 Feb 2024 02:31:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpBIBpKUIbkIBZPc7584Yu6aT6pSQlO3j6evLahsMP+rbCQLK7Dm8x3AdXIreKPYKZSuhbcA==
X-Received: by 2002:a05:6512:3d1a:b0:513:43e:e22d with SMTP id d26-20020a0565123d1a00b00513043ee22dmr3680399lfv.35.1709116311831;
        Wed, 28 Feb 2024 02:31:51 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4142000000b0033cf453f2bbsm14023061wrq.35.2024.02.28.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 02:31:51 -0800 (PST)
Message-ID: <75fb8bf8-f9bc-410d-8c22-f69cbf2080a9@redhat.com>
Date: Wed, 28 Feb 2024 11:31:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] mm: page_owner: add support for splitting to any
 order in split page_owner.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-7-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240226205534.1603748-7-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 21:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner.
> It prepares for upcoming changes to support split huge page to any
> lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/page_owner.h | 13 ++++++++-----
>   mm/huge_memory.c           |  2 +-
>   mm/page_alloc.c            |  4 ++--
>   mm/page_owner.c            |  7 +++----
>   4 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index 2b39c8e19d98..debdc25f08b9 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
>   extern void __reset_page_owner(struct page *page, unsigned short order);
>   extern void __set_page_owner(struct page *page,
>   			unsigned short order, gfp_t gfp_mask);
> -extern void __split_page_owner(struct page *page, int order);
> +extern void __split_page_owner(struct page *page, int old_order,
> +			int new_order);
>   extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
>   extern void __set_page_owner_migrate_reason(struct page *page, int reason);
>   extern void __dump_page_owner(const struct page *page);
> @@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *page,
>   		__set_page_owner(page, order, gfp_mask);
>   }
>   
> -static inline void split_page_owner(struct page *page, int order)
> +static inline void split_page_owner(struct page *page, int old_order,
> +			int new_order)
>   {
>   	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, order);
> +		__split_page_owner(page, old_order, new_order);
>   }
>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
>   {
> @@ -56,10 +58,11 @@ static inline void reset_page_owner(struct page *page, unsigned short order)
>   {
>   }
>   static inline void set_page_owner(struct page *page,
> -			unsigned int order, gfp_t gfp_mask)
> +			unsigned short order, gfp_t gfp_mask)
>   {
>   }
> -static inline void split_page_owner(struct page *page, int order)
> +static inline void split_page_owner(struct page *page, int old_order,
> +			int new_order)
>   {
>   }
>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5d4b7c17b9bc..b2df788c11fa 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2933,7 +2933,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	unlock_page_lruvec(lruvec);
>   	/* Caller disabled irqs, so they are still disabled here */
>   
> -	split_page_owner(head, order);
> +	split_page_owner(head, order, 0);
>   
>   	/* See comment in __split_huge_page_tail() */
>   	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c31a468fe317..cc41341c08f4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2652,7 +2652,7 @@ void split_page(struct page *page, unsigned int order)
>   
>   	for (i = 1; i < (1 << order); i++)
>   		set_page_refcounted(page + i);
> -	split_page_owner(page, order);
> +	split_page_owner(page, order, 0);
>   	split_page_memcg(page, order, 0);
>   }
>   EXPORT_SYMBOL_GPL(split_page);
> @@ -4839,7 +4839,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
>   		struct page *page = virt_to_page((void *)addr);
>   		struct page *last = page + nr;
>   
> -		split_page_owner(page, order);
> +		split_page_owner(page, order, 0);
>   		split_page_memcg(page, order, 0);
>   		while (page < --last)
>   			set_page_refcounted(last);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index b678f7a6e702..033e349f6479 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -306,19 +306,18 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>   	page_ext_put(page_ext);
>   }
>   
> -void __split_page_owner(struct page *page, int order)
> +void __split_page_owner(struct page *page, int old_order, int new_order)
>   {
>   	int i;
>   	struct page_ext *page_ext = page_ext_get(page);
>   	struct page_owner *page_owner;
> -	unsigned int nr = 1 << order;
>   
>   	if (unlikely(!page_ext))
>   		return;
>   
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < (1 << old_order); i++) {
>   		page_owner = get_page_owner(page_ext);
> -		page_owner->order = 0;
> +		page_owner->order = new_order;
>   		page_ext = page_ext_next(page_ext);
>   	}
>   	page_ext_put(page_ext);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


