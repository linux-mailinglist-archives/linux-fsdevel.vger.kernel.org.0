Return-Path: <linux-fsdevel+bounces-18893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F28BE0BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74871C23AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B23152526;
	Tue,  7 May 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUdDdXeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009D14D422
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080305; cv=none; b=ZBpoGu2B62c7/AVB5M7RCrGUfwsdEYaK+PwUhD1pxE43fj3YHE0VQju0Mo8cSbawYynORTxM0it9cTZQMVkIgh5wufad+HKyhDunL1DZc7g5nabgjqccqjRODBQHIUezHTKmzGxcsNq76J/hLzr6Ee7eAt5h7Ju/kw3P46r9ymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080305; c=relaxed/simple;
	bh=n1avMaOXiLgDGf81ox9hcRh6g1q+6LM56hiRHb6nF5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OU7NrPDj/yAV/5e+RruU8EYMp8k6v1TE1FByFMG7T2OsvFvJxfNC2t2dILwypwwjSJJT8pHfIqcCvBkUMk0YliUCjZihH03ERuzLf8BgnJjpLzhmwdJ4sv9kH5FwVsPuRUF8gD5Vq34Pmyh/URDNHsjQ8QkeY2E1pCdgnNmbpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUdDdXeI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715080302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ma0A4QRl86cN5zI8gVEOGGJ7sRXSSgsvkjwuFJ/hkXo=;
	b=DUdDdXeIjlzTZpnoH1839o7aOk0J3cZJRhPp7bubMhR5EF4xRzOrrmdqwSkv+JKzAGGnw1
	lAz03+zeE4pUHGVI+Mv2ifVP+I1f3fIny20I6+N5EATtXwfNdZx9wK6jtGc+ZrloBBAuHs
	QmlcrQrXNf3Uw5SxMIb/ctK8aDXTjGg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-358uIer7OAqHwXbCLJBQdw-1; Tue, 07 May 2024 07:11:41 -0400
X-MC-Unique: 358uIer7OAqHwXbCLJBQdw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34c68b0d27eso1754805f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 04:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715080300; x=1715685100;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ma0A4QRl86cN5zI8gVEOGGJ7sRXSSgsvkjwuFJ/hkXo=;
        b=p46q9WuMr3P7Way99+kOhzPObr8NYsp/wE+wmPReVa0o39IRIvBkMY3soJ+ZlCFfkT
         IxVUdVJ9E3I4OBkEYiNCbO/NTsExC4fZQUZvBaqUDTHvkYjP+uY+1Qy0ilwmqdDam+iS
         m7XG6TR39kB6XW6RAFROoIObJu1SnoLy23R1telPDbolMzVdZfhZp+EZnZYUq8MBiQ7O
         g9DQ48xhRKtLwvnmMKhssHI1Q1Ar8UTg17GDtwPCwdhz47YP9V312kJpg4qTpOPai5LA
         Yh5TYUzdcqY3ngbyKDj8KVot1fii0vjylxHKVg6zej6dybC8AmSu59mWYfcp0rfveq7L
         I5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtbkFJzfC9RfPiz4+hPiUiLsAkN3L+olC2DNoxYNJBfw+gDF/F4djY8AA8C5mS9asgVzI61oc/jhlDHe0dr5tNC/GOun5PXArZQR/YSg==
X-Gm-Message-State: AOJu0YwDJbas63doEAmf29lrxt5CFzcoVjvA9Sk+f2qqm6vc9WRFfgPd
	md4tbXWQR/B4sgJWxj1B7JSkTA/WEjJqQipt+sA5fK7NOeEhIjKnUbLr7oOP4TwmLXfQBrSBGAJ
	7+aaTIfj4YgKwwFv/TAdnW/WeQuRBHB5iufENHf5ux4nsU6yVUNX96fVO7jCfjJJwsyIIWKY=
X-Received: by 2002:a5d:678b:0:b0:34b:44d7:f3eb with SMTP id v11-20020a5d678b000000b0034b44d7f3ebmr12357279wru.3.1715080300225;
        Tue, 07 May 2024 04:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6FKYSsj/W4OlQLkmUqONrveJsDpA25wL1LvAbxjFl57Qr95M9yN00ccrpuzPdeX9P3+kuCQ==
X-Received: by 2002:a5d:678b:0:b0:34b:44d7:f3eb with SMTP id v11-20020a5d678b000000b0034b44d7f3ebmr12357257wru.3.1715080299685;
        Tue, 07 May 2024 04:11:39 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b0034a2d0b9a4fsm12816762wrb.17.2024.05.07.04.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:11:39 -0700 (PDT)
Message-ID: <0bf097d2-6d2a-498b-a266-303f168b6221@redhat.com>
Date: Tue, 7 May 2024 13:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 3/4] mm: filemap: move __lruvec_stat_mod_folio() out
 of filemap_set_pte_range()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-4-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429072417.2146732-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 09:24, Kefeng Wang wrote:
> Adding __folio_add_file_rmap_ptes() which don't update lruvec stat, it
> is used in filemap_set_pte_range(), with it, lruvec stat updating is
> moved into the caller, no functional changes.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/rmap.h |  2 ++
>   mm/filemap.c         | 27 ++++++++++++++++++---------
>   mm/rmap.c            | 16 ++++++++++++++++
>   3 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 7229b9baf20d..43014ddd06f9 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -242,6 +242,8 @@ void folio_add_anon_rmap_pmd(struct folio *, struct page *,
>   		struct vm_area_struct *, unsigned long address, rmap_t flags);
>   void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>   		unsigned long address);
> +int __folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
> +		struct vm_area_struct *);
>   void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>   		struct vm_area_struct *);
>   #define folio_add_file_rmap_pte(folio, page, vma) \
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7019692daddd..3966b6616d02 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3501,14 +3501,15 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
>   
>   static void filemap_set_pte_range(struct vm_fault *vmf, struct folio *folio,
>   			struct page *page, unsigned int nr, unsigned long addr,
> -			unsigned long *rss)
> +			unsigned long *rss, int *nr_mapped)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	pte_t entry;
>   
>   	entry = prepare_range_pte_entry(vmf, false, folio, page, nr, addr);
>   
> -	folio_add_file_rmap_ptes(folio, page, nr, vma);
> +	*nr_mapped += __folio_add_file_rmap_ptes(folio, page, nr, vma);
> +
>   	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>   
>   	/* no need to invalidate: a not-present page won't be cached */
> @@ -3525,7 +3526,8 @@ static void filemap_set_pte_range(struct vm_fault *vmf, struct folio *folio,
>   static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   			struct folio *folio, unsigned long start,
>   			unsigned long addr, unsigned int nr_pages,
> -			unsigned long *rss, unsigned int *mmap_miss)
> +			unsigned long *rss, int *nr_mapped,
> +			unsigned int *mmap_miss)
>   {
>   	vm_fault_t ret = 0;
>   	struct page *page = folio_page(folio, start);
> @@ -3558,7 +3560,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   		continue;
>   skip:
>   		if (count) {
> -			filemap_set_pte_range(vmf, folio, page, count, addr, rss);
> +			filemap_set_pte_range(vmf, folio, page, count, addr,
> +					      rss, nr_mapped);
>   			if (in_range(vmf->address, addr, count * PAGE_SIZE))
>   				ret = VM_FAULT_NOPAGE;
>   		}
> @@ -3571,7 +3574,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   	} while (--nr_pages > 0);
>   
>   	if (count) {
> -		filemap_set_pte_range(vmf, folio, page, count, addr, rss);
> +		filemap_set_pte_range(vmf, folio, page, count, addr, rss,
> +				      nr_mapped);
>   		if (in_range(vmf->address, addr, count * PAGE_SIZE))
>   			ret = VM_FAULT_NOPAGE;
>   	}
> @@ -3583,7 +3587,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   
>   static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>   		struct folio *folio, unsigned long addr,
> -		unsigned long *rss, unsigned int *mmap_miss)
> +		unsigned long *rss, int *nr_mapped, unsigned int *mmap_miss)
>   {
>   	vm_fault_t ret = 0;
>   	struct page *page = &folio->page;
> @@ -3606,7 +3610,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>   	if (vmf->address == addr)
>   		ret = VM_FAULT_NOPAGE;
>   
> -	filemap_set_pte_range(vmf, folio, page, 1, addr, rss);
> +	filemap_set_pte_range(vmf, folio, page, 1, addr, rss, nr_mapped);
>   
>   	return ret;
>   }
> @@ -3646,6 +3650,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   	folio_type = mm_counter_file(folio);
>   	do {
>   		unsigned long end;
> +		int nr_mapped = 0;
>   
>   		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>   		vmf->pte += xas.xa_index - last_pgoff;
> @@ -3655,11 +3660,15 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   
>   		if (!folio_test_large(folio))
>   			ret |= filemap_map_order0_folio(vmf,
> -					folio, addr, &rss, &mmap_miss);
> +					folio, addr, &rss, &nr_mapped,
> +					&mmap_miss);
>   		else
>   			ret |= filemap_map_folio_range(vmf, folio,
>   					xas.xa_index - folio->index, addr,
> -					nr_pages, &rss, &mmap_miss);
> +					nr_pages, &rss, &nr_mapped,
> +					&mmap_miss);
> +
> +		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
>   
>   		folio_unlock(folio);
>   		folio_put(folio);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..55face4024f2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1452,6 +1452,22 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>   		mlock_vma_folio(folio, vma);
>   }
>   
> +int __folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
> +		int nr_pages, struct vm_area_struct *vma)
> +{
> +	int nr, nr_pmdmapped = 0;
> +
> +	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> +
> +	nr = __folio_add_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE,
> +			      &nr_pmdmapped);
> +
> +	/* See comments in folio_add_anon_rmap_*() */
> +	if (!folio_test_large(folio))
> +		mlock_vma_folio(folio, vma);
> +
> +	return nr;
> +}

I'm not really a fan :/ It does make the code more complicated, and it 
will be harder to extend if we decide to ever account differently (e.g., 
NR_SHMEM_MAPPED, additional tracking for mTHP etc).

With large folios we'll be naturally batching already here, and I do 
wonder, if this is really worth for performance, or if we could find 
another way of batching (let the caller activate batching and drain 
afterwards) without exposing these details to the caller.

Note that there is another cleanup happening [1].

[1] 
https://lore.kernel.org/all/20240506192924.271999-1-yosryahmed@google.com/T/#u

-- 
Cheers,

David / dhildenb


