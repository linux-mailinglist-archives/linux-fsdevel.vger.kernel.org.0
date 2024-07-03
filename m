Return-Path: <linux-fsdevel+bounces-23013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4792580E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC49828F575
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93F173348;
	Wed,  3 Jul 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oqc8qIDP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DA152500
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001494; cv=none; b=lp6S3pfTJy5Bu6MMqsuDG7wwgbNe85A+FQOS86BqIjVyL+dQEsZhbbERaZ5ktZf8cV/hvRZJjAvRuchaiAJ4KVb4W9izN53Oc1cR6GeXUXcEL8bjQRycG+T3VqBa8KJlLNdpBOJwWLugiMUp/P5P8wsMzxT+KrdewkUKD3vmP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001494; c=relaxed/simple;
	bh=b+ONelJc/4dyl3e3w6S6cUzGM85bd0ABoCS5DPvYzIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsH6zaVhu2KLZg0SlzceUg/HfVmy45FLgxrxXswAeNk5Egjpdi7Lvrfeb/tNuozj6S58DBodAZ7OcUsNVnEWOva8y04qH5Aq6T1PxwkojJunGzMSU84K96USnQENZjhv6SBrHql76y7c1LUBIn1TfMkeKghgezUDRRK/Qbo9vQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oqc8qIDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720001491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VIW4O9cjcARid8kd3x3WmxH/dYq1njX/nUJ6yIxU7Lw=;
	b=Oqc8qIDPRCyp9ejHzQ5vLi5NpNTfawgZJT5+Q2Ly/sHKCFlG5VhAwEE4kCEd5m/e6L44Gc
	oIV5NAH8CcZ01OY3wtCH1S4UsGcaXJ0GGufevYI11kZf7Nr7DUZWkx2bgBEHg5ywaJtxoh
	qB77fDRaUlwTs/sVJSxR06W+N20gKbw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jmxRF8cnM9645DAeNsk81A-1; Wed, 03 Jul 2024 06:11:30 -0400
X-MC-Unique: jmxRF8cnM9645DAeNsk81A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36792df120fso422657f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 03:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001488; x=1720606288;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VIW4O9cjcARid8kd3x3WmxH/dYq1njX/nUJ6yIxU7Lw=;
        b=CjIC+cfIWbDmZFC0IBo0/eAji9wSS86PnYE5TZluIS9yB3evFmkg6VMZvt5nBeu2f8
         +or+kU1o7wB3Apt8y5MwuemVKG2dQkeYvmQYpP9aCYZJK8Gs2kbRET/Yut87g+IWpxam
         Hn8kdWTeYzTlliWpX5b9y85iKiayxp8I8FlQpzHHbT3CdvxYaKdS/GZqlWlkO95F7I8E
         soG5/t2jMYnyHh3Kq94JEMHgGZTuqUOEyDsFc+Qo98V9P6F4MNQ1WZ9EJ2ui8aIB9tXj
         OiyK69QbtTXKkjy9rJ9vpyUImeH1NxD2l2Deh328cokTYb7/kl2HZfxesZZsLUlpKAlD
         QKrg==
X-Forwarded-Encrypted: i=1; AJvYcCU5oyan+UHCkAOBlg0FJgcOAwZD3MtRQ+XwaF8bjitxB1JEAg1W12njFUags9yCnlGzHDABgwkw/PfTA+2p/Uz/ggcM06DyoWczCVgyWg==
X-Gm-Message-State: AOJu0YyZ+79h/4KYnDDsuic8N6G4LKqPaJMTFh0UDpTvHm/r45lVIOOC
	/CLvPSdySFPj9uybuIOOXzSvW6FkL/8tH5A9sTAHwzOk1dbu/ND/CglNPfMi4e9sd+OqesPfFPh
	EMjTlyiYCebKVMqYHaXg5HE8UyucEj6GzAlAEeWkwQRf3kpJl3HUFpgYzrzq5VHw=
X-Received: by 2002:a05:6000:1052:b0:367:947d:ddce with SMTP id ffacd0b85a97d-367947dde8cmr692149f8f.68.1720001488339;
        Wed, 03 Jul 2024 03:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq8kV0b9MR8S15SlDw9DVYj4k79XzLEYDyI2d9sDxNAZ4qmp8L1kzIHrav+ZPmtwzXoxBAyg==
X-Received: by 2002:a05:6000:1052:b0:367:947d:ddce with SMTP id ffacd0b85a97d-367947dde8cmr692128f8f.68.1720001487885;
        Wed, 03 Jul 2024 03:11:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3400:5126:3051:d630:92ee? (p200300cbc709340051263051d63092ee.dip0.t-ipconnect.de. [2003:cb:c709:3400:5126:3051:d630:92ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm15514574f8f.28.2024.07.03.03.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:11:27 -0700 (PDT)
Message-ID: <79910a02-7767-4f70-9248-319aba79fb45@redhat.com>
Date: Wed, 3 Jul 2024 12:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: ran xiaokai <ranxiaokai627@163.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterx@redhat.com, ran.xiaokai@zte.com.cn,
 ryan.roberts@arm.com, svetly.todorov@memverge.com, vbabka@suse.cz,
 willy@infradead.org, ziy@nvidia.com
References: <1fddf73d-577f-4b4c-996a-818dd99eb489@redhat.com>
 <20240703092023.76749-1-ranxiaokai627@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240703092023.76749-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.24 11:20, ran xiaokai wrote:
>> On 26.06.24 04:49, ran xiaokai wrote:
>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>
>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>>> pages, which means of any order, but KPF_THP should only be set
>>> when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df
>>
>> "should only be set" -- who says that? :)
>>
>> The documentation only talks about "Contiguous pages which construct
>> transparent hugepages". Sure, when it was added there were only PMD ones.
>>
>>
>>> ("mm: thp: support allocation of anonymous multi-size THP"),
>>> multiple orders of folios can be allocated and mapped to userspace,
>>> so the folio_test_large() check is not sufficient here,
>>> replace it with folio_test_pmd_mappable() to fix this.
>>>
>>
>> A couple of points:
>>
>> 1) If I am not daydreaming, ever since we supported non-PMD THP in the
>>     pagecache (much longer than anon mTHP), we already indicate KPF_THP
>>     for them here. So this is not anon specific? Or am I getting the
>>     PG_lru check all wrong?
>>
>> 2) Anon THP are disabled as default. If some custom tool cannot deal
>>     with that "extension" we did with smaller THP, it shall be updated if
>>     it really has to special-case PMD-mapped THP, before enabled by the
>>     admin.
>>
>>
>> I think this interface does exactly what we want, as it is right now.
>> Unless there is *good* reason, we should keep it like that.
>>
>> So I suggest
>>
>> a) Extend the documentation to just state "THP of any size and any
>> mapping granularity" or sth like that.
>>
>> b) Maybe using folio_test_large_rmappable() instead of "(k & (1 <<
>>     PG_lru)) || is_anon", so even isolated-from-LRU THPs are indicated
>>     properly.
> 
> Hi, David,
> 
> The "is_anon" check was introduced to also include page vector cache
> pages, but now large folios are added to lru list directly, bypassed
> the pagevec cache. So the is_anon check seems unnecessary here.
> As now pagecache also supports large folios, the is_anon check seems
> unsufficient here.
> 
> Can i say that for userspace memory,
> folio_test_large_rmappable() == folio_test_large()?
> if that is true, except the "if ((k & (1 << PG_lru)) || is_anon)"
> check, we can also remove the folio_test_large() check,
> like this:
> 
> else if (folio_test_large_rmappable(folio)) {
>          u |= 1 << KPF_THP;
>      else if (is_huge_zero_folio(folio)) {
>          u |= 1 << KPF_ZERO_PAGE;
>          u |= 1 << KPF_THP;
>      }
> } else if (is_zero_pfn(page_to_pfn(page)))
> 
> This will also include the isolated folios.

You'll have to keep the folio_test_large() check, 
folio_test_large_rmappable() wants us to check that ahead of time.

Something like

...
else if (folio_test_large(folio) && folio_test_large_rmappable(folio)) {
	/* Note: we indicate any THPs here, not just PMD-sized ones */
	u |= 1 << KPF_THP;
} else if (is_huge_zero_folio(folio)) {
	u |= 1 << KPF_ZERO_PAGE;
	u |= 1 << KPF_THP
} else if (is_zero_pfn(page_to_pfn(page))) {
	u |= 1 << KPF_ZERO_PAGE;
}

Would likely work and keep the existing behavior (+ include isolated ones).

-- 
Cheers,

David / dhildenb


