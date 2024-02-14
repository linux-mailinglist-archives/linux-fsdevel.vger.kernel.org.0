Return-Path: <linux-fsdevel+bounces-11537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB4854798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EED289E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06118E14;
	Wed, 14 Feb 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0m+pqII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266B18B02
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908123; cv=none; b=pZtnXXAhf85U/lMZPTClMeUon2nDVSjMxh1qQOoodHjEhmVkkT4vIdbxoAOX7R0V5xjTEa9lOzQbAJuoPrB7mBJGypVgJin5BYJpu/umFpIcWSiqvl8Qq5UpsRkU8boFRNGkF0hlqMeD7dwOOMEwMrHXi1cDN0O0Wl19OqfdOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908123; c=relaxed/simple;
	bh=SQvAiJwsbkRskNIjC2WkhKsfQA6FMsn5qKhNC19CoQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbSvCuILvScErilCilpcKDM9gks3wspkcT42DbqNvFN0xz/qLPNhTDXy9TaFtJRcBR5GSSO8ONqgKf22oFkiWqTbbY4NrPKylwh1mT2X+4HHPGYVshcTpyfVgTxXeFpMJTdspQ/RBJE2hoNMbK49/RGO3SreDfyKGzc8nqkmXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0m+pqII; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707908120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FkG4rFYSar/COgr1ANQgOL3qRnWrGDmTgIrKAH1p2yk=;
	b=e0m+pqIINhyQ7RiH60+7ZzRGrAfgF5FftOpjV4QHFqzVJX7I7x1CoC7OkKT8v8tB0yr8UT
	N7SitwSrHvPHEmXRcFVm06DW+5pYAAh+oHQF00YXN8gwVGhV0e31JOy3W/xl74MWkptW2o
	S4KBC9jeuEGpclBAT7Xguo97kq/VXsg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-I1g3zR4pOYC1LEq5nlk8ww-1; Wed, 14 Feb 2024 05:55:18 -0500
X-MC-Unique: I1g3zR4pOYC1LEq5nlk8ww-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cf40f4c08so12447f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 02:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707908117; x=1708512917;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkG4rFYSar/COgr1ANQgOL3qRnWrGDmTgIrKAH1p2yk=;
        b=LfdE6L/jfm2RvTf5+NaAE0sg64an+Efu4bHZLLmnq8UHn/DpwKXg/sNO3cNSXhEGvt
         Bf0rFTLzmmcNF1O0hsfZGlCYOIAKfaGE2RaNR69IRs5s6I5k1x+O8jk9TDQ3E7LoMSpf
         Sn2SQXiJYM1TpYJJ3HNI3twscl0HQCnrcwKCDw5adjdNeDlAG11POAmNbnvdFheb91Pl
         IluqvGjxozWO8yXOz59aAp9LpcNhiJWuUGBA+TUf85XG0XTXnhVWsLCOrQlE7StHIm3Q
         NFQ3wBVqv20+OXtqhSFTfM9Yi/isekwrFs9AQ/22LnUTRhqPX9TBdMgaEWXgGhnJnvn/
         kXaA==
X-Forwarded-Encrypted: i=1; AJvYcCW3A7rXl9VOtfYD0p6DAmHbdadzN0ka/k0lqOH1pWbKfCj8ARc1hV8g6/KtsJDky8fxKhSc4Sx05Vbz23g9N9FrWL1dVmsmCFY/xDyOQg==
X-Gm-Message-State: AOJu0YxrDKpOjQUqXv/U5KetBnGK/s4nlTdLWLKCoRaO8sEpPyCXFYvY
	EjfvvJ0udVAV3eTxEhkZjNkji432+7FmNpKV3H9QyLBAhiZ9rhHWAT18cRJGvMW7Ws6cck1VNdU
	Xq3YjkixWnJw8vIh+Z5ALdyXDBlAdIivsvcZUjSxM03dK9KG47KqkyQb4g3UmHg8=
X-Received: by 2002:adf:ce03:0:b0:33c:e339:23e4 with SMTP id p3-20020adfce03000000b0033ce33923e4mr1686963wrn.62.1707908117486;
        Wed, 14 Feb 2024 02:55:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXEpBq8Q8ZnFUw1naCQqfidxYnDmHpx6kSBfapsNJ6KX7OVMNFoSQImIEewE+QUkL0vkf4Pw==
X-Received: by 2002:adf:ce03:0:b0:33c:e339:23e4 with SMTP id p3-20020adfce03000000b0033ce33923e4mr1686932wrn.62.1707908117063;
        Wed, 14 Feb 2024 02:55:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXp1v9NVJsals5Gj2CSvlzzxVVSJcTBmCSHUiUmrRTKzI5WP59WpjFLd3TWoWkVgs5iv/D4Spi4dWnY4NatoHVyfqqHz3CfPAGVDmI8/1vFuIDz++uFYIdcAO8WaGQCOXLQ0f6P8g1YagKdRvMuxgdytQ/iwe5D37XAGdDkPFdztU8YC0pkxYSZjX9GEvlququsj7jNyn8hhfvwpNPwCuj6EJ9Qm0Y2TMbQdIYMavsiT0s5QU0Gmm5kfgqxcV9bdN4+Zwlp9b3ryg5p9BQfhco9msJbBO2Cf41vsT9j6KvbBkTr5HqsftUr+F4lQFOk9qr1yd7Im0MeRP09Vt0/OKIMnlOqpbEfCQRq5KDtDAK5vaMAIZ380HJC8suqeAI3M3pPsKYUMePUgvLHcjRy3+zi4vOLjhP6YN2HoAZi100NCA34W3T019QKaeuw+qUxhXZTXHncVnNhHuC2L7I4XfbziwKhxSESSFVs7GaNV8vjoUZXYFTUl2Sd2s7fHBdCr175mI7fqy5Q8v/MM56PF0XpppomxJmdu5b8+bAps603502iUJhhw1E=
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d404d000000b0033b4dae972asm11995459wrp.37.2024.02.14.02.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:55:16 -0800 (PST)
Message-ID: <46f61262-e197-456c-97f1-d464ad5688c1@redhat.com>
Date: Wed, 14 Feb 2024 11:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <659e1abb-40d0-42ba-ba0a-8256d7eb1c5a@redhat.com>
 <F4470D3A-DC2C-4A6A-B65C-1C94D732A60E@nvidia.com>
 <66d4b27f-85e4-458e-8d66-54f800c5c65f@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66d4b27f-85e4-458e-8d66-54f800c5c65f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.24 11:50, Ryan Roberts wrote:
> On 13/02/2024 22:31, Zi Yan wrote:
>> On 13 Feb 2024, at 17:21, David Hildenbrand wrote:
>>
>>> On 13.02.24 22:55, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Hi all,
>>>>
>>>> File folio supports any order and multi-size THP is upstreamed[1], so both
>>>> file and anonymous folios can be >0 order. Currently, split_huge_page()
>>>> only splits a huge page to order-0 pages, but splitting to orders higher than
>>>> 0 is going to better utilize large folios. In addition, Large Block
>>>> Sizes in XFS support would benefit from it[2]. This patchset adds support for
>>>> splitting a large folio to any lower order folios and uses it during file
>>>> folio truncate operations.
>>>>
>>>> For Patch 6, Hugh did not like my approach to minimize the number of
>>>> folios for truncate[3]. I would like to get more feedback, especially
>>>> from FS people, on it to decide whether to keep it or not.
>>>
>>> I'm curious, would it make sense to exclude the "more" controversial parts (i.e., patch #6) for now, and focus on the XFS use case only?
>>
>> Sure. Patch 6 was there to make use of split_huge_page_to_list_to_order().
>> Now we have multi-size THP and XFS use cases, it can be dropped.
> 
> What are your plans for how to determine when to split THP and to what order? I
> don't see anything in this series that would split anon THP to non-zero order?
> 
> We have talked about using hints from user space in the past (e.g.  mremap,
> munmap, madvise, etc). But chrome has a use case where it temporarily mprotects
> a single (4K) page as part of garbage collection (IIRC). If you eagerly split on
> that hint, you will have lost the benefits of the large folio when it later
> mprotects back to the original setting.

Not only that, splitting will make some of these operations more 
expensive, possibly with no actual benefit.

> 
> I guess David will suggest this would be a good use case for the khugepaged-lite
> machanism we have been talking about. I dunno - it seems wasteful to split then
> collapse again.

I agree. mprotect() and even madvise(), ... might not be good candidates 
for splitting. mremap() likely is, if the folio is mapped exclusively. 
MADV_DONTNEED/munmap()/mlock() might be good candidates (again, if 
mapped exclusively). This will need a lot of thought I'm afraid (as you 
say, deferred splitting is another example).

-- 
Cheers,

David / dhildenb


