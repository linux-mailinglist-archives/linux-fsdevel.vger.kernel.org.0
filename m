Return-Path: <linux-fsdevel+bounces-21608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D7390662C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9BB283271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84B13D25B;
	Thu, 13 Jun 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD4FspjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE532119
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266048; cv=none; b=efte4D+YNh0svqGjL014mvFpYXCFFSYQOPzHPMTYR4bagjc8kTm0kmoKAjIDZ7rYu1phbMxwhOmP7eo4Ic96tTEdduBOsAsGoq9S7spMhMpGwc3DWrmOh9jRX06/JD4sFqEu/lKw3IVRqIr6TvZiD58Oy7daa0+WBtO1JwZh+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266048; c=relaxed/simple;
	bh=ky8CVT9mozDoquEesxYshFZtSqOyPlbrY1ZPJYAuyMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGBMZ4F/lyc+qK9jBbd+VG0DGG0WFbxUjWoBEPMUp01mnZGcLwbKlw+pKHoB1jX4Gqcon3um3tE26ab95Y19SbsBnUwYAyTDNhVhvODTzFUDrnAhVa3/yXfFK4hUfvqO6UPExGF6iGduElUEnxASLtu+yqAKaBp8fylYe6bT0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AD4FspjG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718266046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5GRWbA/uWeRuMdyWJhyP5cP7uFrOe0sCfM6iCB5SokA=;
	b=AD4FspjGj7KgeUQuod6Puz/1nMG2VJjJLdvBOobUqOLWM/P9OQP/h3Y2JV4kXmZZqlw5ew
	/wtl7Q8N6J5C1rTl+Jmr7L3H0g/jmeVZ2pkT+iP3Bfk63JAvswVx9p4T/tuu2bCX9ZY6eM
	WFmaInT++FXQ5wzkERUc9n713D23vnU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-JX8TT6fJPZ6BZAOU4RgfLQ-1; Thu, 13 Jun 2024 04:07:21 -0400
X-MC-Unique: JX8TT6fJPZ6BZAOU4RgfLQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c893408b5so500870e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 01:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718266039; x=1718870839;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GRWbA/uWeRuMdyWJhyP5cP7uFrOe0sCfM6iCB5SokA=;
        b=lMeJJt8aQaaNlqGfKCEomQi08GHJJblGcEXJMTx9loyKDdvvlBocad1s7Lc9uAKrJ2
         oDZtbcBLPrCGdF69ugWaQOvS5Swuei1BDjSGggBnLSEogjPTgX6UH0n8hUYVckaIeMtj
         szRZ5MgkTaODsQe9Dbt/q5MF4WmM7lw3CXp7BP0AQaQIAApsEt4hJvU8ouPkYSq7scYD
         ZDoQ9exK9ESj8hWD9fRc1MbFYd+K60Gr6NcfOl7O605EHjBIqCKulEl7OlZp0t25iBpy
         GpMC8POKjqZXQzcLHB9EnuKC0f8dAngXvRo8Ir0NUA/Gk1yaFgc5HH/kcrC2B4rVC+kr
         o1+A==
X-Forwarded-Encrypted: i=1; AJvYcCUVeEOKAwD3KowxUqFiOFbcldwPr3NCd+JQ3ODGpq+MVa8VTgHW5VT5qk2WM7Qd+q3/z/DtObBmPuEiev12Sbf+5Kkga4IimqT0dyCP/w==
X-Gm-Message-State: AOJu0YzXj26AzuBpTMMx1hlF4UazckS5XcaF7cAq6aMEc7qQ8TlDDARk
	UDTfLucBetREMJ6GbhoO+Cx5UrEtIvZ+77IxAEd+2f52mba15vRJh8PBZkZFXArhfAgmZtWp82/
	QVMyQSyxvFEN980TaiGhuiPxNDDOOv+4V5YZnm3xpgthezDzciWFcxbC3876B25s=
X-Received: by 2002:a05:6512:3994:b0:52b:bee3:dcc6 with SMTP id 2adb3069b0e04-52c9a3fcc4emr2734818e87.51.1718266039377;
        Thu, 13 Jun 2024 01:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoMq4M7AEYqz8zDytNSjELHfVhQVnOkmAgL0WQw7PbhpnLTUWO+8O96zxrp1TCaRQjETDI1w==
X-Received: by 2002:a05:6512:3994:b0:52b:bee3:dcc6 with SMTP id 2adb3069b0e04-52c9a3fcc4emr2734787e87.51.1718266038928;
        Thu, 13 Jun 2024 01:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f1e6sm121385e87.88.2024.06.13.01.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:07:18 -0700 (PDT)
Message-ID: <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
Date: Thu, 13 Jun 2024 10:07:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 yang@os.amperecomputing.com, linmiaohe@huawei.com, muchun.song@linux.dev,
 osalvador@suse.de
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
 akpm@linux-foundation.org, linux-mm@kvack.org, hare@suse.de,
 linux-kernel@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.24 09:57, Luis Chamberlain wrote:
> On Wed, Jun 12, 2024 at 08:08:15PM +0100, Matthew Wilcox wrote:
>> On Fri, Jun 07, 2024 at 02:58:57PM +0000, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> Usually the page cache does not extend beyond the size of the inode,
>>> therefore, no PTEs are created for folios that extend beyond the size.
>>>
>>> But with LBS support, we might extend page cache beyond the size of the
>>> inode as we need to guarantee folios of minimum order. Cap the PTE range
>>> to be created for the page cache up to the max allowed zero-fill file
>>> end, which is aligned to the PAGE_SIZE.
>>
>> I think this is slightly misleading because we might well zero-fill
>> to the end of the folio.  The issue is that we're supposed to SIGBUS
>> if userspace accesses pages which lie entirely beyond the end of this
>> file.  Can you rephrase this?
>>
>> (from mmap(2))
>>         SIGBUS Attempted access to a page of the buffer that lies beyond the end
>>                of the mapped file.  For an explanation of the treatment  of  the
>>                bytes  in  the  page that corresponds to the end of a mapped file
>>                that is not a multiple of the page size, see NOTES.
>>
>>
>> The code is good though.
>>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Since I've been curating the respective fstests test to test for this
> POSIX corner case [0] I wanted to enable the test for tmpfs instead of
> skipping it as I originally had it, and that meant also realizing mmap(2)
> specifically says this now:
> 
> Huge page (Huge TLB) mappings

Confusion alert: this likely talks about hugetlb (MAP_HUGETLB), not THP 
and friends.

So it might not be required for below changes.

> ...
>         For mmap(), offset must be a multiple of the underlying huge page
>         size. The system automatically aligns length to be a multiple of
>         the underlying huge page size.
> 
> So do we need to adjust this patch with this:
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ea78963f0956..9c8897ba90ff 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3617,6 +3617,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   	vm_fault_t ret = 0;
>   	unsigned long rss = 0;
>   	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> +	unsigned int align = PAGE_SIZE;
>   
>   	rcu_read_lock();
>   	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> @@ -3636,7 +3637,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   		goto out;
>   	}
>   
> -	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
> +	if (folio_test_pmd_mappable(folio))
> +		align = 1 << folio_order(folio);
> +
> +	file_end = DIV_ROUND_UP(i_size_read(mapping->host), align) - 1;
>   	if (end_pgoff > file_end)
>   		end_pgoff = file_end;
> 
> [0] https://lore.kernel.org/all/20240611030203.1719072-3-mcgrof@kernel.org/
> 
>    Luis
> 

-- 
Cheers,

David / dhildenb


