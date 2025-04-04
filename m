Return-Path: <linux-fsdevel+bounces-45797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2CA7C530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25DB3B520F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199919F101;
	Fri,  4 Apr 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYLyuOTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2A634
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800029; cv=none; b=tLQ9Lmco63iA9hXZb513HnDIwEKfFKmJ28zxKvMhtB0N60EdtYDIoPn+g6Ai7aMvK9Dn1Go62M+/jk+YVJnSpxo419y2UtO6sSuBDj7JuC+Efc1oAmuOGzFc+QbT3cu+HZSzDZhKIlSAkPC32q67AGXvgzCW545pRwRR7Neufwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800029; c=relaxed/simple;
	bh=/ONoFkQW8nUl1QwLn/3eHW/c1i9tBNxaWA7YDuFTfpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak6hNN1XPuT3Q0aEfHzQy8f9bhtdBQP7JprGz3XXYxTx2VCAnBLlsDNGp5y2ElbXquG7a6iR+yWvaOoDuG8OTxRTuKfAUUtmgGRyyAn+fN2gvzAOGDgQYbk375CGmTi0BwIqFV372FsCwsbdhy5eisEpxtFSAIxzKJiuT0BQY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYLyuOTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yhxGFHiL20f2jf3jvGVItNzipbStSkYCLJuoGOmL1zk=;
	b=YYLyuOTlzr+UrhE1yNUOCkboOq1qVAGTj6ky3sEssKy+JrSCoXC5DJp40qXUPOwLa7BXUI
	h0LTh5tZEHY7q8FziGUDAC19xgOXYZ3U8ygCJHqVlNVDYUtKF/RZE5ttpeTGS0ZnNpK30I
	wwktDsPislOHLpaBkCW+ALBpgyRr/RM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-DNZB92lSMLGavNcrxLRXxA-1; Fri, 04 Apr 2025 16:53:44 -0400
X-MC-Unique: DNZB92lSMLGavNcrxLRXxA-1
X-Mimecast-MFC-AGG-ID: DNZB92lSMLGavNcrxLRXxA_1743800023
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso1326484f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800023; x=1744404823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhxGFHiL20f2jf3jvGVItNzipbStSkYCLJuoGOmL1zk=;
        b=SHDYCgpcg5n7cXMYsmCkE1pzDs8+EMTdHlr4BNesERdWxdu+s+7kE4cnhdMe0e8uM5
         y4LIqlEJckrXDL1uT6D0sTw2u3fi6l/8V5Gb5XyaThoXEfln643WbQ+UqP8euCYR8ELH
         fj2sGkpvIHYIe/Z2Z/vj8yeMpY0nyupHI/1ZTekLfs3WLkm0H1OBw1sKv0hrMlj7fSMD
         6aLTrRdqNCmV1du+CjCo/9zaeP+tLtHRlat+UvmDNGtwneYSGdQHFDKIq7DwTV59XTYE
         8FSl8ROXGZQU3WeCdgI90KPgtAuKXyx6603kmc8eVmPWa0W3wLepdIWIBh+lS3C1HhDM
         4u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkdB1FsjxCOeAh/VQvo3QAvZdC33a/vdoYWWnEKQsu7fnDG3aC98yTjdNvVodN1ayZa9FW5sHEg6WGaMc7@vger.kernel.org
X-Gm-Message-State: AOJu0YzAW3TddvKSCe6MPpan4n9IbHn3wGh8waG14sno/G/7zE4juR/N
	Rxdpna1gNmZE19gidjpionen+nOg4pE2gz+4YS0TV5m/k8r/tPk/138/M/DBHFMqb4aZp+i9YTJ
	fnF0sIdfJrmluRzXP5FkqNDDoTj9QXgbPp8dTkvWpKIRGxmK8du0PjyuIpCynI2oh/0Yi//5yQy
	36
X-Gm-Gg: ASbGncugAz6XLMDoOuwnklU6bL60bgrWIW3pC5uUNnwEPoGdCwCisWMfoNSi5WmrZkr
	L7lR/Otwfy4SmqU62UUFxoJ5dZKvdPAzaONUvFb3Q4xCghgII/EYXnkutAb0URoJ+04adM1KWx8
	TovzjoQ6Dyq/RKJGUmQTZTQ1c3IGIHGQKoIlHnSgGWmcr4t5qZR+S85LFxtdseakcNoaZYRsojy
	pgOJ+1MzJnuN/B8uCUteRhZFXilj8muwuj8TlVTP1DIYN+UJmTJBinL546s7/3eEfvxrhIt7OQE
	YI2j4S9ypEoB4EnIcpCw6L7wwilhYgKYxlFgXqwLM1nh6tJGJbCkfKfENeS4HZTkmMofDmNuiJz
	b9pl1066PJopEjjfFRwfxsMF/RpgBVCj49oy0J7osgY4=
X-Received: by 2002:a05:6000:290a:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-39d14662e92mr3735354f8f.51.1743800023369;
        Fri, 04 Apr 2025 13:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxW4gfVcnaFSEVatyvVJk8El9ySq4QV41L1WWDXP8nA/lLXsUBsaxSVI2j937A3SlDzU5QtQ==
X-Received: by 2002:a05:6000:290a:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-39d14662e92mr3735346f8f.51.1743800023052;
        Fri, 04 Apr 2025 13:53:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0dbesm58556575e9.33.2025.04.04.13.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:53:42 -0700 (PDT)
Message-ID: <16d31171-c154-4875-94b5-9c85202827fb@redhat.com>
Date: Fri, 4 Apr 2025 22:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iov_iter: Convert iter_xarray_populate_pages() to use
 folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-4-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> ITER_XARRAY is exclusively used with xarrays that contain folios,
> not pages, so extract folio pointers from it, not page pointers.
> Removes a hidden call to compound_head() and a use of find_subpage().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   lib/iov_iter.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 8c7fdb7d8c8f..7c50691fc5bb 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1059,22 +1059,22 @@ static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa
>   					  pgoff_t index, unsigned int nr_pages)
>   {
>   	XA_STATE(xas, xa, index);
> -	struct page *page;
> +	struct folio *folio;
>   	unsigned int ret = 0;
>   
>   	rcu_read_lock();
> -	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
> -		if (xas_retry(&xas, page))
> +	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
> +		if (xas_retry(&xas, folio))
>   			continue;
>   
> -		/* Has the page moved or been split? */
> -		if (unlikely(page != xas_reload(&xas))) {
> +		/* Has the folio moved or been split? */
> +		if (unlikely(folio != xas_reload(&xas))) {
>   			xas_reset(&xas);
>   			continue;
>   		}
>   
> -		pages[ret] = find_subpage(page, xas.xa_index);
> -		get_page(pages[ret]);
> +		pages[ret] = folio_file_page(folio, xas.xa_index);
> +		folio_get(folio);
>   		if (++ret == nr_pages)
>   			break;
>   	}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


