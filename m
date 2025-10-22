Return-Path: <linux-fsdevel+bounces-65206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8CBFE222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6863A8BDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F22FB984;
	Wed, 22 Oct 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQJ7hA8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF82F99A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163995; cv=none; b=msGHLU2UMuhFtKAmiaO4JfRt7jZU+rbjbpqKI5R76rdvRewr3I2KKnv2SQ3SXMkya9WJa4/2g6GZv7hLMqE3Je6SD/jkxAUM6nrWDyW05UduTErvGWjayvtTY6udhwuW9v41QvmQG5XuZktddpzOomwpCEuys2PgRZdNlRWp2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163995; c=relaxed/simple;
	bh=ZeX1LuDnBfPCxTy1JXca9eWWigLWkrzMDGYEfCRHs/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohyp5VCg/mpjd4cNQevpiIfnHdGkTncEKWEVuFatjIX0n/BakHGyUFzm3nCTooXnUgQN656JSWXaRSlOT+Zmy1oBXvDD0yvqYRsHb2Jh/bgMk9dpRP9yn954l00jmoXLjZBD9KHLU46xYVB+lZa+pNInfC9NRe5L6hPxVCmbcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQJ7hA8g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761163992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFSmZK4gFSd0PHQz/xlqwyuF7ltItWEnpq4f0/0wTQ8=;
	b=DQJ7hA8goq4bJqFHr9BcwunIrsYNtMkybFshn3mA6inJvyonEkey8qWHycm9o4jF/Vu4T+
	sAqDELmXiY/bWWErnGRsiaPjmpwq/hWtupSgOWYfNNvDAizTb8NlmjFLhX0OgzFIAUOzGF
	raTp/lCOkPT7bsNgOOiY813ptPzOu0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-TnDhKn8kOuCRlqEw_2qRow-1; Wed, 22 Oct 2025 16:13:10 -0400
X-MC-Unique: TnDhKn8kOuCRlqEw_2qRow-1
X-Mimecast-MFC-AGG-ID: TnDhKn8kOuCRlqEw_2qRow_1761163989
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475c422fd70so44275e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163989; x=1761768789;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFSmZK4gFSd0PHQz/xlqwyuF7ltItWEnpq4f0/0wTQ8=;
        b=jVNxBQhrixH/J80gtP+srQSEyUcXC5/Y5F2hWoxV5vbYiyypGs0yGFK/A9pR9ETFip
         FxjdfN/eF5VaQp4vgzYjRYCnlBwj8aQL2OB5YYoUx4LGrpsRnQFTpvLOXYoqYmKySM0T
         CA6gH8WKeMFf+n53yoRsgQtF0TIynBmK9ApVShrKV+GFaFE5qTUiSbQkro/+Yug95Dqb
         DpjTA3Ixb7osZ3MWaTe0j7Rnc6/MyUWvYBa6XmJvMjBNi+rOnuMM9qMKN7Zhi+CJtLqZ
         TaKPer7ludCnl/UgZBhjs2pZOwOKCQY/QOfixlEipWPf5s2DUwOgRs8shDWBDnNrjzui
         BCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwuXTQEEiTdpzN48Z4xm/f+xuw+cYCw5avzrPwG22+19wxWy1V8NGNrlbk7FNQiRa3/LrOEpUF1HPYvvT3@vger.kernel.org
X-Gm-Message-State: AOJu0YzrH4PB25BuCX1V7txPq0y5e3Am/WQIwtdhchk8iYTscjOPPF83
	zFxNCe5vWDn507uWNmov0dRBz40J1B375BbrCVEexbm5j8MldMg8DQkjx0SaIpBW0kBo0Zjir3z
	ahJJG4fbmEgPN1vIbQsldamufqL8a63nmxviNBmwJGXcU5JtUlx9w+3lOKoOpaIJPi+w=
X-Gm-Gg: ASbGncumJrkSvvnQemgwHm5vnXGJ4tZhHs1Sw0gcRFIgADkGTCe+nWybhILUAcrQjGz
	WMeewynOu6uMJgiyWhhEVH4p0UQV0jVE6t96XLorVl9rJFNxeDiplRxzoEqxhQmRTDaFH+HuY/p
	2sEDaHwcpZpbaAi8aZSaRn1Z/i57veAe+TCaiTXPyXhMQ+pQ17rWeiTKKET1EJpLB1QKg/e4cVO
	mlZs1v9CIFrCzBt4aY/VPfTbX7p8SskpwjJJ9Pkohc0PfjnDEE5dC9D7haqM3509N8rcXBMp9y1
	DgIAD+pvdl++u5C/IqbkYeydY5OTZ4OiR8ByAr//+Kajj507y+hyoQ88lVbfgP4nq0s518mhr2e
	FnXAadqGjt/8okcwu6kQEY9D+I+2+zM0nW9ebgcqnWR505w9krI+r8Bw2qRV/ubGPUFT4RW9UaI
	jV39RwgC2VHtQRH716B3lKrEQj0BE=
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr156597535e9.40.1761163989365;
        Wed, 22 Oct 2025 13:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZxZ5g6TBCinUHJsu3ifBaIcG02y2noD8tegfqlqJZdwjDCU2wn8DQ8gbi106rA8kB0IfEHg==
X-Received: by 2002:a05:600c:1e1f:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-4711792a2admr156597255e9.40.1761163988959;
        Wed, 22 Oct 2025 13:13:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ecadbsm173105f8f.45.2025.10.22.13.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:13:07 -0700 (PDT)
Message-ID: <b63f9223-4c5c-4e2c-9986-02052a3d7f78@redhat.com>
Date: Wed, 22 Oct 2025 22:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/huge_memory: add split_huge_page_to_order()
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
 <20251022033531.389351-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251022033531.389351-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 05:35, Zi Yan wrote:
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/huge_mm.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7698b3542c4f..34f8d8453bf3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -381,6 +381,10 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
>   {
>   	return __split_huge_page_to_list_to_order(page, list, new_order, false);
>   }
> +static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
> +{
> +	return split_huge_page_to_list_to_order(page, NULL, new_order);
> +}
>   
>   /*
>    * try_folio_split_to_order - try to split a @folio at @page to @new_order using
> @@ -400,8 +404,7 @@ static inline int try_folio_split_to_order(struct folio *folio,
>   		struct page *page, unsigned int new_order)
>   {
>   	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
> -		return split_huge_page_to_list_to_order(&folio->page, NULL,
> -				new_order);
> +		return split_huge_page_to_order(&folio->page, new_order);
>   	return folio_split(folio, new_order, page, NULL);

Much more readable

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


