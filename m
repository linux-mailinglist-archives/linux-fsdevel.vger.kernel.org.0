Return-Path: <linux-fsdevel+bounces-65207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45584BFE235
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6B4E96AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636D2FAC07;
	Wed, 22 Oct 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWBBobSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A192741DA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164250; cv=none; b=P0YadZe0d7WggiH+y6DDiCVx4wN6zQV/ZBvGlKMVsyZ1mCu3EyVbzpiVcwV7432DW7p6aQ3E46ExRhgfxsAKk+YjvGQQ1kt3mp9vwKPzlTkKjbJOSEa/HAxYhb861wCL5MU9XCcd4hk0fGDvbj/KIMQ8qheIPQ90xDBHoiPiULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164250; c=relaxed/simple;
	bh=YRaaYG5cLrkW+pKoke0z7upiEKw/k1aav1Pnb7juP7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsNHbP0ohZ9Q/m1GzzFLfy/98GOV14AISj3nDwE7QCTTIk9b2ne17KSxvWpZ4c8R/KiyhH2T/92p+gX+zc+gF0cumjTyPd/3n1zk4tMfJfpGBXLtcPeSk5ulbxfpPjriRQbRRrrBbz+vy6KuEasPS+JM4UmFCtyh/UgKE/cffJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWBBobSa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761164247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vC+s+xeMprR+Ip6ri6xLPS37We7Gp0CsGRiTv6yqlJw=;
	b=iWBBobSaJmGEN9kCTApW9OObrZkx4F6QAfKy6ydPPApFYCX1TWCA53lM72sRllQyZWpMLp
	yryWS31K4tyb/N/pcKPFitzEwUnyYjW/YQsRMufJqoL7ETM80NwBn9yrTXwcAQi14cbW5t
	ZuhwBYA8HBsE3Ie8IOwyRYfLTamEK98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-7x0xyyHlOKyp8YXukpOffw-1; Wed, 22 Oct 2025 16:17:25 -0400
X-MC-Unique: 7x0xyyHlOKyp8YXukpOffw-1
X-Mimecast-MFC-AGG-ID: 7x0xyyHlOKyp8YXukpOffw_1761164244
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471144baa7eso119985e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164244; x=1761769044;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC+s+xeMprR+Ip6ri6xLPS37We7Gp0CsGRiTv6yqlJw=;
        b=qDP+eTJd/sy7oAsP2g+uSPVic9dajE1u1cKjtr2KVrUi6jI/enDzWD79uzhqCwS1mT
         6EfjQQL8L1gGZ1ouzf/revOFTFPmwCg3a/inGvegFtWcRJnBpQNG8aJ4op+E/Adr8b5J
         huP38IU7JkU5/1fX7XbsIBrA6fDd5cBHLkNSpugl0mhm4s9/bOXWBwj22vX6wle3v59M
         JlzJvGueqEAosjj/Q+N0lsBgoMmPGuiJs5zhz5Ep2WRte7sYYyZL+S1Xn7piq7aftBUr
         wDqRoLY1QUkRm8dMRUbhEx8CX9iKHwJ4tCNU2xXSvsyZ9hKkx52bgOURn29zBk3gqGbx
         oZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUKDSld+LpiccAfXwMd1vNRtEEQgiNkLsGI8Q4sltB38IglfaxZdKqP2jCFHEVZjvyhoWGDbD6goWSHMKKG@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRzofJ3pPxdSWQ/6HhS+afKcN/SScBYClZJiRZY7qpD8j6vIh
	PGwVoX2ceGFW21h7MiH3DCcW0sz/C52WqhYFQ21Zh00VqGzRGfGrDRohy8g1jgC6dpjREeOllB/
	yAKyD8dejutzWGNJ+t/1oc6qVMDm8J6dAgyTI6DtfplRL3khvmdentN8RaBW+7QHOmnQ=
X-Gm-Gg: ASbGnctjTivVznHvzIJnC6tL/KLQNwcnBjnHedDO07bQXXPMCyudo11hShOYMQ0smjS
	W9PydN8Xn9oWSHvqKOJuH2oC5vnX6AZfi7Du9zYcNlgQyYFmuNvfH1r1IlCO8DUCRYD9VNor+PA
	qlN+jU/LVjUcVxo59j6QbERHy++OdO0GnDApQAOy7lAjuEKPUK1n1nT9bCmLa9XaneyDOxh+zft
	bwio935Xo7kjc85pElL0wSEPuOODdf6Wdv1Xq1eprmpskwNY+Jwx/KUxzTWExbvNXxdRcrPGCWO
	SPCnH/XQhgaZKOYhZZ8EJtM2K+s3Qp+TA+XpJ9U/X0iv1vns4keQ4M+JNAeX7MZZu34aNSyQw0c
	TpPm44syZb1UVJTM6c/Mn0YSLDdLGyqmMoJtv5ZTHhdD/Rc38hz8rFmOPGMoDbAadBAGHD7Wc8M
	KoMs0IP6BGZjxeNTgnWT9rZz80f2I=
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-47117872663mr178764695e9.8.1761164243935;
        Wed, 22 Oct 2025 13:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJhFihxtaIrVrrQyehfH2+8Qrs+EvwAFrqmTS6AiWmlrhAWqEm6qvu5GsS/mZ0b6O2CjvX2Q==
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-47117872663mr178764385e9.8.1761164243518;
        Wed, 22 Oct 2025 13:17:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm68385365e9.17.2025.10.22.13.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:17:22 -0700 (PDT)
Message-ID: <6279a5b3-cb00-49d0-8521-b7b9dfdee2a8@redhat.com>
Date: Wed, 22 Oct 2025 22:17:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm/memory-failure: improve large block size folio
 handling.
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
 <20251022033531.389351-4-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022033531.389351-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 05:35, Zi Yan wrote:

Subject: I'd drop the trailing "."

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

This is not a fix, correct? Because the fix for the issue we saw was 
sent out separately.

> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/memory-failure.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..40687b7aa8be 100644
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
> +		int new_order = min_order_for_split(folio);

could be const

> +		int err;
> +
>   		/*
>   		 * The flag must be set after the refcount is bumped
>   		 * otherwise it may race with THP split.
> @@ -2294,7 +2298,15 @@ int memory_failure(unsigned long pfn, int flags)
>   		 * page is a valid handlable page.
>   		 */
>   		folio_set_has_hwpoisoned(folio);
> -		if (try_to_split_thp_page(p, false) < 0) {
> +		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> +		/*
> +		 * If the folio cannot be split to order-0, kill the process,
> +		 * but split the folio anyway to minimize the amount of unusable
> +		 * pages.

You could briefly explain here that the remainder of memory failure 
handling code cannot deal with large folios, which is why we treat it 
just like failed split.

-- 
Cheers

David / dhildenb


