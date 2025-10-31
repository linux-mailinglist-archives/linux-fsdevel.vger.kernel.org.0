Return-Path: <linux-fsdevel+bounces-66556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D961C23A08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 08:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C521A2492E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568E329C67;
	Fri, 31 Oct 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU97ZAEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB9328604
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897503; cv=none; b=MFtHh7JWzpRtauCUr9q0kAXgFfD+wgINJBzxBwA3GxFZD+78BKYR3khdRPylX8pDIjZHR0Vp445HaP/UCfBsEvBtwm4NW2MXbssiCwRpzGbljRxRM3Qnb0LNELMtTOx5c5op9aeXSxfZjx7DpmW7JMZ7fe2zqHNaNKz3FWe40sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897503; c=relaxed/simple;
	bh=VOyBD4y6/aRk3pcgc0Rldubfg8OfqWKep+3yPsEdR9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJbAjbSlaMRTNuMPqUv/8GnyX/iAL4XYBBA/KfLImnyJXjq5HgGi1+wVKoQZ65+p5XHU439qny1rEZcH1HuxANw682E8l11RSgTL82z8SFOKinj6H+h7woxgUxD6Ua1VP7Gj81briQmqOahgIKL2KDXgqNOfOBFwAVF0fOLtn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU97ZAEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761897500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S2eS52tk9i8Cbqs2+QfmKwdWaz22X5NSaWz8+XqnQXE=;
	b=aU97ZAEW312FMy+0zH2yE8DfdvhI6wtp+wmJK2cva5R86im2VXibUJGmcpAcS+75CvwJ1g
	p6y84Ky7TdaDqltAcafPRmpH1kIJt8Aw/f8M5T9rPTdymsUNNKE3jC6G1XRKKjmSJUiySW
	tO1CUEfNat2oZqfj9EXt9IISL16hJ2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-zZ3HeHlWOM6S229ITNt70A-1; Fri, 31 Oct 2025 03:58:18 -0400
X-MC-Unique: zZ3HeHlWOM6S229ITNt70A-1
X-Mimecast-MFC-AGG-ID: zZ3HeHlWOM6S229ITNt70A_1761897498
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4298da9effcso1863429f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 00:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897497; x=1762502297;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2eS52tk9i8Cbqs2+QfmKwdWaz22X5NSaWz8+XqnQXE=;
        b=Lo4wsqT7zdJfa+Tnz+uzDnlJWsrBAJTt2vOhjz8wBj05697x6XER8ELteVZmD7fKz/
         aCh+D3vDlg3WzFIx3umr6wj/9P+NpJHQ7UvS+SlfItHwNZLgNRQ+z+uDOAcXhvgnA/3v
         CYXLK7UQY2GLxhL+/B7FQsJHqekF219LaUqnfNrhipTAon6OHRb5LLcaTBW9igaMo7gn
         ELtrcG/EmB8etHKk0BPnbBu1EjZUO/fUKQapVcGHVCE5QntD1hMJO0JNLYmKgkzZ1NZ1
         Z/5ao0G/olbW1wncbrK7scxGReFm52TFdAy9AaqGap3H5emXE+divMQODB3CRLMyWgzH
         vWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHsD2Ii/MnnSOCxDVFFEKDwBJgXtus80wum9EVF6ddoqgCWA9+9shSmtV+fWyzn8lXtsKAHEvMmR6vIoO1@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG+VwiruZEyxHE09P/v6a3evF13id92PYkXpeIr1v+I0L5Jhv
	sMdzH07nRjGzJf9meDZSdDgIc/P81Gowft6oLG9pPPx7HLz/cJGPekEiLSWwz+LloNQ1UVk7YqL
	d1VF6dGEUH+KxeOZ2BNzQZPQzdXxosxxWyaOUyY5Bpxt2XBRIa1ZmfBwHSsl+uLaY2dw=
X-Gm-Gg: ASbGncs3iVQjFogh31xkoTXan1B/isN2NOeNfk5Uz58ZjrfLqRQ2rsBNW7e/WW9hEBX
	yZBfVbtJdZvMhfie713VykcWOWYFKLdMes9WWHYaA4Gz1hewA3PJOXT2nNRDl9XYEXz3fcNLEXq
	Q5Icgj+V8kAvI65RrTukkSPno/yTwyrFTJjYFaOb6AwQQhawHJj2gmGE4FULjlWQpCym2DCeXnY
	4gyzuUOrtChca56BFkQD1yrPe7GKvZ5HpR+CFbm4jIoI0wji89999Hb42+rhD3R88yJXZGJYZ09
	Z3KUJQl5bc54QAzdjpKdEtFjHyEHU490JRtqK3l/tB53gr2PLQsP62U22hNuVKIsX2wVHV13TJT
	S0xnLTLoX8lOuNWdpq7jv0BSsj2BUwLQ=
X-Received: by 2002:a05:600c:c16b:b0:477:f9c:67f5 with SMTP id 5b1f17b1804b1-477376d769amr4379365e9.16.1761897497549;
        Fri, 31 Oct 2025 00:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNwemgOiv3lHzYhEufVFBAYrSQqe//rYSzgVvmn4tkq7hUvG4q9BL5K3qCkZTsiEl6FUiWFg==
X-Received: by 2002:a05:600c:c16b:b0:477:f9c:67f5 with SMTP id 5b1f17b1804b1-477376d769amr4379075e9.16.1761897497158;
        Fri, 31 Oct 2025 00:58:17 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f1cf.dip0.t-ipconnect.de. [79.241.241.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm16398705e9.5.2025.10.31.00.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:58:16 -0700 (PDT)
Message-ID: <e1562980-b9df-4aa6-a44f-185a7c586b33@redhat.com>
Date: Fri, 31 Oct 2025 08:58:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
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
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.25 02:40, Zi Yan wrote:
> When caller does not supply a list to split_huge_page_to_list_to_order(),
> use split_huge_page_to_order() instead.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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

Scanning this once again, I guess in the future all these interfaces 
should rather be folio-based, and if we want to split at a specific page 
where we want the reference to be held later, pass in a page:

int folio_split_to_order(struct folio *folio, struct page *page,
			 unsigned int new_order);

With the hope that we could end up with all folio split functions to
look similar in that regard ... and remove all the "huge_page" terminology.

Of course, that can be done as cleanups on top, because there seems to 
be quite some inconsistency already.


-- 
Cheers

David / dhildenb


