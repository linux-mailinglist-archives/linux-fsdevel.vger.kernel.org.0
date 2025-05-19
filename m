Return-Path: <linux-fsdevel+bounces-49399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F98EABBD00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73563AFCDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36559276047;
	Mon, 19 May 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jlo3zky+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9F275840
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655631; cv=none; b=Ejd2dAh1RaC67IUHTha+BWK3X1hKfiOCQtnLYa7JAbkYEFUrbfHm+zV/YdHXh/J81+/JAU+7BeXrIQOlPx+eqEDdyy/6Kfg1RXiC3FYJgER+/afE+QsQ57GazBUOeTF9v2DyT4Wa+dQkP52IViBxjh67BTyfZJOhxW84w6AosbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655631; c=relaxed/simple;
	bh=UC0z14M4STSjgw8GcEFs4HF/aAuH5okce1RST8b+udY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9t5PEZ4xUXH2IfAu6/q/D+mh4rCJxJscnWyiUNBj9Z+fHYl95DCHlnbzvYCqyn/vIPdxgGAjYrhthLiDHp890y46tIzDFZIhvKsHNvcUCWSNRCfwqWYy1bB0uegujjnXL5g0m5FpzT1O4qbM5L/9693AUh+XPwkYP/gRCODrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jlo3zky+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747655628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GPR3VXLvHXW7ydech2OrYgRwl+zj+Xb2j8cG0tq4eIk=;
	b=Jlo3zky+HAdiB993L8N0ikAmV0KjPC5DKghoFIXeI/5mofQ4WHAbomAsJOx9XA6LR1jZVu
	wPPeg48BN1x3mWzKJRZdrdDipy8aSkXw7KD8DW1nzjyu5YQBbJKmIu2iyteMKe7SOct5iF
	4CJbQV0uI/IckEhTy/qiRJlpiZ0Jz5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-hi4Bw-tsP0KEmUV5eLVuzg-1; Mon, 19 May 2025 07:53:47 -0400
X-MC-Unique: hi4Bw-tsP0KEmUV5eLVuzg-1
X-Mimecast-MFC-AGG-ID: hi4Bw-tsP0KEmUV5eLVuzg_1747655626
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so23689775e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 04:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747655626; x=1748260426;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GPR3VXLvHXW7ydech2OrYgRwl+zj+Xb2j8cG0tq4eIk=;
        b=hqmFhUX7xIw8zwC2KbysPKHRv8ubW6jACWkq34BFm+1BTAC0gNwdcu/g0tNgr9TuxX
         GVGw+1k4aFIeOkmP4wCbJInfdEa0RXTXq92YjjAXN7yqscrcwHd5r8F3Y+/OIad5Tcsh
         FKU/7CdD0SZmNQHkDyxwtNcG4xYJu5DdCWeSr/G0VBEGtQTVfHeVcxH5Ms54MUHX41ZB
         8B+UJtoBCq4aoXtY5t85AdTe2mMhY8rRFv6D0UIJ6iFn8hlt+Ax1dJt8Pw4wbjuANczF
         Ra6pfI+GutVtL81TJ8z6ZQqv4e/aHZYgpDjYfzR5GTGZoE7F7wCboGxIrc34CqWrpc5E
         ogiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrJHNhZUCaKJIsXWTYWKPdH/OM0d73TxZdCKiiLcOHH+DhwhxZdk/NED45TxH1VUE2+YNuBXdz6j4/ROo1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oB6lJzVc5FQrkJF/R96WyxXvc4J+SqCEvzIhEZYl10L/rr8G
	N4i52IINs01LoYNcy0UBD6yqLWIFplawgk3jy5S+7IixC5UUelK8m6gDP0T+cWs8QKObaPJoZg7
	ZyZisc24FMxvfmfKlEYtO8nsNAIDVUJuguPu40I49Pce24Px8Phg3Ano3fdS5vWPv1dc=
X-Gm-Gg: ASbGncuzJaxu5+c52ksm/J6jnFOVZiN//J/GjwMO+Es1vHelQD1tjWQDOZ1nUM3mPOY
	C8ahSZclhRjJTYlpCsRwPAmDlSnE5evkal5uDfTv3vZ2hZtYkKrAB9X1KG9na4akI6X9SqoNf8l
	tlH27jXKAhG9Aog20ZXzvD0gvx99N1r4vtBixE1P9HVC3LyGsOJx+sP/rfn8+FjcdBzyOL99/7x
	GHSj8s0jKdqHiGpuSHIizDrrNy90hVMIjrjBJdDLQ5eEC8mAIHX3jYwKoq9KL7dKiwl13afm/tB
	Cd6Rk+a6QxfbvIiHcghp+Nu17ATiJMcQQ4Pv2lAjoYm4kXKKxUxaq2FoLeCB0osZQIZzTdQLSu1
	RyI+YfNewmDNC2DUC+r/18ICqSdbbbKvnBKvdv4A=
X-Received: by 2002:a5d:5885:0:b0:3a3:71c2:f74b with SMTP id ffacd0b85a97d-3a371c2f942mr2035390f8f.31.1747655625982;
        Mon, 19 May 2025 04:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeikYDBgPelSMoJHVDougEefZ8K1XTFemF16mNYYeA/UWZsVraadRQAlJr/ByjfGMl+SaWcg==
X-Received: by 2002:a5d:5885:0:b0:3a3:71c2:f74b with SMTP id ffacd0b85a97d-3a371c2f942mr2035361f8f.31.1747655625595;
        Mon, 19 May 2025 04:53:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm217395445e9.32.2025.05.19.04.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 04:53:45 -0700 (PDT)
Message-ID: <135556a3-9b72-4ec0-acc3-21ee0d15ebe3@redhat.com>
Date: Mon, 19 May 2025 13:53:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: ksm: prevent KSM from entirely breaking VMA
 merging
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
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
In-Reply-To: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 10:51, Lorenzo Stoakes wrote:
> When KSM-by-default is established using prctl(PR_SET_MEMORY_MERGE), this
> defaults all newly mapped VMAs to having VM_MERGEABLE set, and thus makes
> them available to KSM for samepage merging. It also sets VM_MERGEABLE in
> all existing VMAs.
> 
> However this causes an issue upon mapping of new VMAs - the initial flags
> will never have VM_MERGEABLE set when attempting a merge with adjacent VMAs
> (this is set later in the mmap() logic), and adjacent VMAs will ALWAYS have
> VM_MERGEABLE set.

Just to clarify, you mean that VM_MERGEABLE is set later, during 
__mmap_new_vma()->ksm_add_vma()->__ksm_add_vma(), and we are already 
past vma_merge_new_range(), correct?

-- 
Cheers,

David / dhildenb


