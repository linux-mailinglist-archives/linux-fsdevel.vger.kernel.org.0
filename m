Return-Path: <linux-fsdevel+bounces-26054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD171952C9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA111F217E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4001BBBE9;
	Thu, 15 Aug 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIivNd+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9761BBBC4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717218; cv=none; b=EDLqzT9MfrVyNWU/6HgKaQQYGLCP1klHnmvFTvJQoZrFtlgOlH/zr1uFB06xlUuCULkdVjHAbtAl9/LzlbJShlK6XiPN2hsT1U1xiW7T5WIVtuH9t8N++rcJROodjIzKpdVMwt903AtqtuSNgArhbtPBf9Nb90n7D4DRr2tzn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717218; c=relaxed/simple;
	bh=jLR1YGSpfznlsV5IXa0lkVrnHvlrRcEWy7vboavp1Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q84NvokcU9c4p5IOy6bXTL0l11mJFEGX4b/V/rK4fMpjLwWmZ/x3cN3hQ7vBZIsefNzNxk6J7J9QyY6CE82pbrDqnVQuwBYtFU/WK57srueAU2GKu/R4koDdXkWUU4CDdhCdUlcJru2KMA9TSGY9p5K9F8xG/T8ezRdV/OLtjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIivNd+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723717212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Si//7O5ApUP1/yDL06AmAILjSFyyJ/JUarAYtZfx0u8=;
	b=PIivNd+71GUv958F0gDr8jXaHmqy7su7dng3yMJhKrRDQ0uszz2iN2PMuwSR92UJeq5VXm
	CdM5MH1GQbEAT7Zjkxbirslw/KHWDOxVGMBUxCFDszAPoGsQolNJRnIeIyj2VffNFMMTwO
	N05XeZgBeroXTpLI1pQRPm0MhHMBMk0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-yiNDX5rZMZWvTuba7UHbvg-1; Thu, 15 Aug 2024 06:20:09 -0400
X-MC-Unique: yiNDX5rZMZWvTuba7UHbvg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso7610731fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 03:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717208; x=1724322008;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Si//7O5ApUP1/yDL06AmAILjSFyyJ/JUarAYtZfx0u8=;
        b=KKZOScSgOpxHlHZFvuA8mwRd7X1aaTojq5ZgCv5y/Y88LRcvzn4zwkVLGo4ammwvUy
         H+uGjxkIg9bj/oO4UFtvDeBenIFpJ/oET+86X1XRUGkeisF2g1KkZQ/UOlqzwY5nsmVf
         uyGavU0x6W0wnXhMPfwJN2wUPUNcrTNHRSDJE1kDEQLGq5AjgPpeJNxZFZ3hV8agwqNy
         Q24WkJOJ+LkwSDRxEdFsPq+RHHczaQwc+IgJbVs8zECQX0fUNNwkCvdJP0PefmhvHOjC
         hR8lQ1RChdRZKKnlCZYRKqpHzZM+ZoCfdZD6LPU0GPbhJeq1T+PRnyDHaTuqZ0nHQqss
         A8yA==
X-Forwarded-Encrypted: i=1; AJvYcCU8/0HZSixlcSSYx7N9TZRECUmRIT3mM8B/CAfV60szt2GGuwfpx3x6q2hiFeJNJvpW8wZxM7HW1LE3NNr1YW//ItT0aNmP+Ph59zfzBA==
X-Gm-Message-State: AOJu0YwOWLPRuq/xK+XxipI5/VRNoAAaOJKGyDX7UA1mTDWijgLHsPUK
	T1ioFAfcl2skQ8PdNhzoBxPdK/nFuabBVS1AEro3vEUb8wX3pvCAUO+fF9999o/I6/xE1mOEkMi
	H3ebtk1r8cp1a7X41NcCb1mkggpjdRqMDnVGiYtQ9r7cR27mIFummhXh20VAyEjo=
X-Received: by 2002:a05:651c:4cb:b0:2f3:b081:114c with SMTP id 38308e7fff4ca-2f3b0811230mr27742521fa.40.1723717207573;
        Thu, 15 Aug 2024 03:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHux6zl6U7v9rMQLhfrQ4zeec5RHR/ht/KJxk5mZK5+XcKUmM1aN/PRnOCbP6iGW/YvCVN/Rg==
X-Received: by 2002:a05:651c:4cb:b0:2f3:b081:114c with SMTP id 38308e7fff4ca-2f3b0811230mr27742351fa.40.1723717206911;
        Thu, 15 Aug 2024 03:20:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm81438265e9.1.2024.08.15.03.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:20:06 -0700 (PDT)
Message-ID: <6938b43c-ec61-46f1-bccc-d1b8f6850253@redhat.com>
Date: Thu, 15 Aug 2024 12:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org,
 borntraeger@linux.ibm.com, corbet@lwn.net, frankja@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org, svens@linux.ibm.com,
 willy@infradead.org
References: <20240802155524.517137-8-david@redhat.com>
 <20240815100423.974775-1-p.raghav@samsung.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240815100423.974775-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.24 12:04, Pankaj Raghav wrote:
> Hi David,
> 
> On Fri, Aug 02, 2024 at 05:55:20PM +0200, David Hildenbrand wrote:
>>   			continue;
>>   		}
>>   
>> -		/* FOLL_DUMP to ignore special (like zero) pages */
>> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>> -
>> -		if (IS_ERR_OR_NULL(page))
>> +		folio = folio_walk_start(&fw, vma, addr, 0);
>> +		if (!folio)
>>   			continue;
>>   
>> -		folio = page_folio(page);
>>   		if (!is_transparent_hugepage(folio))
>>   			goto next;
>>   
>> @@ -3544,13 +3542,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>   
>>   		if (!folio_trylock(folio))
>>   			goto next;
>> +		folio_get(folio);
> 
> Shouldn't we lock the folio after we increase the refcount on the folio?
> i.e we do folio_get() first and then folio_trylock()?
> 
> That is how it was done before (through follow_page) and this patch changes
> that. Maybe it doesn't matter? To me increasing the refcount and then
> locking sounds more logical but I do see this ordering getting mixed all
> over the kernel.

There is no need to grab a folio reference if we hold an implicit 
reference through the mapping that cannot go away (not that we hold the 
page table lock). Locking the folio is not special in that regard: we 
just have to make sure that the folio cannot get freed concurrently, 
which is the case here.

So here, we really only grab a reference if we have to -- when we are 
about to drop the page table lock and will continue using the folio 
afterwards.

-- 
Cheers,

David / dhildenb


