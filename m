Return-Path: <linux-fsdevel+bounces-45798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA2A7C533
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C50A3B50D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D801E7C01;
	Fri,  4 Apr 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gswuXfyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85728634
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800239; cv=none; b=jCuLWKf5A7YmQ7Fm2bhse0ZkSEdVapBGWeW0b4dm+3YOAvd7QzwwIM7fbfsnCXYBrZOQXHZf4SNV6lvK/Q+WDtM/+6sek5IQCUizbfGoMRau0lvcGfCx4mcF99ypIQdJmtXSrPXzlNt0d0QthtrU6t00yE+2NM4UlVAHSujMIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800239; c=relaxed/simple;
	bh=1L65CVvSDOW0m7Wy5dDPouXQ+g9QF9hjdnfAenXJ8kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsX/Xzw+GI7h0i+4eFXlF26aBHT5qGf71TPkAt9bvbRnBkOO3CaAz/noIppoJaFRorgIriAEi2vTTXOCQkSTpg+QmnWX7MPCcI89coTsimta40pZIGHRT5FB+4j/ZF+QoO2pmSIbRURV3o4HrsyCLPzSMY/i95QDvKchblaQluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gswuXfyw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MphuJnClTuz/wgauAZ/+9UOOoNZwVFrAJq5GFOCDfKo=;
	b=gswuXfywXEGk01K8pJJoQJXrEhQwgmi2fzrLHAqr4uI5/HVWqJcJ0a5NIGtjikv0+rvzQS
	/9cUjHo5aPNj/VUd1Eb1Jd4Sl/AZ1OcbjHPQkwysmAA/uY6MIQ0Wc00GmZxHd0iKxb0vWF
	lKwbUfI8lF5FZI4dt9wIeKQq6JAPMcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-AZct-kwZN7SGT7kvP65qhQ-1; Fri, 04 Apr 2025 16:57:15 -0400
X-MC-Unique: AZct-kwZN7SGT7kvP65qhQ-1
X-Mimecast-MFC-AGG-ID: AZct-kwZN7SGT7kvP65qhQ_1743800234
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso29180005e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800234; x=1744405034;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MphuJnClTuz/wgauAZ/+9UOOoNZwVFrAJq5GFOCDfKo=;
        b=jb30nDREg5c9SzUmdjMfEGYYYqm93ghO9WAFSx31jr+d8pUu3vSKBaOftPhEMCCq5+
         hS5bUmey/2ABYPKmaQ6BFSq4c69Pxbsq/mjJnm3GScNxeQcL3iBuHv8fQDzV98adD9DU
         RVkkUlXcxSE06+gzHvptClM9ha8pnrfVMF+toTOy9kMlGjXS0MJ6ypDgxdpYKFl3ptlX
         plCnp6Eut0arqdNdTTQY8bRBnlkXufIbMkcDqL1jBel4zDmIkGNsdkxQjQbxryyYcjKq
         Vfn4bWXBwuuYPqEll7vH7FFY8AOBNERt0YpptzChIygoJFdH3bc0G+KlAB0shFKzTZxR
         29lw==
X-Forwarded-Encrypted: i=1; AJvYcCUGH1mScQgw+7osWyocjJzmU220lfUmvQ7XxUgcbT/+OKG2qXhYleWewg65SIpzXL7LfZcZeKx6iB5TSgW8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qq4Djw3xolb2YnW1DmJJctAeeyeG3t3KKzXrK/mJLaCkn6zR
	diG68X3yNzVTZpH886CEwQlHS+0u/pmLU5a10o1e2B0w2DS16aV1KXlqHWg4G+RaIseXmyhpoq1
	vAwNiMCY9ZYv1X19i+Ix07FF7dW5OP4lbVLCroHWPTTa6T545viygVqHIkx3Wbx0=
X-Gm-Gg: ASbGncuduTae+cOefwKLusFQYA7EY7bi6Vu4CcO8pqFwr+LbdzSYbxqRGO82aQex/jv
	CdnsI68WJ96sm1zTkwniUeV3Rha63dyL2f/S6Nz/X/3HW5u9Ah3ePOOvLFu3qYMiNbPQRj/ueBS
	Dq84f5LrI7CK/o0Jzwb9iLyHFA/NjgJ8s85fsBkGyFOiWEGQ/r9Yn/pKDnrN1qoj1qRQjrRwkm/
	HWhSSAOhfy1n8gy3b3MLYZJ/mHJodK+c/C6GXMUVYXZTyYMaknXlL33+TOf4gm71QTx2nfjvNlo
	PEG27PjFD2zFN9L9jduFMSt+53IQfKzY80ayUrA0frIXRSj58kL7LGqj9bB6FFO36UVgKCqZGwK
	tw/iN3lnBBI94ZJ42ynLR6Ba39YtbSTGJUtUROmucly0=
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43ed0da06f1mr38086195e9.29.1743800233992;
        Fri, 04 Apr 2025 13:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzTanrLml12tr3IDgF64xmkRK9hrhYqlKSSITwWBy2in93k0ucTZ0z5PncEDD99Q7+/SAkdg==
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43ed0da06f1mr38086075e9.29.1743800233684;
        Fri, 04 Apr 2025 13:57:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795205sm59026895e9.30.2025.04.04.13.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:57:13 -0700 (PDT)
Message-ID: <c749b632-5b53-4e01-96a9-8193988879c5@redhat.com>
Date: Fri, 4 Apr 2025 22:57:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] filemap: Remove find_subpage()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-6-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> All users of this function now call folio_file_page() instead.
> Delete it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index cd4bd0f8e5f6..0ddd4bd8cdf8 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -945,19 +945,6 @@ static inline bool folio_contains(struct folio *folio, pgoff_t index)
>   	return index - folio_index(folio) < folio_nr_pages(folio);
>   }
>   
> -/*
> - * Given the page we found in the page cache, return the page corresponding
> - * to this index in the file
> - */
> -static inline struct page *find_subpage(struct page *head, pgoff_t index)
> -{
> -	/* HugeTLBfs wants the head page regardless */
> -	if (PageHuge(head))
> -		return head;
> -
> -	return head + (index & (thp_nr_pages(head) - 1));
> -}
> -
>   unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
>   		pgoff_t end, struct folio_batch *fbatch);
>   unsigned filemap_get_folios_contig(struct address_space *mapping,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


