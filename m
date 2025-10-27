Return-Path: <linux-fsdevel+bounces-65744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C1C0F7AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A6D64FB1F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9D3128DC;
	Mon, 27 Oct 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQjGyIYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445D1E5B72
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584008; cv=none; b=SbgRNXU6ouOe5aap3622rNQhYJa8QkIqMSeDgvyCVhEHo0w7Opqc+sO4qM6P9pdyB3jEpH4oGhjGAwwfQdFSPx6rk46FWj1SH/bIW0vThszZzJngaWGco94Uy6emYM/dKoahFJ4qzW1ktjDysy0dCbEMnmdFyPGSFe2u8bMliaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584008; c=relaxed/simple;
	bh=k21mR1kjjuCUY2QQ14L6o4TJ1+uo5urhzwqkf666nZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErVZz7tfZGL0+Z02qKMaYWl1xSguNsezdWKKOQTd7fyWBQxbMXGvvXK5wd9I+UrwLGo4AQK/uuaCFrhZDqB2F8xpwnGM5zmAm7EWgpQBmr4OlqVBhSzhkdt/nhbAZkyARNuDwaiT3Eo0+yCR1qz9z1KYQ+B4PvBHGfVKFxQLot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQjGyIYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761584005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yyrxsbS4pWA34fFEqr8sYK1KnLCfuGgdwv61SrYMo2M=;
	b=bQjGyIYEayVTb7MCFV1Wsy8mpdR0kFQ8sCeXG+JDqv+9ivkZtqYJJa5dPQy1qqNHlzT9hx
	LBrG+/0M/G3TkYAT5MwCLA29o8KRAO+aZBehnTUUVFOUFVRBNrrn6cLfqSVt+pbaAGITKi
	2w2QTscF7YVMXXcztUm8kGRtM2wjSSE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--1GjxIGsN72OvXVtoDkmKQ-1; Mon, 27 Oct 2025 12:53:23 -0400
X-MC-Unique: -1GjxIGsN72OvXVtoDkmKQ-1
X-Mimecast-MFC-AGG-ID: -1GjxIGsN72OvXVtoDkmKQ_1761584002
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3287422f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584002; x=1762188802;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyrxsbS4pWA34fFEqr8sYK1KnLCfuGgdwv61SrYMo2M=;
        b=gCGZK1Mm1Ncd9MrCbEngLfZj2rKZRTvwZ4Tx33AVgYPD4SgaWC8T0I3H+qYmevQYI5
         f+Jj7gDKq/nZBQmX0pgtpoNO7+o+rXhvfv6RcNmEh38+XbUvEQw4zApSw+Iz8LIelkHD
         RPJXL3/kTGN9ZNqwjkH1NK9/dPyyltK+HPWzTe33uABiUNBXc7uyvy4CLQPZdxET9DyS
         pNeCAEe+tNDnYruN1obnVo97vBU/yRRao3ecddYqOc8mRfoeGkQhPr9FZOA63Oaxi4E+
         NaOYOWAiL5LEdOF+bUIrHJgesEzHnsJosCqltlmTKvsILUNum7Up1kqKu6t+geCtA4y3
         d4nw==
X-Forwarded-Encrypted: i=1; AJvYcCVkKI0Otx1ElgqW8UhS9i+ta8eCtaVRx1Okf6oHkEGENp0Gwqqb0u9a279UQt01aYs0cTOHknn8K5BSuqzn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzny5kpy6mSg0H5CGFuzw/aCa+C8ezFjssmupBw5Hsjlv6gn1Sy
	TqLkwF9w69hWY2l8HRXjqsA3+Y+qC3IZSZd3Nve+58XaLVfa3QGyX+8hzTTdGGr6jRd3uxhdOmz
	GSiMzT5PbqOldXErMcOe3fVncfocvMLB91TnoytIHcdhQw6pEfzMxzKnxhJPVY/IQyEE=
X-Gm-Gg: ASbGnctnI9O+yn3O64BeYpbsJFHZB+ZnUv1k7QQfGmaK+2KN0O9B7wGOOAPILdynbKV
	Bsonuio/yfSeikTFkvftrJW1kS0412h5TVkg7qGmisYY4tXy8EdmT8z/wSguGv+O9PqVsBaJ+qt
	yh6EJdfsQXqB0Yh+iesDaqsJnus3W4zopffCobP7QMODdj9kq+umNmjvN71TvQuqYVa2CbSEtPq
	Z6AlAj1Boq+J6rKr0LVB2i1eYNNjlRoZL5xsJ72V6LdXvWU8Q43sTBUPEtSgi85SyOLpjVXJV8Q
	OvC8nd1KWZojTOWe6gltrKLH18UxzdfzSunm6V5bStCAFJRVVKjV5eriz7daJGqLHwAQkgPRFHq
	ALoDI+OK6IzY3b0e2Af9I+P92RZCOBG1qEq8xYvOD3h4zGieLsiTBwpwJX/KwVg39noTyLQnJW5
	Px6obD+6hGjbnefpKOwUJp9DRduYk=
X-Received: by 2002:a05:6000:2085:b0:428:56c5:b305 with SMTP id ffacd0b85a97d-429a81a8444mr148338f8f.6.1761584001715;
        Mon, 27 Oct 2025 09:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoK/qb57I2ph/yRYVVzOerbIGxBbhgWC3n/pibQjUkUWrAUSSMmKLj0i7DtxPcapcs/6SEdA==
X-Received: by 2002:a05:6000:2085:b0:428:56c5:b305 with SMTP id ffacd0b85a97d-429a81a8444mr148311f8f.6.1761584001271;
        Mon, 27 Oct 2025 09:53:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df6b9sm15906933f8f.44.2025.10.27.09.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:53:20 -0700 (PDT)
Message-ID: <b49e12b1-acc1-4150-9ab8-63c05d45ea90@redhat.com>
Date: Mon, 27 Oct 2025 17:53:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
 <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
 <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
 <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
 <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 17:48, Linus Torvalds wrote:
> On Mon, 27 Oct 2025 at 09:06, David Hildenbrand <david@redhat.com> wrote:
>>
>> So I really wish that we can defer optimizing this to freeing folios
>> under RCU instead.
> 
> So just to see, I dug around when we started to do the rcu-protected
> folio lookup (well, it was obviously not a folio at the time).
> 
> Mainly because we actually had a lot more of those subtle
> folio_try_get() users than I expected us to have,
> 
> It goes back to July 2008 (commit e286781d5f2e: "mm: speculative page
> references" being the first in the series).
> 
> I do have to say that the original naming was better: we used to call
> the "try_get" operation "page_cache_get_speculative()", which made it
> very clear that it was doing something speculative and different from
> some of our other rcu patterns, where if it's successful it's all
> good.
> 
> Because even when successful, the folio in folio_try_get() is still
> speculative and needs checking.

Right, and we only access its content after verifying that (a) it is the 
one we wanted to access and (b) stabilizing it, so it will stay that way.

> 
> Not all of our current users seem to re-verify the source of the folio
> afterwards (deferred_split_scan() makes me go "Uhh - you seem to rely
> on folio_try_get() as some kind of validity check" for example).

Note that deferred_split_scan() only operates with anon folios and has 
some nasty NASTY interaction with folio freeing. :)

-- 
Cheers

David / dhildenb


