Return-Path: <linux-fsdevel+bounces-22555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D32919B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933E6285D06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92681946BF;
	Wed, 26 Jun 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hN41+qFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76F1946AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445727; cv=none; b=cEFraDmeHGmJIWAUfFpZ5Cw/CF7xo/uHVfUiaBRiUnlj5WdeUlG+P1LCAmNspYbvAbaQ12tVrQbpz6qQ8qaBPNbJEv+J/q1Aac8a6r3sQvm7ISu4FL7rc/Z2ec1u7KJuarkm5jJ7C8rLuhfjuLeHgZKzabewaR+0wW3uKCquLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445727; c=relaxed/simple;
	bh=prYxmVaT2pXdyaU+Bub6Dy4ols0oNvlkfqPFHvbTipI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFiLFq4XGiZ66gZUEijEkeGGIPy/mxEyz9gI8bdoWK5eqocQDalYgXuWYPGdM4GlV0AI50l+qm+N1o6tRyznMJayNDuvDW/zR4ouMDzqPSXqRG73CGgV0+9m3J91p1z456fUHFEyi07CXlR3SDu5CPYh1POMF0sQ/M3qtVsPbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hN41+qFK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719445724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7CqT7ZoVZ21vEmREjMyead0YkkLsWeh8E80zva5ToM=;
	b=hN41+qFKp+udGgfRVLy4dEm1PPCVbr9bpJlPalErnHe7hiRlmOyMnWa8BlOh+frZ1n6w6V
	qnLX0Mk0cjHKe9kHjiyVL21LCYdzDf7mY00nqqYMLiArbwzocnVvg1pRBdFgT6R90MC4w5
	VXvI+CQoIQrHkBPz7j55CyRv20I6KlY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-1zizb9J6N-ewbzk3QxWyAQ-1; Wed, 26 Jun 2024 19:48:38 -0400
X-MC-Unique: 1zizb9J6N-ewbzk3QxWyAQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7225d0435a9so2705547a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 16:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445717; x=1720050517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7CqT7ZoVZ21vEmREjMyead0YkkLsWeh8E80zva5ToM=;
        b=l+65d56xo1iCmaSmXbX6E3L+nPaVd0gRwz0GPiyi3BKM9jOpevCROWpcJFvsBsIJ4b
         BpiMJ2TJ98iTSErQzBWiTFetPY83IbGjVnh4s0/mTlL1zuTpf7WY4bHtbT0xKv8kG5Aw
         ypWe8aIygkMj0Rw5izhYZx++ZA76Se0X2vdVcnsl8QDtkzeJ6MKXoQ4Stq36hD0TAiN8
         VtoA81BK57GJbM4MCGvKl3hHoi6mXZTbYfN81hA03wxwNN58UrZixC8tNDGron1qi/pI
         A4TIBn80z066QvkwNHS89kCIsfpDFamGlB4sY4HyPmqqTmsDsBvhWHdXyGW9+0AZX4yW
         6CuA==
X-Forwarded-Encrypted: i=1; AJvYcCWcvl47DaRvskn2R0II67jFQgFquiKmbOOuQKnfwYsWAlFcgCT2gHdZlMH0Vb7xOm+LNEmBgHsEIflvSnIT9zyBJ+kJUd0iidNZbLVymA==
X-Gm-Message-State: AOJu0Yzo7z7uCr3RWfFLSHGL8okc26Bh/7QnRbBONm+Ug0T8zVSaieys
	bfLY25uQjmDfKXWtOvgqN2hit1pERXvGkrWjb1gZXmGOPJOuQR54Zr+Yz7NwJVRL3reVfTq3g8h
	l0G6RgfHq9b26ctxEafLDRtNl4L3kgChHBMPooOWblNMZ1h4QX1WvtpbyPiQNeSE=
X-Received: by 2002:a05:6a20:4c82:b0:1bd:1fb9:37be with SMTP id adf61e73a8af0-1bd1fb94724mr5339539637.34.1719445717481;
        Wed, 26 Jun 2024 16:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4cQmMl+Yz/ePmJozmWEc69fVJbFIuXB/kxX5f4SOa9YmR96mVVLdgm1KF4X5QUEcUDF8Mw==
X-Received: by 2002:a05:6a20:4c82:b0:1bd:1fb9:37be with SMTP id adf61e73a8af0-1bd1fb94724mr5339527637.34.1719445717109;
        Wed, 26 Jun 2024 16:48:37 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8060f14sm2269364a91.29.2024.06.26.16.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:48:36 -0700 (PDT)
Message-ID: <471488ec-ea1f-4c57-ad0d-bea422863574@redhat.com>
Date: Thu, 27 Jun 2024 09:48:30 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, hughd@google.com, torvalds@linux-foundation.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
 <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
 <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
 <ZnyAD24AQFzlKAhD@casper.infradead.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZnyAD24AQFzlKAhD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 6:54 AM, Matthew Wilcox wrote:
> On Wed, Jun 26, 2024 at 10:37:00AM +1000, Gavin Shan wrote:
>> On 6/26/24 5:05 AM, David Hildenbrand wrote:
>>> On 25.06.24 20:58, Andrew Morton wrote:
>>>> On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>>> I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
>>>>>> problem with this approach is that we're putting a basically untested
>>>>>> combination into -stable: 1&2 might have bugs which were accidentally
>>>>>> fixed in 3&4.  A way to avoid this is to add cc:stable to all four
>>>>>> patches.
>>>>>>
>>>>>> What are your thoughts on this matter?
>>>>>
>>>>> Especially 4 should also be CC stable, so likely we should just do it
>>>>> for all of them.
>>>>
>>>> Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
>>>> asking for those to be backported further than 1 & 2, which seems
>>>> wrong.
>>>
>>> 4 is shmem fix, which likely dates back a bit longer.
>>>
>>>>
>>>> Then again, by having different Fixes: in the various patches we're
>>>> suggesting that people split the patch series apart as they slot things
>>>> into the indicated places.  In other words, it's not a patch series at
>>>> all - it's a sprinkle of independent fixes.  Are we OK thinking of it
>>>> in that fashion?
>>>
>>> The common themes is "pagecache cannot handle > order-11", #1-3 tackle "ordinary" file THP, #4 tackles shmem THP.
>>>
>>> So I'm not sure we should be splitting it apart. It's just that shmem THP arrived before file THP :)
>>>
>>
>> I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
>> Please let me know if you have a better one for PATCH[4].
>>
>> #4
>>    Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>    Cc: stable@kernel.org # v4.10+
>>    Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
>>    Cc: stable@kernel.org # v4.20+
>> #3
>>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>    Cc: stable@kernel.org # v5.18+
>> #2
>>    Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>>    Cc: stable@kernel.org # v5.18+
>> #1
>>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>    Cc: stable@kernel.org # v5.18+
> 
> I actually think it's this:
> 
> commit 6b24ca4a1a8d
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Sat Jun 27 22:19:08 2020 -0400
> 
>      mm: Use multi-index entries in the page cache
> 
>      We currently store large folios as 2^N consecutive entries.  While this
>      consumes rather more memory than necessary, it also turns out to be buggy.
>      A writeback operation which starts within a tail page of a dirty folio will
>      not write back the folio as the xarray's dirty bit is only set on the
>      head index.  With multi-index entries, the dirty bit will be found no
>      matter where in the folio the operation starts.
> 
>      This does end up simplifying the page cache slightly, although not as
>      much as I had hoped.
> 
>      Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>      Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> 
> Before this, we could split an arbitrary size folio to order 0.  After
> it, we're limited to whatever the xarray allows us to split.
> 

Thanks, PATCH[4]'s fix tag will point to 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache"),
which was merged to v5.17. The fix tags for other patches are correct

Thanks,
Gavin


