Return-Path: <linux-fsdevel+bounces-11466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665F853E20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9301C283C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B584634EB;
	Tue, 13 Feb 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg9iVx++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C60634E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861908; cv=none; b=axl60ZdoCKiG4Hwb0OErlZOPCrww5iuAOAepbIeAyXFFIAraAa97mZfZTR4qn0fImn5AFwhhsXxqeMqhO0vBGj01Fc19At7DicJuL2DLKkbHtd26sqiYsobcUbyhEFe9S7ngAtEzdTPl7lAP/eFHah16HU5pBZonCkkYGwLIfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861908; c=relaxed/simple;
	bh=X3mmjMMPWZvO7ys0UnUVgOwYbLsh+szBz/q2uTvLWY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVmMpvtxl/HxkCz4pmg38zdpFSODxI9luWxzw+jdPRmVNstGbpxYDIBBJEpuehF1kmKHVQNcW38oHcSa5ui2GXemSvKE+pbXvp/HFB3DEpjWMHD2VeiF/DMJ/s2eEU6oS3TUbbd8FDzNlXFrrNMHEgwNp3FErbtUfKDqZiXuX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dg9iVx++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707861904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RgZc24jjJQqeC7+KfoYWO0hi8grRBBzECQH5kw6TD04=;
	b=dg9iVx++2wsDprYX0b4N7846Fz8IlHmCDHDwtTTWHfgYr/+GPbFgdye5F0V1im3W4nkkn0
	4kZyqFflosIN0hvkW4CrITaH0cbV/b1pg99wPP6yhuM/sxNtej0LxUo7XXCZSg2fhERmjN
	JCegUtL+9CAamBrjw3paFpKf0YFfA2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-rS-3_3WCMfqJTp3xCkkb5w-1; Tue, 13 Feb 2024 17:05:03 -0500
X-MC-Unique: rS-3_3WCMfqJTp3xCkkb5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-411e24b69f7so465895e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 14:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861902; x=1708466702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgZc24jjJQqeC7+KfoYWO0hi8grRBBzECQH5kw6TD04=;
        b=j92d/qYgNCuvF2/LboVfuIiEFSCRJAa2ylDzMigm8QH9cScutzC0BuLyL8RjCq87xe
         bnY7RnYI++mcmwkkL2dFm9mqDBB6EhhDavu4KzkxGNl4lB7JR+l6w1URfByCF3INEiPk
         Lk4Qw5i+WL23AcbLUfcAI8M3K2udKmr5d8XW+j5HEJMFRMQOKejPm+5xN+giWFkSM3I+
         DRnQmlaKrGweNjvBPhAclbbho2Iy5l2E67cDjLmjC9RAm3SgiQTIacgk9TVZB8Lw+Ezn
         sZ0MJSE3DzmFofyQ9uSNj6Flo+vwYFo2FlatzL8U4vyLKOwRSknjhKBWpP+80UjcGtyn
         W/pw==
X-Forwarded-Encrypted: i=1; AJvYcCX8MdvtEkAync1/puRl0xlkEMALlkS2150E6pKISkcKh9Mg4jOTH0Dyv6+lGgUBDu2G0Octf8euuqv4SUPAAQ8oRp/1H+Hc0J1nmV5W3A==
X-Gm-Message-State: AOJu0Yyz/U2hoGAxiLV6Lyt4D47p/+WV13q0oi9qD4CekIMe0ZPlLGxn
	NUMNubhcyHILqcazcw9y3+/MLQI90f/t4c3Lj89FxdfFk5kfpA0MEdoxfLfEc3Fb+iCBHlPkgZt
	lxsw7iNZaKQGjh3GRBYs3QZaxsRS9YkFnApZbYztoMJFykezF1b/5GZW4VDH0UNY=
X-Received: by 2002:a05:600c:45ca:b0:40e:bfbf:f368 with SMTP id s10-20020a05600c45ca00b0040ebfbff368mr650500wmo.2.1707861902196;
        Tue, 13 Feb 2024 14:05:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfwGiUw2bYR/LmfQNZuejQn9gXk2z/vWjFO1USlAAPfnN13va/Im5LfF+3hG3wHwAuSolHpw==
X-Received: by 2002:a05:600c:45ca:b0:40e:bfbf:f368 with SMTP id s10-20020a05600c45ca00b0040ebfbff368mr650468wmo.2.1707861901793;
        Tue, 13 Feb 2024 14:05:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id jh2-20020a05600ca08200b00410e6a6403esm17251wmb.34.2024.02.13.14.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:05:01 -0800 (PST)
Message-ID: <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
Date: Tue, 13 Feb 2024 23:04:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.02.24 22:58, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 4:24 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Mon 12-02-24 13:38:46, Suren Baghdasaryan wrote:
>> [...]
>>> We're aiming to get this in the next merge window, for 6.9. The feedback
>>> we've gotten has been that even out of tree this patchset has already
>>> been useful, and there's a significant amount of other work gated on the
>>> code tagging functionality included in this patchset [2].
>>
>> I suspect it will not come as a surprise that I really dislike the
>> implementation proposed here. I will not repeat my arguments, I have
>> done so on several occasions already.
>>
>> Anyway, I didn't go as far as to nak it even though I _strongly_ believe
>> this debugging feature will add a maintenance overhead for a very long
>> time. I can live with all the downsides of the proposed implementation
>> _as long as_ there is a wider agreement from the MM community as this is
>> where the maintenance cost will be payed. So far I have not seen (m)any
>> acks by MM developers so aiming into the next merge window is more than
>> little rushed.
> 
> We tried other previously proposed approaches and all have their
> downsides without making maintenance much easier. Your position is
> understandable and I think it's fair. Let's see if others see more
> benefit than cost here.

Would it make sense to discuss that at LSF/MM once again, especially 
covering why proposed alternatives did not work out? LSF/MM is not "too 
far" away (May).

I recall that the last LSF/MM session on this topic was a bit 
unfortunate (IMHO not as productive as it could have been). Maybe we can 
finally reach a consensus on this.

-- 
Cheers,

David / dhildenb


