Return-Path: <linux-fsdevel+bounces-45791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF7A7C3AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 21:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F131781F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7808214230;
	Fri,  4 Apr 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMdtlQal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DD13D531
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794035; cv=none; b=W8tW9HdWWnr5J5BsnhutBXy8x3rSF8AMdqLUmT85+K8Vbw7Jwoyk040yyY4ejtBgB0r1BRwQd2gdMxVrhkgwTQnRNwyCsML5iyyBdqbXTOAFxC1R0kuBNCCmsyOwKd0lj/F+rPczM3nqE5+yu9Eaq3sVy8qU5h4jf7sUKTEG1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794035; c=relaxed/simple;
	bh=Ow3w7puAPYmR4ya4uhG1A7z3mxIP4ldwHHM8iWgHUC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUkVI1++3gbFtzgC3luGuqQ/NVxbi8DPkYV0tWh4ZRoJmL2zZAjxZq/GnY4VhYAKJi6tPYEVdZgS/IBtahtfVbZzahYrfDN/ArQTn1zIcL5zfrZswVJmf/kJAlv6RiJQUXBC61jXkY0I5n16chwvcSZwIwxEQMK7C4xpDQ5j0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMdtlQal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743794032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Uy2wHSKFxr5oiJfdGGGRkItfd9HfMRo1HowWXsXdLI=;
	b=hMdtlQalMdG+96jLyHh2Xnx3V6dtzSGFyupgeER8rKRureb3DGyHvzRCvxgm6PLX8TwJyD
	9joZ5mioVJmHjYP2uMDVs8GXDcniI92QDtnrLGobxHtHjk2bEO3hjvGfQG6a1sGjsrwkiA
	5csYlERUsCxMBJHgLUedJhqIZ5Enyvc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Ts8jPTFlNcWjfy1mpktdgw-1; Fri, 04 Apr 2025 15:13:49 -0400
X-MC-Unique: Ts8jPTFlNcWjfy1mpktdgw-1
X-Mimecast-MFC-AGG-ID: Ts8jPTFlNcWjfy1mpktdgw_1743794028
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso11218615e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 12:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743794028; x=1744398828;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Uy2wHSKFxr5oiJfdGGGRkItfd9HfMRo1HowWXsXdLI=;
        b=umuoN6V7bjKPllVF4Up6XOZBr0m3DHTgM+IXGORi3Y5E5py4G29sJ8n5AL+Vhow0Sc
         leTVCXCjwRnEw5r1FsPPo06gbUw5ux8Kjo2jk6dlsJROmyvux5l0O0RkaDszGcT49oHh
         6YUuFbRUIsStWxpsdTz7/npwoBKr+tug1jfBkLBRGRCc6k71rJSuSJT9+UyMIRhzv0b/
         /h91hfidO+o+b0eKFEmBkgWqbDogHKfTuEb8dSc1SH1XNZDWYSC0sYeoFjRzWJUx90+O
         N8wNIPAeTep2XH8Egcrtmie83KPNN6Bn3N9KqPpmSIiAcCo9BnJB2jgZRldgQ3Q7aqbw
         zLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw8qfz3W94yrv2IKqR3ISj/UBxcxJ22kz+W+szJYEZK0kOO0tCP23gG16sZFUXNY3ONYii6HcFVGAWWvD5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9FigiIaprP+2f7iK/WHgAR42LWoyvEuJw0Af+/FO3Q/vAnPb
	FQNwnmqGuZP/7mK5wY1yWcF3HUZFn1i3bP0cKdkVSmAXHwFkxLrwqWAKrZc7s4qZZEoEFi8mB2x
	SUCKR2Gc1VdUsgdWQv6xeRJ81bu4RMHXBwKwyVXkBCacKApkNUqqdHY6Dd4wEzOc=
X-Gm-Gg: ASbGncseK9mS0GdyC4mLku0IkN7laruRdlXxmS8b+GfC36Uq3kmwWEqWxhjQR40ZfnI
	Eag92gorLv/hS2iZRjuN9+2QgOzYD/9wucgABQfW3NG6Vk4U/zFP7ZwMtx3ZIoGACUE0YYWEgBU
	hGxjLUe0AU5Hd4QSjind8K6vL1cK+IOlpdklWUteSnzmCxw+1fjrO6O87yF0rLn+wM/CW3/emER
	SaODFTXdAF9Mjv1JtG1+1dYFG51/MhwIIX9vNuy5MfqmE41BUbwwz37ZVvlcucPzW+uNnDzpCBy
	Mn3OoPWAIU9Oet9hBS+VONo9JIKm+AtAWidYVIfzeqHTt5PzJ8ZxtDGqqjfj2hpQBMr2ec5MtOg
	QO9eVwKc+qHD4LtkcdUQcyeTXR9XvJPh99EZ2zSOOPt0=
X-Received: by 2002:a05:600c:c8a:b0:43c:f597:d584 with SMTP id 5b1f17b1804b1-43ecfa0704amr41245665e9.29.1743794028309;
        Fri, 04 Apr 2025 12:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfkuER9ESk4TdalV1jYd6GtkeagBadty4TD/jhIAe8Xs7iHMaS5LzRniMKdR72jsrWtR/vg==
X-Received: by 2002:a05:600c:c8a:b0:43c:f597:d584 with SMTP id 5b1f17b1804b1-43ecfa0704amr41245465e9.29.1743794027953;
        Fri, 04 Apr 2025 12:13:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d6c8sm4982169f8f.73.2025.04.04.12.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:13:47 -0700 (PDT)
Message-ID: <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
Date: Fri, 4 Apr 2025 21:13:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com, shakeel.butt@linux.dev,
 bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org,
 kernel-team@meta.com, Miklos Szeredi <mszeredi@redhat.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-2-joannelkoong@gmail.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250404181443.1363005-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 20:14, Joanne Koong wrote:
> Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
> set to indicate that writing back to disk may take an indeterminate
> amount of time to complete. Extra caution should be taken when waiting
> on writeback for folios belonging to mappings where this flag is set.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   include/linux/pagemap.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 26baa78f1ca7..762575f1d195 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>   	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
>   				   folio contents */
>   	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
> +	AS_WRITEBACK_INDETERMINATE = 9, /* Use caution when waiting on writeback */
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS = 5,
>   	AS_FOLIO_ORDER_MIN = 16,
> @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
>   	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>   }
>   
> +static inline void mapping_set_writeback_indeterminate(struct address_space *mapping)
> +{
> +	set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> +}
> +
> +static inline bool mapping_writeback_indeterminate(struct address_space *mapping)
> +{
> +	return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>   {
>   	return mapping->gfp_mask;

Staring at this again reminds me of my comment in [1]

"
b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
      that very deadlock problem.
"

In the context here now, where we really only focus on the reclaim 
deadlock that can happen for trusted FUSE servers during reclaim, would 
it make sense to call it now something like that?

[1] 
https://lore.kernel.org/linux-mm/0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com/

-- 
Cheers,

David / dhildenb


