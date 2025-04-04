Return-Path: <linux-fsdevel+bounces-45793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52581A7C4D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DD33AAE99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CF21507F;
	Fri,  4 Apr 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDE+X5yF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA32E62C1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797644; cv=none; b=rTfdLtwNqFalsa9LDO9t/VELs8sLnF7mPczcNYrj6C2ul/9gDAjZwAnIyYiPzmuiR5TYLC0RY0th05szcdGh1lyMHWIy/833/qcGKsHMJgEhFf5Bo9VrW5u5OheyPSZ1C3vJzciwv75QbLv/oP1p/yDo/G0219+Op2kku46JBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797644; c=relaxed/simple;
	bh=d7C31jIr0Vy3Qc6+zbVDiZ0ica9jjoasEjO5ug7E7k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt9xiq3lpNvvU0B7Z325pQ0+03NJRWOsMCj/OMInxU3nOXPnVmljwhlucZ5t+MbhTpk22TOZTMyzLrgzKHbDxB3s2XzUJYHoya9ynURZ1Rsv74cXPyxutPq0zzz61sgHm8H6Qh7+boTy5hJEp3E1aAKlcC7L6FBAXGgNdxrQKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDE+X5yF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743797641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FisPwyueA7XGszoCP0mAeHcFBiQ8N8+uB0XVQOZcY9Y=;
	b=bDE+X5yFbsxRcXM6fxdkRlp6H5nJ8H9eF9c3dsQ9GFombYrt7zEbVErbjqXIrGNvQl7NQ+
	4aREsLdki2BS8eNkb5/4bT/OHNK57xdcW5mcSInJpwz3isTyJBUVJueG0iZQBDeoLKNTy8
	duqF6fQnejwg2PxLripvYp5BBBiGGoA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9vkduF5dNTmC76_V4ltlGA-1; Fri, 04 Apr 2025 16:13:59 -0400
X-MC-Unique: 9vkduF5dNTmC76_V4ltlGA-1
X-Mimecast-MFC-AGG-ID: 9vkduF5dNTmC76_V4ltlGA_1743797638
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso17817205e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797638; x=1744402438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FisPwyueA7XGszoCP0mAeHcFBiQ8N8+uB0XVQOZcY9Y=;
        b=DmQSdH1NzgW/sfHDjUX2m7Ywfy1u8YdSvrYM50RHU//Pjfn5QBI8B/ElyM/C8S9n0J
         pyI2QXyZvTQU/YH3SFaeiovdCgkEipR6Zb8U1FlOzD5hA6EhJe1dfNL/L/jR/aPMTxOq
         J3NFwlUVzguU1sRIbc4xwMUm7xJsckmeY7zTW39HQv8fdNDBl+v8alJ1Mv+ztsv6bDec
         GZlPy24z4C5aycWfDRZZ0CHizvs07FhlH2X8pCKgtlt2huAHrZx2c3BLCvSOJrdaef29
         eiqcEtzsLMFwprUxMpzS0tAK7adq073C0RfaOAoGwelaqZRpw+31vw2Gd3m9oZ3dLZAd
         R/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0xuMHMXN43c8sQy4WJRfXdN4+8CI89OVszYIEf6PNldI/00S/8P1bYL+qxBBPahrRzn7fReZW1XYrNJE@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXHSuJ8ZpX41nCNffmC1sg94CrQ1EAE0lpOxhXpmGj/Du/ajk
	gIfv9bpWnllfGBIVF32XdxmIoqQchCE2V9t83BSjapg9MaVJpcgUpRzcDRaj1Sg8XuD1tloE/tf
	2K/qEaNoEm2jDzMV1q5kJZFfSFs2lTdO4REwvK+WKVlUhZVS2Q+XctX7nw6qsWJ4=
X-Gm-Gg: ASbGnctu+ZZgkrqrLZ7E1tpyuRRO6NSU87bs+4eq1IKCzWBNmu9+AT0Ypevu/XkbpTr
	QZoNnT8VwzXUY28Gvh4Uxpqh5TfffMpkfTPrjlq74CivDOfLaF9wqDVXP57pDHHv/RWQMSvz2dS
	/2YAnfmNZNxPQPKJWRRdLlLqQJ5XuYySufbwJ+tLvUm6rG5AwdGNdvu5zXIJyCUvdagXUjr2hic
	f/sPHz87W231oxABW8P1jWyf6N6ImMSNaJzEOSwl90JY5b2lkCwm+/1dd/plQdHiK4X/r18SS2t
	PFd6/B90ZuT+lIaKt2xU8Lt53HzNto1tFJGDYi7e0kNiyIvqNvbXks3ISicOG5hOpz+G16tFCQd
	MCMxTMD4NTS2sm41lENb2dQ2k8jY1FyhE0BqXZ6ajmwY=
X-Received: by 2002:a05:6000:4310:b0:39c:dfa:c3de with SMTP id ffacd0b85a97d-39d6fce132amr474092f8f.47.1743797638165;
        Fri, 04 Apr 2025 13:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPK5fbdI7e4kCf9Cm+KWRnOOpNB+E+ilghSmDiX9zIVWIn+r1waxKZPnKpZn1mJHx6EbdUMQ==
X-Received: by 2002:a05:6000:4310:b0:39c:dfa:c3de with SMTP id ffacd0b85a97d-39d6fce132amr474077f8f.47.1743797637766;
        Fri, 04 Apr 2025 13:13:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bb7bfsm53378735e9.17.2025.04.04.13.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:13:56 -0700 (PDT)
Message-ID: <221860f0-092c-47f1-a6f8-ebbe96429b1a@redhat.com>
Date: Fri, 4 Apr 2025 22:13:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm: add AS_WRITEBACK_INDETERMINATE mapping flag
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 jefflexu@linux.alibaba.com, shakeel.butt@linux.dev,
 bernd.schubert@fastmail.fm, ziy@nvidia.com, jlayton@kernel.org,
 kernel-team@meta.com, Miklos Szeredi <mszeredi@redhat.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-2-joannelkoong@gmail.com>
 <0462bb5b-c728-4aef-baaf-a9da7398479f@redhat.com>
 <CAJnrk1Z2S9K1AsNnYHBOD_kGsOmYuJGyARimtc_4VUgUWDPigQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1Z2S9K1AsNnYHBOD_kGsOmYuJGyARimtc_4VUgUWDPigQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.04.25 22:09, Joanne Koong wrote:
> On Fri, Apr 4, 2025 at 12:13 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.04.25 20:14, Joanne Koong wrote:
>>> Add a new mapping flag AS_WRITEBACK_INDETERMINATE which filesystems may
>>> set to indicate that writing back to disk may take an indeterminate
>>> amount of time to complete. Extra caution should be taken when waiting
>>> on writeback for folios belonging to mappings where this flag is set.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
>>> ---
>>>    include/linux/pagemap.h | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>>> index 26baa78f1ca7..762575f1d195 100644
>>> --- a/include/linux/pagemap.h
>>> +++ b/include/linux/pagemap.h
>>> @@ -210,6 +210,7 @@ enum mapping_flags {
>>>        AS_STABLE_WRITES = 7,   /* must wait for writeback before modifying
>>>                                   folio contents */
>>>        AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */
>>> +     AS_WRITEBACK_INDETERMINATE = 9, /* Use caution when waiting on writeback */
>>>        /* Bits 16-25 are used for FOLIO_ORDER */
>>>        AS_FOLIO_ORDER_BITS = 5,
>>>        AS_FOLIO_ORDER_MIN = 16,
>>> @@ -335,6 +336,16 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
>>>        return test_bit(AS_INACCESSIBLE, &mapping->flags);
>>>    }
>>>
>>> +static inline void mapping_set_writeback_indeterminate(struct address_space *mapping)
>>> +{
>>> +     set_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
>>> +}
>>> +
>>> +static inline bool mapping_writeback_indeterminate(struct address_space *mapping)
>>> +{
>>> +     return test_bit(AS_WRITEBACK_INDETERMINATE, &mapping->flags);
>>> +}
>>> +
>>>    static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>>>    {
>>>        return mapping->gfp_mask;
>>
>> Staring at this again reminds me of my comment in [1]
>>
>> "
>> b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
>>        that very deadlock problem.
>> "
>>
>> In the context here now, where we really only focus on the reclaim
>> deadlock that can happen for trusted FUSE servers during reclaim, would
>> it make sense to call it now something like that?
> 
> Happy to make this change. My thinking was that
> 'AS_WRITEBACK_INDETERMINATE' could be reused in the future for stuff
> besides reclaim, but we can cross that bridge if that ends up being
> the case. 

Yes, but I'm afraid one we start using it in other context we're 
reaching the point where we are trying to deal with untrusted user space 
and the page lock would already be a similar problem.

Happy to be wrong on this one.

Wait for other opinions first. Apart from that, no objection from my side.

-- 
Cheers,

David / dhildenb


