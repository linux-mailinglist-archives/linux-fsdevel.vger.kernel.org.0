Return-Path: <linux-fsdevel+bounces-64916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD7BF678A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C254001C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB332E6B1;
	Tue, 21 Oct 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDNDPvvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAE28A1F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050026; cv=none; b=XobmZVotbVNnKWCW/XBTNOhXluZYx0mTKNCUYv2uYACVUp9sm4QwUh9P+vQF41oDcxxEJFI+Xs2kaJhurhackWAHyTN9q2rcD3t0494M1pX2yk/0VLHT/y9OkfjlWwSbrMWiAdhg4LibXJvtS76rcVpVAauF4p35knR8bqm6CUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050026; c=relaxed/simple;
	bh=Ns4YxXjAdr/bcm7YsKhYSaAihmKGMXbxqznBtGgUMg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8ez+0sgcPQhzIf+2GomNk8wsy+U1zOkSiOcGau3utyuQEzz5OLFV0Q16CAT+zXYxXBy99IpT6SM6mFijhIM0JX+oRMUV9ogMoQ/H1HdjJ2j2Co7YPIlgan5How7zfL9td+Ctx433ue7XXbLcSpCu/jLVqKYNhCgm57V2rsahoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDNDPvvy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761050024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MfqnXu+UHWjME7EnozBlaXknDB7yHQ4Xn7QOHKbDIt8=;
	b=gDNDPvvyWijrPk8ppngsPUoDIFwhI1BpX6nqiFFB8ku/G6M2Owxx8QV0xrCVaxE2oEpGXr
	ZIzQNnegh3SY5oUe/7/cgslUx8/2pCQWRAP6U6TEJC82X0R6Pe4FaThOdrHn65E/EboBmD
	/yhlTycSnX+LAB9GOxbNZKuh+eVtpn0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-A8kf1Su3PYifjjkvRJHwCw-1; Tue, 21 Oct 2025 08:33:42 -0400
X-MC-Unique: A8kf1Su3PYifjjkvRJHwCw-1
X-Mimecast-MFC-AGG-ID: A8kf1Su3PYifjjkvRJHwCw_1761050022
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f63faso2850690f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 05:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050021; x=1761654821;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfqnXu+UHWjME7EnozBlaXknDB7yHQ4Xn7QOHKbDIt8=;
        b=KttrLAtHPwOrE4LiXAANOyE5on/nGy+pY7UNVTzwknSMnkFIR00wdQFoEhMR55Wni8
         FWAsRcjDL5rFT/LsD4nBrRQiukwJR4mKGY7SQmz0Wioh4b76zFfrXtnf/tfY9Nvb4dSo
         uFj+3l14LXkVNDpsnXvQOL28caxIQpRtFy+i1VoCI0Kjv1nSX1LSSrAkPqLqS20sblOL
         znIqoE1mkbBKppqYbiOsIk3fF8KTB/+MnZIdtugcrMgJiOWadLHHo0iDdD8yDj6GyOJh
         kpByC/5LbHlOS9RdH6/IHU0WV+qDxONExTjsifDHcpqXYMEjbmNNmq5JZPoIRvgNllNw
         Hk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlDA2/G4FO6YcOxzf/dKayaVYAcG4L6qQjTW4asWrT4MBhIgNA1C+3TTgGpgs6dIa/iXtI832dr3IbUPan@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQSabaEuxQZ4dVTZAvKxTq3m19rDsROStPnnoN1M0xBNwzhTb
	fg0UgshfQjxN2qOW6A3y+7ZBtDAtqkxHNmQeCwO+Y9QebRd/ZaVbaiUhu44WcYjOWkFZ6YABMAE
	eSul3AbCv+FhsKUTtZcxhKoWF/R8oNXL7LmiDD5Fo4c+c3k5684zGvwRCRFLs1Lpr590=
X-Gm-Gg: ASbGncvccHbOUoLp+AULVMljirdIw3Vx2ovf05ZW9sDfPp+ToCtQ6KzZKZSxnu/5NLJ
	eX0ISLpJmX8lJJVlxSpvaltDXMKFKMRNk9lwIbxRTvdisZ/zDxuFrL+hJBxveBi0pILKy+ht1bN
	HF0Pr+weJOp442/C/wYdQIgs+uSk3QKnu0UVa/iEUSgwiYRR4qhRJB9xFs/vSIXQE6HUuj7DuN8
	RL1yYJ1GsocpWODkxcp2upep+2OxOdDESkbiOFpKEzgnu9artsLKQMgxuC9np6uWu1E1GE/1Ia8
	TdP2xN7UC68R9Yqxgbggl7HQv3aenTqeUWdMR4lOjTBQyUlVjwQJhqsnHMn8Se9i7UER4pGsemm
	2NcAkSE53NZOnsXyE7j6w/W0cDVciy8VHbOToC7uHFd/hdCV5Tpt/15WU6WVeXyCbaGyzPITfhK
	I395FWfpn0KEk2e7UDKsTdGfQORPM=
X-Received: by 2002:a05:6000:3105:b0:427:64c:daaa with SMTP id ffacd0b85a97d-427064cdaecmr11439617f8f.44.1761050021491;
        Tue, 21 Oct 2025 05:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbCiQc+vS9vXSdPHPSKOQwG7mGLzY805GtcC7o+CtuZ741gU2aVh1wRQDPgu9lruJSTs/eTQ==
X-Received: by 2002:a05:6000:3105:b0:427:64c:daaa with SMTP id ffacd0b85a97d-427064cdaecmr11439582f8f.44.1761050021055;
        Tue, 21 Oct 2025 05:33:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9853sm20072238f8f.33.2025.10.21.05.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:33:40 -0700 (PDT)
Message-ID: <fb51f195-b4d1-4bf4-84cf-87d433f8ac86@redhat.com>
Date: Tue, 21 Oct 2025 14:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
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
In-Reply-To: <20251021063509.1101728-2-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 08:35, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> This behavior might not be respected on truncation.
> 
> During truncation, the kernel splits a large folio in order to reclaim
> memory. As a side effect, it unmaps the folio and destroys PMD mappings
> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
> are preserved.
> 
> However, if the split fails, PMD mappings are preserved and the user
> will not receive SIGBUS on any accesses within the PMD.
> 
> Unmap the folio on split failure. It will lead to refault as PTEs and
> preserve SIGBUS semantics.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>   mm/truncate.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 91eb92a5ce4f..cdb698b5f7fa 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -177,6 +177,28 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
>   	return 0;
>   }
>   
> +static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
> +{
> +	enum ttu_flags ttu_flags =
> +		TTU_RMAP_LOCKED |
> +		TTU_SYNC |
> +		TTU_BATCH_FLUSH |

I recall that this flag interacts with try_to_unmap_flush() / 
try_to_unmap_flush_dirty().

See unmap_folio() as one example.

If so, aren't we missing such a call or is the flush implied already 
somehow?

> +		TTU_SPLIT_HUGE_PMD |
> +		TTU_IGNORE_MLOCK;
> +	int ret;
> +
> +	ret = try_folio_split(folio, split_at, NULL);
> +
> +	/*
> +	 * If the split fails, unmap the folio, so it will be refaulted
> +	 * with PTEs to respect SIGBUS semantics.
> +	 */
> +	if (ret)
> +		try_to_unmap(folio, ttu_flags);

Just wondering: do we want to check whether the folio is now actually 
completely unmapped through !folio_mapped() and try to handle if it 
isn't (maybe just warn? Don't know)

We usually check after try_to_unmap() whether we actually found all 
mappings (see unmap_poisoned_folio()). I recall some corner cases where 
unmapping could fail, but I don't remember whether that's specific to 
anonymous pages only.

> +
> +	return ret;
> +}
> +
>   /*
>    * Handle partial folios.  The folio may be entirely within the
>    * range if a split has raced with us.  If not, we zero the part of the
> @@ -224,7 +246,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>   		return true;
>   
>   	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
> -	if (!try_folio_split(folio, split_at, NULL)) {
> +	if (!try_folio_split_or_unmap(folio, split_at)) {
>   		/*
>   		 * try to split at offset + length to make sure folios within
>   		 * the range can be dropped, especially to avoid memory waste
> @@ -249,12 +271,13 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>   			goto out;
>   
>   		/*
> +		 * Split the folio.

I'd drop that. It's not particularly helpful given that we call 
try_folio_split_or_unmap() and mention further above "try to split at 
offset".

Nothing else jumped at me!

-- 
Cheers

David / dhildenb


