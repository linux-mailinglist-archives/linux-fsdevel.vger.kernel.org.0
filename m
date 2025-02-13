Return-Path: <linux-fsdevel+bounces-41643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE57A33FB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443F83AABE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B24221703;
	Thu, 13 Feb 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWp2zhrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C87227EB3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451635; cv=none; b=lxWQNDA2v+z/gGrjTHKT6+BGJvsPpSNBFuBY8R4t+tiQZODxE9tRwDZHvh/kfTmOFC3g05HtoJfneB1cg1y/BFpIfwMnj6fHt6sAPeNLNPsulx8g7wa4d3qHeobEmX1zvUsZYxZNFNngBLbA9sJhu98AXuz5Or2UkwKhzIB1nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451635; c=relaxed/simple;
	bh=GbzcbGEYBt47KyUoS53m6l55tTHSiW3/zYp7rU8qJxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DO185Sci56I6q/r8C6JZyCSepefTR89Fhjf+4xWtrrtHQY09pxluvVwYg7b2fx2ThSuhZLZ/08rTt5xEFQQ8EVoKimPovThNZLP74sfy4UDrTmbjtCeSGBVsxmYDvmfutv2l8msnYlMegQXDjaQb/7nnq1lWFMt4aF8nHHkTewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWp2zhrn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739451632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mfnvsrTaO3psu4jmIyQdi8eiJDFREwQyTUaQ4HeOqrE=;
	b=HWp2zhrnZsI2mjmGDGSmHgYT/GdMup27w2DJrdIE4gUKMSatLshUoaCqypmuK4M+TeKKkA
	ciRUjnl5AgJQsQIoO3lUX+vWP3gwrDOYAxECjkq6JtP3MtvOgoB8guh02OykYDhcd0SUc6
	+nsjpWSIlz8JrwMtdD16svqP7XkvvZ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-2pCbu_YJPqGhQ8wK_Liq4Q-1; Thu, 13 Feb 2025 08:00:30 -0500
X-MC-Unique: 2pCbu_YJPqGhQ8wK_Liq4Q-1
X-Mimecast-MFC-AGG-ID: 2pCbu_YJPqGhQ8wK_Liq4Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38de0201875so507777f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 05:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739451629; x=1740056429;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfnvsrTaO3psu4jmIyQdi8eiJDFREwQyTUaQ4HeOqrE=;
        b=Ha1yPgROCU3cBj/y7ECfUtrckK3YnkQjErnr+V0TM/CuP0UbMp2WuzTHDezRPASR1/
         u6/QG1F8YbC2kJKieKcy81vQ6bcbgJQOaC1zWh5WEfR3bHEel+m2TdAPovvVeWMHHy6l
         1U6K6MBOQboQPSWwRNZff77i5oXYz8GjlSqEdeuA9aRl3XQA0UBW608LSpJWizIeRdav
         GC7PlRH0hcLodTnyM610JybmKJ2KPLSAhxffvf8yaNFFSb7fdcqosijlw+91tLMxbjtM
         iHsQ8Kdw5CziNBYMOPCM/WkpphO14N1bJFS/UYTyegKQ72+tXFoxRQlyN2wqpXH5zb4X
         2Q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVa2kIW1EKS7ATThfLxkvaF9+6EHWzyyklHVZ4TXxtsHyprT4hm43sjKcrooKlD1hSiD18s4InSEznxG4R@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOnSxyNy5Mjeta9sj9XhdqKMNn6XPzxJiCh1OjAlGdewZ755G
	sXjBOoqjVBH5WH5LJWl1l++ZxupljZCmdBOIQ0/4LHukMRcDumL5di4hy3uX+IMn+RxbxWbKYOz
	0+bwVGgD5fT0oADCHyJORYaQYsZx8ZthY8dq9NcSglOV9gHDyhgVY2Psmh7pQ13k=
X-Gm-Gg: ASbGnctFUfkVdJMkK8LAF99eO6gsC+S7redca1SMQUMKJLUlU3N5ljJPCTcgfj4qolx
	c8Ve21uXT5fv2pIXmaYVonSWxYudMq6s61Qv/nOiB24SckqDE2kKqXVTEjrXW4gmBUpk01uuDEg
	EyIHDrhTmf0r1eTGlW6WEk4q9f89zzYm/GQ8seG9IwfvnKHNYT9gWTtyGL3FUsRx9sCygVnuUac
	2d2wwWiqdQyMoOSOawJOYSE3gKc9mQGEBtBmvqxyLhhPXa56D93fR/IzIzrOlGUnJJdQoqaOT+B
	ijPxoAKhm5Y7g96VAlNNkDxzSUwgk1aoDL+m8Tf3khRQmPkpp7yBaJ70pZU6wqYz/bvhAV9Sycu
	XK+ddI2I89DBpwd8KyaBIk3RrsYqaJA==
X-Received: by 2002:a5d:5885:0:b0:38d:da79:c27 with SMTP id ffacd0b85a97d-38f244d5085mr3181629f8f.2.1739451622009;
        Thu, 13 Feb 2025 05:00:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGibeuFs5cDXtn7xG1Fnqp50UyOedeKGyfYtUsGJrtkfYfZ0quTGv8DvIIEgk1u1kG0YtabFA==
X-Received: by 2002:a5d:5885:0:b0:38d:da79:c27 with SMTP id ffacd0b85a97d-38f244d5085mr3179420f8f.2.1739451611117;
        Thu, 13 Feb 2025 05:00:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:100:347d:db94:161d:398f? (p200300cbc7180100347ddb94161d398f.dip0.t-ipconnect.de. [2003:cb:c718:100:347d:db94:161d:398f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4423sm1871351f8f.11.2025.02.13.05.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 05:00:09 -0800 (PST)
Message-ID: <9fb47de6-0d39-43df-b11a-ec188ecd90c8@redhat.com>
Date: Thu, 13 Feb 2025 14:00:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm 1/1] filemap: Remove redundant folio_test_large check
 in filemap_free_folio
To: 'Guanjun' <guanjun@linux.alibaba.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250213055612.490993-1-guanjun@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250213055612.490993-1-guanjun@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.25 06:56, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> The folio_test_large check in filemap_free_folio is unnecessary because
> folio_nr_pages, which is called internally, already performs this check.
> Removing the redundant condition simplifies the code and avoids double
> validation.
> 
> This change improves code readability and reduces unnecessary operations
> in the folio freeing path.
> 
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>   mm/filemap.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 804d7365680c..2b860b59a521 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -227,15 +227,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
>   void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>   {
>   	void (*free_folio)(struct folio *);
> -	int refs = 1;
>   
>   	free_folio = mapping->a_ops->free_folio;
>   	if (free_folio)
>   		free_folio(folio);
>   
> -	if (folio_test_large(folio))
> -		refs = folio_nr_pages(folio);
> -	folio_put_refs(folio, refs);
> +	folio_put_refs(folio, folio_nr_pages(folio));
>   }
>   
>   /**

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


