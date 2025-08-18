Return-Path: <linux-fsdevel+bounces-58162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946CB2A550
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4A86260E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3CB32A3DC;
	Mon, 18 Aug 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNYNErkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6A320CDB
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523100; cv=none; b=XdFjh8sEL4aLaHp7ZfmU73Ro4bxEyJbYFKjL4Unb1e6WMSvg4Gxct+fuUrHwxJF02JU7Z5W+seiqQ8hxG5v/hZC37r5DQvdArcG8A4hNMJL65uj8Id1VyaF81oURQhnjTQX/hcntxK/6J+X3oGJ9/zHwJhVP+Nic4J4ADdomqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523100; c=relaxed/simple;
	bh=WgauoUWQT8jtKVybl1FQjLAo5ru9YepKL7+pAbrIews=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbqIBicfzo+2g3Czt5rAmhS7VqCBEj/L6CFdPYxe4SZ2bYH+r4o/RGgKKW5LBayRYDgmUA69bMydFwQN0WjdGm/mqJYtJ+w9Nrj8cfyOIMDGeebC94NDR8k1Ml5RdGjAfjNdkk99RlcXSAqowxwNLVlCBNub2FMnunPFeYPoTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNYNErkR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755523096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EI+lwS0pOMLisQZ2H6RwpS7sAotb8pPEp3ZpZSihh10=;
	b=FNYNErkREw469fQtp6I4fzWSBXwBzpFe4B0hHoOrF2sfIE6mYywoyTUiFu+NIFVMN05yGk
	onH3Cs5iqBXnQz8tLsTn9xzNJ8OFzci06kvyNfAF0RA7znSrLSJTyB2xi6Z0sXShYDld/A
	q0+Zjv4qj3yH25qvqS1PywhUkNjLQOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ZLRGCWBlMxq_a9_VD9MZUg-1; Mon, 18 Aug 2025 09:18:14 -0400
X-MC-Unique: ZLRGCWBlMxq_a9_VD9MZUg-1
X-Mimecast-MFC-AGG-ID: ZLRGCWBlMxq_a9_VD9MZUg_1755523093
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so17379735e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 06:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523093; x=1756127893;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI+lwS0pOMLisQZ2H6RwpS7sAotb8pPEp3ZpZSihh10=;
        b=lXn5VQdibIjg1dJiHE77q3J4lkeZO+Hq4w/k7rwQ3MUeDVYiHtQJo7SoDWbO9APIxr
         3SgfX2pHTYyleX8ICZYiJaa77gElYITyc8wO+2PJzx4YUjjetCTQtNY08yZfi/YmvEia
         dLVQDbWz+EZ418Th33tauLCH3vxCMGTimgfhdtoFXC/Uz1ZB/PCB/qrdpj4WjwLPIOyD
         KUZ0039AS2wbERhB3lAsNmixOAjSYpgfXrSyZnPPj/oxrUK2vU3rsUOS/ZyCzsm2NCpf
         HTEXGqvaTpx8woyINk+FYeLfJqxtRwge9bEgjBcsbIVa8tQNYtsfCviXgg0lr56GYfMJ
         0YTA==
X-Forwarded-Encrypted: i=1; AJvYcCXy5dcs7Er2Li7wmRfOxNUe9wQmzqIv/tQMcOgeHsveBOnjzDqcWQvGY6Y5H/Xr5lgnbwclKEW8dM02m/35@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwZfssa8jpj4eIOv+F0lsl7G+CDJM6qbLEDKUjolnhZDY8elq
	TWi3EYvHsg0eWlhXrdGsf2O5TlKxkZaKpta9dkpdiSCE8Kw2Me4lxTFtrpJ/wdrauIZvZVinUfk
	gLNfbinMP7uNUiL3ZB5KWaLUeGfTPGqddaBIuCKk84JncOGh+UEbMwpYIHEJySQ+McKU=
X-Gm-Gg: ASbGnctsh9WIE/8GYuW/OsevLIPHHazuCxLxJta1vibKmw5fx0gHmayeCnkJX/0FQS4
	1HWEkQnFKA1Tw1OTIUtCvFnD4pZ2rBR3dZ1DU724K4Gf3S3QZwX2C/RG0S0wil0HsmJGuZsP+Lo
	b2D+v9qszsOktyIKGRTDsKrRuOZxQNUDCd7F34DaO+ApEGNiUq5iFDr7F5CqOsBoV9Mnz89uIUX
	UcUqmrGVKoUX+Mf6Pf4mB1tV7Wtw8ezt05RSSoXNYT3RXl555FqIdFAf4caR1YU6MTJudHM3ikr
	sk46UvagTOGxaG9G2N3A9Dp0dIapqpDk00VzyliomoPqyyPjdfZoif0IJgSvXj4hE8kHsYBFvMb
	TD/cTFuziKNgbuw6E8XS5Y/foK4u8jmnn4X7KwPEm6I4ZzpOSxRTpvHccEsRLKeRg
X-Received: by 2002:a05:600c:4f02:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-45a25d5f37dmr66229605e9.25.1755523093080;
        Mon, 18 Aug 2025 06:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvCChE+JR/YLl5igJTrgibt6OaLIWASKnwzJNFN0U4+Ia5ln7iG9FJAn8iRzHdw5mUIB0cBw==
X-Received: by 2002:a05:600c:4f02:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-45a25d5f37dmr66229165e9.25.1755523092684;
        Mon, 18 Aug 2025 06:18:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9431sm13351453f8f.40.2025.08.18.06.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:18:12 -0700 (PDT)
Message-ID: <092a4ef3-c97c-4a94-b857-a443fb5f8568@redhat.com>
Date: Mon, 18 Aug 2025 15:18:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: remove write_cache_pages
To: Christoph Hellwig <hch@lst.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-bcachefs@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250818061017.1526853-1-hch@lst.de>
 <20250818061017.1526853-4-hch@lst.de>
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
In-Reply-To: <20250818061017.1526853-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 08:10, Christoph Hellwig wrote:
> No users left.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


