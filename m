Return-Path: <linux-fsdevel+bounces-48044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B807EAA9099
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA97D17608C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73141FFC54;
	Mon,  5 May 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijC8Cqhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F51FECB0
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439742; cv=none; b=adzLsUbA/QXnHjoajfaCmfXDylxgTmf+WUBAuTXO7OCqEwDAIJ2f+R0EEK23azdm8M1OE7OHGmWF957BLm40AswiqlclvZ83CVi+lpvAeAiIkrUSNBiA+lSgaj/XLZ5ZlCY7qRUNDSXSgVIv+Sh5wLAIID6ElnYMTrSdJgD9Qdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439742; c=relaxed/simple;
	bh=722/T7/hn4P4TvL9II+YDJBbS5pxncQAa28oCON+Vrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdHjUp0z799/VEL4XnR7Fx2QQHyJKkBSqaaDs3NtWPY4cF4brXYzSovrdKPF43UAIU/RXnGknmmAVN2wPJ1csE3O4iMtGMlD+B43/N8fsmulqcwAJLD69eEIF1Zu0mr8/kMbk6LuMf9TG7lP6bLWS3yJbiGoBnbybAuiFepJOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijC8Cqhb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746439739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BmTwP3C/5RRHNa0cESV330FAgf6OjrxM/JkWPUJkdr4=;
	b=ijC8Cqhb9owexcj8Ls/ioT2HGqT5u3EyYh1DokUuROFfWzzuAVi39BWv8BM4rOOiGPmUl+
	tQOL/Wp2aLlm24iRdUD3ds2ar4PIXlW7423JsZrehAV+5ElJmHmCaQfKbYuekQpjpgsHOc
	1vcHAJt6fjySPfW7xXl09Z9ox7UaGTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-whX1y_mvNwqvCcAsY7TYKw-1; Mon, 05 May 2025 06:08:58 -0400
X-MC-Unique: whX1y_mvNwqvCcAsY7TYKw-1
X-Mimecast-MFC-AGG-ID: whX1y_mvNwqvCcAsY7TYKw_1746439737
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-440667e7f92so24790095e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 03:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439737; x=1747044537;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmTwP3C/5RRHNa0cESV330FAgf6OjrxM/JkWPUJkdr4=;
        b=nBqGBS+J3Z9WS0i+tLdjJp0TtGcAfByV3cRvpDl+a0uXmNA39DhoNR/Q39bqFpfWBv
         xH/j0QuRz2eQWhw/N3rvp7Y7DkeCl2e9q4DPg9z+/kn/O5wz9nq7hSc8LwlAMGBUBN/s
         4hqU5H0wTLxBkV4EiCAueqM3xmfbg+tDzL953xQrBMtqzA7eBjRP4Uu4zhVFXKeJzN6w
         srMQJMUSRI8zAzTx9awCM4Hh0bwhy6IF07kezwwtgv65XuvNkZz7A7GU3AX7biYH1Rui
         8PIuQOxiD5FJqgKSVeb6tTOP+7yLx5oqja0z76O87EZ/mJlMixbr6P1nGCNlWFIetXYr
         UkBw==
X-Forwarded-Encrypted: i=1; AJvYcCXqPb/lYLLRkYgz1dYaonKqxJxeBa+Cx4uDu6sdWoFLedgcnM6+VBSRVigzndqsJ4nu3IHpB73YTfnM1k6z@vger.kernel.org
X-Gm-Message-State: AOJu0YyncPADgwoKXAPZgUGHx6EWZhErtl6AjG+MFq7SQKbSDsxeVIpx
	tdg88qKdu3S9optwFV4c6FHp0e7Crvi3x+dheIahVtUWSJ3OZU/eDxSOvkhnoIp1sQXhzcq8i1C
	tB955vQ8v7FhaxmcfSKeecERj1heuUrLZzGDp4UQeWw8xOtLkO7vfrSCRJStZI1s=
X-Gm-Gg: ASbGnctb6uMCr+xuVKjBRBmXW1oF9zzH9E5HPEg3cFDVwJ64emsGyIiD2ioUs8l+GoB
	tN0BmfCb9pK42dcL0cLi66fQGGB2MQN3gE3ZPwgqDhltaK9LpeSZxXWsSs0fRFvrYI1Ha2ej++e
	qNg+soUAH7mUde21uM0DZFVyycIQA3G1/+AKca8zZ0aZ0dvIv4WjcETbV30KIwZ6zsw/h/I4AIc
	A6hLwvI0h4vX6nQwZ2TksKdIcQZ44O3mkFAP+1Qobqr/ZL3gJgxrogl2ZECyd5AjLCoPKEKcTgE
	H60PRd32NsqDvsuzOYoFKvbYmIRNA+IiauRk2GVpTHQ1oIa15y65FxkIvPN4QkDFTWEtgRpqq6J
	giSzHvRFWLCP+oo3F1DdpvCptHEl4musfr1wYRyA=
X-Received: by 2002:a05:600c:a13:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-441c48bca3bmr57375815e9.8.1746439736743;
        Mon, 05 May 2025 03:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPx432VgCohrDR6C5RgxgqMkrU5XckKpboeqJ5naVLmUoTk99ORY1qD6XhEz6hLJ5dyJF7Ng==
X-Received: by 2002:a05:600c:a13:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-441c48bca3bmr57375515e9.8.1746439736336;
        Mon, 05 May 2025 03:08:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441c0dfc537sm82386455e9.16.2025.05.05.03.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 03:08:55 -0700 (PDT)
Message-ID: <c8f78fd6-c1fb-4884-b370-cb6b03e573b6@redhat.com>
Date: Mon, 5 May 2025 12:08:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] mm/readahead: Store folio order in struct
 file_ra_state
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-5-ryan.roberts@arm.com>
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
In-Reply-To: <20250430145920.3748738-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 16:59, Ryan Roberts wrote:
> Previously the folio order of the previous readahead request was
> inferred from the folio who's readahead marker was hit. But due to the
> way we have to round to non-natural boundaries sometimes, this first
> folio in the readahead block is often smaller than the preferred order
> for that request. This means that for cases where the initial sync
> readahead is poorly aligned, the folio order will ramp up much more
> slowly.
> 
> So instead, let's store the order in struct file_ra_state so we are not
> affected by any required alignment. We previously made enough room in
> the struct for a 16 order field. This should be plenty big enough since
> we are limited to MAX_PAGECACHE_ORDER anyway, which is certainly never
> larger than ~20.
> 
> Since we now pass order in struct file_ra_state, page_cache_ra_order()
> no longer needs it's new_order parameter, so let's remove that.
> 
> Worked example:
> 
> Here we are touching pages 17-256 sequentially just as we did in the
> previous commit, but now that we are remembering the preferred order
> explicitly, we no longer have the slow ramp up problem. Note
> specifically that we no longer have 2 rounds (2x ~128K) of order-2
> folios:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
> FOLIO  0x00040000  0x00050000       65536       64       80     16      4
> FOLIO  0x00050000  0x00060000       65536       80       96     16      4
> FOLIO  0x00060000  0x00080000      131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
> FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
> FOLIO  0x00100000  0x00120000      131072      256      288     32      5
> FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
> HOLE   0x00140000  0x00800000     7077888      320     2048   1728
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/fs.h |  2 ++
>   mm/filemap.c       |  6 ++++--
>   mm/internal.h      |  3 +--
>   mm/readahead.c     | 18 +++++++++++-------
>   4 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 44362bef0010..cde482a7270a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1031,6 +1031,7 @@ struct fown_struct {
>    *      and so were/are genuinely "ahead".  Start next readahead when
>    *      the first of these pages is accessed.
>    * @ra_pages: Maximum size of a readahead request, copied from the bdi.
> + * @order: Preferred folio order used for most recent readahead.

Looking at other members, and how it relates to the other members, 
should we call this something like "ra_prev_order" / "prev_ra_order" to 
distinguish it from !ra members and indicate the "most recent" semantics 
similar to "prev_pos"?

Just a thought while digging through this patch ...

...

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3222,7 +3222,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   		if (!(vm_flags & VM_RAND_READ))
>   			ra->size *= 2;
>   		ra->async_size = HPAGE_PMD_NR;
> -		page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
> +		ra->order = HPAGE_PMD_ORDER;
> +		page_cache_ra_order(&ractl, ra);
>   		return fpin;
>   	}
>   #endif
> @@ -3258,8 +3259,9 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>   	ra->size = ra->ra_pages;
>   	ra->async_size = ra->ra_pages / 4;
> +	ra->order = 0;
>   	ractl._index = ra->start;
> -	page_cache_ra_order(&ractl, ra, 0);
> +	page_cache_ra_order(&ractl, ra);
>   	return fpin;
>   }

Why not let page_cache_ra_order() consume the order and update ra->order 
(or however it will be called :) ) internally?

That might make at least the "most recent readahead" semantics of the 
variable clearer.

Again, just a thought ...

-- 
Cheers,

David / dhildenb


