Return-Path: <linux-fsdevel+bounces-64959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B793BF7750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96161485B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32864239E97;
	Tue, 21 Oct 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0kTBVo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02154224B04
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061455; cv=none; b=fAPtA/5dAL4VgJVSA7KFXWTYBC5CytK6dEke+hr6RIfdNuUe2s16pKB9hsqppmTo2/lu3jUmCjuSW2rHovOHfb/T3eLWCylABKqHdg+R0nPXxHJbiscyyvWH/k757SyVuvGVD09xs1+E7/n/3D5XeAdf+ojNO/X3XBNqSR+7Jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061455; c=relaxed/simple;
	bh=A0TD5KKg3rvP50d4iN5qQNwBdRMTrU7Zn351z7no/Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBOTFjxUGk8epfFwsDu+yMMO5IjYKbXwD9AhxHxky4mF4Bf+1XIFpQ/RA5SqEq4jb1dzVP1x3ORjAA1cTQ7GaVE7t4WZhSVscEjXYVH8s6XzbimOLdVUSYv+ZblC9zijzey30f0/IWm4bNWi82LDqLpVFZFOBRt7Eb3FuDPlfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0kTBVo8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=83AP2pcUZVkXSATkF5eTHL6M4I08IXBIdo5h/3fKK+w=;
	b=G0kTBVo8sCmD9vgWSJz5RC0AZyT4WmcS8KDL1YZcNVLy1jVei6ZUtdlRthA1H/VeuAKceg
	OH6RPoTcfxRfOO1N4PwKJw5pRpgpnlErbvy2/tt7mUuCP0Aa5nsaa67sPXd9mNeXyPBmW4
	ThyhGyBfkIkQpB2rP6qZqOCFou3ZN3Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ZQV3YfWyNqOiDtzz7t_aeA-1; Tue, 21 Oct 2025 11:44:11 -0400
X-MC-Unique: ZQV3YfWyNqOiDtzz7t_aeA-1
X-Mimecast-MFC-AGG-ID: ZQV3YfWyNqOiDtzz7t_aeA_1761061451
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e39567579so34567155e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061450; x=1761666250;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83AP2pcUZVkXSATkF5eTHL6M4I08IXBIdo5h/3fKK+w=;
        b=gybkKC3RBgm+vaZffCcEq3cNayi33ZYMig36BJSleHDQLD/AHWdz0n2lGhjRPrDAnL
         qOaS5PSgqGIGzyw/oGpEiYlsgxDxnnT6HROZjMWH5wF9zHjyuNs1R5ZZm9mnDzR+laA4
         ra4VjhDpLz0IjWUcjB6ToPqagNGihaDu/qFkiTMFzOzCZL1uVLHus4ntxEMX73QsAuV8
         xcSVBAjQtWfeI9pIshK3TCgB8KMeQVJByybvHQeYO6Nv/bcsPJGsY+sdx183VVrtGwZn
         C0q5Rlye1yjJQsK7bCGnvRU2or3aoo3cT42kdPU19+R2YgU1Fvt6ansGgvYwlP8a72DX
         RH1A==
X-Forwarded-Encrypted: i=1; AJvYcCWzqoovyW2ucBj0vL9x810bxvMorQzZEa5wOBPvNyZQwJ+BAtS0Gm4kL8IeyKoK7E6gZzarHaBIAAEVf0Gu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+ZANaGaQsFUT7DDeDZUJMDxZTRafgsiMrdMT4vNWB/DO4b/8
	u7rEff9ZVxLSeG09r3Xf600G76rXgal8Y7/RMEeVBT0xDuQly0/dSz0ItNjuktQ0yqJQ29Ewy+G
	NjeN8772WGuO7o7GqrTaLGVhSVsMP3OX9V8KBLe9qD/CUr5CD3pAfXSmD9etGJGHasAA=
X-Gm-Gg: ASbGnctjFrq/BNwo3kHvKkEim7CvvX8UYzDULUSYK309QqDy+2xbRmwCZKWyXDiRLcs
	tvBcRW2AS3ERs1K9TWGegbnQmopn7qqPJ2gWqBKRl2nkRILELzF/3BF/ihK3t5UKAPgs2QQLf3D
	YfxaPPSwtRAZxo61AIbOehFUdar2zpY8V55fdZ+VX7MetTUidzLbX9+QsBaEhdWcTwQMf9XAPFw
	Gwxc+65xsQ2x+/tBJRrRbof4pirzzQDeenLP+RTMIR4rKHHb75gLuauiY/a9X1m1DCrbuYFVNoh
	wW5UNNROIJE+W+iYoAwLJdMwFyw5s+3khNjZXNIphvQ1xyXEZGDkyhBKqEgjIc/Wb9ftNfQUmC2
	GqZe52UWGmG7IfKXG4jhTCYpQHqg35DCxrKgVciaKlBe1zdkK5258f4Cg6ySpTpKyfyTB3CGh7H
	ubS3mCdyVCd+xBz0rxD+8KX4+Yb4s=
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr130856505e9.15.1761061450436;
        Tue, 21 Oct 2025 08:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaIH2bO/ck6gwXdnqS8Ypxq8Yv23OSCidYjsq98DaSka5gGo9ipZvZfYK6JfQASLqPXM6hqA==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47117877525mr130856175e9.15.1761061449963;
        Tue, 21 Oct 2025 08:44:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm289821585e9.1.2025.10.21.08.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:44:09 -0700 (PDT)
Message-ID: <b353587b-ef50-41ab-8dd2-93330098053e@redhat.com>
Date: Tue, 21 Oct 2025 17:44:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
To: Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
 <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
 <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.10.25 03:23, Zi Yan wrote:
> On 20 Oct 2025, at 19:41, Yang Shi wrote:
> 
>> On Mon, Oct 20, 2025 at 12:46 PM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> On 17 Oct 2025, at 15:11, Yang Shi wrote:
>>>
>>>> On Wed, Oct 15, 2025 at 8:38 PM Zi Yan <ziy@nvidia.com> wrote:
>>>>>
>>>>> Large block size (LBS) folios cannot be split to order-0 folios but
>>>>> min_order_for_folio(). Current split fails directly, but that is not
>>>>> optimal. Split the folio to min_order_for_folio(), so that, after split,
>>>>> only the folio containing the poisoned page becomes unusable instead.
>>>>>
>>>>> For soft offline, do not split the large folio if it cannot be split to
>>>>> order-0. Since the folio is still accessible from userspace and premature
>>>>> split might lead to potential performance loss.
>>>>>
>>>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>> ---
>>>>>   mm/memory-failure.c | 25 +++++++++++++++++++++----
>>>>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index f698df156bf8..443df9581c24 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>>>>    * there is still more to do, hence the page refcount we took earlier
>>>>>    * is still needed.
>>>>>    */
>>>>> -static int try_to_split_thp_page(struct page *page, bool release)
>>>>> +static int try_to_split_thp_page(struct page *page, unsigned int new_order,
>>>>> +               bool release)
>>>>>   {
>>>>>          int ret;
>>>>>
>>>>>          lock_page(page);
>>>>> -       ret = split_huge_page(page);
>>>>> +       ret = split_huge_page_to_list_to_order(page, NULL, new_order);
>>>>>          unlock_page(page);
>>>>>
>>>>>          if (ret && release)
>>>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>          folio_unlock(folio);
>>>>>
>>>>>          if (folio_test_large(folio)) {
>>>>> +               int new_order = min_order_for_split(folio);
>>>>>                  /*
>>>>>                   * The flag must be set after the refcount is bumped
>>>>>                   * otherwise it may race with THP split.
>>>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>                   * page is a valid handlable page.
>>>>>                   */
>>>>>                  folio_set_has_hwpoisoned(folio);
>>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>>> +               /*
>>>>> +                * If the folio cannot be split to order-0, kill the process,
>>>>> +                * but split the folio anyway to minimize the amount of unusable
>>>>> +                * pages.
>>>>> +                */
>>>>> +               if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>>>
>>>> folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
>>>> to order-0 folios because the PG_hwpoisoned flag is set on the
>>>> poisoned page. But if you split the folio to some smaller order large
>>>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
>>>> poisoned folio.
>>>
>>> OK, this means all pages in a folio with folio_test_has_hwpoisoned() should be
>>> checked to be able to set after-split folio's flag properly. Current folio
>>> split code does not do that. I am thinking about whether that causes any
>>> issue. Probably not, because:
>>>
>>> 1. before Patch 1 is applied, large after-split folios are already causing
>>> a warning in memory_failure(). That kinda masks this issue.
>>> 2. after Patch 1 is applied, no large after-split folios will appear,
>>> since the split will fail.
>>
>> I'm a little bit confused. Didn't this patch split large folio to
>> new-order-large-folio (new order is min order)? So this patch had
>> code:
>> if (try_to_split_thp_page(p, new_order, false) || new_order) {
> 
> Yes, but this is Patch 2 in this series. Patch 1 is
> "mm/huge_memory: do not change split_huge_page*() target order silently."
> and sent separately as a hotfix[1].

I'm confused now as well. I'd like to review, will there be a v3 that 
only contains patch #2+#3?

Thanks!

-- 
Cheers

David / dhildenb


