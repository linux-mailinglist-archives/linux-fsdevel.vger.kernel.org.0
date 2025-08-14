Return-Path: <linux-fsdevel+bounces-57876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DBB264D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3931CC42F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDEE2FC889;
	Thu, 14 Aug 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgIm5HH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1791FE474
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172843; cv=none; b=Nc39uG69TpJEPxsYxdD9SSFYLDuPvCrso97UJMcRZiN/jztoOG+UIwDZ+Qkd884xNmVDx+mEUH9ca8bIzHviv5XeE0bZYH7M4ydTWnz6a3F3rgZwF6B5lrA8TZVBWZJSwt1yAh0tgHICxtC3fuyM49VjdU2c4bDuYk3L8JU6us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172843; c=relaxed/simple;
	bh=x9U9R/VfbumBJ8bu/7CLD3jeqPLdVN92HBDbRWeuOcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+3SK3DyMcwIltTr5T5SHRrmDpnI4B6mkLrFMKB0aWbIhcgqvNdYkxpIHxjV7jY9hKzIiNCQkDogLSvjxff+Deha8ns9RW3CwQ1dRR4r+oMMypeZtOyPn+q/h31JvfNxLT0b1QApd56h4Ae+JL3SoTolzEuqnLtqQZHH9NkZPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgIm5HH8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755172840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jMOpUdH6nt0bz5vi3YcX2PybgsEQE6JlF+rSmSMMZuw=;
	b=XgIm5HH8jARN4fX2zVysCDJkiWptSezyPZWAggCPbL5PfUYLqeMD0kiOcQGnl88nU5q8q2
	mDSsBL8dsSEekFJViBe/q17tZPkxGDho8rOVJJ9TBSn/D7raF4KvLX85NT6fCGRoBetke5
	aAfD+7aHFiXXnXotS9wTBLB1aZG2ezg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-MSOkbOqtMmCp8NzX87nkPw-1; Thu, 14 Aug 2025 08:00:37 -0400
X-MC-Unique: MSOkbOqtMmCp8NzX87nkPw-1
X-Mimecast-MFC-AGG-ID: MSOkbOqtMmCp8NzX87nkPw_1755172830
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41c245fso580528f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172830; x=1755777630;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMOpUdH6nt0bz5vi3YcX2PybgsEQE6JlF+rSmSMMZuw=;
        b=BAupT64Ej/gH0BNkgQlzVGhrhQ2pB3QJSsJjl461mpHnNpq7hjCF9DJbFcymeWTrAT
         dkLf1uJEtcuq/eEgZFMCB8rGuuimKDlKsxzmppTBP0wftZ7hGxobBxKhZjN0JZ4nIEyV
         stA/sdPmoSHAHGqgNfG5yXKwoIy03an/iXyFaEBJsU1CH4Vnk2rR3gcMh5FLuC5v4CvI
         Q6IV0CsR46TAcj211et+pwpK40pRHezxyWgD30IiO/yxPYzS9vuIrv6oNszPv/hGuHRG
         6kkVwqs31fDd7f+r4ezFZKjyxESqdZrksmv2qoK3a2PWl7vigv/mFzVPr1Oue7P72W4R
         gp2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwq5tpRsA4TgorOCmbjDTnsR8DsIpZbGWMIJK7UybB3BH9A5NRYpxL6tWR49sa5uxOrdnpn1esL029UeWD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5F+Mfl1CCpiaUu3+NaljRZapzsKM83ZXY6jZGs/Z50SMIYKZ
	JfOzMgiNZ5Ep72n/Nl0etBgq7lkd8aVEbJMo1PfQeKgrVZIflYUvBO9q3CsvSWco5Cu9GG+TF2G
	uCvUuajLoa62eu/mRbvHP1TlFT03tvd27J3pxqiaW2Z6Dzd7y5Q0GRlzVycOw1a6Sk0U=
X-Gm-Gg: ASbGncs2HXlRxyM7SOabzvJ6ZDNEJyxRoip8VBjrYFAYupIgy9UAOt7rCuznNrOpNqh
	Ya4XdQbkMKsfBFEjxfd/SSNsrH5VVOYNJpJSedLD7VslaCvp0+eMqumDbLXKbvK6E2c/Rw2PN82
	EIraboQwK9nW/777v+QfkdFyBm3Gyt5MpnMTTAaVOjYlprjoQTP2uaYM9Yr0avXBoUgDT8VdKjB
	SCZAYLoJTWKD9cFO9D055ZLpZN3RdUQgt2MpCSjMIq8c8yoZUo2oORrjblzUELuJ0Xksu1A/7qa
	QiU1cOacYfMJ6xLqcwXCbPr3A9aDuMUql5AyFVNz84XI/5wVJa/dFCVSsWhHqW8odMAiziohnoN
	SnJgpxpJsnwN46slnNj1Q5pTOmERyz/DvgLwio1r6c1x+T896O4oETGVF5XGKDaEQlss=
X-Received: by 2002:a05:6000:290d:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3b9edf2d89fmr2303931f8f.34.1755172830309;
        Thu, 14 Aug 2025 05:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7Gbb/a7KdvZFKZbHjM30mGxCSwKqtT1kjDippjk/ajMehZu4vEs2MURGJhjqrCAMRSCGQg==
X-Received: by 2002:a05:6000:290d:b0:3b8:fb31:a42d with SMTP id ffacd0b85a97d-3b9edf2d89fmr2303881f8f.34.1755172829807;
        Thu, 14 Aug 2025 05:00:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3e00:9fca:7d89:a265:56f3? (p200300d82f443e009fca7d89a26556f3.dip0.t-ipconnect.de. [2003:d8:2f44:3e00:9fca:7d89:a265:56f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533e6sm51836169f8f.35.2025.08.14.05.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:00:28 -0700 (PDT)
Message-ID: <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
Date: Thu, 14 Aug 2025 14:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Mark Brown <broonie@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 13:45, Mark Brown wrote:
> On Thu, Aug 14, 2025 at 11:49:15AM +0100, Lorenzo Stoakes wrote:
>> On Thu, Aug 14, 2025 at 11:32:55AM +0200, David Hildenbrand wrote:
>>> On 13.08.25 20:52, Lorenzo Stoakes wrote:
> 
>>>> I can't see anything in the kernel to #ifdef it out so I suppose you mean
>>>> running these tests on an older kernel?
> 
> ...
> 
>>>> But this is an unsupported way of running self-tests, they are tied to the
>>>> kernel version in which they reside, and test that specific version.
> 
>>>> Unless I'm missing something here?
> 
>>> I remember we allow for a bit of flexibility when it is simple to handle.
> 
>>> Is that documented somewhere?
> 
>> Not sure if it's documented, but it'd make testing extremely egregious if
>> you had to consider all of the possible kernels and interactions and etc.
> 
>> I think it's 'if it happens to work then fine' but otherwise it is expected
>> that the tests match the kernel.
> 
>> It's also very neat that with a revision you get a set of (hopefully)
>> working tests for that revision :)
> 
> Some people do try to run the selftests with older kernels, they're
> trying to get better coverage for the stables.  For a lot of areas the
> skipping falls out natually since there's some optionality (so even with
> the same kernel version you might not have the feature in the running
> kernel) or it's a new API which has a discovery mechanism in the ABI
> anyway.  OTOH some areas have been actively hostile to the idea of
> running on older kernels so there are things that do break when you try.
> TBH so long as the tests don't crash the system or something people are
> probably just going to ignore any tests that have never passed.

Some people (hello :) ) run tests against distro kernels ... shame that 
prctl just knows one sort of "EINVAL" so we cannot distinguish :(

But yeah, maybe one has to be more careful of filtering these failures 
out then.

-- 
Cheers

David / dhildenb


