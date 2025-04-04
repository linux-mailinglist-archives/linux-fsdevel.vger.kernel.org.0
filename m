Return-Path: <linux-fsdevel+bounces-45800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B72A7C539
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74811189FCBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED91F5423;
	Fri,  4 Apr 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxYByMab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED21624E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800394; cv=none; b=uqdxQrh9/XVGzbAqEfdNHz7q0AVT92aFsrh/gQucQ520nrJEMx8ha7dh9U1g99FA/7XEV+zrYlSPJpOjpwdS+CB1AoR4pUzgHNLxtHTeszQ96BTHwxkzaq17+3kbcvr9E5qKGA1bMYvx5IMJbaIL5MQ/aLiiSRNAoqHLp8d/mZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800394; c=relaxed/simple;
	bh=w9mxxE+o8hf/9m+pn6mM9TIL+92Vh8m8dZFamW6ee6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGIamdR1v3uYq4C8n9AXUpm+7ShqvG2+rR0vQbhvAhl+MSeteVbHVNdjUqVpoYAe+DGG+AW6nUffkTkJZyiPO01nT68examjSccmAls9gDJWpdheMllQOpOWuSeiLDrGjXCkpkR8KQfbkWZbhgjERL6RNozeN/f2anwA6QsYRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxYByMab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DT50UaJCIq5HARWoxsA+lE7/KQIdkexcgQqBk8IUtYk=;
	b=RxYByMabiVEcO6wq8t2ZktSdGZfI+1h/PYgPraWwF8Td0ptXvEcJDCuiu2ZcazeAcJO45I
	hlGfF/K7ckMIvFta4U7NvxJH4TCmdaJWWHIhSvJWJf3ZAA1M1ktvw/MBh9acvtFCgZt65U
	IVORYTl7+X1PFeiPsYPFimotoYrmZHA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-4a8-J_O8OpKF9aktNbaIHw-1; Fri, 04 Apr 2025 16:59:50 -0400
X-MC-Unique: 4a8-J_O8OpKF9aktNbaIHw-1
X-Mimecast-MFC-AGG-ID: 4a8-J_O8OpKF9aktNbaIHw_1743800389
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so16277805e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800389; x=1744405189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DT50UaJCIq5HARWoxsA+lE7/KQIdkexcgQqBk8IUtYk=;
        b=UVC5b2Dv13d6Plp5H3xXt29dag7TviKw/4dWSAFj9e0vZN2m3+KCBma4PiLrORlo+N
         /qh6h0W11m9TBXc/05/XHAjtsfIj6hTvFCf/LJJ2YH9J8haD06lworkjMLleS6Buwc7G
         0Ir865iuk6iCig1AQx65DUQ9AmqzEGLMKuSPQu+EGTecOfv59RQcWX9XzI5VNUrRBUV3
         8gaRqLysmphrVs8EFdIJB93/RVTuwx61qVU2NYelCniirrk2NJsciZwkIa9MBuzGPNGt
         Irl7RRSTNlK4rV7tIX+xEW28ZFd+QLUq4cOASrm+W6wETDSTsZE06UHP0EExFVSh3kZh
         jpng==
X-Forwarded-Encrypted: i=1; AJvYcCWs/FFS+gT/EWQ0JS2IiLoGtFqQMgei/HDEYFZoPS0a2+1Ht0lwBvaKhSzdna0xzNtKZXbvemV5wIJyA/+u@vger.kernel.org
X-Gm-Message-State: AOJu0YzZeQFsZMYltWYfJNj3vf0aWHJeeD+g+QAlCvKqnvSO5AkdFsAU
	B651GSI2PxQHXDh03+0V/K/mWvcqIASZs2Blb1pTnavi20TfT39eA6uJG9gXLCPdZUUdIHbT2CL
	sHY/3EFwWYvNQiXAAp6rAGnILZv0nBAu1depxJzvt4HFtfDEfzVQUIOUICYR4jKg=
X-Gm-Gg: ASbGnctcdNgyvALR+pR9RLtWKWljZobvp0/Mb6X4ohQsWj1icTRNNP0L/9V+bN6W+sR
	2uX2almhsDok3QAAM1wz9uXNkGi2Na+z/7CMQ51iPHFr3xYf9EBcQ1Hk+uB7n6eCfwrA+ySLeDW
	AtShY/M5wFch+BOsnfvTGPn7/zJXnLXZRK0Ij2I/Y3lt6jXGxi9fnAI7EkemINyZPqRiFHZ8CGh
	z98n5VkzQ5sDZ0k4WI7gMDV7QfqQcGnQIPhYq7XEzC0bTyrDVymBs38BrnSYVpOxDc6Nn0lCf8I
	cjA13MPHZs951COzQkIJM4xVdkDIIgLNC1Se0vZr7ACEHGG4XyeSL1IjLfw+Mm/cYmLlAXPqLAA
	VMZiecMxDBmSigQHCjXdSEzZwH7ba1qMKPA4D99Z4kPU=
X-Received: by 2002:a05:600c:4f05:b0:43d:7588:6687 with SMTP id 5b1f17b1804b1-43ee0664696mr7199615e9.12.1743800388861;
        Fri, 04 Apr 2025 13:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkcAs1DUKd0rZsZ3LUSfxY+03wV4lPDMB6Pxb8j9SZzHr/jh4TuFsN+iKvDHZB+gYAQ45Ruw==
X-Received: by 2002:a05:600c:4f05:b0:43d:7588:6687 with SMTP id 5b1f17b1804b1-43ee0664696mr7199505e9.12.1743800388506;
        Fri, 04 Apr 2025 13:59:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1660eb3sm59007305e9.11.2025.04.04.13.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:59:47 -0700 (PDT)
Message-ID: <a7e46516-b94d-44b5-b0f6-14b8f6e2eaa5@redhat.com>
Date: Fri, 4 Apr 2025 22:59:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] filemap: Convert __readahead_batch() to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-7-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-7-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> Extract folios from i_mapping, not pages.  Removes a hidden call to
> compound_head(), a use of thp_nr_pages() and an unnecessary assertion
> that we didn't find a tail page in the page cache.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0ddd4bd8cdf8..c5c9b3770d75 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1424,7 +1424,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>   {
>   	unsigned int i = 0;
>   	XA_STATE(xas, &rac->mapping->i_pages, 0);
> -	struct page *page;
> +	struct folio *folio;
>   
>   	BUG_ON(rac->_batch_count > rac->_nr_pages);
>   	rac->_nr_pages -= rac->_batch_count;
> @@ -1433,13 +1433,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>   
>   	xas_set(&xas, rac->_index);
>   	rcu_read_lock();
> -	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
> -		if (xas_retry(&xas, page))
> +	xas_for_each(&xas, folio, rac->_index + rac->_nr_pages - 1) {
> +		if (xas_retry(&xas, folio))
>   			continue;
> -		VM_BUG_ON_PAGE(!PageLocked(page), page);
> -		VM_BUG_ON_PAGE(PageTail(page), page);
> -		array[i++] = page;
> -		rac->_batch_count += thp_nr_pages(page);
> +		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +		array[i++] = folio_page(folio, 0);
> +		rac->_batch_count += folio_nr_pages(folio);
>   		if (i == array_sz)
>   			break;
>   	}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


