Return-Path: <linux-fsdevel+bounces-45799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC8A7C537
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49CD189FD78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BA1F5423;
	Fri,  4 Apr 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJgABkhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CA634
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800299; cv=none; b=sciBy1u7liLTABFrYVjAS5eQ9Hg8vcX99bwU99fATqUWIm3m07/FqQVzxyJzmTJrdEij3w5aLyT1y8CHPKW2Tj4fHB9WFujd+DwygD9U1pKf4LXT8XpX64HVZ1w1DLa4ku0HvA20JwB8+rcZeTvi2TVdENHawjzmgLgB2PRmUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800299; c=relaxed/simple;
	bh=5rAP454n25zcPYfawRjoBw4lRLm9+VrdJM4e/KKIkA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIh7F7pADPsvoQORRc1HlcM9/BD7U0496n0h+Zq5s6Y8AcwK0OnEw0aJjXsbX9lmIBFoz33ugSfWEbsRJms7yeSsYSQTN8IJRKgGGoeUZTIm+2NmvtAmqNYujRgX7/Mi/d4WwwDrr1tG59tVVBF60u8xeV9HkN5WrvEuURLn81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJgABkhV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sO3UQqypsxo1Y61Nt/Ug7nFQr6xB1gJPZRCYoB22hZg=;
	b=PJgABkhVgAaJyTY7zj3cBrragENTt6s62mAdjZ0sln0/fHpusV594XEU1eZUhbXl3b4Zv0
	koL23KuNrM3ogcXb+zW6CjnxsQcSAI3L0ucTOfGO1noTaiZa4rgsxJ19puem3yxXjReuO8
	urPgBdB9PRFv/Gg9Mw1p1K7rZwt02bc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pWaVj2VDNOqQFRv70xhj7g-1; Fri, 04 Apr 2025 16:56:57 -0400
X-MC-Unique: pWaVj2VDNOqQFRv70xhj7g-1
X-Mimecast-MFC-AGG-ID: pWaVj2VDNOqQFRv70xhj7g_1743800217
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso1724764f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800217; x=1744405017;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sO3UQqypsxo1Y61Nt/Ug7nFQr6xB1gJPZRCYoB22hZg=;
        b=wPXvYV2KaA7+4DBS3//AjTU3GVCbnW4cUAKKoRb2opQm0AvnMZKq7XCkAfenB0pEkS
         UnMpA7qKMhD+q6dLMaLIR7lEgmlQAEBnL7FSyBXQDd7Pj2UZ9QRYWswpS65vZ6fDzOWK
         MIFMtdM1kNgO2bLY5VEBcASTyUsrfEa3JPj5gaI85aTw8nxJbQENboKWd3LPneuZ9oQH
         f1Ov6HjTbiKP0TusVI6oNbCdRMdaMZCXZUpq/96rZdRvH3p7yOlWJW2/BHCn800k04mY
         bIENc8PdRGIdzA1Ptthtrhoa5pYkuMeBjl/yoG1ZFMndrMELaPlTwYOV5SzC2gCOLTGN
         OEzw==
X-Forwarded-Encrypted: i=1; AJvYcCXq2pzUPJbvnSksNky/Nnh8KBcmOu8H9hc/7yWWa/nC16nCwJtvTbitpgv8JhtL4Gm0Xw6R4e4XkGFhlpmI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8q1yzgnwh62EWBXZuqhYSF6g8Ur9+xT23YEXpO2r8aO05LVm
	C/hTlVjLPalKC0hyyv+GdaAQO0JjapX2UTFy1bg7tx/H4f17Pg9cRYr1tkDEWqrbkig3S4cF3aA
	rLeUpCgskmQKrFfaTIw7iu56+TY/gwWdIbeSa+POkt05guZO8U/oxkDO6qzW2SeE=
X-Gm-Gg: ASbGncuxITWSWHyovGdvdihUfX6GYVxwBBEk5pmGAuy0dv9o+x9Boj9kuIZzjRBRI7p
	FOhOVXOcwjjVEjresjDb/rgLIcQcsBmmLgaTCTHixPXB9XrzhnL7JrQSfSZE5lcETrjZHUGnfDC
	f0Bs0G69fEavEWCDKlbf0wH3BNEn85G+J0GDfhWhb9MH6MgCxszYo0lLh/sggzbU9w3iR4ZJXq1
	7XxJT0xNmgpGOL2VUAVB42QjrpZwkVbmdQ6dwaXlxuPonAn0XDnSWBqulxCuzBk42vyv2/wfzrW
	qqI455G/OUeqUmvkZQI1xm6nY861GHjXDIlxKPn9N9ofRj2FWBuyGxfd189s6ttmjtV3ZUHW5fs
	+NyhJekihBIgi47peoNrCgFH2cgk/m7pxx1kx+8hRqtQ=
X-Received: by 2002:a5d:6d84:0:b0:391:20ef:6300 with SMTP id ffacd0b85a97d-39d6fd18c1fmr555082f8f.37.1743800216836;
        Fri, 04 Apr 2025 13:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhMC9Q1PpfIla1nLJoN6o8Xo5pYx7vsN93z+bf9YyETVOZPvKV2nCp4AMMA3VNwSYsJ6ZcJQ==
X-Received: by 2002:a5d:6d84:0:b0:391:20ef:6300 with SMTP id ffacd0b85a97d-39d6fd18c1fmr555076f8f.37.1743800216475;
        Fri, 04 Apr 2025 13:56:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968cfsm5300264f8f.16.2025.04.04.13.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:56:55 -0700 (PDT)
Message-ID: <9338b7ca-13ba-4831-a257-2b081c375de9@redhat.com>
Date: Fri, 4 Apr 2025 22:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iov_iter: Convert iov_iter_extract_xarray_pages() to
 use folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-5-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> ITER_XARRAY is exclusively used with xarrays that contain folios,
> not pages, so extract folio pointers from it, not page pointers.
> Removes a use of find_subpage().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   lib/iov_iter.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 7c50691fc5bb..a56bbf71a5d6 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1650,11 +1650,11 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>   					     iov_iter_extraction_t extraction_flags,
>   					     size_t *offset0)
>   {
> -	struct page *page, **p;
> +	struct page **p;
> +	struct folio *folio;
>   	unsigned int nr = 0, offset;
>   	loff_t pos = i->xarray_start + i->iov_offset;
> -	pgoff_t index = pos >> PAGE_SHIFT;
> -	XA_STATE(xas, i->xarray, index);
> +	XA_STATE(xas, i->xarray, pos >> PAGE_SHIFT);
>   
>   	offset = pos & ~PAGE_MASK;
>   	*offset0 = offset;
> @@ -1665,17 +1665,17 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>   	p = *pages;
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
> -		p[nr++] = find_subpage(page, xas.xa_index);
> +		p[nr++] = folio_file_page(folio, xas.xa_index);
>   		if (nr == maxpages)
>   			break;
>   	}

I'm curious, if we would have a large folio in there, and we'd want to 
extract multiple pages ... wouldn't we only extract one page per large 
folio only? :/

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


