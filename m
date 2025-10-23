Return-Path: <linux-fsdevel+bounces-65295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB8C00975
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9093AD65C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370F30B50A;
	Thu, 23 Oct 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDieVXuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5E302159
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216908; cv=none; b=HUcH0ESvvZMUBYiCtY0JJM4DOaogqbZ/hpfnlgEGVHcMgGMDZIiz/qhvplGQAmoxHLPvebEIWYyXgLpXXOzgamOIBNMpqBp5IqfUXm49qOZ/xdeIYG8r7sb2o5veAGkXU0xgvin/zp0/WnOvrbfegj/Suv+qdsm/yt3OEeawnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216908; c=relaxed/simple;
	bh=ASzPyqFrZBTVAy8rDcV1xKo3KPSuUV4Ayl1O0iKTOQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9V3kdYn1selAQs0YpNDhopBWc2YkFQC7//gdRnZeKNo0dA4nLV2hkdHpt2qz3XU3TSiIfAc7GQMvVbQZTum1ozCHgY97PjaigjyiTsS0mIrsmBeBvP6u79FHhZDlP7coZrWp8tP4G8+Ypbkwc+g4kdKYPS4FN/gsLgVXbXfjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDieVXuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lbLKX68koPI4kruyudw5cKYMlwi7wHT0sON4jcBvqmQ=;
	b=gDieVXuqu3acJiKf4+epXv5ezmMCLWG6PK1CZGjxRIaYD3b7nse+1NpoJV2QUxKRGXrCSh
	t5zYbnpG0oOuWVn82eVuSF26ONhdh59UAkBEHBduGXXPG0hcMkPbFoBdAuibW7FOkmlYKg
	QPlNpEt7qaV33gwsaOA/fQGxBfqcXTc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-NfGXNjIkM-uF8KKgTMwPJg-1; Thu, 23 Oct 2025 06:55:02 -0400
X-MC-Unique: NfGXNjIkM-uF8KKgTMwPJg-1
X-Mimecast-MFC-AGG-ID: NfGXNjIkM-uF8KKgTMwPJg_1761216901
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so2730005e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 03:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216901; x=1761821701;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbLKX68koPI4kruyudw5cKYMlwi7wHT0sON4jcBvqmQ=;
        b=Dt3jrinUEjj0q6z8kLwl/yrhxtpCgLVs3AkNGyGfshnpzNfWnQe5j/8kqMtMKyldqH
         6cX5s2NL87UN/OoETI19eSAAmvFZknraFlShTBLpliKTa3djbHcDvBLUDlvWHF/Vdup2
         uYpy9GLR9OtIix3EnqYiyBRf+ACrgXZHmdnjwGSTHG8TEh9xjaLWfHk/ynNcHrGM/V2c
         cmhX5WnGhuf/aiJDjeAtds8XBzzznFRkOfBs3rCJzfwgMtmQIJZ8f5MnNlGNVno+EYl0
         x0MFzynq21+OrjUMKNfbvE22e+uxyuGbhgis1Op7+HSckOqms8bBGp35Bb5Q57sHCaML
         CZAw==
X-Forwarded-Encrypted: i=1; AJvYcCV7tMduymvbpSnbCSlDfZZCy8enn7i2fABqlxDecAQuDc1lHVVbNBhCuJdwrpp46oKkwM9YiDqGtPXi3HTf@vger.kernel.org
X-Gm-Message-State: AOJu0YxxY/BthsdV19HUFTwuNiV3Vv9raAXDK1WnBoS1gQl3KUGFFRGG
	Lw8AMURQbuwH9o7wElNGDZqGMIdK7lN6hnKTLguHUbdyPNueAkn7xDA3ssZEu00PczYB22QVTz6
	gluTA8PASY4ARCFF4abHVjAFfd398r4Gitx1BUPlqdkzs/tZqnqFwoolmxBvbjzSj/sc=
X-Gm-Gg: ASbGnctScNDmdsYcgrGgFtP6iI6D3IdmwBw6v4iy0vCYY8IsaS5qylLnTrC3ImQt3GI
	Fa6HYcx5O9QUpPlxWS5kQEC8PMbSR54OneikWnM1j/tQPoSiRMFUyhO6HhluazO243ZiZRuNfYn
	Y4fspHeXc5TAOehug1Pc+AUwDqD6BUMqpn1Km0uFfZ7360v+hijBvnRZeNUbG0wXrZRhCXk9C51
	y4q5jaGYfGsjx6dChr0AWoKc8IEsS1+PHcBnGxkj0WYRDIHcZDlc1ZUQFIg66WvpFGb37CF40y2
	sBj3OsCyyMAB6f4eC7qC1I6Tvdmkd+meXuDBgOCvjYIsMEtRCeCEDN7wQBYN7Oo5zFxcL1c312T
	LwkTMghqGN/HQfWiN/2QdTzYt+RSmCU3WJ7C+o+WEiFZzUW1+H1SNTPpijTFuRrCWQlAwcR4Pwb
	+amCSJyLShhZg/KzVk7o8ZrDF2gSA=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr175144375e9.25.1761216901490;
        Thu, 23 Oct 2025 03:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyUNeHJgwXCbIligtDABnZfmVfKo4xq28X5BL2u+Iw9UgWmk5i0BeHZ0usCgIJViVp2uc3nA==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr175144205e9.25.1761216901065;
        Thu, 23 Oct 2025 03:55:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf3b51sm55877895e9.9.2025.10.23.03.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:55:00 -0700 (PDT)
Message-ID: <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
Date: Thu, 23 Oct 2025 12:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 12:31, Kiryl Shutsemau wrote:
> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
>> "garbage" as in pointing at something without a direct map, something that's
>> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
>> undesired read-effects.
> 
> Pedro already points to the problem with missing direct mapping.
> _nofault() copy should help with this.

Yeah, we do something similar when reading the kcore for that reason.

> 
> Can direct mapping ever be converted to MMIO? It can be converted to DMA
> buffer (which is fine), but MMIO? I have not seen it even in virtualized
> environments.

I recall discussions in the context of PAT and the adjustment of caching 
attributes of the direct map for MMIO purposes: so I suspect there are 
ways that can happen, but I am not 100% sure.


Thinking about it, in VMs we have the direct map set on balloon inflated 
pages that should not be touched, not even read, otherwise your 
hypervisor might get very angry. That case we could likely handle by 
checking whether the source page actually exists and doesn't have 
PageOffline() set, before accessing it. A bit nasty.

A more obscure cases would probably be reading a page that was poisoned 
by hardware and is not expected to be used anymore. Could also be 
checked by checking the page.

Essentially all cases where we try to avoid reading ordinary memory 
already when creating memory dumps that might have a direct map.


Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.

On s390x, reading a "protected" page of a CoCo Vm will trigger an 
interrupt, I'd assume _nofault would take care of this.

-- 
Cheers

David / dhildenb


