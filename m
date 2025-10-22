Return-Path: <linux-fsdevel+bounces-65205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA7BFE1FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B6B3A8736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D82F83B2;
	Wed, 22 Oct 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuro5jnR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B202F8BFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163783; cv=none; b=efwOGKiIoT2WnJDnc9vai6XdXcV55TS1/oGVqZLkoK08eR1AwdhgdeV14VBce+DwupSWDwIl7u6fdMm4JFyZPlHafFBQi52NsvfGS6blFQOie6hU7jCQ+RL85P+4+kG8R2DmImCctF0wS6c9jecLZ2xdBh8tWQg5BZyTpawRb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163783; c=relaxed/simple;
	bh=+gKvWEAhNp2p6hG9E4kpfgsuz952AQjuSk7lPZqtluA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlpkRSibNqWKvS2+7QHAF1uS0ZpXbUTqLDvykAJImhwr8YqrhGrqwCnMVqX2NoITTG0HNjY/bB8Aob8cPIn9qSXSDsMsQIQYIz9aCcPnZsnj9fk4fNn91CPTpLV9Qo9jwBjhARmQIBXe5/hAhe83IZ62V5tIOfjsEszJmOXhqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wuro5jnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761163781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dUeO/YtpBDjpNP+/Rv4SHJERka//cgw1906gVbxjijk=;
	b=Wuro5jnRfi2UyvraNyUEWC/8py3yLarbK1Zi5LzoLoJQiIThwHfBZC3IeUUD6sElmz+r74
	wpqCIZLxV3dJ8yFMu3olGMvJO2U7shr9fqr80P49fVGMIRxLYPoy3LLS3brjeGMTf6l5A9
	9JnT6buI7vz4+woRwZF7DMg6162PCJs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-8x55FnWqPO2xm8_8CVUpHQ-1; Wed, 22 Oct 2025 16:09:33 -0400
X-MC-Unique: 8x55FnWqPO2xm8_8CVUpHQ-1
X-Mimecast-MFC-AGG-ID: 8x55FnWqPO2xm8_8CVUpHQ_1761163768
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso30525e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163768; x=1761768568;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUeO/YtpBDjpNP+/Rv4SHJERka//cgw1906gVbxjijk=;
        b=j3PMBQaIjgDVY/v332kIWA1oJtQCAvkSkDvlNr2wD12kG+Q7Wb6qHE5P+02qx9I6TY
         kei/65rGtXWwWZMi1SesWEKrRmsXc/CuYi76N1SaF/HjH5i8itmQkjgQ12b5si30foqv
         Rt0EhH1r5Pq0Fzs2KJQ4Pq9BGrKr8Pgn0eEqbpN7PAMaDYIUubxU5A0gFM97I/UdOkMW
         VBAkbjO1eEl0yL5c2ljz428MjafEPIswimIzRNkaFXXGeLfowzt+IfxnOCymvssajEQy
         DhpMFcxIGG/yoE6Z3WML6rg+ZDo2sA3C+M1hU9Vw2LoHqAu2v6BBVd78+BXgAh41y6tt
         x3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsDOBi1Gl1TkAlm2RC2tEPP1ansUpv+tbw5yEEkrMjs2kXzYwhFKS/aOCCMIC6ptaCbLjBiDkcJHozbCfN@vger.kernel.org
X-Gm-Message-State: AOJu0YxyMTgVfqLUckG6Hn2AnalvuJmvBD0knmq4GLFhcKZQ1Co2F5PB
	YKIFSpSsHVvcYyUkLPXlzAtWLaulOvesQJ1BxzzUKvkqEd4vQ/TWPl1WvhFJ6t3LoolK7YE1CLG
	v9OlBwVmdd8sQ3rZ12zB9whM6nHIlMtnRksG1eHy1n8zW9kM891/fLnnHdYG8bvbYZdg=
X-Gm-Gg: ASbGncuul/8Ya8/NLi48jvGyqysu04L3iMieCrXhByIgmXi+Vs4vGdRkiygWwpJvs3/
	ficBUWXdaI4o8ex6dh7xOeZFCQJsVF9WE2VxL+tcKR9kcMcRI+yEtojhr9rE599TJz+HNO8nWWz
	q7BrNGynthduUQClORPzCy7bXVBETxoZRt5BeZzpLeh/mbIaVnT96n0JcPo1z8T5zXn3XJdYft9
	B3QXzAVnsWu8TYdS/PEbN+EMRsgOq3xXv1k4NDdEYUzAyKFn3eHTYZqbo9rn9dwDxObAgQLUNhM
	UgX/pwfvvg8iaPQWMQ54p0tZ8YKmmUGBzS86xP06hHsJGKnvMKO1H32CnO4cvt7IDS6qslK++50
	Yjhe4SyurxdxeEQovpTmjKLK58r9iKfPm+WAPOCd5YxhuauyXaU0R3hMkQP4VF0ACI/t/kg5vw6
	1V+M2iCAD08Z+zIM6sI0EH0o+OAds=
X-Received: by 2002:a05:600c:3b04:b0:471:350:f7b8 with SMTP id 5b1f17b1804b1-471179017damr146055525e9.20.1761163767936;
        Wed, 22 Oct 2025 13:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeJmZJAMcww8F4mWD3Mdmim44dMWfgL8QKaixUaVMVlxDl0JJqaHLVxenWhQsfEAEk9uyhKQ==
X-Received: by 2002:a05:600c:3b04:b0:471:350:f7b8 with SMTP id 5b1f17b1804b1-471179017damr146055395e9.20.1761163767473;
        Wed, 22 Oct 2025 13:09:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eb549sm144198f8f.41.2025.10.22.13.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:09:26 -0700 (PDT)
Message-ID: <d3d05898-5530-4990-9d61-8268bd483765@redhat.com>
Date: Wed, 22 Oct 2025 22:09:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm/huge_memory: preserve PG_has_hwpoisoned if a
 folio is split to >0 order
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022033531.389351-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 05:35, Zi Yan wrote:
> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> after-split folios containing pages with PG_hwpoisoned flag if the folio is
> split to >0 order folios. Scan all pages in a to-be-split folio to
> determine which after-split folios need the flag.
> 
> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> avoid the scan and set it on all after-split folios, but resulting false
> positive has undesirable negative impact. To remove false positive, caller
> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
> do the scan. That might be causing a hassle for current and future callers
> and more costly than doing the scan in the split code. More details are
> discussed in [1].
> 
> It is OK that current implementation does not do this, because memory
> failure code always tries to split to order-0 folios and if a folio cannot
> be split to order-0, memory failure code either gives warnings or the split
> is not performed.
> 

We're losing PG_has_hwpoisoned for large folios, so likely this should be
a stable fix for splitting anything to an order > 0 ?

> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc65ec3393d2..f3896c1f130f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3455,6 +3455,17 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   					caller_pins;
>   }
>   
> +static bool page_range_has_hwpoisoned(struct page *first_page, long nr_pages)
> +{
> +	long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		if (PageHWPoison(first_page + i))
> +			return true;
> +
> +	return false;

Nit: I'd just do

static bool page_range_has_hwpoisoned(struct page *page, unsigned long nr_pages)
{
	for (; nr_pages; page++, nr_pages--)
		if (PageHWPoison(page))
			return true;
	}
	return false;
}

> +}
> +
>   /*
>    * It splits @folio into @new_order folios and copies the @folio metadata to
>    * all the resulting folios.
> @@ -3462,22 +3473,32 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   static void __split_folio_to_order(struct folio *folio, int old_order,
>   		int new_order)
>   {
> +	/* Scan poisoned pages when split a poisoned folio to large folios */
> +	bool check_poisoned_pages = folio_test_has_hwpoisoned(folio) &&
> +				    new_order != 0;

I'd shorten this to "handle_hwpoison" or sth like that.

Maybe we can make it const and fit it into a single line.

Comparison with 0 is not required.

	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;

>   	long new_nr_pages = 1 << new_order;
>   	long nr_pages = 1 << old_order;
>   	long i;
>   
> +	folio_clear_has_hwpoisoned(folio);
> +
> +	/* Check first new_nr_pages since the loop below skips them */
> +	if (check_poisoned_pages &&
> +	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
> +		folio_set_has_hwpoisoned(folio);
>   	/*
>   	 * Skip the first new_nr_pages, since the new folio from them have all
>   	 * the flags from the original folio.
>   	 */
>   	for (i = new_nr_pages; i < nr_pages; i += new_nr_pages) {
>   		struct page *new_head = &folio->page + i;
> -
>   		/*
>   		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
>   		 * Don't pass it around before clear_compound_head().
>   		 */
>   		struct folio *new_folio = (struct folio *)new_head;
> +		bool poisoned_new_folio = check_poisoned_pages &&
> +			page_range_has_hwpoisoned(new_head, new_nr_pages);

Is the temp variable really required? I'm afraid it is a bit ugly either way :)

I'd just move it into the if() below.

	if (handle_hwpoison &&
	    page_range_has_hwpoisoned(new_head, new_nr_pages)
		folio_set_has_hwpoisoned(new_folio);




-- 
Cheers

David / dhildenb


