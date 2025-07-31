Return-Path: <linux-fsdevel+bounces-56413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4ADB171EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DFD1C20278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDF2C08C5;
	Thu, 31 Jul 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgREQ4c0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED4238D49
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968030; cv=none; b=LPx8R3bFwqw08cY8ECSYjq62MdR+PlYiuXYfMBRrvgmXAQRSDyJDfq14XYo7ro5k78I3HgbRnEBU3FevOFW0JziyXzAMTrQfGifB7THweB4VpYUSCD4nwn0QsnObPN/PqOBLVgAuQMMa90ZunVsvvD0ITW3ui0Z85urvCiUXqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968030; c=relaxed/simple;
	bh=3KLuyMr0bSxLI5U8RI1yZL2Yv96hPijFT8J7biGE2dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swq24Jd3AllEt687k+VhPWwFJt+rROe3yWDJaTn03vqVcR/kD2LzCi+1mOwQ5ESsiBeuoAcl0YTZCxIeGgdRPh6TGb9eGmL0ZscMHPD41OJg5ZoNY7aTuyNZc4H11nosvsWHHIOys7c6Za+wUYYs9hg9aqhw/y1ChsXWi25VPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgREQ4c0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753968027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H8cVWOuIO40JfoYuCXD6TQrtJBGKCxwzWML3Rk1WtL4=;
	b=DgREQ4c0xYGTbts5i1jErOhsfflQx8iQK4CSYnFWNfGqp61ZOCgWH2i0b7klTP6xQ5lga7
	/peE+QYhS9UoMkRhqMh4RvZPPPIpxbdegaQ0mlN2qUgZXkHrpCj1cTIiae1lrY864/Ggj9
	DoznQeeqviwtoJz3YrytmFosV3MhyWc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-sTGbEkvMMj6sU10GyTNFVw-1; Thu, 31 Jul 2025 09:20:26 -0400
X-MC-Unique: sTGbEkvMMj6sU10GyTNFVw-1
X-Mimecast-MFC-AGG-ID: sTGbEkvMMj6sU10GyTNFVw_1753968025
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso6641535e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 06:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968025; x=1754572825;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8cVWOuIO40JfoYuCXD6TQrtJBGKCxwzWML3Rk1WtL4=;
        b=p3j/XOgaTEyd9TkEgNkr8MjicK+CfV9vMV4XKqQ1mg2H5NQfBOMEcXbQnnv4U1XY2g
         HGon2OeiN1CPZnFz1RlriH2ZjVtZ9UPGxB9P7ik1MaQkCITo4y7tctD91NN58RVockBh
         e9U1kR3TJiEJrViWwXcLarPMTq9fogH+l7JYBGiu8pRhxSCpxSvvvkGLKHZ6tgFGJb2L
         ObRQZyvQ3es8kpLAGDOcb0h8cdeKZdGErcQ/G3K6FCJAFpEr+T8Wf98SNYFWpYfIluTk
         +x3PJ0rDRDkFfq+3EEgnqTByAuPNFHylOGK1+H0bSLlrGoO1LWBM3ykyxjloIFZxiOcB
         zKsg==
X-Forwarded-Encrypted: i=1; AJvYcCXrmeZz7RL91cF80Z3VXYPosfwMKvv7ucAQJjMyYaKfN7Zw97ci8SoQrSbyuoKiF0s0oHZRv/CQQfIetu7p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yzUWeaP5GIR1DJwSqCk+7DMhsQUubhXpkfwZi5KSIgIrQnhM
	LEzwsWqOB9sDk1+ww+h7sBe3Wdsg4HAepYiHVwANwuVRpdkHOd1RXMDKEO23v3xEUOv8+ZEFLUT
	IRgV+OYUpSL1RClJMkt7pklh39ZPvWg00myjlNTpn42QQJ1/Ft92LrCG2nH+B/ika4O0=
X-Gm-Gg: ASbGncuKHppZWzGurDHu0blwG7UCgFpew+YbCZ1RdNTbZRNsGjs0PMw2HTGcAaOp71l
	s1N/juZwfqylCchO0dLqS5JZwj9ws+Npm1wOZ2Pa93Ufh6qa7jzDWKJFSdca9LcxwU159EjvK7E
	4WC2dfksqinr9dWMz7iP/7xZxY6bp/cm9sRWOpeRoMhmXowfvEHpNwZW43jJdQLwa9/XgwPqwZg
	FQgm9nBgWiVNEXHzGieTRDu5ujjiwNedNx8p1XqWXWgM2XHONCKrOH2y/q0MQmPeCg8N3IojZva
	oC3yo+d5YojEvnetKcajbCeZGTrMS6t4EF/9GJ4wrcUsxMjpTIdzxneBAAN0XrOPwveJx+ZE9v7
	B0UBXUwKyuhQFkZuupY+6yVDQfTESr+aCCIjaaDUuiMjUc29lT+PsX6RI+KxZLdulo4E=
X-Received: by 2002:a05:600c:35d4:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-45892a38f57mr77121205e9.0.1753968024908;
        Thu, 31 Jul 2025 06:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7izoet6gCRjloh7faX2I/dT1hRt2aBMnfvHniM+pSH974YB03S1kXDORrNyqMh7/oaxdrw==
X-Received: by 2002:a05:600c:35d4:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-45892a38f57mr77120805e9.0.1753968024404;
        Thu, 31 Jul 2025 06:20:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a22365c0sm23257955e9.3.2025.07.31.06.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 06:20:23 -0700 (PDT)
Message-ID: <e496bf28-ed56-4935-8ac4-994e297506ee@redhat.com>
Date: Thu, 31 Jul 2025 15:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Usama Arif <usamaarif642@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-2-usamaarif642@gmail.com>
 <dda2e42f-7c20-4530-93f9-d3a73bb1368b@lucifer.local>
 <c9896875-fb86-4b6c-8091-27c8152ba6d0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <c9896875-fb86-4b6c-8091-27c8152ba6d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 15:12, Usama Arif wrote:
> 
> 
> On 31/07/2025 13:40, Lorenzo Stoakes wrote:
>> On Thu, Jul 31, 2025 at 01:27:18PM +0100, Usama Arif wrote:
>> [snip]
>>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>> Cc: Nico Pache <npache@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Usama Arif <usamaarif642@gmail.com>
>>> Cc: SeongJae Park <sj@kernel.org>
>>> Cc: Jann Horn <jannh@google.com>
>>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> Cc: Yafang Shao <laoar.shao@gmail.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>
>> You don't need to include these Cc's, Andrew will add them for you.
>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>
>> Shouldn't this also be signed off by you? 2/5 and 3/5 has S-o-b for both
>> David and yourself?
>>
>> This is inconsistent at the very least.
>>
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> 
> The Ccs were added by David, and I didn't want to remove them.

They were still part of the first submission without cover letter, so 
you should drop them from here now that you are sending it as part of a 
series.

> 
>>>
>>> ---
>>>
>>
>> Nothing below the --- will be included in the patch, so we can drop the
>> below, it's just noise that people can find easily if needed.
>>
>>> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
>>> think there might be real use cases where we want to disable any THPs --
>>> in particular also around debugging THP-related problems, and
>>> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
>>> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
>>> helpful for debugging purposes. Of course, I thought of having a
>>> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
>>> I just don't like the semantics.
>>
>> [snip]
>>
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> This S-o-b is weird, it's in a comment essentially. Let's drop that too
>> please.

That just got added automatically while modifying the patch.

> 
> 
> Everything below --- was added by David I believe to provide further explanation that
> doesn't need to be included in the commit message, and I didn't want to remove it
> or his 2nd sign-off, as its discarded anyways. Its useful info that can just be
> ignored.


Best to drop under the "---" I think it was most important for the PoC 
to give more context.


-- 
Cheers,

David / dhildenb


