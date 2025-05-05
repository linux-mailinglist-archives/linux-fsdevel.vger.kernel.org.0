Return-Path: <linux-fsdevel+bounces-48041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858E1AA9066
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F41175E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533B1F790F;
	Mon,  5 May 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNLgFbr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C24174A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439065; cv=none; b=qQTsV8ObpBsnyHvyABL+l0a3FwcrBBdWbRS+WEl4hW06O8aeywQ5LoNorYQqar+PQHuWdL23RI1jZ5xSJjleUuueeqrRPDdCGrY3bW4vIjPvvMyG8URjtkEl3160AJUB+wGkPQChVlpYOrF9LyggCevN0MH0bjo0eoQfETpui9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439065; c=relaxed/simple;
	bh=MD7BwA1iF2+cJiCKkOn0rOo3DP3w4YwY8e9xKYi/lQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz0geS+2m4f70Ag54sfhnwGMqFUAL9dTXrxGP4uOn+0hLL0u0Gc60kunD93P0/oR2VKcziKoEacp2apCIS7CubvdoxcFPaRM92WxZSq5Q5JYd50SBMBpR9lYeJH5K5ehABzCN226x6S8EJkQav546t1/UE6Rx3QtcSZ0ZnOTJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNLgFbr8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746439063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PKpVQKr8dLLUpoWrktCT6IWgKKoHWqB8wx1c+ST3NKI=;
	b=LNLgFbr8sC36w0BgPIghfEtqzj36ghx7Qy9tbIJOrps3Tx4sKGU11xlGeg0CWsxfPJHYRH
	DIW2LBQEvXvBotmblWD7sEUym1J6uJ9mWACrCZCEg7jldsLe8kJVJTwLHXiDEAZVgoJGVn
	HpkLO5YQdkIGpo2/cVYpZFMZ+C2U7F8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-KAuKQO1oPU2W28Lyu6CKJw-1; Mon, 05 May 2025 05:57:42 -0400
X-MC-Unique: KAuKQO1oPU2W28Lyu6CKJw-1
X-Mimecast-MFC-AGG-ID: KAuKQO1oPU2W28Lyu6CKJw_1746439061
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-44059976a1fso18010085e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 02:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439061; x=1747043861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKpVQKr8dLLUpoWrktCT6IWgKKoHWqB8wx1c+ST3NKI=;
        b=dNVOgu99npcmThY/QLk5X+gdSQsy0/W+UhgFibT7hvd/RaqVNC11GMO8iLC+FX6qSZ
         VhDrdAUjXARffaiEW0JZaNHr2lAKG0G/B8FBjQj6bY/qxfdJsQ1uMkBFUF/oj+233wvv
         smeo0piIEwXTnm8Gz9gWuuyIVJsbbub7/Q1DV1pIa3Nm3WZ+fHRirAbPdKQAs5UIQ+tm
         N89VAjhURWThwQhYWcotXdAJh8aC2lpZbxbWT7+c6eGjBRC/mlT+6MsyqtAaSSmBoBcp
         ++kBKxYY0gcK1mPBsqsz+1lSkxnkDoLcm68Do1IKDYxB66KuGItZAUxWwBYUJlNIMw4X
         uk7A==
X-Forwarded-Encrypted: i=1; AJvYcCUuJRGhseESC2p4z8x9zRy2/VGG62cwij+llyx0OAD23VoYQ+8LrZAUKF5t1mo9lGH6Yu5QcEi8pCFvKWrP@vger.kernel.org
X-Gm-Message-State: AOJu0YzSc1+qnBpewE0ITzMNGbFDkYmBAFEuFOJ2i9UDcunjXjTaA87I
	+B0lpCOe2Gc+OqU5lixgWudt0/HULMAHVwtqhLUhi50PBzA4eMonDHmBkC3kgce/dPBMrCkBYdV
	kIxCP6hjro7jvSFZZRJCppnCkoFmJOK09VcGhh5VJBJjMHv0fIoG3B0AGd4rLr/A=
X-Gm-Gg: ASbGncsOlyoCk4wdOFFirWnqhGxroNfoUGPrLxpqTarA84w48utrP9/xC9hmwA/gjJm
	X1JkTtMKDHIdzwsoKKtVb7Us0hZ1ZRQZg5xRgXF3BdgxhJEhEg3tSyYNeAIsCUAJxNdUmG1OiCd
	TrsMdEwnvTrZmm7e5lEyXfpkuZ3KYbOQ8XNzEkDZ79m4Cw4LP9Sc/xwreNK1TGwAtGp3zvxTBQ8
	oVjrTO34BTepCf+QwpJhrmlDnMbEsadZeRnhLgmUt+dZq8fVvBNFX6lM8HQfQg+ymGbBX1NmwQN
	RkSofSr0Me/dKXJwRUcoQq5MYNwZbhOZsaroxrAS81d+opJY2CThDN7RbfAvukJVv327BFQZ7ct
	QkZUzEfxBmLoMRFmWi9tQNR6svTahuzPBGPpWF/E=
X-Received: by 2002:a05:600c:500d:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-441bbf3b4b3mr97989885e9.29.1746439060708;
        Mon, 05 May 2025 02:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtIwxUjQXL2NSzan5novyjnrfpVxfypUeKQ35LMvAEv1T/4y5tjxEbs+pfQSDQVTpPSGypnw==
X-Received: by 2002:a05:600c:500d:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-441bbf3b4b3mr97989615e9.29.1746439060337;
        Mon, 05 May 2025 02:57:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aed5e8sm172833335e9.16.2025.05.05.02.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:57:39 -0700 (PDT)
Message-ID: <c175eb26-65f7-4936-ae6e-43aedff3f7d5@redhat.com>
Date: Mon, 5 May 2025 11:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/5] mm/readahead: Make space in struct
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
 <20250430145920.3748738-4-ryan.roberts@arm.com>
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
In-Reply-To: <20250430145920.3748738-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 16:59, Ryan Roberts wrote:
> We need to be able to store the preferred folio order associated with a
> readahead request in the struct file_ra_state so that we can more
> accurately increase the order across subsequent readahead requests. But
> struct file_ra_state is per-struct file, so we don't really want to
> increase it's size.
> 
> mmap_miss is currently 32 bits but it is only counted up to 10 *
> MMAP_LOTSAMISS, which is currently defined as 1000. So 16 bits should be
> plenty. Redefine it to unsigned short, making room for order as unsigned
> short in follow up commit.

Makes sense and LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


