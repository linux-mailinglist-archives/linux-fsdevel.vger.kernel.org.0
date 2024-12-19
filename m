Return-Path: <linux-fsdevel+bounces-37803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFD9F7E3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FCF188B891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D815442C;
	Thu, 19 Dec 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf38usvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FD2AD16
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622797; cv=none; b=nnfOWweFW+h5jz58u9nT1JRGGfWy+EUS0ZvtAk0DhLtJgE5CxFv4UdcvRePCzjKNlNC6Kvop8OJzhD4x7nN+C3rwgnj2+5tlrkVzdPG9SS+IDlv2qpLL5OauL4MdroXuYmvy9sPSd4VmEzWFmZ+BBjaOxWnVbIsvzLCM++kAHlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622797; c=relaxed/simple;
	bh=DMDG4YQhyZzna8NYV94lN8StMD07MNUDAhYg0lXu6Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbcRlLCkeCb1t46xWyfAtovtUIkXl2OYiOgSoGx3J/RCNzTjaaKsqCqx8c9FRSLJaFXvCtWvwSy0sEPZY0mK+hvZnx5qDzuHyyZzW7n0ZsNzozKQoVJowfAXp9IZPUJUEdYKihQX9cBgRbXewvRp6vi+o0Ov404f6oRmSMB6mA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tf38usvd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734622794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xFOLa2I9/dISQC7RvibnzBJmDjVm3oc5kkVHh7Ml3Q=;
	b=Tf38usvdsLnKUyENPp5kJmM5HJgrsXl/ZXaDbm+9n3hBNM+WpFh2u4qShbjzzUITT23JeX
	POHjr5h5W8oUbfEwp0rxXxeCRJZrITCVY38J0Q/wec6nFuypcBTDf1du277jNQSeOfxEHc
	kS7L1OrmdM/JLsUJapmVolaGNo62ODY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-6cvf6ngBO0SPs2pwrcrn5w-1; Thu, 19 Dec 2024 10:39:53 -0500
X-MC-Unique: 6cvf6ngBO0SPs2pwrcrn5w-1
X-Mimecast-MFC-AGG-ID: 6cvf6ngBO0SPs2pwrcrn5w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436219070b4so5500395e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 07:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622792; x=1735227592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xFOLa2I9/dISQC7RvibnzBJmDjVm3oc5kkVHh7Ml3Q=;
        b=YArMZDfboFF1CEJvqnJfU7fdGcQHZKqmOqeQwb9wxhJ0U6fjFA138NIkKDRD4UIzZ+
         KWfJpDUWMPR5uK1VTwkxiCT2RX+MBt7bDHZQlZU9pJGNdnQdICcAwyoTm3+Cek+jeKvl
         SxeOFF+TIUrrvWALd1+NX4XC0K17W2EP03nYMVMCAp9BRy58xv6IXlw8ttXG6QB/uJWU
         Slbrp1el5cpTmjG1vj7X466vpxzR5HOYUxhg8QArI98cwiEk6i7JLo63zChNwD9GUc/I
         zD3whMr/1Uz36fPVeG59YgEkOhCW8Gv75PoMOGbjIASf1CQXJaEfiIxYM+AioEw74rwP
         J+yg==
X-Forwarded-Encrypted: i=1; AJvYcCX+xL74KxX/tIodZsLikx7jgcC77XGDY6X6wmM/fFm27bA7QtTh5ifsHmNeYHckoahD3v25HlN5SlPwbr1x@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+mK1vIl27AH6FhJRwfbK+TMv1IQbRDVezQCu0sozjR7WXyd6
	73ovxhGXau/BtKTl8vF9a9d3sk7/KELDYz65jFYNmnkazh6p8gHHu/3VSmk+iDI6b+8tZcDph8Y
	TrGaIgqxrLAyusVglMrb6LB36kROlAJqn4TvX3kP75pVWtMmylO0QW9kzUwPEUpQ=
X-Gm-Gg: ASbGncsioxfuN8TQGSevrey9tD1sNTpjNSjY9nMgxY/80N4jQmE0Z7yenPvwyfoEtK5
	O2eeP+zvYYXbptwcS96kH3UQrPUBWoL4AnzpA3Y9i6NJTnFn82ga9GVT8vp1ciTPmjoIUSyfheZ
	zUZldVStw2n46uSYxmtpzFiRqRqzg6xViaWUFRywwihTsiDm+I3on+QsH1FXO4M1sniSHL6qoer
	JpbLZEoNQvFnklpsx146GHqCqSIXIWd+wmwj/DZ0WAvMMmhs7NQzktx2ujM6zUn+s04D3lLFmtp
	T9Gkty9au+Toc3YP7VUUuZ5j2/QOYmhmdX3PC0wvQcPNMmJcX7mBfhgJ8ZhLXoXCQ87gitsXV9H
	2LI+OUw==
X-Received: by 2002:a05:6000:4711:b0:385:f821:e97e with SMTP id ffacd0b85a97d-388e4d6c078mr6817833f8f.9.1734622792168;
        Thu, 19 Dec 2024 07:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH8/knWNosjFEO3inUxNRRAwQar+XrXifwWYmlpetEZNRd+J4z+R8imoH+Hw/6QdIswwfYhw==
X-Received: by 2002:a05:6000:4711:b0:385:f821:e97e with SMTP id ffacd0b85a97d-388e4d6c078mr6817813f8f.9.1734622791797;
        Thu, 19 Dec 2024 07:39:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm1833107f8f.71.2024.12.19.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:39:51 -0800 (PST)
Message-ID: <b3df8b0a-fa19-425a-b703-cbe70b6abeda@redhat.com>
Date: Thu, 19 Dec 2024 16:39:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
 <90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 16:08, Zi Yan wrote:
> On 19 Dec 2024, at 9:19, Zi Yan wrote:
> 
>> On 19 Dec 2024, at 8:05, David Hildenbrand wrote:
>>
>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>> writeback may take an indeterminate amount of time to complete, and
>>>> waits may get stuck.
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> ---
>>>>    mm/migrate.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index df91248755e4..fe73284e5246 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>    		 */
>>>>    		switch (mode) {
>>>>    		case MIGRATE_SYNC:
>>>> -			break;
>>>> +			if (!src->mapping ||
>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>> +				break;
>>>> +			fallthrough;
>>>>    		default:
>>>>    			rc = -EBUSY;
>>>>    			goto out;
>>>
>>> Ehm, doesn't this mean that any fuse user can essentially completely block CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>
>>> That sounds very bad.
>>
>> Yeah, these writeback folios become unmovable. It makes memory fragmentation
>> unrecoverable. I do not know why AS_WRITEBACK_INDETERMINATE is allowed, since
>> it is essentially a forever pin to writeback folios. Why not introduce a
>> retry and timeout mechanism instead of waiting for the writeback forever?
> 
> If there is no way around such indeterminate writebacks, to avoid fragment memory,
> these to-be-written-back folios should be migrated to a physically contiguous region. Either you have a preallocated region or get free pages from MIGRATE_UNMOVABLE.

But at what point?

We surely don't want to make fuse consume only effectively-unmovable memory.

-- 
Cheers,

David / dhildenb


