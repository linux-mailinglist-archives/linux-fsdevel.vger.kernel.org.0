Return-Path: <linux-fsdevel+bounces-11522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624C8544B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0341F25527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE0111BE;
	Wed, 14 Feb 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnfpYJ9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AFC13C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901930; cv=none; b=WNAOkao4MbF6oQh58HPRhAxL8upGCZK9D79PwqXLMvPMMh0AEeuLV7Ftr0BP5cR7uEwEDeljVR02d6EDMKVuuqHwwxkawHhLq8L/6f16DK+fSfHokdrqNi8/A5EtP3AiU1xMdFg60+3WqAfQEzUj/lExeq9k43xPsv6DPlT+T4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901930; c=relaxed/simple;
	bh=b/mhMZ0zKqCT3ertcABmL3CKUgHpNWzDTwLWzbWXPU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKBsbKanPQD6e9N3G5LA8SD33KbVygXv+NPT6CycQRtVpROF1EImfp+FqltniCqYPpHs61n3ZKm/ShtviIKkVs0k7iKDhTm64h0fJLo23IywmBZywVRUy05KzyjI+jGLGrgCG5G10JOfL691bZOm6BszCaO3eQvDiA6Z3NxzMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnfpYJ9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707901927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VZA6DFg+WwA52lCBTWxrutolHXxVdoWwm9k2EKmKknw=;
	b=YnfpYJ9haw6IPWosF0W1mmD4ydIJT2jB4T9FpY6rOkT+HvZI5tLAraOPXjbP8+T+D/wiGx
	4L7iXNUmNmGbWRho7/ZFFe2vDymsn+Q+FmXLZrwMOFAEuQzaEpg/ia0/ouaZXGvMM06Icb
	22KAIXd5QOWWc16bGre/WtYRaxuf7eY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Fh50xFDqPxm0ZZncQkHSGA-1; Wed, 14 Feb 2024 04:12:06 -0500
X-MC-Unique: Fh50xFDqPxm0ZZncQkHSGA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411ce6e7643so5995085e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 01:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901925; x=1708506725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZA6DFg+WwA52lCBTWxrutolHXxVdoWwm9k2EKmKknw=;
        b=wkxjWFWuhFvdVATuiSx+RsdLIoEUC/IB9b/05Ef9IXm6LhYsh7BGPNetL7Iq2JzkYc
         DwvcF+Cs9mPNStcHCmiZm9tBUugCE/dwB1rODqRl43R5nqMaAgg3mPIJegMNzqqgqrop
         Qxq+DReIOp4utLSe2IKO0T0BtkULsUJLHfX4o0emcs0KMeBLujSBCiaaqWUzANEpgRfA
         bI/hOu29pbb37W8TUrKqdanD76WaP5lHPgR7Qiv981sR5DKNouVBT+Fly0hVjMRXwhCA
         HHpEN7l0bWFoqL4cyrdmrvzaGv87vXZp1r6MhOUYDnLeJwr5rb1RnUc7ZKMaSaa1W2Uh
         6yWg==
X-Forwarded-Encrypted: i=1; AJvYcCUQcOFiXk3Kq2iVnLDGxML0TJU2CxOzFY2pVzdxmt/EgM5PYuRLQvoVIQGfjlgJDbexqdgKH4KOjeuehJJxaEduFkWOFuxABD1/WlwxNw==
X-Gm-Message-State: AOJu0YyMdofz8xU9PQUJDmcrTdVutVkbMDUDXjO3A7az+jXR2Ca2h6+o
	bvhSswT/HaV2nUw2tQh7N6DtwFNd9HCtval1o9bUpftKEBcVRRgnuD50BmekI/rlVv2RdADbyYb
	zA5J8dSRFeIi9mz9n74VygJDAoav4u6XfXiWw17pc8xCkahEabDHm3jNbG2HpnhQ=
X-Received: by 2002:a05:600c:4f92:b0:40e:f9df:3531 with SMTP id n18-20020a05600c4f9200b0040ef9df3531mr1616937wmq.8.1707901924980;
        Wed, 14 Feb 2024 01:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhZev06DT+wQwCDjrhbCZX5g30BdTp6oDhqJnXloyJB+rxmBte2E2NuMdQoDmK9WLQFWbF2g==
X-Received: by 2002:a05:600c:4f92:b0:40e:f9df:3531 with SMTP id n18-20020a05600c4f9200b0040ef9df3531mr1616906wmq.8.1707901924586;
        Wed, 14 Feb 2024 01:12:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqS5g1CamuPWuk5EE/YsfGdQ1wTy8LozYCBRvSt2P3zg16qUWY8dW+1xuaxuONCVcCdHJw3/UW+h98SehqzecRpIqVlzAg31i+hD3r80gW1+6nMLemeKSOEJbS8/HrqPqly9CCdvTw1mthL8iW+M/PxzA6fh5IxXwBdhsPzhqzLSCs7uGOkszPxvApMK1WjazzELLLqw7ZiRHgfty3p3sh/sr62OCU3r9R/TGfJb2ilnhapoqu4z7m50VpIGlcE1EOeDQ2g465iosRXhYo/Tfr+wZ094zbS35DEzLzTKXBfXl/EHR8Uy1F7hHeLZ2GUEJ4F+TnR+VBUsDkrXUcIndVNf+luwxNPKSP1C4MqbTF+WOXzB1uOoFWR0BEYXvnV6OmYCr0KZZQYvUSGUpuoS9gXqJmtyT+S/jqpjMejsR0KslcYGZezqp7PxCAeSO2LWeyWrz2J+HbHvld8T6tp67K7wrNNrfY1c2ipxFVhSvdIRs4ZQVc/qJ73yzPGrQSV7M+uOqtrjp9/lUs4ZQAe3j3xn23CV3IbMhfaoM67TNynePh6EffyzumwL+H4+SAsXgH
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b00411e6243e70sm1308929wmq.12.2024.02.14.01.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:12:04 -0800 (PST)
Message-ID: <27691f5d-2218-4247-b688-cd16d46961c3@redhat.com>
Date: Wed, 14 Feb 2024 10:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] mm/memcg: use order instead of nr in
 split_page_memcg()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-2-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213215520.1048625-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 22:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> We do not have non power of two pages, using nr is error prone if nr
> is not power-of-two. Use page order instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/memcontrol.h | 4 ++--
>   mm/huge_memory.c           | 3 ++-
>   mm/memcontrol.c            | 3 ++-
>   mm/page_alloc.c            | 4 ++--
>   4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4e4caeaea404..173bbb53c1ec 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1163,7 +1163,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>   	rcu_read_unlock();
>   }
>   
> -void split_page_memcg(struct page *head, unsigned int nr);
> +void split_page_memcg(struct page *head, int order);
>   
>   unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>   						gfp_t gfp_mask,
> @@ -1621,7 +1621,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>   {
>   }
>   
> -static inline void split_page_memcg(struct page *head, unsigned int nr)
> +static inline void split_page_memcg(struct page *head, int order)
>   {
>   }
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 016e20bd813e..0cd5fba0923c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2877,9 +2877,10 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	unsigned long offset = 0;
>   	unsigned int nr = thp_nr_pages(head);
>   	int i, nr_dropped = 0;
> +	int order = folio_order(folio);

You could calculate "nr" from "order" here, removing the usage of 
thp_nr_pages().

>   
>   	/* complete memcg works before add pages to LRU */
> -	split_page_memcg(head, nr);
> +	split_page_memcg(head, order);
>   
>   	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


