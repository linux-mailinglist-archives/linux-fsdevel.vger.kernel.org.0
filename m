Return-Path: <linux-fsdevel+bounces-13859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09316874CB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D581F23A94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EC3126F05;
	Thu,  7 Mar 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D75O5D7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98085277
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808745; cv=none; b=TNVw/jChiC0OfEASOdWDtyI7UeFuR7bP3vAi1bLnrF5wBzrY59rLTVszlXVZmgOYeDZw1xvcIzVUFWilHpyl5R+gsq5V9dGhIZ2KI1pHCq4BAIi6bjj+tzwY0WKHtiBG4jH3jOE0+Rq33tbChRHl/lJyaSnFjBkSojQTAs9H1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808745; c=relaxed/simple;
	bh=8UOBs8aO/kTgyMHp6wLoVqSvUe8xn0ai/cATyleO8pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/atdjq7kiNy+azQ98XUFv9b29VWs39qpxLLpLkyluABaWX+U+MxW1+04dqIRDWZibyCpbEv4PZh/UmsIJYqJMNco0d9BuQ1CfdfujU8plVJb4UAuUvkU0B9oCAB9hpLptPo6GoE6KkWhYKrJEkVqBE9de00kARoTu30r4vHIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D75O5D7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709808742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t1lbZwtUExa5zCAHzjEb8QruKJQqDEzc7uaBj6FAG0U=;
	b=D75O5D7mpIQ2PSQUQdp9O8JuzSklLW4HAOTxOAgKNYlsuKSFCll71dScBv2ACl7PB9C5ys
	JBvTc0ygKaAXgMimOLkcCpXq4DuG/LRMvFpHLRTGbteW3obJyrsrkEV5AwU16kjAnL8jHf
	aioo/++/bUWeXM9y2UK7ocaU5boia80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Lc1kZ3w-MPuXm0fSf4iyzg-1; Thu, 07 Mar 2024 05:52:20 -0500
X-MC-Unique: Lc1kZ3w-MPuXm0fSf4iyzg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d782af89dso277912f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 02:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808739; x=1710413539;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1lbZwtUExa5zCAHzjEb8QruKJQqDEzc7uaBj6FAG0U=;
        b=UbRaf94ZQ0+bNJQFNomyP7ryCSjRqfN2OMV7zbpAUrhvZ9KwzoCvWMvJ9/Yhws4Fyi
         +14lF/EdZ5TJIqo5FB+S8tUIUrl774aSQ/YvbfG04tD+yeXtzIao3pW89Qjhc5K6vkKT
         8/bfCAQUXabVrDEiz2OnpIoYsVKG8oJ2Tf4ZFeuILQJUY4QQ7BypCtA9bCdnYjEbIGrh
         g+UMMJuypawf9xPykDh8Lhq29Vk1Hn3vwbhjGq3IirAXpOcG3SED8T0Iu+WGVysp1iql
         DZEBOrMucSyBUt1ObEZtHSmETtiaxSTFxnZ+Qc0LAa8CgV5Kzuam7hDtaJZzUYAsNWS9
         PP2g==
X-Gm-Message-State: AOJu0Yz3HgdUzr9YDOP0vMZzUkX5L98gmRrha917GbcYNzEuQFovuE2u
	fjNGM0Andb3M2wuPuhCLUD6j663dVGD5wpqyA+Y3Ua67zSKaOQqqPEL8BFG/LpDj5uUn5Ohdzta
	auEnsUXRY0KkjICXJ1S9GYVVcwHlv5EObVbKwYBhBm+23/lY8QyUYQdoTA9r7SXk=
X-Received: by 2002:a05:6000:1149:b0:33e:64f3:65a5 with SMTP id d9-20020a056000114900b0033e64f365a5mr859534wrx.52.1709808739338;
        Thu, 07 Mar 2024 02:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJh3+9NXoe+Qo4JMKp3+nHbsmiyELlTfMtntswBNzGDWOsJByVWEGlKIAahNZ3iA13xoM7+g==
X-Received: by 2002:a05:6000:1149:b0:33e:64f3:65a5 with SMTP id d9-20020a056000114900b0033e64f365a5mr859517wrx.52.1709808738905;
        Thu, 07 Mar 2024 02:52:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b0033de2f2a88dsm20096450wro.103.2024.03.07.02.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:52:18 -0800 (PST)
Message-ID: <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com>
Date: Thu, 7 Mar 2024 11:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, upstream+pagemap@sigma-star.at,
 adobriyan@gmail.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com,
 hughd@google.com, peterx@redhat.com, avagin@google.com, lstoakes@gmail.com,
 vbabka@suse.cz, akpm@linux-foundation.org, usama.anjum@collabora.com,
 corbet@lwn.net
References: <20240306232339.29659-1-richard@nod.at>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240306232339.29659-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.03.24 00:23, Richard Weinberger wrote:
> Is a PTE present and writable, bit 58 will be set.
> This allows detecting CoW memory mappings and other mappings
> where a write access will cause a page fault.
> 

But why is that required? What is the target use case? (I did not get 
the cover letter in my inbox)

We're running slowly but steadily out of bits, so we better make wise 
decisions.

Also, consider: Architectures where the dirty/access bit is not HW 
managed could indicate "writable" here although we *will* get a page 
fault to set the page dirty/accessed.

So best this can universally do is say "this PTE currently has write 
permissions".

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   fs/proc/task_mmu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..7c7e0e954c02 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1341,6 +1341,7 @@ struct pagemapread {
>   #define PM_SOFT_DIRTY		BIT_ULL(55)
>   #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>   #define PM_UFFD_WP		BIT_ULL(57)
> +#define PM_WRITE		BIT_ULL(58)
>   #define PM_FILE			BIT_ULL(61)
>   #define PM_SWAP			BIT_ULL(62)
>   #define PM_PRESENT		BIT_ULL(63)
> @@ -1417,6 +1418,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>   			flags |= PM_SOFT_DIRTY;
>   		if (pte_uffd_wp(pte))
>   			flags |= PM_UFFD_WP;
> +		if (pte_write(pte))
> +			flags |= PM_WRITE;
>   	} else if (is_swap_pte(pte)) {
>   		swp_entry_t entry;
>   		if (pte_swp_soft_dirty(pte))
> @@ -1483,6 +1486,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   				flags |= PM_SOFT_DIRTY;
>   			if (pmd_uffd_wp(pmd))
>   				flags |= PM_UFFD_WP;
> +			if (pmd_write(pmd))
> +				flags |= PM_WRITE;
>   			if (pm->show_pfn)
>   				frame = pmd_pfn(pmd) +
>   					((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -1586,6 +1591,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>   		if (huge_pte_uffd_wp(pte))
>   			flags |= PM_UFFD_WP;
>   
> +		if (pte_write(pte))
> +			flags |= PM_WRITE;
> +
>   		flags |= PM_PRESENT;
>   		if (pm->show_pfn)
>   			frame = pte_pfn(pte) +

-- 
Cheers,

David / dhildenb


